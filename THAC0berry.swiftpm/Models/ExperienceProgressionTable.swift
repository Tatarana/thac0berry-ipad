import Foundation

/// Tabela de XP acumulado por nível, por classe — pedido do usuário
/// (2026-09-22, item 4 do lote): "em XP needed for the next level, podemos
/// preencher automaticamente, dado que sabemos esta tabela por classe,
/// certo?". Copiada literalmente das 4 tabelas de progressão já
/// embutidas no corpus de regras (`Store/EmbeddedRules_Part14.swift`/
/// `Part15.swift`) — não é dado novo nem inventado, é a MESMA fonte que já
/// alimenta a consulta de regras (Table 14: Warrior Experience Levels,
/// Table 20: Wizard Experience Levels, Table 23: Priest Experience Levels,
/// Table 25: Rogue Experience Levels — conferidas linha a linha, 20 níveis
/// cada, batendo `headers.count`/`row.count` antes de copiar, seguindo a
/// regra do projeto de nunca inventar dado de regra). Guardada aqui como
/// constante Swift (em vez de reler o `RuleTable` em texto toda vez) só
/// pra não depender de parsing de string pra um cálculo que roda toda hora
/// que o jogador muda de nível/classe.
enum ExperienceProgressionTable {
    /// XP acumulado necessário pra alcançar cada nível, 1 a 20 (índice 0 =
    /// nível 1 = sempre 0). Fighter/Paladin/Ranger vêm de Table 14 (Paladin
    /// e Ranger dividem a mesma coluna "Paladin/Ranger" no PHB); Mage tem
    /// coluna própria em Table 20 ("Mage/Specialist", que também cobre
    /// Illusionist e os outros especialistas — não há classe Illusionist
    /// separada no app hoje); Cleric/Druid vêm de Table 23, cada um com
    /// coluna própria; Thief/Bard dividem a única coluna de Table 25 ("XP
    /// needed").
    private struct ClassNote: Decodable {
        let fromLevel: Int
        let text: String
    }

    private struct Table: Decodable {
        let thresholds: [String: [Int]]
        let classNotes: [String: ClassNote]?
    }

    /// Os limiares de XP vivem em `Resources/rules_experience.json`
    /// (chave = `CharacterClass.rawValue`, índice 0 = nível 1).
    private static let table: Table? =
        BundleJSON.loadObject(Table.self, file: "rules_experience.json").value

    static func xpRequired(for level: Int, class characterClass: CharacterClass) -> Int? {
        guard level >= 1, level <= 20, let row = table?.thresholds[characterClass.rawValue], row.count >= level else { return nil }
        return row[level - 1]
    }

    /// String pronta pro campo "XP needed for next level" — XP pro PRÓXIMO
    /// nível (`level + 1`), formatada com separador de milhar igual o
    /// resto da tabela do PHB ("2,000"). `nil` quando o próximo nível já
    /// passa de 20 (jogador preenche à mão dali pra frente, igual sempre
    /// foi).
    static func xpNeededForNextLevel(currentLevel: Int, class characterClass: CharacterClass) -> String? {
        guard let xp = xpRequired(for: currentLevel + 1, class: characterClass) else { return nil }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: xp)) ?? "\(xp)"
    }

    /// Observação do livro sobre a progressão da classe (ex.: Druida
    /// hierofante a partir do 16º nível), vinda do JSON; `nil` quando não
    /// há nota pra essa classe/nível.
    static func note(for characterClass: CharacterClass, level: Int) -> String? {
        guard let note = table?.classNotes?[characterClass.rawValue], level >= note.fromLevel else { return nil }
        return note.text
    }
}
