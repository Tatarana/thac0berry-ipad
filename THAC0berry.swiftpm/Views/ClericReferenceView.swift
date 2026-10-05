import SwiftUI

/// A 3ª página da aba Sheet — só existe pra quem tem ficha de magia
/// (Clérigo, por ora). Três tabelas de consulta rápida do PHB 2e, coladas
/// fielmente: Turning Undead, Priest Spell Progression e Wisdom. Nenhum
/// campo aqui é editável — é referência pura, os dados de verdade do
/// personagem (nível, Sabedoria) só servem pra destacar a linha que importa.
struct ClericReferencePage: View {
    let character: PlayerCharacter

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Cleric Reference Tables")
                .font(Paper.printed(15))
                .tracking(1.6)
                .foregroundStyle(Paper.ink)
                .frame(maxWidth: .infinity, alignment: .center)

            PriestSpellProgressionTable(currentLevel: character.level)
            TurningUndeadTable(currentLevel: character.level)
            WisdomReferenceTable(currentScore: character.abilities.wisdom)
        }
        .padding(16)
        .background(Color.white.opacity(0.4))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 2))
    }
}

// MARK: - Peças compartilhadas
//
// Sem `private` (2026-09-29) — `WizardReferenceView.swift` reaproveita as
// três daqui em vez de duplicar o mesmo desenho de célula/título/rodapé.

struct RefTableTitle: View {
    let text: String
    var body: some View {
        Text(text.uppercased())
            .font(Paper.printed(13))
            .tracking(1.3)
            .foregroundStyle(Paper.ink)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 2)
    }
}

struct RefCell: View {
    let text: String
    var isHeader: Bool = false
    var isHighlighted: Bool = false
    var minWidth: CGFloat = 30
    var alignment: Alignment = .center

    // Ternários tirados de dentro dos modificadores e tipados aqui: cada um
    // inline multiplicava as combinações que o type-checker testava (era a
    // 2ª função mais lenta de compilar do app, ~0,4–0,56 s — ver CI).
    private var cellFont: Font { isHeader ? Paper.printed(10.5) : Paper.printed(11.5) }
    private var cellTracking: CGFloat { isHeader ? 0.4 : 0 }
    private var textColor: Color { isHighlighted ? Paper.redInk : Paper.ink }
    private var textAlignment: TextAlignment { alignment == .leading ? .leading : .center }
    private var fill: Color {
        if isHighlighted { return Paper.redInk.opacity(0.1) }
        return isHeader ? Color.black.opacity(0.05) : Color.clear
    }

    var body: some View {
        Text(text)
            .font(cellFont)
            .tracking(cellTracking)
            .foregroundStyle(textColor)
            .lineLimit(2)
            .minimumScaleFactor(0.7)
            .multilineTextAlignment(textAlignment)
            .frame(minWidth: minWidth, minHeight: 26, alignment: alignment)
            .padding(.horizontal, 3)
            .padding(.vertical, 3)
            // O `Grid` mede a largura da coluna pelo tamanho IDEAL de cada
            // célula (esse `.frame(minWidth:)` acima não conta pra isso),
            // então isso aqui não desalinha as colunas — só faz a célula
            // preencher o espaço que a coluna já tem, senão fundo e borda
            // ficavam abraçados só no texto, sobrando um vão sem moldura ao
            // lado (foi o que aconteceu com Wisdom: a coluna de Immunity
            // ficou larga pelas linhas com texto longo, e as linhas com só
            // "—" não preenchiam esse espaço).
            .frame(maxWidth: .infinity, alignment: alignment)
            .background(fill)
            .overlay(Rectangle().stroke(Paper.hairline, lineWidth: 0.6))
    }
}

struct RefFootnotes: View {
    let lines: [String]
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(lines, id: \.self) { line in
                Text(line)
                    .font(Paper.printedItalic(9.5))
                    .foregroundStyle(Paper.inkSoft)
            }
        }
        .padding(.top, 2)
    }
}

// MARK: - Tabela 24: Priest Spell Progression

private struct PriestSpellProgressionTable: View {
    let currentLevel: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            RefTableTitle(text: "Priest Spell Progression")

            // `Grid` (nativo, iOS 16+) mede a maior célula de cada coluna
            // olhando TODAS as `GridRow`s de uma vez, então as colunas
            // sempre alinham — diferente de empilhar `HStack`s soltos, onde
            // cada linha decide sua própria largura sem saber das outras.
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                GridRow {
                    RefCell(text: "Lvl", isHeader: true, minWidth: 30)
                    ForEach(1...7, id: \.self) { circle in
                        RefCell(text: circleHeader(circle), isHeader: true)
                    }
                }
                ForEach(Array(PriestTables.spellProgressionRows.enumerated()), id: \.offset) { offset, row in
                    let level = offset + 1
                    GridRow {
                        RefCell(text: "\(level)", isHighlighted: level == currentLevel)
                        ForEach(0..<7, id: \.self) { i in
                            RefCell(text: row[i].map(String.init) ?? "—",
                                    isHighlighted: level == currentLevel)
                        }
                    }
                }
            }
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))

            RefFootnotes(lines: [
                "* Usable only by priests with 17 or greater Wisdom.",
                "** Usable only by priests with 18 or greater Wisdom.",
            ])
        }
    }

    private func circleHeader(_ circle: Int) -> String {
        switch circle {
        case 6: return "6*"
        case 7: return "7**"
        default: return "\(circle)"
        }
    }
}

// MARK: - Tabela 61: Turning Undead

private struct TurningUndeadTable: View {
    let currentLevel: Int

    /// A tabela tem colunas de faixa ("10-11", "12-13", "14+") — a linha do
    /// nível atual destaca a coluna certa mesmo quando ele cai numa faixa.
    private func columnMatchesLevel(_ column: String) -> Bool {
        if let exact = Int(column) { return exact == currentLevel }
        if column.hasSuffix("+"), let base = Int(column.dropLast()) { return currentLevel >= base }
        let parts = column.split(separator: "-").compactMap { Int($0) }
        guard parts.count == 2 else { return false }
        return (parts[0]...parts[1]).contains(currentLevel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            RefTableTitle(text: "Turning Undead")

            ScrollView(.horizontal, showsIndicators: false) {
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    GridRow {
                        RefCell(text: "Type / HD", isHeader: true, minWidth: 128, alignment: .leading)
                        ForEach(PriestTables.turningUndeadLevels, id: \.self) { level in
                            RefCell(text: level, isHeader: true, isHighlighted: columnMatchesLevel(level), minWidth: 42)
                        }
                    }
                    // Tupla nomeada não aceita `id: \.campo` (key path pra
                    // elemento de tupla não compila) — usa o índice como id.
                    ForEach(Array(PriestTables.turningUndeadRows.enumerated()), id: \.offset) { _, row in
                        GridRow {
                            RefCell(text: row.type, minWidth: 128, alignment: .leading)
                            ForEach(Array(row.results.enumerated()), id: \.offset) { i, value in
                                RefCell(text: value,
                                        isHighlighted: columnMatchesLevel(PriestTables.turningUndeadLevels[i]),
                                        minWidth: 42)
                            }
                        }
                    }
                }
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
            }

            RefFootnotes(lines: PriestTables.turningUndeadFootnotes)
        }
    }
}

// MARK: - Tabela 5: Wisdom

private struct WisdomReferenceTable: View {
    let currentScore: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            RefTableTitle(text: "Wisdom")

            ScrollView(.horizontal, showsIndicators: false) {
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    GridRow {
                        RefCell(text: "Score", isHeader: true, minWidth: 44)
                        RefCell(text: "Mag.\nDefense", isHeader: true, minWidth: 56)
                        RefCell(text: "Bonus\nSpells", isHeader: true, minWidth: 64)
                        RefCell(text: "Spell\nFailure", isHeader: true, minWidth: 56)
                        RefCell(text: "Spell Immunity", isHeader: true, minWidth: 230, alignment: .leading)
                    }
                    // Mesmo motivo do Turning Undead acima: tupla não aceita
                    // `id: \.score`, usa o índice.
                    ForEach(Array(PriestTables.wisdomRows.enumerated()), id: \.offset) { _, row in
                        let isCurrent = row.score == currentScore
                        GridRow {
                            RefCell(text: "\(row.score)", isHighlighted: isCurrent, minWidth: 44)
                            RefCell(text: row.magDef, isHighlighted: isCurrent, minWidth: 56)
                            RefCell(text: row.bonus, isHighlighted: isCurrent, minWidth: 64)
                            RefCell(text: row.failure, isHighlighted: isCurrent, minWidth: 56)
                            RefCell(text: row.immunity, isHighlighted: isCurrent, minWidth: 230, alignment: .leading)
                        }
                    }
                }
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
            }
        }
    }
}
