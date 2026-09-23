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
        SearchField(text: $query, placeholder: "spell name")
    }

    /// Cenário virou selinho de ícone (`SettingFilterRow` abaixo) — mesmo
    /// padrão pedido pelo usuário pro Compendium de Proficiências ("sem
    /// combos feios de formulário. Use ícones."), agora replicado aqui pra
    /// manter as duas telas consistentes. Esfera continua como `Menu`: não
    /// tem cenário fixo nem ícone natural por esfera, e a lista de opções é
    /// grande demais (dúzias) pra caber numa fileira de selinhos.
    private var filtersRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                filterMenu(title: "Sphere", selection: $sphereFilter, options: availableSpheres,
                          allLabel: "All Spheres")

                Spacer()

                if !sphereFilter.isEmpty || !settingFilter.isEmpty {
                    Button("clear filters") {
                        sphereFilter = []
                        settingFilter = []
                    }
                    .font(Paper.printedItalic(11))
                    .foregroundStyle(Paper.inkSoft)
                }
            }

            SettingFilterRow(selected: $settingFilter, options: availableSettings)
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
                            allLabel: String) -> some View {
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
                    Text(checked ? "✓ \(option)" : option)
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

    /// "Generic" (ver `CampaignSettingCatalog.isGeneric`) nunca some da
    /// lista, esteja o filtro de ícones ligado ou não — mesma regra
    /// adotada no filtro por ícone do Compendium de Proficiências
    /// (`ProficiencyCompendiumView.matchesSelectedSettings`); antes o
    /// `Menu` de "Setting" escondia até as magias genéricas se algum
    /// cenário específico estivesse marcado, o que não fazia muito
    /// sentido (conteúdo básico do PHB deveria continuar disponível não
    /// importa o cenário escolhido).
    private func matchesSettingFilter(_ spell: Spell) -> Bool {
        if CampaignSettingCatalog.isGeneric(spell.setting) { return true }
        guard let setting = spell.setting else { return false }
        return settingFilter.contains(setting)
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
            list = list.filter(matchesSettingFilter)
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

// MARK: - Filtro por cenário (ícones, não Picker/Menu)

/// Fileira de "selinhos" com ícone — mesmo padrão pedido pro Compendium de
/// Proficiências (`ProficiencyCompendiumView.SettingFilterRow`), replicado
/// aqui em vez de compartilhado: cada `struct` é `private` (visível só
/// dentro do próprio arquivo), e as duas telas têm listas de cenário
/// diferentes (`options` vem de `availableSettings`, calculado sobre a
/// base de magias de Priest — "Al-Qadim"/"Council of Wyrms"/"Spelljammer",
/// que só existem no corpus de proficiências, nunca apareceriam aqui de
/// qualquer forma). "All" (sem nenhum marcado) mostra tudo; tocar um ou
/// mais cenários restringe a lista a eles (mais o que é "Generic", que
/// nunca some — ver `matchesSettingFilter`). Toque-e-segure mostra o nome
/// completo do cenário (`actionTooltip`, mesmo tooltip do resto do app).
private struct SettingFilterRow: View {
    @Binding var selected: Set<String>
    let options: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            FieldLabel(text: "Setting")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 7) {
                    SettingFilterChip(
                        systemImage: "asterisk",
                        label: "All",
                        tooltip: "Show every setting",
                        isSelected: selected.isEmpty,
                        action: { selected.removeAll() }
                    )
                    ForEach(options, id: \.self) { setting in
                        SettingFilterChip(
                            systemImage: CampaignSettingCatalog.icon(for: setting),
                            imageName: CampaignSettingCatalog.logoImageName(for: setting),
                            label: CampaignSettingCatalog.shortLabel(for: setting),
                            tooltip: setting,
                            isSelected: selected.contains(setting),
                            action: { toggle(setting) }
                        )
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }

    private func toggle(_ setting: String) {
        if selected.contains(setting) {
            selected.remove(setting)
        } else {
            selected.insert(setting)
        }
    }
}

private struct SettingFilterChip: View {
    let systemImage: String
    /// Nome do PNG (sem extensão) do logo de verdade do cenário — `nil`
    /// cai pro `systemImage` de sempre. Ver `CampaignSettingCatalog.
    /// logoImageName(for:)` (2026-09-21, logos entregues pelo usuário).
    var imageName: String? = nil
    let label: String
    let tooltip: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                settingIcon
                Text(label)
                    .font(Paper.printed(10))
                    .tracking(0.3)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
            .foregroundStyle(isSelected ? Paper.sheet : Paper.ink)
            .frame(width: 56, height: 46)
            .background(isSelected ? Paper.ink : Color.white.opacity(0.15))
            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Paper.ink.opacity(0.5), lineWidth: 1))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
        .actionTooltip(tooltip)
        .accessibilityLabel(tooltip)
    }

    /// Mesmo fallback de `ProficiencyCompendiumView.SettingFilterChip` —
    /// cópia privada de propósito (mesmo padrão que o resto do filtro de
    /// Setting já segue neste arquivo), ver o comentário lá pro porquê do
    /// `.renderingMode(.template)`.
    @ViewBuilder
    private var settingIcon: some View {
        if let imageName, let art = Image.bundled(imageName) {
            art
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 17, height: 17)
        } else {
            Image(systemName: systemImage)
                .font(.system(size: 15, weight: .medium))
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
                // `SpellPaperRow` em modo `.compact` (TODO.md item 3) — era
                // um `SpellbookRow` próprio aqui, quase idêntico ao da
                // Folha de Magias (mesma estrela de favorito, mesmo botão
                // pra abrir o detalhe), só sem o resumo/horário de
                // conjuração. Virou o mesmo componente com um parâmetro de
                // densidade, em vez de duas implementações divergindo com
                // o tempo.
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(spells) { spell in
                        SpellPaperRow(spell: spell, style: .compact,
                                      isFavorite: favoritesEnabled ? isFavorite(spell.id) : nil,
                                      onToggleFavorite: favoritesEnabled ? { onToggleFavorite(spell.id) } : nil) {
                            onSelect(spell)
                        }
                    }
                }
            }
        }
    }
}
