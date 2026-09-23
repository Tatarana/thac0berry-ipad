import SwiftUI

/// Campo "Race" do CABEÇALHO da ficha (`RecordHeaderForm`,
/// `CharacterSheetView.swift`) — mesmo padrão do `AlignmentField` logo ao
/// lado dele. **Este é o único lugar onde Race é editável** (TODO.md item
/// 37, 2026-09-22): a tabela da aba "Character Description" (página 4)
/// mostra Race/Alignment como cópia só-leitura (`DescCellStatic`), pra não
/// ter dois jeitos diferentes de editar o mesmo dado — mesmo tratamento
/// que "Class" já tinha ali. Antes disso, o seletor de Raça (TODO.md item
/// 35) tinha sido ligado só na tabela da página 4 por engano — o campo
/// daqui, que é o primeiro que aparece e o que o usuário realmente estava
/// tocando, continuou com o `EditableText` livre de sempre até o item 37.
struct RaceField: View {
    @Binding var character: PlayerCharacter
    var size: CGFloat = 17
    @State private var isPickerPresented = false

    var body: some View {
        Button {
            isPickerPresented = true
        } label: {
            HandValue(text: character.race.isEmpty ? "—" : character.race, size: size)
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $isPickerPresented) {
            RacePickerSheet(character: $character)
        }
    }
}

/// Lista das 6 raças do PHB, com busca — mesmo esqueleto do
/// `AlignmentPickerSheet`. Escolher uma raça aplica direto os ajustes de
/// atributo e a resistência mágica (ver `RaceOption.apply(to:)`) — mas se
/// o atributo do personagem estiver fora do mínimo/máximo da raça, ou a
/// classe atual não bater com o limite de nível dela (Table 7), mostra a
/// tabela de referência com o aviso ANTES de aplicar, em vez de travar a
/// escolha (decisão do usuário, TODO.md item 35: "só aviso, mostrando a
/// tabela").
struct RacePickerSheet: View {
    @Binding var character: PlayerCharacter
    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""
    /// Raça tocada que tem aviso pendente — enquanto não-nil, a tela troca
    /// a lista pelo painel de aviso (`RaceWarningPane`) em vez de abrir
    /// uma segunda `.sheet()` aninhada (mais simples de fechar as duas de
    /// uma vez só quando o jogador confirma "usar assim mesmo").
    @State private var pendingRace: RaceOption? = nil

    var body: some View {
        ZStack {
            PaperBackground()

            if let pendingRace {
                RaceWarningPane(
                    race: pendingRace,
                    character: character,
                    onConfirm: { apply(pendingRace) },
                    onCancel: { self.pendingRace = nil }
                )
                .padding(24)
            } else {
                VStack(alignment: .leading, spacing: 14) {
                    HStack(alignment: .top) {
                        Text("Choose Race")
                            .font(Paper.hand(28))
                            .foregroundStyle(Paper.penInk)
                        Spacer()
                        Button("close") { dismiss() }
                            .font(Paper.printed(16))
                            .foregroundStyle(Paper.inkSoft)
                    }

                    SearchField(text: $query, placeholder: "race name")

                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(filtered) { race in
                                RacePickerRow(
                                    race: race,
                                    isSelected: RaceOption.match(character.race) == race,
                                    onSelect: { select(race) }
                                )
                            }
                        }
                    }
                }
                .padding(24)
            }
        }
    }

    private var filtered: [RaceOption] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return RaceOption.allCases }
        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return RaceOption.allCases }
        return RaceOption.allCases.filter { Fuzzy.normalize($0.rawValue).contains(normalizedQuery) }
    }

    /// Toca numa raça: sem aviso nenhum, aplica na hora; com aviso,
    /// mostra o painel de referência primeiro (nunca trava a escolha).
    private func select(_ race: RaceOption) {
        let warnings = warnings(for: race)
        if warnings.isEmpty {
            apply(race)
        } else {
            pendingRace = race
        }
    }

    private func warnings(for race: RaceOption) -> [String] {
        var items = race.abilityWarnings(for: character.abilities)
        if let levelWarning = race.levelLimitWarning(for: character.characterClass, currentLevel: character.level) {
            items.append(levelWarning)
        }
        return items
    }

    private func apply(_ race: RaceOption) {
        race.apply(to: &character)
        pendingRace = nil
        dismiss()
    }
}

private struct RacePickerRow: View {
    let race: RaceOption
    let isSelected: Bool
    var onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(alignment: .top) {
                Text(isSelected ? "★" : "")
                    .frame(width: 18)
                VStack(alignment: .leading, spacing: 2) {
                    Text(race.rawValue)
                        .font(Paper.hand(18))
                        .foregroundStyle(Paper.penInk)
                    if let requirements = race.abilityRequirements {
                        Text(requirements.count == 6 ? "Ability score minimums apply" : "")
                            .font(Paper.printedItalic(11))
                            .foregroundStyle(Paper.inkSoft)
                    } else {
                        Text("No ability score restrictions")
                            .font(Paper.printedItalic(11))
                            .foregroundStyle(Paper.inkSoft)
                    }
                }
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

/// Painel de referência mostrado quando a raça escolhida tem algum aviso
/// (atributo fora do mínimo/máximo da Table 7, ou classe/nível atual
/// acima do limite da Table 7 de nível) — nunca impede a escolha, só
/// mostra a régua oficial antes do jogador confirmar.
private struct RaceWarningPane: View {
    let race: RaceOption
    let character: PlayerCharacter
    var onConfirm: () -> Void
    var onCancel: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("\(race.rawValue) — heads up")
                .font(Paper.hand(24))
                .foregroundStyle(Paper.penInk)

            Text("This doesn't stop you from picking \(race.rawValue) — just flagging what the PHB says, for reference.")
                .font(Paper.printedItalic(12.5))
                .foregroundStyle(Paper.inkSoft)

            Rectangle().fill(Paper.ink).frame(height: 1.2)

            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(warnings, id: \.self) { warning in
                        HStack(alignment: .top, spacing: 6) {
                            Text("•").font(Paper.printed(13))
                            Text(warning)
                                .font(Paper.printed(13))
                                .foregroundStyle(Paper.penInk)
                        }
                    }

                    if let footnote = race.abilityRequirementFootnote {
                        Text(footnote)
                            .font(Paper.printedItalic(11))
                            .foregroundStyle(Paper.inkSoft)
                            .padding(.top, 4)
                    }
                }
            }

            Spacer(minLength: 0)

            HStack(spacing: 12) {
                Button(action: onCancel) {
                    Text("Cancel")
                        .font(Paper.printed(14))
                        .foregroundStyle(Paper.ink)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Paper.ink, lineWidth: 1.2))
                }
                .buttonStyle(.plain)

                Button(action: onConfirm) {
                    Text("Use \(race.rawValue) anyway")
                        .font(Paper.printed(14))
                        .foregroundStyle(Paper.sheet)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Paper.ink)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var warnings: [String] {
        var items = race.abilityWarnings(for: character.abilities)
        if let levelWarning = race.levelLimitWarning(for: character.characterClass, currentLevel: character.level) {
            items.append(levelWarning)
        }
        return items
    }
}
