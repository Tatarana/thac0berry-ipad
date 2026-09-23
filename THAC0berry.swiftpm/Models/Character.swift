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

// MARK: - Esferas de acesso

/// Nível de acesso do personagem a uma esfera de magia de clérigo —
/// acesso MAIOR conjura até o círculo máximo que o nível permitir, acesso
/// MENOR só até o 3º círculo daquela esfera (regra do PHB, capítulo 3).
/// String bruta em vez de referência a `Spell.spheres` de propósito: são
/// dados de fontes diferentes (a lista canônica de esferas é fixa; o
/// texto de `spheres` em cada magia vem direto do corpus JSON), casam
/// pelo NOME, não por identidade de tipo.
enum SphereAccessLevel: String, Codable, Hashable, CaseIterable {
    case major
    case minor

    var label: String {
        switch self {
        case .major: return "Major"
        case .minor: return "Minor"
        }
    }
}

/// Sinal de esfera-de-acesso pra um candidato de magia na Folha de Magias
/// (ver `PlayerCharacter.sphereSignal(for:)`) — SEMPRE só um aviso, nunca
/// um filtro: a magia continua na lista, escolhível, do mesmo jeito.
enum SphereSignal: Hashable {
    /// Nenhuma das esferas da magia está marcada (nem maior, nem menor).
    case outsideSpheres
    /// Pelo menos uma esfera da magia está marcada, mas só como MENOR —
    /// regra do PHB (capítulo 3): acesso menor trava no 3º círculo,
    /// então uma magia de 4º círculo em diante nessa esfera fica fora do
    /// alcance mecânico do personagem, mesmo "tendo" a esfera.
    case minorCircleCap

    var label: String {
        switch self {
        case .outsideSpheres: return "outside spheres"
        case .minorCircleCap: return "minor — caps at 3rd circle"
        }
    }
}

// MARK: - Jogadas de proteção

/// As cinco categorias de saving throw de AD&D 2e. São valores "role igual
/// ou acima" — quanto MENOR, melhor. O app guarda o alvo "Start" direto da
/// tabela da classe/nível (o `ConsequenceEngine` escreve aqui sozinho numa
/// subida de nível) e um "Mod" numérico por jogada que o jogador ajusta na
/// mão (item de anel/poção temporário, penalidade de armadilha, bônus de
/// magia — qualquer coisa que a tabela por si só não cobre). "Total" (Start
/// − Mod, já que um bônus positivo FACILITA a jogada — reduz o número que
/// precisa tirar no d20, regra do PHB cap. 9) é só exibido, nunca guardado:
/// sempre recalculado a partir dos outros dois, nunca pode ficar
/// dessincronizado.
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

    /// Coluna "Mod" do PDF — ajuste numérico por jogada (positivo = bônus,
    /// facilita; negativo = penalidade), guardado por `SaveEntry.id`
    /// porque cada jogada não tinha campo próprio antes. Optional pelo
    /// mesmo motivo de sempre: fichas antigas não têm essa chave no JSON
    /// salvo.
    var modifiers: [String: Int]? = nil

    func modifier(for id: String) -> Int { modifiers?[id] ?? 0 }

    mutating func setModifier(_ value: Int, for id: String) {
        var dict = modifiers ?? [:]
        if value == 0 {
            dict.removeValue(forKey: id)
        } else {
            dict[id] = value
        }
        modifiers = dict.isEmpty ? nil : dict
    }

    /// "Total" da coluna do PDF — Start menos o Mod aplicado (ver o
    /// comentário da struct pro porquê de ser subtração). Nunca guardado;
    /// sempre recalculado na hora de exibir.
    func total(for entry: SaveEntry) -> Int {
        self[keyPath: entry.keyPath] - modifier(for: entry.id)
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

    /// `Weapon.id` quando esta linha veio do `WeaponPickerSheet` (Weapon
    /// Compendium) — mesmo padrão de `ProficiencyEntry.matchedProficiencyID`:
    /// liga a linha à base pra abrir a descrição completa num toque, sem
    /// depender do nome bater exatamente. `nil` numa linha digitada à mão
    /// (fichas antigas, ou arma caseira fora da base de 69 armas do PHB).
    var matchedWeaponID: String? = nil
}

/// Uma linha da tabela de Proficiências da ficha oficial (nome + espaços
/// gastos + marcado ou não).
struct ProficiencyEntry: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String = ""
    /// Quantos espaços de proficiência esta entrada consome. Era um campo
    /// de TEXTO LIVRE — qualquer coisa podia ser digitada ali, inclusive
    /// coisas que não fazem sentido nenhum nessa coluna (bug relatado pelo
    /// usuário 2026-09-22: a ficha do Kelmon, gerada a partir dos dados de
    /// exemplo antigos de `SampleCharacter.swift`, tinha "weapon" e "WIS
    /// 17" no campo "Slots" — informação que devia estar em `target`, ou
    /// nem existir). Virou número de verdade. `init(from:)` abaixo lê
    /// fichas salvas ANTES dessa mudança (campo era String): tenta como
    /// Int primeiro, senão extrai os dígitos de dentro do texto antigo
    /// (ex.: "2 slots" → 2), senão cai pro padrão de 1 — nunca falha ao
    /// abrir a ficha, só normaliza o valor.
    var slots: Int = 1
    /// "checked" era um Bool (caixinha de visto) — na prática a coluna
    /// "Chk" da ficha oficial é o número-alvo pra rolar no dado (ex.: "14")
    /// pra ter sucesso na checagem, não um sim/não. `checked` fica sem uso
    /// (fichas antigas continuam decodificando normalmente, a chave extra é
    /// só ignorada) e `target` — Optional, mesma regra de sempre — guarda
    /// o valor de verdade.
    var checked: Bool = false
    var target: String? = nil
    /// `Proficiency.id` quando esta linha veio do `ProficiencyPickerSheet`
    /// (TODO.md item 18) — mesmo padrão de `ItemSpellUse.matchedSpellID`:
    /// liga a linha à base pra abrir a descrição completa num toque, sem
    /// depender do nome bater exatamente. `nil` numa linha digitada à mão
    /// (fichas antigas, ou proficiência caseira fora da base) — nesse caso
    /// o nome ainda é comparado contra a base como último recurso (ver
    /// `ProficiencyFormRow.matchedProficiency`), mas sem garantia nenhuma.
    var matchedProficiencyID: String? = nil

    init(id: UUID = UUID(), name: String = "", slots: Int = 1, checked: Bool = false,
         target: String? = nil, matchedProficiencyID: String? = nil) {
        self.id = id
        self.name = name
        self.slots = slots
        self.checked = checked
        self.target = target
        self.matchedProficiencyID = matchedProficiencyID
    }

    private enum CodingKeys: String, CodingKey {
        case id, name, slots, checked, target, matchedProficiencyID
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        checked = try container.decodeIfPresent(Bool.self, forKey: .checked) ?? false
        target = try container.decodeIfPresent(String.self, forKey: .target)
        matchedProficiencyID = try container.decodeIfPresent(String.self, forKey: .matchedProficiencyID)

        if let intSlots = try? container.decodeIfPresent(Int.self, forKey: .slots) {
            slots = intSlots
        } else if let textSlots = try? container.decodeIfPresent(String.self, forKey: .slots) {
            let digits = textSlots.filter(\.isNumber)
            slots = Int(digits) ?? 1
        } else {
            slots = 1
        }
    }
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

    /// `MundaneItem.id` quando esta linha veio do `MundaneItemPickerSheet`
    /// (Equipment Compendium) — mesmo padrão de
    /// `ProficiencyEntry.matchedProficiencyID`/`WeaponEntry.matchedWeaponID`:
    /// liga a linha à base pra abrir a descrição completa (custo/peso) num
    /// toque. `nil` numa linha digitada à mão (fichas antigas, ou item
    /// caseiro fora do catálogo de 183 itens).
    var matchedItemID: String? = nil
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

    /// Liga esta linha a um item de `MagicItemDatabase` (mesmo padrão de
    /// `Page2EquipmentEntry.matchedItemID`/`MundaneItemDatabase`) — só usado
    /// pela lista "Magic Items" (não por "Treasure / Other Possessions",
    /// que continua puramente texto livre). `nil` = linha digitada à mão
    /// pelo jogador (item caseiro/criado por ele) ou ficha salva antes
    /// desta versão existir; nesse caso cai pro fallback de nome exato,
    /// igual ao equipamento mundano.
    var matchedItemID: String? = nil
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

    /// Quantas páginas fixas a aba "Sheet" da ficha de personagem tem pra
    /// essa classe (`RecordSheetPagerView`/`RecordSheetBeadRow` em
    /// `CharacterSheetView.swift`) — Ficha + Equipment/Movement/Experience
    /// + Character Description pra todo mundo, mais uma 4ª página de
    /// tabelas de referência do Clérigo só pra quem tem ficha de magia.
    /// Centralizado aqui (2026-09-20) porque as duas views antes tinham
    /// cada uma sua própria conta solta — divergiram (`RecordSheetBeadRow`
    /// ficou um a menos que `RecordSheetPagerView`), e a página extra do
    /// Clérigo nunca ganhava bolinha própria por causa disso.
    var recordSheetPageCount: Int { hasSpellSheet ? 4 : 3 }

    /// O grupo (Warrior/Wizard/Priest/Rogue) que esta classe pertence —
    /// mesmo rótulo de `Proficiency.primaryGroup` (2026-09-22, pedido do
    /// usuário: destacar no seletor de Proficiências o grupo "da classe do
    /// personagem"). "General" fica de fora — toda classe pode aprender
    /// proficiências gerais, então não é o grupo de NINGUÉM em particular.
    var proficiencyGroup: String {
        switch self {
        case .fighter, .paladin, .ranger: return "Warrior"
        case .mage: return "Wizard"
        case .cleric, .druid: return "Priest"
        case .thief, .bard: return "Rogue"
        }
    }

    /// O dado de Hit Dice de cada classe — coluna "Hit Dice" das tabelas
    /// de progressão de experiência do PHB, já conferidas em
    /// `ExperienceProgressionTable` (Table 14: Warrior Experience Levels →
    /// "Hit Dice (d10)"; Table 20: Wizard → "d4"; Table 23: Priest →
    /// "d8"; Table 25: Rogue → "d6"). Usado por
    /// `PlayerCharacter.refreshHitDiceType()` pra preencher o campo "Hit
    /// Dice" sozinho quando o jogador escolhe a classe (pedido do usuário,
    /// 2026-09-22: "deve entrar naquele motor", o mesmo de XP needed for
    /// the next level).
    var hitDieType: String {
        switch self {
        case .fighter, .paladin, .ranger: return "d10"
        case .mage: return "d4"
        case .cleric, .druid: return "d8"
        case .thief, .bard: return "d6"
        }
    }

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

    /// Cenários de campanha ligados (ver `CampaignSettingCatalog`) — `nil`
    /// é o padrão (campanha nova, ou nunca mexeu nisso) e significa "sem
    /// filtro, mostra tudo", igual toda outra feature de sinalização deste
    /// app (esferas de acesso, etc.): nunca quebra campanha existente, só
    /// SOMA um filtro quando o jogador liga pelo menos um cenário. Um
    /// conjunto vazio (todos os cenários desligados na mão) tem o mesmo
    /// efeito de `nil` — só o conteúdo genérico/core apareceria, o que não
    /// faz sentido pra nenhuma mesa de verdade, então é tratado como "sem
    /// filtro" também (ver `allowsSetting`).
    var enabledSettings: Set<String>? = nil

    var displayTitle: String {
        name.isEmpty ? "Unnamed Campaign" : name
    }

    /// Verdadeiro quando `setting` deveria aparecer nas listas desta
    /// campanha — conteúdo genérico/core sempre aparece; o resto só
    /// aparece se a campanha não tiver filtro configurado, ou se tiver
    /// ligado esse cenário especificamente.
    func allowsSetting(_ setting: String?) -> Bool {
        if CampaignSettingCatalog.isGeneric(setting) { return true }
        guard let enabledSettings, !enabledSettings.isEmpty else { return true }
        guard let setting else { return true }
        return enabledSettings.contains(setting)
    }

    /// Mesma regra que `allowsSetting`, mas pra proficiências — que podem
    /// pertencer a mais de um cenário (`Proficiency.campaignSettings`):
    /// aparece se QUALQUER um dos cenários dela bater (união, não
    /// interseção — mesmo raciocínio do filtro por esfera do Grimório).
    func allowsAnySetting(_ settings: [String]) -> Bool {
        guard let enabledSettings, !enabledSettings.isEmpty else { return true }
        if settings.isEmpty { return true }
        if settings.contains(where: { CampaignSettingCatalog.isGeneric($0) }) { return true }
        return !Set(settings).isDisjoint(with: enabledSettings)
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

    /// Recalcula `xpNeededNextLevel` a partir de `ExperienceProgressionTable`
    /// (nível/classe atuais) e marca `recentAutoChange` pro `ChangeFlash`
    /// piscar da próxima vez que o campo aparecer. Método no MODELO (não só
    /// dentro de `ExperienceForm`) porque a página 2 da ficha vive dentro
    /// de um `UIPageViewController` (`RecordSheetPagerView`) que só
    /// atualiza a página VISÍVEL — mudar de nível/classe enquanto a página
    /// 1 está na tela não disparava o `onChange` de `ExperienceForm`
    /// (página 2, fora de vista, congelada) — bug relatado pelo usuário
    /// (2026-09-22): "ao subir ou descer de nível este campo não é
    /// atualizado". Chamado agora direto de onde nível/classe são editados
    /// (página 1), não só de dentro de `ExperienceForm`.
    mutating func refreshXPNeededNextLevel() {
        guard let text = ExperienceProgressionTable.xpNeededForNextLevel(
            currentLevel: level, class: characterClass
        ) else { return }
        guard xpNeededNextLevel != text else { return }
        xpNeededNextLevel = text
        markRecentAutoChange("xpNeededNextLevel")
    }

    /// Preenche `combat.hitDiceType` ("Hit Dice: __d__" na página 1, perto
    /// do THAC0) a partir de `CharacterClass.hitDieType` — mesmo "motor"
    /// de `refreshXPNeededNextLevel()`, pedido do usuário (2026-09-22).
    ///
    /// `force: true` (chamado de `ClassPicker.select`, na troca de
    /// classe): sempre resincroniza com a classe atual, igual o XP faz —
    /// bug relatado pelo usuário na v1.38 ("não tá refletindo ao trocar
    /// de classe"): a versão anterior só preenchia quando o campo estava
    /// vazio, então depois do primeiro preenchimento a troca de classe
    /// parava de atualizar o valor.
    ///
    /// `force: false` (padrão — chamado de `CombatForm.onAppear`, toda
    /// vez que a página aparece): só preenche quando o campo está VAZIO,
    /// nunca sobrescreve uma anotação que o jogador tenha escrito à mão —
    /// senão o safety net rodaria de novo a cada vez que a página
    /// aparecesse e apagaria qualquer texto customizado.
    mutating func refreshHitDiceType(force: Bool = false) {
        let expected = characterClass.hitDieType
        guard force || (combat?.hitDiceType ?? "").isEmpty else { return }
        guard combat?.hitDiceType != expected else { return }
        var updated = combat ?? CombatDetails()
        updated.hitDiceType = expected
        combat = updated
        markRecentAutoChange("hitDiceType")
    }

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

    // MARK: - Motor de Consequências (2026-09-19)
    //
    // Retrato de nível/atributos na última vez que o jogador revisou (ou
    // dispensou) a janela de consequências — não é "o que a ficha tinha
    // quando foi criada", é "o que já foi visto". Comparado contra
    // `level`/`abilities` atuais pra decidir se o sinal "•" aparece perto
    // do nível (ver `RecordHeaderForm`/`ConsequenceEngine`). Optional pelo
    // mesmo motivo de sempre: uma ficha salva antes desta versão não tem
    // essas chaves — `ensureConsequenceSnapshotInitialized()` preenche
    // com o valor atual na primeira vez que a ficha abre, silenciosamente,
    // pra não fazer todo personagem já existente aparecer com o sinal
    // aceso do nada.
    var lastAppliedLevel: Int? = nil
    var lastAppliedAbilities: AbilityScores? = nil

    /// Qual campo foi editado por último, entre os que o motor de
    /// consequências acompanha ("level", "strength", "dexterity",
    /// "constitution", "intelligence", "wisdom", "charisma") — decide ONDE
    /// mostrar o sinal (ver `effectiveChangedField`). Setado pelas views
    /// (`RecordHeaderForm`/`AbilityScoresForm`, via `.onChange`) a cada
    /// edição de verdade, e zerado em `markConsequencesReviewed()`.
    ///
    /// Existe porque o usuário testou a versão anterior (um sinal por
    /// campo mudado, todos ao mesmo tempo) e achou pior: "o ícone fica
    /// replicando a cada ajuste". Pediu pra deixar só UM sinal ativo — o
    /// do último campo mexido — mas que ao tocar continue mostrando a
    /// SOMA de todos os ajustes pendentes (por isso `ConsequencePreviewSheet`
    /// continua comparando `lastAppliedRuleContext` inteiro contra
    /// `currentRuleContext`, sem filtrar por este campo).
    var lastChangedField: String? = nil

    // MARK: - Sinal de "mudou sozinho" (2026-09-22)
    //
    // Pedido do usuário ao ver o seletor de Raça aplicando ajustes de
    // atributo/resistência mágica sozinho na ficha: "dá pra deixar o novo
    // valor numa outra cor por alguns segundos? Assim fica claro pro
    // player o que mudou". Chaves aqui são o MESMO vocabulário de
    // `lastChangedField` ("strength", "dexterity" etc.) mais campos que
    // esse outro sinal não cobre ("spellResistance", "racialAbilities") —
    // guarda só "isso foi tocado por uma ação automática e ainda não foi
    // mostrado piscando"; `ChangeFlash` (`Views/ChangeFlash.swift`) lê e
    // consome (remove a chave) na primeira vez que aquele campo aparece
    // na tela, então cada mudança pisca uma única vez, mesmo que o campo
    // fique fora da aba visível por um tempo antes do jogador chegar lá.
    /// Não existe pra tudo que muda (edição manual do jogador não entra
    /// aqui) — só pra mudanças que o APP fez sozinho, feitas fora da
    /// visão do jogador naquele instante (ex.: escolher raça mexe em
    /// Força/Constituição na aba Sheet enquanto ele está na aba
    /// Description). Optional pelo mesmo motivo de sempre.
    var recentAutoChanges: Set<String>? = nil

    /// Marca `key` pra piscar na próxima vez que aparecer na tela.
    mutating func markRecentAutoChange(_ key: String) {
        recentAutoChanges = (recentAutoChanges ?? []).union([key])
    }

    /// `true` enquanto `key` ainda não piscou — consultado a cada render
    /// do campo (não é um evento único), então quem chama decide quando
    /// "consumir" com `clearRecentAutoChange`.
    func hasRecentAutoChange(_ key: String) -> Bool {
        recentAutoChanges?.contains(key) ?? false
    }

    /// Consome a marca — chamado pelo `ChangeFlash` depois de agendar a
    /// animação, pra não piscar de novo a cada re-render enquanto o
    /// campo continua visível.
    mutating func clearRecentAutoChange(_ key: String) {
        recentAutoChanges?.remove(key)
    }

    /// `true` quando nível ou atributos mudaram desde a última revisão —
    /// liga o sinal "•" no cabeçalho da ficha.
    var hasPendingConsequences: Bool {
        guard let lastAppliedLevel, let lastAppliedAbilities else { return false }
        return lastAppliedLevel != level || lastAppliedAbilities != abilities
    }

    /// `true` só quando o NÍVEL mudou desde a última revisão.
    var hasPendingLevelChange: Bool {
        guard let lastAppliedLevel else { return false }
        return lastAppliedLevel != level
    }

    /// Mesma ideia de `hasPendingLevelChange`, mas por ATRIBUTO.
    func hasPendingAbilityChange(_ keyPath: KeyPath<AbilityScores, Int>) -> Bool {
        guard let lastAppliedAbilities else { return false }
        return lastAppliedAbilities[keyPath: keyPath] != abilities[keyPath: keyPath]
    }

    /// Qual campo deve mostrar o sinal de consequência agora — só UM de
    /// cada vez, nunca vários simultâneos (ver `lastChangedField` acima).
    /// Usa `lastChangedField` quando ele bate com alguma mudança ainda
    /// pendente; se não houver (ficha salva antes deste campo existir, com
    /// uma mudança pendente "órfã" — sem edição rastreada desde então),
    /// cai num fallback previsível (nível primeiro, depois cada atributo
    /// em ordem) em vez de simplesmente não mostrar sinal nenhum.
    var effectiveChangedField: String? {
        guard hasPendingConsequences else { return nil }
        if let lastChangedField, isPendingChange(forField: lastChangedField) {
            return lastChangedField
        }
        if hasPendingLevelChange { return "level" }
        if hasPendingAbilityChange(\.strength) { return "strength" }
        if hasPendingAbilityChange(\.dexterity) { return "dexterity" }
        if hasPendingAbilityChange(\.constitution) { return "constitution" }
        if hasPendingAbilityChange(\.intelligence) { return "intelligence" }
        if hasPendingAbilityChange(\.wisdom) { return "wisdom" }
        if hasPendingAbilityChange(\.charisma) { return "charisma" }
        return nil
    }

    /// Auxiliar de `effectiveChangedField`: o campo nomeado ainda tem uma
    /// mudança pendente de verdade? (evita apontar pro último campo
    /// editado se essa mudança específica já foi revisada por algum outro
    /// caminho, mas outras continuam pendentes.)
    private func isPendingChange(forField field: String) -> Bool {
        switch field {
        case "level": return hasPendingLevelChange
        case "strength": return hasPendingAbilityChange(\.strength)
        case "dexterity": return hasPendingAbilityChange(\.dexterity)
        case "constitution": return hasPendingAbilityChange(\.constitution)
        case "intelligence": return hasPendingAbilityChange(\.intelligence)
        case "wisdom": return hasPendingAbilityChange(\.wisdom)
        case "charisma": return hasPendingAbilityChange(\.charisma)
        default: return false
        }
    }

    /// Retrato "antes" pro `ConsequenceEngine.diff` — `nil` só na primeira
    /// abertura de uma ficha antiga, antes do snapshot inicial rodar.
    var lastAppliedRuleContext: RuleContext? {
        guard let lastAppliedLevel, let lastAppliedAbilities else { return nil }
        return RuleContext(level: lastAppliedLevel, characterClass: characterClass, abilities: lastAppliedAbilities)
    }

    /// Retrato "agora" pro `ConsequenceEngine.diff`.
    var currentRuleContext: RuleContext {
        RuleContext(level: level, characterClass: characterClass, abilities: abilities)
    }

    /// Chamado ao abrir a ficha (`.onAppear`). Só preenche o snapshot
    /// quando ainda não existe (ficha nova, ou salva antes desta versão) —
    /// sem marcar consequência nenhuma pra trás: só a partir daqui uma
    /// mudança de nível/atributo liga o sinal. Chamar de novo depois que
    /// já existe não faz nada (por isso é seguro repetir a cada
    /// `.onAppear`, sem apagar uma consequência pendente de verdade).
    mutating func ensureConsequenceSnapshotInitialized() {
        guard lastAppliedLevel == nil, lastAppliedAbilities == nil else { return }
        markConsequencesReviewed()
    }

    /// "Zera" o sinal: o snapshot passa a valer o nível/atributos atuais.
    /// Chamado depois que o jogador revisou a janela de consequências
    /// (aplicou as automáticas, ou fechou tendo visto) — ao contrário de
    /// `ensureConsequenceSnapshotInitialized()`, sempre sobrescreve.
    mutating func markConsequencesReviewed() {
        lastAppliedLevel = level
        lastAppliedAbilities = abilities
        lastChangedField = nil
    }

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

    /// Esferas de acesso (TODO.md item 16) — `nil`/vazio até o jogador
    /// preencher pela primeira vez (nenhuma ficha antiga tem essa chave).
    /// Guardado como dicionário esfera→nível em vez de dois `Set`s
    /// separados porque uma esfera só pode ter UM nível por personagem —
    /// o dicionário já impede o estado inválido "maior E menor ao mesmo
    /// tempo" que dois conjuntos permitiriam sem checagem extra.
    var sphereAccess: [String: SphereAccessLevel]? = nil

    /// `nil` quando a esfera não está marcada (nem maior nem menor) — o
    /// mesmo "sem preferência" de antes de o jogador mexer em nada.
    func sphereAccessLevel(for sphere: String) -> SphereAccessLevel? {
        sphereAccess?[sphere]
    }

    /// Só pra decidir se vale ordenar/sinalizar a lista de candidatos por
    /// esfera (`SlotEditorSheet`/`MemorizedRow` em `SpellSheetView.swift`)
    /// — personagem que nunca abriu o editor de esferas não deve ter a
    /// lista reordenada "sem querer" a partir de um mapa vazio.
    var hasConfiguredSphereAccess: Bool {
        !(sphereAccess?.isEmpty ?? true)
    }

    /// `true` quando QUALQUER esfera da magia está marcada (maior ou
    /// menor) — usado só pra ordenar/sinalizar, nunca pra esconder uma
    /// magia (decisão do usuário: o filtro de esferas não bloqueia).
    func hasSphereAccess(to spheres: [String]) -> Bool {
        guard let sphereAccess, !sphereAccess.isEmpty else { return false }
        return spheres.contains { sphereAccess[$0] != nil }
    }

    /// `true` quando ALGUMA esfera da magia está marcada como MAIOR —
    /// critério de ordenação mais forte que `hasSphereAccess(to:)` (TODO.md
    /// item 16, pedido do usuário 2026-09-20): acesso maior conjura em
    /// qualquer círculo, então é a aposta mais segura pra pôr no topo da
    /// lista, antes até de uma esfera marcada só como Menor (que trava no
    /// 3º círculo — ver `sphereSignal(for:)`). Só ordena, nunca esconde.
    func hasMajorSphereAccess(to spheres: [String]) -> Bool {
        spheres.contains { sphereAccessLevel(for: $0) == .major }
    }

    /// Aviso pra um candidato de magia na Folha de Magias (TODO.md item
    /// 16) — sempre só um SINAL, nunca um filtro. Centralizado aqui (em
    /// vez de duas versões quase iguais em `MemorizedRow`/`SlotEditorSheet`
    /// de `SpellSheetView.swift`) pra não arriscar as duas divergirem.
    func sphereSignal(for spell: Spell) -> SphereSignal? {
        guard hasConfiguredSphereAccess, !spell.spheres.isEmpty else { return nil }
        let matchedLevels = spell.spheres.compactMap { sphereAccessLevel(for: $0) }
        guard !matchedLevels.isEmpty else { return .outsideSpheres }
        // Tem a esfera, mas só como MENOR (regra do PHB: acesso menor
        // trava no 3º círculo) — se NENHUMA das esferas batidas for MAIOR
        // e a magia passa do 3º círculo, ela está fora do alcance mecânico
        // do personagem mesmo "tendo" a esfera.
        if spell.level > 3, !matchedLevels.contains(.major) {
            return .minorCircleCap
        }
        return nil
    }

    /// Prioridade de ordenação por esfera (TODO.md item 16, retocado
    /// 2026-09-20 — print do usuário mostrou o bug): antes o critério de
    /// ORDENAR (`hasMajorSphereAccess`) e o de AVISAR (`sphereSignal`) eram
    /// dois critérios DIFERENTES — uma magia com esfera Menor mas dentro do
    /// 3º círculo não mostrava aviso nenhum (`sphereSignal == nil`), mas
    /// também não contava como "esfera maior" pra ordenação, então ficava
    /// no mesmo grupo (sem prioridade) que uma magia de fato fora de
    /// qualquer esfera — resultado: magias SEM aviso apareciam espalhadas
    /// no meio de magias COM aviso, em vez de todas agrupadas no topo.
    /// Agora os dois usam a MESMA régua: 0 = esfera maior batida (aposta
    /// mais segura, vai pro topo), 1 = sem aviso nenhum (esfera menor
    /// dentro do alcance, ou magia sem `spheres` pra comparar — nem favor
    /// nem contra), 2 = com aviso (`sphereSignal` não é `nil`) — essas
    /// afundam TODAS juntas pro fim da lista. Devolve `1` (neutro, sem
    /// reordenar nada) quando o personagem não configurou esferas.
    func sphereSortRank(for spell: Spell) -> Int {
        guard hasConfiguredSphereAccess else { return 1 }
        if hasMajorSphereAccess(to: spell.spheres) { return 0 }
        return sphereSignal(for: spell) == nil ? 1 : 2
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
