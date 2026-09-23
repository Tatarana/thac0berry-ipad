import SwiftUI

/// Tela de consulta da base de Divindades (*Faiths & Avatars* + *Powers &
/// Pantheons*, 79 entradas) — mesmo espírito do `KitCompendiumView`/
/// `RulesCompendiumView`: folhear ou buscar a base inteira, sem estar
/// presa a nenhum personagem. Agrupada por hierarquia de poder (Over-
/// power/Greater/Intermediate/Lesser/Demipower) em vez de alfabética —
/// é a pergunta mais comum ao procurar um deus ("quais são os grandes
/// poderes do panteão?"), com um filtro de livro ao lado (a maioria das
/// divindades de Forgotten Realms está em *Faiths & Avatars*; panteões
/// não-humanos e de outros mundos — egípcio, mulhorandi etc. — vêm de
/// *Powers & Pantheons*).
struct DeityCompendiumView: View {
    @EnvironmentObject private var deityDatabase: DeityDatabase

    @State private var query: String = ""
    @State private var bookFilter: String? = nil
    @State private var expandedGroups: Set<String> = []
    @State private var detailDeity: Deity? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            searchField
            bookToggle

            if let error = deityDatabase.loadError {
                Text(error)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.redInk)
            } else if groupedDeities.isEmpty {
                Text("No deities match — try a different search.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            }

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(groupedDeities, id: \.label) { group in
                        DeityGroupSection(
                            label: group.label,
                            deities: group.deities,
                            isExpanded: isExpanded(group.label),
                            onToggleExpand: { toggleExpand(group.label) },
                            onSelect: { detailDeity = $0 }
                        )
                    }
                }
            }
        }
        .sheet(item: $detailDeity) { deity in
            DeityDetailSheet(deity: deity)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Deities")
                .font(Paper.hand(30))
                .foregroundStyle(Paper.penInk)
            Text("\(filtered.count) of \(deityDatabase.entries.count) deities · Faiths & Avatars, Powers & Pantheons")
                .font(Paper.printedItalic(12))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "deity name, alias, portfolio…")
    }

    private var bookToggle: some View {
        HStack(spacing: 8) {
            DeityBookChip(label: "All", isSelected: bookFilter == nil, action: { bookFilter = nil })
            DeityBookChip(label: "Faiths & Avatars", isSelected: bookFilter == "Faiths & Avatars",
                          action: { bookFilter = "Faiths & Avatars" })
            DeityBookChip(label: "Powers & Pantheons", isSelected: bookFilter == "Powers & Pantheons",
                          action: { bookFilter = "Powers & Pantheons" })
        }
    }

    // MARK: - Dados derivados

    private var filtered: [Deity] {
        let base = bookFilter.map { book in deityDatabase.entries.filter { $0.book == book } } ?? deityDatabase.entries
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return base }

        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return base }

        return base.filter { deity in
            Fuzzy.normalize(deity.name).contains(normalizedQuery)
                || (deity.aliases.map { Fuzzy.normalize($0).contains(normalizedQuery) } ?? false)
                || Fuzzy.normalize(deity.portfolio).contains(normalizedQuery)
        }
    }

    private struct RankGroup { let label: String; let deities: [Deity] }

    /// Ordem de hierarquia divina, do topo pra baixo — igual a página do
    /// livro já organiza. "Letter Power" (só Tiamat, provável erro de
    /// digitação do livro por "Lesser Power" — ver `Deity.rank`) e `nil`
    /// (Gwaeron Windstrom) caem em "Other" no fim, pra não quebrar a
    /// ordem das categorias de verdade.
    private static let rankOrder = ["Over-power", "Greater Power", "Intermediate Power", "Lesser Power", "Demipower"]

    private static func groupLabel(forRank rank: String?) -> String {
        guard let rank, Self.rankOrder.contains(rank) else { return "Other" }
        return rank
    }

    private var groupedDeities: [RankGroup] {
        let byRank = Dictionary(grouping: filtered, by: { Self.groupLabel(forRank: $0.rank) })
        var orderedLabels = Self.rankOrder
        orderedLabels.append("Other")

        return orderedLabels.compactMap { label in
            guard let deities = byRank[label], !deities.isEmpty else { return nil }
            return RankGroup(label: label, deities: deities.sorted { $0.name < $1.name })
        }
    }

    private func isExpanded(_ label: String) -> Bool {
        if expandedGroups.contains(label) { return true }
        return !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func toggleExpand(_ label: String) {
        if expandedGroups.contains(label) {
            expandedGroups.remove(label)
        } else {
            expandedGroups.insert(label)
        }
    }
}

private struct DeityBookChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(Paper.printed(11.5))
                .tracking(0.6)
                .foregroundStyle(isSelected ? Paper.sheet : Paper.inkSoft)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(isSelected ? Paper.ink : Color.clear)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Paper.inkSoft.opacity(0.5), lineWidth: isSelected ? 0 : 1))
        }
        .buttonStyle(.plain)
    }
}

private struct DeityGroupSection: View {
    let label: String
    let deities: [Deity]
    let isExpanded: Bool
    let onToggleExpand: () -> Void
    let onSelect: (Deity) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: onToggleExpand) {
                Text("\(isExpanded ? "▾" : "▸") \(label) (\(deities.count))")
                    .font(Paper.printed(17))
                    .tracking(1.2)
                    .foregroundStyle(Paper.ink)
            }
            .buttonStyle(.plain)

            if isExpanded {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(deities) { deity in
                        DeityCompendiumRow(deity: deity, onSelect: { onSelect(deity) })
                    }
                }
            }
        }
    }
}

private struct DeityCompendiumRow: View {
    let deity: Deity
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(deity.name)
                        .font(Paper.hand(19))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    if let status = deity.status {
                        Text(status.uppercased())
                            .font(Paper.printed(9))
                            .tracking(0.6)
                            .foregroundStyle(Paper.redInk)
                    }
                    Spacer(minLength: 4)
                    Text(deity.alignment ?? "—")
                        .font(Paper.printedItalic(10.5))
                        .foregroundStyle(Paper.inkSoft)
                        .lineLimit(1)
                }
                Text(deity.portfolio)
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

// MARK: - Descrição completa da divindade

struct DeityDetailSheet: View {
    let deity: Deity
    @Environment(\.dismiss) private var dismiss
    @State private var showAvatarStatblock = false

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(deity.name)
                            .font(Paper.hand(28))
                            .foregroundStyle(Paper.penInk)
                        Text(subtitle)
                            .font(Paper.printedItalic(15))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                Rectangle().fill(Paper.ink).frame(height: 1.4)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 14)],
                                  alignment: .leading, spacing: 10) {
                            if let alignment = deity.alignment {
                                DeityDetailField(label: "Alignment", value: alignment)
                            }
                            DeityDetailField(label: "Portfolio", value: deity.portfolio)
                            if let symbol = deity.symbol {
                                DeityDetailField(label: "Symbol", value: symbol)
                            }
                            if let worshiperAlignments = deity.worshiperAlignments {
                                DeityDetailField(label: "Worshiper Alignments", value: worshiperAlignments)
                            }
                            if let plane = deity.plane {
                                DeityDetailField(label: "Home Plane", value: plane)
                            }
                            if let domainName = deity.domainName {
                                DeityDetailField(label: "Domain", value: domainName)
                            }
                            if let superior = deity.superior, superior != "None" {
                                DeityDetailField(label: "Superior", value: superior)
                            }
                            if let aliases = deity.aliases {
                                DeityDetailField(label: "Aliases", value: aliases)
                            }
                            if let allies = deity.allies {
                                DeityDetailField(label: "Allies", value: allies)
                            }
                            if let foes = deity.foes {
                                DeityDetailField(label: "Foes", value: foes)
                            }
                            DeityDetailField(label: "Source", value: deity.book)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            FieldLabel(text: "Mythology & Clergy")
                            Text(deity.fullText)
                                .font(Paper.printed(14))
                                .foregroundStyle(Paper.ink)
                                .lineSpacing(4)
                        }

                        // Statblock de combate do avatar — colapsado por
                        // padrão: é a divindade em pé de guerra, cenário
                        // raro de mesa, e o texto é longo (chega a passar
                        // de 1.500 palavras nas divindades maiores); não
                        // faz sentido empurrar o dogma/clero, que é o que
                        // a maioria abre a ficha pra ler, pra baixo dele.
                        if deity.avatarDescription != nil {
                            avatarSection
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding(24)
        }
    }

    private var subtitle: String {
        var parts: [String] = []
        if let rank = deity.rank { parts.append(rank) }
        parts.append(deity.book)
        return parts.joined(separator: " · ")
    }

    private var avatarSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Button(action: { showAvatarStatblock.toggle() }) {
                HStack(spacing: 6) {
                    Text(showAvatarStatblock ? "▾" : "▸")
                    FieldLabel(text: "Avatar Statblock")
                    if let classLevels = deity.avatarClassLevels {
                        Text(classLevels)
                            .font(Paper.printedItalic(11))
                            .foregroundStyle(Paper.inkSoft)
                            .lineLimit(1)
                    }
                }
            }
            .buttonStyle(.plain)

            if showAvatarStatblock, let avatarDescription = deity.avatarDescription {
                Text(avatarDescription)
                    .font(Paper.printed(13))
                    .foregroundStyle(Paper.ink)
                    .lineSpacing(3)
            }
        }
    }
}

private struct DeityDetailField: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            FieldLabel(text: label)
            Text(value)
                .font(Paper.hand(17))
                .foregroundStyle(Paper.penInk)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Atalho "?" pra abrir a divindade a partir de outro lugar do app

/// Botão redondo pequeno igual `RuleLinkButton`, mas resolvido por NOME em
/// vez de id fixo — usado onde o app só tem texto livre pra trabalhar:
/// `Kit.deity` (57 kits de sacerdote especializado) e o campo "Patron
/// Deity" da ficha (`PlayerCharacter.deity`, texto livre desde sempre).
/// Sem correspondência exata (nome digitado errado, divindade de
/// homebrew, ou simplesmente vazio) o botão não aparece — mesma filosofia
/// do `RuleLinkButton`: melhor não mostrar nada que abrir uma ficha vazia
/// ou a divindade errada.
struct DeityLinkButton: View {
    let deityName: String
    @EnvironmentObject private var deityDatabase: DeityDatabase
    @State private var showDetail = false

    var body: some View {
        if let deity = deityDatabase.deity(named: deityName) {
            Button(action: { showDetail = true }) {
                Text("?")
                    .font(Paper.printed(11))
                    .fontWeight(.bold)
                    .foregroundStyle(Paper.sheet)
                    .frame(width: 17, height: 17)
                    .background(Paper.inkSoft)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Deity: \(deity.name)")
            .sheet(isPresented: $showDetail) {
                DeityDetailSheet(deity: deity)
            }
        }
    }
}
