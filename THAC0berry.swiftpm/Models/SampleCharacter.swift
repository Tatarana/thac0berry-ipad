import Foundation

/// Personagem de exemplo carregado na primeira execução, para as folhas
/// nunca aparecerem vazias. Kelmon é um clérigo humano de 11º nível.
///
/// Os números seguem as tabelas de sacerdote de AD&D 2e: THAC0 14 (níveis
/// 10-12), jogadas de proteção da faixa 10-12, e magias 5/4/4/3/2/1 pelo
/// nível mais 2/2/1 de bônus por Sabedoria 17 — total 7/6/5/3/2/1.
extension PlayerCharacter {

    static func kelmon() -> PlayerCharacter {
        var kelmon = PlayerCharacter()
        kelmon.name = "Kelmon"
        kelmon.playerName = "Fernando"
        kelmon.race = "Humano"
        kelmon.characterClass = .cleric
        kelmon.level = 11
        kelmon.alignment = "Leal e Bom"
        kelmon.deity = "Torm"
        kelmon.sex = "M"
        kelmon.age = "41"
        kelmon.height = "1,78"
        kelmon.weight = "82 kg"
        kelmon.hair = "Grisalhos"
        kelmon.eyes = "Castanhos"
        kelmon.movement = 9

        kelmon.abilities = AbilityScores(
            strength: 14,
            exceptionalStrength: nil,
            dexterity: 12,
            constitution: 15,
            intelligence: 11,
            wisdom: 17,
            charisma: 15
        )

        kelmon.saves = SavingThrows(
            paralyzationPoisonDeath: 6,
            rodStaffWand: 10,
            petrificationPolymorph: 9,
            breathWeapon: 12,
            spell: 11
        )

        kelmon.hitPointsMax = 63
        kelmon.hitPointsCurrent = 47
        kelmon.armorClass = 0
        kelmon.armorRating = "3"
        kelmon.shieldRating = "−2"
        kelmon.thac0 = 14
        kelmon.experience = 712_450

        kelmon.details = kelmonDetails()

        kelmon.weapons = [
            WeaponEntry(name: "Maça +2", attacks: "1", thac0: "12",
                        damageSmall: "1d6+3", damageLarge: "1d6+3", range: "—"),
            WeaponEntry(name: "Funda", attacks: "1", thac0: "14",
                        damageSmall: "1d4", damageLarge: "1d4", range: "5/10/20")
        ]

        kelmon.equipment = [
            EquipmentItem(name: "Cota de placas", note: "50"),
            EquipmentItem(name: "Escudo grande +1", note: "10"),
            EquipmentItem(name: "Símbolo sagrado de prata", note: "1"),
            EquipmentItem(name: "Poção de cura ×2", note: "2"),
            EquipmentItem(name: "Mochila, corda, tochas", note: "14"),
            EquipmentItem(name: "Rações de viagem (5 dias)", note: "5")
        ]

        kelmon.weaponProficiencies = ["Maça", "Funda", "Martelo de guerra"]

        kelmon.skills = [
            EquipmentItem(name: "Religião", note: "Sab 17"),
            EquipmentItem(name: "Cura", note: "Sab 15"),
            EquipmentItem(name: "Herbalismo", note: "Int 10"),
            EquipmentItem(name: "Leitura e escrita", note: "Int 12"),
            EquipmentItem(name: "Etiqueta", note: "Car 15")
        ]

        kelmon.languages = ["Comum", "Élfico"]
        kelmon.magicItems = ["Maça +2", "Escudo grande +1",
                             "Periapto de proteção contra veneno"]
        kelmon.allies = ["Dorn, guerreiro — companheiro de estrada",
                         "Irmã Ivet, acólita"]

        kelmon.treasure = Treasure(platinum: 3, gold: 214, electrum: 18,
                                   silver: 40, copper: 65)

        kelmon.spellSlotAllotments = kelmonPreparation.map { level, spellIDs in
            SpellSlotAllotment(caster: .divine, level: level, count: spellIDs.count)
        }
        kelmon.spellSheets = [kelmonYesterday(), kelmonToday()]
        return kelmon
    }

    // MARK: - Ajustes de atributo já preenchidos

    private static func kelmonDetails() -> AbilityDetails {
        var details = AbilityDetails()
        details.strengthHit = "0"
        details.strengthDamage = "0"
        details.strengthWeight = "55"
        details.strengthMaxPress = "170"
        details.strengthDoors = "8"
        details.strengthBars = "7%"

        details.dexterityReaction = "0"
        details.dexterityMissile = "0"
        details.dexterityDefense = "0"

        details.constitutionHP = "+1"
        details.constitutionShock = "90%"
        details.constitutionResurrection = "94%"
        details.constitutionPoison = "0"

        details.intelligenceLanguages = "2"
        details.intelligenceMaxLevel = "5º"
        details.intelligenceLearn = "45%"
        details.intelligenceMaxPerLevel = "7"

        details.wisdomDefense = "+3"
        details.wisdomFailure = "0%"
        details.wisdomBonusSpells = "+2 / +2 / +1"

        details.charismaHenchmen = "7"
        details.charismaLoyalty = "+15%"
        details.charismaReaction = "+3"
        return details
    }

    // MARK: - Folhas de magia

    /// Quantidade de slots por círculo e a lista memorizada do dia.
    private static let kelmonPreparation: [(Int, [String])] = [
        (1, ["pri1-bless", "pri1-cure-light-wounds", "pri1-cure-light-wounds",
             "pri1-command", "pri1-sanctuary", "pri1-detect-magic", "pri1-light"]),
        (2, ["pri2-silence-15-radius", "pri2-hold-person", "pri2-spiritual-hammer",
             "pri2-aid", "pri2-chant", "pri2-slow-poison"]),
        (3, ["pri3-prayer", "pri3-dispel-magic", "pri3-cure-disease",
             "pri3-remove-curse", "pri3-continual-light"]),
        (4, ["pri4-cure-serious-wounds", "pri4-divination",
             "pri4-protection-from-evil-10-radius"]),
        (5, ["pri5-raise-dead", "pri5-flame-strike"]),
        (6, ["pri6-heal"])
    ]

    private static func kelmonBoard(spent: [Int: Int]) -> SpellSlotBoard {
        var board = SpellSlotBoard()

        for (level, spellIDs) in kelmonPreparation {
            board.setCount(spellIDs.count, level: level, caster: .divine)
            let spentCount: Int = spent[level] ?? 0
            var position = 0
            for index in board.slots.indices
            where board.slots[index].level == level && board.slots[index].caster == .divine {
                if position < spellIDs.count {
                    board.slots[index].preparedSpellID = spellIDs[position]
                    board.slots[index].isSpent = position < spentCount
                }
                position += 1
            }
        }
        return board
    }

    /// Folha de ontem, já encerrada — serve para mostrar que o histórico da
    /// campanha fica guardado folha a folha.
    private static func kelmonYesterday() -> SpellSheet {
        var sheet = SpellSheet()
        sheet.title = "2º dia em Elturel"
        sheet.date = Date().addingTimeInterval(-26 * 3600)
        sheet.wisdomAtCreation = 17
        sheet.turnUndeadUsed = 5
        sheet.slotBoard = kelmonBoard(spent: [1: 4, 2: 3, 3: 2, 4: 1])

        // Exemplo do uso real de Additional Spells: um "passar rápido" de
        // alguns dias descansando na estalagem, sem repreparar slot por
        // slot em cada dia — só o registro do que foi lançado nesse meio
        // tempo, com Regeneration como caso de magia ainda fora da base.
        var extra = SpellLogEntry()
        extra.displayName = "Regeneration"
        extra.rawText = "Regeneration"

        sheet.entries = [extra]
        return sheet
    }

    /// A folha do dia em andamento.
    private static func kelmonToday() -> SpellSheet {
        var sheet = SpellSheet()
        sheet.title = "3º dia em Elturel"
        sheet.date = Date()
        sheet.wisdomAtCreation = 17
        sheet.turnUndeadUsed = 1
        sheet.slotBoard = kelmonBoard(spent: [1: 2, 2: 1, 3: 1])

        // O que foi memorizado e gasto hoje já aparece riscado na grade de
        // círculos acima — Additional Spells começa em branco, pronta pra
        // registrar algo fora dela quando precisar.
        sheet.entries = []

        // Um item mágico de exemplo, pra mostrar a seção cheia — com duas
        // magias atreladas, pra deixar claro que um item não fica preso a
        // uma só.
        sheet.magicItems = [
            MagicItem(name: "Wand of Cure Light Wounds",
                      itemDescription: "A slim silver wand tipped with a moonstone. "
                          + "10 charges; recharges at a temple of Torm once a season.",
                      spells: [
                          ItemSpellUse(spellName: "Cure Light Wounds",
                                       matchedSpellID: "pri1-cure-light-wounds",
                                       damageNote: "1d8+1",
                                       maxUses: 10,
                                       usedCount: 3)
                      ])
        ]
        return sheet
    }
}
