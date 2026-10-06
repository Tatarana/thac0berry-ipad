// Gera os valores de referência das regras de jogo do app (rules-fixtures.json)
// a partir do PRÓPRIO código Swift: compilado no CI (macOS) junto com
// THAC0berry.swiftpm/Models, Store (menos CharacterLibrary.swift, que usa
// SwiftUI) e Utils. A versão web reimplementa as regras em TypeScript e o CI
// de lá compara com este arquivo, valor a valor.
//
// Fica fora de THAC0berry.swiftpm/ de propósito: tudo lá dentro entra no app.
// Uso (ver .github/workflows/rules-fixtures.yml): os JSON de regra
// (Resources/rules_*.json) precisam estar na mesma pasta do executável,
// porque os providers leem via Bundle.main.
//
// Saída determinística (chaves ordenadas, sem data nem commit), para que
// "mudou o arquivo" signifique "mudou alguma regra".

import Foundation

// MARK: - Serialização genérica (Mirror), para as tabelas estáticas

func encode(_ value: Any) -> Any {
    let mirror = Mirror(reflecting: value)
    switch mirror.displayStyle {
    case .optional:
        guard let wrapped = mirror.children.first?.value else { return NSNull() }
        return encode(wrapped)
    case .enum:
        if let raw = value as? any RawRepresentable { return encode(raw.rawValue) }
        return String(describing: value)
    case .collection:
        return mirror.children.map { encode($0.value) }
    case .set:
        // Conjunto não tem ordem: ordena pela forma serializada.
        return mirror.children.map { encode($0.value) }.sorted { serialized($0) < serialized($1) }
    case .dictionary:
        var object: [String: Any] = [:]
        for child in mirror.children {
            let pair = Array(Mirror(reflecting: child.value).children)
            guard pair.count == 2 else { continue }
            object[String(describing: pair[0].value)] = encode(pair[1].value)
        }
        return object
    case .tuple, .struct, .class:
        var object: [String: Any] = [:]
        for (index, child) in mirror.children.enumerated() {
            let label = child.label.map { $0.hasPrefix(".") ? String($0.dropFirst()) : $0 } ?? "\(index)"
            object[label] = encode(child.value)
        }
        return object
    default:
        return value
    }
}

func serialized(_ value: Any) -> String {
    let data = (try? JSONSerialization.data(withJSONObject: [value], options: [.sortedKeys])) ?? Data()
    return String(decoding: data, as: UTF8.self)
}

func encodeRule(_ value: RuleValue?) -> Any {
    guard let value else { return NSNull() }
    switch value {
    case .int(let number): return number
    case .intByCircle(let counts): return counts
    case .savingThrows(let saves): return encode(saves)
    case .string(let text): return text
    }
}

func orNull(_ value: Any?) -> Any { value ?? NSNull() }

// MARK: - Entradas percorridas

let classes = CharacterClass.allCases
let levels = Array(0...21)          // inclui as bordas (0 e 21 = fora da tabela)
let scores = Array(1...25)
let registry = RulesetRegistry()

func abilities(_ change: (inout AbilityScores) -> Void) -> AbilityScores {
    var scores = AbilityScores()
    change(&scores)
    return scores
}

// Sanidade: sem os JSON ao lado do executável, tudo viria nulo sem erro.
guard registry.resolve(key: "thac0", context: RuleContext(level: 1, characterClass: .fighter, abilities: AbilityScores())) != nil else {
    FileHandle.standardError.write(Data("rules_thac0.json não encontrado ao lado do executável\n".utf8))
    exit(1)
}

var output: [String: Any] = [:]

// MARK: - Atributos (Tabelas 1 a 6): cada chave varia só o próprio atributo

let abilityKeys = AbilityDetailProviders.all.map(\.key)
var abilityDetails: [String: Any] = [:]
for key in abilityKeys {
    var byScore: [String: Any] = [:]
    for score in scores {
        let a = abilities { a in
            if key.hasPrefix("strength") { a.strength = score }
            if key.hasPrefix("dexterity") { a.dexterity = score }
            if key.hasPrefix("constitution") { a.constitution = score }
            if key.hasPrefix("intelligence") { a.intelligence = score }
            if key.hasPrefix("wisdom") { a.wisdom = score }
            if key.hasPrefix("charisma") { a.charisma = score }
        }
        let context = RuleContext(level: 1, characterClass: .fighter, abilities: a)
        byScore["\(score)"] = encodeRule(registry.resolve(key: key, context: context)?.value)
    }
    abilityDetails[key] = byScore
}
output["abilityDetails"] = abilityDetails

// Força excepcional (18/01 a 18/00 = 1 a 100)
var exceptional: [String: Any] = [:]
for key in abilityKeys where key.hasPrefix("strength") {
    var byPercent: [String: Any] = [:]
    for percent in 1...100 {
        let a = abilities { $0.strength = 18; $0.exceptionalStrength = percent }
        let context = RuleContext(level: 1, characterClass: .fighter, abilities: a)
        byPercent["\(percent)"] = encodeRule(registry.resolve(key: key, context: context)?.value)
    }
    exceptional[key] = byPercent
}
output["strengthExceptional"] = exceptional

// MARK: - Por classe e nível (atributos padrão, 10)

let levelKeys = ["thac0", "savingThrows", "priestSpellSlots", "wizardSpellSlots", "bardSpellSlots"]
var byClassLevel: [String: Any] = [:]
for characterClass in classes {
    var byLevel: [String: Any] = [:]
    for level in levels {
        var entry: [String: Any] = [:]
        let context = RuleContext(level: level, characterClass: characterClass, abilities: AbilityScores())
        for key in levelKeys {
            entry[key] = encodeRule(registry.resolve(key: key, context: context)?.value)
        }
        entry["xpRequired"] = orNull(ExperienceProgressionTable.xpRequired(for: level, class: characterClass))
        entry["xpNeededForNextLevel"] = orNull(ExperienceProgressionTable.xpNeededForNextLevel(currentLevel: level, class: characterClass))
        entry["xpNote"] = orNull(ExperienceProgressionTable.note(for: characterClass, level: level))
        entry["backstabMultiplier"] = ThievingSkillsTable.backstabMultiplier(level: level)
        entry["weaponSlots"] = ProficiencySlotsTable.totalWeaponSlots(for: characterClass, level: level)
        var withIntelligence: [String: Any] = [:]
        for score in scores {
            withIntelligence["\(score)"] = ProficiencySlotsTable.totalWeaponSlots(for: characterClass, level: level, intelligence: score)
        }
        entry["weaponSlotsByIntelligence"] = withIntelligence
        byLevel["\(level)"] = entry
    }
    byClassLevel[characterClass.rawValue] = byLevel
}
output["byClassLevel"] = byClassLevel

// MARK: - Propriedades de cada classe

var classInfo: [String: Any] = [:]
for characterClass in classes {
    var character = PlayerCharacter()
    character.characterClass = characterClass
    character.levelChanges = nil
    ConsequenceEngine.refreshLevelChanges(for: &character, registry: registry, force: true)
    var baseScores: [String: Any] = [:]
    for skill in ThievingSkillsTable.allSkills {
        baseScores[skill] = ThievingSkillsTable.baseScore(skill: skill, characterClass: characterClass)
    }
    classInfo[characterClass.rawValue] = [
        "proficiencyGroup": characterClass.proficiencyGroup,
        "hitDieType": characterClass.hitDieType,
        "hasSpellSheet": characterClass.hasSpellSheet,
        "isArcaneCaster": characterClass.isArcaneCaster,
        "hasReferencePage": characterClass.hasReferencePage,
        "hasThievingSkills": characterClass.hasThievingSkills,
        "recordSheetPageCount": characterClass.recordSheetPageCount,
        "proficiencyTableGroup": ProficiencySlotsTable.group(for: characterClass),
        "proficiencyRow": encode(ProficiencySlotsTable.row(for: characterClass) as Any),
        "nonProficiencyPenalty": ProficiencySlotsTable.nonProficiencyPenalty(for: characterClass),
        "thievingSkills": ThievingSkillsTable.skills(for: characterClass),
        "thievingBaseScores": baseScores,
        "levelChanges": encode(character.levelChanges as Any),
    ]
}
output["classes"] = classInfo

// MARK: - Progressão de magias (nível × atributo) e slots da ficha

func progression(_ compute: (Int, Int) -> [Int]) -> [String: Any] {
    var byLevel: [String: Any] = [:]
    for level in levels {
        var byScore: [String: Any] = [:]
        for score in scores { byScore["\(score)"] = compute(level, score) }
        byLevel["\(level)"] = byScore
    }
    return byLevel
}
output["spellProgression"] = [
    "priest": progression { PriestTables.spellProgression(level: $0, wisdom: $1) },
    "wizard": progression { WizardTables.spellProgression(level: $0, intelligence: $1) },
    "bard": progression { BardTables.spellProgression(level: $0, intelligence: $1) },
]

func allotments(_ characterClass: CharacterClass, school: WizardSchool? = nil) -> [String: Any] {
    var byLevel: [String: Any] = [:]
    for level in levels {
        var byScore: [String: Any] = [:]
        for score in scores {
            var character = PlayerCharacter()
            character.characterClass = characterClass
            character.level = level
            character.abilities.wisdom = score
            character.abilities.intelligence = score
            character.wizardSchool = school
            byScore["\(score)"] = character.computedSpellSlotAllotments.map { ["caster": $0.caster.rawValue, "level": $0.level, "count": $0.count] }
        }
        byLevel["\(level)"] = byScore
    }
    return byLevel
}
output["slotAllotments"] = [
    "Cleric": allotments(.cleric),
    "Mage": allotments(.mage),
    "Mage (specialist)": allotments(.mage, school: .abjuration),
    "Bard": allotments(.bard),
]

// MARK: - Perícias de ladrão

var dexterity: [String: Any] = [:]
for score in scores {
    var bySkill: [String: Any] = [:]
    for skill in ThievingSkillsTable.allSkills {
        bySkill[skill] = ThievingSkillsTable.dexterityAdjustment(skill: skill, dexterity: score)
    }
    dexterity["\(score)"] = bySkill
}
// "Half-Elf" fica de fora: racialAdjustment percorre um dicionário (ordem
// aleatória a cada execução) e "half elf" também contém "elf", então o
// resultado muda de uma execução para outra. Bug registrado no TODO.md.
var racial: [String: Any] = [:]
for race in ["Human", "Dwarf", "Hill Dwarf", "Elf", "Grey Elf", "Gnome", "Halfling", "Stout Halfling", ""] {
    var bySkill: [String: Any] = [:]
    for skill in ThievingSkillsTable.allSkills {
        bySkill[skill] = ThievingSkillsTable.racialAdjustment(skill: skill, race: race)
    }
    racial[race] = bySkill
}
output["thieving"] = [
    "allSkills": ThievingSkillsTable.allSkills,
    "dexterityAdjustment": dexterity,
    "racialAdjustment": racial,
]

// MARK: - Sabedoria e Inteligência (funções usadas fora dos providers)

var wisdom: [String: Any] = [:]
var intelligence: [String: Any] = [:]
for score in scores {
    wisdom["\(score)"] = [
        "bonusSpells": orNull(WisdomTable.bonusSpells(forScore: score)),
        "bonusSpellTotals": encode(WisdomTable.bonusSpellTotals(forScore: score) as Any),
    ]
    intelligence["\(score)"] = [
        "maxSpellLevelInt": IntelligenceTable.maxSpellLevelInt(forScore: score),
        "bonusLanguages": IntelligenceTable.bonusLanguages(forScore: score),
    ]
}
output["wisdom"] = wisdom
output["intelligence"] = intelligence

// MARK: - Tabelas estáticas (páginas de referência da ficha)

output["tables"] = [
    "StrengthTable.byScore": encode(StrengthTable.byScore),
    "StrengthTable.byExceptionalUpperBound": encode(StrengthTable.byExceptionalUpperBound),
    "DexterityTable.byScore": encode(DexterityTable.byScore),
    "ConstitutionTable.byScore": encode(ConstitutionTable.byScore),
    "IntelligenceTable.byScore": encode(IntelligenceTable.byScore),
    "WisdomTable.byScore": encode(WisdomTable.byScore),
    "CharismaTable.byScore": encode(CharismaTable.byScore),
    "PriestTables.spellProgressionRows": encode(PriestTables.spellProgressionRows),
    "PriestTables.wisdomRequirementByCircle": encode(PriestTables.wisdomRequirementByCircle),
    "PriestTables.turningUndeadLevels": encode(PriestTables.turningUndeadLevels),
    "PriestTables.turningUndeadRows": encode(PriestTables.turningUndeadRows),
    "PriestTables.turningUndeadFootnotes": encode(PriestTables.turningUndeadFootnotes),
    "PriestTables.wisdomRows": encode(PriestTables.wisdomRows),
    "WizardTables.spellProgressionRows": encode(WizardTables.spellProgressionRows),
    "BardTables.spellProgressionRows": encode(BardTables.spellProgressionRows),
    "ThievingSkillsTable.thiefBaseScores": encode(ThievingSkillsTable.thiefBaseScores),
    "ThievingSkillsTable.ninjaBaseScores": encode(ThievingSkillsTable.ninjaBaseScores),
    "ThievingSkillsTable.bardBaseScores": encode(ThievingSkillsTable.bardBaseScores),
    "ThievingSkillsTable.racialAdjustments": encode(ThievingSkillsTable.racialAdjustments),
    "ThievingSkillsTable.dexterityAdjustments": encode(ThievingSkillsTable.dexterityAdjustments),
    "ThievingSkillsTable.thiefArmorColumns": encode(ThievingSkillsTable.thiefArmorColumns),
    "ThievingSkillsTable.thiefArmorAdjustments": encode(ThievingSkillsTable.thiefArmorAdjustments),
    "ThievingSkillsTable.ninjaArmorColumns": encode(ThievingSkillsTable.ninjaArmorColumns),
    "ThievingSkillsTable.ninjaArmorAdjustments": encode(ThievingSkillsTable.ninjaArmorAdjustments),
    "ProficiencySlotsTable.rows": encode(ProficiencySlotsTable.rows),
]

output["about"] = "Gerado por thac0berry-ipad/Scripts/rules_fixtures/main.swift a partir do código Swift do app. Não edite à mão."

let data = try JSONSerialization.data(withJSONObject: output, options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes])
FileHandle.standardOutput.write(data)
FileHandle.standardOutput.write(Data("\n".utf8))
