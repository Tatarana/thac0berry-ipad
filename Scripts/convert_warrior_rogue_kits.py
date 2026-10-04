#!/usr/bin/env python3
"""Converte warrior_kits.json e rogue_kits.json (os JSONs estruturados que
o usuário forneceu pra fechar o TODO.md v1.92/v1.94 — "Warrior Kits
continua bloqueado até o usuário mandar o JSON estruturado dos kits" /
mesmo acordo pro Rogue) pro MESMO formato que `Resources/kits.json` já usa
pros kits de sacerdote e mago — e ANEXA os dois grupos nesse mesmo
arquivo, em vez de criar arquivos `Resources/` separados. Mesma filosofia
de `convert_wizard_kits.py` (ver o comentário grande lá): kit de
guerreiro/ladrão é a mesma categoria "Character Kit" da wiki de origem, só
a classe que muda — anexar ao `kits.json` existente significa ZERO
mudança em `KitDatabase.swift`.

O esquema bruto de `warrior_kits.json`/`rogue_kits.json` já vem
estruturalmente idêntico ao de `kits.json` (mesmas chaves de topo:
`classEligibility`, `features`, `description` com `rawWikitext` incluso,
`categories`) — bem mais perto do alvo do que o `wizard_kits.json` bruto
estava. As únicas diferenças de esquema tratadas aqui:

1. `mechanics.requirements` usa `alignment` (singular, string ou `null`)
   em vez de `alignments` (lista) — mesmo tratamento do conversor de mago,
   convertido pra lista de 0 ou 1 item.
2. `mechanics.weapons` não tem a chave `forbidden` — sempre emitida como
   `[]`, mesmo bug em potencial do `Spell.schools` que os outros dois
   conversores já tratam.
3. `mechanics.armor` e `mechanics.turnUndead` não existem no arquivo bruto
   (dado de armadura/Turn Undead pra essas classes só aparece como texto
   livre em `features.specialHindrances`/`features.equipment`, sem
   estrutura pra extrair) — sintetizados com os mesmos valores neutros já
   usados pro mago ("sem restrição além da classe base" / "não conjura").
4. `mechanics.weaponSlots` só vira campo de fato quando tem conteúdo (39
   dos 114 kits de guerreiro, 14 dos 73 de ladrão) — mesmo tratamento do
   conversor de mago, usando o `Optional` que `Kit.swift` já suporta.
5. Kit de Barbarian: o livro de origem (Complete Barbarian's Handbook)
   trata Barbarian como uma quarta "classe" ao lado de Fighter/Paladin/
   Ranger dentro do grupo Warrior, e é assim que o JSON bruto marca os 14
   kits dele (`subclass: "Barbarian"`, `allowedClasses: ["Barbarian"]`).
   MAS a regra oficial (confirmada com o usuário antes de codar o grupo
   Warrior, ver TODO.md v1.92: "Barbarian é Kit de Fighter, não uma nova
   `CharacterClass`") é que Barbarian é um KIT — `CharacterClass` do app
   não tem (e não vai ter) um caso `.barbarian`. Sem remapear isso,
   `KitDatabase.kits(allowedFor:)` filtraria por `allowedClasses.contains(className)`
   e os 14 kits de Barbarian ficariam invisíveis pra sempre (nenhuma
   classe jogável chamada "Barbarian" existe pra casar o filtro) — exatamente
   o mesmo formato de problema que o caso especial "Specialty Priest" já
   resolve pra Cleric em `KitDatabase.swift`, só que aqui é mais simples
   resolver na conversão (como o mago já faz com "Wizard"→"Mage") em vez
   de adicionar mais um caso especial em Swift: `allowedClasses` vira
   `["Fighter"]` pra esses 14, mantendo `subclass: "Barbarian"` intacto
   (é o rótulo exibido em `KitPickerRow`/agrupamento do compêndio).

Uso:
    python3 Scripts/convert_warrior_rogue_kits.py \
        warrior_kits_raw.json Warrior \
        THAC0berry.swiftpm/Resources/kits.json
    python3 Scripts/convert_warrior_rogue_kits.py \
        rogue_kits_raw.json Rogue \
        THAC0berry.swiftpm/Resources/kits.json
O terceiro argumento é lido (se existir) e sobrescrito com os kits
existentes + os convertidos desta rodada, nessa ordem. Rodar uma vez pra
cada grupo (Warrior, depois Rogue) — cada rodada lê de novo o resultado
da anterior, então a ordem de invocação não perde nada.
"""
import json
import sys

# Mapeia o `allowedClasses` do arquivo bruto pro valor real de
# `CharacterClass` no app — só Barbarian precisa de remap (item 5 acima);
# os outros seis (Fighter/Paladin/Ranger/Thief/Bard/Ninja) já batem 1:1.
ALLOWED_CLASS_REMAP = {
    "Barbarian": "Fighter",
}


def normalize_requirements(raw: dict) -> dict:
    alignment = raw.get("alignment")
    alignments = [alignment] if alignment else []
    return {
        "abilities": raw.get("abilities") or {},
        "alignments": alignments,
        "races": raw.get("races"),
    }


def normalize_weapons(raw: dict) -> dict:
    return {
        "required": raw.get("required") or [],
        "recommended": raw.get("recommended") or [],
        "forbidden": raw.get("forbidden") or [],
        "notes": raw.get("notes"),
    }


def normalize_proficiencies(raw: dict) -> dict:
    return {
        "bonus": raw.get("bonus") or [],
        "recommended": raw.get("recommended") or [],
        "notes": raw.get("notes"),
    }


NEUTRAL_ARMOR = {
    "allowedTypes": "as_class",
    "shieldsAllowed": "as_class",
    "metalAllowed": True,
    "maxArmorClass": None,
    "notes": "",
}

NEUTRAL_TURN_UNDEAD = {
    "capable": False,
    "mode": "not_applicable",
    "notes": "Warrior and Rogue kits don't turn undead — that's a priest class feature.",
}


def normalize_mechanics(raw: dict | None) -> dict:
    raw = raw or {}
    mechanics = {
        "requirements": normalize_requirements(raw.get("requirements") or {}),
        "weapons": normalize_weapons(raw.get("weapons") or {}),
        "proficiencies": normalize_proficiencies(raw.get("proficiencies") or {}),
        "armor": NEUTRAL_ARMOR,
        "turnUndead": NEUTRAL_TURN_UNDEAD,
        "startingCash": raw.get("startingCash"),
    }
    weapon_slots = raw.get("weaponSlots")
    if weapon_slots and any(v is not None for v in weapon_slots.values()):
        mechanics["weaponSlots"] = weapon_slots
    return mechanics


def normalize_allowed_classes(raw: list) -> list:
    return [ALLOWED_CLASS_REMAP.get(c, c) for c in raw]


def convert_kit(raw: dict, class_group: str) -> dict:
    eligibility = raw["classEligibility"]
    return {
        "id": raw["id"],
        "name": raw["name"],
        "wikiPageTitle": raw["wikiPageTitle"],
        "redirectAliases": raw.get("redirectAliases") or [],
        "classEligibility": {
            "classGroup": class_group,
            "subclass": eligibility["subclass"],
            "allowedClasses": normalize_allowed_classes(eligibility.get("allowedClasses") or []),
        },
        "sourceBook": raw["sourceBook"],
        "features": raw["features"],
        "description": raw["description"],
        "categories": raw.get("categories") or [],
        "mechanics": normalize_mechanics(raw.get("mechanics")),
        # Só existem pra kit de sacerdote especializado por divindade.
        "deity": None,
        "pantheon": None,
        "setting": None,
        "titleInChurch": None,
    }


def main() -> None:
    if len(sys.argv) != 4:
        print(__doc__)
        sys.exit(1)

    raw_path, class_group, kits_path = sys.argv[1], sys.argv[2], sys.argv[3]

    with open(raw_path, encoding="utf-8") as f:
        raw_kits = json.load(f)

    converted = [
        convert_kit(k, class_group) for k in raw_kits if not k["id"].startswith("create_your_own")
    ]

    try:
        with open(kits_path, encoding="utf-8") as f:
            existing = json.load(f)
    except FileNotFoundError:
        existing = []

    existing_ids = {k["id"] for k in existing}
    new_ids = {k["id"] for k in converted}
    overlap = existing_ids & new_ids
    if overlap:
        print(f"AVISO: ids duplicados entre kits.json e {raw_path} — {sorted(overlap)}")

    combined = existing + converted
    with open(kits_path, "w", encoding="utf-8") as f:
        json.dump(combined, f, ensure_ascii=False, indent=2)
        f.write("\n")

    print(f"{len(raw_kits)} kits brutos de {class_group}, {len(converted)} convertidos "
          f"({len(raw_kits) - len(converted)} 'Create Your Own' excluídos), "
          f"{len(existing)} kits preexistentes preservados, "
          f"{len(combined)} kits no total em {kits_path}")


if __name__ == "__main__":
    main()
