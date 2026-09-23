import Foundation

/// O agrupamento "Warrior / Wizard / Priest / Rogue" que as tabelas de
/// progressão do PHB usam (Tabela 53 — THAC0, Tabela 60 — Saving Throws)
/// em vez da classe específica do personagem. Compartilhado pelos dois
/// providers que dependem dele — evita duas cópias do mesmo mapeamento
/// divergindo silenciosamente se uma classe nova entrar no app.
enum CoreClassGroup: String, Hashable {
    case warrior = "Warrior"
    case wizard = "Wizard"
    case priest = "Priest"
    case rogue = "Rogue"

    /// Fighter/Paladin/Ranger → Warrior; Mage → Wizard; Cleric/Druid →
    /// Priest; Thief/Bard → Rogue — o agrupamento padrão do livro.
    init(_ characterClass: CharacterClass) {
        switch characterClass {
        case .fighter, .paladin, .ranger:
            self = .warrior
        case .mage:
            self = .wizard
        case .cleric, .druid:
            self = .priest
        case .thief, .bard:
            self = .rogue
        }
    }
}
