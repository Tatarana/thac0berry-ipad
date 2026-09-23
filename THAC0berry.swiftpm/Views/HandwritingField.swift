import SwiftUI
import UIKit

/// Linha de escrita à mão.
///
/// Em vez de rodar OCR sobre a tinta (impreciso com nomes próprios de magia),
/// o campo usa o Scribble nativo do iPadOS: você escreve com a Apple Pencil
/// direto sobre a linha e o sistema converte para texto com o mesmo motor de
/// reconhecimento da Apple. O teclado de software fica desligado por padrão,
/// então a caneta é o caminho principal e nada pula na tela no meio do jogo.
struct HandwritingField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    /// Quando falso (o padrão), o teclado de software não aparece — só a
    /// caneta escreve. Quando verdadeiro, `inputView` fica `nil` e o
    /// teclado de verdade passa a estar disponível — mas junto dele o
    /// iPadOS também passa a oferecer, assim que a caneta encosta, um
    /// painel Scribble flutuante (desfazer, idioma, ditado, confirmar)
    /// plantado no canto da tela, empurrando a folha/popover pra cima pra
    /// manter o campo visível acima dele (TODO.md item 31 — usuário
    /// relatou "a janela pulando"). Não existe API pública pra manter o
    /// teclado disponível e suprimir só esse painel: a única forma de
    /// nunca mostrá-lo é `inputView` não-nulo mesmo vazio, ou seja,
    /// `false`. Por isso este campo nasce `false` em toda parte — a caneta
    /// já escreve perfeitamente sozinha — e só vira `true` quando o
    /// PRÓPRIO usuário pede explicitamente, tocando o botão de teclado do
    /// `SearchField` (abaixo) — nunca como estado inicial de uma tela.
    var allowsSoftwareKeyboard: Bool = false
    /// Liga pra pedir foco (e, com `allowsSoftwareKeyboard` também
    /// verdadeiro, abrir o teclado de verdade) já na próxima atualização,
    /// sem esperar o usuário tocar no campo — usado pelo botão de teclado
    /// do `SearchField` (abaixo), que abre o teclado no mesmo toque em vez
    /// de só "destravar" e deixar o usuário ainda ter que tocar o campo
    /// duas vezes. Quem liga desliga sozinho de volta depois de um
    /// instante (ver `updateUIView`) — não precisa (nem deve) ficar `true`
    /// depois do primeiro foco, senão qualquer outro re-render do campo
    /// roubaria o foco de novo à força.
    var requestsFocus: Binding<Bool> = .constant(false)
    var onCommit: () -> Void = {}
    /// Tamanho da fonte de "letra de mão" — células pequenas (nome de arma,
    /// proficiência) precisam de algo menor que o nome do personagem.
    var fontSize: CGFloat = 25
    /// Cor da tinta — caneta azul por padrão (as três folhas de papel), mas
    /// as telas de navegação em couro escuro (Fase 1 da proposta de Design)
    /// passam um tom claro aqui, já que o campo é a única entrada de texto
    /// que sobrou fora do pergaminho (o nome da campanha).
    var textColor: Color = Paper.penInk

    func makeUIView(context: Context) -> UITextField {
        let field = UITextField()
        field.delegate = context.coordinator
        field.placeholder = placeholder
        field.font = UIFont(name: "Bradley Hand", size: fontSize)
            ?? UIFont(name: "Noteworthy-Bold", size: fontSize - 1)
            ?? .systemFont(ofSize: fontSize - 1)
        field.textColor = UIColor(textColor)
        field.backgroundColor = .clear
        field.borderStyle = .none
        field.autocorrectionType = .no
        field.spellCheckingType = .no
        field.autocapitalizationType = .words
        field.clearButtonMode = .whileEditing
        field.returnKeyType = .done
        // Espaço vertical generoso: escrever à mão precisa de mais folga
        // do que digitar.
        field.setContentHuggingPriority(.defaultLow, for: .horizontal)
        if !allowsSoftwareKeyboard {
            // Um inputView vazio deixa o Scribble funcionando e impede o
            // teclado de subir.
            field.inputView = UIView()
        }
        field.addTarget(context.coordinator,
                        action: #selector(Coordinator.editingChanged(_:)),
                        for: .editingChanged)
        return field
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        uiView.placeholder = placeholder
        uiView.textColor = UIColor(textColor)
        let wantsKeyboard = allowsSoftwareKeyboard
        let hasKeyboard = uiView.inputView == nil
        if wantsKeyboard != hasKeyboard {
            uiView.inputView = wantsKeyboard ? nil : UIView()
            if uiView.isFirstResponder {
                uiView.reloadInputViews()
            }
        }
        if requestsFocus.wrappedValue, !uiView.isFirstResponder {
            // Assíncrono: `updateUIView` já está no meio de um ciclo de
            // atualização da SwiftUI, então mexer no `Binding` de volta
            // (pra desligar o pedido depois de atendido) precisa esperar
            // esse ciclo terminar — senão é "modifying state during view
            // update", o mesmo cuidado que o resto do app já toma com
            // `DispatchQueue.main.async` nesses casos.
            DispatchQueue.main.async {
                uiView.becomeFirstResponder()
                requestsFocus.wrappedValue = false
            }
        }
        context.coordinator.parent = self
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        var parent: HandwritingField

        init(_ parent: HandwritingField) {
            self.parent = parent
        }

        @objc func editingChanged(_ field: UITextField) {
            parent.text = field.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            parent.onCommit()
            return true
        }
    }
}

/// Campo de busca — usado por todo Compendium/seletor ("campo de texto +
/// lista de itens pra escolher", TODO.md item 31) — que nasce só-caneta
/// (sem o teclado de verdade, então sem o painel flutuante de Scribble que
/// empurrava a tela) e só liga o teclado quando o PRÓPRIO usuário pede,
/// tocando o ícone de teclado. Repõe a opção de digitar (útil pra soletrar
/// algo que a caneta reconheceu errado, ou pra quem prefere teclado físico)
/// sem trazer de volta o "pula na tela" pro caso comum, que continua sendo
/// só escrever com a caneta.
///
/// Ficou como um componente único (em vez de repetir os 14 lugares que
/// tinham exatamente este mesmo `VStack` antes) — trocar aqui uma vez só
/// resolve pra todo Compendium/seletor de uma vez, e evita um novo campo
/// nascer com `allowsSoftwareKeyboard: true` fixo por engano de novo.
struct SearchField: View {
    @Binding var text: String
    var placeholder: String
    var onCommit: () -> Void = {}
    var fontSize: CGFloat = 25

    /// Começa desligado em TODA tela — mesmo alguém tendo ligado antes em
    /// OUTRO Compendium, cada campo tem seu próprio estado (nunca é global
    /// nem persiste entre telas), porque o padrão seguro é sempre
    /// só-caneta; ligar o teclado é sempre um gesto explícito, feito de
    /// novo cada vez que faz falta.
    @State private var typingEnabled = false
    /// Liga junto com `typingEnabled` (nunca sozinho) só no toque que
    /// LIGA o teclado — pedir foco ao DESLIGAR não faria sentido, e o
    /// próprio `HandwritingField` desliga isto de volta sozinho assim que
    /// atende o pedido.
    @State private var focusRequested = false

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(alignment: .firstTextBaseline) {
                FieldLabel(text: "Search")
                Spacer()
                Button {
                    typingEnabled.toggle()
                    // Liga o teclado JÁ no mesmo toque, em vez de só
                    // destravar a possibilidade e obrigar o usuário a
                    // tocar o campo uma segunda vez pra então ver o
                    // teclado aparecer.
                    if typingEnabled { focusRequested = true }
                } label: {
                    Image(systemName: typingEnabled ? "keyboard.fill" : "keyboard")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(typingEnabled ? Paper.penInk : Paper.inkSoft)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(typingEnabled ? "Turn off software keyboard" : "Turn on software keyboard")
            }
            HandwritingField(text: $text, placeholder: placeholder,
                             allowsSoftwareKeyboard: typingEnabled,
                             requestsFocus: $focusRequested,
                             onCommit: onCommit, fontSize: fontSize)
                .frame(height: 44)
            DottedRule()
        }
    }
}

/// Tira o foco de qualquer campo de escrita da folha.
///
/// Um campo de texto em foco anuncia ao iPadOS uma área de captura de
/// Scribble muito maior que ele mesmo — foi o que fazia um risco no
/// contador de conjurações, do outro lado da linha, virar texto dentro da
/// linha de escrever. Basta um traço passar perto uma vez para o campo
/// ganhar foco, e a partir daí ele engole todos os outros. Por isso
/// encostar num contador larga o foco antes de qualquer coisa.
func resignPencilFocus() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
}

/// Avisa o iPadOS "não é escrita, aqui não" pra uma área inteira que não
/// tem NENHUM campo de escrita seu (ex.: a linha "Class / Kit" + "Level"
/// do cabeçalho, que só tem Menu/botão/balão) mas fica perto o bastante
/// de um `HandwritingField` de verdade (Character Name, na linha de
/// cima) pra a caneta, às vezes, tentar escrever ali por engano.
///
/// Diferente do `resignPencilFocus()` (que larga o foco de um campo já
/// focado), isto ataca a outra metade do problema, documentada em
/// `StrikeInteraction` (`SpellSheetView.swift`): o Scribble mira o campo
/// de escrita mais próximo INDEPENDENTE de quem está em foco — então só
/// tirar o foco não bastava aqui. É só a `UIScribbleInteraction`
/// recusando começar, sem gesto nenhum: `isUserInteractionEnabled`
/// continua o padrão (`true`, a interaction precisa disso pra ser
/// consultada) mas a view não tem NENHUM `UIGestureRecognizer` próprio,
/// então nunca ganha um toque no hit-test contra o Menu/botão de verdade
/// por cima dela — só fica ali, num `.background()`, respondendo "não"
/// quando o sistema pergunta se pode escrever naquele pedaço da tela.
struct ScribbleGuard: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.addInteraction(UIScribbleInteraction(delegate: context.coordinator))
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator() }

    final class Coordinator: NSObject, UIScribbleInteractionDelegate {
        func scribbleInteraction(_ interaction: UIScribbleInteraction,
                                 shouldBeginAt location: CGPoint) -> Bool {
            false
        }
    }
}

/// A entrada de caneta dos contadores de traço.
///
/// Duas coisas acontecem aqui, e as duas existem por causa do Scribble:
/// uma `UIScribbleInteraction` que recusa começar nesta área — é como a
/// Apple documenta áreas de desenho, "aqui a caneta desenha, não escreve"
/// — e o `resignPencilFocus()` no primeiro toque, porque a interaction
/// sozinha não protege contra um campo que já esteja em foco.
///
/// Como a interaction precisa de uma UIView de verdade para ser
/// encontrada pelo sistema, o traço também é reconhecido aqui, em UIKit,
/// em vez de por um gesto do SwiftUI: um arrasto soma um traço, um toque
/// parado apaga o último.
struct TallyInput: UIViewRepresentable {
    /// Comprimento do traço em curso, para desenhar o risco enquanto a
    /// caneta desce. Zero quando não há traço em andamento.
    var onStrokeChange: (CGFloat) -> Void = { _ in }
    var onAdd: () -> Void
    var onRemove: () -> Void

    /// Altura máxima do risco desenhado durante o arrasto.
    var markHeight: CGFloat = 20

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear

        view.addInteraction(UIScribbleInteraction(delegate: context.coordinator))

        let stroke = UIPanGestureRecognizer(target: context.coordinator,
                                            action: #selector(Coordinator.handleStroke(_:)))
        stroke.delegate = context.coordinator
        view.addGestureRecognizer(stroke)
        context.coordinator.stroke = stroke

        let erase = UITapGestureRecognizer(target: context.coordinator,
                                           action: #selector(Coordinator.handleErase))
        erase.delegate = context.coordinator
        view.addGestureRecognizer(erase)

        // Duração zero: dispara no instante em que a caneta encosta, antes
        // de saber se vai ser traço ou toque. É o momento mais cedo
        // possível para largar o foco do campo de escrita — depois disso o
        // Scribble já teria capturado o traço.
        let touchDown = UILongPressGestureRecognizer(target: context.coordinator,
                                                     action: #selector(Coordinator.handleTouchDown(_:)))
        touchDown.minimumPressDuration = 0
        touchDown.delegate = context.coordinator
        view.addGestureRecognizer(touchDown)
        context.coordinator.touchDown = touchDown

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.parent = self
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIGestureRecognizerDelegate, UIScribbleInteractionDelegate {
        var parent: TallyInput
        weak var stroke: UIPanGestureRecognizer?
        weak var touchDown: UILongPressGestureRecognizer?

        init(_ parent: TallyInput) {
            self.parent = parent
        }

        /// Aqui a caneta desenha, não escreve.
        func scribbleInteraction(_ interaction: UIScribbleInteraction,
                                 shouldBeginAt location: CGPoint) -> Bool {
            false
        }

        func gestureRecognizer(_ gesture: UIGestureRecognizer,
                               shouldRecognizeSimultaneouslyWith other: UIGestureRecognizer) -> Bool {
            // O toque inicial só larga o foco do campo de escrita: é um
            // observador passivo, convive com todo mundo, inclusive com a
            // rolagem da folha.
            if gesture === touchDown || other === touchDown { return true }

            // O traço e o toque de apagar convivem entre si, por estarem na
            // mesma área. Com a rolagem, não — ver abaixo.
            return other.view === gesture.view
        }

        /// Riscar não é rolar a folha.
        ///
        /// Sem isto, um traço no contador desenha e arrasta a página ao
        /// mesmo tempo, porque o contador vive dentro de um ScrollView e os
        /// dois gestos são arrastos verticais. Quem começa um arrasto
        /// dentro do contador está riscando, então a rolagem espera: ela só
        /// assume se este gesto falhar — o que acontece quando o toque
        /// termina sem arrasto nenhum.
        func gestureRecognizer(_ gesture: UIGestureRecognizer,
                               shouldBeRequiredToFailBy other: UIGestureRecognizer) -> Bool {
            guard gesture === stroke, other is UIPanGestureRecognizer else { return false }
            return other.view !== gesture.view
        }

        /// A caneta encostou no contador: seja lá o que ela vá fazer, o
        /// campo de escrita não pode continuar em foco enquanto isso.
        @objc func handleTouchDown(_ gesture: UILongPressGestureRecognizer) {
            guard gesture.state == .began else { return }
            resignPencilFocus()
        }

        /// Um arrasto majoritariamente vertical, como o risco na parede da
        /// cela, soma um uso.
        ///
        /// Os limiares aqui são curtos de propósito. O UIPanGestureRecognizer
        /// já engole uns 10pt de movimento antes de sequer começar, e o que
        /// se mede abaixo é o que vem *depois* disso — os dois somados são o
        /// tamanho real do risco que a mão precisa fazer. Pedir mais uns
        /// poucos pontos é o suficiente para separar um risco de um toque
        /// que escorregou, sem obrigar a puxar um traço mais alto que a
        /// própria linha.
        @objc func handleStroke(_ gesture: UIPanGestureRecognizer) {
            let travel = gesture.translation(in: gesture.view)
            let down: CGFloat = abs(travel.y)
            let sideways: CGFloat = abs(travel.x)

            switch gesture.state {
            case .changed:
                guard down > 2, down > sideways else { return }
                parent.onStrokeChange(min(down, parent.markHeight))
            case .ended:
                parent.onStrokeChange(0)
                if down >= 3, down > sideways { parent.onAdd() }
            case .cancelled, .failed:
                parent.onStrokeChange(0)
            default:
                break
            }
        }

        /// Um toque parado, sem arrasto, apaga o último traço.
        @objc func handleErase() {
            parent.onRemove()
        }
    }
}

/// Escrita livre de mais de uma linha — a página em branco do caderno de
/// anotações. Mesma linguagem visual do `HandwritingField` (Bradley Hand,
/// tinta azul), mas sobre um `UITextView` em vez de `UITextField`, pra
/// caber parágrafo. O Scribble funciona sozinho num UITextView, sem
/// nenhuma configuração extra.
struct NotebookTextArea: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    var fontSize: CGFloat = 18

    private var inkColor: UIColor { UIColor(red: 0.118, green: 0.208, blue: 0.341, alpha: 1) }
    private var placeholderColor: UIColor { UIColor(red: 0.420, green: 0.361, blue: 0.275, alpha: 0.55) }

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
        view.font = UIFont(name: "Bradley Hand", size: fontSize)
            ?? UIFont(name: "Noteworthy-Bold", size: fontSize - 1)
            ?? .systemFont(ofSize: fontSize - 1)
        view.backgroundColor = .clear
        view.autocorrectionType = .no
        view.spellCheckingType = .no
        view.textContainerInset = UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 4)

        // UITextView não tem placeholder nativo — a própria caixa mostra o
        // texto guia em cinza até o toque, e o coordinator troca pelo
        // conteúdo real no primeiro foco.
        if text.isEmpty {
            view.text = placeholder
            view.textColor = placeholderColor
            context.coordinator.showingPlaceholder = true
        } else {
            view.text = text
            view.textColor = inkColor
            context.coordinator.showingPlaceholder = false
        }
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        context.coordinator.parent = self
        guard !context.coordinator.showingPlaceholder, uiView.text != text else { return }
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    final class Coordinator: NSObject, UITextViewDelegate {
        var parent: NotebookTextArea
        var showingPlaceholder = false

        init(_ parent: NotebookTextArea) {
            self.parent = parent
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            guard showingPlaceholder else { return }
            textView.text = ""
            textView.textColor = parent.inkColor
            showingPlaceholder = false
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            guard textView.text.isEmpty else { return }
            textView.text = parent.placeholder
            textView.textColor = parent.placeholderColor
            showingPlaceholder = true
        }

        func textViewDidChange(_ textView: UITextView) {
            guard !showingPlaceholder else { return }
            parent.text = textView.text
        }
    }
}

/// Linha pautada, pra parecer papel de ficha em vez de formulário.
struct RuledLine: View {
    var body: some View {
        Rectangle()
            .fill(Color.secondary.opacity(0.35))
            .frame(height: 1)
    }
}
