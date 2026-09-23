import SwiftUI

/// Tela de consulta do catálogo geral de itens mundanos (não-mágicos) do
/// PHB — mesmo espírito de `WeaponCompendiumView`/`ArmorCompendiumView`:
/// folhear a base inteira, sem estar presa a nenhum personagem. Agrupada
/// por `category` (a mesma divisão que já vem no corpus — Clothing/Food &
/// Lodging/Household Provisioning/Miscellaneous Equipment/Services/Tack &
/// Harness/Transport).
struct MundaneItemCompendiumView: View {
    @EnvironmentObject private var itemDatabase: MundaneItemDatabase

    @State private var query: String = ""
    @State private var expandedGroups: Set<String> = []
    @State private var detailItem: MundaneItem? = nil

    // Mesmo motivo/mesmo padrão de `WeaponCompendiumView`/
    // `ArmorCompendiumView` — formato de tabela em vez de "nome + um
    // resumo", pra ver custo/peso sem precisar abrir cada item. Não
    // `private` porque `MundaneItemCompendiumRow` usa os mesmos valores.
    static let nameWidth: CGFloat = 220
    static let colWidth: CGFloat = 80

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            searchField

            if let error = itemDatabase.loadError {
                Text(error)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.redInk)
            } else if groupedItems.isEmpty {
                Text("No items match — try a different search.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            } else {
                ScrollView(.horizontal, showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 10) {
                        tableHeader
                        ForEach(groupedItems, id: \.category) { group in
                            MundaneItemGroupSection(
                                label: group.category,
                                items: group.items,
                                isExpanded: isExpanded(group.category),
                                onToggleExpand: { toggleExpand(group.category) },
                                onSelect: { detailItem = $0 }
                            )
                        }
                    }
                }
            }
        }
        .sheet(item: $detailItem) { item in
            MundaneItemDetailSheet(item: item)
        }
    }

    private var tableHeader: some View {
        HStack(spacing: 0) {
            Text("Item").frame(width: Self.nameWidth, alignment: .leading)
            Text("Cost").frame(width: Self.colWidth)
            Text("Weight").frame(width: Self.colWidth)
        }
        .font(Paper.printed(10.5))
        .foregroundStyle(Paper.ink)
        .padding(.vertical, 5)
        .padding(.horizontal, 4)
        .overlay(alignment: .bottom) { Rectangle().fill(Paper.ink).frame(height: 1.2) }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Equipment")
                .font(Paper.hand(30))
                .foregroundStyle(Paper.penInk)
            Text("\(filtered.count) of \(itemDatabase.items.count) items")
                .font(Paper.printedItalic(12))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "item name")
    }

    // MARK: - Dados derivados

    private var filtered: [MundaneItem] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return itemDatabase.items }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return itemDatabase.items }

        return itemDatabase.items.filter {
            Fuzzy.normalize($0.name).contains(normalizedQuery)
        }
    }

    private struct CategoryGroup { let category: String; let items: [MundaneItem] }

    /// Ordem fixa em vez de alfabética — "Miscellaneous Equipment" primeiro
    /// por ser de longe a maior categoria (68 dos 183 itens), o resto em
    /// ordem alfabética.
    private static let categoryOrder = [
        "Miscellaneous Equipment", "Clothing", "Food & Lodging",
        "Household Provisioning", "Services", "Tack & Harness", "Transport",
    ]

    private var groupedItems: [CategoryGroup] {
        let byCategory = Dictionary(grouping: filtered, by: { $0.category })
        return Self.categoryOrder.compactMap { category in
            guard let items = byCategory[category], !items.isEmpty else { return nil }
            return CategoryGroup(category: category, items: items.sorted { $0.name < $1.name })
        }
    }

    private func isExpanded(_ category: String) -> Bool {
        if expandedGroups.contains(category) { return true }
        return !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func toggleExpand(_ category: String) {
        if expandedGroups.contains(category) {
            expandedGroups.remove(category)
        } else {
            expandedGroups.insert(category)
        }
    }
}

private struct MundaneItemGroupSection: View {
    let label: String
    let items: [MundaneItem]
    let isExpanded: Bool
    let onToggleExpand: () -> Void
    let onSelect: (MundaneItem) -> Void

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
                        MundaneItemCompendiumRow(item: item, onSelect: { onSelect(item) })
                    }
                }
            }
        }
    }
}

/// Linha de tabela — custo/peso visíveis de cara, mesmo motivo de
/// `WeaponCompendiumRow`/`ArmorCompendiumRow`.
private struct MundaneItemCompendiumRow: View {
    let item: MundaneItem
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 0) {
                Text(item.name)
                    .font(Paper.hand(16))
                    .foregroundStyle(Paper.penInk)
                    .lineLimit(1)
                    .frame(width: MundaneItemCompendiumView.nameWidth, alignment: .leading)
                Text(item.cost ?? "—")
                    .frame(width: MundaneItemCompendiumView.colWidth)
                Text(item.weight ?? "—")
                    .frame(width: MundaneItemCompendiumView.colWidth)
            }
            .font(Paper.printed(13))
            .foregroundStyle(Paper.ink)
            .padding(.vertical, 6)
            .padding(.horizontal, 4)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .overlay(alignment: .bottom) { DottedRule() }
    }
}

// MARK: - Descrição completa

/// Janela de detalhe, aberta a partir do Compendium (só consulta) ou do
/// seletor de item na ficha (`MundaneItemPickerSheet`).
struct MundaneItemDetailSheet: View {
    let item: MundaneItem
    var onChoose: (() -> Void)? = nil
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
                        Text(item.category)
                            .font(Paper.printedItalic(15))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Spacer()
                    if let onChoose {
                        Button("choose") {
                            onChoose()
                            dismiss()
                        }
                        .font(Paper.printed(13))
                        .foregroundStyle(Paper.inkSoft)
                    }
                    if let onChangeItem {
                        Button("change", action: onChangeItem)
                            .font(Paper.printedItalic(13))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                Rectangle().fill(Paper.ink).frame(height: 1.4)

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 14)],
                          alignment: .leading, spacing: 10) {
                    if let cost = item.cost {
                        MundaneItemDetailField(label: "Cost", value: cost)
                    }
                    if let weight = item.weight {
                        MundaneItemDetailField(label: "Weight", value: weight)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(24)
        }
    }
}

private struct MundaneItemDetailField: View {
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

// MARK: - Seletor de item (usado na tabela de Equipment da página 2)

/// Sheet aberta a partir de cada linha da tabela de Equipment
/// (`Page2EquipmentRow`, `CharacterSheetView.swift`) — escolher aqui
/// preenche o nome e sugere o peso; "Location" (onde o jogador guarda o
/// item) continua sempre manual, é escolha de mesa, não dado de regra.
/// Mesmo padrão de `WeaponPickerSheet`/`ProficiencyPickerSheet`, incluindo
/// a saída "use as typed" pra item caseiro fora da base de 183.
struct MundaneItemPickerSheet: View {
    @Binding var entry: Page2EquipmentEntry
    @EnvironmentObject private var itemDatabase: MundaneItemDatabase
    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""
    @State private var detailItem: MundaneItem? = nil
    /// Filtro por categoria (2026-09-22, item 5 do lote de pedidos) — as
    /// mesmas 7 categorias que já agrupam a tela de consulta
    /// (`MundaneItemCompendiumView.categoryOrder`), só que aqui como filtro
    /// em vez de agrupamento: o seletor da ficha é uma lista pra escolher
    /// rápido, não pra folhear, então filtrar (reduzir a lista) faz mais
    /// sentido do que expandir/colapsar seções. `nil` = qualquer categoria.
    @State private var selectedCategory: String? = nil

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    Text("Choose an Item")
                        .font(Paper.hand(28))
                        .foregroundStyle(Paper.penInk)
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                searchField
                MundaneCategoryChipRow(availableCategories: availableCategories, selected: $selectedCategory)

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

                if !entry.item.isEmpty {
                    Button {
                        entry.item = ""
                        entry.weight = ""
                        entry.matchedItemID = nil
                        dismiss()
                    } label: {
                        Text("Clear current item (\(entry.item))")
                            .font(Paper.printedItalic(13))
                            .foregroundStyle(Paper.redInk)
                    }
                    .buttonStyle(.plain)
                }

                if let error = itemDatabase.loadError {
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
                            MundaneItemPickerRow(
                                item: candidate,
                                isSelected: entry.item == candidate.name,
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
            MundaneItemDetailSheet(item: candidate, onChoose: { choose(candidate) })
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "item name")
    }

    /// Mesma ordem fixa de `MundaneItemCompendiumView.categoryOrder`
    /// (Miscellaneous Equipment primeiro por ser a maior, resto
    /// alfabético) — duplicada aqui porque aquela é `private` no outro
    /// struct; deriva das categorias que de fato aparecem na base, então
    /// nunca mostra um chip vazio.
    private static let categoryOrder = [
        "Miscellaneous Equipment", "Clothing", "Food & Lodging",
        "Household Provisioning", "Services", "Tack & Harness", "Transport",
    ]

    private var availableCategories: [String] {
        let present = Set(itemDatabase.items.map(\.category))
        let ordered = Self.categoryOrder.filter { present.contains($0) }
        let extra = present.subtracting(Self.categoryOrder).sorted()
        return ordered + extra
    }

    private var filtered: [MundaneItem] {
        var all = itemDatabase.items
        if let selectedCategory {
            all = all.filter { $0.category == selectedCategory }
        }
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return all }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return all }

        return all.filter { Fuzzy.normalize($0.name).contains(normalizedQuery) }
    }

    private func choose(_ candidate: MundaneItem) {
        entry.item = candidate.name
        entry.weight = candidate.weight ?? ""
        entry.matchedItemID = candidate.id
        dismiss()
    }

    private func useAsTyped() {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        entry.item = trimmed
        entry.matchedItemID = nil
        dismiss()
    }
}

/// Fileira de chips de texto simples pra filtrar por categoria — seleção
/// única (um item só pertence a uma categoria, ao contrário do filtro de
/// cenário de campanha do Proficiency Compendium, que aceita vários).
private struct MundaneCategoryChipRow: View {
    let availableCategories: [String]
    @Binding var selected: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            FieldLabel(text: "Category")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 7) {
                    MundaneCategoryChip(label: "All", isSelected: selected == nil, action: { selected = nil })
                    ForEach(availableCategories, id: \.self) { category in
                        MundaneCategoryChip(label: category, isSelected: selected == category,
                                             action: { selected = (selected == category) ? nil : category })
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

private struct MundaneCategoryChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(Paper.printed(11.5))
                .lineLimit(1)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .foregroundStyle(isSelected ? Paper.sheet : Paper.ink)
                .background(isSelected ? Paper.ink : Color.white.opacity(0.15))
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Paper.ink.opacity(0.5), lineWidth: 1))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

private struct MundaneItemPickerRow: View {
    let item: MundaneItem
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
                    Text(item.cost ?? "—")
                        .font(Paper.printedItalic(11))
                        .foregroundStyle(Paper.inkSoft)
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
