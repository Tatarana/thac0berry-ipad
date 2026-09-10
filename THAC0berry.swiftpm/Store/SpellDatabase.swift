import Foundation

/// Base de magias embutida (Resources/spells.json) mais a busca aproximada
/// usada pelo log escrito à mão.
final class SpellDatabase: ObservableObject {
    @Published private(set) var spells: [Spell] = []
    @Published private(set) var loadError: String? = nil

    init() {
        load()
    }

    private func load() {
        guard let url = Bundle.main.url(forResource: "spells", withExtension: "json") else {
            loadError = "spells.json não foi encontrado no bundle."
            return
        }
        do {
            let data = try Data(contentsOf: url)
            spells = try JSONDecoder().decode([Spell].self, from: data)
        } catch {
            loadError = "Falha ao ler spells.json: \(error.localizedDescription)"
        }
    }

    func spell(id: String) -> Spell? {
        spells.first { $0.id == id }
    }

    func spells(caster: CasterType, level: Int) -> [Spell] {
        spells
            .filter { $0.caster == caster && $0.level == level }
            .sorted { $0.name < $1.name }
    }

    /// Candidatos ordenados por semelhança com o que foi escrito.
    /// `limit` mantém a lista curta o bastante para caber ao lado da linha.
    func matches(for text: String, limit: Int = 5, minimumScore: Double = 0.34) -> [SpellMatch] {
        let query = Fuzzy.normalize(text)
        guard !query.isEmpty else { return [] }

        // Passos separados e com tipo explícito de propósito: uma cadeia
        // única de map/filter/sorted estoura o tempo de inferência do
        // compilador ("unable to type-check this expression in reasonable
        // time") no Swift Playgrounds.
        var scored: [SpellMatch] = []
        scored.reserveCapacity(spells.count)

        for spell in spells {
            let score: Double = Fuzzy.similarity(query, spell.normalizedName)
            if score >= minimumScore {
                scored.append(SpellMatch(spell: spell, score: score))
            }
        }

        scored.sort { (lhs: SpellMatch, rhs: SpellMatch) -> Bool in
            if lhs.score == rhs.score {
                return lhs.spell.name < rhs.spell.name
            }
            return lhs.score > rhs.score
        }

        if scored.count > limit {
            scored.removeLast(scored.count - limit)
        }
        return scored
    }
}

struct SpellMatch: Identifiable, Hashable {
    let spell: Spell
    let score: Double

    var id: String { spell.id }

    /// Acima disso o app se sente à vontade para pré-selecionar o candidato.
    var isStrong: Bool { score >= 0.72 }

    var confidenceLabel: String {
        switch score {
        case 0.85...: return "quase certo"
        case 0.6..<0.85: return "provável"
        default: return "palpite"
        }
    }
}
