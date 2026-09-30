import SwiftUI

/// A 4ª página da aba Sheet pro grupo Warrior (Fighter/Paladin/Ranger) —
/// item 6 do feedback do usuário (2026-09-30: "não tem página de tabelas
/// úteis pro Warrior"). Mesmo espírito de `ClericReferenceView.swift`/
/// `WizardReferenceView.swift` (as peças `RefTableTitle`/`RefCell`/
/// `RefFootnotes` vêm de lá, sem duplicar): consulta pura, nenhum campo
/// editável — os dados de verdade da ficha (classe, nível) só destacam a
/// linha/coluna que importa.
///
/// THAC0 e Saving Throws já são calculados sozinhos pra QUALQUER classe
/// (ver `ConsequenceEngine.refreshLevelChanges`, seção "Level Changes" da
/// página 2) — não duplicados aqui. O que faltava mesmo era a Tabela 34
/// (slots de proficiência de arma + penalidade de não-proficiência) e um
/// resumo consultável de Weapon Specialization, que hoje só existe como
/// nota de rodapé em cima da tabela de armas.
struct WarriorReferencePage: View {
    let character: PlayerCharacter

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Warrior Reference Tables")
                .font(Paper.printed(15))
                .tracking(1.6)
                .foregroundStyle(Paper.ink)
                .frame(maxWidth: .infinity, alignment: .center)

            ProficiencySlotsReferenceTable(characterClass: character.characterClass)
            WeaponSpecializationCard(characterClass: character.characterClass)
        }
        .padding(16)
        .background(Color.white.opacity(0.4))
        .overlay(Rectangle().stroke(Paper.ink, lineWidth: 2))
    }
}

// MARK: - Tabela 34: Proficiency Slots

private struct ProficiencySlotsReferenceTable: View {
    let characterClass: CharacterClass

    private var currentGroup: String { ProficiencySlotsTable.group(for: characterClass) }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                RefTableTitle(text: "Proficiency Slots (Table 34)")
                RuleLinkButton(ruleID: "phb_ch05_proficiencies")
            }

            ScrollView(.horizontal, showsIndicators: false) {
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    GridRow {
                        RefCell(text: "Group", isHeader: true, minWidth: 64, alignment: .leading)
                        RefCell(text: "Initial\n(Weapon)", isHeader: true, minWidth: 54)
                        RefCell(text: "+1 every\n(levels)", isHeader: true, minWidth: 54)
                        RefCell(text: "Non-prof.\npenalty", isHeader: true, minWidth: 58)
                        RefCell(text: "Initial\n(Nonweapon)", isHeader: true, minWidth: 62)
                        RefCell(text: "+1 every\n(levels)", isHeader: true, minWidth: 54)
                    }
                    ForEach(ProficiencySlotsTable.rows, id: \.group) { row in
                        let isCurrent = row.group == currentGroup
                        GridRow {
                            RefCell(text: row.group, isHighlighted: isCurrent, minWidth: 64, alignment: .leading)
                            RefCell(text: row.initialWeapon, isHighlighted: isCurrent, minWidth: 54)
                            RefCell(text: row.levelsWeapon, isHighlighted: isCurrent, minWidth: 54)
                            RefCell(text: row.penalty, isHighlighted: isCurrent, minWidth: 58)
                            RefCell(text: row.initialNonweapon, isHighlighted: isCurrent, minWidth: 62)
                            RefCell(text: row.levelsNonweapon, isHighlighted: isCurrent, minWidth: 54)
                        }
                    }
                }
                .overlay(Rectangle().stroke(Paper.ink, lineWidth: 1.2))
            }

            RefFootnotes(lines: [
                "\"Group\" bundles the 8 classes into the 4 archetypes the table uses — Paladin/Ranger read the Fighter row, Druid reads Cleric, Bard reads Thief.",
                "Related weapon (same family, e.g. long sword/broad sword): penalty is halved, rounded up — a Fighter's -2 becomes -1, a Wizard's -5 becomes -3.",
            ])
        }
    }
}

// MARK: - Weapon Specialization

private struct WeaponSpecializationCard: View {
    let characterClass: CharacterClass
    private var isFighter: Bool { characterClass == .fighter }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                RefTableTitle(text: "Weapon Specialization")
                RuleLinkButton(ruleID: "cfh_ch04_weapon_proficiency_slots")
            }

            VStack(alignment: .leading, spacing: 6) {
                SpecRow(label: "Who", value: isFighter
                        ? "Your class (Fighter) — eligible."
                        : "Fighters only — never Paladins or Rangers, even though they share this page.")
                SpecRow(label: "Melee", value: "1 extra proficiency slot → +1 to hit, +2 damage.")
                SpecRow(label: "Bow / crossbow", value: "2 extra slots → no damage bonus; instead, a \"point-blank\" range (crossbow 6–30ft, bow 6–60ft) with +2 to hit inside it, and the weapon can fire before initiative is rolled if it's ready and a target is in sight.")
                SpecRow(label: "Limit", value: "Only one specialization at character creation — more later, as new slots are gained.")
            }
        }
    }
}

private struct SpecRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(label.uppercased())
                .font(Paper.printed(9.5))
                .tracking(0.6)
                .foregroundStyle(Paper.inkSoft)
                .frame(width: 92, alignment: .leading)
            Text(value)
                .font(Paper.printed(11.5))
                .foregroundStyle(Paper.ink)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
