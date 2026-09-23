import Foundation

/// Base de regras embutida (PHB + DMG + CPrH, 385 entradas / ~202 tabelas) — mesmo
/// padrão de `KitDatabase`/`SpellDatabase`: `EmbeddedRules.entries` já são
/// literais Swift compilados (ver `EmbeddedRules_Part1.swift`...`Part20.swift`
/// e o comentário em `Rule.swift`), então não há nada pra falhar em
/// runtime — `loadError` fica sempre `nil`, mantido só pra bater com o
/// padrão das outras databases caso uma fonte externa entre no futuro.
final class RulesDatabase: ObservableObject {
    @Published private(set) var entries: [RuleEntry] = []
    @Published private(set) var loadError: String? = nil

    init() {
        entries = EmbeddedRules.entries
    }

    func entry(id: String) -> RuleEntry? {
        entries.first { $0.id == id }
    }

    /// Todas as entradas de um capítulo específico, na ordem em que
    /// aparecem no array embutido (que já segue a ordem do livro).
    func entries(book: String, chapter: Int) -> [RuleEntry] {
        entries.filter { $0.book == book && $0.chapterNumber == chapter }
    }

    /// Capítulos únicos por livro, na ordem de primeira aparição — usado
    /// pra montar as seções da lista de navegação sem duplicar cabeçalhos.
    func chapters(book: String) -> [(number: Int, title: String)] {
        var seen: Set<Int> = []
        var result: [(number: Int, title: String)] = []
        for entry in entries where entry.book == book {
            if !seen.contains(entry.chapterNumber) {
                seen.insert(entry.chapterNumber)
                result.append((entry.chapterNumber, entry.chapterTitle))
            }
        }
        return result
    }

    /// Candidatos ordenados por semelhança com o texto buscado — mesma
    /// técnica de `SpellDatabase.matches`: passos separados com tipo
    /// explícito pra não estourar o tempo de inferência do type-checker.
    /// Compara contra `topic`, `summary` e `searchKeywords` (o `content`
    /// completo entraria no ruído — prosa longa combina com quase tudo).
    func matches(for text: String, limit: Int = 30, minimumScore: Double = 0.3,
                 book: String? = nil) -> [RuleMatch] {
        let query = Fuzzy.normalize(text)
        guard !query.isEmpty else { return [] }

        var scored: [RuleMatch] = []
        scored.reserveCapacity(entries.count)

        for entry in entries {
            if let book, entry.book != book { continue }

            let topicScore: Double = Fuzzy.similarity(query, Fuzzy.normalize(entry.topic))
            var keywordScore: Double = 0
            for keyword in entry.searchKeywords {
                let s: Double = Fuzzy.similarity(query, Fuzzy.normalize(keyword))
                if s > keywordScore { keywordScore = s }
            }
            let best: Double = max(topicScore, keywordScore)
            if best >= minimumScore {
                scored.append(RuleMatch(entry: entry, score: best))
            }
        }

        scored.sort { (lhs: RuleMatch, rhs: RuleMatch) -> Bool in
            if lhs.score == rhs.score {
                return lhs.entry.topic < rhs.entry.topic
            }
            return lhs.score > rhs.score
        }

        if scored.count > limit {
            scored.removeLast(scored.count - limit)
        }
        return scored
    }
}

struct RuleMatch: Identifiable, Hashable {
    let entry: RuleEntry
    let score: Double

    var id: String { entry.id }
}
