import Foundation

/// Base de magias embutida mais a busca aproximada usada pelo log escrito
/// à mão.
///
/// A base fica espalhada em vários arquivos JSON em vez de um só
/// `spells.json` gigante: `spells.json` continua com o punhado de exemplo
/// (usado por `SampleCharacter`), e a base real de sacerdote entra aos
/// poucos em arquivos `priest_*.json` — um por nível/tipo, no formato que
/// `Scripts/convert_spells.py` gera a partir dos dados brutos da wiki (ver
/// TODO.md item 1). Todo arquivo cujo nome comece com "priest" ou
/// "spells" no bundle é carregado e somado num array só.
final class SpellDatabase: ObservableObject {
    @Published private(set) var spells: [Spell] = []
    @Published private(set) var loadError: String? = nil

    init() {
        load()
    }

    private func load() {
        let names = ["spells"] + priestFileNames()
        var merged: [Spell] = []
        var seenIDs: Set<String> = []
        var errors: [String] = []

        for name in names {
            guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
                if name == "spells" { errors.append("spells.json não foi encontrado no bundle.") }
                continue
            }
            do {
                let data = try Data(contentsOf: url)
                let batch = try JSONDecoder().decode([Spell].self, from: data)
                for spell in batch {
                    // Em caso de id repetido entre arquivos, o primeiro
                    // arquivo carregado vence — spells.json (os exemplos de
                    // Kelmon) sempre entra primeiro na lista `names` acima,
                    // então ele nunca é sobrescrito por um id igual vindo
                    // da base real.
                    guard !seenIDs.contains(spell.id) else { continue }
                    seenIDs.insert(spell.id)
                    merged.append(spell)
                }
            } catch {
                errors.append("Falha ao ler \(name).json: \(error.localizedDescription)")
            }
        }

        spells = merged
        loadError = errors.isEmpty ? nil : errors.joined(separator: " ")
    }

    /// Nomes (sem extensão) de todo `priest_*.json` presente no bundle,
    /// em ordem alfabética — assim a lista cresce sozinha conforme mais
    /// arquivos da base real forem adicionados ao projeto, sem precisar
    /// tocar neste arquivo de novo.
    private func priestFileNames() -> [String] {
        guard let resourceURL = Bundle.main.resourceURL,
              let entries = try? FileManager.default.contentsOfDirectory(at: resourceURL,
                                                                          includingPropertiesForKeys: nil)
        else { return [] }

        return entries
            .filter { $0.pathExtension == "json" && $0.deletingPathExtension().lastPathComponent.hasPrefix("priest_") }
            .map { $0.deletingPathExtension().lastPathComponent }
            .sorted()
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
