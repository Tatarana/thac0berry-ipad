#!/usr/bin/env python3
"""Gera Store/EmbeddedProficiencies.swift + EmbeddedProficiencies_PartN.swift
a partir dos JSON de origem em tmp-data/proficiencies/ (general.json,
priest.json, rogue.json, warrior.json, wizard.json, psionicist.json,
other_and_racial.json).

Mesma técnica de EmbeddedKits.swift/EmbeddedRules.swift: cada proficiência
vira uma constante Swift TIPADA (`let embeddedProficiencyNNNN: Proficiency
= Proficiency(...)`), espalhadas em vários arquivos (~15 por parte) — um
array literal único com todas as 372 de uma vez trava o type-checker do
Swift Playgrounds ("Build Failed" sem mensagem, já vivido com Kits, ver
TODO.md item 9). NUNCA volte a ler isso como JSON de bundle em runtime —
mesmo problema, três vezes documentado (spells.json, priestKits.json).

Uso: python3 generate_embedded_proficiencies.py <pasta com os 7 json> <pasta Store/ de saída>
"""
import json
import sys
from pathlib import Path

GROUP_FILES = [
    "general.json", "priest.json", "rogue.json",
    "warrior.json", "wizard.json", "psionicist.json", "other_and_racial.json",
]

PER_PART = 15


def swift_string(s: str) -> str:
    """Escapa uma string Python pro conteúdo de um literal Swift entre aspas."""
    out = []
    for ch in s:
        if ch == "\\":
            out.append("\\\\")
        elif ch == '"':
            out.append('\\"')
        elif ch == "\n":
            out.append("\\n")
        elif ch == "\t":
            out.append("\\t")
        elif ch == "\r":
            out.append("\\r")
        else:
            out.append(ch)
    return "".join(out)


def swift_str_array(items):
    return "[" + ", ".join(f'"{swift_string(x)}"' for x in items) + "]"


def render_proficiency(const_name: str, e: dict) -> str:
    m = e["mechanics"]
    sap = e.get("skillsAndPowers")
    if sap:
        sub_ability = sap.get("subAbility")
        sub_ability_swift = f'"{swift_string(sub_ability)}"' if sub_ability is not None else "nil"
        cost = sap.get("characterPointCost")
        cost_swift = str(int(cost)) if cost is not None else "nil"
        sap_swift = (
            "ProficiencySkillsAndPowers(\n"
            f'            subAbility: {sub_ability_swift},\n'
            f'            characterPointCost: {cost_swift},\n'
            f'            baseRating: "{swift_string(sap["baseRating"])}"\n'
            "        )"
        )
    else:
        sap_swift = "nil"

    return f"""let {const_name}: Proficiency = Proficiency(
    id: "{swift_string(e['id'])}",
    name: "{swift_string(e['name'])}",
    wikiPageTitle: "{swift_string(e['wikiPageTitle'])}",
    redirectAliases: {swift_str_array(e.get('redirectAliases', []))},
    primaryGroup: "{swift_string(e['primaryGroup'])}",
    campaignSettings: {swift_str_array(e['campaignSettings'])},
    mechanics: ProficiencyMechanics(
        groups: {swift_str_array(m['groups'])},
        slotsRequired: {int(m['slotsRequired'])},
        rawSlots: "{swift_string(m['rawSlots'])}",
        relevantAbility: "{swift_string(m['relevantAbility'])}",
        checkModifier: {int(m['checkModifier'])},
        rawModifier: "{swift_string(m['rawModifier'])}",
        prerequisites: {swift_str_array(m.get('prerequisites', []))}
    ),
    skillsAndPowers: {sap_swift},
    description: ProficiencyDescription(
        briefSummary: "{swift_string(e['description']['briefSummary'])}",
        fullText: "{swift_string(e['description']['fullText'])}"
    )
)
"""


def main():
    src_dir = Path(sys.argv[1])
    out_dir = Path(sys.argv[2])

    entries = []
    seen_ids = set()
    for fname in GROUP_FILES:
        data = json.loads((src_dir / fname).read_text(encoding="utf-8"))
        for e in data:
            if e["id"] in seen_ids:
                raise SystemExit(f"ID duplicado: {e['id']} (em {fname})")
            seen_ids.add(e["id"])
            entries.append(e)

    entries.sort(key=lambda e: e["id"])
    print(f"total: {len(entries)} proficiências")

    parts = [entries[i:i + PER_PART] for i in range(0, len(entries), PER_PART)]
    const_names = []

    for part_index, chunk in enumerate(parts, start=1):
        lines = [
            "import Foundation",
            "",
            f"/// Parte {part_index} de {len(parts)} das proficiências embutidas — ver",
            "/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a",
            "/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários",
            "/// arquivos/constantes em vez de um array literal único gigante (mesmo",
            "/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um",
            "/// array com centenas de literais aninhados trava o type-checker do",
            "/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo",
            "/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e",
            "/// rápido, em vez de inferir o array inteiro de uma vez.",
            "",
        ]
        for offset, e in enumerate(chunk):
            const_name = f"embeddedProficiency{part_index:02d}{offset:02d}"
            const_names.append(const_name)
            lines.append(render_proficiency(const_name, e))
        out_path = out_dir / f"EmbeddedProficiencies_Part{part_index}.swift"
        out_path.write_text("\n".join(lines), encoding="utf-8")
        print(f"wrote {out_path} ({len(chunk)} entries)")

    # Arquivo-índice: só a lista de constantes já tipadas, trivial de checar.
    index_lines = [
        "import Foundation",
        "",
        "/// As 372 proficiências não-de-arma, embutidas como literais Swift de",
        "/// verdade — SEM JSON, `Bundle`, `Data` ou `JSONDecoder` nenhum em",
        "/// runtime. Mesmo padrão de `EmbeddedKits.swift`/`EmbeddedRules.swift`:",
        "/// ver o comentário grande em qualquer `EmbeddedProficiencies_PartN.swift`",
        "/// pro porquê da divisão em vários arquivos, e em `KitDatabase.swift` pro",
        "/// histórico completo de por que ler isso de JSON de bundle NÃO é",
        "/// confiável neste toolchain (três tentativas diferentes já falharam pra",
        "/// Kits, mesma classe de bug).",
        "///",
        "/// Gerado por `Scripts/generate_embedded_proficiencies.py` a partir dos",
        "/// JSON de origem (`general.json`, `priest.json`, `rogue.json`,",
        "/// `warrior.json`, `wizard.json`, `psionicist.json`,",
        "/// `other_and_racial.json`) — regenere com esse script se os dados de",
        "/// origem mudarem, não edite os arquivos `_PartN` à mão.",
        "enum EmbeddedProficiencies {",
        "    static let entries: [Proficiency] = [",
    ]
    for name in const_names:
        index_lines.append(f"        {name},")
    index_lines.append("    ]")
    index_lines.append("}")

    (out_dir / "EmbeddedProficiencies.swift").write_text("\n".join(index_lines), encoding="utf-8")
    print(f"wrote {out_dir / 'EmbeddedProficiencies.swift'} ({len(const_names)} entries indexed)")


if __name__ == "__main__":
    main()
