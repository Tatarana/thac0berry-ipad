import Foundation

/// Parte 2 de 5 dos kits embutidos — ver `EmbeddedKits.swift` pro
/// porquê disso existir (nunca volte pra ler isso de JSON/bundle) e pro porquê
/// de estar dividido em vários arquivos/constantes em vez de um array literal
/// único gigante: um único `[Kit(...), Kit(...), ...]` com todos os kits
/// dá exatamente no erro clássico do type-checker do Swift ("unable to
/// type-check this expression in reasonable time" — que no Swift
/// Playgrounds às vezes só aparece como "Build Failed" sem detalhe nenhum).
/// Cada kit aqui é uma constante com tipo explícito (`: Kit`), o que faz o
/// compilador checar cada um isoladamente e rápido, em vez de tentar inferir
/// o array inteiro de uma vez.


let embeddedKit020: Kit = Kit(
        id: "guardians_of_the_shrines",
        name: "Guardians of the Shrines",
        wikiPageTitle: "Guardians of the Shrines (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Cleric",
            allowedClasses: ["Cleric"]
        ),
        sourceBook: "The Complete Cleric's Handbook",
        features: KitFeatures(
            role: "Clerics who protect and serve a shrine usually do so for one of two reasons: either they are unable to travel due to age or other circumstances, or there is some pressing situation that requires constant vigilance. Water clerics, for instance, may be forced to care for a particular shrine because it rests on the bank of a stream in need of continual surveillance. Villages and tribal camps are often found near elemental shrines. They reside there, either to exploit the resources of the shrine or to implore its guardian to serve as a kind of holy man for them. The clerics of these shrines are called upon to heal wounds, cure sicknesses, and help destroy whatever threatens the settlement. Some priests help their neighbors willingly, others demand tribute for their services. Villages sometimes view these clerics as eccentric hermits, though they rarely refuse a healing spell.",
            requirements: nil,
            specialBenefits: "Those who spend their lives in the shrines of the elements have earned a special place in the ethereal souls of their masters. There are no special awards per se, but a shrine cleric will almost always be in conjunction with his element. In addition, priests of the shrines often have other skills associated with the local terrain. These proficiencies are free, but are available only if the cleric's shrine is in one of the locations listed below. * Guardians of mountain shrines, usually earth or air, may take the mountaineering proficiency. * Air clerics are known to have skills in astrology, and their shrines are always located beneath the starry sky. Others, living on high mountain peaks or windy canyons, may have learned the wind-sailing proficiency. * A shrine located in a desert or other dry area would force its protector to learn the water-finding skill. * Any shrine known for tending to the needs of travelers, especially those of the element of water, will have a protector with the healing proficiency. Players may select a proficiency or the Dungeon Master can assign proficiencies based on a shrine's surroundings or the tasks its priest would have to learn in a particular location.",
            specialHindrances: nil,
            wealthOptions: nil,
            weaponProficiencies: nil,
            nonweaponProficiencies: nil,
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Scattered like seeds on the wind are the rare shrines of the elementals. Always built over natural features, they usually contain a quantity of an element in its pure form. Clerics say that this helps create a clearer channel of energy to the patron plane.",
            fullText: "## Guardians of the Shrines\nScattered like seeds on the wind are the rare shrines of the elementals. Always built over natural features, they usually contain a quantity of an element in its pure form. Clerics say that this helps create a clearer channel of energy to the patron plane. A cleric of the appropriate element, within range of such a shrine, is significantly more powerful than usual.\n\n**Role:** Clerics who protect and serve a shrine usually do so for one of two reasons: either they are unable to travel due to age or other circumstances, or there is some pressing situation that requires constant vigilance. Water clerics, for instance, may be forced to care for a particular shrine because it rests on the bank of a stream in need of continual surveillance.\n\nVillages and tribal camps are often found near elemental shrines. They reside there, either to exploit the resources of the shrine or to implore its guardian to serve as a kind of holy man for them. The clerics of these shrines are called upon to heal wounds, cure sicknesses, and help destroy whatever threatens the settlement. Some priests help their neighbors willingly, others demand tribute for their services.\n\nVillages sometimes view these clerics as eccentric hermits, though they rarely refuse a healing spell.\n\n**Alignment:** Those who commit their lives to a particular shrine are usually lawful in alignment. Priests who wandered before settling into a shrine may well change alignment as soon as they become attuned to the order and rhythms of life around them.\n\nChaotic guardians tend to be loners. They are often reluctant to allow anyone near their shrines and may use violence to maintain their cherished solitude.\n\nClerics who offer aid and protection to visitors calling on their shrines are usually good-aligned, but neutral priests will often demand some sort of compensation. Evil priests tend to use their shrines as havens from those who would hunt them.\n\n**Special Abilities:** Those who spend their lives in the shrines of the elements have earned a special place in the ethereal souls of their masters. There are no special awards per se, but a shrine cleric will almost always be in conjunction with his element.\n\nIn addition, priests of the shrines often have other skills associated with the local terrain. These proficiencies are free, but are available only if the cleric's shrine is in one of the locations listed below.\n* Guardians of mountain shrines, usually earth or air, may take the mountaineering proficiency.\n* Air clerics are known to have skills in astrology, and their shrines are always located beneath the starry sky. Others, living on high mountain peaks or windy canyons, may have learned the wind-sailing proficiency.\n* A shrine located in a desert or other dry area would force its protector to learn the water-finding skill.\n* Any shrine known for tending to the needs of travelers, especially those of the element of water, will have a protector with the healing proficiency.\n\nPlayers may select a proficiency or the Dungeon Master can assign proficiencies based on a shrine's surroundings or the tasks its priest would have to learn in a particular location.\n\n**Suggested Proficiencies:** Agriculture, ancient history, astrology, blacksmithing (Earth and Fire), fire-building, healing, mining (Earth), mountaineering (Earth), stonemasonry (Earth), survival.",
            rawWikitext: "{{Sidebar EAFW Ch2}}__NOTOC__\n==Guardians of the Shrines==\nScattered like seeds on the wind are the rare shrines of the elementals. Always built over natural features, they usually contain a quantity of an element in its pure form. Clerics say that this helps create a clearer channel of energy to the patron plane. A cleric of the appropriate element, within range of such a shrine, is significantly more powerful than usual.\n\n'''Role:''' Clerics who protect and serve a shrine usually do so for one of two reasons: either they are unable to travel due to age or other circumstances, or there is some pressing situation that requires constant vigilance. Water clerics, for instance, may be forced to care for a particular shrine because it rests on the bank of a stream in need of continual surveillance.\n\nVillages and tribal camps are often found near elemental shrines. They reside there, either to exploit the resources of the shrine or to implore its guardian to serve as a kind of holy man for them. The clerics of these shrines are called upon to heal wounds, cure sicknesses, and help destroy whatever threatens the settlement. Some priests help their neighbors willingly, others demand tribute for their services.\n\nVillages sometimes view these clerics as eccentric hermits, though they rarely refuse a healing spell.\n\n'''Alignment:''' Those who commit their lives to a particular shrine are usually lawful in alignment. Priests who wandered before settling into a shrine may well change alignment as soon as they become attuned to the order and rhythms of life around them.\n\nChaotic guardians tend to be loners. They are often reluctant to allow anyone near their shrines and may use violence to maintain their cherished solitude.\n\nClerics who offer aid and protection to visitors calling on their shrines are usually good-aligned, but neutral priests will often demand some sort of compensation. Evil priests tend to use their shrines as havens from those who would hunt them.\n\n'''Special Abilities:''' Those who spend their lives in the shrines of the elements have earned a special place in the ethereal souls of their masters. There are no special awards per se, but a shrine cleric will almost always be in conjunction with his element.\n\nIn addition, priests of the shrines often have other skills associated with the local terrain. These proficiencies are free, but are available only if the cleric's shrine is in one of the locations listed below.\n* Guardians of mountain shrines, usually earth or air, may take the mountaineering proficiency.\n* Air clerics are known to have skills in astrology, and their shrines are always located beneath the starry sky. Others, living on high mountain peaks or windy canyons, may have learned the wind-sailing proficiency.\n* A shrine located in a desert or other dry area would force its protector to learn the water-finding skill.\n* Any shrine known for tending to the needs of travelers, especially those of the element of water, will have a protector with the healing proficiency.\n\nPlayers may select a proficiency or the Dungeon Master can assign proficiencies based on a shrine's surroundings or the tasks its priest would have to learn in a particular location.\n\n'''Suggested Proficiencies:''' Agriculture, ancient history, astrology, blacksmithing (Earth and Fire), fire-building, healing, mining (Earth), mountaineering (Earth), stonemasonry (Earth), survival.\n\n{{Navbox Earth, Air, Fire and Water}}\n[[Category:Character Kit]]\n[[Category:Character Kit EAFW]]"
        ),
        categories: ["Character Kit", "Character Kit EAFW"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: [:],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: [],
                recommended: [],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: nil
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit021: Kit = Kit(
        id: "helm_bulwark",
        name: "Helm - Bulwark",
        wikiPageTitle: "Helm - Bulwark (Character Kit)",
        redirectAliases: ["Priests of Helm (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The Bulwarks are the ecclesiastics of Helm's faith that acts as bodyguards, sentinels, or any other role that actively involves defense, protection, and warding. Despite the damage to Helm's reputation done during the Avatar crisis, many folks in authority seek out bulwarks for those difficult defense-related tasks. Bulwarks are responsible for much of the income flowing into the coffers of this relatively unpopular (in the North, anyway) church.",
            requirements: "Strength 14, Wisdom 9",
            specialBenefits: "Bulwarks are only surprised on a 1 on a d10. In addition, they gain a +2 bonus to any vision check that needs to be rolled due to constant vigilance. Bulwarks begin their careers with a free suit of plate mail armor and a two-handed weapon donated by the church of Helm. Bulwarks can also turn undead. In the realm of glyphs, a bulwark has a 10% chance per level of identifying a particular glyph of warding. Bulwarks at 7th level can also cast a special glyph of warding spell once a day. This glyph, which resembles the eye of Helm, causes 4d6+1 hit points of damage per level of the priest, exploding in a silent blue flash of magical cold energy when activated. The special glyph is cast by pressing Helm's holy symbol on a surface for one round; the glyph appears as a branded Helm's eye and lasts for twelve hours per level of the priest. In all other ways, it acts as a normal glyph of warding spell.",
            specialHindrances: "Since the church of Helm is suffering a dramatic drop in popularity, the only steady sources of income are the proceeds from the bulwarks' missions. Thus, each bulwark must tithe 50% of his treasure or salary (coins, gems, jewelry) to the church for charity work. If a bulwark is somehow blinded by destruction of his eyes or by magical means, he must make a saving throw (no bonuses) vs rods or suffer the effects of a fear spell for 1d12 hours. While blind, bulwarks are reduced in status to normal clerics of the same level. Regaining his sight will be the bulwark's paramount goal, after which his status as a bulwark is also restored.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Blindfighting",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "The Bulwarks are the ecclesiastics of Helm's faith that acts as bodyguards, sentinels, or any other role that actively involves defense, protection, and warding. Despite the damage to Helm's reputation done during the Avatar crisis, many folks in authority seek out bulwarks for those difficult defense-related tasks.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Human\n|-\n| **Ability Requirements** || Strength 14,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Blindfighting\n|-\n| **Recommended Proficiencies** || Law\n|}\n## Overview\nThe Bulwarks are the ecclesiastics of Helm's faith that acts as bodyguards, sentinels, or any other role that actively involves defense, protection, and warding. Despite the damage to Helm's reputation done during the Avatar crisis, many folks in authority seek out bulwarks for those difficult defense-related tasks.\n\nBulwarks are responsible for much of the income flowing into the coffers of this relatively unpopular (in the North, anyway) church.\n\n## Description\nBulwarks certainly live up to their name. They cut an imposing figure in their plate armor, open-faced helm with a sky blue plume, and a two-handed weapon such as a polearm, battleaxe, or two-handed sword. Bulwarks give the impression of being immovable objects, planted in locations by their duty and staying there until their job is done.\n\n## Role-Playing\nA bulwark takes his job of defender very seriously. Many will not even talk while on duty. To some, this seems to indicate that the bulwark is simply not paying attention. On the contrary, he is so focused on defending his charge that he does not allow himself to be distracted by superfluous people and idle, empty-headed chit-chat.\n\nThe loyalty of a bulwark is beyond question. Loyal and vigilant, they tackle each assignment with a serious, stolid determination.\n\nMany bulwarks are aware of the sullen dislike that most other deities have of Helm, and they tend to watch the clerics of those deities with suspicion.\n\n## Special Abilities\nBulwarks are only surprised on a 1 on a d10. In addition, they gain a +2 bonus to any vision check that needs to be rolled due to constant vigilance.\n\nBulwarks begin their careers with a free suit of plate mail armor and a two-handed weapon donated by the church of Helm. Bulwarks can also turn undead.\n\nIn the realm of glyphs, a bulwark has a 10% chance per level of identifying a particular glyph of warding. Bulwarks at 7th level can also cast a special glyph of warding spell once a day. This glyph, which resembles the eye of Helm, causes 4d6+1 hit points of damage per level of the priest, exploding in a silent blue flash of magical cold energy when activated. The special glyph is cast by pressing Helm's holy symbol on a surface for one round; the glyph appears as a branded Helm's eye and lasts for twelve hours per level of the priest. In all other ways, it acts as a normal glyph of warding spell.\n\n## Special Disadvantages\nSince the church of Helm is suffering a dramatic drop in popularity, the only steady sources of income are the proceeds from the bulwarks' missions. Thus, each bulwark must tithe 50% of his treasure or salary (coins, gems, jewelry) to the church for charity work.\n\nIf a bulwark is somehow blinded by destruction of his eyes or by magical means, he must make a saving throw (no bonuses) vs rods or suffer the effects of a fear spell for 1d12 hours. While blind, bulwarks are reduced in status to normal clerics of the same level. Regaining his sight will be the bulwark's paramount goal, after which his status as a bulwark is also restored.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Human\n|-\n| '''Ability Requirements''' || [[Strength]] 14,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Blind-fighting (Proficiency)|Blindfighting]]\n|-\n| '''Recommended Proficiencies''' || [[Law (Proficiency)|Law]]\n|}__TOC__\n==Overview==\nThe Bulwarks are the ecclesiastics of Helm's faith that acts as bodyguards, sentinels, or any other role that actively involves defense, protection, and warding. Despite the damage to Helm's reputation done during the Avatar crisis, many folks in authority seek out bulwarks for those difficult defense-related tasks.\n\nBulwarks are responsible for much of the income flowing into the coffers of this relatively unpopular (in the North, anyway) church.\n\n==Description==\nBulwarks certainly live up to their name. They cut an imposing figure in their plate armor, open-faced helm with a sky blue plume, and a two-handed weapon such as a polearm, battleaxe, or two-handed sword. Bulwarks give the impression of being immovable objects, planted in locations by their duty and staying there until their job is done.\n\n==Role-Playing==\nA bulwark takes his job of defender very seriously. Many will not even talk while on duty. To some, this seems to indicate that the bulwark is simply not paying attention. On the contrary, he is so focused on defending his charge that he does not allow himself to be distracted by superfluous people and idle, empty-headed chit-chat.\n\nThe loyalty of a bulwark is beyond question. Loyal and vigilant, they tackle each assignment with a serious, stolid determination.\n\nMany bulwarks are aware of the sullen dislike that most other deities have of Helm, and they tend to watch the clerics of those deities with suspicion.\n\n==Special Abilities==\nBulwarks are only surprised on a 1 on a d10. In addition, they gain a +2 bonus to any vision check that needs to be rolled due to constant vigilance.\n\nBulwarks begin their careers with a free suit of plate mail armor and a two-handed weapon donated by the church of Helm. Bulwarks can also turn undead.\n\nIn the realm of glyphs, a bulwark has a 10% chance per level of identifying a particular glyph of warding. Bulwarks at 7th level can also cast a special glyph of warding spell once a day. This glyph, which resembles the eye of Helm, causes 4d6+1 hit points of damage per level of the priest, exploding in a silent blue flash of magical cold energy when activated. The special glyph is cast by pressing Helm's holy symbol on a surface for one round; the glyph appears as a branded Helm's eye and lasts for twelve hours per level of the priest. In all other ways, it acts as a normal glyph of warding spell.\n\n==Special Disadvantages==\nSince the church of Helm is suffering a dramatic drop in popularity, the only steady sources of income are the proceeds from the bulwarks' missions. Thus, each bulwark must tithe 50% of his treasure or salary (coins, gems, jewelry) to the church for charity work.\n\nIf a bulwark is somehow blinded by destruction of his eyes or by magical means, he must make a saving throw (no bonuses) vs rods or suffer the effects of a fear spell for 1d12 hours. While blind, bulwarks are reduced in status to normal clerics of the same level. Regaining his sight will be the bulwark's paramount goal, after which his status as a bulwark is also restored.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Strength": 14, "Wisdom": 9],
                alignments: [],
                races: "Human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Blindfighting"],
                recommended: ["Law"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Helm",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Bulwark"
    )

let embeddedKit022: Kit = Kit(
        id: "helm_quester",
        name: "Helm - Quester",
        wikiPageTitle: "Helm - Quester (Character Kit)",
        redirectAliases: ["Quester (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Helm, He of the Unsleeping Eyes, is the god of guardians and protection. In his infinite wisdom, Helm created the quester a priest that retrieves lost items and rescues lost or kidnapped people.",
            requirements: "Wisdom 9",
            specialBenefits: "Questers cast spells from the Guardian and Protection spheres as if they were one experience level higher than normal. They also cast locate object spells that last 24 hours, rather than the usual B-hour duration.",
            specialHindrances: "Questers of Helm are not especially welcome in the Heartlands and the North, thanks to Helm's belligerent role during the Time of Troubles. He kept the gods from ascending the Celestial Stairway, and killed Mystra when she attempted to do so. All reactions with Northem and Heartland NPCs have a penalty of -4 against the faithful of Helm. Questers cannot cast spells from the Animal and Plant spheres.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Riding, land-based",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Helm, He of the Unsleeping Eyes, is the god of guardians and protection. In his infinite wisdom, Helm created the quester a priest that retrieves lost items and rescues lost or kidnapped people.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Human\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Riding, land-based\n|-\n| **Recommended Proficiencies** || Law, tracking\n|}\n## Overview\nHelm, He of the Unsleeping Eyes, is the god of guardians and protection. In his infinite wisdom, Helm created the quester a priest that retrieves lost items and rescues lost or kidnapped people.\n\n## Description\nAll questers wear full plate mail and an open faced helm with a golden plume. Over this armor, these priests of Helm often don a golden-colored tabard with Helm's eye emblazoned on the chest. Questers can use any weapons, and many favor two-handed swords, totally rejecting the use of a shield.\n\n## Role-Playing\nThe concepts of guarding and protecting are passive and defensive by nature. Questers, on the other hand, aggressively respond to crises that have already taken place like kidnappings or the theft of a valuable item. The questers call this \"reactive defense.\"\n\nQuesters are very single-minded clerics. They see each retrieval mission as a \"quest\", and will single-mindedly go forth and carry out their mission. Any being or force that stands in their way should either move aside or prepare to face their collective wrath.\n\n## Special Abilities\nQuesters cast spells from the Guardian and Protection spheres as if they were one experience level higher than normal. They also cast locate object spells that last 24 hours, rather than the usual B-hour duration.\n\n## Special Disadvantages\nQuesters of Helm are not especially welcome in the Heartlands and the North, thanks to Helm's belligerent role during the Time of Troubles. He kept the gods from ascending the Celestial Stairway, and killed Mystra when she attempted to do so. All reactions with Northem and Heartland NPCs have a penalty of -4 against the faithful of Helm.\n\nQuesters cannot cast spells from the Animal and Plant spheres.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Human\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Riding, Land-Based (Proficiency)|Riding, land-based]]\n|-\n| '''Recommended Proficiencies''' || [[Law (Proficiency)|Law]], [[Tracking (Proficiency)|tracking]]\n|}__TOC__\n==Overview==\nHelm, He of the Unsleeping Eyes, is the god of guardians and protection. In his infinite wisdom, Helm created the quester a priest that retrieves lost items and rescues lost or kidnapped people.\n\n==Description==\nAll questers wear full plate mail and an open faced helm with a golden plume. Over this armor, these priests of Helm often don a golden-colored tabard with Helm's eye emblazoned on the chest. Questers can use any weapons, and many favor two-handed swords, totally rejecting the use of a shield.\n\n==Role-Playing==\nThe concepts of guarding and protecting are passive and defensive by nature. Questers, on the other hand, aggressively respond to crises that have already taken place like kidnappings or the theft of a valuable item. The questers call this \"reactive defense.\"\n\nQuesters are very single-minded clerics. They see each retrieval mission as a \"quest\", and will single-mindedly go forth and carry out their mission. Any being or force that stands in their way should either move aside or prepare to face their collective wrath.\n\n==Special Abilities==\nQuesters cast spells from the Guardian and Protection spheres as if they were one experience level higher than normal. They also cast locate object spells that last 24 hours, rather than the usual B-hour duration.\n\n==Special Disadvantages==\nQuesters of Helm are not especially welcome in the Heartlands and the North, thanks to Helm's belligerent role during the Time of Troubles. He kept the gods from ascending the Celestial Stairway, and killed Mystra when she attempted to do so. All reactions with Northem and Heartland NPCs have a penalty of -4 against the faithful of Helm.\n\nQuesters cannot cast spells from the Animal and Plant spheres.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9],
                alignments: [],
                races: "Human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Riding", "land-based"],
                recommended: ["Law", "tracking"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Helm",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Quester"
    )

let embeddedKit023: Kit = Kit(
        id: "hivemaster",
        name: "Hivemaster",
        wikiPageTitle: "Hivemaster (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "Hivemasters appear somewhat enigmatic. Many attempt to instill insectoid virtues in their followers, such as patience, hard work, and close cooperation. Some higher-level Hivemasters even attempt to influence human societies to adopt a communal pattern modeled on that of hive insects. Others—often styling themselves Webmasters—take on the patient, deadly personas of predator arachnids or insects such as dragonflies or spiders, ruthlessly hunting down (or lying in wait to trap) the enemies of the druidic order. A Hivemaster—s grove usually centers around the dwelling place of the creature for which the druid has the greatest affinity—a forest covered with spider webs, a field with beehives, etc.",
            requirements: nil,
            specialBenefits: "A Hivemaster receives a +4 bonus to saving throws against stings or bites of poisonous insects or arachnids, including giant versions. The druid also gains a +4 bonus on agriculture, animal training, and animal lore proficiency checks concerning insects or arachnids, and can apply the animal training proficiency to giant insects and arachnids. A Hivemaster like Cagua may pass harmlessly through spider webs of all sorts, including webs created by the web spell. When she casts a summon insects, giant insect, creeping doom, or insect plague spell, the player increases her effective level by three. Upon reaching 7th level, the druid gains the ability to shapechange into a giant insect or arachnid type once per day. She can take the form of a nonpoisonous giant ant, giant centipede, giant spider, or giant wasp. The Hivemaster may assume this insectoid form instead of one of her other shapechanging choices (bird, mammal, or reptile). For example, Cagua may choose to avoid the bird form today in favor of the insectoid form, but tomorrow she may decide not to shapechange into reptile form. The druid still can assume only three forms per day, just like the normal druidic shapechanging ability. Note: Gray druids with the Hivemaster kit may assume the insectoid form instead of any one of their usual shapechanging choices: mammal, reptile, or nonpoisonous giant spider.",
            specialHindrances: "The Hivemaster's animal friendship, speak with animals, and summon animals spells allow her to summon or communicate with only insects, giant insects, or arachnids. Hivemasters receive a -3 penalty when using animal proficiencies (animal lore, animal training, etc.) on creatures that are not insects or arachnids.",
            wealthOptions: "3d6-10 gp.",
            weaponProficiencies: "Recommended—scimitar, staff.",
            nonweaponProficiencies: "* Recommended—(general) agriculture; (warrior) animal lore, endurance, set snares.",
            equipment: "The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "The Hivemaster druid lives to foster insectoid and arachnid life wherever it exists. Most low-level Hivemasters, such as Cagua (pictured on the next page) work as beekeepers or the like.",
            fullText: "## Hivemaster\nThe Hivemaster druid lives to foster insectoid and arachnid life wherever it exists. Most low-level Hivemasters, such as Cagua (pictured on the next page) work as beekeepers or the like.\n\n**Role:** Hivemasters appear somewhat enigmatic. Many attempt to instill insectoid virtues in their followers, such as patience, hard work, and close cooperation. Some higher-level Hivemasters even attempt to influence human societies to adopt a communal pattern modeled on that of hive insects. Others—often styling themselves Webmasters—take on the patient, deadly personas of predator arachnids or insects such as dragonflies or spiders, ruthlessly hunting down (or lying in wait to trap) the enemies of the druidic order. A Hivemaster—s grove usually centers around the dwelling place of the creature for which the druid has the greatest affinity—a forest covered with spider webs, a field with beehives, etc.\n\n**Branch Restrictions:** None.\n\n**Weapon Proficiencies:** *Recommended*—scimitar, staff.\n\n**Secondary Skills:** Farmer, woodworker/carpenter.\n\n**Nonweapon Proficiencies:**\n* *Recommended*—(general) agriculture; (warrior) animal lore, endurance, set snares.\n\n**Equipment:** The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp.\n\n**Special Benefits:** A Hivemaster receives a +4 bonus to saving throws against stings or bites of poisonous insects or arachnids, including giant versions.\n\nThe druid also gains a +4 bonus on agriculture, animal training, and animal lore proficiency checks concerning insects or arachnids, and can apply the animal training proficiency to giant insects and arachnids.\n\nA Hivemaster like Cagua may pass harmlessly through spider webs of all sorts, including webs created by the *web* spell. When she casts a *summon insects*, *giant insect*, *creeping doom*, or *insect plague* spell, the player increases her effective level by three.\n\nUpon reaching 7th level, the druid gains the ability to shapechange into a giant insect or arachnid type once per day. She can take the form of a nonpoisonous giant ant, giant centipede, giant spider, or giant wasp. The Hivemaster may assume this insectoid form instead of one of her other shapechanging choices (bird, mammal, or reptile). For example, Cagua may choose to avoid the bird form today in favor of the insectoid form, but tomorrow she may decide not to shapechange into reptile form. The druid still can assume only three forms per day, just like the normal druidic shapechanging ability. Note: Gray druids with the Hivemaster kit may assume the insectoid form instead of any one of their usual shapechanging choices: mammal, reptile, or nonpoisonous giant spider.\n\n**Special Hindrances:** The Hivemaster's *animal friendship, speak with animals*, and *summon animals* spells allow her to summon  or communicate with only insects, giant insects, or arachnids. Hivemasters receive a -3 penalty when using animal proficiencies (animal lore, animal training, etc.) on creatures that are not insects or arachnids.\n\n**Wealth Options:** 3d6-10 gp.",
            rawWikitext: "{{Sidebar CDH Ch2}}__NOTOC__\n==Hivemaster==\nThe Hivemaster druid lives to foster insectoid and arachnid life wherever it exists. Most low-level Hivemasters, such as Cagua (pictured on the next page) work as beekeepers or the like.\n\n'''Role:''' Hivemasters appear somewhat enigmatic. Many attempt to instill insectoid virtues in their followers, such as patience, hard work, and close cooperation. Some higher-level Hivemasters even attempt to influence human societies to adopt a communal pattern modeled on that of hive insects. Others—often styling themselves Webmasters—take on the patient, deadly personas of predator arachnids or insects such as dragonflies or spiders, ruthlessly hunting down (or lying in wait to trap) the enemies of the druidic order. A Hivemaster—s grove usually centers around the dwelling place of the creature for which the druid has the greatest affinity—a forest covered with spider webs, a field with beehives, etc.\n\n'''Branch Restrictions:''' None.\n\n'''Weapon Proficiencies:''' ''Recommended''—scimitar, staff.\n\n'''Secondary Skills:''' Farmer, woodworker/carpenter.\n\n'''Nonweapon Proficiencies:'''\n* ''Recommended''—(general) [[Agriculture (Proficiency)|agriculture]]; (warrior) [[Animal Lore (Proficiency)|animal lore]], [[Endurance (Proficiency)|endurance]], [[Set Snares (Proficiency)|set snares]].\n\n'''Equipment:''' The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' A Hivemaster receives a +4 bonus to saving throws against stings or bites of poisonous insects or arachnids, including giant versions.\n\nThe druid also gains a +4 bonus on agriculture, animal training, and animal lore proficiency checks concerning insects or arachnids, and can apply the animal training proficiency to giant insects and arachnids.\n\nA Hivemaster like Cagua may pass harmlessly through spider webs of all sorts, including webs created by the ''web'' spell. When she casts a ''[[Summon Insects (Priest Spell)|summon insects]]'', ''[[Giant Insect (Priest Spell)|giant insect]]'', ''[[Creeping Doom (Priest Spell)|creeping doom]]'', or ''[[Insect Plague (Priest Spell)|insect plague]]'' spell, the player increases her effective level by three.\n\nUpon reaching 7th level, the druid gains the ability to shapechange into a giant insect or arachnid type once per day. She can take the form of a nonpoisonous giant ant, giant centipede, giant spider, or giant wasp. The Hivemaster may assume this insectoid form instead of one of her other shapechanging choices (bird, mammal, or reptile). For example, Cagua may choose to avoid the bird form today in favor of the insectoid form, but tomorrow she may decide not to shapechange into reptile form. The druid still can assume only three forms per day, just like the normal druidic shapechanging ability. Note: Gray druids with the Hivemaster kit may assume the insectoid form instead of any one of their usual shapechanging choices: mammal, reptile, or nonpoisonous giant spider.\n\n'''Special Hindrances:''' The Hivemaster's ''animal friendship, speak with animals'', and ''summon animals'' spells allow her to summon  or communicate with only insects, giant insects, or arachnids. Hivemasters receive a -3 penalty when using animal proficiencies (animal lore, animal training, etc.) on creatures that are not insects or arachnids.\n\n'''Wealth Options:''' 3d6-10 gp.\n\n{{Navbox The Complete Druid's Handbook}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: [:],
                alignments: ["True Neutral"],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["scimitar", "staff"],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: [],
                recommended: ["agriculture", "animal lore", "endurance", "set snares"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .specific(["wooden_shield"]),
                metalAllowed: false,
                maxArmorClass: "leather_or_padded",
                notes: "Druids are restricted to non-metallic armor (leather, padded, hide) and wooden shields only."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: false,
                mode: "forbidden",
                notes: "Druids cannot turn undead as a core class rule."
            ),
            startingCash: "3d6"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit024: Kit = Kit(
        id: "hoar_nemesis",
        name: "Hoar - Nemesis",
        wikiPageTitle: "Hoar - Nemesis (Character Kit)",
        redirectAliases: ["Priests of Hoar (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Hoar is the lesser power of doom and retribution. The nemeses are his secret priests, most of whom either have been wronged themselves or had someone close to them wronged. In any case, the culprit was either never caught or somehow escaped justice. Nemeses have dedicated their lives to obsessively pursuing evildoers who have evaded punishment. Although they are proficient in laws, a nemesis is well past looking for justice: He is looking for revenge.",
            requirements: "Wisdom 9",
            specialBenefits: "When a nemesis needs to exact vengeance for an unpunished crime, he sequesters himself in a night-long vigil. During this vigil, his prayers are punctuated by screams against the concept of unavenged evil and fervent pleas to Hoar for intervention. With the dawn, the nemesis learns the direction toward his quarry (along compass points like north or north-northwest, but no distance is given). He also receives a vision of the target's present whereabouts. The DM can describe visual clues only about the location and it is up to the player to pinpoint the site. No distance or magic exists that can hide targets from this vision. Once a nemesis finds his quarry, one of them will die. Nemeses can turn undead. If the undead is the target of the nemesis, it must be destroyed in melee.",
            specialHindrances: "A nemesis must be of lawful neutral alignment. When a nemesis has a target in his mind courtesy of the vigil, nothing, no matter how important, can detour him from his all-consuming task. Once a nemesis has avenged a victim, he must inform the victim in person that retribution has been made. If the victim is dead, the nemesis must cast a speak with dead spell to inform the deceased about the mission. Nemeses cannot take up another vengeance quest until the previous one is totally finished. Some nemeses take years tracking a criminal and more years finding the victim to close that circle of retribution.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Law, tracking",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Hoar is the lesser power of doom and retribution. The nemeses are his secret priests, most of whom either have been wronged themselves or had someone close to them wronged. In any case, the culprit was either never caught or somehow escaped justice.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || All but Warrior\n|-\n| **Bonus Proficiencies** || Law, tracking\n|-\n| **Recommended Proficiencies** || Survival\n|}\n## Overview\nHoar is the lesser power of doom and retribution. The nemeses are his secret priests, most of whom either have been wronged themselves or had someone close to them wronged. In any case, the culprit was either never caught or somehow escaped justice. Nemeses have dedicated their lives to obsessively pursuing evildoers who have evaded punishment. Although they are proficient in laws, a nemesis is well past looking for justice: He is looking for revenge.\n\n## Description\nEven the priests of a number of the evil gods do not look as intimidating as a nemesis. The priest carries all the signs of traveling far and wide such as sunburnt, craggy features, wind-tossed hair, and dusty boots and clothes. Most of them have extensive scars, eye-patches, or other external signs of injuries gained through their many battles. Nemeses have a piercing stare that seems to bore right through someone, as if the nemesis can somehow look at someone's inner self and see everything that a person has ever done.\n\nNemeses will use any weapon and any type of armor available to them. The only indications of their ecclesiastical status are the prominently displayed bronze holy symbols they all wear, which show a two-faced man, each face staring in opposing directions.\n\n## Role-Playing\nDriven, obsessive, unstoppable, and with a burning desire to see evil deeds avenged, the nemesis considers himself Hoar's appointed judge, jury, and executioner. A nemesis can work well with a scale or a hand of Tyr, since their missions are similar. However, those priests of Tyr are prompted by respect for the law and a wish to see justice served. A nemesis is motivated solely out of vengeance, either for himself or for the victims who cannot avenge themselves.\n\n## Special Abilities\nWhen a nemesis needs to exact vengeance for an unpunished crime, he sequesters himself in a night-long vigil. During this vigil, his prayers are punctuated by screams against the concept of unavenged evil and fervent pleas to Hoar for intervention. With the dawn, the nemesis learns the direction toward his quarry (along compass points like north or north-northwest, but no distance is given). He also receives a vision of the target's present whereabouts. The DM can describe visual clues only about the location and it is up to the player to pinpoint the site. No distance or magic exists that can hide targets from this vision. Once a nemesis finds his quarry, one of them will die.\n\nNemeses can turn undead. If the undead is the target of the nemesis, it must be destroyed in melee.\n\n## Special Disadvantages\nA nemesis must be of lawful neutral alignment. When a nemesis has a target in his mind courtesy of the vigil, nothing, no matter how important, can detour him from his all-consuming task.\n\nOnce a nemesis has avenged a victim, he must inform the victim in person that retribution has been made. If the victim is dead, the nemesis must cast a speak with dead spell to inform the deceased about the mission. Nemeses cannot take up another vengeance quest until the previous one is totally finished. Some nemeses take years tracking a criminal and more years finding the victim to close that circle of retribution.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || All but Warrior\n|-\n| '''Bonus Proficiencies''' || [[Law (Proficiency)|Law]], [[Tracking (Proficiency)|tracking]]\n|-\n| '''Recommended Proficiencies''' || [[Survival (Proficiency)|Survival]]\n|}__TOC__\n==Overview==\nHoar is the lesser power of doom and retribution. The nemeses are his secret priests, most of whom either have been wronged themselves or had someone close to them wronged. In any case, the culprit was either never caught or somehow escaped justice. Nemeses have dedicated their lives to obsessively pursuing evildoers who have evaded punishment. Although they are proficient in laws, a nemesis is well past looking for justice: He is looking for revenge.\n\n==Description==\nEven the priests of a number of the evil gods do not look as intimidating as a nemesis. The priest carries all the signs of traveling far and wide such as sunburnt, craggy features, wind-tossed hair, and dusty boots and clothes. Most of them have extensive scars, eye-patches, or other external signs of injuries gained through their many battles. Nemeses have a piercing stare that seems to bore right through someone, as if the nemesis can somehow look at someone's inner self and see everything that a person has ever done.\n\nNemeses will use any weapon and any type of armor available to them. The only indications of their ecclesiastical status are the prominently displayed bronze holy symbols they all wear, which show a two-faced man, each face staring in opposing directions.\n\n==Role-Playing==\nDriven, obsessive, unstoppable, and with a burning desire to see evil deeds avenged, the nemesis considers himself Hoar's appointed judge, jury, and executioner. A nemesis can work well with a scale or a hand of Tyr, since their missions are similar. However, those priests of Tyr are prompted by respect for the law and a wish to see justice served. A nemesis is motivated solely out of vengeance, either for himself or for the victims who cannot avenge themselves.\n\n==Special Abilities==\nWhen a nemesis needs to exact vengeance for an unpunished crime, he sequesters himself in a night-long vigil. During this vigil, his prayers are punctuated by screams against the concept of unavenged evil and fervent pleas to Hoar for intervention. With the dawn, the nemesis learns the direction toward his quarry (along compass points like north or north-northwest, but no distance is given). He also receives a vision of the target's present whereabouts. The DM can describe visual clues only about the location and it is up to the player to pinpoint the site. No distance or magic exists that can hide targets from this vision. Once a nemesis finds his quarry, one of them will die.\n\nNemeses can turn undead. If the undead is the target of the nemesis, it must be destroyed in melee.\n\n==Special Disadvantages==\nA nemesis must be of lawful neutral alignment. When a nemesis has a target in his mind courtesy of the vigil, nothing, no matter how important, can detour him from his all-consuming task.\n\nOnce a nemesis has avenged a victim, he must inform the victim in person that retribution has been made. If the victim is dead, the nemesis must cast a speak with dead spell to inform the deceased about the mission. Nemeses cannot take up another vengeance quest until the previous one is totally finished. Some nemeses take years tracking a criminal and more years finding the victim to close that circle of retribution.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9],
                alignments: [],
                races: "Any"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Law", "tracking"],
                recommended: ["Survival"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Hoar",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Nemesis"
    )

let embeddedKit025: Kit = Kit(
        id: "ilmater_alleviator",
        name: "Ilmater - Alleviator",
        wikiPageTitle: "Ilmater - Alleviator (Character Kit)",
        redirectAliases: ["Priests of Ilmater (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Ilmater, the crying god, represents suffering, endurance, and martyrdom. The priestly order of alleviators was started not by Ilmater but by the priests themselves. Rather than passively accept the pain of others, this new faction within Ilmater's church chose to teach people how to cope with pain and suffering.",
            requirements: "Wisdom 9",
            specialBenefits: "Due to their abilities to withstand suffering, alleviators can remain active until they reach a negative hit point total equal to their base hit point total. They can only use this ability in melee if they are protecting someone else from getting hurt. Thus, an alleviator with 23 hit points will not drop until he is reduced to -24 hit points. When a melee encounter concludes, the alleviator must be brought to at least 1 hit point within two rounds or he will die.",
            specialHindrances: "Alleviators must give 70% of their treasure to the church of Ilmater. Also, they cannot turn undead.",
            wealthOptions: "3d6",
            weaponProficiencies: "1",
            nonweaponProficiencies: "Endurance",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Ilmater, the crying god, represents suffering, endurance, and martyrdom. The priestly order of alleviators was started not by Ilmater but by the priests themselves. Rather than passively accept the pain of others, this new faction within Ilmater's church chose to teach people how to cope with pain and suffering.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 1\n|-\n| **Additional Slot** || 0\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Endurance\n|-\n| **Recommended Proficiencies** || None\n|}\n## Overview\nIlmater, the crying god, represents suffering, endurance, and martyrdom. The priestly order of alleviators was started not by Ilmater but by the priests themselves. Rather than passively accept the pain of others, this new faction within Ilmater's church chose to teach people how to cope with pain and suffering.\n\n## Description\nThe alleviators live very simply, and most of them are commonly clad in simple grey robes with a length of rope for a belt. Each wrist has a leather thong tied around it, in honor of Ilmater, although the priest's wrists are not tied together. Alleviators shun armor and shields, and can only use a staff as a weapon.\n\n## Role-Playing\nThe important thing to remember is that alleviators are not responsible for removing people's suffering; they help people endure their sufferings. The alleviators are aware\n\nthat there is much evil and suffering the world, so they emphasize that coping with it makes a person stronger than opposing the pain and losing.\n\nThere are alleviators, however, who will try to alleviate suffering where it is found, or be an advocate for the rights of the common man. This group of alleviators are viewed as radicals within the church.\n\n## Special Abilities\nDue to their abilities to withstand suffering, alleviators can remain active until they reach a negative hit point total equal to their base hit point total. They can only use this ability in melee if they are protecting someone else from getting hurt. Thus, an alleviator with 23 hit points will not drop until he is reduced to -24 hit points. When a melee encounter concludes, the alleviator must be brought to at least 1 hit point within two rounds or he will die.\n\n## Special Disadvantages\nAlleviators must give 70% of their treasure to the church of Ilmater. Also, they cannot turn undead.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 1\n|-\n| '''Additional Slot''' || 0\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Endurance (Proficiency)|Endurance]]\n|-\n| '''Recommended Proficiencies''' || None\n|}__TOC__\n==Overview==\nIlmater, the crying god, represents suffering, endurance, and martyrdom. The priestly order of alleviators was started not by Ilmater but by the priests themselves. Rather than passively accept the pain of others, this new faction within Ilmater's church chose to teach people how to cope with pain and suffering.\n\n==Description==\nThe alleviators live very simply, and most of them are commonly clad in simple grey robes with a length of rope for a belt. Each wrist has a leather thong tied around it, in honor of Ilmater, although the priest's wrists are not tied together. Alleviators shun armor and shields, and can only use a staff as a weapon.\n\n==Role-Playing==\nThe important thing to remember is that alleviators are not responsible for removing people's suffering; they help people endure their sufferings. The alleviators are aware\n\nthat there is much evil and suffering the world, so they emphasize that coping with it makes a person stronger than opposing the pain and losing.\n\nThere are alleviators, however, who will try to alleviate suffering where it is found, or be an advocate for the rights of the common man. This group of alleviators are viewed as radicals within the church.\n\n==Special Abilities==\nDue to their abilities to withstand suffering, alleviators can remain active until they reach a negative hit point total equal to their base hit point total. They can only use this ability in melee if they are protecting someone else from getting hurt. Thus, an alleviator with 23 hit points will not drop until he is reduced to -24 hit points. When a melee encounter concludes, the alleviator must be brought to at least 1 hit point within two rounds or he will die.\n\n==Special Disadvantages==\nAlleviators must give 70% of their treasure to the church of Ilmater. Also, they cannot turn undead.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9],
                alignments: [],
                races: "Any"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Endurance"],
                recommended: [],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: false,
                mode: "forbidden",
                notes: "Also, they cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Ilmater",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Alleviator"
    )

let embeddedKit026: Kit = Kit(
        id: "iyachtu_xvim_gauntlet",
        name: "Iyachtu Xvim - Gauntlet",
        wikiPageTitle: "Iyachtu Xvim - Gauntlet (Character Kit)",
        redirectAliases: ["Priests of Iyachtu Xvim (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Iyacthu Xvim, the Godson, is supposedly the offspring of the god Bane, who died during the Avatar crisis. Xvim, as he most commonly known, began ascending to true power when Zhentil Keep fell during the later Cyrinishad fiasco. One of Xvim's first acts was to create crusaders and several branches of special clergy. The gauntlets of Xvim are fanatical priests who bully the followers of other faiths, especially those who worship Cyric. They are best described as bullies, psychotics, and assassins.",
            requirements: "Strength 12, Wisdom 9",
            specialBenefits: "Gauntlets are immune to all forms of fear. Gauntlets can turn and command undead. Any weapon or armor type is permissible for gauntlets. Gauntlets can also use poison. Gauntlets can make an ability check using Wisdom in order to tell if someone is a worshiper of Cyric. They gain a +2 bonus to that check if the targets wear holy symbols of Cyric on their persons. Since most of Xvim's clergy are former priests of Cyric (who previously were also former priests of Bane), the remainder of Cyric's clergy have a sheer hatred of them. Whenever a cleric, priest, crusader, or specialist priest of Cyric sees a gauntlet, he will immediately attack in a homicidal rage, regardless of where the encounter is or any other conditions. Followers of Cyric gain a +1 to attack and damage rolls against the gauntlets. Furthermore, gauntlets suffer a -1 to their saving throws against spells thrown by clerics and crusaders of Cyric. Gauntlets cannot cast any beneficial effects of spells from the Healing and Necromantic spheres except for cure light wounds. They can, however, use curative items and potions.",
            specialHindrances: nil,
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Inquisitor, religion",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Iyacthu Xvim, the Godson, is supposedly the offspring of the god Bane, who died during the Avatar crisis. Xvim, as he most commonly known, began ascending to true power when Zhentil Keep fell during the later Cyrinishad fiasco.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Dwarf, human\n|-\n| **Ability Requirements** || Strength 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Inquisitor, religion\n|-\n| **Recommended Proficiencies** || Local history\n|}\n## Overview\nIyacthu Xvim, the Godson, is supposedly the offspring of the god Bane, who died during the Avatar crisis. Xvim, as he most commonly known, began ascending to true power when Zhentil Keep fell during the later Cyrinishad fiasco.\n\nOne of Xvim's first acts was to create crusaders and several branches of special clergy. The gauntlets of Xvim are fanatical priests who bully the followers of other faiths, especially those who worship Cyric. They are best described as bullies, psychotics, and assassins.\n\n## Description\nThe gauntlets favor black armor, mostly chain or plate mail, but they always wear black great helms and steel gauntlets. They wear black cloaks and cowls, with a forest green trim around the edges.\n\nIn terms of weaponry, they can choose any weapon, but they must wield at least one edged weapon and one blunt weapon. The gauntlets favor both the overt destructive weapons such as bastard swords and battleaxes, and the more subtle saps and daggers.\n\n## Role-Playing\nAs the servants of an up-and-coming lesser power that is fast approaching intermediate power in the wake of Cyric's failures, the gauntlets are zealots who take every opportunity to spread hatred and tyranny. They often try to turn people and races against each other, or take local political matters into their hands by murder and oppression. The gauntlets are always busy spreading their god's doctrine of hate.\n\nDespite a strong homicidal streak in each and every one of them, the Gauntlets are a well-organized, welldisciplined branch of the faith. They have a definite hierarchy, with the strong bullying the weak, and a strict adherence to Xvim's religious canon. Most of the gauntlets are former priests of Cyric who left the faith when the god betrayed Zhentil Keep.\n\nGauntlets can always find something to hate in any one they meet. That, and their \"survival of the fittest\" mentality, best sums up these miscreants.\n\n## Special Abilities\nGauntlets are immune to all forms of fear. Gauntlets can turn and command undead.\n\nAny weapon or armor type is permissible for gauntlets. Gauntlets can also use poison.\n\nGauntlets can make an ability check using Wisdom in order to tell if someone is a worshiper of Cyric. They gain a +2 bonus to that check if the targets wear holy symbols of Cyric on their persons.\n\nSince most of Xvim's clergy are former priests of Cyric (who previously were also former priests of Bane), the remainder of Cyric's clergy have a sheer hatred of them. Whenever a cleric, priest, crusader, or specialist priest of Cyric sees a gauntlet, he will immediately attack in a homicidal rage, regardless of where the encounter is or any other conditions.\n\nFollowers of Cyric gain a +1 to attack and damage rolls against the gauntlets. Furthermore, gauntlets suffer a -1 to their saving throws against spells thrown by clerics and crusaders of Cyric.\n\nGauntlets cannot cast any beneficial effects of spells from the Healing and Necromantic spheres except for cure light wounds. They can, however, use curative items and potions.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Dwarf, human\n|-\n| '''Ability Requirements''' || [[Strength]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Inquisitor (Character Kit)|Inquisitor]], [[Religion (Proficiency)|religion]]\n|-\n| '''Recommended Proficiencies''' || [[Local History (Proficiency)|Local history]]\n|}__TOC__\n==Overview==\nIyacthu Xvim, the Godson, is supposedly the offspring of the god Bane, who died during the Avatar crisis. Xvim, as he most commonly known, began ascending to true power when Zhentil Keep fell during the later Cyrinishad fiasco.\n\nOne of Xvim's first acts was to create crusaders and several branches of special clergy. The gauntlets of Xvim are fanatical priests who bully the followers of other faiths, especially those who worship Cyric. They are best described as bullies, psychotics, and assassins.\n\n==Description==\nThe gauntlets favor black armor, mostly chain or plate mail, but they always wear black great helms and steel gauntlets. They wear black cloaks and cowls, with a forest green trim around the edges.\n\nIn terms of weaponry, they can choose any weapon, but they must wield at least one edged weapon and one blunt weapon. The gauntlets favor both the overt destructive weapons such as bastard swords and battleaxes, and the more subtle saps and daggers.\n\n==Role-Playing==\nAs the servants of an up-and-coming lesser power that is fast approaching intermediate power in the wake of Cyric's failures, the gauntlets are zealots who take every opportunity to spread hatred and tyranny. They often try to turn people and races against each other, or take local political matters into their hands by murder and oppression. The gauntlets are always busy spreading their god's doctrine of hate.\n\nDespite a strong homicidal streak in each and every one of them, the Gauntlets are a well-organized, welldisciplined branch of the faith. They have a definite hierarchy, with the strong bullying the weak, and a strict adherence to Xvim's religious canon. Most of the gauntlets are former priests of Cyric who left the faith when the god betrayed Zhentil Keep.\n\nGauntlets can always find something to hate in any one they meet. That, and their \"survival of the fittest\" mentality, best sums up these miscreants.\n\n==Special Abilities==\nGauntlets are immune to all forms of fear. Gauntlets can turn and command undead.\n\nAny weapon or armor type is permissible for gauntlets. Gauntlets can also use poison.\n\nGauntlets can make an ability check using Wisdom in order to tell if someone is a worshiper of Cyric. They gain a +2 bonus to that check if the targets wear holy symbols of Cyric on their persons.\n\nSince most of Xvim's clergy are former priests of Cyric (who previously were also former priests of Bane), the remainder of Cyric's clergy have a sheer hatred of them. Whenever a cleric, priest, crusader, or specialist priest of Cyric sees a gauntlet, he will immediately attack in a homicidal rage, regardless of where the encounter is or any other conditions.\n\nFollowers of Cyric gain a +1 to attack and damage rolls against the gauntlets. Furthermore, gauntlets suffer a -1 to their saving throws against spells thrown by clerics and crusaders of Cyric.\n\nGauntlets cannot cast any beneficial effects of spells from the Healing and Necromantic spheres except for cure light wounds. They can, however, use curative items and potions.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Strength": 12, "Wisdom": 9],
                alignments: [],
                races: "Dwarf, human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Inquisitor", "religion"],
                recommended: ["Local history"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "modified",
                notes: "command undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Iyachtu Xvim",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Gauntlet"
    )

let embeddedKit027: Kit = Kit(
        id: "iyachtu_xvim_orb",
        name: "Iyachtu Xvim - Orb",
        wikiPageTitle: "Iyachtu Xvim - Orb (Character Kit)",
        redirectAliases: ["Orb (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Every starting faith needs its missionaries, and the orbs, named for the glowing green eyes of Xvim, are the messengers of this new faith. Of course, the orbs use methods like blackmail, coercion, and intimidation to spread the ugly message of their god.",
            requirements: "Charisma 12, Wisdom 9",
            specialBenefits: "Orbs can cast fear once per day, and are also immune to any fear effects, including dragon fear. They can turn and command undead.",
            specialHindrances: "Orbs are always looking for any hint of the location of the Cyrinishad, a book and artifact of Cyrics which they are dedicated to eventually destroying. This quest takes precedence over anything else, even recruiting worshipers, if any word arrives of the books location. Orbs cannot cast any spells from the Creation sphere.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Inquisitor, religion",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Every starting faith needs its missionaries, and the orbs, named for the glowing green eyes of Xvim, are the messengers of this new faith. Of course, the orbs use methods like blackmail, coercion, and intimidation to spread the ugly message of their god.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Charisma 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 3\n|-\n| **Additional Slot** || 4\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Inquisitor, religion\n|-\n| **Recommended Proficiencies** || None\n|}\n## Overview\nEvery starting faith needs its missionaries, and the orbs, named for the glowing green eyes of Xvim, are the messengers of this new faith. Of course, the orbs use methods like blackmail, coercion, and intimidation to spread the ugly message of their god.\n\n## Description\nOrbs wear long black cassocks, black iron skullcaps, and green ecclesiastical stoles. They also wear black iron gauntlets that have a pair of glowing green eyes painted on the back of the hand. These gauntlets are actually the priests' holy symbols of Xvim. Armor is worn under the\n\ncassock, and is usually chain mail. Orbs favor hammers as a weapon.\n\n## Role-Playing\nThe orbs are aware of the importance of their mission. They know that the more followers they recruit, the stronger Xvim gets. Orbs begin as charming orators, talking about Cyric's failure and Xvim's resurgence.\n\nThe orbs and the clergy of Xvim have learned to pay spies and thieves well for \"delicate\" information. Those who do not accept Xvim as their true god are approached in private, where they are threatened or blackmailed into joining Xvim's flock. The orbs are especially looking for influential, powerful, and wealthy people to join up and expand the faith.\n\n## Special Abilities\nOrbs can cast fear once per day, and are also immune to any fear effects, including *dragon fear*. They can turn and command undead.\n\n## Special Disadvantages\nOrbs are always looking for any hint of the location of the Cyrinishad, a book and artifact of Cyrics which they are dedicated to eventually destroying. This quest takes precedence over anything else, even recruiting worshipers, if any word arrives of the books location.\n\nOrbs cannot cast any spells from the Creation sphere.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Charisma]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 3\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Inquisitor (Character Kit)|Inquisitor]], [[Religion (Proficiency)|religion]]\n|-\n| '''Recommended Proficiencies''' || None\n|}__TOC__\n==Overview==\nEvery starting faith needs its missionaries, and the orbs, named for the glowing green eyes of Xvim, are the messengers of this new faith. Of course, the orbs use methods like blackmail, coercion, and intimidation to spread the ugly message of their god.\n\n==Description==\nOrbs wear long black cassocks, black iron skullcaps, and green ecclesiastical stoles. They also wear black iron gauntlets that have a pair of glowing green eyes painted on the back of the hand. These gauntlets are actually the priests' holy symbols of Xvim. Armor is worn under the\n\ncassock, and is usually chain mail. Orbs favor hammers as a weapon.\n\n==Role-Playing==\nThe orbs are aware of the importance of their mission. They know that the more followers they recruit, the stronger Xvim gets. Orbs begin as charming orators, talking about Cyric's failure and Xvim's resurgence.\n\nThe orbs and the clergy of Xvim have learned to pay spies and thieves well for \"delicate\" information. Those who do not accept Xvim as their true god are approached in private, where they are threatened or blackmailed into joining Xvim's flock. The orbs are especially looking for influential, powerful, and wealthy people to join up and expand the faith.\n\n==Special Abilities==\nOrbs can cast fear once per day, and are also immune to any fear effects, including ''dragon fear''. They can turn and command undead.\n\n==Special Disadvantages==\nOrbs are always looking for any hint of the location of the Cyrinishad, a book and artifact of Cyrics which they are dedicated to eventually destroying. This quest takes precedence over anything else, even recruiting worshipers, if any word arrives of the books location.\n\nOrbs cannot cast any spells from the Creation sphere.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9, "Charisma": 12],
                alignments: [],
                races: "Any"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Inquisitor", "religion"],
                recommended: [],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "modified",
                notes: "command undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Iyachtu Xvim",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Orb"
    )

let embeddedKit028: Kit = Kit(
        id: "kelemvor_mortarchs",
        name: "Kelemvor - Mortarchs",
        wikiPageTitle: "Kelemvor - Mortarchs (Character Kit)",
        redirectAliases: ["Priests of Kelemvor (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "As the newly-made Lord of the Dead, Kelemvor has consolidated his position by creating several special priests. The mortarch is a priest who specializes in consecrating graves, maintaining the knowledge of burial customs, and comforting the bereaved.",
            requirements: "Charisma 12, Wisdom 9",
            specialBenefits: "Mortarch have access to a special bless spell. When cast on a grave, the grave itself can turn away undead at the same level as the casting priest. The body buried in that grave also cannot become undead. The bless lasts for one year per level of the priest. Mortarchs are also able to turn undead as if they were one level higher than they actually are.",
            specialHindrances: "Mortarchs can only use clubs, hammers, horseman's maces or flails. They cannot cast raise dead or resurrection, nor use any items which duplicate those spells.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Burial customs",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "As the newly-made Lord of the Dead, Kelemvor has consolidated his position by creating several special priests. The mortarch is a priest who specializes in consecrating graves, maintaining the knowledge of burial customs, and comforting the bereaved.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Charisma 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Burial customs\n|-\n| **Recommended Proficiencies** || Ancient history, etiquette, folklore\n|}\n## Overview\nAs the newly-made Lord of the Dead, Kelemvor has consolidated his position by creating several special priests. The mortarch is a priest who specializes in consecrating graves, maintaining the knowledge of burial customs, and comforting the bereaved.\n\n## Description\nMortarchs dress in elegant but somber robes of dark blue and light grey, and they wear silver circlets on their brows. Any weaponry that they carry must be hidden within the folds of their robes, as mourners are unsettled by the sight of brandished weapons.\n\n## Role-Playing\nDeath is but a part of life, and mortarchs try to teach this to the living. Death is not to be feared, although it is not also to be prematurely embraced either. Death is simply the end of the normal mortal cycle. The undead are an abomination against that proper cycle of life and death.\n\nAll souls have the right to a decent burial regardless of their actions in life; a mortarch does not judge the dead—that is the duty of the gods. Every corpse must be treated with dignity, from the lowliest guttersnipe to the mightiest king, since respect for the deceased bespeaks respect for the Lord of the Dead.\n\n## Special Abilities\nMortarch have access to a special bless spell. When cast on a grave, the grave itself can turn away undead at the same level as the casting priest. The body buried in that grave also cannot become undead. The bless lasts for one year per level of the priest. Mortarchs are also able to turn undead as if they were one level higher than they actually are.\n\n## Special Disadvantages\nMortarchs can only use clubs, hammers, horseman's maces or flails. They cannot cast raise dead or resurrection, nor use any items which duplicate those spells.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Charisma]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Burial Customs (Proficiency)|Burial customs]]\n|-\n| '''Recommended Proficiencies''' || [[Ancient History (Proficiency)|Ancient history]], [[Etiquette (Proficiency)|etiquette]], [[Folklore (Proficiency)|folklore]]\n|}__TOC__\n==Overview==\nAs the newly-made Lord of the Dead, Kelemvor has consolidated his position by creating several special priests. The mortarch is a priest who specializes in consecrating graves, maintaining the knowledge of burial customs, and comforting the bereaved.\n\n==Description==\nMortarchs dress in elegant but somber robes of dark blue and light grey, and they wear silver circlets on their brows. Any weaponry that they carry must be hidden within the folds of their robes, as mourners are unsettled by the sight of brandished weapons.\n\n==Role-Playing==\nDeath is but a part of life, and mortarchs try to teach this to the living. Death is not to be feared, although it is not also to be prematurely embraced either. Death is simply the end of the normal mortal cycle. The undead are an abomination against that proper cycle of life and death.\n\nAll souls have the right to a decent burial regardless of their actions in life; a mortarch does not judge the dead—that is the duty of the gods. Every corpse must be treated with dignity, from the lowliest guttersnipe to the mightiest king, since respect for the deceased bespeaks respect for the Lord of the Dead.\n\n==Special Abilities==\nMortarch have access to a special bless spell. When cast on a grave, the grave itself can turn away undead at the same level as the casting priest. The body buried in that grave also cannot become undead. The bless lasts for one year per level of the priest. Mortarchs are also able to turn undead as if they were one level higher than they actually are.\n\n==Special Disadvantages==\nMortarchs can only use clubs, hammers, horseman's maces or flails. They cannot cast raise dead or resurrection, nor use any items which duplicate those spells.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9, "Charisma": 12],
                alignments: [],
                races: "Any"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Burial customs"],
                recommended: ["Ancient history", "etiquette", "folklore"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "modified",
                notes: "turn undead as if they were one level higher than they actually are"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Kelemvor",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Mortarchs"
    )

let embeddedKit029: Kit = Kit(
        id: "kelemvor_necrobane",
        name: "Kelemvor - Necrobane",
        wikiPageTitle: "Kelemvor - Necrobane (Character Kit)",
        redirectAliases: ["Necrobane (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The necrobane's task is to battle all manner of undead, halting the spread of animated bodies (skeletons and zombies), and putting the undead souls to rest (ghouls, wights, spectres, etc).",
            requirements: "Wisdom 9",
            specialBenefits: nil,
            specialHindrances: "Once every other tenday, a necrobane must slay at least one undead creature. Failure to do so results in a -1 penalty on all attack rolls, damage rolls, saving throws, proficiency checks, initiative rolls, and surprise rolls. Necrobanes and necromancers most definitely do not get along, even if their alignments are exactly the same. The difference is a philosophical one—The necrobanes wish to stop all undead and preserve the natural balance of death, while necromancers see undeath as a way to extend a lifetime. As a result, each class has a -4 reaction penalty on interactions with the other. Necrobanes are also not allowed to cast any spells from the Necromantic sphere, and they cannot use any magic items which duplicate these effects.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Burial customs",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "The necrobane's task is to battle all manner of undead, halting the spread of animated bodies (skeletons and zombies), and putting the undead souls to rest (ghouls, wights, spectres, etc).",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Dwarf, half-elf, human\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Burial customs\n|-\n| **Recommended Proficiencies** || Ancient history\n|}\n## Overview\nThe necrobane's task is to battle all manner of undead, halting the spread of animated bodies (skeletons and zombies), and putting the undead souls to rest (ghouls, wights, spectres, etc).\n\n## Description\nNecrobanes can wear any type of armor and they can use any type of weapon. They wear black cloaks, don silver circlets on their brows, and Kelemvor's holy symbol is prominently displayed on a neck chain.\n\n## Role-Playing\nUndead walking around Faerûn are offensive to Kelemvor, and the necrobanes are fueled by that same anger burning within them. If given a choice of attacking orcs or wights, the necrobane will choose the wights\n\nwithout hesitation. And despite this anger against undead, the necrobane also has Kelemvor's compassion for restless souls. While the mindless undead are dispatched casually, there is pity for the spirits in even the most evil undead.\n\nThe extremely intelligent and powerful undead, such as vampires and liches, are the ones that even a necrobane can have a hard time feeling pity for them. Lichdom is a premeditated act, and full-strength vampires are extremely foul entities, thus earning a greater share of the necrobane's enmity. The cycle of life demands that mortals die, not prolong their lives unnaturally through necromancy and other foul magic, and a necrobane simply wishes to further that cycle.\n\n## Special Advantages\nNecrobanes are immune to the paralytic touch of ghouls and ghasts. Furthermore, they get a saving throw vs. spells to defend against the level-draining abilities of spectres, wraiths, and wights, and the Strength-draining attacks of shadows.\n\nNecrobanes can identify any type of undead on sight. If the undead is somehow magically disguised, the necrobane gets an ability check based on Wisdom. Succeeding the roll tells the necrobane that there is \"something not quite right\" about the disguised being in question.\n\nWhen turning undead, necrobanes affect twice the normal number (roll 2d6 and double the result).\n\nNecrobanes' damage rolls are unaffected by damage restrictions against specific undead. For example, they can use edged weapons against skeletons without any damage penalties or reduction.\n\n## Special Disadvantages\nOnce every other tenday, a necrobane must slay at least one undead creature. Failure to do so results in a -1 penalty on all attack rolls, damage rolls, saving throws, proficiency checks, initiative rolls, and surprise rolls.\n\nNecrobanes and necromancers most definitely do not get along, even if their alignments are exactly the same. The difference is a philosophical one—The necrobanes wish to stop all undead and preserve the natural balance of death, while necromancers see undeath as a way to extend a lifetime. As a result, each class has a -4 reaction penalty on interactions with the other.\n\nNecrobanes are also not allowed to cast any spells from the Necromantic sphere, and they cannot use any magic items which duplicate these effects.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Dwarf, half-elf, human\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Burial Customs (Proficiency)|Burial customs]]\n|-\n| '''Recommended Proficiencies''' || [[Ancient History (Proficiency)|Ancient history]]\n|}__TOC__\n==Overview==\nThe necrobane's task is to battle all manner of undead, halting the spread of animated bodies (skeletons and zombies), and putting the undead souls to rest (ghouls, wights, spectres, etc).\n\n==Description==\nNecrobanes can wear any type of armor and they can use any type of weapon. They wear black cloaks, don silver circlets on their brows, and Kelemvor's holy symbol is prominently displayed on a neck chain.\n\n==Role-Playing==\nUndead walking around Faerûn are offensive to Kelemvor, and the necrobanes are fueled by that same anger burning within them. If given a choice of attacking orcs or wights, the necrobane will choose the wights\n\nwithout hesitation. And despite this anger against undead, the necrobane also has Kelemvor's compassion for restless souls. While the mindless undead are dispatched casually, there is pity for the spirits in even the most evil undead.\n\nThe extremely intelligent and powerful undead, such as vampires and liches, are the ones that even a necrobane can have a hard time feeling pity for them. Lichdom is a premeditated act, and full-strength vampires are extremely foul entities, thus earning a greater share of the necrobane's enmity. The cycle of life demands that mortals die, not prolong their lives unnaturally through necromancy and other foul magic, and a necrobane simply wishes to further that cycle.\n\n==Special Advantages==\nNecrobanes are immune to the paralytic touch of ghouls and ghasts. Furthermore, they get a saving throw vs. spells to defend against the level-draining abilities of spectres, wraiths, and wights, and the Strength-draining attacks of shadows.\n\nNecrobanes can identify any type of undead on sight. If the undead is somehow magically disguised, the necrobane gets an ability check based on Wisdom. Succeeding the roll tells the necrobane that there is \"something not quite right\" about the disguised being in question.\n\nWhen turning undead, necrobanes affect twice the normal number (roll 2d6 and double the result).\n\nNecrobanes' damage rolls are unaffected by damage restrictions against specific undead. For example, they can use edged weapons against skeletons without any damage penalties or reduction.\n\n==Special Disadvantages==\nOnce every other tenday, a necrobane must slay at least one undead creature. Failure to do so results in a -1 penalty on all attack rolls, damage rolls, saving throws, proficiency checks, initiative rolls, and surprise rolls.\n\nNecrobanes and necromancers most definitely do not get along, even if their alignments are exactly the same. The difference is a philosophical one—The necrobanes wish to stop all undead and preserve the natural balance of death, while necromancers see undeath as a way to extend a lifetime. As a result, each class has a -4 reaction penalty on interactions with the other.\n\nNecrobanes are also not allowed to cast any spells from the Necromantic sphere, and they cannot use any magic items which duplicate these effects.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9],
                alignments: [],
                races: "Dwarf, half-elf, human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Burial customs"],
                recommended: ["Ancient history"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Kelemvor",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Necrobane"
    )

let embeddedKit030: Kit = Kit(
        id: "lathander_springlord_lady",
        name: "Lathander - Springlord/lady",
        wikiPageTitle: "Lathander - Springlord/lady (Character Kit)",
        redirectAliases: ["Priests of Lathander (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The springlords of Lathander epitomize the most popular aspects of renewal as experienced by all the races of the Realms. These priests act as healers, midwives, and raisers of the dead.",
            requirements: "Wisdom 9",
            specialBenefits: "All healing nonweapon proficiency checks gain a +2 bonus. The springlord can also use the healing proficiency to diagnose the precise nature and extent of the injury (how many hit points reduced, what sort of disease, or what type of poison used, etc.). All healing spells cast by the springlord gain a +2 bonus.",
            specialHindrances: "Springlords cannot use Combat spells, and can only wield clubs, staves, and slings. The heaviest armor a springlord can wear is chain mail.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Artistic ability, healing",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "The springlords of Lathander epitomize the most popular aspects of renewal as experienced by all the races of the Realms. These priests act as healers, midwives, and raisers of the dead.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Artistic ability, healing\n|-\n| **Recommended Proficiencies** || Herbalism\n|}\n## Overview\nThe springlords of Lathander epitomize the most popular aspects of renewal as experienced by all the races of the Realms. These priests act as healers, midwives, and raisers of the dead.\n\n## Description\nSpringlords wear long, loose robes of yellow, pink, and red, the traditional colors of Lathander. The hem, cuffs, and other borders are trimmed in green, which symbolizes renewal. Springlords do not wear the more ostentatious ceremonial headgear except on holy days or when attending important rulers and the like.\n\n## Role-Playing\nSpringlords shun praise, pomp, and ceremony. They enjoy being \"priests of the people,\" and are the least structured of Lathander's clergy.\n\nTo a springlord, events such as births, rebirths, and restorations are all good causes for celebration. If someone cannot afford to pay for healing or resurrection spells or other services, the springlord will perform them anyway. However, they draw the line at healing the same party of adventurers who keep coming back time and time again. This charity will be provided only once for any one person, and be sure that a springlord will remember.\n\nEach springlord also has an artistic talent of some sort. This can be painting, sculpting, singing, poetry, or any art medium and it is used to honor Lathander.\n\n## Special Abilities\nAll healing nonweapon proficiency checks gain a +2 bonus. The springlord can also use the healing proficiency to diagnose the precise nature and extent of the injury (how many hit points reduced, what sort of disease, or what type of poison used, etc.). All healing spells cast by the springlord gain a +2 bonus.\n\n## Special Disadvantages\nSpringlords cannot use Combat spells, and can only wield clubs, staves, and slings. The heaviest armor a springlord can wear is chain mail.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Artistic Ability (Proficiency)|Artistic ability]], [[Healing (Proficiency)|healing]]\n|-\n| '''Recommended Proficiencies''' || [[Herbalism (Proficiency)|Herbalism]]\n|}__TOC__\n==Overview==\nThe springlords of Lathander epitomize the most popular aspects of renewal as experienced by all the races of the Realms. These priests act as healers, midwives, and raisers of the dead.\n\n==Description==\nSpringlords wear long, loose robes of yellow, pink, and red, the traditional colors of Lathander. The hem, cuffs, and other borders are trimmed in green, which symbolizes renewal. Springlords do not wear the more ostentatious ceremonial headgear except on holy days or when attending important rulers and the like.\n\n==Role-Playing==\nSpringlords shun praise, pomp, and ceremony. They enjoy being \"priests of the people,\" and are the least structured of Lathander's clergy.\n\nTo a springlord, events such as births, rebirths, and restorations are all good causes for celebration. If someone cannot afford to pay for healing or resurrection spells or other services, the springlord will perform them anyway. However, they draw the line at healing the same party of adventurers who keep coming back time and time again. This charity will be provided only once for any one person, and be sure that a springlord will remember.\n\nEach springlord also has an artistic talent of some sort. This can be painting, sculpting, singing, poetry, or any art medium and it is used to honor Lathander.\n\n==Special Abilities==\nAll healing nonweapon proficiency checks gain a +2 bonus. The springlord can also use the healing proficiency to diagnose the precise nature and extent of the injury (how many hit points reduced, what sort of disease, or what type of poison used, etc.). All healing spells cast by the springlord gain a +2 bonus.\n\n==Special Disadvantages==\nSpringlords cannot use Combat spells, and can only wield clubs, staves, and slings. The heaviest armor a springlord can wear is chain mail.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9],
                alignments: [],
                races: "Any"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Artistic ability", "healing"],
                recommended: ["Herbalism"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Lathander",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Springlord/lady"
    )

let embeddedKit031: Kit = Kit(
        id: "leira_mistwalker",
        name: "Leira - Mistwalker",
        wikiPageTitle: "Leira - Mistwalker (Character Kit)",
        redirectAliases: ["Priests of Leira (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Leira was the goddess of deception and illusion, and the patron goddess of liars and illusionists. She was supposedly slain under mysterious circumstances during the Avatar crisis. However, this sect of priests, the mistwalkers, still gets divine power and claims that Leira is the source. Cyric is currently the clandestine source of these priests' powers, or so it seems. Of course, when people deal with a goddess of deception and the Prince of Lies, no one can be quite sure what the real truth is.",
            requirements: "Wisdom 9, Intelligence 14",
            specialBenefits: "Mistwalkers get a saving throw to resist the power of a ring of truth. Also, all mistwalkers have +2 bonuses on their saving throws to disbelieve an illusion. Mistwalkers can cast phantasmal force once per day. At 3rd level, they can cast improved phantasmal force once per day. At 5th level, mistwalkers can cast spectral force once per day. At 9th level, a mistwalker's holy symbol of Leira acts as an amulet of proof against detection and location.",
            specialHindrances: "Mistwalkers suffer a -1 penalty to saving throws and attack rolls in direct sunlight. They cannot turn undead. Due to their notorious reputation as liars, Mistwalkers also suffer a -4 penalty to reaction rolls with all NPCs. Mistwalkers cannot wear any armor heavier than leather, and cannot use shields or two-handed weapons of any kind. Most weapons allowed are easily concealed, like daggers and short swords. The only missile weapons allowed are throwing daggers and blowguns.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Disguise, forgery",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Leira was the goddess of deception and illusion, and the patron goddess of liars and illusionists. She was supposedly slain under mysterious circumstances during the Avatar crisis. However, this sect of priests, the mistwalkers, still gets divine power and claims that Leira is the source.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any except dwarves\n|-\n| **Ability Requirements** || Wisdom 9,Intelligence 14\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest, Rogue\n|-\n| **Bonus Proficiencies** || Disguise, forgery\n|-\n| **Recommended Proficiencies** || Spellcraft\n|}\n## Overview\nLeira was the goddess of deception and illusion, and the patron goddess of liars and illusionists. She was supposedly slain under mysterious circumstances during the Avatar crisis. However, this sect of priests, the mistwalkers, still gets divine power and claims that Leira is the source.\n\nCyric is currently the clandestine source of these priests' powers, or so it seems. Of course, when people deal with a goddess of deception and the Prince of Lies, no one can be quite sure what the real truth is.\n\n## Description\nThe mistwalkers are fond of wearing soft clothing that is either gray or flat black in hue. Each mistwalker also has a swirling cloak that is any color that was not chosen for her clothing. The cloak has a large hood, which the mistwalker often wears drawn over her head, obscuring her features. Mistwalkers always wear soft-soled shoes,\n\nwhich inspired their name. Armor heavier than leather is never worn, shields are not used, and the most favored weapons are short swords, daggers, and garrotes. No two-handed weapons are allowed for the mistwalkers.\n\n## Role-Playing\nIs Leira dead? The mistwalkers enjoy being coy about the answer. Obviously, they are receiving spells and power, but is it from the Lady of Mists or from Cyric? The mistwalkers enjoy playing mind-games with every one, and they never give a straight answer, no matter what the subject or the question.\n\nMistwalkers almost never raise their voices. They speak and move softly, like mist and shadows. Even when they tell the truth, they always seem to be holding back something.\n\nLies are the currency of mistwalkers, and they can spin a web of deception better than any other mortals who walk the surface Realms. In fact, they pride themselves on their convincing lies.\n\nMany mistwalkers learn the basics of acting and disguise as well as their usual clerical training. The better an actor a person is, the more convincing a liar he or she will be.\n\n## Special Abilities\nMistwalkers get a saving throw to resist the power of a ring of truth. Also, all mistwalkers have +2 bonuses on their saving throws to disbelieve an illusion.\n\nMistwalkers can cast phantasmal force once per day. At 3rd level, they can cast improved phantasmal force once per day. At 5th level, mistwalkers can cast spectral force once per day. At 9th level, a mistwalker's holy symbol of Leira acts as an amulet of proof against detection and location.\n\n## Special Disadvantages\nMistwalkers suffer a -1 penalty to saving throws and attack rolls in direct sunlight. They cannot turn undead. Due to their notorious reputation as liars, Mistwalkers also suffer a -4 penalty to reaction rolls with all NPCs.\n\nMistwalkers cannot wear any armor heavier than leather, and cannot use shields or two-handed weapons of any kind. Most weapons allowed are easily concealed, like daggers and short swords. The only missile weapons allowed are throwing daggers and blowguns.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any except dwarves\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9,{{br}}[[Intelligence]] 14\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest, Rogue\n|-\n| '''Bonus Proficiencies''' || [[Disguise (Proficiency)|Disguise]], forgery\n|-\n| '''Recommended Proficiencies''' || [[Spellcraft (Proficiency)|Spellcraft]]\n|}__TOC__\n==Overview==\nLeira was the goddess of deception and illusion, and the patron goddess of liars and illusionists. She was supposedly slain under mysterious circumstances during the Avatar crisis. However, this sect of priests, the mistwalkers, still gets divine power and claims that Leira is the source.\n\nCyric is currently the clandestine source of these priests' powers, or so it seems. Of course, when people deal with a goddess of deception and the Prince of Lies, no one can be quite sure what the real truth is.\n\n==Description==\nThe mistwalkers are fond of wearing soft clothing that is either gray or flat black in hue. Each mistwalker also has a swirling cloak that is any color that was not chosen for her clothing. The cloak has a large hood, which the mistwalker often wears drawn over her head, obscuring her features. Mistwalkers always wear soft-soled shoes,\n\nwhich inspired their name. Armor heavier than leather is never worn, shields are not used, and the most favored weapons are short swords, daggers, and garrotes. No two-handed weapons are allowed for the mistwalkers.\n\n==Role-Playing==\nIs Leira dead? The mistwalkers enjoy being coy about the answer. Obviously, they are receiving spells and power, but is it from the Lady of Mists or from Cyric? The mistwalkers enjoy playing mind-games with every one, and they never give a straight answer, no matter what the subject or the question.\n\nMistwalkers almost never raise their voices. They speak and move softly, like mist and shadows. Even when they tell the truth, they always seem to be holding back something.\n\nLies are the currency of mistwalkers, and they can spin a web of deception better than any other mortals who walk the surface Realms. In fact, they pride themselves on their convincing lies.\n\nMany mistwalkers learn the basics of acting and disguise as well as their usual clerical training. The better an actor a person is, the more convincing a liar he or she will be.\n\n==Special Abilities==\nMistwalkers get a saving throw to resist the power of a ring of truth. Also, all mistwalkers have +2 bonuses on their saving throws to disbelieve an illusion.\n\nMistwalkers can cast phantasmal force once per day. At 3rd level, they can cast improved phantasmal force once per day. At 5th level, mistwalkers can cast spectral force once per day. At 9th level, a mistwalker's holy symbol of Leira acts as an amulet of proof against detection and location.\n\n==Special Disadvantages==\nMistwalkers suffer a -1 penalty to saving throws and attack rolls in direct sunlight. They cannot turn undead. Due to their notorious reputation as liars, Mistwalkers also suffer a -4 penalty to reaction rolls with all NPCs.\n\nMistwalkers cannot wear any armor heavier than leather, and cannot use shields or two-handed weapons of any kind. Most weapons allowed are easily concealed, like daggers and short swords. The only missile weapons allowed are throwing daggers and blowguns.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 14, "Wisdom": 9],
                alignments: [],
                races: "Any except dwarves"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Disguise", "forgery"],
                recommended: ["Spellcraft"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: false,
                mode: "forbidden",
                notes: "They cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Leira",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Mistwalker"
    )

let embeddedKit032: Kit = Kit(
        id: "lliira_festbringer",
        name: "Lliira - Festbringer",
        wikiPageTitle: "Lliira - Festbringer (Character Kit)",
        redirectAliases: ["Lliira — Festbringer (Character Kit)", "Priests of Lliira (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "As the patron goddess of joy, happiness and dance, Lliira has created a line of priests called festbringers. These special priests organize parties, keep track of feast days and holidays, and are well-versed in party customs from all over the Realms.",
            requirements: "Charisma 13, Dexterity 12, Wisdom 9",
            specialBenefits: "Festbringers can make an ability check using their Intelligence in order to have knowledge of a particular city or nation's party customs. Festbringers also have an uncanny ability to know what the exact date is wherever they are. After all, they simply cannot allow a feast day to go by unnoticed and uncelebrated. Festbringers also have remarkable fortitude, able to stay up all hours of the night carousing without getting tired or woozy. All Constitution and Endurance checks are made with a +4 bonus. Festbringers often need to deal with party crashers or unruly partygoers. Three times a day, a festbringer can use a special form of the command spell. It can affect up to three targets, and subjects have a -2 penalty on their saving throws. The given command is usually \"Dance!\" Truly beligerent party crashers intent on disrupting the proceedings are often simply told to \"Leave!\"",
            specialHindrances: "Festbringers are noncombatants, period. They would rather be defended by strong companions, then throw their allies a victory party after it is all over. Festbringers cannot turn undead.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Dancing, endurance",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "As the patron goddess of joy, happiness and dance, Lliira has created a line of priests called festbringers. These special priests organize parties, keep track of feast days and holidays, and are well-versed in party customs from all over the Realms.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Charisma 13,Dexterity 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Dancing, endurance\n|-\n| **Recommended Proficiencies** || Etiquette, folklore, local history\n|}\n## Overview\nAs the patron goddess of joy, happiness and dance, Lliira has created a line of priests called festbringers. These special priests organize parties, keep track of feast days and holidays, and are well-versed in party customs from all over the Realms.\n\n## Description\nThe festbringers dress in stunning gowns if they are female, or rich tunics and pants if they are male. In either case, the clothing is always yellow and orange, Lliira's holy colors, and much of it is made from luxurious satins and diaphanous silks.\n\nArmor and weapons are rejected completely by the festbringers. The most offensive item found on their persons is either a belt, anklet, bracelet, or choker made of silver and adorned with little silver bells. The bells make a pleasant jingling sound when the festbringer walks or moves.\n\n## Role-Playing\nLife in the Realms can be filled with strife, struggle, and pain. The festbringers believe that everyone needs a party and a good laugh. They are not foolish optimists, laughing madly as a dragon attacks them. Rather, they seek joy in even the gloomiest (but not life-threatening) circumstances.\n\nFestbringers may seem overly obsessed with parties, dancing, and laughter, but this is simply because they believe there is way too much weeping and seriousness in life, and someone needs to compensate with joy. At least, that's what the festbringers profess.\n\nOne can always count on a festbringer to know the right joke for any occasion, the latest dances from Waterdeep, or the party customs for whatever city he is in. Although they are of little use in a slimy sewer, mountainous lair, or rotting graveyard, festbringers are avidly sought after in a palace ballroom or the tap room of an inn.\n\n## Special Abilities\nFestbringers can make an ability check using their Intelligence in order to have knowledge of a particular city or nation's party customs.\n\nFestbringers also have an uncanny ability to know what the exact date is wherever they are. After all, they simply cannot allow a feast day to go by unnoticed and uncelebrated.\n\nFestbringers also have remarkable fortitude, able to stay up all hours of the night carousing without getting tired or woozy. All Constitution and Endurance checks are made with a +4 bonus.\n\nFestbringers often need to deal with party crashers or unruly partygoers. Three times a day, a festbringer can use a special form of the command spell. It can affect up to three targets, and subjects have a -2 penalty on their saving throws. The given command is usually \"Dance!\" Truly beligerent party crashers intent on disrupting the proceedings are often simply told to \"Leave!\"\n\n## Special Disadvantages\nFestbringers are noncombatants, period. They would rather be defended by strong companions, then throw their allies a victory party after it is all over.\n\nFestbringers cannot turn undead.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Charisma]] 13,{{br}}[[Dexterity]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Dancing (Proficiency)|Dancing]], [[Endurance (Proficiency)|endurance]]\n|-\n| '''Recommended Proficiencies''' || [[Etiquette (Proficiency)|Etiquette]], [[Folklore (Proficiency)|folklore]], [[Local History (Proficiency)|local history]]\n|}__TOC__\n==Overview==\nAs the patron goddess of joy, happiness and dance, Lliira has created a line of priests called festbringers. These special priests organize parties, keep track of feast days and holidays, and are well-versed in party customs from all over the Realms.\n\n==Description==\nThe festbringers dress in stunning gowns if they are female, or rich tunics and pants if they are male. In either case, the clothing is always yellow and orange, Lliira's holy colors, and much of it is made from luxurious satins and diaphanous silks.\n\nArmor and weapons are rejected completely by the festbringers. The most offensive item found on their persons is either a belt, anklet, bracelet, or choker made of silver and adorned with little silver bells. The bells make a pleasant jingling sound when the festbringer walks or moves.\n\n==Role-Playing==\nLife in the Realms can be filled with strife, struggle, and pain. The festbringers believe that everyone needs a party and a good laugh. They are not foolish optimists, laughing madly as a dragon attacks them. Rather, they seek joy in even the gloomiest (but not life-threatening) circumstances.\n\nFestbringers may seem overly obsessed with parties, dancing, and laughter, but this is simply because they believe there is way too much weeping and seriousness in life, and someone needs to compensate with joy. At least, that's what the festbringers profess.\n\nOne can always count on a festbringer to know the right joke for any occasion, the latest dances from Waterdeep, or the party customs for whatever city he is in. Although they are of little use in a slimy sewer, mountainous lair, or rotting graveyard, festbringers are avidly sought after in a palace ballroom or the tap room of an inn.\n\n==Special Abilities==\nFestbringers can make an ability check using their Intelligence in order to have knowledge of a particular city or nation's party customs.\n\nFestbringers also have an uncanny ability to know what the exact date is wherever they are. After all, they simply cannot allow a feast day to go by unnoticed and uncelebrated.\n\nFestbringers also have remarkable fortitude, able to stay up all hours of the night carousing without getting tired or woozy. All Constitution and Endurance checks are made with a +4 bonus.\n\nFestbringers often need to deal with party crashers or unruly partygoers. Three times a day, a festbringer can use a special form of the command spell. It can affect up to three targets, and subjects have a -2 penalty on their saving throws. The given command is usually \"Dance!\" Truly beligerent party crashers intent on disrupting the proceedings are often simply told to \"Leave!\"\n\n==Special Disadvantages==\nFestbringers are noncombatants, period. They would rather be defended by strong companions, then throw their allies a victory party after it is all over.\n\nFestbringers cannot turn undead.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Dexterity": 12, "Wisdom": 9, "Charisma": 13],
                alignments: [],
                races: "Any"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Dancing", "endurance"],
                recommended: ["Etiquette", "folklore", "local history"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: false,
                mode: "forbidden",
                notes: "Festbringers cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Lliira",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Festbringer"
    )

let embeddedKit033: Kit = Kit(
        id: "lliira_profitprophet",
        name: "Lliira - Profitprophet",
        wikiPageTitle: "Lliira - Profitprophet (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Despite Waukeen's apparent demise, there exists a sect of her clergy in Sembia that simply refuses to believe that she is dead. The profitprophets continuously preach and portend the Merchant Goddess' return, all the while making lots of money in business ventures. Lliira now covertly gives these priests their spells and abilities. The profitprophets blindly point to the fact that they use Waukeen's name in their prayers and rituals and still gain spells as proof that she is still alive, or at the very least, not completely dead.",
            requirements: "Intelligence 12, Wisdom 9",
            specialBenefits: "Profitprophets can discern real precious metals and gems from clever fakes. This even includes false valuables created by magical means. The profitprophets can also estimate, give or take 5%, the cost of any goods or service they can see. Services applies to things like rooms for the night at a particular inn, a smithy's price for forging an item, or even a mercenary's pay rate for guarding a caravan. The clerics can turn undead.",
            specialHindrances: "The clergy of Lliira have taken over most of Waukeen's devoted, and the church of Waukeen officially, though unhappily, acknowledges this. As a result, there is friction between the profitprophets and the Lliiran church. Hostilities often break out between the two, even in public places. If a profitprophet ever experiences spell failure, he must make an ability check using Intelligence. If the check is failed, the cleric believes that Waukeen is truly dead and suffers the effects of a confusion spell. Each subsequent day, the cleric may make another ability check. Once the profitprophet passes the check, the madness lifts and all is well again.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Appraising",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Despite Waukeen's apparent demise, there exists a sect of her clergy in Sembia that simply refuses to believe that she is dead. The profitprophets continuously preach and portend the Merchant Goddess' return, all the while making lots of money in business ventures.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Intelligence 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Appraising\n|-\n| **Recommended Proficiencies** || Reading/writing\n|}\n## Overview\nDespite Waukeen's apparent demise, there exists a sect of her clergy in Sembia that simply refuses to believe that she is dead. The profitprophets continuously preach and portend the Merchant Goddess' return, all the while making lots of money in business ventures.\n\nLliira now covertly gives these priests their spells and abilities. The profitprophets blindly point to the fact that they use Waukeen's name in their prayers and rituals and still gain spells as proof that she is still alive, or at the very least, not completely dead.\n\n## Description\nThe profitprophets are stubbornly determined to keep the customs and vestments of the church of Waukeen alive. They strut around in tunics made of the most expensive materials, covered by heavy cloaks decorated with small in-laid bars of precious metals, gems, and ermine trim. The profitprophets look every bit an affluent and successful priesthood. The visible displays of wealth are meant to assure everyone that the goddess of wealth is still quite alive indeed. Many believe, however, that the profitprophets are the ones who need that reassurance more than most.\n\n## Role-Playing\nProfitprophets walk the fine line between public shows of opulence and private fits of desperate doubt. Publicly, they continue to bless new businesses, advise and make business deals, and amass wealth. Privately, they hope and pray that Waukeen is truly alive, or else they will eventually wind up looking awfully silly, not to mention flat broke.\n\nThese priests refuse to face the idea that Lliira now has Waukeen's portfolio. Interestingly enough, Lliira magnanimously lets them have their spells.\n\nStill, old habits die hard, and profitprophets cannot resist a good bargain, a hearty round of haggling, an exciting investment, or a jingling purse full of gold. After all, priests can raise mortals from the grave, so the prophets hope their continued worship may yet restore Waukeen to life as well!\n\n## Special Abilities\nProfitprophets can discern real precious metals and gems from clever fakes. This even includes false valuables created by magical means.\n\nThe profitprophets can also estimate, give or take 5%, the cost of any goods or service they can see. Services applies to things like rooms for the night at a particular inn, a smithy's price for forging an item, or even a mercenary's pay rate for guarding a caravan.\n\nThe clerics can turn undead.\n\n## Special Disadvantages\nThe clergy of Lliira have taken over most of Waukeen's devoted, and the church of Waukeen officially, though unhappily, acknowledges this. As a result, there is friction between the profitprophets and the Lliiran church. Hostilities often break out between the two, even in public places.\n\nIf a profitprophet ever experiences spell failure, he must make an ability check using Intelligence. If the check is failed, the cleric believes that Waukeen is truly dead and suffers the effects of a confusion spell. Each subsequent day, the cleric may make another ability check. Once the profitprophet passes the check, the madness lifts and all is well again.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Intelligence]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Appraising (Proficiency)|Appraising]]\n|-\n| '''Recommended Proficiencies''' || [[Reading/Writing (Proficiency)|Reading/writing]]\n|}__TOC__\n==Overview==\nDespite Waukeen's apparent demise, there exists a sect of her clergy in Sembia that simply refuses to believe that she is dead. The profitprophets continuously preach and portend the Merchant Goddess' return, all the while making lots of money in business ventures.\n\nLliira now covertly gives these priests their spells and abilities. The profitprophets blindly point to the fact that they use Waukeen's name in their prayers and rituals and still gain spells as proof that she is still alive, or at the very least, not completely dead.\n\n==Description==\nThe profitprophets are stubbornly determined to keep the customs and vestments of the church of Waukeen alive. They strut around in tunics made of the most expensive materials, covered by heavy cloaks decorated with small in-laid bars of precious metals, gems, and ermine trim. The profitprophets look every bit an affluent and successful priesthood. The visible displays of wealth are meant to assure everyone that the goddess of wealth is still quite alive indeed. Many believe, however, that the profitprophets are the ones who need that reassurance more than most.\n\n==Role-Playing==\nProfitprophets walk the fine line between public shows of opulence and private fits of desperate doubt. Publicly, they continue to bless new businesses, advise and make business deals, and amass wealth. Privately, they hope and pray that Waukeen is truly alive, or else they will eventually wind up looking awfully silly, not to mention flat broke.\n\nThese priests refuse to face the idea that Lliira now has Waukeen's portfolio. Interestingly enough, Lliira magnanimously lets them have their spells.\n\nStill, old habits die hard, and profitprophets cannot resist a good bargain, a hearty round of haggling, an exciting investment, or a jingling purse full of gold. After all, priests can raise mortals from the grave, so the prophets hope their continued worship may yet restore Waukeen to life as well!\n\n==Special Abilities==\nProfitprophets can discern real precious metals and gems from clever fakes. This even includes false valuables created by magical means.\n\nThe profitprophets can also estimate, give or take 5%, the cost of any goods or service they can see. Services applies to things like rooms for the night at a particular inn, a smithy's price for forging an item, or even a mercenary's pay rate for guarding a caravan.\n\nThe clerics can turn undead.\n\n==Special Disadvantages==\nThe clergy of Lliira have taken over most of Waukeen's devoted, and the church of Waukeen officially, though unhappily, acknowledges this. As a result, there is friction between the profitprophets and the Lliiran church. Hostilities often break out between the two, even in public places.\n\nIf a profitprophet ever experiences spell failure, he must make an ability check using Intelligence. If the check is failed, the cleric believes that Waukeen is truly dead and suffers the effects of a confusion spell. Each subsequent day, the cleric may make another ability check. Once the profitprophet passes the check, the madness lifts and all is well again.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 12, "Wisdom": 9],
                alignments: [],
                races: "Any"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Appraising"],
                recommended: ["Reading/writing"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Lliira",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Profitprophet"
    )

let embeddedKit034: Kit = Kit(
        id: "lost_druid",
        name: "Lost Druid",
        wikiPageTitle: "Lost Druid (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "Lost Druids always feel bitter. Sometimes they go insane, their hearts filled with an insatiable, often impossible, desire for vengeance against those who destroyed their land. For instance, say Struma became a Lost Druid when he found his forest destroyed by orcs. He may attempt to plot the downfall of the entire orcish race and the death of every last orc. Most Lost Druids live solitary existences, but sometimes they group together, often within the sinister Shadow Circle. (See Chapter 3: The Druidic Order.)",
            requirements: nil,
            specialBenefits: "The druid gains minor access to the Necromancy spell sphere. Upon reaching 6th level, he gains an additional power, the ability to animate dead animals. Treat this power as the priest spell animate dead; however, the druid may use it only once per day, and it affects 1 HD of normal (real-world) animals per level of the druid.",
            specialHindrances: "The Lost Druid cast only the reversed versions of heal or cure spells. As a Lost Druid, Struma may never attain Grand Druid status, and thus may not progress past it to hierophant rank. A character of Grand Druid or hierophant rank may not become a Lost Druid. All rangers and druids with other kits react to Lost Druids at a -4 penalty, usually with a mixture of pity and fear. (Other Lost Druids have only a -2 penalty to encounter reactions.) Most druids consider Lost Druids enemies and attempt to hunt, slay, or imprison them.",
            wealthOptions: "3d6x10 gp.",
            weaponProficiencies: "Recommended—scimitar, staff.",
            nonweaponProficiencies: "* Recommended—(priest) herbalism, spellcraft; (warrior) animal lore, endurance, set snares, survival.",
            equipment: "A Lost Druid such as Struma should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "The strangest members of the druidic order, Lost Druids find that many other druids no longer consider them kin. The Lost Druids come from lands that have been maliciously destroyed—forests burned to the ground, swamps drained, mountains ruined by mining, and so on.",
            fullText: "## Lost Druid\nThe strangest members of the druidic order, Lost Druids find that many other druids no longer consider them kin. The Lost Druids come from lands that have been maliciously destroyed—forests burned to the ground, swamps drained, mountains ruined by mining, and so on. Rather than try to rebuild or move on, a Lost Druid such as Struma (pictured next page) allows his heart to darken from brooding on the devastation and embraces strange magic to seek revenge.\n\nUnder extreme stress (and the DM's discretion), a druid may renounce a particular kit forever and become a Lost Druid. Druids of 2nd or higher level lose one level as a result of the change but suffer no other penalties. Note that this is an exception to the rule on abandoning kits (p.&nbsp;42), so the DM may wish to restrict it to NPCs.\n\n**Role:** Lost Druids always feel bitter. Sometimes they go insane, their hearts filled with an insatiable, often impossible, desire for vengeance against those who destroyed their land. For instance, say Struma became a Lost Druid when he found his forest destroyed by orcs. He may attempt to plot the downfall of the entire orcish race and the death of every last orc. Most Lost Druids live solitary existences, but sometimes they group together, often within the sinister Shadow  Circle. (See Chapter 3: The Druidic Order.)\n\n**Branch Restrictions:** None.\n\n**Weapon Proficiencies:** *Recommended*—scimitar, staff.\n\n**Secondary Skills:** Hunter, weaponsmith.\n\n**Nonweapon Proficiencies:**\n* *Recommended*—(priest) herbalism, spellcraft; (warrior) animal lore, endurance, set snares, survival.\n\n**Equipment:** A Lost Druid such as Struma should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp.\n\n**Special Benefits:** The druid gains minor access to the Necromancy spell sphere. Upon reaching 6th level, he gains an additional power, the ability to animate dead animals. Treat this power as the priest spell *animate dead*; however, the druid may use it only once per day, and it affects 1 HD of normal (real-world) animals per level of the druid.\n\n**Special Hindrances:** The Lost Druid cast only the *reversed* versions of *heal* or *cure* spells.\n\nAs a Lost Druid, Struma may never attain Grand Druid status, and thus may not progress past it to hierophant rank. A character of Grand Druid or hierophant rank may not become a Lost Druid.\n\nAll rangers and druids with other kits react to Lost Druids at a -4 penalty, usually with a mixture of pity and fear. (Other Lost Druids have only a -2 penalty to encounter reactions.) Most druids consider Lost Druids enemies and attempt to hunt, slay, or imprison them.\n\n**Wealth Options:** 3d6x10 gp.",
            rawWikitext: "{{Sidebar CDH Ch2}}__NOTOC__\n==Lost Druid==\nThe strangest members of the druidic order, Lost Druids find that many other druids no longer consider them kin. The Lost Druids come from lands that have been maliciously destroyed—forests burned to the ground, swamps drained, mountains ruined by mining, and so on. Rather than try to rebuild or move on, a Lost Druid such as Struma (pictured next page) allows his heart to darken from brooding on the devastation and embraces strange magic to seek revenge.\n\nUnder extreme stress (and the DM's discretion), a druid may renounce a particular kit forever and become a Lost Druid. Druids of 2nd or higher level lose one level as a result of the change but suffer no other penalties. Note that this is an exception to the rule on [[Abandoning Kits (CDH)|abandoning kits]] (p.&nbsp;42), so the DM may wish to restrict it to NPCs.\n\n'''Role:''' Lost Druids always feel bitter. Sometimes they go insane, their hearts filled with an insatiable, often impossible, desire for vengeance against those who destroyed their land. For instance, say Struma became a Lost Druid when he found his forest destroyed by orcs. He may attempt to plot the downfall of the entire orcish race and the death of every last orc. Most Lost Druids live solitary existences, but sometimes they group together, often within the sinister Shadow  Circle. (See Chapter 3: The Druidic Order.)\n\n'''Branch Restrictions:''' None.\n\n'''Weapon Proficiencies:''' ''Recommended''—scimitar, staff.\n\n'''Secondary Skills:''' Hunter, weaponsmith.\n\n'''Nonweapon Proficiencies:'''\n* ''Recommended''—(priest) [[Herbalism (Proficiency)|herbalism]], [[Spellcraft (Proficiency)|spellcraft]]; (warrior) [[Animal Lore (Proficiency)|animal lore]], [[Endurance (Proficiency)|endurance]], [[Set Snares (Proficiency)|set snares]], [[Survival (Proficiency)|survival]].\n\n'''Equipment:''' A Lost Druid such as Struma should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' The druid gains minor access to the Necromancy spell sphere. Upon reaching 6th level, he gains an additional power, the ability to animate dead animals. Treat this power as the priest spell ''animate dead''; however, the druid may use it only once per day, and it affects 1 HD of normal (real-world) animals per level of the druid.\n\n'''Special Hindrances:''' The Lost Druid cast only the ''reversed'' versions of ''heal'' or ''cure'' spells.\n\nAs a Lost Druid, Struma may never attain Grand Druid status, and thus may not progress past it to hierophant rank. A character of Grand Druid or hierophant rank may not become a Lost Druid.\n\nAll rangers and druids with other kits react to Lost Druids at a -4 penalty, usually with a mixture of pity and fear. (Other Lost Druids have only a -2 penalty to encounter reactions.) Most druids consider Lost Druids enemies and attempt to hunt, slay, or imprison them.\n\n'''Wealth Options:''' 3d6x10 gp.\n\n{{Navbox The Complete Druid's Handbook}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: [:],
                alignments: ["True Neutral"],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["scimitar", "staff"],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: [],
                recommended: ["herbalism", "spellcraft", "animal lore", "endurance", "set snares", "survival"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .specific(["wooden_shield"]),
                metalAllowed: false,
                maxArmorClass: "leather_or_padded",
                notes: "Druids are restricted to non-metallic armor (leather, padded, hide) and wooden shields only."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: false,
                mode: "forbidden",
                notes: "Druids cannot turn undead as a core class rule."
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit035: Kit = Kit(
        id: "loviatar_painteacher",
        name: "Loviatar - Painteacher",
        wikiPageTitle: "Loviatar - Painteacher (Character Kit)",
        redirectAliases: ["Priests of Loviatar (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Loviatar, the mistress of pain and agony, has taken special steps to ensure that her faith remains solid. The painteachers are the inquisitors of her faith who keep it pure. Naturally, the best way to purify something is to bum it.",
            requirements: "Wisdom 9",
            specialBenefits: "Painteachers get a +4 bonus to their Charisma score whenever they attempt to intimidate a victim. Conversely, attempts at intimidating a painteacher suffer a -4 penalty. When a painteacher is in battle and his hit point total falls between 1 and -5, the priest must make an proficiency check against Endurance. Succeeding the check means that the priest successfully endures the pain, stays conscious, and keeps fighting. A check must be made every round until the painteacher either fails the roll and falls, or the damage is healed. Painteachers are immune to the symbol of pain.",
            specialHindrances: "Painteachers cast healing spells at one level lower than their current level, and they are reduced 1 hit point on each die of healing. The healing is also excruciatingly painful for the victim. Painteachers do not use too many magical means to get to the truth during interrogations. Thus, divination spells are also cast at one level lower. Painteachers are unable to turn the undead.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Endurance, inquisitor",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Loviatar, the mistress of pain and agony, has taken special steps to ensure that her faith remains solid. The painteachers are the inquisitors of her faith who keep it pure. Naturally, the best way to purify something is to bum it.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Endurance, inquisitor\n|-\n| **Recommended Proficiencies** || Religion\n|}\n## Overview\nLoviatar, the mistress of pain and agony, has taken special steps to ensure that her faith remains solid. The painteachers are the inquisitors of her faith who keep it pure. Naturally, the best way to purify something is to bum it.\n\n## Description\nPainteachers wear the pleated scale mail of their mistress, and they cover it with a sheer, nearly transparent full-length cloak of black gauze. Many painteachers enjoy wearing a black silk hood in order to add to their wicked-looking morning star or a cat-o'nine-tails as their primary weapons.\n\n## Role-Playing\nIt is the painteacher's role to weed out the \"pathetic fools who snivel and grovel their way through life and clutter up the Realms.\" For such people, the painteacher intimidation abilities. Painteachers favor either a has nothing but contempt, and if he finds one, they are removed from this life.\n\nPainteachers understand that there is a fine balance between suffering unavoidable pain and enduring pain. The philosophies of \"that which does not kill me makes me stronger\" and \"pain is the great communicator, for everyone understands it\" fit nicely into the doctrines of Loviatar as enforced by the painteachers. Painteachers tend to lace their conversation with references to anguish and suffering, including the quotes in the above paragraph.\n\nThe painteacher's unflinching acceptance of pain and lack of fear about it is eerie to nearly everyone else. These priests simply cannot be bullied, although they themselves make excellent bullies.\n\nContempt and is openly expressed for the weak and those fearful of any pain. Disgust to the point of violence is saved for those who either shudder at or savor pain without fighting back. Returning pain for pain is a core precept of Loviatar's faith, and Loviatar's faithful only respect those who don't give in to the torment and they judge people as worthy if they give as good as they get, trading wound for wound. In fact, anyone who stolidly endures pain without losing his dignity is openly admired, whether he is a paladin of Tyr or a priest of Cyric.\n\n## Special Abilities\nPainteachers get a +4 bonus to their Charisma score whenever they attempt to intimidate a victim. Conversely, attempts at intimidating a painteacher suffer a -4 penalty.\n\nWhen a painteacher is in battle and his hit point total falls between 1 and -5, the priest must make an proficiency check against Endurance. Succeeding the check means that the priest successfully endures the pain, stays conscious, and keeps fighting. A check must be made every round until the painteacher either fails the roll and falls, or the damage is healed.\n\nPainteachers are immune to the symbol of pain.\n\n## Special Disadvantages\nPainteachers cast healing spells at one level lower than their current level, and they are reduced 1 hit point on each die of healing. The healing is also excruciatingly painful for the victim.\n\nPainteachers do not use too many magical means to get to the truth during interrogations. Thus, divination spells are also cast at one level lower.\n\nPainteachers are unable to turn the undead.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Endurance (Proficiency)|Endurance]], [[Inquisitor (Character Kit)|inquisitor]]\n|-\n| '''Recommended Proficiencies''' || [[Religion (Proficiency)|Religion]]\n|}__TOC__\n==Overview==\nLoviatar, the mistress of pain and agony, has taken special steps to ensure that her faith remains solid. The painteachers are the inquisitors of her faith who keep it pure. Naturally, the best way to purify something is to bum it.\n\n==Description==\nPainteachers wear the pleated scale mail of their mistress, and they cover it with a sheer, nearly transparent full-length cloak of black gauze. Many painteachers enjoy wearing a black silk hood in order to add to their wicked-looking morning star or a cat-o'nine-tails as their primary weapons.\n\n==Role-Playing==\nIt is the painteacher's role to weed out the \"pathetic fools who snivel and grovel their way through life and clutter up the Realms.\" For such people, the painteacher intimidation abilities. Painteachers favor either a has nothing but contempt, and if he finds one, they are removed from this life.\n\nPainteachers understand that there is a fine balance between suffering unavoidable pain and enduring pain. The philosophies of \"that which does not kill me makes me stronger\" and \"pain is the great communicator, for everyone understands it\" fit nicely into the doctrines of Loviatar as enforced by the painteachers. Painteachers tend to lace their conversation with references to anguish and suffering, including the quotes in the above paragraph.\n\nThe painteacher's unflinching acceptance of pain and lack of fear about it is eerie to nearly everyone else. These priests simply cannot be bullied, although they themselves make excellent bullies.\n\nContempt and is openly expressed for the weak and those fearful of any pain. Disgust to the point of violence is saved for those who either shudder at or savor pain without fighting back. Returning pain for pain is a core precept of Loviatar's faith, and Loviatar's faithful only respect those who don't give in to the torment and they judge people as worthy if they give as good as they get, trading wound for wound. In fact, anyone who stolidly endures pain without losing his dignity is openly admired, whether he is a paladin of Tyr or a priest of Cyric.\n\n==Special Abilities==\nPainteachers get a +4 bonus to their [[Charisma]] score whenever they attempt to intimidate a victim. Conversely, attempts at intimidating a painteacher suffer a -4 penalty.\n\nWhen a painteacher is in battle and his hit point total falls between 1 and -5, the priest must make an proficiency check against [[Endurance (Proficiency)|Endurance]]. Succeeding the check means that the priest successfully endures the pain, stays conscious, and keeps fighting. A check must be made every round until the painteacher either fails the roll and falls, or the damage is healed.\n\nPainteachers are immune to the symbol of pain.\n\n==Special Disadvantages==\nPainteachers cast healing spells at one level lower than their current level, and they are reduced 1 hit point on each die of healing. The healing is also excruciatingly painful for the victim.\n\nPainteachers do not use too many magical means to get to the truth during interrogations. Thus, divination spells are also cast at one level lower.\n\nPainteachers are unable to turn the undead.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9],
                alignments: [],
                races: "Any"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Endurance", "inquisitor"],
                recommended: ["Religion"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Loviatar",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Painteacher"
    )

let embeddedKit036: Kit = Kit(
        id: "malar_beastheart",
        name: "Malar - Beastheart",
        wikiPageTitle: "Malar - Beastheart (Character Kit)",
        redirectAliases: ["Priests of Malar (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Malar the Beastlord is the chaotic evil god of marauding beasts, savagery, bloodlust, and the hunt. Beasthearts seek to emulate their god, immersing themselves in the blood and frenzy of the hunt and very often losing their humanity in the process.",
            requirements: "Strength 12, Wisdom 9",
            specialBenefits: "When a beastheart begins his First Hunt (first level), he must select a species (not a monster) to empathize. This empathy to a beast's species is known as the blood bond. The list of beasts for the blood bond includes, but is not limited to, the following: bear, wolf, fox, great cat, wild dog, or wolverine. Almost any mammalian predator will do. From this point on, the beastheart will never raise a hand or weapon to any animal of his blood bond, nor will those animals attack him. This does not mean the animal is like a friend or familiar—both animal and beastheart respect the other, as if they were members of the same pack. When a beastheart reaches 7th level, he can talk to any representative of his blood-bonded species once a day. He can use this ability for one round per level of the priest. When in battle, a beastheart can go into a special berserker rage. The beastheart attacks twice per round with a +2 bonus to attack and damage rolls. The berserk priest can fight into negative hit points, one point per level, to a maximum of -9 hit points. Thus, a 3rd-level beastheart can fight until he reaches -3 hit points and then he falls unconscious. The rage lasts for one round per level.",
            specialHindrances: "Cities and towns make beasthearts feel uncomfortable. Beasthearts suffer a -2 penalty to attack and damage rolls in these settings. They cannot go into a berserk rage within an urban setting either. Beasthearts risk a regression into savagery. Each time a beastheart goes berserk, there is a 20% chance that he will think he is actually an animal. This savage effect lasts for 2d4+2 hours. During this time, the priest loses all additional abilities and powers and is compelled to savagely attack opponents with his bare hands and teeth. Beasthearts cannot turn undead.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Animal lore, hunting, tracking",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Malar the Beastlord is the chaotic evil god of marauding beasts, savagery, bloodlust, and the hunt. Beasthearts seek to emulate their god, immersing themselves in the blood and frenzy of the hunt and very often losing their humanity in the process.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Half-elf, human\n|-\n| **Ability Requirements** || Strength 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Animal lore, hunting, tracking\n|-\n| **Recommended Proficiencies** || Animal handling\n|}\n## Overview\nMalar the Beastlord is the chaotic evil god of marauding beasts, savagery, bloodlust, and the hunt. Beasthearts seek to emulate their god, immersing themselves in the blood and frenzy of the hunt and very often losing their humanity in the process.\n\n## Description\nBeasthearts wear rough-spun clothing or animal skins and a headpiece of a bear, wolf, or great cat that the beastheart killed with his bare hands. They all wear flat stone disks on leather thongs around their necks with Malar's holy symbol scratched into the disks.\n\nMost beasthearts use spears, battleaxes, or two-handed swords. They favor hide or leather armor. Beasthearts carry a scent that seems to be a mixture of human sweat, animal musk, and spilled blood.\n\n## Role-Playing\nBeasthearts seek to release the animals within themselves and submerge their human natures. They love living out in the wilderness, running through forests and grasslands, howling at the moon, and killing prey with their bare hands.\n\nMost beasthearts waver between savagery and the challenge of a difficult hunt. In the latter case, they are more lucid and reasonable, as appreciation for a fine chase and the strategies of the hunt are more human qualities than animal attributes.\n\n## Special Abilities\nWhen a beastheart begins his First Hunt (first level), he must select a species (not a monster) to empathize. This empathy to a beast's species is known as the blood bond. The list of beasts for the blood bond includes, but is not limited to, the following: bear, wolf, fox, great cat, wild dog, or wolverine. Almost any mammalian predator will do. From this point on, the beastheart will never raise a hand or weapon to any animal of his blood bond, nor will those animals attack him. This does not mean the animal is like a friend or familiar—both animal and beastheart respect the other, as if they were members of the same pack.\n\nWhen a beastheart reaches 7th level, he can talk to any representative of his blood-bonded species once a day. He can use this ability for one round per level of the priest.\n\nWhen in battle, a beastheart can go into a special berserker rage. The beastheart attacks twice per round with a +2 bonus to attack and damage rolls. The berserk priest can fight into negative hit points, one point per level, to a maximum of -9 hit points. Thus, a 3rd-level beastheart can fight until he reaches -3 hit points and then he falls unconscious. The rage lasts for one round per level.\n\n## Special Disadvantages\nCities and towns make beasthearts feel uncomfortable. Beasthearts suffer a -2 penalty to attack and damage rolls in these settings. They cannot go into a berserk rage within an urban setting either.\n\nBeasthearts risk a regression into savagery. Each time a beastheart goes berserk, there is a 20% chance that he will think he is actually an animal. This savage effect lasts for 2d4+2 hours. During this time, the priest loses all additional abilities and powers and is compelled to savagely attack opponents with his bare hands and teeth.\n\nBeasthearts cannot turn undead.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Half-elf, human\n|-\n| '''Ability Requirements''' || [[Strength]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Animal Lore (Proficiency)|Animal lore]], [[Hunting (Proficiency)|hunting]], [[Tracking (Proficiency)|tracking]]\n|-\n| '''Recommended Proficiencies''' || [[Animal Handling (Proficiency)|Animal handling]]\n|}__TOC__\n==Overview==\nMalar the Beastlord is the chaotic evil god of marauding beasts, savagery, bloodlust, and the hunt. Beasthearts seek to emulate their god, immersing themselves in the blood and frenzy of the hunt and very often losing their humanity in the process.\n\n==Description==\nBeasthearts wear rough-spun clothing or animal skins and a headpiece of a bear, wolf, or great cat that the beastheart killed with his bare hands. They all wear flat stone disks on leather thongs around their necks with Malar's holy symbol scratched into the disks.\n\nMost beasthearts use spears, battleaxes, or two-handed swords. They favor hide or leather armor. Beasthearts carry a scent that seems to be a mixture of human sweat, animal musk, and spilled blood.\n\n==Role-Playing==\nBeasthearts seek to release the animals within themselves and submerge their human natures. They love living out in the wilderness, running through forests and grasslands, howling at the moon, and killing prey with their bare hands.\n\nMost beasthearts waver between savagery and the challenge of a difficult hunt. In the latter case, they are more lucid and reasonable, as appreciation for a fine chase and the strategies of the hunt are more human qualities than animal attributes.\n\n==Special Abilities==\nWhen a beastheart begins his First Hunt (first level), he must select a species (not a monster) to empathize. This empathy to a beast's species is known as the blood bond. The list of beasts for the blood bond includes, but is not limited to, the following: bear, wolf, fox, great cat, wild dog, or wolverine. Almost any mammalian predator will do. From this point on, the beastheart will never raise a hand or weapon to any animal of his blood bond, nor will those animals attack him. This does not mean the animal is like a friend or familiar—both animal and beastheart respect the other, as if they were members of the same pack.\n\nWhen a beastheart reaches 7th level, he can talk to any representative of his blood-bonded species once a day. He can use this ability for one round per level of the priest.\n\nWhen in battle, a beastheart can go into a special berserker rage. The beastheart attacks twice per round with a +2 bonus to attack and damage rolls. The berserk priest can fight into negative hit points, one point per level, to a maximum of -9 hit points. Thus, a 3rd-level beastheart can fight until he reaches -3 hit points and then he falls unconscious. The rage lasts for one round per level.\n\n==Special Disadvantages==\nCities and towns make beasthearts feel uncomfortable. Beasthearts suffer a -2 penalty to attack and damage rolls in these settings. They cannot go into a berserk rage within an urban setting either.\n\nBeasthearts risk a regression into savagery. Each time a beastheart goes berserk, there is a 20% chance that he will think he is actually an animal. This savage effect lasts for 2d4+2 hours. During this time, the priest loses all additional abilities and powers and is compelled to savagely attack opponents with his bare hands and teeth.\n\nBeasthearts cannot turn undead.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Strength": 12, "Wisdom": 9],
                alignments: [],
                races: "Half-elf, human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Animal lore", "hunting", "tracking"],
                recommended: ["Animal handling"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: false,
                mode: "forbidden",
                notes: "Beasthearts cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Malar",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Beastheart"
    )

let embeddedKit037: Kit = Kit(
        id: "mask_catfoot",
        name: "Mask - Catfoot",
        wikiPageTitle: "Mask - Catfoot (Character Kit)",
        redirectAliases: ["Priests of Mask (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "With certain setbacks during the Cyrinishad incident, Mask has been reduced to the status of a demipower. The more forward-thinking of his clergy's leaders correctly understand the need to bolster worship in their god and see the need to get the church better organized. This has resulted in the creation of two special branches of priests, the catfoot and the nightrunner. The catfoot is a priest of Mask whose specific locale of choice is an urban environment. He stands ready to counsel, defend, heal, and get money out of any thief who worships Mask. There is no plural form of catfoot; for some reason the priests dislike the sound of \"catfeet.\"",
            requirements: "Dexterity 16, Wisdom 9",
            specialBenefits: "A catfoot is intimately familiar with one city. At the beginning of his career, a home city must be chosen. The catfoot can make an ability check against Wisdom to know some uncommon knowledge about the city, like special short cuts, reliable fences, safe houses, corruptible city guards, and so forth. A catfoot has all the abilities of a thief of his level, but he begins with only the base thief ability scores; he has no initial discretionary points to allocate. For each level he attains, the catfoot receives 10 points.",
            specialHindrances: "Since the faith is in the midst of rebuilding, 50% of a catfoot's take must go to the church coffers. A catfoot must be either lawful, chaotic, or absolute neutral. A catfoot cannot turn undead. They are limited to wearing leather armor for defense, and cannot use shields.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Appraising, disguise",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "With certain setbacks during the Cyrinishad incident, Mask has been reduced to the status of a demipower. The more forward-thinking of his clergy's leaders correctly understand the need to bolster worship in their god and see the need to get the church better organized.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Dexterity 16,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest, Rogue\n|-\n| **Bonus Proficiencies** || Appraising, disguise\n|-\n| **Recommended Proficiencies** || Gaming, tumbling\n|}\n## Overview\nWith certain setbacks during the Cyrinishad incident, Mask has been reduced to the status of a demipower. The more forward-thinking of his clergy's leaders correctly understand the need to bolster worship in their god and see the need to get the church better organized. This has resulted in the creation of two special branches of priests, the catfoot and the nightrunner.\n\nThe catfoot is a priest of Mask whose specific locale of choice is an urban environment. He stands ready to counsel, defend, heal, and get money out of any thief who worships Mask.\n\nThere is no plural form of catfoot; for some reason the priests dislike the sound of \"catfeet.\"\n\n## Description\nThe catfoot dresses solely in blacks and grays. The only armor a catfoot wears is leather armor, and that must be dyed either black or gray as well. The catfoot always wears a black or midnight-blue cloak with a hood. All priests also wear black masks—either domino masks\n\nacross their eyes or full masks covering their entire faces—to preserve their anonymity.\n\nA catfoot can use any weapon a thief can use.\n\n## Role-Playing\nA catfoot acts like a mixture of a streetwise local, an opportunistic thief, a smooth-talking conman, and a crooked priest. Even though every catfoot's mission is to minister to Mask's faithful and bring in more worshipers (and their loot), each priest also has a healthy dose of self-interest. In fact, Mask encourages his priests to beg, borrow, and steal as much for themselves as they can, provided he gets his share.\n\nA catfoot excels at quoting what little written doctrine of Mask that exists, then turning around and deviating from it for his own personal gain. However, when a worshiper of Mask is in a jam, a catfoot will do his best to help the thief out of his predicament, as long as he doesn't have to unduly risk his own neck.\n\n## Special Abilities\nA catfoot is intimately familiar with one city. At the beginning of his career, a home city must be chosen. The catfoot can make an ability check against Wisdom to know some uncommon knowledge about the city, like special short cuts, reliable fences, safe houses, corruptible city guards, and so forth.\n\nA catfoot has all the abilities of a thief of his level, but he begins with only the base thief ability scores; he has no initial discretionary points to allocate. For each level he attains, the catfoot receives 10 points.\n\n## Special Disadvantages\nSince the faith is in the midst of rebuilding, 50% of a catfoot's take must go to the church coffers.\n\nA catfoot must be either lawful, chaotic, or absolute neutral. A catfoot cannot turn undead. They are limited to wearing leather armor for defense, and cannot use shields.",
            rawWikitext: "{{For|other Mask pages|Mask}}\n{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Dexterity]] 16,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest, Rogue\n|-\n| '''Bonus Proficiencies''' || [[Appraising (Proficiency)|Appraising]], [[Disguise (Proficiency)|disguise]]\n|-\n| '''Recommended Proficiencies''' || [[Gaming (Proficiency)|Gaming]], [[Tumbling (Proficiency)|tumbling]]\n|}__TOC__\n==Overview==\nWith certain setbacks during the Cyrinishad incident, Mask has been reduced to the status of a demipower. The more forward-thinking of his clergy's leaders correctly understand the need to bolster worship in their god and see the need to get the church better organized. This has resulted in the creation of two special branches of priests, the catfoot and the nightrunner.\n\nThe catfoot is a priest of Mask whose specific locale of choice is an urban environment. He stands ready to counsel, defend, heal, and get money out of any thief who worships Mask.\n\nThere is no plural form of catfoot; for some reason the priests dislike the sound of \"catfeet.\"\n\n==Description==\nThe catfoot dresses solely in blacks and grays. The only armor a catfoot wears is leather armor, and that must be dyed either black or gray as well. The catfoot always wears a black or midnight-blue cloak with a hood. All priests also wear black masks—either domino masks\n\nacross their eyes or full masks covering their entire faces—to preserve their anonymity.\n\nA catfoot can use any weapon a thief can use.\n\n==Role-Playing==\nA catfoot acts like a mixture of a streetwise local, an opportunistic thief, a smooth-talking conman, and a crooked priest. Even though every catfoot's mission is to minister to Mask's faithful and bring in more worshipers (and their loot), each priest also has a healthy dose of self-interest. In fact, Mask encourages his priests to beg, borrow, and steal as much for themselves as they can, provided he gets his share.\n\nA catfoot excels at quoting what little written doctrine of Mask that exists, then turning around and deviating from it for his own personal gain. However, when a worshiper of Mask is in a jam, a catfoot will do his best to help the thief out of his predicament, as long as he doesn't have to unduly risk his own neck.\n\n==Special Abilities==\nA catfoot is intimately familiar with one city. At the beginning of his career, a home city must be chosen. The catfoot can make an ability check against Wisdom to know some uncommon knowledge about the city, like special short cuts, reliable fences, safe houses, corruptible city guards, and so forth.\n\nA catfoot has all the abilities of a thief of his level, but he begins with only the base thief ability scores; he has no initial discretionary points to allocate. For each level he attains, the catfoot receives 10 points.\n\n==Special Disadvantages==\nSince the faith is in the midst of rebuilding, 50% of a catfoot's take must go to the church coffers.\n\nA catfoot must be either lawful, chaotic, or absolute neutral. A catfoot cannot turn undead. They are limited to wearing leather armor for defense, and cannot use shields.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Dexterity": 16, "Wisdom": 9],
                alignments: [],
                races: "Any"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Appraising", "disguise"],
                recommended: ["Gaming", "tumbling"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: false,
                mode: "forbidden",
                notes: "A catfoot cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Mask",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Catfoot"
    )

let embeddedKit038: Kit = Kit(
        id: "mask_nightrunner",
        name: "Mask - Nightrunner",
        wikiPageTitle: "Mask - Nightrunner (Character Kit)",
        redirectAliases: ["Nightrunner (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The nightrunner is the wilderness counterpart of the catfoot, and is often found in adventuring parties. These priests try to demonstrate how Mask's good graces are important, even in non-urban settings.",
            requirements: "Dexterity 15, Wisdom 9",
            specialBenefits: "All nightrunners have limited thieves' abilities. They are surprised only on a 1 or 2 on a d10. Nightrunners can backstab like a thief of the same level, and they have three thieving abilities: move silently, hide in shadow, and climb walls.",
            specialHindrances: "Nightrunners are limited to the thieving abilities listed above, and they start out with only the base scores. For subsequent levels, nightrunners get 7 points to boost these abilities as they see fit. Nightrunners can only turn undead of 5 hit dice or less, though they affect those undead as normal priests of their current levels.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Set snares, tumbling",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "The nightrunner is the wilderness counterpart of the catfoot, and is often found in adventuring parties. These priests try to demonstrate how Mask's good graces are important, even in non-urban settings.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Half-elf, human\n|-\n| **Ability Requirements** || Dexterity 15,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest, Rogue\n|-\n| **Bonus Proficiencies** || Set snares, tumbling\n|-\n| **Recommended Proficiencies** || Appraising, direction sense\n|}\n## Overview\nThe **nightrunner** is the wilderness counterpart of the catfoot, and is often found in adventuring parties. These priests try to demonstrate how Mask's good graces are important, even in non-urban settings.\n\n## Description\nNightrunners dress like common adventurers. Nightrunners wear leather armor, and use any of the weapons that thieves are allowed to use. However, they have small medallions stamped on the hilts of their sacred daggers, which show Mask's symbol. These daggers are the nightrunners' holy symbols.\n\n## Role-Playing\nNightrunners are at home in non-urban settings, be it the wilderness or a dungeon. They make no secret of the fact that they are priests of Mask, and they do their best to extol his virtues of stealth, cunning, and a lust for gold to all who will listen.\n\nNightrunners very often come across as a sort of poorman's priest of Tymora, since they are just as cocky, overconfident, and opportunistic. Still, as devotees of the god of thieves, they choose to make their own luck, rather than rely on Tymora.\n\n## Special Abilities\nAll nightrunners have limited thieves' abilities. They are surprised only on a 1 or 2 on a d10. Nightrunners can backstab like a thief of the same level, and they have three thieving abilities: move silently, hide in shadow, and climb walls.\n\n## Special Disadvantages\nNightrunners are limited to the thieving abilities listed above, and they start out with only the base scores. For subsequent levels, nightrunners get 7 points to boost these abilities as they see fit.\n\nNightrunners can only turn undead of 5 hit dice or less, though they affect those undead as normal priests of their current levels.",
            rawWikitext: "{{For|other Mask pages|Mask}}\n{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Half-elf, human\n|-\n| '''Ability Requirements''' || [[Dexterity]] 15,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest, Rogue\n|-\n| '''Bonus Proficiencies''' || [[Set Snares (Proficiency)|Set snares]], [[Tumbling (Proficiency)|tumbling]]\n|-\n| '''Recommended Proficiencies''' || [[Appraising (Proficiency)|Appraising]], [[Direction Sense (Proficiency)|direction sense]]\n|}__TOC__\n==Overview==\nThe '''nightrunner''' is the wilderness counterpart of the catfoot, and is often found in adventuring parties. These priests try to demonstrate how Mask's good graces are important, even in non-urban settings.\n\n==Description==\nNightrunners dress like common adventurers. Nightrunners wear leather armor, and use any of the weapons that thieves are allowed to use. However, they have small medallions stamped on the hilts of their sacred daggers, which show Mask's symbol. These daggers are the nightrunners' holy symbols.\n\n==Role-Playing==\nNightrunners are at home in non-urban settings, be it the wilderness or a dungeon. They make no secret of the fact that they are priests of Mask, and they do their best to extol his virtues of stealth, cunning, and a lust for gold to all who will listen.\n\nNightrunners very often come across as a sort of poorman's priest of Tymora, since they are just as cocky, overconfident, and opportunistic. Still, as devotees of the god of thieves, they choose to make their own luck, rather than rely on Tymora.\n\n==Special Abilities==\nAll nightrunners have limited thieves' abilities. They are surprised only on a 1 or 2 on a d10. Nightrunners can backstab like a thief of the same level, and they have three thieving abilities: move silently, hide in shadow, and climb walls.\n\n==Special Disadvantages==\nNightrunners are limited to the thieving abilities listed above, and they start out with only the base scores. For subsequent levels, nightrunners get 7 points to boost these abilities as they see fit.\n\nNightrunners can only turn undead of 5 hit dice or less, though they affect those undead as normal priests of their current levels.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Dexterity": 15, "Wisdom": 9],
                alignments: [],
                races: "Half-elf, human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Set snares", "tumbling"],
                recommended: ["Appraising", "direction sense"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Mask",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Nightrunner"
    )

let embeddedKit039: Kit = Kit(
        id: "mielikki_treespeaker",
        name: "Mielikki - Treespeaker",
        wikiPageTitle: "Mielikki - Treespeaker (Character Kit)",
        redirectAliases: ["Priests of Mielikki (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Mielikki, Lady of the Forest, has many diverse followers. Among the more interesting orders of her faith are the treespeakers of Mielikki. They are exclusively elven maidens of grace and purity who ride unicorns and commune with nature as easily as others communicate with each other. The treespeakers actively protect nature by any means necessary, although they prefer to remain quietly hidden in the background.",
            requirements: "Charisma 12, Wisdom 12",
            specialBenefits: "All treespeakers function as normal priests. However, they are allowed to use long bows and short swords, as well as chain armor. Beginning treespeakers get a free short sword, long bow, and a suit of mundane chain mail armor. They also get the ability to speak with plants at will at 3rd level. At 5th level, a treespeaker earns her cloak of elvenkind, and at 7th level she receive her own suit of elven chain mail. All of a treespeaker's special possessions are provided by the church hierarchy, which keeps very close watch on the elven maidens. At 9th level, each treespeaker undertakes a vigil in a grove dedicated to Mielikki. During that vigil, she will meet a unicorn. This beautiful animal is not a servant to be commanded, but rather an ally, friend, and equal companion, as well as a willing mount. Given this rapport between rider and mount, there have been instances where unicorns have charged into certain death to save a beloved treespeaker.",
            specialHindrances: "Only elven females can be treespeakers. At the start of their careers, the females pledge their purity for two decades. At the end of that time, they may renew the pledge and continue as treespeakers, or they may bow out and become a regular priest of Mielikki. Any treespeaker who breaks the vow of purity forever loses all her spells and abilities immediately. Naturally, the unicorn instantly deserts her as well. Treespeakers cannot turn undead, and have no access to the Guardian and Necromantic spheres of priests' spells. : ''\"Beg pardon, but I have to interject. Treespeakers are by far the loveliest women I've ever seen. And they are all unapproachable. Lady Mielikki, you are cruel indeed!\" :: -Mendryll 'Wench-chaser' Belarod.''",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Animal lore, herbalism",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Mielikki, Lady of the Forest, has many diverse followers. Among the more interesting orders of her faith are the treespeakers of Mielikki. They are exclusively elven maidens of grace and purity who ride unicorns and commune with nature as easily as others communicate with each other.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Elf\n|-\n| **Ability Requirements** || Charisma 12,Wisdom 12\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Animal lore, herbalism\n|-\n| **Recommended Proficiencies** || Tracking\n|}\n## Overview\nMielikki, Lady of the Forest, has many diverse followers. Among the more interesting orders of her faith are the treespeakers of Mielikki. They are exclusively elven maidens of grace and purity who ride unicorns and commune with nature as easily as others communicate with each other. The treespeakers actively protect nature by any means necessary, although they prefer to remain quietly hidden in the background.\n\n## Description\nTreespeakers are elven females who wear suits of elven chainmail and cloaks of elvenkind. They can be either moon elves or gold elves. The elf maidens carry themselves with an elegant presence, their every movement as smooth and effortless as a waterfall.\n\nTreespeakers favor the long bow and the short sword as their primary weapons.\n\n## Role-Playing\nTreespeakers are lovers of nature, and will jealously protect it. Although they are serious in their duties, treespeakers also enjoy laughter and fun. However, despite their beauty and charm, these women avoid any and all romantic entanglements. They will not even flirt in jest with anyone, and they will defend themselves quite harshly against any advances.\n\n## Special Abilities\nAll treespeakers function as normal priests. However, they are allowed to use long bows and short swords, as well as chain armor.\n\nBeginning treespeakers get a free short sword, long bow, and a suit of mundane chain mail armor. They also get the ability to speak with plants at will at 3rd level. At 5th level, a treespeaker earns her cloak of elvenkind, and at 7th level she receive her own suit of elven chain mail. All of a treespeaker's special possessions are provided by the church hierarchy, which keeps very close watch on the elven maidens.\n\nAt 9th level, each treespeaker undertakes a vigil in a grove dedicated to Mielikki. During that vigil, she will meet a unicorn. This beautiful animal is not a servant to be commanded, but rather an ally, friend, and equal companion, as well as a willing mount. Given this rapport between rider and mount, there have been instances where unicorns have charged into certain death to save a beloved treespeaker.\n\n## Special Disadvantages\nOnly elven females can be treespeakers. At the start of their careers, the females pledge their purity for two decades. At the end of that time, they may renew the pledge and continue as treespeakers, or they may bow out and become a regular priest of Mielikki.\n\nAny treespeaker who breaks the vow of purity forever loses all her spells and abilities immediately. Naturally, the unicorn instantly deserts her as well.\n\nTreespeakers cannot turn undead, and have no access to the Guardian and Necromantic spheres of priests' spells.\n\n: *\"Beg pardon, but I have to interject. Treespeakers are by far the loveliest women I've ever seen. And they are all unapproachable. Lady Mielikki, you are cruel indeed!\"*\n\n:: *-Mendryll 'Wench-chaser' Belarod.*",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Elf\n|-\n| '''Ability Requirements''' || [[Charisma]] 12,{{br}}[[Wisdom]] 12\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Animal Lore (Proficiency)|Animal lore]], [[Herbalism (Proficiency)|herbalism]]\n|-\n| '''Recommended Proficiencies''' || [[Tracking (Proficiency)|Tracking]]\n|}__TOC__\n==Overview==\nMielikki, Lady of the Forest, has many diverse followers. Among the more interesting orders of her faith are the treespeakers of Mielikki. They are exclusively elven maidens of grace and purity who ride unicorns and commune with nature as easily as others communicate with each other. The treespeakers actively protect nature by any means necessary, although they prefer to remain quietly hidden in the background.\n\n==Description==\nTreespeakers are elven females who wear suits of elven chainmail and cloaks of elvenkind. They can be either moon elves or gold elves. The elf maidens carry themselves with an elegant presence, their every movement as smooth and effortless as a waterfall.\n\nTreespeakers favor the long bow and the short sword as their primary weapons.\n\n==Role-Playing==\nTreespeakers are lovers of nature, and will jealously protect it. Although they are serious in their duties, treespeakers also enjoy laughter and fun. However, despite their beauty and charm, these women avoid any and all romantic entanglements. They will not even flirt in jest with anyone, and they will defend themselves quite harshly against any advances.\n\n==Special Abilities==\nAll treespeakers function as normal priests. However, they are allowed to use long bows and short swords, as well as chain armor.\n\nBeginning treespeakers get a free short sword, long bow, and a suit of mundane chain mail armor. They also get the ability to speak with plants at will at 3rd level. At 5th level, a treespeaker earns her cloak of elvenkind, and at 7th level she receive her own suit of elven chain mail. All of a treespeaker's special possessions are provided by the church hierarchy, which keeps very close watch on the elven maidens.\n\nAt 9th level, each treespeaker undertakes a vigil in a grove dedicated to Mielikki. During that vigil, she will meet a unicorn. This beautiful animal is not a servant to be commanded, but rather an ally, friend, and equal companion, as well as a willing mount. Given this rapport between rider and mount, there have been instances where unicorns have charged into certain death to save a beloved treespeaker.\n\n==Special Disadvantages==\nOnly elven females can be treespeakers. At the start of their careers, the females pledge their purity for two decades. At the end of that time, they may renew the pledge and continue as treespeakers, or they may bow out and become a regular priest of Mielikki.\n\nAny treespeaker who breaks the vow of purity forever loses all her spells and abilities immediately. Naturally, the unicorn instantly deserts her as well.\n\nTreespeakers cannot turn undead, and have no access to the Guardian and Necromantic spheres of priests' spells.\n\n: ''\"Beg pardon, but I have to interject. Treespeakers are by far the loveliest women I've ever seen. And they are all unapproachable. Lady Mielikki, you are cruel indeed!\"''\n\n:: ''-Mendryll 'Wench-chaser' Belarod.''\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 12, "Charisma": 12],
                alignments: [],
                races: "Elf"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Animal lore", "herbalism"],
                recommended: ["Tracking"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .asClass,
                shieldsAllowed: .asClass,
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "Standard armor options according to priest class."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: false,
                mode: "forbidden",
                notes: "Treespeakers cannot turn undead, and have no access to the Guardian and Necromantic spheres of priests' spells"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Mielikki",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Treespeaker"
    )
