#!/usr/bin/env python3
"""Gera `library.schema.json` (formato da biblioteca de personagens) a partir
dos modelos Swift do app.

O `library.json` do iPad (e o backup exportado em Settings) é o contrato da
ficha com a web e o backend. O schema é gerado do código, não escrito à mão,
para que nunca divirja do que o decode do Swift realmente aceita:

- Codable sintetizado: todo campo não opcional é obrigatório no JSON, mesmo
  com valor padrão no struct (ver CLAUDE.md, seção 4).
- `T?`: opcional; o encode do Swift omite a chave quando é `nil`.
- Tipos com `init(from:)` próprio ficam em OVERRIDES, escritos à mão a partir
  do decode. Um `init(from:)` ou `CodingKeys` novo sem entrada lá faz o
  script falhar, de propósito.
- Date: ISO-8601 sem fração de segundo (`.iso8601` do JSONDecoder recusa
  "2026-10-05T12:00:00.000Z", o formato do `toISOString()` do JavaScript).

Uso:
  python Scripts/gen_library_schema.py            grava em ../thac0berry-data/schemas/
  python Scripts/gen_library_schema.py --check    só compara (CI); sai 1 se divergir
  --out CAMINHO                                   outro arquivo de saída
"""
import argparse
import json
import os
import re
import sys

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
APP = os.path.join(ROOT, "THAC0berry.swiftpm")
SOURCES = [
    "Models/Character.swift",
    "Models/ActiveEffect.swift",
    "Models/SpellSheet.swift",
    "Models/Spell.swift",
]
DEFAULT_OUT = os.path.join(ROOT, "..", "thac0berry-data", "schemas", "library.schema.json")

DATE = {
    "type": "string",
    "pattern": r"^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(Z|[+-]\d{2}:?\d{2})$",
    "description": "ISO-8601 sem fração de segundo (JSONDecoder .iso8601).",
}
UUID = {
    "type": "string",
    "pattern": r"^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$",
}
DATA = {
    "type": "string",
    "contentEncoding": "base64",
    "pattern": r"^[A-Za-z0-9+/]*={0,2}$",
}
SCALARS = {
    "String": {"type": "string"},
    "Int": {"type": "integer"},
    "Double": {"type": "number"},
    "Bool": {"type": "boolean"},
    "Date": DATE,
    "UUID": UUID,
    "Data": DATA,
}

# Tipos com decode próprio: schema escrito a partir do init(from:).
OVERRIDES = {
    # Models/Character.swift, ProficiencyEntry.init(from:): tudo via
    # decodeIfPresent; `slots` aceita número ou texto (só os dígitos contam).
    "ProficiencyEntry": {
        "type": "object",
        "properties": {
            "id": UUID,
            "name": {"type": "string"},
            "slots": {"type": ["integer", "string"]},
            "checked": {"type": "boolean"},
            "target": {"type": ["string", "null"]},
            "matchedProficiencyID": {"type": ["string", "null"]},
        },
    },
    # Models/Character.swift, CharacterClass.init(from:): aceita qualquer
    # texto (desconhecido vira Fighter). O schema restringe aos valores do
    # enum mais os nomes antigos em português que o decode traduz.
    "CharacterClass": {
        "type": "string",
        "enum": [
            "Fighter", "Paladin", "Ranger", "Mage", "Cleric", "Druid", "Thief", "Bard", "Ninja",
            # Psionicist: classe nova feita primeiro na web (2026-10-06, decisão do
            # usuário). O CharacterClass do iPad ainda não tem o caso; o init(from:)
            # dele lê valor desconhecido como Fighter. Ver TODO.md (v1.101+).
            "Psionicist",
            "Guerreiro", "Paladino", "Patrulheiro", "Mago", "Clérigo", "Druida", "Ladino", "Bardo",
        ],
        "description": "Gravar só os valores em inglês; os em português são de bibliotecas antigas.",
    },
}

# Extensões feitas primeiro na web (decisão do usuário, 2026-10-06): campos que o
# Swift ainda não tem. O iPad atual ignora a chave ao ler (e a perde ao salvar);
# quando o iPad ganhar o campo, ele sai daqui e passa a ser gerado do modelo.
WEB_FIRST_DEFS = {
    # Bloco psiônico do Psionicist (Complete Psionics Handbook, cap. 1).
    "Psionics": {
        "type": "object",
        "required": [],
        "properties": {
            "pspMaxOverride": {"anyOf": [{"type": "integer"}, {"type": "null"}],
                               "description": "PSPs máximos escritos à mão; null = calculado pela Tabela 5."},
            "pspCurrent": {"anyOf": [{"type": "integer"}, {"type": "null"}],
                           "description": "PSPs atuais; null = cheio (igual ao máximo)."},
            "primaryDiscipline": {"anyOf": [{"type": "string"}, {"type": "null"}]},
            "disciplines": {"type": "array", "items": {"type": "string"},
                            "description": "Disciplinas com acesso (inclui a principal)."},
            "powers": {"type": "array", "items": {"$ref": "#/$defs/PsionicPowerEntry"}},
            "defenseModes": {"type": "array", "items": {"type": "string"}},
            "uses": {"type": "array", "items": {"$ref": "#/$defs/PsionicUse"},
                     "description": "Registro de usos (PSPs gastos), para o XP sugerido do relatório da sessão."},
        },
    },
    "PsionicPowerEntry": {
        "type": "object",
        "required": ["id", "name"],
        "properties": {
            "id": {"type": "string"},
            "powerID": {"anyOf": [{"type": "string"}, {"type": "null"}],
                        "description": "id em psionic_powers.json; null = poder escrito à mão."},
            "name": {"type": "string"},
            "discipline": {"anyOf": [{"type": "string"}, {"type": "null"}]},
            "tier": {"anyOf": [{"type": "string"}, {"type": "null"}],
                     "description": "Science ou Devotion."},
        },
    },
    "PsionicUse": {
        "type": "object",
        "required": ["id", "date", "psp"],
        "properties": {
            "id": {"type": "string"},
            "date": {"type": "string", "description": "ISO-8601 sem fração de segundo."},
            "sessionID": {"anyOf": [{"type": "string"}, {"type": "null"}]},
            "power": {"type": "string"},
            "psp": {"type": "integer"},
        },
    },
}
WEB_FIRST_DEFS["ClassLevel"] = {
    "type": "object",
    "required": ["characterClass", "level"],
    "properties": {
        "characterClass": {"$ref": "#/$defs/CharacterClass"},
        "level": {"type": "integer"},
    },
}

WEB_FIRST_PROPERTIES = {
    "PlayerCharacter": {
        # Multiclasse (2026-10-07, thac0berry-web/docs/multiclasse.md): a classe
        # principal continua em characterClass/level; aqui ficam as outras.
        "multiClasses": {
            "anyOf": [{"type": "array", "items": {"$ref": "#/$defs/ClassLevel"}}, {"type": "null"}],
            "description": "Outras classes de um multiclasse (semi-humanos), com o nível de cada uma; ausente = classe única.",
        },
        "lastAppliedMultiClasses": {
            "anyOf": [{"type": "array", "items": {"$ref": "#/$defs/ClassLevel"}}, {"type": "null"}],
            "description": "Retrato do motor de consequências: as outras classes no último estado revisado.",
        },
        "psionics": {
            "anyOf": [{"$ref": "#/$defs/Psionics"}, {"type": "null"}],
            "description": "Bloco psiônico do Psionicist (feito primeiro na web, 2026-10-06; o iPad ainda não tem).",
        },
    },
}

ROOTS = ["Campaign", "PlayerCharacter"]


def strip_code(line):
    """Tira literais de texto e comentário de linha, para contar chaves."""
    line = re.sub(r'"(?:\\.|[^"\\])*"', '""', line)
    return line.split("//", 1)[0]


class Decl:
    def __init__(self, kind, name, header):
        self.kind = kind          # "struct" ou "enum"
        self.name = name
        self.header = header
        self.props = []           # (nome, tipo, doc)
        self.cases = []           # (nome, valor bruto)
        self.custom_decode = False
        self.coding_keys = False


def parse(text, decls):
    lines = text.split("\n")
    stack = []   # (Decl ou None, profundidade em que o corpo começa)
    depth = 0
    doc = []
    for raw in lines:
        stripped = raw.strip()
        code = strip_code(raw)
        current = stack[-1][0] if stack else None
        body_depth = stack[-1][1] if stack else None
        opened_decl = None

        if stripped.startswith("///"):
            doc.append(stripped[3:].strip())
        elif stripped and not stripped.startswith("//") and not stripped.startswith("@"):
            m = re.match(r"^\s*(?:private |fileprivate )?(struct|enum) (\w+)\s*(:[^{]*)?\{", code)
            if m and (current is None or depth == body_depth):
                parent = current.name + "." if current else ""
                opened_decl = Decl(m.group(1), parent + m.group(2), m.group(3) or "")
                decls[opened_decl.name] = opened_decl
                if current:
                    decls.setdefault(current.name + "#nested", {})[m.group(2)] = opened_decl.name
            elif current and depth == body_depth:
                if "init(from decoder" in code:
                    current.custom_decode = True
                if re.search(r"enum CodingKeys", code):
                    current.coding_keys = True
                if current.kind == "struct":
                    pm = re.match(r"^\s*(?:var|let) (\w+)\s*(?::\s*([^={]+?))?\s*(=\s*([^{]+))?$", code.rstrip())
                    if pm and "static" not in code.split("var")[0]:
                        name, typ, default = pm.group(1), pm.group(2), pm.group(4)
                        if typ is None:
                            im = re.match(r"^\s*(\w+)\(\)\s*$", default or "")
                            if not im:
                                sys.exit(f"tipo não inferível: {current.name}.{name} = {default}")
                            typ = im.group(1)
                        current.props.append((name, typ.strip(), doc_text(doc)))
                elif current.kind == "enum":
                    # `case a`, `case a, b` ou `case a = "Texto"` (valor bruto
                    # lido da linha original, já que strip_code apaga textos).
                    if re.match(r"^\s*case \w", code):
                        body = raw.split("//", 1)[0].split("case", 1)[1]
                        for part in body.split(","):
                            pv = re.match(r'^\s*(\w+)\s*(?:=\s*"([^"]*)")?\s*$', part)
                            if not pv:
                                sys.exit(f"case não reconhecido em {current.name}: {raw.strip()}")
                            value = pv.group(2) if pv.group(2) is not None else pv.group(1)
                            current.cases.append((pv.group(1), value))
            if not stripped.startswith("///"):
                doc = []

        if opened_decl:
            stack.append((opened_decl, depth + 1))
        depth += code.count("{") - code.count("}")
        while stack and depth < stack[-1][1]:
            stack.pop()


def doc_text(doc):
    """Primeiro parágrafo do comentário de documentação."""
    para = []
    for line in doc:
        if not line:
            if para:
                break
            continue
        para.append(line)
    return " ".join(para)


def split_top(s, sep):
    level = 0
    for i, ch in enumerate(s):
        if ch in "[<(":
            level += 1
        elif ch in "]>)":
            level -= 1
        elif ch == sep and level == 0:
            return s[:i], s[i + 1:]
    return None


class Builder:
    def __init__(self, decls):
        self.decls = decls
        self.defs = {}

    def resolve(self, name, scope):
        if scope:
            nested = self.decls.get(scope + "#nested", {})
            if name in nested:
                return nested[name]
        if name in self.decls:
            return name
        sys.exit(f"tipo desconhecido: {name} (em {scope})")

    def type_schema(self, typ, scope):
        typ = typ.strip()
        if typ.endswith("?"):
            inner = self.type_schema(typ[:-1], scope)
            return {"anyOf": [inner, {"type": "null"}]}
        if typ.startswith("[") and typ.endswith("]"):
            body = typ[1:-1]
            kv = split_top(body, ":")
            if kv:
                key, value = kv[0].strip(), kv[1]
                obj = {"type": "object", "additionalProperties": self.type_schema(value, scope)}
                if key == "Int":
                    # JSONEncoder grava chave Int como texto: {"3": "..."}
                    obj["propertyNames"] = {"pattern": r"^-?\d+$"}
                elif key != "String":
                    sys.exit(f"dicionário com chave {key} não suportado")
                return obj
            return {"type": "array", "items": self.type_schema(body, scope)}
        m = re.match(r"^Set<(.+)>$", typ)
        if m:
            return {"type": "array", "items": self.type_schema(m.group(1), scope), "uniqueItems": True}
        if typ in SCALARS:
            return dict(SCALARS[typ])
        name = self.resolve(typ, scope)
        self.define(name)
        return {"$ref": f"#/$defs/{name}"}

    def define(self, name):
        if name in self.defs:
            return
        self.defs[name] = None  # reserva (tipos recursivos)
        if name in OVERRIDES:
            self.defs[name] = OVERRIDES[name]
            return
        d = self.decls[name]
        if d.custom_decode or d.coding_keys:
            sys.exit(f"{name} tem init(from:) ou CodingKeys próprios: escreva a entrada em OVERRIDES")
        if d.kind == "enum":
            if "String" not in d.header or "Codable" not in d.header:
                sys.exit(f"enum {name} não é String + Codable")
            self.defs[name] = {"type": "string", "enum": [v for _, v in d.cases]}
            return
        if "Codable" not in d.header:
            sys.exit(f"struct {name} não é Codable")
        props, required = {}, []
        for prop, typ, doc in d.props:
            schema = self.type_schema(typ, name)
            if doc:
                schema = {**schema, "description": doc}
            props[prop] = schema
            if not typ.endswith("?"):
                required.append(prop)
        self.defs[name] = {"type": "object", "required": required, "properties": props}


def build():
    decls = {}
    for rel in SOURCES:
        with open(os.path.join(APP, rel), encoding="utf-8") as f:
            parse(f.read(), decls)
    b = Builder(decls)
    for r in ROOTS:
        b.define(r)
    for name, props in WEB_FIRST_PROPERTIES.items():
        b.defs[name]["properties"].update(props)
    b.defs.update(WEB_FIRST_DEFS)
    defs = {k: b.defs[k] for k in sorted(b.defs)}
    return {
        "$schema": "https://json-schema.org/draft/2020-12/schema",
        "$id": "https://thac0berry/schemas/library.schema.json",
        "title": "Biblioteca de personagens (library.json e backup)",
        "description": (
            "GERADO por thac0berry-ipad/Scripts/gen_library_schema.py a partir de "
            "Models/Character.swift, ActiveEffect.swift, SpellSheet.swift e "
            "Store/CharacterLibrary.swift (LibraryData). Não edite à mão. "
            "Itens de campaigns/characters que não batem com o schema são "
            "descartados pelo iPad (LossyArray), um por um."
        ),
        "type": "object",
        "properties": {
            "schemaVersion": {
                "type": "integer",
                "description": "CharacterLibrary.currentSchemaVersion; ausente = 0. Maior que o do app: abre só para leitura.",
            },
            "campaigns": {"type": "array", "items": {"$ref": "#/$defs/Campaign"}},
            "characters": {"type": "array", "items": {"$ref": "#/$defs/PlayerCharacter"}},
            "favoriteSpellIDs": {"anyOf": [{"type": "array", "items": {"type": "string"}, "uniqueItems": True}, {"type": "null"}]},
            "defaultNotebookPaperStyle": {"anyOf": [{"$ref": "#/$defs/NotebookPaperStyle"}, {"type": "null"}]},
        },
        "$defs": defs,
    }


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true")
    ap.add_argument("--out", default=DEFAULT_OUT)
    args = ap.parse_args()
    text = json.dumps(build(), ensure_ascii=False, indent=2) + "\n"
    if args.check:
        try:
            with open(args.out, encoding="utf-8") as f:
                current = f.read()
        except FileNotFoundError:
            current = None
        if current != text:
            print(f"DIFERE {args.out}: rode python Scripts/gen_library_schema.py e leve o resultado ao thac0berry-data")
            return 1
        print(f"OK {args.out}")
        return 0
    with open(args.out, "w", encoding="utf-8", newline="\n") as f:
        f.write(text)
    print(f"gravado {args.out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
