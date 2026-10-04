# Dados em JSON

Regra: só código é compilado; dados ficam em `THAC0berry.swiftpm/Resources/*.json`
(UTF-8, neutro, reutilizável pelo futuro backend/web). Carregamento:
`Store/BundleJSON.swift` e os `Store/*Database.swift`.

**O formato de cada arquivo está definido em [`schemas/`](../schemas/README.md)**
(JSON Schema, espelhando o decode do Swift). Validar antes de toda entrega:

```
python Scripts/validate_schemas.py
```

`Scripts/validate_data.py` é o validador anterior (cobre só 6 arquivos e confere
contagens fixas de registros); mantido por enquanto, o de schemas é o que vale.

Convenções das tabelas de regras (`rules_*.json`): topo é objeto com
`schemaVersion`, `id`, `sourceRuleID`; chaves de grupo = `CoreClassGroup.rawValue`
(Warrior, Wizard, Priest, Rogue); listas por nível têm 20 posições, índice 0 =
nível 1.
