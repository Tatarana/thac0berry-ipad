"""
Extração heurística (regex) de dano/cura a partir do texto livre das
magias — abordagem 3 (híbrida) discutida com o usuário: regex cobre os
formatos de frase mais comuns e consistentes do texto oficial; o que não
casa em nada confiável fica só com `damage` (texto curto) preenchido, sem
`damageDice` estruturado, em vez do `None`/`None` que `convert_spells.py`
grava hoje pra tudo.

Roda direto sobre o JSON CRU da fonte (não sobre o já convertido) — reusa
`convert_spells.convert_entry` pra montar o registro final e só então
tenta extrair dano/cura. Isso importa pra magias reversíveis: o `fullText`
da fonte inclui tanto o efeito direto quanto o da forma reversa no mesmo
bloco de texto (ex.: "Regenerate Light Wounds" — uma magia de CURA — tem
o dano da sua reversa "degenerate light wounds" descrito ali dentro). Uma
magia reversa como essa nem existe como entrada própria na base (só
aparece citada em texto), então rodar a extração em cima do texto
completo arrisca pegar o número do efeito ERRADO. Pra evitar isso, magias
reversíveis usam só `description.sections.mainEffect` (que a fonte já
mantém separado, sem o parágrafo da forma reversa) em vez do `fullText`.

Roda por enquanto só sobre priest_level_1.json (teste isolado, ainda não
estendido pros outros níveis) — ver TODO.md item 1, último subitem.

Uso: python3 extract_damage.py <entrada_crua.json> <saida.json> [--report]
"""
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import convert_spells  # noqa: E402


# N[dD]M[+-]B — "1d8", "2d4+2", "d6" (conta implícita 1).
_DICE = re.compile(r"(\d*)[dD](\d+)(?:\s*([+-])\s*(\d+))?")

# Depois do valor de dano batido, se um desses termos aparecer logo a
# seguir, o número não é fixo (escala por nível/unidade de um jeito que o
# `SpellDamage` atual não representa) — melhor não estruturar errado.
_SCALING_NEARBY = re.compile(
    r"\bper\s+(?:\d+\s+)?(level|caster\s+level|two\s+levels|ounce|feet|foot|"
    r"tons?|cargo\s+tons?)\b|\bfor\s+every\b|\bplus\s+\d+\s+points?\s+(for|per)\b",
    re.IGNORECASE,
)
# "por rodada"/"per round" continua um valor fixo por instância — não é o
# tipo de escala que o modelo não representa (diferente de "por nível"),
# por isso fica fora da lista acima de propósito.

# "1d6 per level (max 10d6)" — escala com nível, mas com teto explícito;
# esse formato o modelo já representa direito (`scalesWithLevel` + `maxDice`).
_LEVEL_SCALE_WITH_CAP = re.compile(
    r"(\d*)[dD](\d+)\s+per\s+level\s*\(\s*max(?:imum)?\s*(?:of\s*)?"
    r"(\d+)[dD](\d+)\s*\)",
    re.IGNORECASE,
)

# "1d3 points of damage plus 2 points for every level of the spellcaster,
# to a maximum of 1d3+20 points" (Frost Fingers) / "1d6 points of damage,
# plus 1 point per caster level." (Sunscorch, sem teto) — o DADO fica fixo,
# só o bônus somado cresce por nível; `SpellDamage.bonusPerLevel` foi
# criado exatamente pra esse formato. O teto (grupo 5) é opcional.
_BONUS_PER_LEVEL = re.compile(
    r"(\d*)[dD](\d+)\s+points?\s+of\s+(?:[a-zA-Z]+\s+){0,2}?damage,?\s+plus\s+(\d+)\s+points?\s+"
    r"(?:for\s+every|per)\s+(?:level|caster\s+level)(?:\s+of\s+the\s+\w+)?"
    r"(?:[^.]{0,40}?to\s+a\s+maximum\s+of\s+(?:\d*[dD]\d+\s*[+-]\s*)?(\d+)\s+points?)?",
    re.IGNORECASE,
)

_DAMAGE_VERBS = (
    r"(?:inflict(?:s|ing)?|caus(?:es|ing)?|suffer(?:s|ing)?|tak(?:es|ing)?|sustain(?:s|ing)?|"
    r"deal(?:s|ing)?|receiv(?:es|ing)?)"
)
_DAMAGE_PATTERN = re.compile(
    _DAMAGE_VERBS + r"\s+" + _DICE.pattern + r"\s+points?\s+of\s+(?:[a-zA-Z]+\s+){0,2}?damage",
    re.IGNORECASE,
)
# Forma passiva — "1d6 points of damage is taken per round" — o dado vem
# ANTES do verbo, formato comum em descrições de dano contínuo/condicional.
_DAMAGE_PATTERN_PASSIVE = re.compile(
    _DICE.pattern + r"\s+points?\s+of\s+(?:[a-zA-Z]+\s+){0,2}?damage\s+(?:is|are|was|were)\s+"
    r"(?:taken|caused|inflicted|suffered|sustained)",
    re.IGNORECASE,
)

_HEAL_REGAIN_HP = re.compile(
    r"regains?\s+" + _DICE.pattern + r"\s+hit\s*points?", re.IGNORECASE
)
_HEAL_OF_POINTS = re.compile(
    r"heals?\s+(?:it|him|her|them)?\s*(?:of\s+)?" + _DICE.pattern + r"\s+points?",
    re.IGNORECASE,
)
_HEAL_AMOUNT_IS = re.compile(
    r"amount\s+of\s+damage\s+healed\s+is\s+" + _DICE.pattern, re.IGNORECASE
)
_HEAL_DAMAGE_TO_BE_HEALED = re.compile(
    r"causes?\s+" + _DICE.pattern + r"\s+points?\s+of\s+(?:wound\s+or\s+other\s+injury\s+)?"
    r"damage[^.]{0,60}?(?:to\s+be\s+healed|healed)\b",
    re.IGNORECASE,
)


def _dice_from_match(m: "re.Match[str]", group_offset: int = 0) -> dict:
    count = m.group(group_offset + 1)
    sides = m.group(group_offset + 2)
    sign = m.group(group_offset + 3)
    bonus = m.group(group_offset + 4)
    value = {
        "dice": int(count) if count else 1,
        "sides": int(sides),
        "bonus": 0,
        "scalesWithLevel": False,
        "maxDice": None,
        "isHealing": False,
        "bonusPerLevel": 0,
        "maxBonus": None,
    }
    if sign and bonus:
        value["bonus"] = int(bonus) if sign == "+" else -int(bonus)
    return value


def _text_for(value: dict) -> str:
    text = f"{value['dice']}d{value['sides']}"
    if value["bonus"] > 0:
        text += f"+{value['bonus']}"
    elif value["bonus"] < 0:
        text += f"{value['bonus']}"
    if value.get("bonusPerLevel"):
        text += f"+{value['bonusPerLevel']}/level"
        if value.get("maxBonus") is not None:
            text += f" (max +{value['maxBonus']})"
    return text


def extract(full_text: str) -> tuple[dict | None, str | None]:
    """Retorna (damageDice estruturado ou None, texto curto pra `damage` ou None)."""
    if not full_text:
        return None, None

    # 1. Escala por nível com teto explícito — checa primeiro, é o caso
    # mais específico (perderia pro cast genérico de "N per level" senão).
    m = _LEVEL_SCALE_WITH_CAP.search(full_text)
    if m:
        dice, sides, max_dice, max_sides = m.groups()
        if sides == max_sides:  # o teto tem que ser no mesmo tipo de dado
            value = {
                "dice": int(dice) if dice else 1,
                "sides": int(sides),
                "bonus": 0,
                "scalesWithLevel": True,
                "maxDice": int(max_dice),
                "isHealing": False,
            }
            return value, f"{value['dice']}d{value['sides']} per level (max {max_dice}d{sides})"

    # 2. Cura — três formas de frase observadas na fonte.
    for pattern in (_HEAL_REGAIN_HP, _HEAL_OF_POINTS, _HEAL_AMOUNT_IS, _HEAL_DAMAGE_TO_BE_HEALED):
        m = pattern.search(full_text)
        if m:
            tail = full_text[m.end():m.end() + 40]
            if _SCALING_NEARBY.search(tail):
                continue  # escala de um jeito que não sabemos modelar — melhor não estruturar
            value = _dice_from_match(m)
            value["isHealing"] = True
            return value, "Heal " + _text_for(value)

    # 3. Bônus que escala por nível ("1d3 + 2/nível", com ou sem teto) —
    # checa antes do dano genérico, senão a exclusão de "per level" do
    # passo 4 descartaria esses casos como não-modeláveis.
    m = _BONUS_PER_LEVEL.search(full_text)
    if m:
        dice, sides, bonus_per_level, max_bonus = m.groups()
        value = {
            "dice": int(dice) if dice else 1,
            "sides": int(sides),
            "bonus": 0,
            "scalesWithLevel": False,
            "maxDice": None,
            "isHealing": False,
            "bonusPerLevel": int(bonus_per_level),
            "maxBonus": int(max_bonus) if max_bonus else None,
        }
        return value, _text_for(value)

    # 4. Dano direto — ativo ("inflicts 2d4 points of damage") e passivo
    # ("2d4 points of damage is taken").
    for pattern in (_DAMAGE_PATTERN, _DAMAGE_PATTERN_PASSIVE):
        m = pattern.search(full_text)
        if m:
            tail = full_text[m.end():m.end() + 40]
            if _SCALING_NEARBY.search(tail):
                return None, None  # dano existe, mas escala de um jeito não modelável — deixa pro passo 4
            value = _dice_from_match(m)
            return value, _text_for(value)

    return None, None


def find_damage_mentions(full_text: str) -> str | None:
    """Quando não dá pra estruturar, mas claramente existe dano/cura numérico
    no texto (dado + "damage"/"healed"/"hit points" por perto), devolve um
    trecho curto pra pelo menos preencher `damage` como texto livre — em vez
    de deixar `None` e a folha mostrar "—" pra uma magia que claramente causa
    dano ou cura."""
    if not full_text:
        return None
    for m in _DICE.finditer(full_text):
        window = full_text[m.end():m.end() + 60]
        if re.search(r"damage|heal|hit\s*points?", window, re.IGNORECASE):
            sentence_start = full_text.rfind(".", 0, m.start())
            sentence_start = sentence_start + 1 if sentence_start != -1 else 0
            sentence_end = full_text.find(".", m.end())
            sentence_end = sentence_end + 1 if sentence_end != -1 else len(full_text)
            snippet = full_text[sentence_start:sentence_end].strip()
            if len(snippet) > 140:
                snippet = snippet[:137].rstrip() + "…"
            return snippet
    return None


def _primary_effect_text(raw_entry: dict, converted_full_description: str) -> str:
    """Texto a usar na extração: pra magia reversível, só o efeito direto
    (`sections.mainEffect`, sem o parágrafo da forma reversa); pras demais,
    o mesmo `fullDescription` que já foi calculado na conversão normal."""
    is_reversible = bool((raw_entry.get("reversible") or {}).get("isReversible"))
    if not is_reversible:
        return converted_full_description
    sections = (raw_entry.get("description") or {}).get("sections") or {}
    main_effect = sections.get("mainEffect")
    if main_effect:
        return convert_spells.clean_text(main_effect)
    return converted_full_description  # fonte não separou as seções — melhor que nada


def main():
    if len(sys.argv) < 3:
        print("uso: extract_damage.py <entrada_crua.json> <saida.json> [--report]")
        sys.exit(1)

    report = "--report" in sys.argv
    with open(sys.argv[1], encoding="utf-8") as f:
        raw_data = json.load(f)

    converted = [convert_spells.convert_entry(e) for e in raw_data]

    structured = 0
    text_only = 0
    none_count = 0
    skipped_reversible = 0
    log = []

    for raw_entry, entry in zip(raw_data, converted):
        is_reversible = bool((raw_entry.get("reversible") or {}).get("isReversible"))
        primary_text = _primary_effect_text(raw_entry, entry.get("fullDescription") or "")

        dice, text = extract(primary_text)
        if dice is None:
            fallback = find_damage_mentions(primary_text)
            if fallback:
                entry["damage"] = fallback
                entry["damageDice"] = None
                text_only += 1
                log.append(("texto", entry["name"], fallback))
            else:
                none_count += 1
        else:
            entry["damage"] = text
            entry["damageDice"] = dice
            structured += 1
            log.append(("estruturado" if not is_reversible else "estruturado (reversível)",
                         entry["name"], text))
        if is_reversible:
            skipped_reversible += 1

    with open(sys.argv[2], "w", encoding="utf-8") as f:
        json.dump(converted, f, ensure_ascii=False, indent=2)

    print(f"{len(converted)} magias ({skipped_reversible} reversíveis, usando só o "
          f"efeito direto) — {structured} com damageDice estruturado, "
          f"{text_only} só com texto, {none_count} sem dano/cura reconhecido")

    if report:
        print()
        for kind, name, value in sorted(log):
            print(f"  [{kind:25}] {name}: {value}")


if __name__ == "__main__":
    main()
