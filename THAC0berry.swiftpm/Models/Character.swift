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

    struct SaveEntry: Identifiable {
        let id: String
        let label: String
        let keyPath: WritableKeyPath<SavingThrows, Int>
    }

    static let labels: [SaveEntry] = [
        SaveEntry(id: "ppd", label: "Paralisia / Veneno / Morte",
                  keyPath: \.paralyzationPoisonDeath),
        SaveEntry(id: "rsw", label: "Varinha / Bastão / Cetro",
                  keyPath: \.rodStaffWand),
        SaveEntry(id: "pp", label: "Petrificação / Polimorfia",
                  keyPath: \.petrificationPolymorph),
        SaveEntry(id: "bw", label: "Sopro de dragão",
                  keyPath: \.breathWeapon),
        SaveEntry(id: "sp", label: "Magia",
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
}

/// As classes de personagem de AD&D 2e (livro do jogador). A classe decide
/// que ficha de magia a pasta abre — por ora só o Clérigo tem uma, a
/// Priest Spell Sheet; as outras classes conjuradoras (Mago, Druida) ganham
/// a delas mais pra frente.
enum CharacterClass: String, Codable, CaseIterable, Identifiable, Hashable {
    case fighter = "Guerreiro"
    case paladin = "Paladino"
    case ranger = "Patrulheiro"
    case mage = "Mago"
    case cleric = "Clérigo"
    case druid = "Druida"
    case thief = "Ladino"
    case bard = "Bardo"

    var id: String { rawValue }

    /// Só o Clérigo tem folha de magias por enquanto.
    var hasSpellSheet: Bool { self == .cleric }
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

    /// As sessões de mesa da campanha — cada uma agrupa um punhado de
    /// folhas de dia. Vive à parte das folhas pelo mesmo motivo que os
    /// slots: evita binding aninhado, e permite arquivar sem mexer nas
    /// folhas em si.
    var sessions: [Session] = []

    /// Uma grade de slots em branco (sem nada preparado ainda), do
    /// tamanho que a ficha do personagem diz que ele tem hoje.
    func freshSlotBoard() -> SpellSlotBoard {
        var board = SpellSlotBoard()
        for allotment in spellSlotAllotments where allotment.count > 0 {
            board.setCount(allotment.count, level: allotment.level, caster: allotment.caster)
        }
        return board
    }

    /// Folhas em ordem, da mais recente para a mais antiga.
    var sortedSpellSheets: [SpellSheet] {
        spellSheets.sorted { $0.date > $1.date }
    }

    /// A sessão "ativa": a mais recente que não está arquivada. Se não
    /// existir nenhuma (personagem novo, ou todas encerradas), cria uma
    /// sozinha, datada de hoje — é nela que "+ folha do dia" vai escrever.
    @discardableResult
    mutating func activeSession() -> Session {
        if let existing = sessions.filter({ !$0.isArchived }).max(by: { $0.date < $1.date }) {
            return existing
        }
        let created = Session(date: Date())
        sessions.append(created)
        return created
    }

    /// Antes de existir Sessão, as folhas viviam soltas na pasta. Na
    /// primeira leitura de uma ficha salva por uma versão anterior, agrupa
    /// as folhas órfãs numa sessão só, datada da mais antiga delas — sem
    /// isso elas sumiriam da faixa de abas, que agora navega por sessão.
    mutating func migrateLegacySheetsIfNeeded() {
        let orphanIndices = spellSheets.indices.filter { spellSheets[$0].sessionID == nil }
        guard !orphanIndices.isEmpty else { return }
        let earliest = orphanIndices.map { spellSheets[$0].date }.min() ?? Date()
        let legacy = Session(date: earliest, title: "Sessões antigas")
        sessions.append(legacy)
        for index in orphanIndices { spellSheets[index].sessionID = legacy.id }
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

    var displayTitle: String {
        name.isEmpty ? "Personagem sem nome" : name
    }

    var displaySubtitle: String {
        let parts = [race, characterClass.rawValue].filter { !$0.isEmpty }
        let base = parts.joined(separator: " ")
        return base.isEmpty ? "Nível \(level)" : "\(base) — nível \(level)"
    }
}
