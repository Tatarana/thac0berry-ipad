import Foundation

/// Base de magias embutida mais a busca aproximada usada pelo log escrito
/// à mão.
///
/// A base fica espalhada em duas fontes bem diferentes de propósito.
/// O punhado de exemplos usado por `SampleCharacter` (o personagem Kelmon
/// pré-carregado) vem de `EmbeddedSampleSpells.spells` — literais Swift de
/// verdade, sem JSON nenhum de permeio (ver o comentário grande naquele
/// arquivo: um bug de campo em duas partes — primeiro `spells.json` do
/// bundle, depois até uma versão embutida como STRING JSON gigante, as
/// duas dando "The data couldn't be read because it is missing"). A base
/// de verdade de sacerdote continua entrando aos poucos em arquivos
/// `priest_*.json` no bundle — um por nível/tipo, no formato que
/// `Scripts/convert_spells.py` gera a partir dos dados brutos da wiki (ver
/// TODO.md item 1) — esses sempre carregaram sem problema, confirmado
/// pelo contador de diagnóstico que a mensagem de erro passou a mostrar.
final class SpellDatabase: ObservableObject {
    @Published private(set) var spells: [Spell] = []
    @Published private(set) var loadError: String? = nil

    init() {
        load()
    }

    private func load() {
        var merged: [Spell] = []
        var seenIDs: Set<String> = []
        var errors: [String] = []

        // Exemplos do Kelmon primeiro — igual antes, prioridade no merge
        // abaixo (nenhum id da base real de sacerdote sobrescreve um
        // exemplo igual). Literais Swift, sem JSON nem bundle nenhum no
        // meio — nada aqui pode falhar em runtime.
        for spell in EmbeddedSampleSpells.spells {
            guard !seenIDs.contains(spell.id) else { continue }
            seenIDs.insert(spell.id)
            merged.append(spell)
        }

        for file in priestFiles() {
            do {
                let data = try Data(contentsOf: file.url)
                let batch = try JSONDecoder().decode([Spell].self, from: data)
                for spell in batch {
                    guard !seenIDs.contains(spell.id) else { continue }
                    seenIDs.insert(spell.id)
                    merged.append(spell)
                }
            } catch {
                errors.append("Failed to read \(file.name).json: \(error.localizedDescription)")
            }
        }

        spells = merged
        if errors.isEmpty {
            loadError = nil
        } else {
            // Só sobra erro aqui se algum `priest_*.json` do bundle falhar
            // pra ler ou decodificar — os exemplos do Kelmon não passam
            // mais por leitura nenhuma (literais Swift, ver
            // `EmbeddedSampleSpells.swift`). A versão/build entra junto na
            // mensagem: ajudou a confirmar, na rodada anterior desse bug,
            // que o build testado era mesmo o mais novo — vale manter.
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
            let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
            let priestCount = priestFiles().count
            loadError = errors.joined(separator: " ")
                + " [running build \(version) (\(build)), \(priestCount) priest file(s) found]"
        }
    }

    /// Nome + URL de todo `priest_*.json` no bundle — achados numa
    /// varredura de `FileManager.default.contentsOfDirectory` e lidos
    /// dessa MESMA URL depois (em vez de descobrir o nome de um jeito e
    /// pedir a URL de novo por outro caminho, como o código fazia antes —
    /// ver histórico do bug em `EmbeddedSampleSpells.swift`).
    private func priestFiles() -> [(name: String, url: URL)] {
        guard let resourceURL = Bundle.main.resourceURL,
              let entries = try? FileManager.default.contentsOfDirectory(at: resourceURL,
                                                                          includingPropertiesForKeys: nil)
        else { return [] }

        // `uniquingKeysWith` em vez de `uniqueKeysWithValues`: nomes
        // duplicados não deveriam existir dentro do mesmo diretório, mas
        // não vale a pena travar o app inteiro (fatal error) se algum
        // cenário esquisito de build do Playgrounds produzir um.
        let byName = Dictionary(entries
            .filter { $0.pathExtension == "json" && $0.deletingPathExtension().lastPathComponent.hasPrefix("priest_") }
            .map { ($0.deletingPathExtension().lastPathComponent, $0) },
            uniquingKeysWith: { first, _ in first })

        return byName.keys.sorted().compactMap { name in byName[name].map { (name, $0) } }
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
    ///
    /// `caster`/`level`, quando informados, filtram a base ANTES de cortar
    /// pelo `limit` — não depois. Cortar primeiro e filtrar depois (como
    /// era) deixava um slot de círculo 1 sem nenhum candidato só porque as
    /// 5 magias mais parecidas do app inteiro eram todas de outros
    /// círculos (ex.: escrever "cure" no círculo 1 - "Cure Light Wounds" -
    /// esbarrava em "Cure Rot"/"Cure Scurvy"/"Cure Madness", todas de
    /// círculos mais altos e com nome mais parecido letra a letra,
    /// tomando as 5 vagas antes do filtro por círculo/classe rodar).
    func matches(for text: String, limit: Int = 5, minimumScore: Double = 0.34,
                 caster: CasterType? = nil, level: Int? = nil) -> [SpellMatch] {
        let query = Fuzzy.normalize(text)
        guard !query.isEmpty else { return [] }

        // Passos separados e com tipo explícito de propósito: uma cadeia
        // única de map/filter/sorted estoura o tempo de inferência do
        // compilador ("unable to type-check this expression in reasonable
        // time") no Swift Playgrounds.
        var scored: [SpellMatch] = []
        scored.reserveCapacity(spells.count)

        for spell in spells {
            if let caster, spell.caster != caster { continue }
            if let level, spell.level != level { continue }
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
        case 0.85...: return "near match"
        case 0.6..<0.85: return "likely"
        default: return "guess"
        }
    }
}
