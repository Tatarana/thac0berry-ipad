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
    /// Quando falso, o teclado de software não aparece — só a caneta escreve.
    var allowsSoftwareKeyboard: Bool = false
    var onCommit: () -> Void = {}

    func makeUIView(context: Context) -> UITextField {
        let field = UITextField()
        field.delegate = context.coordinator
        field.placeholder = placeholder
        field.font = UIFont(name: "Bradley Hand", size: 25)
            ?? UIFont(name: "Noteworthy-Bold", size: 24)
            ?? .systemFont(ofSize: 24)
        field.textColor = UIColor(red: 0.118, green: 0.208, blue: 0.341, alpha: 1) // caneta azul
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
        let wantsKeyboard = allowsSoftwareKeyboard
        let hasKeyboard = uiView.inputView == nil
        if wantsKeyboard != hasKeyboard {
            uiView.inputView = wantsKeyboard ? nil : UIView()
            if uiView.isFirstResponder {
                uiView.reloadInputViews()
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

/// Linha pautada, pra parecer papel de ficha em vez de formulário.
struct RuledLine: View {
    var body: some View {
        Rectangle()
            .fill(Color.secondary.opacity(0.35))
            .frame(height: 1)
    }
}
