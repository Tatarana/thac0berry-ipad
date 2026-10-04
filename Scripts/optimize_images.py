#!/usr/bin/env python3
"""Reduz os PNGs de `THAC0berry.swiftpm/Resources/` ao tamanho que a tela usa.

A arte chega da LLM de imagem com 600-800 px, mas é desenhada bem menor
(tile da Home 108pt, tile do Compendium 78pt, engrenagem 42pt, selo 16pt).
O Swift Playgrounds processa todos os recursos a cada build no iPad, então
pixel sobrando é custo de build/instalação sem ganho visual.

Limite = 3x o maior tamanho de exibição (iPad é @2x; 3x dá folga):
- icon_*   -> lado maior <= 384 px  (108pt * 3 = 324)
- seal_*   -> lado maior <= 128 px  (16pt, folga pra uso maior no futuro)
- banner_* -> altura     <= 324 px  (108pt * 3)
- resto    -> só recompressão sem perda (main_badge é exibido até 920pt).

Idempotente: nunca aumenta imagem; rodar de novo não muda nada.
Uso: python Scripts/optimize_images.py [--dry-run]
"""
import os
import sys

from PIL import Image

RES = os.path.join(os.path.dirname(__file__), "..", "THAC0berry.swiftpm", "Resources")


def target_size(name, w, h):
    if name.startswith("icon_"):
        limit = 384
    elif name.startswith("seal_"):
        limit = 128
    elif name.startswith("banner_"):
        return (round(w * 324 / h), 324) if h > 324 else (w, h)
    else:
        return (w, h)
    scale = limit / max(w, h)
    return (round(w * scale), round(h * scale)) if scale < 1 else (w, h)


def main():
    dry = "--dry-run" in sys.argv
    before = after = 0
    for fn in sorted(os.listdir(RES)):
        if not fn.endswith(".png"):
            continue
        path = os.path.join(RES, fn)
        size0 = os.path.getsize(path)
        im = Image.open(path)
        im.load()
        new = target_size(fn, *im.size)
        if new != im.size:
            im = im.resize(new, Image.LANCZOS)
        if not dry:
            tmp = path + ".tmp"
            im.save(tmp, "PNG", optimize=True)
            # Só substitui se ficou menor (recompressão pura pode não ganhar).
            if new != Image.open(path).size or os.path.getsize(tmp) < size0:
                os.replace(tmp, path)
            else:
                os.remove(tmp)
        size1 = os.path.getsize(path)
        before += size0
        after += size1
        print(f"{fn:34} {size0 // 1024:5} KB -> {size1 // 1024:5} KB  {new[0]}x{new[1]}")
    print(f"Total: {before // 1024} KB -> {after // 1024} KB")


if __name__ == "__main__":
    main()
