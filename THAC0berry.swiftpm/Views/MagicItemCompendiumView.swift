import SwiftUI

/// Tela de consulta da base de itens mágicos — 5.669 itens, escopo full do
/// corpus (TODO.md item 30 — "Acho melhor já irmos no escopo full, já que
/// os dados estão bons"). Mesmo espírito de `KitCompendiumView`/
/// `ProficiencyCompendiumView`: folhear a base inteira, sem estar presa a
/// nenhum personagem — SÓ consulta, por enquanto sem seletor na ficha (ver
/// TODO.md item 29/30: nenhuma seção existente da ficha mapeia num campo
/// óbvio de item mágico, ao contrário de Weapon/Armor/Equipment).
///
/// Linhas em formato PROSA ("nome + tap to open"), não tabela — ao
/// contrário do Weapon/Armor/Equipment Compendium (TODO.md item 27, que
/// converteu aqueles três porque não têm descrição nenhuma). Itens mágicos
/// têm `description.fullText` de verdade, então o mesmo formato do
/// Kit/Proficiency Compendium se aplica aqui.
///
/// Agrupado por `classification.broadCategory` (7 grupos — Miscellaneous
/// mescla os arquivos A-M/N-Z de origem, ver `MagicItemDatabase`), com um
/// segundo filtro por FONTE em dois níveis: grupo de fonte primeiro
/// (Encyclopedia Magica / Dragon Magazine / Polyhedron Newszine / Trading
/// Cards / Basic D&D / Other Sourcebooks), depois — só quando um grupo está
/// selecionado — uma lista de livros específicos daquele grupo pra
/// restringir mais. Exatamente a granularidade que o usuário escolheu
/// ("Os dois: grupo primeiro, livro depois") entre as três opções
/// oferecidas.
struct MagicItemCompendiumView: View {
    @EnvironmentObject private var magicItemDatabase: MagicItemDatabase

    @State private var query: String = ""
    @State private var expandedGroups: Set<String> = []
    @State private var collapsedGroups: Set<String> = []
    @State private var detailItem: CompendiumMagicItem? = nil

    /// Grupo de fonte selecionado — só um por vez (diferente do filtro de
    /// cenário do Proficiency Compendium, que aceita vários simultâneos):
    /// aqui o segundo nível (livro) só faz sentido depois de escolher UM
    /// grupo, então múltipla seleção de grupo complicaria sem ganho real.
    @State private var selectedSourceGroup: MagicItemSourceGroup? = nil
    /// Livro específico dentro do grupo selecionado — `nil` = qualquer
    /// livro daquele grupo. Reseta sempre que o grupo muda.
    @State private var selectedBook: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            searchField
            SourceGroupFilterRow(selected: $selectedSourceGroup, onChange: { selectedBook = nil })

            if let selectedSourceGroup {
                BookFilterRow(
                    group: selectedSourceGroup,
                    allBooks: MagicItemSourceGroup.books(in: selectedSourceGroup, items: magicItemDatabase.items),
                    selected: $selectedBook
                )
            }

            if let error = magicItemDatabase.loadError {
                Text(error)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.redInk)
            } else if groupedItems.isEmpty {
                Text("No magic items match — try a different search or filter.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            }

            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(groupedItems, id: \.category) { section in
                    MagicItemGroupSection(
                        label: section.category,
                        items: section.items,
                        isExpanded: isExpanded(section.category),
                        onToggleExpand: { toggleExpand(section.category) },
                        onSelect: { detailItem = $0 }
                    )
                }
            }
        }
        .sheet(item: $detailItem) { item in
            MagicItemDetailSheet(item: item)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Magic Items")
                .font(Paper.hand(30))
                .foregroundStyle(Paper.penInk)
            Text("\(filtered.count) of \(magicItemDatabase.items.count) items")
                .font(Paper.printedItalic(12))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "item name")
    }

    // MARK: - Dados derivados

    private var sourceFiltered: [CompendiumMagicItem] {
        guard let selectedSourceGroup else { return magicItemDatabase.items }
        return magicItemDatabase.items.filter { item in
            guard MagicItemSourceGroup.groups(for: item).contains(selectedSourceGroup) else { return false }
            guard let selectedBook else { return true }
            return item.sources.contains { $0.book == selectedBook }
        }
    }

    private var filtered: [CompendiumMagicItem] {
        let base = sourceFiltered
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return base }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return base }

        return base.filter { Fuzzy.normalize($0.name).contains(normalizedQuery) }
    }

    private struct CategoryGroup { let category: String; let items: [CompendiumMagicItem] }

    private var groupedItems: [CategoryGroup] {
        let byCategory = Dictionary(grouping: filtered, by: { $0.classification.broadCategory })
        return MagicItemDatabase.categoryOrder.compactMap { category in
            guard let entries = byCategory[category], !entries.isEmpty else { return nil }
            return CategoryGroup(category: category, items: entries.sorted { $0.name < $1.name })
        }
    }

    private var autoExpand: Bool {
        !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || selectedSourceGroup != nil
    }

    private func isExpanded(_ category: String) -> Bool {
        autoExpand ? !collapsedGroups.contains(category) : expandedGroups.contains(category)
    }

    private func toggleExpand(_ category: String) {
        if autoExpand {
            if collapsedGroups.contains(category) {
                collapsedGroups.remove(category)
            } else {
                collapsedGroups.insert(category)
            }
        } else if expandedGroups.contains(category) {
            expandedGroups.remove(category)
        } else {
            expandedGroups.insert(category)
        }
    }
}

// MARK: - Filtro de fonte (grupo, depois livro)

/// Primeiro nível: selinhos de texto (sem ícone ilustrado — grupos de fonte
/// são uma categoria nova deste Compendium, sem arte própria) pro grupo de
/// fonte. Só um selecionado por vez — tocar num já selecionado desmarca
/// (volta pra "All").
private struct SourceGroupFilterRow: View {
    @Binding var selected: MagicItemSourceGroup?
    var onChange: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            FieldLabel(text: "Source")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 7) {
                    TextFilterChip(label: "All", isSelected: selected == nil, action: {
                        selected = nil
                        onChange()
                    })
                    ForEach(MagicItemSourceGroup.allCases) { group in
                        TextFilterChip(label: group.rawValue, isSelected: selected == group, action: {
                            selected = (selected == group) ? nil : group
                            onChange()
                        })
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

/// Segundo nível: só aparece com um grupo já escolhido — lista de livros
/// específicos DAQUELE grupo (ex. dentro de "Dragon Magazine", as 104
/// edições distintas que têm algum item). "All" aqui mostra o grupo
/// inteiro sem restringir a um livro.
private struct BookFilterRow: View {
    let group: MagicItemSourceGroup
    let allBooks: [String]
    @Binding var selected: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            FieldLabel(text: "Book (\(group.rawValue))")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 7) {
                    TextFilterChip(label: "All", isSelected: selected == nil, action: { selected = nil })
                    ForEach(allBooks, id: \.self) { book in
                        TextFilterChip(label: book, isSelected: selected == book, action: {
                            selected = (selected == book) ? nil : book
                        })
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

/// Selinho de texto genérico — mesmo desenho de `SettingFilterChip`
/// (Proficiency/Grimório) mas sem ícone, já que estes filtros não têm arte
/// própria. Largura livre (não os 56pt fixos do selinho de ícone) porque
/// título de livro varia muito de tamanho.
private struct TextFilterChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(Paper.printed(11))
                .tracking(0.3)
                .lineLimit(1)
                .foregroundStyle(isSelected ? Paper.sheet : Paper.ink)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background(isSelected ? Paper.ink : Color.white.opacity(0.15))
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Paper.ink.opacity(0.5), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Lista agrupada por categoria

private struct MagicItemGroupSection: View {
    let label: String
    let items: [CompendiumMagicItem]
    let isExpanded: Bool
    let onToggleExpand: () -> Void
    let onSelect: (CompendiumMagicItem) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: onToggleExpand) {
                Text("\(isExpanded ? "▾" : "▸") \(label) (\(items.count))")
                    .font(Paper.printed(17))
                    .tracking(1.2)
                    .foregroundStyle(Paper.ink)
            }
            .buttonStyle(.plain)

            if isExpanded {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(items) { item in
                        MagicItemCompendiumRow(item: item, onSelect: { onSelect(item) })
                    }
                }
            }
        }
    }
}

private struct MagicItemCompendiumRow: View {
    let item: CompendiumMagicItem
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(item.name)
                        .font(Paper.hand(19))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    Spacer(minLength: 4)
                    Text(item.sources.first?.book ?? "Unknown")
                        .font(Paper.printedItalic(10.5))
                        .foregroundStyle(Paper.inkSoft)
                        .lineLimit(1)
                }
                Text(item.description.briefSummary)
                    .font(Paper.printed(12))
                    .foregroundStyle(Paper.inkSoft)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

// MARK: - Descrição completa do item

struct MagicItemDetailSheet: View {
    let item: CompendiumMagicItem
    /// `nil` na consulta solta do Compêndio (`MagicItemCompendiumView`,
    /// sem personagem nenhum ligado) — só preenchido quando esta sheet
    /// abre a partir de uma linha "Magic Items" da ficha
    /// (`MagicItemQuantifiedRow`), pra dar a mesma saída "change" que
    /// `MundaneItemDetailSheet`/`ProficiencyDetailSheet` já têm (usuário
    /// relatou a falta, 2026-09-22).
    var onChangeItem: (() -> Void)? = nil
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.name)
                            .font(Paper.hand(28))
                            .foregroundStyle(Paper.penInk)
                        Text(item.classification.specificType)
                            .font(Paper.printedItalic(15))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Spacer()
                    if let onChangeItem {
                        Button("change", action: onChangeItem)
                            // Item 4 do pedido do usuário (2026-09-24):
                            // padronizado nos 16pt do "close" ao lado.
                            .font(Paper.printedItalic(16))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                Rectangle().fill(Paper.ink).frame(height: 1.4)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 14)],
                                  alignment: .leading, spacing: 10) {
                            MagicItemDetailField(label: "XP Value", value: xpText)
                            MagicItemDetailField(label: "Gold Value", value: goldText)
                            if !item.sources.isEmpty {
                                MagicItemDetailField(label: "Source", value: sourcesText)
                            }
                        }

                        if !item.campaignSettings.isEmpty {
                            VStack(alignment: .leading, spacing: 4) {
                                FieldLabel(text: "Campaign Settings")
                                HStack(spacing: 6) {
                                    ForEach(item.campaignSettings, id: \.self) { setting in
                                        Text(setting)
                                            .font(Paper.printed(10.5))
                                            .foregroundStyle(Paper.sheet)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Paper.ink)
                                            .clipShape(Capsule())
                                    }
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            FieldLabel(text: "Description")
                            Text(item.description.fullText)
                                .font(Paper.printed(14))
                                .foregroundStyle(Paper.ink)
                                .lineSpacing(4)
                        }

                        enchantmentSection
                        powerSection
                        containsSpellsSection
                        defenseBonusSection
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding(24)
        }
    }

    private var xpText: String {
        if let xp = item.economyAndXP.xpValue { return "\(xp) xp" }
        return item.economyAndXP.rawXP ?? "—"
    }

    private var goldText: String {
        if let gold = item.economyAndXP.goldValue { return "\(gold) gp" }
        return item.economyAndXP.rawValue ?? "—"
    }

    private var sourcesText: String {
        item.sources.compactMap { source -> String? in
            guard let book = source.book else { return nil }
            if let page = source.page { return "\(book) (p. \(page))" }
            return book
        }.joined(separator: "; ")
    }

    @ViewBuilder
    private var enchantmentSection: some View {
        if let enchantment = item.enchantment {
            VStack(alignment: .leading, spacing: 4) {
                FieldLabel(text: "Enchantment")
                HStack(spacing: 18) {
                    if let attack = enchantment.attackBonus {
                        Text("Attack +\(attack)").font(Paper.printed(13)).foregroundStyle(Paper.ink)
                    }
                    if let damage = enchantment.damageBonus {
                        Text("Damage +\(damage)").font(Paper.printed(13)).foregroundStyle(Paper.ink)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var powerSection: some View {
        if let power = item.power {
            VStack(alignment: .leading, spacing: 4) {
                FieldLabel(text: "Power")
                if let name = power.name {
                    Text(name).font(Paper.printed(13)).foregroundStyle(Paper.ink)
                }
                if power.chargeBased == true {
                    Text(power.maxCharges.map { "Charge-based, up to \($0) charges" } ?? "Charge-based")
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Paper.inkSoft)
                }
                if let spell = power.spell {
                    Text("Replicates: \(spell.name) (\(spell.spellClass))")
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Paper.inkSoft)
                }
            }
        }
    }

    @ViewBuilder
    private var containsSpellsSection: some View {
        if !item.containsSpells.isEmpty {
            VStack(alignment: .leading, spacing: 4) {
                FieldLabel(text: "Contains Spells")
                Text(item.containsSpells.map { "\($0.name) (\($0.spellClass))" }.joined(separator: ", "))
                    .font(Paper.printed(13))
                    .foregroundStyle(Paper.ink)
                    .lineSpacing(3)
            }
        }
    }

    @ViewBuilder
    private var defenseBonusSection: some View {
        if let bonus = item.defenseBonus {
            VStack(alignment: .leading, spacing: 4) {
                FieldLabel(text: "Defense")
                VStack(alignment: .leading, spacing: 2) {
                    if let ac = bonus.acBonus {
                        Text("AC +\(ac)").font(Paper.printed(13)).foregroundStyle(Paper.ink)
                    }
                    if let save = bonus.savingThrowBonus {
                        Text("Saving Throws +\(save)").font(Paper.printed(13)).foregroundStyle(Paper.ink)
                    }
                    if let resist = bonus.magicResistance {
                        Text("Magic Resistance +\(resist)%").font(Paper.printed(13)).foregroundStyle(Paper.ink)
                    }
                    if let hp = bonus.hitPointBonus {
                        Text("Hit Points +\(hp)").font(Paper.printed(13)).foregroundStyle(Paper.ink)
                    }
                    if let attack = bonus.attackBonus {
                        Text("Attack +\(attack)").font(Paper.printed(13)).foregroundStyle(Paper.ink)
                    }
                    if let abilities = bonus.abilityScoreBonus, !abilities.isEmpty {
                        Text(abilities.sorted { $0.key < $1.key }.map { "\($0.key) +\($0.value)" }.joined(separator: ", "))
                            .font(Paper.printed(13))
                            .foregroundStyle(Paper.ink)
                    }
                    if !bonus.resistances.isEmpty {
                        Text("Resists: \(bonus.resistances.joined(separator: ", "))")
                            .font(Paper.printed(13))
                            .foregroundStyle(Paper.ink)
                    }
                    if bonus.regenerates {
                        Text("Regenerates").font(Paper.printedItalic(12)).foregroundStyle(Paper.inkSoft)
                    }
                }
            }
        }
    }
}

// MARK: - Seletor pra ficha (Magic Items da página 2)

/// Mesmo padrão de `MundaneItemPickerSheet`: busca por nome na base
/// (`MagicItemDatabase`, 5.669 itens), "usar como digitado" pra item
/// caseiro/criado pelo jogador quando a busca não bate em nada, e "ⓘ" em
/// cada linha pra ver a descrição completa antes de escolher. Diferente do
/// Mundane (que liga a um `Page2EquipmentEntry`), aqui a linha escolhida é
/// um `QuantifiedItem` — guarda `name` + `matchedItemID`, mantendo
/// `quantity`/`usedCount` que já estavam na linha.
struct MagicItemPickerSheet: View {
    @Binding var entry: QuantifiedItem
    @EnvironmentObject private var magicItemDatabase: MagicItemDatabase
    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""
    @State private var detailItem: CompendiumMagicItem? = nil

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    Text("Choose a Magic Item")
                        .font(Paper.hand(28))
                        .foregroundStyle(Paper.penInk)
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                searchField

                if !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                   !filtered.contains(where: { Fuzzy.normalize($0.name) == Fuzzy.normalize(query) }) {
                    Button(action: useAsTyped) {
                        Text("Use \"\(query.trimmingCharacters(in: .whitespacesAndNewlines))\" as-is")
                            .font(Paper.printed(13).bold())
                            .foregroundStyle(Paper.sheet)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Paper.ink)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }

                if !entry.name.isEmpty {
                    Button {
                        entry.name = ""
                        entry.matchedItemID = nil
                        dismiss()
                    } label: {
                        Text("Clear current item (\(entry.name))")
                            .font(Paper.printedItalic(13))
                            .foregroundStyle(Paper.redInk)
                    }
                    .buttonStyle(.plain)
                }

                if let error = magicItemDatabase.loadError {
                    Text(error)
                        .font(Paper.printedItalic(12))
                        .foregroundStyle(Paper.redInk)
                } else if filtered.isEmpty {
                    Text("No items match — try a different search.")
                        .font(Paper.printedItalic(13))
                        .foregroundStyle(Paper.inkSoft)
                }

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filtered) { candidate in
                            MagicItemPickerRow(
                                item: candidate,
                                isSelected: entry.name == candidate.name,
                                onSelect: { choose(candidate) },
                                onInfo: { detailItem = candidate }
                            )
                        }
                    }
                }
            }
            .padding(24)
        }
        .sheet(item: $detailItem) { candidate in
            MagicItemDetailSheet(item: candidate)
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "item name")
    }

    private var filtered: [CompendiumMagicItem] {
        let all = magicItemDatabase.items
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return all }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return all }

        return all.filter { Fuzzy.normalize($0.name).contains(normalizedQuery) }
    }

    private func choose(_ candidate: CompendiumMagicItem) {
        entry.name = candidate.name
        entry.matchedItemID = candidate.id
        dismiss()
    }

    private func useAsTyped() {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        entry.name = trimmed
        entry.matchedItemID = nil
        dismiss()
    }
}

private struct MagicItemPickerRow: View {
    let item: CompendiumMagicItem
    let isSelected: Bool
    let onSelect: () -> Void
    let onInfo: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Button(action: onSelect) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(isSelected ? "★" : "")
                        .font(Paper.printed(14))
                        .foregroundStyle(Ember.crimson)
                        .frame(width: 14)
                    Text(item.name)
                        .font(Paper.hand(19))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    Spacer(minLength: 4)
                    Text(item.classification.specificType)
                        .font(Paper.printedItalic(11))
                        .foregroundStyle(Paper.inkSoft)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button(action: onInfo) {
                Text("ⓘ")
                    .font(Paper.printed(15))
                    .foregroundStyle(Paper.inkSoft)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

private struct MagicItemDetailField: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            FieldLabel(text: label)
            Text(value)
                .font(Paper.hand(18))
                .foregroundStyle(Paper.penInk)
        }
    }
}
