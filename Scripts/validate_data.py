#!/usr/bin/env python3
"""Valida os JSONs de dados contra o schema esperado pelos modelos Swift.
Rode antes de toda entrega:  python3 Scripts/validate_data.py
Sai com código 1 se algo estiver errado."""
import json, os, sys
R = os.path.join(os.path.dirname(__file__), "..", "THAC0berry.swiftpm", "Resources")
S, I = str, int
# campo -> (tipo, obrigatório)
SCHEMAS = {
 "weapons.json": ({"id":(S,1),"name":(S,1),"size":(S,0),"type":(S,0),"speedFactor":(I,1),
    "attacksPerRound":(S,1),"damageSmall":(S,0),"damageLarge":(S,0),"range":(dict,0),"source":(S,0)}, 75),
 "armor.json": ({"id":(S,1),"name":(S,1),"kind":(S,1),"baseAC":(I,0),"cost":(S,0),"weight":(S,0)}, 20),
 "mundane_items.json": ({"id":(S,1),"name":(S,1),"category":(S,1),"cost":(S,0),"weight":(S,0)}, 183),
 "sample_spells.json": ({"id":(S,1),"name":(S,1),"level":(I,1),"caster":(S,1),"school":(S,1),
    "castingTime":(S,1),"range":(S,1),"components":(S,1),"duration":(S,1),"areaOfEffect":(S,1),
    "savingThrow":(S,1),"damage":(S,0),"summary":(S,1),"damageDice":(dict,0),"spheres":(list,0),
    "schools":(list,0),"fullDescription":(S,0),"setting":(S,0)}, 62),
}
ENUMS = {("armor.json","kind"):{"armor","helmet","shield"},("sample_spells.json","caster"):{"arcane","divine"}}
bad = 0
for fn,(schema,count) in SCHEMAS.items():
    data = json.load(open(os.path.join(R,fn),encoding="utf-8"))
    errs=[]
    if len(data)!=count: errs.append(f"count {len(data)} != {count}")
    ids=[d.get("id") for d in data]
    if len(ids)!=len(set(ids)): errs.append("ids duplicados")
    for d in data:
        for k in d:
            if k not in schema: errs.append(f"{d.get('id')}: campo desconhecido {k}")
        for k,(t,req) in schema.items():
            v=d.get(k)
            if v is None:
                if req: errs.append(f"{d.get('id')}: falta {k}")
            elif not isinstance(v,t) or isinstance(v,bool): errs.append(f"{d.get('id')}.{k}: tipo {type(v).__name__}")
            elif (fn,k) in ENUMS and v not in ENUMS[(fn,k)]: errs.append(f"{d.get('id')}.{k}: valor {v}")
    # Swift decodifica SpellDamage com chaves obrigatórias (mesmo com default no struct)
    DMG={"dice","sides","bonus","scalesWithLevel","maxDice","isHealing","bonusPerLevel","maxBonus"}
    if fn=="sample_spells.json":
        for d in data:
            dd=d.get("damageDice")
            if dd is not None and set(dd)!=DMG: errs.append(f"{d['id']}: damageDice precisa de todas as chaves {sorted(DMG-set(dd))}")
    print(("FAIL " if errs else "OK   ")+fn, len(data), "registros")
    for e in errs[:10]: print("   ",e)
    bad+=bool(errs)

# ---- Fase 2a: tabelas de regras ----
def check_rules():
    errs=[]
    GROUPS={"Priest","Rogue","Warrior","Wizard"}
    t=json.load(open(os.path.join(R,"rules_thac0.json")))
    if set(t["groups"])!=GROUPS: errs.append("thac0: grupos")
    for g,row in t["groups"].items():
        if len(row)!=20: errs.append(f"thac0 {g}: {len(row)} níveis")
        if any(b>a for a,b in zip(row,row[1:])): errs.append(f"thac0 {g}: não monotônico")
    s=json.load(open(os.path.join(R,"rules_saving_throws.json")))
    if set(s["groups"])!=GROUPS: errs.append("saves: grupos")
    keys={"paralyzationPoisonDeath","rodStaffWand","petrificationPolymorph","breathWeapon","spell"}
    for g,rows in s["groups"].items():
        if rows[-1]["maxLevel"] is not None: errs.append(f"saves {g}: última faixa deve ser null")
        mls=[r["maxLevel"] for r in rows[:-1]]
        if mls!=sorted(set(mls)): errs.append(f"saves {g}: faixas fora de ordem")
        for r in rows:
            if set(r["values"])!=keys: errs.append(f"saves {g}: chaves")
    print(("FAIL " if errs else "OK   ")+"rules_thac0.json / rules_saving_throws.json")
    for e in errs: print("   ",e)
    return bool(errs)
def check_xp():
    errs=[]
    d=json.load(open(os.path.join(R,"rules_experience.json")))["thresholds"]
    if set(d)!={"Fighter","Paladin","Ranger","Mage","Cleric","Druid","Thief","Bard","Ninja"}: errs.append("classes")
    for c,row in d.items():
        if len(row)!=20 or row[0]!=0: errs.append(f"{c}: 20 níveis começando em 0")
    for c,row in d.items():
        if c!="Druid" and any(b<=a for a,b in zip(row,row[1:])): errs.append(f"{c}: não crescente")
    print(("FAIL " if errs else "OK   ")+"rules_experience.json")
    for e in errs: print("   ",e)
    return bool(errs)
sys.exit(1 if check_rules() or check_xp() or bad else 0)
