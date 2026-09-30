"""
Converte um arquivo de magias de MAGO (wiki scrape) para o schema que o
app usa (Spell.swift) — mesma ideia de `convert_spells.py` (que já fazia
isso pra Priest), só que adaptado pro formato de origem um pouco
diferente desta base (2026-09-29, Grimório do Mago): aqui `school` chega
como um objeto (`{"primary": [...], "subSchool": ..., ...}`) em vez de já
vir como texto pronto, e cada entrada carrega uma escola por magia
(equivalente à esfera do sacerdote) — por isso a saída ganha um campo
novo `schools` (lista), usado pelo filtro de escola do Grimório do Mago
do mesmo jeito que `spheres` já é usado pelo do Clérigo.

Uso:
    python3 convert_wizard_spells.py <entrada.json> <saida.json>

Pensado pra rodar um arquivo por vez (level_1.json, level_2.json, ...),
sempre gerando um Resources/wizard_<algo>.json separado — mesmo motivo
de sempre (ver TODO.md e a nota em Store/SpellDatabase.swift): arquivos
menores carregam mais rápido e um erro de leitura em um não derruba os
outros.
"""
import json
import re
import sys


# Hífen suave (usado pela fonte só pra indicar onde quebrar a palavra,
# ex.: "im\xadportance") — não é visível na wiki, mas sobra como lixo no
# texto puro. Removido de todo campo de texto — mesmo tratamento de
# `convert_spells.py`.
SOFT_HYPHEN = "­"

_WIKITABLE = re.compile(r"\{\|.*?\|\}", re.DOTALL)


def _render_wikitable(match: "re.Match[str]") -> str:
    rows: list[list[str]] = []
    for raw_line in match.group(0).splitlines():
        line = raw_line.strip()
        if not line or line.startswith("|-") or line == "|}" or line.startswith("{|"):
            continue
        if line.startswith("!") or line.startswith("|"):
            cells = [cell.strip() for cell in line[1:].split("||")]
            rows.append(cells)
    return "\n".join(" | ".join(cells) for cells in rows)


def clean_text(text: str) -> str:
    if not text:
        return text
    text = text.replace(SOFT_HYPHEN, "")
    text = _WIKITABLE.sub(_render_wikitable, text)
    return text.strip()


def build_components(comp: dict) -> str:
    parts = []
    if comp.get("verbal"):
        parts.append("V")
    if comp.get("somatic"):
        parts.append("S")
    if comp.get("material"):
        parts.append("M")
    text = ", ".join(parts) if parts else "None"
    desc = comp.get("materialDescription")
    if desc:
        text += f" ({clean_text(desc)})"
    return text


def full_description(desc: dict) -> str:
    text = desc.get("fullText")
    if text:
        return clean_text(text)
    sections = desc.get("sections") or {}
    main = sections.get("mainEffect")
    if main:
        return clean_text(main)
    return clean_text(desc.get("briefSummary") or "")


def build_school(school: dict) -> tuple[str, list[str]]:
    """Junta `primary` (+ `subSchool`, quando houver) num texto "Escola,
    Escola" pro campo `school` de sempre (mesmo formato que o Priest já
    usa: "Enchantment/Charm, Necromancy") e devolve também a lista solta
    (sem o subschool) pro filtro (`schools`)."""
    primary = [clean_text(s) for s in (school.get("primary") or [])]
    label_parts = list(primary)
    sub = school.get("subSchool")
    if sub:
        label_parts.append(f"{clean_text(sub)} (sub)")
    return ", ".join(label_parts) if label_parts else "—", primary


def build_id(entry: dict, tier: int) -> str:
    # Mesmo cuidado de `convert_spells.py`: o slug da fonte é único DENTRO
    # de um arquivo, mas magias de nível/tier diferente podem compartilhar
    # o mesmo slug (duas entradas de nomes iguais em tiers diferentes).
    # Prefixo "wizard-<tier>-" evita colisão sem esbarrar no "wiz-..." que
    # os exemplos do Kelmon possam usar.
    slug = entry["id"].replace("_", "-")
    return f"wizard-{tier}-{slug}"


def convert_entry(entry: dict) -> dict:
    level = entry.get("level") or {}
    school = entry.get("school") or {}
    setting = entry.get("setting") or {}
    description = entry.get("description") or {}
    components = entry.get("components") or {}
    tier = level.get("tier", 0)

    school_label, school_list = build_school(school)

    return {
        "id": build_id(entry, tier),
        "name": clean_text(entry["title"]),
        "level": tier,
        "caster": "arcane",
        "school": school_label,
        "castingTime": clean_text(entry.get("castingTime") or "—"),
        "range": clean_text(entry.get("range") or "—"),
        "components": build_components(components),
        "duration": clean_text(entry.get("duration") or "—"),
        "areaOfEffect": clean_text(entry.get("areaOfEffect") or "—"),
        "savingThrow": clean_text(entry.get("savingThrow") or "—"),
        "damage": None,
        "summary": clean_text(description.get("briefSummary") or ""),
        "damageDice": None,
        "spheres": [],
        "schools": school_list,
        "fullDescription": full_description(description),
        "setting": clean_text(setting.get("name") or "Generic"),
    }


def main():
    if len(sys.argv) != 3:
        print("uso: convert_wizard_spells.py <entrada.json> <saida.json>")
        sys.exit(1)

    with open(sys.argv[1], encoding="utf-8") as f:
        data = json.load(f)

    converted = [convert_entry(e) for e in data]

    ids = [c["id"] for c in converted]
    dupes = {i for i in ids if ids.count(i) > 1}
    if dupes:
        print(f"AVISO: ids duplicados no arquivo de saída: {dupes}")

    with open(sys.argv[2], "w", encoding="utf-8") as f:
        json.dump(converted, f, ensure_ascii=False, indent=2)

    print(f"{len(converted)} magias convertidas -> {sys.argv[2]}")


if __name__ == "__main__":
    main()
