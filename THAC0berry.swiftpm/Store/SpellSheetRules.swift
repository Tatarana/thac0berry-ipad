import Foundation

/// Regra única de "começar um dia novo de magias" (Lote 1 do inventário,
/// `Docs/inventario-regras-nas-telas.md`, item A3). Antes existia em 5
/// cópias espalhadas pelas telas, e só uma delas (o "+" de dia novo)
/// herdava as preparações do dia anterior. Decisão do usuário
/// (2026-10-04): todo dia novo herda do dia anterior — é o que o jogador
/// faz na mesa ao repousar e repreparar a partir do que tinha ontem.
extension PlayerCharacter {

    /// Cria e anexa a folha de um dia novo e devolve o id dela.
    ///
    /// - `continuingFrom`: o "dia anterior" de onde herdar. `nil` = a folha
    ///   mais recente do personagem com data até `date` (ou até agora). Sem
    ///   nenhuma folha anterior, nasce uma grade em branco do tamanho atual.
    /// - Herdar = `SpellSheet.nextDay(keepingPreparations: true)`: mesmas
    ///   magias memorizadas, slots desmarcados, registro do dia vazio, itens
    ///   mágicos com cargas zeradas — e a grade ajustada à tabela de slots
    ///   de HOJE (nível, atributo ou CLASSE podem ter mudado desde ontem).
    /// - Troca de classe: folhas existentes nunca são alteradas (decisão do
    ///   usuário, 2026-10-05). A primeira folha nova depois da troca herda
    ///   do dia anterior e o ajuste à tabela troca os slots do tipo antigo
    ///   (ex.: divinos de Clérigo) por slots vazios do tipo novo (arcanos).
    @discardableResult
    mutating func startSpellSheet(sessionID: UUID,
                                  title: String,
                                  date: Date? = nil,
                                  continuingFrom previous: SpellSheet? = nil) -> UUID {
        let day = date ?? Date()
        let source = previous ?? spellSheets
            .filter { $0.date <= day }
            .max(by: { $0.date < $1.date })

        var sheet: SpellSheet
        if let source {
            sheet = source.nextDay(keepingPreparations: true)
            sheet.slotBoard = sheet.slotBoard.reconciled(with: computedSpellSlotAllotments)
        } else {
            sheet = SpellSheet()
            sheet.slotBoard = freshSlotBoard()
        }
        sheet.sessionID = sessionID
        sheet.title = title
        if let date { sheet.date = date }
        // Congela o atributo que decide os slots (Sabedoria/Inteligência,
        // conforme a classe) no valor de hoje — vale pra esse dia mesmo
        // que o personagem mude depois.
        sheet.wisdomAtCreation = spellSheetAbilityScoreAtCreation
        spellSheets.append(sheet)
        return sheet.id
    }
}

extension SpellSlotBoard {

    /// Ajusta uma grade herdada do dia anterior para bater com a tabela da
    /// ficha: aumenta ou diminui a contagem de cada círculo (`setCount`
    /// preserva o que estava preparado quando um nível encolhe) e zera
    /// círculos que saíram da tabela por completo. (Movido de
    /// `CharacterSheetView`, onde era privado.)
    func reconciled(with allotments: [SpellSlotAllotment]) -> SpellSlotBoard {
        struct Key: Hashable {
            let caster: CasterType
            let level: Int
        }
        var result = self
        var covered = Set<Key>()

        for allotment in allotments {
            covered.insert(Key(caster: allotment.caster, level: allotment.level))
            result.setCount(allotment.count, level: allotment.level, caster: allotment.caster)
        }

        let existing = Set(result.slots.map { Key(caster: $0.caster, level: $0.level) })
        for pair in existing where !covered.contains(pair) {
            result.setCount(0, level: pair.level, caster: pair.caster)
        }

        return result
    }
}
