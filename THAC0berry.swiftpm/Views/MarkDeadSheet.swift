import SwiftUI

/// A folha que captura o momento da morte de um personagem — data +
/// como aconteceu — antes de mandar ele pro memorial (Fallen Heroes).
///
/// Antes disso não existia jornada nenhuma: o único botão "Mark as dead"
/// do app (`CampaignDetailView.castMenu`) matava o personagem na hora,
/// gravando `Date()` e uma nota em branco sem perguntar nada — por isso
/// `deathLine` em `CharacterListView` cai pro texto genérico "Fallen"
/// quando não há nada de fato registrado. Esta folha é o mesmo padrão
/// visual de `NewSessionSheet` (`CampaignIndexView.swift`): papel,
/// `DatePicker` compacto pro único campo que é mesmo uma data pra
/// escolher, `HandwritingField` pro resto.
struct MarkDeadSheet: View {
    let character: PlayerCharacter
    let onConfirm: (Date, String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var date = Date()
    @State private var note = ""

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Mark \(character.displayTitle) as dead")
                        .font(Paper.hand(24))
                        .foregroundStyle(Paper.penInk)
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                VStack(alignment: .leading, spacing: 4) {
                    FieldLabel(text: "Date")
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .tint(Paper.ink)
                }

                VStack(alignment: .leading, spacing: 0) {
                    FieldLabel(text: "How did it happen? (optional)")
                    HandwritingField(text: $note, placeholder: "e.g. Swallowed by a purple worm",
                                     allowsSoftwareKeyboard: false, onCommit: {})
                        .frame(height: 54)
                        .overlay(alignment: .bottom) { DottedRule() }
                }

                Button(role: .destructive) {
                    onConfirm(date, note)
                    dismiss()
                } label: {
                    Text("mark as dead")
                        .font(Paper.printed(13))
                        .tracking(1)
                        .foregroundStyle(Color.red.opacity(0.85))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 7)
                        .overlay(Rectangle().stroke(Color.red.opacity(0.55), lineWidth: 1.2))
                }
                .buttonStyle(.plain)
            }
            .padding(24)
            .frame(width: 380)
        }
    }
}
