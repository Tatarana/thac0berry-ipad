import Foundation

/// Compara dois retratos de personagem (antes/depois de subir de nível ou
/// mudar um atributo) e produz as diferenças que a janela de consequências
/// mostra. Fica em cima do `RulesetRegistry` sem saber nada de módulo — só
/// pergunta pela `key` lógica, então um suplemento futuro (Dark Sun,
/// Ravenloft) mudando a resposta de "thac0" ou "savingThrows" não exige
/// tocar neste arquivo.
///
/// A lista de regras rastreadas (`trackedRules`) é o único lugar que sabe
/// COMO escrever um `RuleValue` de volta no `PlayerCharacter` — de
/// propósito: mantém `RuleProvider`/`RulesetRegistry` só de leitura, sem
/// acoplar o motor de regras ao formato exato da ficha.
enum ConsequenceEngine {
    private struct TrackedRule {
        let key: String
        let kind: ConsequenceItem.Kind
        let apply: ((RuleValue, inout PlayerCharacter) -> Void)?
    }

    /// Atalho pras regras de ajuste de atributo: todas seguem o mesmo
    /// formato (`RuleValue.string` → um campo de texto livre em
    /// `PlayerCharacter.details`), só muda a `key` e qual campo recebe.
    private static func abilityRule(_ key: String, write: @escaping (String, inout AbilityDetails) -> Void) -> TrackedRule {
        TrackedRule(key: key, kind: .autoApplicable, apply: { value, character in
            guard let text = value.stringValue else { return }
            write(text, &character.details)
        })
    }

    /// As regras cobertas até agora — HP por nível continua fora daqui de
    /// propósito (pede dado, e o motor nunca aplica nada que envolva
    /// rolagem). Ampliar esta lista é como o Motor de Consequências
    /// cresce, sem mexer na UI que a consome.
    private static let trackedRules: [TrackedRule] = [
        TrackedRule(key: "thac0", kind: .autoApplicable, apply: { value, character in
            guard let newTHAC0 = value.intValue else { return }
            character.thac0 = newTHAC0
        }),
        TrackedRule(key: "savingThrows", kind: .autoApplicable, apply: { value, character in
            guard let newSaves = value.savingThrowsValue else { return }
            character.saves = newSaves
        }),
        TrackedRule(key: "priestSpellSlots", kind: .alreadyAutomatic, apply: nil),

        // MARK: Ajustes de atributo (Tabelas 1-6) — cada um escreve num
        // campo de texto livre pré-existente em `AbilityDetails` (a mesma
        // struct que já alimenta a seção "o que o app sabe calcular" da
        // ficha). Ver `AbilityDetailProvider.swift` pra origem dos dados.
        abilityRule("strengthHit", write: { text, details in details.strengthHit = text }),
        abilityRule("strengthDamage", write: { text, details in details.strengthDamage = text }),
        abilityRule("strengthWeight", write: { text, details in details.strengthWeight = text }),
        abilityRule("strengthMaxPress", write: { text, details in details.strengthMaxPress = text }),
        abilityRule("strengthDoors", write: { text, details in details.strengthDoors = text }),
        abilityRule("strengthBars", write: { text, details in details.strengthBars = text }),

        abilityRule("dexterityReaction", write: { text, details in details.dexterityReaction = text }),
        abilityRule("dexterityMissile", write: { text, details in details.dexterityMissile = text }),
        abilityRule("dexterityDefense", write: { text, details in details.dexterityDefense = text }),

        abilityRule("constitutionHP", write: { text, details in details.constitutionHP = text }),
        abilityRule("constitutionShock", write: { text, details in details.constitutionShock = text }),
        abilityRule("constitutionResurrection", write: { text, details in details.constitutionResurrection = text }),
        abilityRule("constitutionPoison", write: { text, details in details.constitutionPoison = text }),

        abilityRule("intelligenceLanguages", write: { text, details in details.intelligenceLanguages = text }),
        abilityRule("intelligenceMaxLevel", write: { text, details in details.intelligenceMaxLevel = text }),
        abilityRule("intelligenceLearn", write: { text, details in details.intelligenceLearn = text }),
        abilityRule("intelligenceMaxPerLevel", write: { text, details in details.intelligenceMaxPerLevel = text }),

        abilityRule("wisdomDefense", write: { text, details in details.wisdomDefense = text }),
        abilityRule("wisdomFailure", write: { text, details in details.wisdomFailure = text }),
        abilityRule("wisdomBonusSpells", write: { text, details in details.wisdomBonusSpells = text }),

        abilityRule("charismaHenchmen", write: { text, details in details.charismaHenchmen = text }),
        abilityRule("charismaLoyalty", write: { text, details in details.charismaLoyalty = text }),
        abilityRule("charismaReaction", write: { text, details in details.charismaReaction = text }),
    ]

    /// Diferenças entre `old` e `new` pra cada regra rastreada. Uma regra
    /// só vira item quando o valor resolvido realmente muda — inclusive
    /// quando um lado é `nil` (ex. saiu do alcance da tabela).
    static func diff(old: RuleContext, new: RuleContext, registry: RulesetRegistry) -> [ConsequenceItem] {
        var items: [ConsequenceItem] = []

        for rule in trackedRules {
            let oldResolved = registry.resolve(key: rule.key, context: old)
            let newResolved = registry.resolve(key: rule.key, context: new)
            guard oldResolved?.value != newResolved?.value else { continue }

            let label = newResolved?.provider.label ?? oldResolved?.provider.label ?? rule.key
            let sourceRuleID = newResolved?.provider.sourceRuleID(for: new)
                ?? oldResolved?.provider.sourceRuleID(for: old)

            items.append(ConsequenceItem(
                id: rule.key,
                label: label,
                oldValue: oldResolved?.value,
                newValue: newResolved?.value,
                sourceRuleID: sourceRuleID,
                kind: rule.kind
            ))
        }

        return items
    }

    /// Aplica no personagem só os itens automáticos (`.autoApplicable`) —
    /// os `.alreadyAutomatic` não têm o que aplicar, e nada aqui pede dado
    /// (por enquanto o motor só cobre regra determinística; um item que
    /// dependesse de rolagem entraria com um terceiro `Kind` que este
    /// método simplesmente ignoraria).
    static func applyAutomatic(_ items: [ConsequenceItem], to character: inout PlayerCharacter) {
        for item in items where item.kind == .autoApplicable {
            guard let newValue = item.newValue else { continue }
            guard let rule = trackedRules.first(where: { $0.key == item.id }),
                  let apply = rule.apply
            else { continue }
            apply(newValue, &character)
        }
    }
}
