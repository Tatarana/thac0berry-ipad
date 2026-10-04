# Schemas dos dados de referência

Contrato dos JSON em `THAC0berry.swiftpm/Resources/` (magias, kits, regras,
itens…). É a fonte de verdade do **formato** desses dados para o app iPad e,
no futuro, para o backend e a versão web. JSON Schema draft 2020-12.

Validar: `python Scripts/validate_schemas.py` (requer `pip install jsonschema`).
O CI (`.github/workflows/data.yml`) roda isso a cada push que mexe em dados,
schemas ou no validador.

## Arquivo → schema

| Arquivos | Schema | Modelo Swift |
|---|---|---|
| `sample_spells.json`, `priest_*.json`, `wizard_*.json` | `spell.schema.json` | `Models/Spell.swift` |
| `weapons.json` | `weapon.schema.json` | `Models/Weapon.swift` |
| `armor.json` | `armor.schema.json` | `Models/ArmorPiece.swift` |
| `mundane_items.json` | `mundane-item.schema.json` | `Models/MundaneItem.swift` |
| `deities.json` | `deity.schema.json` | `Models/Deity.swift` |
| `proficiencies.json` | `proficiency.schema.json` | `Models/Proficiency.swift` |
| `kits.json` | `kit.schema.json` | `Models/Kit.swift` |
| `magic_*.json` | `magic-item.schema.json` | `Models/MagicItem.swift` |
| `psionic_powers.json` | `psionic-power.schema.json` | `Models/PsionicPower.swift` |
| `rules.json` | `rule-entry.schema.json` | `Models/Rule.swift` |
| `rules_thac0.json` | `rules-thac0.schema.json` | `Store/RuleEngine/CoreRuleset/Thac0ByLevelProvider.swift` |
| `rules_saving_throws.json` | `rules-saving-throws.schema.json` | `Store/RuleEngine/CoreRuleset/SavingThrowsByLevelProvider.swift` |
| `rules_experience.json` | `rules-experience.schema.json` | `Models/ExperienceProgressionTable.swift` |

`spells.json` não é carregado pelo app (versão antiga de `sample_spells.json`)
e é pulado pelo validador.

## Como o schema espelha o Swift

O schema descreve o que o **decode do Swift aceita**, não o que "parece certo":

- `let x: T` no Swift → `x` em `required`, sem `null`.
- `let x: T?` (Codable sintetizado) ou `decodeIfPresent` num `init(from:)`
  próprio → opcional, aceita `null`.
- **Pegadinha:** `var x: T = valorPadrão` com Codable **sintetizado** continua
  exigindo a chave no JSON — o default do struct não vale pro decoder. Por
  isso `SpellDamage.bonus`, `isHealing` etc. são obrigatórios. (Foi esse o
  bug dos `priest_*.json` na v1.81–v1.86, ver `TODO.md`.)
- Campos a mais no JSON são aceitos (o decoder ignora). O validador lista
  esses campos como aviso; `--strict` transforma em erro. Hoje não há nenhum.

## Regra de mudança

Mudou um modelo Swift que decodifica um desses arquivos → atualize o schema
**no mesmo commit**. Campo novo em modelo existente entra como opcional
(`decodeIfPresent ?? default` no Swift, fora de `required` no schema), senão
os arquivos antigos deixam de decodificar.
