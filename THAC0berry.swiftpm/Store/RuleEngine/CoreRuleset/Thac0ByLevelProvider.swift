import Foundation

/// THAC0 por grupo e nível (Tabela 53 do PHB). Os números vivem em
/// `Resources/rules_thac0.json` (índice 0 = nível 1) — aqui só a lógica.
struct Thac0ByLevelProvider: RuleProvider {
    let key = "thac0"
    let label = "THAC0 by Level (Table 53)"

    private struct Table: Decodable {
        let sourceRuleID: String
        let groups: [String: [Int]]
    }

    private static let table: Table? =
        BundleJSON.loadObject(Table.self, file: "rules_thac0.json").value

    func compute(for context: RuleContext) -> RuleValue? {
        let group = CoreClassGroup(context.characterClass)
        guard let row = Self.table?.groups[group.rawValue] else { return nil }
        let index = context.level - 1
        guard index >= 0, index < row.count else { return nil }
        return .int(row[index])
    }

    func sourceRuleID(for context: RuleContext) -> String? {
        Self.table?.sourceRuleID
    }
}
