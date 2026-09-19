import SwiftUI

/// O Grimório: uma tela própria pra navegar a base inteira de magias de
/// Priest, sem estar presa ao fluxo de "memorizar num slot" — pra folhear
/// em busca de opções, tipo consultando o livro na mesa (ver TODO.md
/// item 6). Agrupada por círculo com títulos recolhíveis (mesmo padrão do
/// "old sessions" em `CampaignIndexView`), com busca e favoritos.
struct SpellbookView: View {
    /// `nil` quando o Grimório é aberto direto da tela inicial — sem
    /// personagem nenhum associado, é puro livro de consulta. Favoritar
    /// (2026-09-19) virou preferência global do jogador
    /// (`CharacterLibrary.favoriteSpellIDs`), não mais deste personagem —
    /// por isso a estrela continua aparecendo mesmo sem `character`
    /// nenhum; só serve pra destacar a magia atual quando existe uma.
    var character: Binding<PlayerCharacter>? = nil
    @EnvironmentObject private var spellbook: SpellDatabase
    @EnvironmentObject private var library: CharacterLibrary

    @State private var query: String = ""
    @State private var favoritesOnly = false
    /// Vazio = sem filtro (mostra todas). Múltipla escolha: uma magia
    /// aparece se bater com QUALQUER uma das esferas/cenários marcados
    /// (união, não interseção) — visão de "quero ver as magias destas
    /// esferas juntas", não "só a que serve pras duas ao mesmo tempo".
    /// Esfera e cenário são os dois eixos que fazem mais sentido pra um
    /// Priest: esfera é como a gente escolhe magia liberada pro
    /// personagem na mesa, cenário é útil quando a campanha só usa um ou
    /// dois cenários específicos e o resto vira ruído na lista.
    @State private var sphereFilter: Set<String> = []
    @State private var settingFilter: Set<String> = []
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
            filtersRow

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
                        favoritesEnabled: favoritesEnabled,
                        isFavorite: { library.isFavorite($0) },
                        onToggleExpand: { toggleExpand(group.level) },
                        onToggleFavorite: { library.toggleFavorite($0) },
                        onSelect: { detailSpell = $0 }
                    )
                }
            }
        }
        .sheet(item: $detailSpell) { spell in
            SpellDetailSheet(spell: spell, freeName: nil,
                             isFavorite: library.isFavorite(spell.id),
                             onToggleFavorite: { library.toggleFavorite(spell.id) })
        }
    }

    /// A estrela de favorito sempre existe — favoritar é global (ver
    /// comentário no topo do arquivo), não depende de ter personagem
    /// aberto. O nome ficou (em vez de sempre `true` direto nos usos)
    /// porque deixa a intenção clara nos outros lugares que checam isso.
    private var favoritesEnabled: Bool { true }

    private var header: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Priest Spellbook")
                    .font(Paper.hand(30))
                    .foregroundStyle(Paper.penInk)
                Text("\(filtered.count) of \(allDivineSpells.count) spells")
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.inkSoft)
            }
            Spacer()
            if favoritesEnabled {
                RoundIconButton(
                    systemImage: favoritesOnly ? "star.fill" : "star",
                    style: .paper,
                    action: { favoritesOnly.toggle() },
                    accessibilityLabel: "Favorites only"
                )
            }
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

    private var filtersRow: some View {
        HStack(spacing: 10) {
            filterMenu(title: "Sphere", selection: $sphereFilter, options: availableSpheres,
                      allLabel: "All Spheres")
            filterMenu(title: "Setting", selection: $settingFilter, options: availableSettings,
                      allLabel: "All Settings", icon: settingIcon)

            if !sphereFilter.isEmpty || !settingFilter.isEmpty {
                Button("clear filters") {
                    sphereFilter = []
                    settingFilter = []
                }
                .font(Paper.printedItalic(11))
                .foregroundStyle(Paper.inkSoft)
            }

            Spacer()
        }
    }

    /// Menu de múltipla escolha. `option` aqui é um valor de VERDADE vindo
    /// dos dados (ex.: a esfera "All", que existe de fato em 2e pra magia
    /// que serve qualquer especialista) — por isso o botão de "limpar
    /// filtro" tem o rótulo "All Spheres"/"All Settings" por extenso, pra
    /// não ficar um "All" duplicado e ambíguo do lado do "All" que é só
    /// mais uma opção da lista (foi exatamente essa confusão que gerou o
    /// bug reportado).
    ///
    /// `.menuActionDismissBehavior(.disabled)` em cada botão de opção
    /// mantém o menu aberto depois do toque, senão cada marcação fecharia
    /// o menu e obrigaria reabrir pra marcar a próxima — inviável pra
    /// escolha múltipla.
    private func filterMenu(title: String, selection: Binding<Set<String>>, options: [String],
                            allLabel: String, icon: ((String) -> String)? = nil) -> some View {
        Menu {
            Button {
                selection.wrappedValue.removeAll()
            } label: {
                Label(selection.wrappedValue.isEmpty ? "✓ \(allLabel)" : allLabel,
                      systemImage: "xmark.circle")
            }
            .menuActionDismissBehavior(.disabled)

            Divider()

            ForEach(options, id: \.self) { option in
                Button {
                    if selection.wrappedValue.contains(option) {
                        selection.wrappedValue.remove(option)
                    } else {
                        selection.wrappedValue.insert(option)
                    }
                } label: {
                    let checked = selection.wrappedValue.contains(option)
                    if let icon {
                        Label(checked ? "✓ \(option)" : option, systemImage: icon(option))
                    } else {
                        Text(checked ? "✓ \(option)" : option)
                    }
                }
                .menuActionDismissBehavior(.disabled)
            }
        } label: {
            Text("\(title): \(filterSummary(selection.wrappedValue, allLabel: allLabel)) ▾")
                .font(Paper.printed(12))
                .tracking(0.5)
                .foregroundStyle(Paper.ink)
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
        }
    }

    private func filterSummary(_ selection: Set<String>, allLabel: String) -> String {
        switch selection.count {
        case 0: return allLabel
        case 1: return selection.first!
        default: return "\(selection.count) selected"
        }
    }

    /// Não são os logos oficiais de cada cenário (arte licenciada da
    /// TSR/WotC) — só símbolos do sistema (SF Symbols) escolhidos pra
    /// lembrar a identidade visual de cada um sem reproduzir marca
    /// registrada de ninguém.
    private func settingIcon(_ setting: String) -> String {
        switch setting {
        case "Forgotten Realms": return "globe.americas.fill"
        case "Dark Sun": return "sun.max.fill"
        case "Greyhawk": return "shield.fill"
        case "Ravenloft": return "moon.stars.fill"
        case "Planescape": return "infinity"
        case "Generic": return "book.closed.fill"
        default: return "questionmark.circle"
        }
    }

    // MARK: - Dados derivados

    /// Toda a base de Priest (não mostra as poucas magias de mago que
    /// existem na base de exemplo — o Grimório é só de sacerdote).
    private var allDivineSpells: [Spell] {
        spellbook.spells.filter { $0.caster == .divine }
    }

    /// Lista de esferas/cenários vem sempre da base INTEIRA de Priest, não
    /// da lista já filtrada — senão o menu de opções ficaria mudando de
    /// tamanho (ou sumindo opção) conforme outro filtro fosse aplicado,
    /// o que confunde mais do que ajuda.
    private var availableSpheres: [String] {
        Set(allDivineSpells.flatMap(\.spheres)).sorted()
    }

    private var availableSettings: [String] {
        Set(allDivineSpells.compactMap(\.setting)).sorted()
    }

    private var filtered: [Spell] {
        var list = allDivineSpells

        if favoritesOnly {
            list = list.filter { library.isFavorite($0.id) }
        }

        if !sphereFilter.isEmpty {
            list = list.filter { !Set($0.spheres).isDisjoint(with: sphereFilter) }
        }

        if !settingFilter.isEmpty {
            list = list.filter { spell in
                guard let setting = spell.setting else { return false }
                return settingFilter.contains(setting)
            }
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
            || !sphereFilter.isEmpty
            || !settingFilter.isEmpty
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
    let favoritesEnabled: Bool
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
                                    favoritesEnabled: favoritesEnabled,
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
    let favoritesEnabled: Bool
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    let onSelect: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            if favoritesEnabled {
                Button(action: onToggleFavorite) {
                    Text(isFavorite ? "★" : "☆")
                        .font(Paper.printed(16))
                        .foregroundStyle(isFavorite ? Paper.redInk : Paper.inkSoft)
                        .frame(width: 20)
                }
                .buttonStyle(.plain)
            }

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
