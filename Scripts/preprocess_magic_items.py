#!/usr/bin/env python3
"""Trims the raw magic-items corpus (8 category JSON files, ~20MB) down to
what THAC0berry.swiftpm/Models/MagicItem.swift actually decodes, and writes
the result into Resources/ as magic_<category>.json — same convention as
Scripts/convert_spells.py's priest_*.json output, read at runtime by
MagicItemDatabase (see the big comment there for why this corpus uses the
runtime-bundle-JSON pattern instead of embedded Swift literals).

Dropped per item (confirmed always-null/dead across the whole 5,669-item
corpus by a full type audit — see TODO.md item 29/30):
  - description.rawWikitext (47% size overhead, redundant with fullText)
  - intelligentItemProperties, creator (always null, 0/5669)
  - economyAndXP.weight (always null, 0/5669)
  - sources[].volume (always null, 10770/10770 source entries)
  - classification.magicSchool (always null, 0/5669)

Re-run this whenever the raw corpus (in the scratch eval directory) changes;
it is NOT run automatically as part of the app build.
"""
import json
import os

SRC = "/tmp/claude-0/magic-items-eval"
OUT = os.path.join(os.path.dirname(__file__), "..", "THAC0berry.swiftpm", "Resources")

CATEGORY_FILES = [
    "armor_and_shields.json",
    "miscellaneous_a_to_m.json",
    "miscellaneous_n_to_z.json",
    "potions_and_oils.json",
    "rings.json",
    "rods_staves_wands.json",
    "scrolls_and_books.json",
    "weapons.json",
]


def trim_item(it):
    out = {
        "id": it["id"],
        "name": it["name"],
        "wikiPageTitle": it.get("wikiPageTitle"),
        "redirectAliases": it.get("redirectAliases") or [],
        "otherNames": it.get("otherNames") or [],
        "classification": {
            "broadCategory": it["classification"]["broadCategory"],
            "specificType": it["classification"]["specificType"],
        },
        "economyAndXP": {
            "xpValue": it["economyAndXP"].get("xpValue"),
            "goldValue": it["economyAndXP"].get("goldValue"),
            "rawXP": it["economyAndXP"].get("rawXP"),
            "rawValue": it["economyAndXP"].get("rawValue"),
        },
        "description": {
            "briefSummary": it["description"].get("briefSummary") or "",
            "fullText": it["description"].get("fullText") or "",
        },
        "sources": [
            {"book": s.get("book"), "page": s.get("page")}
            for s in (it.get("sources") or [])
        ],
        "categories": it.get("categories") or [],
        "campaignSettings": it.get("campaignSettings") or [],
        "defenseBonus": it.get("defenseBonus"),
    }
    if it.get("enchantment") is not None:
        out["enchantment"] = it["enchantment"]
    if it.get("power") is not None:
        out["power"] = it["power"]
    if it.get("containsSpells"):
        out["containsSpells"] = it["containsSpells"]
    return out


def main():
    total_in = 0
    total_out_bytes = 0
    for fn in CATEGORY_FILES:
        with open(os.path.join(SRC, fn)) as f:
            data = json.load(f)
        total_in += len(data)
        trimmed = [trim_item(it) for it in data]
        out_name = "magic_" + fn
        out_path = os.path.join(OUT, out_name)
        with open(out_path, "w") as f:
            json.dump(trimmed, f, ensure_ascii=False, separators=(",", ":"))
        size = os.path.getsize(out_path)
        total_out_bytes += size
        print(f"{out_name}: {len(trimmed)} items, {size / 1024:.0f} KB")
    print(f"TOTAL: {total_in} items, {total_out_bytes / 1024 / 1024:.2f} MB")


if __name__ == "__main__":
    main()
