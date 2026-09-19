import Foundation

// MARK: - Atributos

struct AbilityScores: Codable, Hashable {
    var strength: Int = 10
    /// Força excepcional (01–00) — só guerreiros com Força 18.
    var exceptionalStrength: Int? = nil
    var dexterity: Int = 10
    var constitution: Int = 10
    var intelligence: Int = 10
    var wisdom: Int = 10
    var charisma: Int = 10

    var strengthDisplay: String {
        if strength == 18, let pct = exceptionalStrength, pct > 0 {
            return pct >= 100 ? "18/00" : String(format: "18/%02d", pct)
        }
        return "\(strength)"
    }
}

// MARK: - Jogadas de proteção

/// As cinco categorias de saving throw de AD&D 2e. São valores "role igual
/// ou acima", então o app guarda o alvo do d20 direto da tabela da classe.
struct SavingThrows: Codable, Hashable {
    var paralyzationPoisonDeath: Int = 16
    var rodStaffWand: Int = 18
    var petrificationPolymorph: Int = 17
    var breathWeapon: Int = 20
    var spell: Int = 19

    /// Resistência mágica — linha extra do PDF oficial, texto livre (ex.:
    /// "10%"). Optional pelo mesmo motivo de sempre: fichas antigas não
    /// têm essa chave no JSON salvo.
    var spellResistance: String? = nil

    /// Coluna "Mod" do PDF — um modificador de texto livre por jogada
    /// (ex.: "+2 vs veneno"), guardado por `SaveEntry.id` porque cada
    /// jogada não tinha campo próprio antes. Optional pelo mesmo motivo de
    /// sempre: fichas antigas não têm essa chave no JSON salvo.
    var modifiers: [String: String]? = nil

    func modifier(for id: String) -> String { modifiers?[id] ?? "" }

    mutating func setModifier(_ text: String, for id: String) {
        var dict = modifiers ?? [:]
        dict[id] = text
        modifiers = dict
    }

    struct SaveEntry: Identifiable {
        let id: String
        let label: String
        let keyPath: WritableKeyPath<SavingThrows, Int>
    }

    static let labels: [SaveEntry] = [
        SaveEntry(id: "ppd", label: "Paralyzation / Poison / Death",
                  keyPath: \.paralyzationPoisonDeath),
        SaveEntry(id: "rsw", label: "Rod / Staff / Wand",
                  keyPath: \.rodStaffWand),
        SaveEntry(id: "pp", label: "Petrification / Polymorph",
                  keyPath: \.petrificationPolymorph),
        SaveEntry(id: "bw", label: "Breath Weapon",
                  keyPath: \.breathWeapon),
        SaveEntry(id: "sp", label: "Spell",
                  keyPath: \.spell)
    ]
}

// MARK: - Slots de magia

/// Um slot individual. Em 2e o mago memoriza uma magia específica em cada
/// slot; conjurar gasta aquele slot, e só o descanso devolve.
struct SpellSlot: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var level: Int
    var caster: CasterType
    /// Magia preparada neste slot (id da base de magias), se houver.
    var preparedSpellID: String? = nil
    /// Nome livre, para magias que não estão na base embutida.
    var preparedSpellName: String? = nil
    var isSpent: Bool = false

    var isEmpty: Bool { preparedSpellID == nil && preparedSpellName == nil }

    mutating func clear() {
        preparedSpellID = nil
        preparedSpellName = nil
        isSpent = false
    }
}

/// Quantos slots de um círculo o personagem tem por descanso — a tabela de
/// memorização do livro, preenchida uma vez na ficha. É o molde a partir
/// do qual toda folha de magia nova é montada; diferente do `SpellSlot`,
/// não guarda o que está preparado hoje, só o quanto cabe.
struct SpellSlotAllotment: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var caster: CasterType
    var level: Int
    var count: Int
}

// MARK: - Tabelas de referência do clérigo (PHB 2e — Tabelas 5, 24 e 61)
//
// Dados fixos do livro, traduzidos o mais fiel possível das tabelas
// oficiais. Vivem aqui (não numa view) porque `PlayerCharacter.
// computedSpellSlotAllotments` também lê a Priest Spell Progression pra
// montar a grade de slots de folhas novas — a tabela na tela do Clérigo é
// só a mesma fonte, exibida.
enum PriestTables {
    /// Tabela 24: Priest Spell Progression. Índice 0 = nível 1 do
    /// personagem; cada linha tem 7 posições (círculos 1–7). `nil` é "—"
    /// (círculo ainda não disponível nesse nível).
    static let spellProgressionRows: [[Int?]] = [
        [1, nil, nil, nil, nil, nil, nil],       // 1
        [2, nil, nil, nil, nil, nil, nil],       // 2
        [2, 1, nil, nil, nil, nil, nil],         // 3
        [3, 2, nil, nil, nil, nil, nil],         // 4
        [3, 3, 1, nil, nil, nil, nil],           // 5
        [3, 3, 2, nil, nil, nil, nil],           // 6
        [3, 3, 2, 1, nil, nil, nil],             // 7
        [3, 3, 3, 2, nil, nil, nil],             // 8
        [4, 4, 3, 2, 1, nil, nil],               // 9
        [4, 4, 3, 3, 2, nil, nil],               // 10
        [5, 4, 4, 3, 2, 1, nil],                 // 11
        [6, 5, 5, 3, 2, 2, nil],                 // 12
        [6, 6, 6, 4, 2, 2, nil],                 // 13
        [6, 6, 6, 5, 3, 2, 1],                   // 14
        [6, 6, 6, 6, 4, 2, 1],                   // 15
        [7, 7, 7, 6, 4, 3, 1],                   // 16
        [7, 7, 7, 7, 5, 3, 2],                   // 17
        [8, 8, 8, 8, 6, 4, 2],                   // 18
        [9, 9, 9, 8, 6, 4, 2],                   // 19
        [9, 9, 9, 8, 7, 5, 2],                   // 20
    ]

    /// Requisito mínimo de Sabedoria pra cada círculo (só 6º e 7º têm; os
    /// outros ficam 0, sem restrição além da tabela de progressão em si).
    static let wisdomRequirementByCircle: [Int: Int] = [6: 17, 7: 18]

    /// Slots de cada círculo (1–7) pro nível/Sabedoria dados — `count > 0`
    /// só quando a tabela concede e (se houver requisito) a Sabedoria bate.
    static func spellProgression(level: Int, wisdom: Int) -> [Int] {
        let row = spellProgressionRows[max(0, min(level, spellProgressionRows.count) - 1)]
        return row.enumerated().map { index, count in
            let circle = index + 1
            guard let count else { return 0 }
            if let required = wisdomRequirementByCircle[circle], wisdom < required { return 0 }
            return count
        }
    }

    /// Tabela 61: Turning Undead. Cada linha é (tipo/DV, resultados nas 12
    /// colunas de nível de clérigo). "T" = turned automático, "D" =
    /// destroyed automático, "D*" = destroyed + 2d4 adicionais, "—" = sem
    /// efeito possível nesse nível.
    static let turningUndeadLevels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10-11", "12-13", "14+"]
    static let turningUndeadRows: [(type: String, results: [String])] = [
        ("Skeleton or 1 HD", ["10", "7", "4", "T", "T", "D", "D", "D*", "D*", "D*", "D*", "D*"]),
        ("Zombie", ["13", "10", "7", "4", "T", "T", "D", "D", "D*", "D*", "D*", "D*"]),
        ("Ghoul or 2 HD", ["16", "13", "10", "7", "4", "T", "T", "D", "D", "D*", "D*", "D*"]),
        ("Shadow or 3-4 HD", ["19", "16", "13", "10", "7", "4", "T", "T", "D", "D", "D*", "D*"]),
        ("Wight or 5 HD", ["20", "19", "16", "13", "10", "7", "4", "T", "T", "D", "D", "D*"]),
        ("Ghast", ["—", "20", "19", "16", "13", "10", "7", "4", "T", "T", "D", "D"]),
        ("Wraith or 6 HD", ["—", "—", "20", "19", "16", "13", "10", "7", "4", "T", "T", "D"]),
        ("Mummy or 7 HD", ["—", "—", "—", "20", "19", "16", "13", "10", "7", "4", "T", "T"]),
        ("Spectre or 8 HD", ["—", "—", "—", "—", "20", "19", "16", "13", "10", "7", "4", "T"]),
        ("Vampire or 9 HD", ["—", "—", "—", "—", "—", "20", "19", "16", "13", "10", "7", "4"]),
        ("Ghost or 10 HD", ["—", "—", "—", "—", "—", "—", "20", "19", "16", "13", "10", "7"]),
        ("Lich or 11+ HD", ["—", "—", "—", "—", "—", "—", "—", "20", "19", "16", "13", "10"]),
        ("Special**", ["—", "—", "—", "—", "—", "—", "—", "—", "20", "19", "16", "13"]),
    ]
    static let turningUndeadFootnotes = [
        "* An additional 2d4 creatures of this type are turned.",
        "** Special creatures include unique undead, free-willed undead of the Negative Material Plane, certain Greater and Lesser Powers, and those undead that dwell in the Outer Planes.",
        "† Paladins turn undead as priests who are two levels lower.",
    ]

    /// Tabela 5: Wisdom. Uma linha por pontuação (1–25).
    static let wisdomRows: [(score: Int, magDef: String, bonus: String, failure: String, immunity: String)] = [
        (1, "−6", "—", "80%", "—"),
        (2, "−4", "—", "60%", "—"),
        (3, "−3", "—", "50%", "—"),
        (4, "−2", "—", "45%", "—"),
        (5, "−1", "—", "40%", "—"),
        (6, "−1", "—", "35%", "—"),
        (7, "−1", "—", "30%", "—"),
        (8, "0", "—", "25%", "—"),
        (9, "0", "0", "20%", "—"),
        (10, "0", "0", "15%", "—"),
        (11, "0", "0", "10%", "—"),
        (12, "0", "0", "5%", "—"),
        (13, "0", "1st", "0%", "—"),
        (14, "0", "1st", "0%", "—"),
        (15, "+1", "2nd", "0%", "—"),
        (16, "+2", "2nd", "0%", "—"),
        (17, "+3", "3rd", "0%", "—"),
        (18, "+4", "4th", "0%", "—"),
        (19, "+4", "1st, 3rd", "0%", "cause fear, charm person, command, friends, hypnotism"),
        (20, "+4", "2nd, 4th", "0%", "forget, hold person, ray of enfeeblement, scare"),
        (21, "+4", "3rd, 5th", "0%", "fear"),
        (22, "+4", "4th, 5th", "0%", "charm monster, confusion, emotion, fumble, suggestion"),
        (23, "+4", "1st, 6th", "0%", "chaos, feeblemind, hold monster, magic jar, quest"),
        (24, "+4", "5th, 6th", "0%", "geas, mass suggestion, rod of rulership"),
        (25, "+4", "6th, 7th", "0%", "antipathy/sympathy, death spell, mass charm"),
    ]
}

/// A grade inteira de slots de um personagem, agrupada por nível de círculo.
struct SpellSlotBoard: Codable, Hashable {
    var slots: [SpellSlot] = []

    func slots(level: Int, caster: CasterType) -> [SpellSlot] {
        slots.filter { $0.level == level && $0.caster == caster }
    }

    var usedLevels: [Int] {
        Array(Set(slots.map(\.level))).sorted()
    }

    func casters() -> [CasterType] {
        CasterType.allCases.filter { c in slots.contains { $0.caster == c } }
    }

    /// Ajusta a quantidade de slots de um nível, preservando o que já estava
    /// preparado nos slots que continuam existindo.
    mutating func setCount(_ count: Int, level: Int, caster: CasterType) {
        guard count >= 0 else { return }
        var existing = slots.filter { $0.level == level && $0.caster == caster }
        slots.removeAll { $0.level == level && $0.caster == caster }
        if existing.count > count {
            // Descarta primeiro os slots vazios, depois os já gastos — nunca
            // uma magia preparada que ainda está disponível.
            existing.sort { (lhs: SpellSlot, rhs: SpellSlot) -> Bool in
                SpellSlotBoard.keepRank(lhs) < SpellSlotBoard.keepRank(rhs)
            }
            existing = Array(existing.prefix(count))
        } else {
            while existing.count < count {
                existing.append(SpellSlot(level: level, caster: caster))
            }
        }
        slots.append(contentsOf: existing)
        sortSlots()
    }

    /// Prioridade de permanência quando a quantidade de slots diminui:
    /// preparados e disponíveis ficam, vazios são os primeiros a sair.
    /// (A lista é ordenada por este posto e cortada pelo fim.)
    private static func keepRank(_ slot: SpellSlot) -> Int {
        if slot.isEmpty { return 2 }
        if slot.isSpent { return 1 }
        return 0
    }

    /// Ordem determinística: sem o id no critério, os chips embaralham a cada
    /// edição, porque sort não é estável.
    private mutating func sortSlots() {
        slots.sort { (lhs: SpellSlot, rhs: SpellSlot) -> Bool in
            if lhs.caster != rhs.caster {
                return lhs.caster.rawValue < rhs.caster.rawValue
            }
            if lhs.level != rhs.level {
                return lhs.level < rhs.level
            }
            return lhs.id.uuidString < rhs.id.uuidString
        }
    }

    /// Descanso: devolve todos os slots gastos. Mantém o que estava preparado
    /// para quem prefere remontar a lista a partir do dia anterior.
    mutating func rest(clearingPreparations: Bool) {
        for index in slots.indices {
            slots[index].isSpent = false
            if clearingPreparations { slots[index].clear() }
        }
    }

    /// Marca como gasto o primeiro slot disponível com a magia indicada.
    /// Retorna true se encontrou um slot pra gastar.
    @discardableResult
    mutating func spendSlot(spellID: String) -> Bool {
        guard let index = slots.firstIndex(where: {
            $0.preparedSpellID == spellID && !$0.isSpent
        }) else { return false }
        slots[index].isSpent = true
        return true
    }

    /// Mesma coisa para magias preparadas por nome livre (fora da base).
    @discardableResult
    mutating func spendSlot(named name: String) -> Bool {
        let target = Fuzzy.normalize(name)
        guard !target.isEmpty else { return false }
        guard let index = slots.firstIndex(where: { slot in
            guard !slot.isSpent, let prepared = slot.preparedSpellName else { return false }
            return Fuzzy.normalize(prepared) == target
        }) else { return false }
        slots[index].isSpent = true
        return true
    }
}

// MARK: - Personagem

/// Uma linha da lista de equipamento: nome e uma nota curta à direita
/// (peso, dano, quantidade) — como se escreve na margem da ficha.
struct EquipmentItem: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String = ""
    var note: String = ""
}

/// Uma linha da tabela de armas da ficha oficial.
struct WeaponEntry: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String = ""
    var attacks: String = "1"
    var thac0: String = ""
    var damageSmall: String = ""
    var damageLarge: String = ""
    var range: String = "—"

    // Campos novos da ficha oficial (PDF page 1) — Optional porque uma
    // ficha salva antes desta versão não tem essas chaves no JSON, e o
    // decoder sintetizado do Swift falha o struct inteiro se um campo
    // não-Optional com valor padrão estiver ausente (só Optional vira
    // decodeIfPresent e cai em nil sozinho).
    var size: String? = nil
    var weaponType: String? = nil
    var speed: String? = nil
    var hitAdj: String? = nil
    var dmgAdj: String? = nil
    var rangeSpecial: String? = nil
}

/// Uma linha da tabela de Proficiências da ficha oficial (nome + espaços
/// gastos + marcado ou não).
struct ProficiencyEntry: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String = ""
    var slots: String = ""
    /// "checked" era um Bool (caixinha de visto) — na prática a coluna
    /// "Chk" da ficha oficial é o número-alvo pra rolar no dado (ex.: "14")
    /// pra ter sucesso na checagem, não um sim/não. `checked` fica sem uso
    /// (fichas antigas continuam decodificando normalmente, a chave extra é
    /// só ignorada) e `target` — Optional, mesma regra de sempre — guarda
    /// o valor de verdade.
    var checked: Bool = false
    var target: String? = nil
}

/// Os detalhes de combate da ficha oficial que não têm campo próprio ainda
/// no personagem — tudo texto livre, como as linhas em branco do PDF.
/// Todo o struct é Optional no personagem (ver `PlayerCharacter.combat`)
/// pelo mesmo motivo do `WeaponEntry` acima.
struct CombatDetails: Codable, Hashable {
    var surprisedAC: String? = nil
    var shieldlessAC: String? = nil
    var rearAC: String? = nil
    var typeWorn: String? = nil
    var dexChecks: String? = nil
    var visionChecks: String? = nil
    var hearingChecks: String? = nil
    var hitDiceType: String? = nil
    var numbedNumber: String? = nil
    var uselessNumber: String? = nil
    var maxDeaths: String? = nil
    var deathsToDate: String? = nil
    var wounds: String? = nil
}

/// Uma linha da tabela de Equipment da página 2 do PDF oficial — item,
/// onde está guardado, peso. Diferente do `EquipmentItem` da aba Equipment
/// (que só tem nome + nota): mantido à parte de propósito, pra não mexer
/// na aba Equipment enquanto ela não for refeita também.
struct Page2EquipmentEntry: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var item: String = ""
    var location: String = ""
    var weight: String = ""

    /// Coluna fixa em que a linha nasceu (0 ou 1). Antes as duas colunas
    /// eram um rodízio calculado pelo índice na lista — apagar uma linha
    /// deslocava o índice de tudo que vinha depois, e metade das linhas
    /// "pulava" de coluna. Guardando a coluna na própria linha, apagar uma
    /// só mexe nas linhas abaixo dela NA MESMA coluna, como uma lista
    /// normal. Optional pelo mesmo motivo de sempre; ausência vira coluna 0.
    var column: Int? = nil
}

/// As taxas da tabela "Movement" da página 2.
struct MovementRates: Codable, Hashable {
    var base: String = ""
    var jog: String = ""
    var runX3: String = ""
    var runX4: String = ""
    var runX5: String = ""
    var day: String = ""
}

/// Uma linha da tabela de Encumbrance da página 2 — uma das quatro
/// categorias fixas do livro (Light/Moderate/Heavy/Severe).
struct EncumbranceRow: Codable, Hashable {
    var weightCarried: String = ""
    var moveRate: String = ""
    var attackPenalty: String = ""
    var acPenalty: String = ""
}

struct EncumbranceTable: Codable, Hashable {
    var light = EncumbranceRow()
    var moderate = EncumbranceRow()
    var heavy = EncumbranceRow()
    var severe = EncumbranceRow()
}

/// Uma linha da tabela "Level Changes" (By / At Levels) da página 2.
struct LevelChangeRow: Codable, Hashable {
    var by: String = ""
    var atLevels: String = ""
}

struct LevelChangesTable: Codable, Hashable {
    var thac0 = LevelChangeRow()
    var savingThrows = LevelChangeRow()
    var weaponProficiencies = LevelChangeRow()
    var nonWeaponProficiencies = LevelChangeRow()
}

/// Uma linha com quantidade — "10 poções de cura" numa linha só, em vez de
/// dez linhas repetidas. Usado pelas listas de Magic Items e Treasure/
/// Other Possessions da página 2.
struct QuantifiedItem: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String = ""
    var quantity: Int = 1

    /// Quantos já foram usados/gastos — marcado a mão com o mesmo contador
    /// de traço ("pauzinhos") da Priest Spell Sheet. Optional pelo mesmo
    /// motivo de sempre: linhas criadas antes desta versão não têm essa
    /// chave.
    var usedCount: Int? = nil
}

/// As moedas, como na caixa de tesouro da ficha.
struct Treasure: Codable, Hashable {
    var platinum: Int = 0
    var gold: Int = 0
    var electrum: Int = 0
    var silver: Int = 0
    var copper: Int = 0
}

/// Os ajustes derivados dos atributos. Na ficha oficial são linhas em
/// branco preenchidas a partir das tabelas do Livro do Jogador; aqui o app
/// sugere o que sabe calcular e deixa o resto por sua conta.
struct AbilityDetails: Codable, Hashable {
    var strengthHit: String = ""
    var strengthDamage: String = ""
    var strengthWeight: String = ""
    var strengthMaxPress: String = ""
    var strengthDoors: String = ""
    var strengthBars: String = ""

    var dexterityReaction: String = ""
    var dexterityMissile: String = ""
    var dexterityDefense: String = ""

    var constitutionHP: String = ""
    var constitutionShock: String = ""
    var constitutionResurrection: String = ""
    var constitutionPoison: String = ""

    var intelligenceLanguages: String = ""
    var intelligenceMaxLevel: String = ""
    var intelligenceLearn: String = ""
    var intelligenceMaxPerLevel: String = ""

    var wisdomDefense: String = ""
    var wisdomFailure: String = ""
    /// Bônus de magia por círculo, como está escrito na tabela do livro:
    /// "+2 / +2 / +1" — círculo 1 ganha +2 slot(s), círculo 2 +2, círculo 3 +1.
    var wisdomBonusSpells: String = ""

    /// O bônus de um círculo específico, lido do texto livre acima. `0`
    /// quando o círculo não tem bônus (ou o texto não cobre esse círculo).
    func wisdomBonus(forCircle level: Int) -> Int {
        let parts = wisdomBonusSpells
            .replacingOccurrences(of: " ", with: "")
            .split(separator: "/")
        guard level >= 1, level <= parts.count else { return 0 }
        let digits = parts[level - 1].filter { $0.isNumber }
        return Int(digits) ?? 0
    }

    var charismaHenchmen: String = ""
    var charismaLoyalty: String = ""
    var charismaReaction: String = ""

    // Três campos da ficha oficial que as folhas antigas não têm —
    // Optional pelo mesmo motivo do `WeaponEntry`/`CombatDetails` acima.
    var intelligenceSpellImmunity: String? = nil
    var wisdomSpellImmunity: String? = nil
    var constitutionRegen: String? = nil
}

/// As classes de personagem de AD&D 2e (livro do jogador). A classe decide
/// que ficha de magia a pasta abre — por ora só o Clérigo tem uma, a
/// Priest Spell Sheet; as outras classes conjuradoras (Mago, Druida) ganham
/// a delas mais pra frente.
enum CharacterClass: String, Codable, CaseIterable, Identifiable, Hashable {
    case fighter = "Fighter"
    case paladin = "Paladin"
    case ranger = "Ranger"
    case mage = "Mage"
    case cleric = "Cleric"
    case druid = "Druid"
    case thief = "Thief"
    case bard = "Bard"

    var id: String { rawValue }

    /// Só o Clérigo tem folha de magias por enquanto.
    var hasSpellSheet: Bool { self == .cleric }

    /// Fichas salvas antes da tradução da UI pra inglês guardavam o nome
    /// da classe em português (era o `rawValue` da época) — sem isso elas
    /// deixariam de decodificar e a pasta apareceria vazia. Continua
    /// aceitando o valor antigo na leitura; a próxima gravação já salva no
    /// valor novo em inglês.
    init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)
        if let match = CharacterClass(rawValue: raw) {
            self = match
            return
        }
        switch raw {
        case "Guerreiro": self = .fighter
        case "Paladino": self = .paladin
        case "Patrulheiro": self = .ranger
        case "Mago": self = .mage
        case "Clérigo": self = .cleric
        case "Druida": self = .druid
        case "Ladino": self = .thief
        case "Bardo": self = .bard
        default: self = .fighter
        }
    }
}

/// Uma sessão de mesa — a data real em que ela aconteceu, não a data do
/// jogo. Cada folha de magia (`SpellSheet`) pertence a uma sessão através
/// de `sessionID`; a sessão em si só guarda o cabeçalho (data, título,
/// resumo), nunca as folhas — evita o mesmo tipo de binding aninhado que
/// já doeu com os slots.
struct Session: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    /// A data real da mesa — o dia em que vocês jogaram, não um dia dentro
    /// da história.
    var date: Date = Date()
    var title: String = ""
    var summary: String = ""
    /// Sessões encerradas somem da faixa de abas e da lista principal do
    /// índice, mas os dados continuam intactos — arquivar nunca apaga.
    var isArchived: Bool = false
}

/// Os dois tipos de folha do caderno: uma escrita com o Scribble do sistema
/// (vira texto de verdade, editável e pesquisável) e uma de desenho livre,
/// pra quem tem letra feia — ali é tinta pura, sem tentativa de transcrever.
enum NotebookPageKind: String, Codable {
    case transcribed
    case freeform
}

/// Uma folha livre do caderno de campanha — encontro com NPC, pista,
/// decisão do grupo. Sem seções fixas: só um título opcional, uma data e o
/// conteúdo, que é texto ou tinta dependendo do tipo da folha.
struct NotebookEntry: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var date: Date = Date()
    var title: String = ""
    var text: String = ""

    /// Optional pelo mesmo motivo de sempre: folhas criadas antes desta
    /// versão não têm essa chave — ausência é tratada como `.transcribed`,
    /// que era o único tipo que existia até então.
    var kind: NotebookPageKind? = nil

    /// Traço de tinta serializado (PKDrawing.dataRepresentation()) — só
    /// usado quando kind == .freeform.
    var drawingData: Data? = nil
}

/// Uma campanha de mesa: dura meses ou anos, agrupa as sessões jogadas e o
/// caderno de anotações — ambos compartilhados por quem quer que esteja
/// jogando essa campanha, não mais presos a um personagem só (ver
/// `Session`/`NotebookEntry`, que moraram dentro de `PlayerCharacter` até
/// esta versão). Um personagem pertence a uma campanha, ou a nenhuma — ver
/// `PlayerCharacter.campaignID` — e mais de um personagem pode jogar a
/// mesma campanha ao mesmo tempo, inclusive compartilhando a mesma sessão.
struct Campaign: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String = ""
    /// Quando a campanha começou de verdade — não precisa bater com a data
    /// da sessão mais antiga (a campanha pode ter sido criada bem antes da
    /// primeira mesa marcada, ex.: personagens preparados com um mês de
    /// antecedência).
    var startedDate: Date = Date()
    var notes: String = ""
    /// Encerrada (nunca apagada) — sai da lista principal, mas continua
    /// consultável, igual a uma sessão arquivada.
    var isArchived: Bool = false

    /// As sessões de mesa — cada uma agrupa um punhado de folhas de dia de
    /// um ou mais personagens.
    var sessions: [Session] = []

    /// Caderno de anotações livres da campanha — encontros com NPCs,
    /// pistas, decisões do grupo. Compartilhado por todo mundo que joga
    /// essa campanha, não mais um caderno por personagem.
    var notebookEntries: [NotebookEntry] = []

    var displayTitle: String {
        name.isEmpty ? "Unnamed Campaign" : name
    }

    /// A sessão "ativa": a mais recente que não está arquivada. Se não
    /// existir nenhuma (campanha nova, ou todas encerradas), cria uma
    /// sozinha, datada de hoje.
    @discardableResult
    mutating func activeSession() -> Session {
        if let existing = sessions.filter({ !$0.isArchived }).max(by: { $0.date < $1.date }) {
            return existing
        }
        let created = Session(date: Date())
        sessions.append(created)
        return created
    }

    /// Cria uma folha nova no fim do caderno (mais recente) e devolve o id
    /// dela, pronto pra virar o `currentID` do pager.
    @discardableResult
    mutating func addNotebookPage(kind: NotebookPageKind) -> UUID {
        var entry = NotebookEntry()
        entry.kind = kind
        notebookEntries.append(entry)
        return entry.id
    }
}

/// O estado de um personagem dentro de uma campanha — só "alive" aparece
/// no elenco por padrão; os outros dois ficam em seções recolhidas, nunca
/// somem de verdade (matar/aposentar nunca apaga dados).
enum CharacterStatus: String, Codable, CaseIterable {
    case alive
    case dead
    case archived
}

struct PlayerCharacter: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String = ""
    var playerName: String = ""
    var race: String = ""
    var characterClass: CharacterClass = .fighter
    var level: Int = 1
    var alignment: String = ""
    var deity: String = ""
    var sex: String = ""
    var age: String = ""
    var height: String = ""
    var weight: String = ""
    var hair: String = ""
    var eyes: String = ""

    // Campos novos da ficha oficial (PDF page 1) — Optional pelo mesmo
    // motivo do resto desta seção: fichas salvas antes desta versão não
    // têm essas chaves.
    var kit: String? = nil
    var placeOfOrigin: String? = nil
    var combat: CombatDetails? = nil
    var proficiencies: [ProficiencyEntry]? = nil
    var toHitModifiers: [EquipmentItem]? = nil
    var damageModifiers: [EquipmentItem]? = nil
    var acModifiers: [EquipmentItem]? = nil
    var nonProficiencyPenalty: String? = nil

    /// Ajustes manuais da tabela "Target's AC / To Hit #", indexados pela
    /// CA alvo (10 a −10). Uma CA sem entrada aqui usa o valor calculado
    /// automaticamente a partir do THAC0 — ver `thac0TargetDisplay`.
    var thac0TargetOverrides: [Int: String]? = nil

    // Campos novos da página 4 do PDF oficial (Character Description) —
    // Optional pelo mesmo motivo do resto. `name`, `playerName`, `race`,
    // `alignment`, `deity`, `sex`, `age`, `height`, `weight`, `hair`,
    // `eyes` e `placeOfOrigin` (Origin) já existiam desde a página 1 e são
    // reaproveitados direto nesta página, sem duplicar dado.
    var birthDate: String? = nil
    var birthRank: String? = nil
    var nationality: String? = nil
    var racialAbilities: String? = nil
    var skin: String? = nil
    var vision: String? = nil
    var handedness: String? = nil
    var personality: String? = nil
    var hitPointsByLevel: String? = nil
    var backgroundHistory: String? = nil
    /// Retrato pro quadrado "Character Sketch" do PDF — enviado pelo
    /// jogador (upload de foto/desenho), não gerado pelo app. Guardado já
    /// redimensionado e comprimido em JPEG (ver `UIImage.resizedForSketch`
    /// em `CharacterDescriptionView.swift`) antes de chegar aqui, pro JSON
    /// da biblioteca não inchar com fotos em resolução de câmera.
    var portraitImageData: Data? = nil

    // Campos novos da página 2 do PDF oficial (Equipment/Movement/
    // Experience) — Optional pelo mesmo motivo do resto: fichas salvas
    // antes desta versão não têm essas chaves. `magicItems` e `experience`
    // já existiam e são reaproveitados aqui direto, sem duplicar dado.
    var page2Equipment: [Page2EquipmentEntry]? = nil
    var page2TotalWeight: String? = nil
    var page2EquipmentEncumbrance: String? = nil
    var page2MovementRate: String? = nil
    var page2Movement: MovementRates? = nil
    var page2EncumbranceTable: EncumbranceTable? = nil
    var xpNeededNextLevel: String? = nil
    var xpKitModifier: String? = nil
    var xpAbilityBonus: String? = nil
    var xpSubraceModifier: String? = nil
    var xpLevelLimit: String? = nil
    var levelChanges: LevelChangesTable? = nil
    /// Substituída por `page2MagicItems`/`page2TreasureItems` (com
    /// quantidade) — o campo antigo fica aqui só pra não quebrar a leitura
    /// de fichas salvas com ele, mas não é mais editado em lugar nenhum.
    var page2TreasureNotes: [String]? = nil
    var page2MagicItems: [QuantifiedItem]? = nil
    var page2TreasureItems: [QuantifiedItem]? = nil

    var movement: Int = 12
    var equipment: [EquipmentItem] = []
    var weapons: [WeaponEntry] = []
    var weaponProficiencies: [String] = []
    var skills: [EquipmentItem] = []      // perícia + atributo/base
    var languages: [String] = []
    var magicItems: [String] = []
    var allies: [String] = []
    var treasure = Treasure()
    var details = AbilityDetails()

    var abilities = AbilityScores()
    var saves = SavingThrows()

    var hitPointsMax: Int = 6
    var hitPointsCurrent: Int = 6
    var armorClass: Int = 10
    var thac0: Int = 20

    var experience: Int = 0

    /// Armadura e escudo separados, porque a ficha oficial mostra a conta.
    var armorRating: String = ""
    var shieldRating: String = ""

    /// Uma folha de magias por dia de jogo. Os slots vivem aqui, não no
    /// personagem: eles zeram no repouso, e cada dia é uma folha nova.
    var spellSheets: [SpellSheet] = []

    /// Quantos slots de cada círculo o personagem tem por descanso — a
    /// tabela de memorização da classe, preenchida uma vez aqui na ficha.
    /// Toda folha de magia nova nasce a partir dela; não é editável dia a
    /// dia na própria folha, porque senão duas folhas do mesmo personagem
    /// discordariam sobre quantos slots ele tem.
    var spellSlotAllotments: [SpellSlotAllotment] = []

    /// A campanha a que este personagem pertence — `nil` quer dizer que ele
    /// está no Sandbox: já existe (atributos, equipamento, o que for), mas
    /// ainda não foi associado a nenhuma campanha de verdade. É a campanha,
    /// não mais o personagem, que possui as sessões de mesa e o caderno —
    /// ver `Campaign`.
    var campaignID: UUID? = nil

    /// Vivo, morto (mas consultável) ou aposentado sem ter morrido.
    var status: CharacterStatus = .alive

    /// Quando morreu, se for o caso — a data real da mesa, não uma data da
    /// história.
    var diedOn: Date? = nil
    /// Nota livre sobre a morte (ex.: "caiu pra um dragão vermelho perto de
    /// Elturel").
    var deathNote: String? = nil

    /// Se este personagem nasceu de "Clonar personagem", o id de quem foi
    /// clonado — só pra rastrear a linhagem; nada no app depende disso pra
    /// funcionar.
    var clonedFromCharacterID: UUID? = nil

    /// LEGADO (2026-09-19): favoritar deixou de ser por personagem e virou
    /// preferência global do jogador — ver `CharacterLibrary.favoriteSpellIDs`.
    /// Este campo continua aqui só pra migrar fichas salvas ANTES da troca
    /// (`CharacterLibrary.load()` junta os favoritos de todo personagem num
    /// conjunto só, uma vez); nada escreve nele de novo, e nenhuma tela lê
    /// dele — todo mundo passou a consultar a biblioteca.
    var favoriteSpellIDs: Set<String> = []

    /// Quantos slots de cada círculo o personagem tem por descanso, calculado
    /// pela Priest Spell Progression (Tabela 24 do PHB) a partir do nível e
    /// da Sabedoria atuais — substitui a antiga entrada manual
    /// (`spellSlotAllotments`, mantida só pra fichas salvas antigas
    /// continuarem decodificando) que morava na aba Equipment.
    var computedSpellSlotAllotments: [SpellSlotAllotment] {
        guard characterClass.hasSpellSheet else { return [] }
        let counts = PriestTables.spellProgression(level: level, wisdom: abilities.wisdom)
        return counts.enumerated().compactMap { index, count in
            guard count > 0 else { return nil }
            return SpellSlotAllotment(caster: .divine, level: index + 1, count: count)
        }
    }

    /// Uma grade de slots em branco (sem nada preparado ainda), do
    /// tamanho que a Priest Spell Progression diz que o personagem tem hoje.
    func freshSlotBoard() -> SpellSlotBoard {
        var board = SpellSlotBoard()
        for allotment in computedSpellSlotAllotments where allotment.count > 0 {
            board.setCount(allotment.count, level: allotment.level, caster: allotment.caster)
        }
        return board
    }

    /// Folhas em ordem, da mais recente para a mais antiga.
    var sortedSpellSheets: [SpellSheet] {
        spellSheets.sorted { $0.date > $1.date }
    }

    /// A folha do dia em andamento — a última criada.
    var currentSheetIndex: Int? {
        guard !spellSheets.isEmpty else { return nil }
        var newestIndex = 0
        for index in spellSheets.indices where spellSheets[index].date > spellSheets[newestIndex].date {
            newestIndex = index
        }
        return newestIndex
    }

    /// Quantas vezes cada magia apareceu memorizada em alguma folha deste
    /// personagem — usado pra ordenar por "mais usada" sem precisar de um
    /// contador dedicado (ver TODO.md item 3).
    func spellUsageCounts() -> [String: Int] {
        var counts: [String: Int] = [:]
        for sheet in spellSheets {
            for slot in sheet.slotBoard.slots {
                guard let id = slot.preparedSpellID else { continue }
                counts[id, default: 0] += 1
            }
        }
        return counts
    }

    var displayTitle: String {
        name.isEmpty ? "Unnamed Character" : name
    }

    var displaySubtitle: String {
        let parts = [race, characterClass.rawValue].filter { !$0.isEmpty }
        let base = parts.joined(separator: " ")
        return base.isEmpty ? "Level \(level)" : "\(base) — level \(level)"
    }

    // MARK: - Tabela "Target's AC / To Hit #"

    /// As 21 CAs-alvo mostradas na ficha oficial, de 10 até −10.
    static let thac0TargetACs: [Int] = Array(stride(from: 10, through: -10, by: -1))

    /// O número de ataque calculado pela regra pura: THAC0 − CA alvo.
    func thac0AutoTarget(ac: Int) -> Int { thac0 - ac }

    /// O que a célula mostra: o ajuste manual, se houver um escrito por
    /// cima (bônus situacional), senão o valor calculado.
    func thac0TargetDisplay(ac: Int) -> String {
        if let override = thac0TargetOverrides?[ac], !override.isEmpty {
            return override
        }
        return "\(thac0AutoTarget(ac: ac))"
    }

    /// Grava um ajuste manual — mas se o texto escrito bate com o valor
    /// calculado (ou fica vazio), a célula "cicatriza" de volta pro modo
    /// automático em vez de guardar um texto redundante.
    mutating func setThac0Override(ac: Int, text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespaces)
        let auto = "\(thac0AutoTarget(ac: ac))"
        if trimmed.isEmpty || trimmed == auto {
            thac0TargetOverrides?[ac] = nil
        } else {
            if thac0TargetOverrides == nil { thac0TargetOverrides = [:] }
            thac0TargetOverrides?[ac] = trimmed
        }
    }
}
