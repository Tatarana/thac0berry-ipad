#!/usr/bin/env python3
"""Converte o wizard_kits.json bruto (wiki-scrape) pro MESMO formato que
Resources/kits.json já usa pros 91 kits de sacerdote — e ANEXA os kits de
mago dentro desse mesmo arquivo, em vez de criar um arquivo `Resources/`
separado.

Por que anexar em vez de um arquivo à parte (2026-09-29): `Kit.swift` já
documenta que kit de sacerdote genérico e kit de sacerdote especializado
por divindade entram no MESMO array porque "a wiki de origem já os trata
como a mesma categoria" (Character Kit) — kit de mago é exatamente a
mesma categoria de novo, só a classe que muda. Anexar ao `kits.json`
existente significa ZERO mudança em `KitDatabase.swift` (que já filtra
por `classEligibility.allowedClasses` de forma genérica, sem nada
hardcoded pra sacerdote) — `KitField`/`KitPickerSheet` na ficha do
personagem já vão listar os kits de mago sozinhos assim que a classe for
"Mage", sem precisar tocar em nenhuma view.

Diferenças de esquema achadas entre o wizard_kits.json bruto e o formato
que `Kit.swift` espera (todas tratadas aqui, não em Swift, pra manter o
modelo Swift simples — mesma filosofia usada em `convert_spells.py`/
`convert_wizard_spells.py`):

1. `classEligibility.allowedClasses` no arquivo bruto usa `"Wizard"`, mas
   a classe do personagem no app se chama `"Mage"` (`CharacterClass.mage`
   — ver `Models/Character.swift`). Sintetizado aqui como `["Mage"]`
   direto, em vez de precisar de um caso especial em Swift (como já existe
   pra "Specialty Priest"/"Cleric").
2. Um kit (`wild_mage`, de "Tome of Magic") tem `classEligibility` SÓ com
   `classGroup` — sem `subclass` nem `allowedClasses`. Preenchido aqui com
   os mesmos valores dos outros 39.
3. `mechanics.requirements` usa `alignment` (singular, string ou `null`)
   em vez de `alignments` (lista, como em `kits.json`) — convertido aqui
   pra lista de 0 ou 1 item.
4. `mechanics.weapons` não tem a chave `forbidden` (`kits.json` sempre
   tem, mesmo que vazia) — bug idêntico ao que já mordeu `Spell.schools`
   (chave nova ausente derrubando o decode inteiro com uma mensagem de
   erro enganosa) se eu não sintetizasse aqui. Sempre emitida como `[]`.
5. `mechanics.armor` e `mechanics.turnUndead` não existem no arquivo bruto
   (conceito específico de sacerdote — kit de mago não tem restrição de
   armadura própria nem conjura Turn Undead). Sintetizados com valores
   neutros ("sem restrição além da classe base" / "não conjura") em vez
   de tornar esses campos opcionais em `Kit.swift` — mais simples manter
   o modelo Swift uniforme entre os dois tipos de kit.
6. Um kit inteiro (`wild_mage`) não tem `mechanics` NENHUMA — sintetizada
   do zero (vazia, já que os únicos dados de requisito que existem pra
   ele vêm como texto livre em `features.requirements`).
7. `mechanics.weaponSlots` é um campo NOVO que `kits.json` nunca teve —
   vira `Optional` em `Kit.swift` (`Codable` sintetizado já trata tipo
   opcional de verdade como `decodeIfPresent` automaticamente, sem
   precisar de `init(from:)` próprio — diferente do bug do `schools`,
   que era um array NÃO opcional com valor padrão em Swift).
8. 9 dos 49 kits brutos são "Create Your Own (...)" — cartas em branco do
   card set de 1992/1993, sem regra nenhuma (mesma situação dos 6 "Create
   Your Own" de sacerdote já removidos antes, ver `Kit.swift`). Excluídos
   aqui.

Uso:
    python3 Scripts/convert_wizard_kits.py <wizard_kits_raw.json> \
        THAC0berry.swiftpm/Resources/kits.json
O segundo argumento é lido (se existir) e sobrescrito com os kits de
sacerdote originais + os de mago convertidos, nessa ordem.
"""
import json
import sys


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
    "notes": "Wizard kits don't turn undead — that's a priest class feature.",
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


def convert_kit(raw: dict) -> dict:
    return {
        "id": raw["id"],
        "name": raw["name"],
        "wikiPageTitle": raw["wikiPageTitle"],
        "redirectAliases": raw.get("redirectAliases") or [],
        "classEligibility": {
            "classGroup": "Wizard",
            "subclass": "Wizard",
            "allowedClasses": ["Mage"],
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
    if len(sys.argv) != 3:
        print(__doc__)
        sys.exit(1)

    raw_path, kits_path = sys.argv[1], sys.argv[2]

    with open(raw_path, encoding="utf-8") as f:
        raw_kits = json.load(f)

    converted = [
        convert_kit(k) for k in raw_kits if not k["id"].startswith("create_your_own")
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
        print(f"AVISO: ids duplicados entre kits.json e wizard_kits — {sorted(overlap)}")

    combined = existing + converted
    with open(kits_path, "w", encoding="utf-8") as f:
        json.dump(combined, f, ensure_ascii=False, indent=2)
        f.write("\n")

    print(f"{len(raw_kits)} kits brutos, {len(converted)} convertidos "
          f"({len(raw_kits) - len(converted)} 'Create Your Own' excluídos), "
          f"{len(existing)} kits de sacerdote preservados, "
          f"{len(combined)} kits no total em {kits_path}")


if __name__ == "__main__":
    main()
