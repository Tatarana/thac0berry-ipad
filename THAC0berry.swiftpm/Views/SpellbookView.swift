import SwiftUI

/// O Grimório: uma tela própria pra navegar a base inteira de magias de
/// Priest, sem estar presa ao fluxo de "memorizar num slot" — pra folhear
/// em busca de opções, tipo consultando o livro na mesa (ver TODO.md
/// item 6). Agrupada por círculo com títulos recolhíveis (mesmo padrão do
/// "old sessions" em `CampaignIndexView`), com busca e favoritos.
struct SpellbookView: View {
    @Binding var character: PlayerCharacter
    @EnvironmentObject private var spellbook: SpellDatabase

    @State private var query: String = ""
    @State private var favoritesOnly = false
    /// Recolhido por padrão — com quase 1.800 magias, montar as ~300
    /// linhas de um círculo inteiro de uma vez já é pesado, montar as
    /// ~1.800 de todos os círculos ao mesmo tempo travava o app por
    /// vários segundos ao abrir a tela e ao tocar em qualquer magia.
    /// `Set` de círculos ABERTOS (não fechados) — assim um círculo novo
    /// que apareça (por causa de um filtro, por exemplo) já nasce fechado.
    @State private var expandedLevels: Set<Int> = []
    @State private var detailSpell: Spell? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            searchField

            if groupedLevels.isEmpty {
                Text("No spells match — try a different search.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            }

            // LazyVStack: com um círculo aberto (até ~300 magias) só as
            // linhas visíveis na tela chegam a existir de verdade, em vez
            // de montar tudo de uma vez como um VStack normal faria.
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(groupedLevels, id: \.level) { group in
                    LevelSection(
                        label: levelLabel(group.level),
                        spells: group.spells,
                        isExpanded: isExpanded(group.level),
                        isFavorite: character.isFavorite,
                        onToggleExpand: { toggleExpand(group.level) },
                        onToggleFavorite: { character.toggleFavorite($0) },
                        onSelect: { detailSpell = $0 }
                    )
                }
            }
        }
        .sheet(item: $detailSpell) { spell in
            SpellDetailSheet(spell: spell, freeName: nil,
                             isFavorite: character.isFavorite(spell.id),
                             onToggleFavorite: { character.toggleFavorite(spell.id) })
        }
    }

    private var header: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Priest Spellbook")
                    .font(Paper.hand(30))
                    .foregroundStyle(Paper.penInk)
                Text("\(filtered.count) of \(spellbook.spells.filter { $0.caster == .divine }.count) spells")
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.inkSoft)
            }
            Spacer()
            Button { favoritesOnly.toggle() } label: {
                Text(favoritesOnly ? "★ favorites only" : "☆ favorites only")
                    .font(Paper.printed(12))
                    .tracking(1)
                    .foregroundStyle(Paper.ink)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
            }
            .buttonStyle(.plain)
        }
    }

    private var searchField: some View {
        VStack(alignment: .leading, spacing: 2) {
            FieldLabel(text: "Search")
            HandwritingField(text: $query, placeholder: "spell name",
                             allowsSoftwareKeyboard: true, onCommit: {})
                .frame(height: 44)
            DottedRule()
        }
    }

    // MARK: - Dados derivados

    /// Toda a base de Priest (não mostra as poucas magias de mago que
    /// existem na base de exemplo — o Grimório é só de sacerdote).
    private var filtered: [Spell] {
        var list = spellbook.spells.filter { $0.caster == .divine }

        if favoritesOnly {
            list = list.filter { character.isFavorite($0.id) }
        }

        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return list }

        // `SpellDatabase.matches` foi pensada pra escrita à mão errando
        // letras ("mag mis" → "Magic Missile"), com um limiar bem
        // permissivo (0.2) pra não recusar um palpite razoável. Numa caixa
        // de busca digitada isso vira ruído: "cure" trazia coisa sem
        // nenhuma relação de verdade (ex.: "Candle") porque a distância de
        // edição entre as duas palavras curtas passa longe do que faria
        // sentido pra busca de texto — e como a lista final é ordenada
        // alfabeticamente por círculo, esses resultados fracos apareciam
        // MISTURADOS com os bons, às vezes até antes deles.
        //
        // Pra busca digitada o que se espera é substring: contém "cure" em
        // algum lugar do nome. Só cai pro fuzzy (com limiar bem mais
        // estrito) se a substring não achar nada — cobre um erro de
        // digitação pequeno sem abrir a porta pra qualquer coisa parecida.
        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return list }

        let substringMatches = list.filter { $0.normalizedName.contains(normalizedQuery) }
        if !substringMatches.isEmpty { return substringMatches }

        let fuzzyIDs = Set(spellbook.matches(for: trimmed, limit: 50, minimumScore: 0.55).map(\.spell.id))
        return list.filter { fuzzyIDs.contains($0.id) }
    }

    private struct LevelGroup { let level: Int; let spells: [Spell] }

    private var groupedLevels: [LevelGroup] {
        let byLevel = Dictionary(grouping: filtered, by: { $0.level })
        return byLevel.keys.sorted().map { level in
            LevelGroup(level: level, spells: byLevel[level, default: []].sorted { $0.name < $1.name })
        }
    }

    private func levelLabel(_ level: Int) -> String {
        switch level {
        case 0: return "Orisons"
        case 8: return "Quest Spells"
        case 9...: return "High-Level / Epic (tier \(level))"
        default: return "Level \(level)"
        }
    }

    /// Enquanto tem busca ativa ou o filtro de favoritas ligado, os
    /// círculos com resultado abrem sozinhos — senão os resultados
    /// ficariam escondidos atrás de um título fechado. Sem filtro nenhum,
    /// só abre o que o jogador tocar.
    private func isExpanded(_ level: Int) -> Bool {
        if expandedLevels.contains(level) { return true }
        let hasActiveFilter = favoritesOnly
            || !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return hasActiveFilter
    }

    private func toggleExpand(_ level: Int) {
        if expandedLevels.contains(level) {
            expandedLevels.remove(level)
        } else {
            expandedLevels.insert(level)
        }
    }
}

private struct LevelSection: View {
    let label: String
    let spells: [Spell]
    let isExpanded: Bool
    let isFavorite: (String) -> Bool
    let onToggleExpand: () -> Void
    let onToggleFavorite: (String) -> Void
    let onSelect: (Spell) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: onToggleExpand) {
                Text("\(isExpanded ? "▾" : "▸") \(label) (\(spells.count))")
                    .font(Paper.printed(17))
                    .tracking(1.2)
                    .foregroundStyle(Paper.ink)
            }
            .buttonStyle(.plain)

            if isExpanded {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(spells) { spell in
                        SpellbookRow(spell: spell,
                                    isFavorite: isFavorite(spell.id),
                                    onToggleFavorite: { onToggleFavorite(spell.id) },
                                    onSelect: { onSelect(spell) })
                    }
                }
            }
        }
    }
}

private struct SpellbookRow: View {
    let spell: Spell
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    let onSelect: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Button(action: onToggleFavorite) {
                Text(isFavorite ? "★" : "☆")
                    .font(Paper.printed(16))
                    .foregroundStyle(isFavorite ? Paper.redInk : Paper.inkSoft)
                    .frame(width: 20)
            }
            .buttonStyle(.plain)

            Button(action: onSelect) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(spell.name)
                        .font(Paper.hand(19))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    if !spell.spheres.isEmpty {
                        Text(spell.spheres.joined(separator: ", "))
                            .font(Paper.printedItalic(10.5))
                            .foregroundStyle(Paper.inkSoft)
                            .lineLimit(1)
                    }
                    Spacer(minLength: 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 3)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}
