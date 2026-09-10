import Foundation

/// Casamento aproximado de texto. A escrita à mão erra — "Magic Missile"
/// vira "Magic Missle", "Mogic Missile", "MagicMissile" — então o app nunca
/// exige acerto exato: ele ordena os candidatos por semelhança e deixa a
/// confirmação com você.
enum Fuzzy {

    /// Minúsculas, sem acento, sem pontuação, espaços colapsados.
    static func normalize(_ text: String) -> String {
        let folded: String = text.folding(
            options: [.diacriticInsensitive, .caseInsensitive],
            locale: Locale(identifier: "en_US")
        )

        var cleaned = ""
        cleaned.reserveCapacity(folded.count)
        for character in folded {
            if character.isLetter || character.isNumber {
                cleaned.append(character)
            } else {
                cleaned.append(" ")
            }
        }

        let words: [Substring] = cleaned.split(separator: " ", omittingEmptySubsequences: true)
        return words.joined(separator: " ")
    }

    /// Distância de edição clássica, com duas linhas em vez da matriz inteira.
    static func levenshtein(_ lhs: [Character], _ rhs: [Character]) -> Int {
        if lhs.isEmpty { return rhs.count }
        if rhs.isEmpty { return lhs.count }

        var previous = Array(0...rhs.count)
        var current = [Int](repeating: 0, count: rhs.count + 1)

        for i in 1...lhs.count {
            current[0] = i
            for j in 1...rhs.count {
                let cost = lhs[i - 1] == rhs[j - 1] ? 0 : 1
                current[j] = min(
                    previous[j] + 1,        // remoção
                    current[j - 1] + 1,     // inserção
                    previous[j - 1] + cost  // substituição
                )
            }
            swap(&previous, &current)
        }
        return previous[rhs.count]
    }

    /// Semelhança de 0 a 1 entre dois textos já normalizados.
    static func similarity(_ lhs: String, _ rhs: String) -> Double {
        if lhs == rhs { return 1 }
        if lhs.isEmpty || rhs.isEmpty { return 0 }

        let a = Array(lhs), b = Array(rhs)
        let distance = levenshtein(a, b)
        let base = Double(max(a.count, b.count))
        var score = 1 - Double(distance) / base

        // Escrever só o começo do nome é comum na mesa ("mag mis"), então
        // prefixo e substring valem um empurrão — exclusivos entre si e só a
        // partir de três letras, senão "s" viraria "Sleep" com alta confiança.
        if lhs.count >= 3 {
            if rhs.hasPrefix(lhs) || lhs.hasPrefix(rhs) {
                score += 0.15
            } else if rhs.contains(lhs) || lhs.contains(rhs) {
                score += 0.10
            }
        }

        // Iniciais das palavras: "mm" acha "Magic Missile".
        let initials = rhs.split(separator: " ").compactMap(\.first)
        if initials.count > 1, String(initials) == lhs {
            score = max(score, 0.90)
        }

        return min(score, 1)
    }
}
