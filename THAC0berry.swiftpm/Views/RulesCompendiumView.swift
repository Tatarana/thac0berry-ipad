import SwiftUI

/// Tela de consulta da base de regras (PHB + DMG, 274 entradas / 200
/// tabelas) — mesmo espírito do `KitCompendiumView`/`SpellbookView`:
/// folhear ou buscar a base inteira, sem estar presa a nenhum personagem.
/// Agrupada por livro e depois por capítulo (ordem do próprio livro, não
/// alfabética) — é como qualquer jogador já folheia o PHB/DMG físico.
struct RulesCompendiumView: View {
    @EnvironmentObject private var rulesDatabase: RulesDatabase

    @State private var query: String = ""
    @State private var bookFilter: String? = nil
    @State private var expandedChapters: Set<String> = []
    @State private var detailEntry: RuleEntry? = nil

    private var isSearching: Bool {
        !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            searchField
            bookToggle

            if let error = rulesDatabase.loadError {
                Text(error)
                    .font(Paper.printedItalic(12))
                    .foregroundStyle(Paper.redInk)
            } else if isSearching && searchResults.isEmpty {
                Text("No rules match — try a different search.")
                    .font(Paper.printedItalic(13))
                    .foregroundStyle(Paper.inkSoft)
            }

            if isSearching {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(searchResults) { match in
                        RuleCompendiumRow(entry: match.entry, onSelect: { detailEntry = match.entry })
                    }
                }
            } else {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(chapterGroups, id: \.key) { group in
                        RuleChapterSection(
                            label: "\(group.book) Ch. \(group.chapter): \(group.title)",
                            entries: group.entries,
                            isExpanded: expandedChapters.contains(group.key),
                            onToggleExpand: { toggleExpand(group.key) },
                            onSelect: { detailEntry = $0 }
                        )
                    }
                }
            }
        }
        .sheet(item: $detailEntry) { entry in
            RuleDetailSheet(entry: entry)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Rules Reference")
                .font(Paper.hand(30))
                .foregroundStyle(Paper.penInk)
            Text("\(rulesDatabase.entries.count) rules · Player's Handbook, Dungeon Master's Guide & Complete Priest's Handbook")
                .font(Paper.printedItalic(12))
                .foregroundStyle(Paper.inkSoft)
        }
    }

    private var searchField: some View {
        SearchField(text: $query, placeholder: "topic, keyword…")
    }

    /// PHB / DMG / CPrH / todos — a DMG tem conteúdo voltado pro Mestre
    /// (recompensas, criação de item mágico, diretrizes de campanha) junto
    /// com regras do PHB, e o CPrH (Complete Priest's Handbook) é ainda
    /// mais nesse sentido — a maior parte dos seus capítulos (deuses,
    /// design de fé, role-playing) é material de worldbuilding pro
    /// Mestre, não regra de jogador; o filtro deixa quem só quer as
    /// regras de jogador escondê-las sem precisar caçar pelo `book` de
    /// cada resultado.
    private var bookToggle: some View {
        HStack(spacing: 8) {
            BookFilterChip(label: "All", isSelected: bookFilter == nil, action: { bookFilter = nil })
            BookFilterChip(label: "PHB", isSelected: bookFilter == "PHB", action: { bookFilter = "PHB" })
            BookFilterChip(label: "DMG", isSelected: bookFilter == "DMG", action: { bookFilter = "DMG" })
            BookFilterChip(label: "CPrH", isSelected: bookFilter == "CPrH", action: { bookFilter = "CPrH" })
        }
    }

    private var searchResults: [RuleMatch] {
        rulesDatabase.matches(for: query, limit: 40, book: bookFilter)
    }

    private struct ChapterGroup {
        let key: String
        let book: String
        let chapter: Int
        let title: String
        let entries: [RuleEntry]
    }

    private var chapterGroups: [ChapterGroup] {
        let books = bookFilter.map { [$0] } ?? ["PHB", "DMG", "CPrH"]
        var groups: [ChapterGroup] = []
        for book in books {
            for chapter in rulesDatabase.chapters(book: book) {
                let entries = rulesDatabase.entries(book: book, chapter: chapter.number)
                    .sorted { $0.topic < $1.topic }
                guard !entries.isEmpty else { continue }
                groups.append(ChapterGroup(key: "\(book)-\(chapter.number)", book: book,
                                            chapter: chapter.number, title: chapter.title, entries: entries))
            }
        }
        return groups
    }

    private func toggleExpand(_ key: String) {
        if expandedChapters.contains(key) {
            expandedChapters.remove(key)
        } else {
            expandedChapters.insert(key)
        }
    }
}

private struct BookFilterChip: View {
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

private struct RuleChapterSection: View {
    let label: String
    let entries: [RuleEntry]
    let isExpanded: Bool
    let onToggleExpand: () -> Void
    let onSelect: (RuleEntry) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: onToggleExpand) {
                Text("\(isExpanded ? "▾" : "▸") \(label) (\(entries.count))")
                    .font(Paper.printed(15))
                    .tracking(0.8)
                    .foregroundStyle(Paper.ink)
            }
            .buttonStyle(.plain)

            if isExpanded {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(entries) { entry in
                        RuleCompendiumRow(entry: entry, onSelect: { onSelect(entry) })
                    }
                }
            }
        }
    }
}

private struct RuleCompendiumRow: View {
    let entry: RuleEntry
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(entry.topic)
                        .font(Paper.hand(18))
                        .foregroundStyle(Paper.penInk)
                        .lineLimit(1)
                    Spacer(minLength: 4)
                    Text(entry.book)
                        .font(Paper.printedItalic(10.5))
                        .foregroundStyle(Paper.inkSoft)
                        .lineLimit(1)
                }
                Text(entry.summary)
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

// MARK: - Detalhe de uma regra

/// Sheet de detalhe — aberta tanto pela navegação livre do Compendium
/// quanto pelos atalhos "?" na ficha (`RuleLinkButton`). `content` é
/// renderizado em blocos (`RuleContentBlock`) em vez de um `Text` único:
/// o texto original mistura prosa, subtítulos (`## `/`### `) e referências
/// de tabela (`[TABLE_REF: ...]`) que precisam virar um grid de verdade,
/// não continuar como texto solto.
struct RuleDetailSheet: View {
    let entry: RuleEntry
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PaperBackground()

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(entry.topic)
                            .font(Paper.hand(26))
                            .foregroundStyle(Paper.penInk)
                        Text(entry.breadcrumbs)
                            .font(Paper.printedItalic(14))
                            .foregroundStyle(Paper.inkSoft)
                    }
                    Spacer()
                    Button("close") { dismiss() }
                        .font(Paper.printed(16))
                        .foregroundStyle(Paper.inkSoft)
                }

                Rectangle().fill(Paper.ink).frame(height: 1.4)

                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        ForEach(Array(contentBlocks.enumerated()), id: \.offset) { _, block in
                            RuleContentBlockView(block: block)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding(24)
        }
    }

    private var contentBlocks: [RuleContentBlock] {
        RuleContentParser.parse(entry.content, tables: entry.tables)
    }
}

/// Bloco de conteúdo de uma regra, já classificado a partir da prosa
/// markdown-ish do `content` original.
enum RuleContentBlock {
    case heading(String)
    case subheading(String)
    case paragraph(String)
    case bulletList([String])
    case table(RuleTable)
}

enum RuleContentParser {
    /// `[TABLE_REF: Table 53: THAC0 by Level]` — o texto entre colchetes é
    /// sempre "Table N" ou "Table N: Título" exatamente igual ao `title`
    /// (ou prefixo de `tableNumber`) de uma tabela na mesma entrada —
    /// verificado por auditoria (0 referências soltas em todo o corpus).
    private static let tableRefPattern = try! NSRegularExpression(pattern: #"^\[TABLE_REF:\s*(.+?)\]$"#)

    static func parse(_ content: String, tables: [RuleTable]) -> [RuleContentBlock] {
        var blocks: [RuleContentBlock] = []
        let paragraphs = content.components(separatedBy: "\n\n")

        for rawParagraph in paragraphs {
            let paragraph = rawParagraph.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !paragraph.isEmpty else { continue }

            let lines = paragraph.components(separatedBy: "\n").map { $0.trimmingCharacters(in: .whitespaces) }
            var remainingLines = lines[...]

            // Um bloco pode abrir com "## Subtítulo" ou "### Subtítulo" e
            // continuar com prosa normal na mesma linha em branco dupla —
            // separa o cabeçalho e processa o resto do bloco à parte.
            if let firstLine = remainingLines.first {
                if firstLine.hasPrefix("### ") {
                    blocks.append(.subheading(String(firstLine.dropFirst(4))))
                    remainingLines = remainingLines.dropFirst()
                } else if firstLine.hasPrefix("## ") {
                    blocks.append(.heading(String(firstLine.dropFirst(3))))
                    remainingLines = remainingLines.dropFirst()
                }
            }

            guard !remainingLines.isEmpty else { continue }
            let rest = remainingLines.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
            guard !rest.isEmpty else { continue }

            // [TABLE_REF: ...] sozinho na linha/bloco → resolve pra tabela.
            if let match = tableRefPattern.firstMatch(in: rest, range: NSRange(rest.startIndex..., in: rest)),
               let range = Range(match.range(at: 1), in: rest) {
                let refTitle = String(rest[range]).trimmingCharacters(in: .whitespaces)
                if let table = resolveTable(refTitle, in: tables) {
                    blocks.append(.table(table))
                    continue
                }
            }

            // Bloco onde toda linha começa com "* " → lista.
            let restLines = rest.components(separatedBy: "\n")
            if !restLines.isEmpty && restLines.allSatisfy({ $0.hasPrefix("* ") || $0.hasPrefix(":* ") }) {
                let items = restLines.map { line -> String in
                    if line.hasPrefix(":* ") { return String(line.dropFirst(3)) }
                    return String(line.dropFirst(2))
                }
                blocks.append(.bulletList(items))
                continue
            }

            blocks.append(.paragraph(rest))
        }

        return blocks
    }

    private static func resolveTable(_ refTitle: String, in tables: [RuleTable]) -> RuleTable? {
        if let exact = tables.first(where: { $0.title == refTitle }) { return exact }
        // Fallback: a referência às vezes só traz "Table N" sem o título
        // completo — casa pelo número no início.
        return tables.first { refTitle.hasPrefix($0.tableNumber) }
    }
}

private struct RuleContentBlockView: View {
    let block: RuleContentBlock

    var body: some View {
        switch block {
        case .heading(let text):
            Text(LocalizedStringKey(text))
                .font(Paper.hand(20))
                .foregroundStyle(Paper.penInk)
                .padding(.top, 2)
        case .subheading(let text):
            Text(LocalizedStringKey(text))
                .font(Paper.printed(15))
                .tracking(0.4)
                .foregroundStyle(Paper.ink)
        case .paragraph(let text):
            Text(LocalizedStringKey(text))
                .font(Paper.printed(13.5))
                .foregroundStyle(Paper.ink)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        case .bulletList(let items):
            VStack(alignment: .leading, spacing: 5) {
                ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                    HStack(alignment: .top, spacing: 6) {
                        Text("•")
                            .font(Paper.printed(13.5))
                            .foregroundStyle(Paper.inkSoft)
                        Text(LocalizedStringKey(item))
                            .font(Paper.printed(13.5))
                            .foregroundStyle(Paper.ink)
                            .lineSpacing(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        case .table(let table):
            RuleTableView(table: table)
        }
    }
}

/// Grid de uma tabela de regra — largura variável (2 a 6 colunas), então
/// roda dentro de um `ScrollView(.horizontal)` próprio em vez de tentar
/// encolher pra caber na tela (número que quebra linha vira ambíguo).
struct RuleTableView: View {
    let table: RuleTable

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(table.title)
                .font(Paper.printedItalic(12.5))
                .foregroundStyle(Paper.inkSoft)

            // `horizontalSpacing`/`verticalSpacing` zerados de propósito: um
            // `.background()` no nível do `GridRow` só pinta atrás do texto,
            // não o espaço entre colunas (o Grid dimensiona cada célula
            // pelo conteúdo) — deixava a linha de cabeçalho com fundo
            // escuro "picado", só atrás de cada palavra. Em vez disso, cada
            // célula pinta o próprio fundo cobrindo até a borda (`padding`
            // + `frame(maxWidth: .infinity)`), então células vizinhas sem
            // espaçamento entre si formam uma barra contínua de verdade.
            ScrollView(.horizontal, showsIndicators: true) {
                Grid(alignment: .leading, horizontalSpacing: 0, verticalSpacing: 0) {
                    GridRow {
                        ForEach(Array(table.headers.enumerated()), id: \.offset) { _, header in
                            Text(header)
                                .font(Paper.printed(11.5))
                                .tracking(0.4)
                                .foregroundStyle(Paper.sheet)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Paper.ink)
                        }
                    }

                    ForEach(Array(table.rows.enumerated()), id: \.offset) { rowIndex, row in
                        GridRow {
                            ForEach(Array(row.enumerated()), id: \.offset) { _, cell in
                                Text(cell)
                                    .font(Paper.printed(12))
                                    .foregroundStyle(Paper.ink)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(rowIndex.isMultiple(of: 2) ? Color.clear : Paper.ink.opacity(0.06))
                            }
                        }
                    }
                }
            }
            .background(Paper.sheet.opacity(0.5))
            .overlay(RoundedRectangle(cornerRadius: 6, style: .continuous).stroke(Paper.inkSoft.opacity(0.35), lineWidth: 1))
        }
    }
}

// MARK: - Atalho "?" pra abrir uma regra direto da ficha

/// Botão redondo pequeno usado nos rótulos de seção da ficha (THAC0,
/// Proficiencies, Saving Throws, Encumbrance) — abre a regra correspondente
/// direto, sem passar pelo Compendium. `ruleID` casa com o `id` gerado no
/// pipeline de extração (ex. `"phb_ch09_calculating_thac0"`); se a base não
/// tiver a entrada (id digitado errado, ou dado que mudou numa
/// regeneração futura) o botão simplesmente não aparece — melhor que abrir
/// uma sheet vazia sem explicação.
struct RuleLinkButton: View {
    let ruleID: String
    @EnvironmentObject private var rulesDatabase: RulesDatabase
    @State private var showDetail = false

    var body: some View {
        if let entry = rulesDatabase.entry(id: ruleID) {
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
            .accessibilityLabel("Rule: \(entry.topic)")
            .sheet(isPresented: $showDetail) {
                RuleDetailSheet(entry: entry)
            }
        }
    }
}
