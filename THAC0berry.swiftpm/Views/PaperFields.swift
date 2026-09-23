import SwiftUI

/// Ponte entre um campo Optional do modelo (ver comentário de Codable-
/// safety em `Character.swift` — todo campo novo tem que ser Optional pra
/// não quebrar a leitura de fichas salvas antigas) e o `Binding` não-
/// Optional que os campos de papel (`EditableText`, `EditableNumber`)
/// esperam.
extension Binding {
    /// Para um `String?`/`Int?` etc.: lê o valor guardado ou o padrão, e
    /// grava direto de volta no Optional (nunca precisa materializar nada).
    func orDefault<T>(_ fallback: T) -> Binding<T> where Value == T? {
        Binding<T>(
            get: { self.wrappedValue ?? fallback },
            set: { self.wrappedValue = $0 }
        )
    }

    /// Para um struct Optional inteiro (ex.: `combat: CombatDetails?`): lê
    /// o valor guardado ou um struct novo em folha, e materializa o
    /// Optional na primeira escrita — assim os outros campos do struct que
    /// forem preenchidos depois não se perdem.
    func orInit<T>(_ makeDefault: @autoclosure @escaping () -> T) -> Binding<T> where Value == T? {
        Binding<T>(
            get: { self.wrappedValue ?? makeDefault() },
            set: { self.wrappedValue = $0 }
        )
    }
}

/// Campos editáveis que continuam parecendo escrita na ficha: o valor fica
/// à mostra em letra de mão e, ao ser tocado, abre um balão pequeno onde a
/// caneta escreve por cima — nada de teclado nem de célula de formulário.

struct EditableNumber: View {
    @Binding var value: Int
    var size: CGFloat = 26
    var color: Color = Paper.penInk
    var lower: Int = -99
    var upper: Int = 9999
    var tilt: Double = -0.5

    @State private var isEditing = false
    @State private var draft = ""

    var body: some View {
        Button {
            // Larga o foco de qualquer outro campo de escrita ANTES de
            // abrir o balão — sem isto, um campo que ainda esteja em foco
            // em outro canto da ficha (ex.: Character Name) continua
            // anunciando uma área de captura de Scribble maior que ele
            // mesmo, e um traço feito aqui dentro do balão do Nível acaba
            // sendo entregue a esse campo antigo em vez do novo. Mesma
            // causa/mesma solução do `resignPencilFocus()` que já existia
            // pros contadores de traço (ver comentário em
            // `HandwritingField.swift`).
            resignPencilFocus()
            draft = "\(value)"
            isEditing = true
        } label: {
            HandValue(text: "\(value)", size: size, color: color, tilt: tilt)
        }
        .buttonStyle(.plain)
        // popover não tem onDismiss: o commit vai no set do binding, senão
        // fechar tocando fora descarta o que a caneta escreveu.
        .popover(isPresented: Binding(
            get: { isEditing },
            set: { open in
                isEditing = open
                if !open { commit() }
            }
        )) {
            NumberPad(draft: $draft,
                      onStep: { step in adjust(by: step) },
                      onDone: { commit(); isEditing = false })
                .presentationCompactAdaptation(.popover)
        }
    }

    private func adjust(by step: Int) {
        let current: Int = Int(draft) ?? value
        let next: Int = min(max(current + step, lower), upper)
        draft = "\(next)"
        value = next
    }

    private func commit() {
        if let parsed = Int(draft) {
            value = min(max(parsed, lower), upper)
        }
    }
}

private struct NumberPad: View {
    @Binding var draft: String
    let onStep: (Int) -> Void
    let onDone: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            PadButton(symbol: "−") { onStep(-1) }
            HandwritingField(text: $draft, placeholder: "",
                             allowsSoftwareKeyboard: false, onCommit: onDone)
                .frame(width: 84, height: 44)
                .overlay(alignment: .bottom) { DottedRule() }
            PadButton(symbol: "+") { onStep(1) }
            Button(action: onDone) {
                Text("done")
                    .font(Paper.printed(13))
                    .foregroundStyle(Paper.ink)
            }
        }
        .padding(14)
        .background(Paper.sheet)
    }
}

private struct PadButton: View {
    let symbol: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(symbol)
                .font(Paper.printed(22))
                .foregroundStyle(Paper.ink)
                .frame(width: 38, height: 38)
                .overlay(Circle().stroke(Paper.ink, lineWidth: 1.4))
        }
        .buttonStyle(.plain)
    }
}

struct EditableText: View {
    @Binding var value: String
    var placeholder: String = "—"
    var size: CGFloat = 26
    var tilt: Double = -0.4
    var underline: Bool = true
    /// Disparado quando o balão fecha e o valor é gravado — usado por
    /// campos que precisam reagir ao valor final (ex.: Wounds descontando
    /// dos Hit Points), não só guardá-lo.
    var onCommit: (String) -> Void = { _ in }

    @State private var isEditing = false
    @State private var draft = ""

    var body: some View {
        Button {
            // Mesmo motivo do `EditableNumber` acima — larga o foco de
            // qualquer campo antigo antes de abrir o balão de edição.
            resignPencilFocus()
            draft = value
            isEditing = true
        } label: {
            VStack(alignment: .leading, spacing: 1) {
                HandValue(text: value.isEmpty ? placeholder : value,
                          size: size,
                          color: value.isEmpty ? Paper.inkSoft.opacity(0.6) : Paper.penInk,
                          tilt: tilt)
                    .lineLimit(1)
                if underline {
                    Rectangle().fill(Paper.hairline).frame(height: 1)
                }
            }
        }
        .buttonStyle(.plain)
        .popover(isPresented: Binding(
            get: { isEditing },
            set: { open in
                isEditing = open
                if !open { value = draft; onCommit(draft) }
            }
        )) {
            HStack(spacing: 12) {
                HandwritingField(text: $draft, placeholder: placeholder,
                                 allowsSoftwareKeyboard: false) {
                    value = draft
                    isEditing = false
                    onCommit(draft)
                }
                .frame(width: 340, height: 64)
                .overlay(alignment: .bottom) { DottedRule() }

                Button {
                    value = draft
                    isEditing = false
                    onCommit(draft)
                } label: {
                    Text("done")
                        .font(Paper.printed(13))
                        .foregroundStyle(Paper.ink)
                }
            }
            .padding(14)
            .background(Paper.sheet)
            .presentationCompactAdaptation(.popover)
        }
    }
}

/// Campo de texto livre que escreve DIRETO na página — sem abrir balão,
/// como já fazíamos na Ficha de Magias (`HandwritingField` puro). Pra
/// campos de nome/descrição onde o usuário quer digitar ou usar a Apple
/// Pencil ali mesmo, em vez de tocar pra abrir um popover primeiro.
struct InlineTextField: View {
    @Binding var value: String
    var placeholder: String = "—"
    var fontSize: CGFloat = 16
    var underline: Bool = false
    var textColor: Color = Paper.penInk

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HandwritingField(text: $value, placeholder: placeholder,
                             allowsSoftwareKeyboard: false, fontSize: fontSize,
                             textColor: textColor)
                .frame(height: fontSize + 16)
            if underline {
                Rectangle().fill(Paper.hairline).frame(height: 1)
            }
        }
    }
}
