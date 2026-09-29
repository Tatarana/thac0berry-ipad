#!/usr/bin/env python3
"""Converte os literais Swift `let embeddedXNNNN: Type = Type(label: expr, ...)`
de EmbeddedX_PartN.swift em JSON, preservando ordem e conteúdo byte-a-byte
(sem reescrever/parafrasear texto — parser mecânico, não LLM).

Uso:
  python3 swift_lit_to_json.py \
      --parts "Store/EmbeddedRules_Part*.swift" \
      --aggregator Store/EmbeddedRules.swift \
      --out Resources/rules.json
"""
import argparse
import glob
import json
import re
import sys


class Tok:
    __slots__ = ("kind", "value")
    def __init__(self, kind, value=None):
        self.kind = kind
        self.value = value
    def __repr__(self):
        return f"Tok({self.kind!r},{self.value!r})"


def tokenize(src: str):
    toks = []
    i = 0
    n = len(src)
    while i < n:
        c = src[i]
        if c in " \t\r\n":
            i += 1
            continue
        if c == "/" and i + 1 < n and src[i + 1] == "/":
            # line comment (covers /// doc comments too)
            j = src.find("\n", i)
            i = n if j == -1 else j + 1
            continue
        if c == "/" and i + 1 < n and src[i + 1] == "*":
            j = src.find("*/", i + 2)
            i = n if j == -1 else j + 2
            continue
        if c == '"':
            # scan string literal, respecting \" and \\
            j = i + 1
            buf = []
            while j < n:
                ch = src[j]
                if ch == "\\" and j + 1 < n:
                    buf.append(ch)
                    buf.append(src[j + 1])
                    j += 2
                    continue
                if ch == '"':
                    break
                buf.append(ch)
                j += 1
            raw_escaped = "".join(buf)
            toks.append(Tok("STRING", raw_escaped))
            i = j + 1
            continue
        if c.isdigit() or (c == "-" and i + 1 < n and src[i + 1].isdigit()):
            j = i + 1 if c == "-" else i
            j = i
            if c == "-":
                j += 1
            while j < n and (src[j].isdigit() or src[j] == "."):
                j += 1
            toks.append(Tok("NUMBER", src[i:j]))
            i = j
            continue
        if c.isalpha() or c == "_":
            j = i
            while j < n and (src[j].isalnum() or src[j] == "_"):
                j += 1
            word = src[i:j]
            if word == "true":
                toks.append(Tok("BOOL", True))
            elif word == "false":
                toks.append(Tok("BOOL", False))
            elif word == "nil":
                toks.append(Tok("NIL", None))
            elif word in ("import", "let"):
                toks.append(Tok(word.upper(), word))
            else:
                toks.append(Tok("IDENT", word))
            i = j
            continue
        if c == "[":
            toks.append(Tok("LBRACKET")); i += 1; continue
        if c == "]":
            toks.append(Tok("RBRACKET")); i += 1; continue
        if c == "(":
            toks.append(Tok("LPAREN")); i += 1; continue
        if c == ")":
            toks.append(Tok("RPAREN")); i += 1; continue
        if c == ":":
            toks.append(Tok("COLON")); i += 1; continue
        if c == ",":
            toks.append(Tok("COMMA")); i += 1; continue
        if c == ".":
            toks.append(Tok("DOT")); i += 1; continue
        if c == "=":
            toks.append(Tok("EQUALS")); i += 1; continue
        # anything else (stray chars) — skip defensively
        i += 1
    toks.append(Tok("EOF"))
    return toks


class Parser:
    def __init__(self, toks):
        self.toks = toks
        self.pos = 0

    def peek(self):
        return self.toks[self.pos]

    def next(self):
        t = self.toks[self.pos]
        self.pos += 1
        return t

    def expect(self, kind):
        t = self.next()
        if t.kind != kind:
            raise SyntaxError(f"expected {kind}, got {t} at pos {self.pos}")
        return t

    def parse_program(self):
        """Returns dict: name -> parsed value, for every top-level `let`."""
        symbols = {}
        while self.peek().kind != "EOF":
            t = self.peek()
            if t.kind == "IMPORT":
                # skip "import Foundation" line: consume until next LET/EOF-ish token
                self.next()
                while self.peek().kind not in ("LET", "EOF"):
                    self.next()
                continue
            if t.kind == "LET":
                self.next()
                name = self.expect("IDENT").value
                # optional ": Type" — Type may itself contain [ ] tokens
                if self.peek().kind == "COLON":
                    self.next()
                    self.skip_type()
                self.expect("EQUALS")
                value = self.parse_expr()
                symbols[name] = value
                continue
            # unexpected token at top level — skip defensively
            self.next()
        return symbols

    def skip_type(self):
        # consumes a type annotation: IDENT, or [IDENT], or [IDENT: IDENT], optional trailing ?
        depth = 0
        while True:
            t = self.peek()
            if t.kind == "LBRACKET":
                depth += 1; self.next(); continue
            if t.kind == "RBRACKET":
                depth -= 1; self.next(); continue
            if t.kind == "IDENT":
                self.next(); continue
            if t.kind == "COLON" and depth > 0:
                self.next(); continue
            if t.kind == "IDENT" and t.value == "?":
                self.next(); continue
            break
        # trailing '?' isn't tokenized separately (not needed - no '?' char handled);
        # this parser is deliberately permissive since we discard the type anyway.

    def parse_expr(self):
        t = self.peek()
        if t.kind == "STRING":
            self.next()
            return unescape_swift_string(t.value)
        if t.kind == "NUMBER":
            self.next()
            s = t.value
            return float(s) if "." in s else int(s)
        if t.kind == "BOOL":
            self.next()
            return t.value
        if t.kind == "NIL":
            self.next()
            return None
        if t.kind == "LBRACKET":
            return self.parse_bracket()
        if t.kind == "DOT":
            self.next()
            case_name = self.expect("IDENT").value
            if self.peek().kind == "LPAREN":
                self.next()
                args = []
                if self.peek().kind != "RPAREN":
                    args.append(self.parse_expr())
                    while self.peek().kind == "COMMA":
                        self.next()
                        args.append(self.parse_expr())
                self.expect("RPAREN")
                return {"__case__": case_name, "__args__": args}
            return {"__case__": case_name}
        if t.kind == "IDENT":
            name = t.value
            self.next()
            if self.peek().kind == "LPAREN":
                # labeled call: TypeName(label: expr, label: expr, ...)
                self.next()
                fields = {}
                if self.peek().kind != "RPAREN":
                    self.parse_labeled_arg(fields)
                    while self.peek().kind == "COMMA":
                        self.next()
                        self.parse_labeled_arg(fields)
                self.expect("RPAREN")
                return fields
            # bare identifier reference (resolved later)
            return {"__ref__": name}
        raise SyntaxError(f"unexpected token {t} at pos {self.pos}")

    def parse_labeled_arg(self, fields):
        label = self.expect("IDENT").value
        self.expect("COLON")
        value = self.parse_expr()
        fields[label] = value

    def parse_bracket(self):
        self.expect("LBRACKET")
        if self.peek().kind == "COLON":
            # [:] empty dict
            self.next()
            self.expect("RBRACKET")
            return {}
        if self.peek().kind == "RBRACKET":
            self.next()
            return []
        first = self.parse_expr()
        if self.peek().kind == "COLON":
            # dict literal: first was the first KEY
            self.next()
            first_val = self.parse_expr()
            d = {first: first_val}
            while self.peek().kind == "COMMA":
                self.next()
                if self.peek().kind == "RBRACKET":
                    break
                k = self.parse_expr()
                self.expect("COLON")
                v = self.parse_expr()
                d[k] = v
            self.expect("RBRACKET")
            return d
        # array literal
        arr = [first]
        while self.peek().kind == "COMMA":
            self.next()
            if self.peek().kind == "RBRACKET":
                break
            arr.append(self.parse_expr())
        self.expect("RBRACKET")
        return arr


def unescape_swift_string(raw: str) -> str:
    """raw is the content between quotes, with Swift escapes still literal
    (e.g. contains the two chars backslash+n for a newline). Swift and JSON
    use the same escape vocabulary for \\" \\\\ \\n \\t \\r, so we decode
    with Python's own escape handling for exactly that safe subset."""
    out = []
    i = 0
    n = len(raw)
    while i < n:
        c = raw[i]
        if c == "\\" and i + 1 < n:
            nxt = raw[i + 1]
            mapping = {'"': '"', "\\": "\\", "n": "\n", "t": "\t", "r": "\r", "0": "\0"}
            if nxt in mapping:
                out.append(mapping[nxt])
                i += 2
                continue
            # unknown escape — keep both chars as-is (defensive; none expected)
            out.append(c)
            out.append(nxt)
            i += 2
            continue
        out.append(c)
        i += 1
    return "".join(out)


def resolve_refs(value, symbols):
    """Recursively resolve {"__ref__": name} nodes and convert
    {"__case__": ...} enum markers to their Codable JSON shape
    (KitArmorRestriction: .asClass -> "as_class", .specific([...]) -> [...])."""
    if isinstance(value, dict):
        if "__ref__" in value:
            target = symbols[value["__ref__"]]
            return resolve_refs(target, symbols)
        if "__case__" in value:
            case = value["__case__"]
            args = value.get("__args__")
            if args:
                # only single-arg associated-value cases appear in this corpus
                resolved_args = [resolve_refs(a, symbols) for a in args]
                return resolved_args[0] if len(resolved_args) == 1 else resolved_args
            # bare case (no associated value): encode as its snake_case sentinel
            return re.sub(r'(?<!^)(?=[A-Z])', '_', case).lower()
        return {k: resolve_refs(v, symbols) for k, v in value.items()}
    if isinstance(value, list):
        return [resolve_refs(v, symbols) for v in value]
    return value


def parse_file(path: str) -> dict:
    with open(path, "r", encoding="utf-8") as f:
        src = f.read()
    toks = tokenize(src)
    parser = Parser(toks)
    return parser.parse_program()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--parts", required=True, help="glob for EmbeddedX_Part*.swift")
    ap.add_argument("--aggregator", required=True, help="EmbeddedX.swift with the final ordered array")
    ap.add_argument("--array-name", required=True, help="name of the top-level let in the aggregator holding the array")
    ap.add_argument("--out", required=True)
    args = ap.parse_args()

    symbols = {}
    part_files = sorted(glob.glob(args.parts))
    if not part_files:
        print(f"ERROR: no files matched {args.parts}", file=sys.stderr)
        sys.exit(1)
    for path in part_files:
        symbols.update(parse_file(path))

    agg_symbols = parse_file(args.aggregator)
    if args.array_name not in agg_symbols:
        print(f"ERROR: {args.array_name} not found in {args.aggregator}. Found: {list(agg_symbols.keys())}", file=sys.stderr)
        sys.exit(1)
    ordered_refs = agg_symbols[args.array_name]
    if not isinstance(ordered_refs, list):
        print(f"ERROR: {args.array_name} did not parse as an array", file=sys.stderr)
        sys.exit(1)

    result = []
    for ref in ordered_refs:
        resolved = resolve_refs(ref, symbols)
        result.append(resolved)

    with open(args.out, "w", encoding="utf-8") as f:
        json.dump(result, f, ensure_ascii=False, indent=None, separators=(",", ":"))

    print(f"OK: {len(result)} records -> {args.out} ({len(part_files)} source files, {len(symbols)} symbols)")


if __name__ == "__main__":
    main()
