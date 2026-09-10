import SwiftUI

/// A capa da pasta: as fichas guardadas, cada uma como uma folha dobrada.
struct CharacterListView: View {
    @EnvironmentObject private var library: CharacterLibrary
    @EnvironmentObject private var spellbook: SpellDatabase

    var body: some View {
        NavigationStack {
            ZStack {
                PaperBackground()

                ScrollView {
                    VStack(spacing: 16) {
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading, spacing: 0) {
                                FieldLabel(text: "Advanced Dungeons & Dragons · 2ª edição")
                                Text("THAC0berry")
                                    .font(Paper.hand(44))
                                    .foregroundStyle(Paper.penInk)
                                    .rotationEffect(.degrees(-0.7))
                            }
                            Spacer()
                            Button {
                                library.addCharacter()
                            } label: {
                                Text("+ nova ficha")
                                    .font(Paper.printed(13))
                                    .tracking(1.2)
                                    .foregroundStyle(Paper.ink)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 6)
                                    .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.3))
                            }
                            .buttonStyle(.plain)
                        }

                        Rectangle().fill(Paper.ink).frame(height: 2)

                        ForEach($library.characters) { $person in
                            NavigationLink {
                                CharacterSheetView(character: $person)
                            } label: {
                                CharacterCard(character: person)
                            }
                            .buttonStyle(.plain)
                        }

                        if library.characters.isEmpty {
                            Text("Nenhuma ficha na pasta.")
                                .font(Paper.printedItalic(14))
                                .foregroundStyle(Paper.inkSoft)
                                .padding(.top, 30)
                        }

                        if let error = spellbook.loadError ?? library.lastError {
                            Text(error)
                                .font(Paper.printedItalic(12))
                                .foregroundStyle(Paper.redInk)
                        }
                    }
                    .padding(26)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

private struct CharacterCard: View {
    let character: PlayerCharacter

    /// Magias memorizadas e ainda não gastas na folha do dia em andamento.
    static func readySpells(in character: PlayerCharacter) -> Int {
        guard let sheet = character.sortedSpellSheets.first else { return 0 }
        var total = 0
        for slot in sheet.slotBoard.slots where !slot.isSpent && !slot.isEmpty {
            total += 1
        }
        return total
    }

    var body: some View {
        let subtitle: String = character.displaySubtitle
        let hp: String = "\(character.hitPointsCurrent)/\(character.hitPointsMax) PV"
        // O que interessa na capa é a folha do dia em andamento.
        let ready: Int = CharacterCard.readySpells(in: character)
        let sheetCount: Int = character.spellSheets.count

        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                Text(character.displayTitle)
                    .font(Paper.hand(34))
                    .foregroundStyle(Paper.penInk)
                    .rotationEffect(.degrees(-0.5))
                Text(subtitle)
                    .font(Paper.printed(13))
                    .foregroundStyle(Paper.inkSoft)
            }

            Spacer(minLength: 0)

            VStack(alignment: .trailing, spacing: 2) {
                Text(hp)
                    .font(Paper.printed(13))
                    .foregroundStyle(Paper.redInk)
                Text("\(ready) magias prontas · \(sheetCount) folhas")
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.inkSoft)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.18))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.4))
    }
}
