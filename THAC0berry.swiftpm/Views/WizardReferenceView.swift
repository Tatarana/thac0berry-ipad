import SwiftUI

/// A 3ª página da aba Sheet pra quem tem ficha de magia de Mago — mesmo
/// espírito de `ClericReferenceView.swift` (2026-09-29, ver comentário lá:
/// as três peças compartilhadas — `RefTableTitle`/`RefCell`/`RefFootnotes`
/// — vêm de lá em vez de duplicadas aqui). Duas tabelas de consulta rápida
/// do PHB 2e: Wizard Spell Progression (Tabela 21) e Intelligence
/// (Tabela 4) — o Mago não tem Turning Undead nem Wisdom, então a página
/// fica mais curta que a do Clérigo. Nenhum campo aqui é editável — é
/// referência pura, os dados de verdade do personagem (nível, Inteligência)
/// só servem pra destacar a linha que importa.
struct WizardReferencePage: View {
    let character: PlayerCharacter

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Wizard Reference Tables")
                .font(Paper.printed(15))
                .tracking(1.6)
                .foregroundStyle(Paper.ink)
                .frame(maxWidth: .infinity, alignment: .center)

            WizardSpellProgressionTable(currentLevel: character.level,
                                        currentIntelligence: character.abilities.intelligence)
            IntelligenceReferenceTable(currentScore: character.abilities.intelligence)
        }
        .padding(16)
        .background(Color.white.opacity(0.4))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 2))
    }
}

// MARK: - Tabela 21: Wizard Spell Progression

private struct WizardSpellProgressionTable: View {
    let currentLevel: Int
    /// Só pra destacar, na legenda de rodapé, o teto de círculo que a
    /// Inteligência atual do personagem permite — a MESMA regra que
    /// `WizardTables.spellProgression` já aplica de verdade na folha de
    /// magias, aqui só exibida.
    let currentIntelligence: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            RefTableTitle(text: "Wizard Spell Progression")

            ScrollView(.horizontal, showsIndicators: false) {
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    GridRow {
                        RefCell(text: "Lvl", isHeader: true, minWidth: 30)
                        ForEach(1...9, id: \.self) { circle in
                            RefCell(text: "\(circle)", isHeader: true, minWidth: 30)
                        }
                    }
                    ForEach(Array(WizardTables.spellProgressionRows.enumerated()), id: \.offset) { offset, row in
                        let level = offset + 1
                        GridRow {
                            RefCell(text: "\(level)", isHighlighted: level == currentLevel, minWidth: 30)
                            ForEach(0..<9, id: \.self) { i in
                                RefCell(text: row[i].map(String.init) ?? "—",
                                        isHighlighted: level == currentLevel, minWidth: 30)
                            }
                        }
                    }
                }
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
            }

            RefFootnotes(lines: [
                "A wizard can never learn or cast a spell of a circle higher than Intelligence allows — see the Intelligence table below (\"Max Spell Level\", currently \(intelligenceCapLabel) for Intelligence \(currentIntelligence)).",
            ])
        }
    }

    private var intelligenceCapLabel: String {
        IntelligenceTable.byScore[currentIntelligence]?.maxSpellLevel ?? "—"
    }
}

// MARK: - Tabela 4: Intelligence

private struct IntelligenceReferenceTable: View {
    let currentScore: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            RefTableTitle(text: "Intelligence")

            ScrollView(.horizontal, showsIndicators: false) {
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    GridRow {
                        RefCell(text: "Score", isHeader: true, minWidth: 44)
                        RefCell(text: "Languages", isHeader: true, minWidth: 70)
                        RefCell(text: "Max Spell\nLevel", isHeader: true, minWidth: 64)
                        RefCell(text: "Learn\nSpell %", isHeader: true, minWidth: 56)
                        RefCell(text: "Max Spells\nper Level", isHeader: true, minWidth: 70)
                    }
                    // `keys.sorted()` só percorre chaves que o próprio
                    // dicionário garante existir — `byScore[score]!` nunca
                    // encontra `nil` aqui, ao contrário de um score externo
                    // qualquer (a origem do valor de verdade continua sendo
                    // `currentScore`, só usado pra destacar a linha, nunca
                    // pra indexar).
                    ForEach(Array(IntelligenceTable.byScore.keys.sorted()), id: \.self) { score in
                        let row = IntelligenceTable.byScore[score]!
                        let isCurrent = score == currentScore
                        GridRow {
                            RefCell(text: "\(score)", isHighlighted: isCurrent, minWidth: 44)
                            RefCell(text: row.languages, isHighlighted: isCurrent, minWidth: 70)
                            RefCell(text: row.maxSpellLevel, isHighlighted: isCurrent, minWidth: 64)
                            RefCell(text: row.learnChance, isHighlighted: isCurrent, minWidth: 56)
                            RefCell(text: row.maxSpellsPerLevel, isHighlighted: isCurrent, minWidth: 70)
                        }
                    }
                }
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
            }

            RefFootnotes(lines: [
                "Minimum Intelligence to be a wizard: 9.",
            ])
        }
    }
}
