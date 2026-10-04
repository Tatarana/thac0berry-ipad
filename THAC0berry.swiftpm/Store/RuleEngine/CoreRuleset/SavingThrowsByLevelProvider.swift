import Foundation

/// Tabela 60 do PHB ("Character Saving Throws"): as cinco jogadas de
/// proteção por grupo e faixa de nível. Os números vivem em
/// `Resources/rules_saving_throws.json`; `maxLevel` nulo = faixa "N+".
struct SavingThrowsByLevelProvider: RuleProvider {
    let key = "savingThrows"
    let label = "Saving Throws by Level (Table 60)"

    private struct Values: Decodable {
        let paralyzationPoisonDeath: Int
        let rodStaffWand: Int
        let petrificationPolymorph: Int
        let breathWeapon: Int
        let spell: Int
    }

    private struct Row: Decodable {
        let maxLevel: Int?
        let values: Values
    }

    private struct Table: Decodable {
        let sourceRuleID: String
        let groups: [String: [Row]]
    }

    private static let table: Table? =
        BundleJSON.loadObject(Table.self, file: "rules_saving_throws.json").value

    func compute(for context: RuleContext) -> RuleValue? {
        let group = CoreClassGroup(context.characterClass)
        guard let rows = Self.table?.groups[group.rawValue] else { return nil }
        guard context.level >= 1 else { return nil }
        guard let row = rows.first(where: { context.level <= ($0.maxLevel ?? Int.max) }) else { return nil }
        let v = row.values
        return .savingThrows(SavingThrows(paralyzationPoisonDeath: v.paralyzationPoisonDeath,
                                          rodStaffWand: v.rodStaffWand,
                                          petrificationPolymorph: v.petrificationPolymorph,
                                          breathWeapon: v.breathWeapon,
                                          spell: v.spell))
    }

    func sourceRuleID(for context: RuleContext) -> String? {
        Self.table?.sourceRuleID
    }
}
