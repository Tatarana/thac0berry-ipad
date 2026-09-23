import Foundation

/// Tabela 53 do PHB ("Calculated THAC0s") — um THAC0 direto por
/// grupo/nível, níveis 1 a 20. Os números abaixo não foram digitados de
/// memória: vieram do mesmo JSON de extração auditado que virou
/// `EmbeddedRules_Part*.swift` (ver `phb_ch09_calculating_thac0` na base
/// de regras — é o mesmo "ver regra" que este provider aponta), conferidos
/// contra a tabela renderizada na Referência de Regras antes de entrar
/// aqui.
///
/// Nível 21+ fica fora do alcance desta v1 (a Tabela 54 — Improvement
/// Rate — cobre a progressão depois do 20, mas não entrou nesta rodada);
/// `compute` devolve `nil` nesse caso e o campo simplesmente não aparece
/// como alterável na janela de consequências.
struct Thac0ByLevelProvider: RuleProvider {
    let key = "thac0"
    let label = "THAC0 by Level (Table 53)"

    private static let byGroup: [CoreClassGroup: [Int]] = [
        .priest:  [20, 20, 20, 18, 18, 18, 16, 16, 16, 14, 14, 14, 12, 12, 12, 10, 10, 10, 8, 8],
        .rogue:   [20, 20, 19, 19, 18, 18, 17, 17, 16, 16, 15, 15, 14, 14, 13, 13, 12, 12, 11, 11],
        .warrior: [20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1],
        .wizard:  [20, 20, 20, 19, 19, 19, 18, 18, 18, 17, 17, 17, 16, 16, 16, 15, 15, 15, 14, 14],
    ]

    func compute(for context: RuleContext) -> RuleValue? {
        let group = CoreClassGroup(context.characterClass)
        guard let row = Self.byGroup[group] else { return nil }
        let index = context.level - 1
        guard index >= 0, index < row.count else { return nil }
        return .int(row[index])
    }

    func sourceRuleID(for context: RuleContext) -> String? {
        "phb_ch09_calculating_thac0"
    }
}
