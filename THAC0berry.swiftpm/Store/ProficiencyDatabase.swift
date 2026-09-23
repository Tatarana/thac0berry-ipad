import Foundation

/// Base de proficiências não-de-arma — vem de `EmbeddedProficiencies.
/// entries`, literais Swift de verdade, SEM bundle/`Data`/`JSONDecoder`
/// nenhum em runtime. Mesmo motivo/mesmo padrão de `KitDatabase.swift` —
/// ver o comentário lá pro histórico completo de por que ler isso de JSON
/// de bundle não é confiável neste toolchain.
final class ProficiencyDatabase: ObservableObject {
    @Published private(set) var proficiencies: [Proficiency] = []
    /// Mantido só pra bater com o padrão das outras bases (`spellbook.
    /// loadError`/`kits.loadError`) — sempre `nil` agora que não há
    /// leitura de bundle nenhuma pra falhar.
    @Published private(set) var loadError: String? = nil

    init() {
        proficiencies = EmbeddedProficiencies.entries.sorted { $0.name < $1.name }
    }

    func proficiency(id: String) -> Proficiency? {
        proficiencies.first { $0.id == id }
    }

    /// Todos os grupos primários existentes, na ordem fixa do PHB/wiki de
    /// origem — pra agrupar a lista de consulta.
    static let groupOrder = ["General", "Priest", "Rogue", "Warrior", "Wizard", "Psionicist", "Racial / Special"]

    /// Busca aproximada por nome — mesmo padrão de `SpellDatabase.matches`:
    /// substring primeiro (o que se espera de uma busca digitada), só cai
    /// pro fuzzy se a substring não achar nada (cobre erro de digitação
    /// pequeno sem abrir a porta pra qualquer coisa parecida).
    func matches(for query: String, limit: Int = 20) -> [Proficiency] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return [] }
        let normalizedQuery = Fuzzy.normalize(trimmed)
        guard !normalizedQuery.isEmpty else { return [] }

        let substringMatches = proficiencies.filter {
            Fuzzy.normalize($0.name).contains(normalizedQuery)
        }
        if !substringMatches.isEmpty { return Array(substringMatches.prefix(limit)) }

        let scored = proficiencies
            .map { ($0, Fuzzy.similarity(normalizedQuery, Fuzzy.normalize($0.name))) }
            .filter { $0.1 >= 0.55 }
            .sorted { $0.1 > $1.1 }
        return scored.prefix(limit).map(\.0)
    }
}
