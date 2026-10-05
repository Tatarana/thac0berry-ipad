import SwiftUI

/// A 4ª página da aba Sheet pro grupo Rogue (Thief/Bard/Ninja) — mesmo
/// espírito de `WarriorReferenceView.swift`: consulta pura, nenhum campo
/// editável. Mostra as quatro tabelas que a seção "Thieving Skills" da
/// página 1 NÃO consegue aplicar sozinha (raça e Destreza já são
/// semeadas lá — ver `ThievingSkillsForm.seedIfNeeded`/
/// `ThievingSkillsTable`), mais Backstab e, pro Bard, a progressão de
/// magia e as 4 habilidades próprias dele.
struct RogueReferencePage: View {
    let character: PlayerCharacter

    private var skills: [String] { ThievingSkillsTable.skills(for: character.characterClass) }
    // Comparações tipadas fora do `body` (`x == .a || x == .b` inline faz
    // o type-checker testar todos os `==` possíveis; ~0,16–0,23 s).
    private var showsBackstab: Bool { [CharacterClass.thief, .ninja].contains(character.characterClass) }
    private var showsBardSpells: Bool { character.characterClass == CharacterClass.bard }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Rogue Reference Tables")
                .font(Paper.printed(15))
                .tracking(1.6)
                .foregroundStyle(Paper.ink)
                .frame(maxWidth: .infinity, alignment: .center)

            ThievingSkillsBaseTable(characterClass: character.characterClass, skills: skills)
            ArmorAdjustmentReferenceTable(characterClass: character.characterClass, skills: skills)

            if showsBackstab {
                BackstabReferenceTable(currentLevel: character.level)
            }

            if showsBardSpells {
                BardSpellProgressionReferenceTable(currentLevel: character.level)
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.4))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 2))
    }
}

// MARK: - Base scores (Table 26 / Table 2 CNH / Table 33) + Dex/Race columns

private struct ThievingSkillsBaseTable: View {
    let characterClass: CharacterClass
    let skills: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                RefTableTitle(text: "Thieving Skills — Base Score")
                RuleLinkButton(ruleID: baseRuleID)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    GridRow {
                        RefCell(text: "Skill", isHeader: true, minWidth: 132, alignment: .leading)
                        RefCell(text: "Base", isHeader: true, minWidth: 48)
                    }
                    ForEach(skills, id: \.self) { skill in
                        GridRow {
                            RefCell(text: skill, minWidth: 132, alignment: .leading)
                            RefCell(text: "\(ThievingSkillsTable.baseScore(skill: skill, characterClass: characterClass))%",
                                    minWidth: 48)
                        }
                    }
                }
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
            }

            RefFootnotes(lines: footnotes)
        }
    }

    private var baseRuleID: String {
        switch characterClass {
        case .ninja: return "cnh_ch01_the_ninja_class"
        case .bard: return "phb_ch03_rogue_tables"
        default: return "phb_ch03_rogue_tables"
        }
    }

    private var footnotes: [String] {
        switch characterClass {
        case .ninja:
            return ["Base scores are the Ninja's own (Table 2, Complete Ninja's Handbook) — different from the Thief's Table 26, not a variant of it.",
                    "Race adjustment only for Dwarf/Halfling (the only demihumans allowed as ninja) — same numbers as the Thief's Table 27.",
                    "Dexterity adjustment reuses the Thief's Table 28 — the Ninja's own Table 3 explicitly reproduces it."]
        case .bard:
            return ["Table 33 gives one flat base per ability, not a per-race table — apply the Thief's race/Dexterity adjustments (Table 27/28) on top, per the Bard description."]
        default:
            return ["Race adjustment: Table 27. Dexterity adjustment: Table 28. Both already folded into the seeded value on the Sheet page."]
        }
    }
}

// MARK: - Armor adjustments (Table 29 / Ninja Table 5) — reference only, not auto-applied

private struct ArmorAdjustmentReferenceTable: View {
    let characterClass: CharacterClass
    let skills: [String]

    private var isNinja: Bool { characterClass == .ninja }
    private var columns: [String] { isNinja ? ThievingSkillsTable.ninjaArmorColumns : ThievingSkillsTable.thiefArmorColumns }
    private var table: [String: [Int]] { isNinja ? ThievingSkillsTable.ninjaArmorAdjustments : ThievingSkillsTable.thiefArmorAdjustments }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                RefTableTitle(text: "Armor Adjustment")
                RuleLinkButton(ruleID: isNinja ? "cnh_ch01_the_ninja_class" : "phb_ch03_rogue_tables")
            }

            ScrollView(.horizontal, showsIndicators: false) {
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    GridRow {
                        RefCell(text: "Skill", isHeader: true, minWidth: 132, alignment: .leading)
                        ForEach(columns, id: \.self) { col in
                            RefCell(text: col, isHeader: true, minWidth: 54)
                        }
                    }
                    ForEach(skills, id: \.self) { skill in
                        GridRow {
                            RefCell(text: skill, minWidth: 132, alignment: .leading)
                            ForEach(Array((table[skill] ?? []).enumerated()), id: \.offset) { _, value in
                                RefCell(text: value == 0 ? "—" : "\(value > 0 ? "+" : "")\(value)%", minWidth: 54)
                            }
                        }
                    }
                }
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
            }

            RefFootnotes(lines: [
                "Not folded into the seeded % on the Sheet page — the app only stores your AC number, not the armor TYPE, so there's no reliable way to pick the right column automatically. Apply it by hand.",
            ])
        }
    }
}

// MARK: - Backstab (Table 30 — shared by Thief and Ninja)

private struct BackstabReferenceTable: View {
    let currentLevel: Int

    private static let rows: [(range: String, multiplier: String, lower: Int, upper: Int)] = [
        ("1-4", "x2", 1, 4), ("5-8", "x3", 5, 8), ("9-12", "x4", 9, 12), ("13+", "x5", 13, 999),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                RefTableTitle(text: "Backstab Damage Multiplier")
                RuleLinkButton(ruleID: "phb_ch03_rogue_tables")
            }

            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                GridRow {
                    RefCell(text: "Level", isHeader: true, minWidth: 80)
                    RefCell(text: "Multiplier", isHeader: true, minWidth: 80)
                }
                ForEach(Self.rows, id: \.range) { row in
                    let isCurrent = (row.lower...row.upper).contains(currentLevel)
                    GridRow {
                        RefCell(text: row.range, isHighlighted: isCurrent, minWidth: 80)
                        RefCell(text: row.multiplier, isHighlighted: isCurrent, minWidth: 80)
                    }
                }
            }
            .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))

            RefFootnotes(lines: [
                "Backstab requires surprise/being unseen — a successful attack from behind gets +4 to hit and this damage multiplier.",
            ])
        }
    }
}

// MARK: - Bard Spell Progression (Table 32)
//
// Dados agora vivem em `BardTables.spellProgressionRows` (Models/Character.swift)
// — canônico desde a Bard Spell Sheet de verdade (2026-09-30, "My
// Spellbook"/`computedSpellSlotAllotments`); esta view só EXIBE a mesma
// fonte, sem manter uma segunda cópia que poderia um dia divergir.

private struct BardSpellProgressionReferenceTable: View {
    let currentLevel: Int

    private static let rows: [[Int?]] = BardTables.spellProgressionRows

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                RefTableTitle(text: "Bard Spell Progression")
                RuleLinkButton(ruleID: "phb_ch03_rogue_tables")
            }

            ScrollView(.horizontal, showsIndicators: false) {
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    GridRow {
                        RefCell(text: "Lvl", isHeader: true, minWidth: 30)
                        ForEach(1...6, id: \.self) { circle in
                            RefCell(text: "\(circle)", isHeader: true, minWidth: 30)
                        }
                    }
                    ForEach(Array(Self.rows.enumerated()), id: \.offset) { offset, row in
                        let level = offset + 1
                        GridRow {
                            RefCell(text: "\(level)", isHighlighted: level == currentLevel, minWidth: 30)
                            ForEach(0..<6, id: \.self) { i in
                                RefCell(text: row[i].map(String.init) ?? "—",
                                        isHighlighted: level == currentLevel, minWidth: 30)
                            }
                        }
                    }
                }
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
            }

            RefFootnotes(lines: [
                "Bards learn wizard spells by chance, not free choice, and never gain new ones automatically on level-up — see the Bard description (PHB ch. 3) for how spells are found. Add what your character finds in play to \u{201C}My Spellbook\u{201D} (menu ☰) by hand — same manual grimoire as the Mage, no dice roll simulated.",
                "This table already drives your actual spell slots — see the Sheet page and \u{201C}My Spellbook.\u{201D}",
            ])
        }
    }
}
