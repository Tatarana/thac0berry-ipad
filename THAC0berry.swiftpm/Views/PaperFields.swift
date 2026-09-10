import SwiftUI

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
                             allowsSoftwareKeyboard: true, onCommit: onDone)
                .frame(width: 84, height: 44)
                .overlay(alignment: .bottom) { DottedRule() }
            PadButton(symbol: "+") { onStep(1) }
            Button(action: onDone) {
                Text("pronto")
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

    @State private var isEditing = false
    @State private var draft = ""

    var body: some View {
        Button {
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
                if !open { value = draft }
            }
        )) {
            HStack(spacing: 12) {
                HandwritingField(text: $draft, placeholder: placeholder,
                                 allowsSoftwareKeyboard: true) {
                    value = draft
                    isEditing = false
                }
                .frame(width: 340, height: 64)
                .overlay(alignment: .bottom) { DottedRule() }

                Button {
                    value = draft
                    isEditing = false
                } label: {
                    Text("pronto")
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
