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
    ///   de HOJE (nível ou atributo podem ter mudado desde ontem).
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

    /// Troca de classe que muda o TIPO de magia (Clérigo ↔ Mago/Bardo):
    /// a folha do dia atual (a mais recente) ganha uma grade em branco da
    /// classe nova. Sem isso, um personagem que passou por Clérigo e virou
    /// Mago ficava com slots divinos — oferecendo magias de sacerdote e o
    /// bloco de Turn Undead numa "Mage Spell Sheet" (achado no teste da
    /// v1.99.3). Decisão do usuário (2026-10-05): só a folha atual; dias
    /// passados ficam como registro histórico. O registro de conjurações
    /// da folha é mantido. Mago ↔ Bardo (os dois arcanos) não mexe em nada.
    ///
    /// Devolve `true` se a folha foi refeita.
    @discardableResult
    mutating func realignCurrentSpellSheetToClass() -> Bool {
        guard characterClass.hasSpellSheet, let index = currentSheetIndex else { return false }
        let expected: CasterType = characterClass.isArcaneCaster ? .arcane : .divine
        guard spellSheets[index].slotBoard.casters().contains(where: { $0 != expected }) else { return false }
        spellSheets[index].slotBoard = freshSlotBoard()
        spellSheets[index].wisdomAtCreation = spellSheetAbilityScoreAtCreation
        return true
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
