import Foundation

/// Quem conjura a magia. Em AD&D 2e as listas de mago e sacerdote são
/// separadas, com mecânicas de memorização iguais mas fontes diferentes.
enum CasterType: String, Codable, CaseIterable, Identifiable {
    case arcane   // mago / ilusionista
    case divine   // clérigo / druida

    var id: String { rawValue }

    var label: String {
        switch self {
        case .arcane: return "Wizard"
        case .divine: return "Priest"
        }
    }
}

/// Dados mecânicos de uma magia, como aparecem no cabeçalho da descrição
/// no livro. O campo `summary` é um resumo próprio de uma linha, só para
/// lembrar o que a magia faz na hora do jogo.
struct Spell: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let level: Int
    let caster: CasterType
    /// Escola de magia, como no livro ("Evocation", "Enchantment/Charm").
    let school: String
    /// Tempo de conjuração — em 2e é isso que entra no cálculo de iniciativa.
    let castingTime: String
    let range: String
    let components: String
    let duration: String
    let areaOfEffect: String
    let savingThrow: String
    /// Dano ou cura por extenso, como no livro ("1d6 per level (max 10d6)").
    /// Fica intacto para a janela de descrição — quem calcula o valor do
    /// personagem é `damageDice`.
    let damage: String?
    /// Resumo de uma linha, para lembrar rápido o que a magia faz.
    let summary: String
    /// Versão estruturada de `damage`, quando dá para reduzir a um dado +
    /// bônus. É o que a tabela da folha de magias usa para mostrar o valor
    /// já calculado para o nível do conjurador, sem a legenda "Cura"/"Dmg".
    /// `nil` quando a magia não tem dano numérico (ou o texto é livre
    /// demais para modelar, como "quase todos os PV" de Heal).
    let damageDice: SpellDamage?
    /// Esferas de acesso (só faz sentido para sacerdote — ver TODO.md
    /// item 4). Vazio para magias de mago ou entradas de exemplo antigas.
    var spheres: [String] = []
    /// Texto completo da descrição, quando disponível — `summary` continua
    /// sendo o resumo curto usado no resto do app; este campo é só para a
    /// janela de detalhe (`SpellDetailSheet`).
    var fullDescription: String? = nil
    /// Cenário/ambientação pra qual a magia é indicada ou possível
    /// ("Generic", "Forgotten Realms", "Dark Sun"...). `nil` para entradas
    /// de exemplo antigas que não vêm da base real.
    var setting: String? = nil

    /// Nome normalizado usado pelo casamento aproximado da escrita à mão.
    var normalizedName: String { Fuzzy.normalize(name) }
}

/// Um dano/cura reduzido a dado + bônus, com ou sem escala por nível do
/// conjurador — o que permite a folha mostrar "10d6" em vez de "1d6 per
/// level (max 10d6)" para quem já sabe seu próprio nível.
struct SpellDamage: Codable, Hashable {
    /// Número de dados na rolagem — ou, se `scalesWithLevel`, quantos dados
    /// por nível do conjurador.
    var dice: Int
    var sides: Int
    /// Bônus fixo somado uma vez (não escala com nível).
    var bonus: Int = 0
    var scalesWithLevel: Bool = false
    /// Teto de dados quando escala por nível (ex.: bola de fogo para em
    /// 10d6 mesmo com um conjurador de nível mais alto).
    var maxDice: Int? = nil
    var isHealing: Bool = false
    /// Bônus que cresce com o nível do conjurador (diferente de `dice`
    /// escalando: aqui o DADO fica fixo, só o bônus somado sobe) — ex.:
    /// "1d3 points of damage plus 2 points per level" (Frost Fingers).
    /// Some com `bonus` (que continua sendo o valor fixo, se houver os
    /// dois ao mesmo tempo).
    var bonusPerLevel: Int = 0
    /// Teto pro bônus TOTAL já escalado (`bonusPerLevel * nível`), quando
    /// o texto original menciona um máximo explícito. `nil` = sem teto.
    var maxBonus: Int? = nil

    /// O valor já calculado para o nível do conjurador, pronto para a
    /// tabela: "10d6", "2d8 + 1", "1d4", "1d3 + 10".
    func text(casterLevel: Int) -> String {
        let count: Int
        if scalesWithLevel {
            let raw = dice * max(casterLevel, 1)
            count = min(raw, maxDice ?? raw)
        } else {
            count = dice
        }
        var totalBonus = bonus
        if bonusPerLevel > 0 {
            let scaled = bonusPerLevel * max(casterLevel, 1)
            totalBonus += min(scaled, maxBonus ?? scaled)
        }
        var text = sides > 0 ? "\(count)d\(sides)" : "\(count)"
        if totalBonus > 0 { text += " + \(totalBonus)" }
        if totalBonus < 0 { text += " - \(abs(totalBonus))" }
        return text
    }
}
