import Foundation

/// Um "kit" de sacerdote — a especialização/origem de personagem descrita
/// em livros como *The Complete Priest's Handbook* (kits genéricos, tipo
/// Fighting-Monk ou Warrior Priest) e nos guias regionais de Forgotten
/// Realms (sacerdote especializado de uma divindade específica, tipo
/// "Selûne - Silver Lady"). Ambos entram no mesmo arquivo/array porque a
/// wiki de origem já os trata como a mesma categoria ("Character Kit") —
/// só o subconjunto de campos preenchidos muda: os quatro campos de
/// divindade (`deity`/`pantheon`/`setting`/`titleInChurch`) só existem nos
/// kits de sacerdote especializado, `nil` no resto (ver `isSpecialtyPriest`).
///
/// Os 91 kits em si (97 originais menos os 6 "Create Your Own" — cartas em
/// branco sem regra nenhuma, removidos por não servirem pra nada num app de
/// fichas) vêm de `EmbeddedKits.kits` (`Store/EmbeddedKits.swift`)
/// — literais Swift de verdade, não JSON de bundle (ver o comentário
/// grande lá e em `KitDatabase` pro porquê: três tentativas diferentes de
/// ler isso de um recurso JSON falharam, e a causa real só apareceu depois
/// de tudo — 13 dos 97 kits não têm a chave `mechanics.armor.allowedTypes`,
/// o que derrubava o decode do array inteiro). O JSON original convertido
/// da wiki por um pipeline separado (fora do app), mesmo espírito de
/// `Scripts/convert_spells.py`, ainda é a fonte de onde `EmbeddedKits.swift`
/// foi gerado — só não faz mais parte do bundle do app.
struct Kit: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let wikiPageTitle: String
    let redirectAliases: [String]
    let classEligibility: KitClassEligibility
    let sourceBook: String
    let features: KitFeatures
    let description: KitDescription
    let categories: [String]
    let mechanics: KitMechanics

    // Só preenchidos para kit de sacerdote especializado (um por divindade).
    let deity: String?
    let pantheon: String?
    let setting: String?
    let titleInChurch: String?

    var isSpecialtyPriest: Bool { deity != nil }
}

struct KitClassEligibility: Codable, Hashable {
    let classGroup: String
    /// "Cleric", "Druid", "Any Priest" ou "Specialty Priest" — mais
    /// granular que `allowedClasses` (que já veio pronto pra filtrar) mas
    /// útil pra exibir de forma legível ("kit de Druid", etc.).
    let subclass: String
    let allowedClasses: [String]
}

struct KitDescription: Codable, Hashable {
    /// Resumo de um parágrafo, pra listas/cards.
    let briefSummary: String
    /// Texto corrido já limpo de marcação de wiki — pronto pra exibir
    /// direto numa `Text`/`PaperTextEditor` de detalhe.
    let fullText: String
    /// Wikitext original, mantido só como referência/depuração — não é
    /// pensado pra aparecer na UI.
    let rawWikitext: String
}

/// Texto livre por seção, como aparece no livro — cada campo é `nil`
/// quando o kit de origem não descreve aquela seção. `mechanics` cobre o
/// mesmo terreno de forma estruturada quando dá pra extrair um valor
/// (dados, listas); isto aqui é a prosa completa, pra exibir sem perder
/// nuance que a extração estruturada não capturou.
struct KitFeatures: Codable, Hashable {
    let role: String?
    let requirements: String?
    let specialBenefits: String?
    let specialHindrances: String?
    let wealthOptions: String?
    let weaponProficiencies: String?
    let nonweaponProficiencies: String?
    let equipment: String?
}

struct KitMechanics: Codable, Hashable {
    let requirements: KitRequirements
    let weapons: KitWeaponRules
    let proficiencies: KitProficiencyRules
    let armor: KitArmorRules
    let turnUndead: KitTurnUndeadRules
    /// Formato "dados" livre, ex. "3d6x10 gp" — mantido como texto porque
    /// já vem com o multiplicador embutido (ex.: "3d6x10") em vez de dado +
    /// fator separados, sem padrão fixo o bastante pra valer estruturar.
    let startingCash: String?
}

struct KitRequirements: Codable, Hashable {
    /// Chaves são o nome do atributo em inglês, como no livro
    /// ("Strength", "Wisdom", ...) — dicionário em vez de seis campos
    /// opcionais porque só os atributos exigidos aparecem.
    let abilities: [String: Int]
    let alignments: [String]
    let races: String?
}

struct KitWeaponRules: Codable, Hashable {
    let required: [String]
    let recommended: [String]
    let forbidden: [String]
    let notes: String?
}

struct KitProficiencyRules: Codable, Hashable {
    let bonus: [String]
    let recommended: [String]
    let notes: String?
}

struct KitArmorRules: Codable, Hashable {
    let allowedTypes: KitArmorRestriction
    let shieldsAllowed: KitArmorRestriction
    let metalAllowed: Bool
    /// Só preenchido quando o kit limita a CA alcançável (ex. monges
    /// desarmados) — texto livre porque o valor já vem como categoria
    /// ("leather_or_padded"), não um número, no arquivo de origem.
    let maxArmorClass: String?
    let notes: String

    /// Escrever `init(from:)` à mão (abaixo) tira o memberwise init
    /// sintetizado automaticamente — recriado aqui porque
    /// `EmbeddedKits.swift` constrói `KitArmorRules` direto por literal,
    /// sem passar por decode nenhum.
    init(allowedTypes: KitArmorRestriction, shieldsAllowed: KitArmorRestriction,
         metalAllowed: Bool, maxArmorClass: String?, notes: String) {
        self.allowedTypes = allowedTypes
        self.shieldsAllowed = shieldsAllowed
        self.metalAllowed = metalAllowed
        self.maxArmorClass = maxArmorClass
        self.notes = notes
    }

    /// `init(from:)` escrito à mão porque `allowedTypes` some por completo
    /// (não é `null` — a CHAVE não existe) em 13 dos 97 kits de origem —
    /// achado só depois de um decode inteiro falhando silenciosamente com
    /// "The data couldn't be read because it is missing" (é a mensagem
    /// genérica que o Swift dá pra `DecodingError.keyNotFound`, fácil de
    /// confundir com bundle/arquivo sumido — ver `KitDatabase`/`TODO.md`
    /// item 9 pro caso real que isso causou). Chave ausente vira `.asClass`
    /// — mesma leitura de "sem restrição própria do kit" que a string
    /// sentinela `"as_class"` já significa.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        allowedTypes = try container.decodeIfPresent(KitArmorRestriction.self, forKey: .allowedTypes) ?? .asClass
        shieldsAllowed = try container.decodeIfPresent(KitArmorRestriction.self, forKey: .shieldsAllowed) ?? .asClass
        metalAllowed = try container.decode(Bool.self, forKey: .metalAllowed)
        maxArmorClass = try container.decodeIfPresent(String.self, forKey: .maxArmorClass)
        notes = try container.decode(String.self, forKey: .notes)
    }
}

/// `allowedTypes`/`shieldsAllowed` vêm do arquivo de origem de duas formas:
/// a string sentinela `"as_class"` (sem restrição além da já imposta pela
/// classe base) ou uma lista concreta de tipos permitidos/proibidos.
/// Decodifica tentando lista primeiro, e trata qualquer string como
/// "sem restrição própria do kit" — não só `"as_class"` — pra não quebrar
/// o carregamento se uma regeneração futura do arquivo usar outra
/// sentinela.
enum KitArmorRestriction: Codable, Hashable {
    case asClass
    case specific([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let types = try? container.decode([String].self) {
            self = .specific(types)
        } else {
            _ = try container.decode(String.self)
            self = .asClass
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .asClass:
            try container.encode("as_class")
        case .specific(let types):
            try container.encode(types)
        }
    }

    var specificTypes: [String]? {
        if case .specific(let types) = self { return types }
        return nil
    }
}

struct KitTurnUndeadRules: Codable, Hashable {
    let capable: Bool
    /// "allowed" / "modified" / "forbidden" no arquivo de origem — mantido
    /// como texto (em vez de enum fechado) porque este arquivo já passou
    /// por três rodadas de correção de dados; um valor novo/inesperado aqui
    /// não pode derrubar o carregamento do kit inteiro.
    let mode: String
    let notes: String
}
