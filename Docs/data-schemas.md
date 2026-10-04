# Dados em JSON (Fase 1)
Regra: só código é compilado; dados ficam em `Resources/*.json` (UTF-8, neutro, reutilizável pelo futuro backend/web).
Validar antes de toda entrega: `python3 Scripts/validate_data.py`. Carregamento: `Store/BundleJSON.swift`.

- `weapons.json` — array de `Weapon` {id, name, size?, type?, speedFactor, attacksPerRound, damageSmall?, damageLarge?, range?{short?,medium?,long?}, source?}
- `armor.json` — array de `ArmorPiece` {id, name, kind: armor|helmet|shield, baseAC?, cost?, weight?}
- `mundane_items.json` — array de `MundaneItem` {id, name, category, cost?, weight?}
- `sample_spells.json` — array de `Spell` (exemplos do Kelmon), mesmo formato dos `priest_*/wizard_*`.

## Tabelas de regras (Fase 2)
Topo = objeto com `schemaVersion`, `id`, `sourceRuleID`. Chaves de grupo = `CoreClassGroup.rawValue` (Warrior, Wizard, Priest, Rogue).
- `rules_thac0.json` — `groups.<G>`: array de 20 inteiros (índice 0 = nível 1).
- `rules_saving_throws.json` — `groups.<G>`: array de faixas `{maxLevel: Int|null, values:{paralyzationPoisonDeath, rodStaffWand, petrificationPolymorph, breathWeapon, spell}}`; `maxLevel` null = "N+".
- `rules_experience.json` — `thresholds.<CharacterClass.rawValue>`: 20 inteiros (índice 0 = nível 1, XP mínimo). `classNotes` = observações do livro.
