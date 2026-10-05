#!/usr/bin/env python3
"""Sincroniza os dados de referência do repo `thac0berry-data` para o app.

A fonte única dos JSON (magias, kits, regras, itens…) e dos schemas é o repo
`thac0berry-data`. O Swift Playgrounds precisa dos arquivos DENTRO do projeto,
então este script copia `thac0berry-data/data/*.json` para
`THAC0berry.swiftpm/Resources/`, byte a byte.

Uso:
  python Scripts/sync_data.py            copia (padrão: ../thac0berry-data)
  python Scripts/sync_data.py --check    só compara; sai com 1 se divergir (CI)
  python Scripts/sync_data.py --source <pasta-data>

Não apaga nada sozinho: JSON que existe só no app é listado para decisão manual.
Depois de copiar, o app mudou: siga o ciclo normal (versão, CI, teste no iPad).
"""
import argparse
import os
import shutil
import sys

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
RES = os.path.join(ROOT, "THAC0berry.swiftpm", "Resources")
DEFAULT_SOURCE = os.path.join(ROOT, "..", "thac0berry-data", "data")


def read(path):
    with open(path, "rb") as f:
        return f.read()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true", help="só compara, não copia")
    parser.add_argument("--source", default=DEFAULT_SOURCE, help="pasta data/ do repo thac0berry-data")
    args = parser.parse_args()

    if not os.path.isdir(args.source):
        print(f"Pasta de origem não encontrada: {args.source}")
        print("Clone o repo ao lado deste: git clone https://github.com/Tatarana/thac0berry-data.git")
        return 1

    source = sorted(f for f in os.listdir(args.source) if f.endswith(".json"))
    local = sorted(f for f in os.listdir(RES) if f.endswith(".json"))

    changed = [f for f in source if f not in local or read(os.path.join(args.source, f)) != read(os.path.join(RES, f))]
    only_local = [f for f in local if f not in source]

    for f in changed:
        print(("DIFERE " if args.check else "COPIA  ") + f)
        if not args.check:
            shutil.copyfile(os.path.join(args.source, f), os.path.join(RES, f))
    for f in only_local:
        print(f"SÓ NO APP {f} (não existe em thac0berry-data; decidir se apaga ou se sobe para lá)")

    total = len(changed) + len(only_local)
    if total == 0:
        print(f"OK: {len(source)} arquivos idênticos a thac0berry-data")
        return 0
    if args.check:
        print(f"\nDivergência: {len(changed)} diferente(s), {len(only_local)} só no app. Rode sem --check para copiar.")
        return 1
    print(f"\n{len(changed)} arquivo(s) copiado(s). O app mudou: suba a versão e siga o ciclo (CI + iPad).")
    return 1 if only_local else 0


if __name__ == "__main__":
    sys.exit(main())
