"""
Converte um arquivo de magias no formato da fonte (wiki scrape) para o
schema que o app usa (Spell.swift). Uso:

    python3 convert_spells.py <entrada.json> <saida.json>

Pensado pra rodar um arquivo por vez (level_1.json, level_2.json, ...),
sempre gerando um Resources/priest_<algo>.json separado — ver TODO.md
item 1 e a nota em Store/SpellDatabase.swift sobre por que os arquivos
ficam separados em vez de um único spells.json gigante.
"""
import json
import re
import sys


# Hífen suave (usado pela fonte só pra indicar onde quebrar a palavra,
# ex.: "por\xadtent") — não é visível na wiki, mas sobra como lixo no
# texto puro. Removido de todo campo de texto.
SOFT_HYPHEN = "­"

# Tabelas em wikitext ("{| class=... ! cabeçalho || ... |- | célula || ... |}")
# aparecem cruas dentro de `fullText` pra magias como Portent (ver bug
# reportado: a tabela de 1d6/resultado aparecia com a sintaxe da wiki na
# tela em vez de virar texto legível). Cada linha de cabeçalho ("!") ou de
# dado ("|", que não seja só "|-") já vem com as células da linha inteira
# separadas por "||" — não uma célula por linha.
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


def build_id(entry: dict, tier: int) -> str:
    # O id da fonte é único dentro de um arquivo, mas NÃO entre níveis: a
    # wiki às vezes tem duas magias de nome igual em círculos diferentes
    # (ex.: "Float" nível 1 e "Float" nível 2 são magias distintas, mas o
    # scraper gerou o mesmo slug "float" pras duas). Prefixar com
    # "priest-<nível>-" evita a colisão sem esbarrar no formato "pri1-..."
    # já usado pelos exemplos de Kelmon em spells.json (esses usam "pri",
    # não "priest").
    slug = entry["id"].replace("_", "-")
    return f"priest-{tier}-{slug}"


def convert_entry(entry: dict) -> dict:
    level = entry.get("level") or {}
    setting = entry.get("setting") or {}
    description = entry.get("description") or {}
    components = entry.get("components") or {}
    tier = level.get("tier", 0)

    return {
        "id": build_id(entry, tier),
        "name": clean_text(entry["title"]),
        "level": tier,
        "caster": "divine",
        "school": clean_text(entry.get("school") or ""),
        "castingTime": clean_text(entry.get("castingTime") or "—"),
        "range": clean_text(entry.get("range") or "—"),
        "components": build_components(components),
        "duration": clean_text(entry.get("duration") or "—"),
        "areaOfEffect": clean_text(entry.get("areaOfEffect") or "—"),
        "savingThrow": clean_text(entry.get("savingThrow") or "—"),
        "damage": None,
        "summary": clean_text(description.get("briefSummary") or ""),
        "damageDice": None,
        "spheres": [clean_text(s) for s in (entry.get("spheres") or [])],
        "fullDescription": full_description(description),
        "setting": clean_text(setting.get("name") or "Generic"),
    }


def main():
    if len(sys.argv) != 3:
        print("uso: convert_spells.py <entrada.json> <saida.json>")
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
