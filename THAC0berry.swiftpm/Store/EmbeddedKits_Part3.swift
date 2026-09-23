import Foundation

/// Parte 3 de 5 dos kits embutidos — ver `EmbeddedKits.swift` pro
/// porquê disso existir (nunca volte pra ler isso de JSON/bundle) e pro porquê
/// de estar dividido em vários arquivos/constantes em vez de um array literal
/// único gigante: um único `[Kit(...), Kit(...), ...]` com todos os kits
/// dá exatamente no erro clássico do type-checker do Swift ("unable to
/// type-check this expression in reasonable time" — que no Swift
/// Playgrounds às vezes só aparece como "Build Failed" sem detalhe nenhum).
/// Cada kit aqui é uma constante com tipo explícito (`: Kit`), o que faz o
/// compilador checar cada um isoladamente e rápido, em vez de tentar inferir
/// o array inteiro de uma vez.


let embeddedKit040: Kit = Kit(
        id: "milil_loresinger",
        name: "Milil - Loresinger",
        wikiPageTitle: "Milil - Loresinger (Character Kit)",
        redirectAliases: ["Priests of Milil (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Milil is the god of poetry, song, creativity, and inspiration. It is not a surprise at all that a band of priests got together and declared themselves loresingers of Milil. The loresingers specialize in storytelling, or to be more exact, storysinging. Most loresingers are indistinguishable from bards, hardly surprising since there are many bards who worship Milil. Milil is considered subordinate to Oghma the Binder, the patron god of the bards. Aside from some competitiveness, especially from the sects of Oghma, the faiths are allied.",
            requirements: "Charisma 14, Intelligence 12, Wisdom 9",
            specialBenefits: "Along with his priestly abilities, a loresinger has all the special skills of a bard except for additional spells. However, loresingers cannot turn undead. Loresingers can use the local history proficiency in order to come up with a story that will appeal directly to the natives of the area he is currently visiting.",
            specialHindrances: "If a loresinger ever loses his voice (a silence spell, a gag over his mouth, etc.), he must make a saving throw vs spell or suffer the effects of a fear spell until his voice returns. Loresingers cannot turn undead, nor can they cast priest spells from the Combat sphere. : \"Gods above, who writes this stuff? Loresingers are so pretentious and they get so overwrought when the least little thing goes wrong! I know that my lord and god Oghma is on good terms with their patron Milil, but this whole description is over-romanticized nonsense. No one, and I do mean no one, can entertain us well us a bard, and that goes double for those over-sensitive, preening sissies called Loresingers!\" :: -Mendryll Belarod, bard and well proud of it!",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Artistic ability (poetry), folklore, singing",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Milil is the god of poetry, song, creativity, and inspiration. It is not a surprise at all that a band of priests got together and declared themselves loresingers of Milil. The loresingers specialize in storytelling, or to be more exact, storysinging.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Elf, half-elf, human\n|-\n| **Ability Requirements** || Charisma 14,Intelligence 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest, Rogue\n|-\n| **Bonus Proficiencies** || Artistic ability (poetry), folklore, singing\n|-\n| **Recommended Proficiencies** || Local history, musical instrument\n|}\n## Overview\nMilil is the god of poetry, song, creativity, and inspiration. It is not a surprise at all that a band of priests got together and declared themselves loresingers of Milil. The loresingers specialize in storytelling, or to be more exact, storysinging.\n\nMost loresingers are indistinguishable from bards, hardly surprising since there are many bards who worship Milil. Milil is considered subordinate to Oghma the Binder, the patron god of the bards. Aside from some competitiveness, especially from the sects of Oghma, the faiths are allied.\n\n## Description\nWhen performing, loresingers wear billowy white shirts with puffy sleeves, and either green or tan tights. Each loresinger has a short crimson cape with embroidered golden dragons cavorting up and down the length of the rich fabric. In a concession to the dangers of the road, many loresingers wear leather armor while traveling. Of course, they do their best to make the armor blend in with their other clothes. Favored weapons of the loresingers are the rapier and the main-gauche.\n\n## Role-Playing\nSinging and storytelling, and combinations of the two whenever possible, are at the center of every loresinger's life. In fact, loresingers define everything, including life itself, in terms of songs and stories.\n\nWhereas \"normal\" bards are equal parts rogue, performer, musician, and news-bearer, loresingers have a more romanticized idea about their roles in the Realms. They believe Milil intends the loresingers to be sensitive storytellers with sweet voices and vast fonts of creative inspiration. A loresinger's performance should, in their minds, invoke the dreams of the humble people of the Realms and motivate them all to do greater things.\n\n## Special Abilities\nAlong with his priestly abilities, a loresinger has all the special skills of a bard except for additional spells. However, loresingers cannot turn undead.\n\nLoresingers can use the local history proficiency in order to come up with a story that will appeal directly to the natives of the area he is currently visiting.\n\n## Special Disadvantages\nIf a loresinger ever loses his voice (a silence spell, a gag over his mouth, etc.), he must make a saving throw vs spell or suffer the effects of a fear spell until his voice returns.\n\nLoresingers cannot turn undead, nor can they cast priest spells from the Combat sphere.\n\n: *\"Gods above, who writes this stuff? Loresingers are so pretentious and they get so overwrought when the least little thing goes wrong! I know that my lord and god Oghma is on good terms with their patron Milil, but this whole description is over-romanticized nonsense. No one, and I do mean no one, can entertain us well us a bard, and that goes double for those over-sensitive, preening sissies called Loresingers!\"*\n\n:: *-Mendryll Belarod, bard and well proud of it!*",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Elf, half-elf, human\n|-\n| '''Ability Requirements''' || [[Charisma]] 14,{{br}}[[Intelligence]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest, Rogue\n|-\n| '''Bonus Proficiencies''' || [[Artistic Ability (Proficiency)|Artistic ability]] (poetry), [[Folklore (Proficiency)|folklore]], [[Singing (Proficiency)|singing]]\n|-\n| '''Recommended Proficiencies''' || [[Local History (Proficiency)|Local history]], [[Musical Instrument (Proficiency)|musical instrument]]\n|}__TOC__\n==Overview==\nMilil is the god of poetry, song, creativity, and inspiration. It is not a surprise at all that a band of priests got together and declared themselves loresingers of Milil. The loresingers specialize in storytelling, or to be more exact, storysinging.\n\nMost loresingers are indistinguishable from bards, hardly surprising since there are many bards who worship Milil. Milil is considered subordinate to Oghma the Binder, the patron god of the bards. Aside from some competitiveness, especially from the sects of Oghma, the faiths are allied.\n\n==Description==\nWhen performing, loresingers wear billowy white shirts with puffy sleeves, and either green or tan tights. Each loresinger has a short crimson cape with embroidered golden dragons cavorting up and down the length of the rich fabric. In a concession to the dangers of the road, many loresingers wear leather armor while traveling. Of course, they do their best to make the armor blend in with their other clothes. Favored weapons of the loresingers are the rapier and the main-gauche.\n\n==Role-Playing==\nSinging and storytelling, and combinations of the two whenever possible, are at the center of every loresinger's life. In fact, loresingers define everything, including life itself, in terms of songs and stories.\n\nWhereas \"normal\" bards are equal parts rogue, performer, musician, and news-bearer, loresingers have a more romanticized idea about their roles in the Realms. They believe Milil intends the loresingers to be sensitive storytellers with sweet voices and vast fonts of creative inspiration. A loresinger's performance should, in their minds, invoke the dreams of the humble people of the Realms and motivate them all to do greater things.\n\n==Special Abilities==\nAlong with his priestly abilities, a loresinger has all the special skills of a bard except for additional spells. However, loresingers cannot turn undead.\n\nLoresingers can use the [[Local History (Proficiency)|local history]] proficiency in order to come up with a story that will appeal directly to the natives of the area he is currently visiting.\n\n==Special Disadvantages==\nIf a loresinger ever loses his voice (a silence spell, a gag over his mouth, etc.), he must make a saving throw vs spell or suffer the effects of a fear spell until his voice returns.\n\nLoresingers cannot turn undead, nor can they cast priest spells from the Combat sphere.\n\n: ''\"Gods above, who writes this stuff? Loresingers are so pretentious and they get so overwrought when the least little thing goes wrong! I know that my lord and god Oghma is on good terms with their patron Milil, but this whole description is over-romanticized nonsense. No one, and I do mean no one, can entertain us well us a bard, and that goes double for those over-sensitive, preening sissies called Loresingers!\"''\n\n:: ''-Mendryll Belarod, bard and well proud of it!''\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 12, "Wisdom": 9, "Charisma": 14],
                alignments: [],
                races: "Elf, half-elf, human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Artistic ability", "folklore", "singing"],
                recommended: ["Local history", "musical instrument"],
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
                notes: "However, loresingers cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Milil",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Loresinger"
    )

let embeddedKit041: Kit = Kit(
        id: "mystra_apothecar",
        name: "Mystra - Apothecar",
        wikiPageTitle: "Mystra - Apothecar (Character Kit)",
        redirectAliases: ["Priests of Mystra (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Apothecars are the holy alchemists of the church of Mystra. Their main function is the fabrication and identification of potions, salves, ointments, and elixirs. They are a proud line of priests, many of them having been in Mystra's service for generations.",
            requirements: "Intelligence 14, Wisdom 9",
            specialBenefits: "Apothecars have a 5% likelihood per level to identify a potion by just smelling it and a 10% chance per level to identify a potion by one small taste. Their base chance of successfully brewing a potion is 85%.",
            specialHindrances: "Given their usual environment of tower laboratories, apothecars are ill-suited for combat and suffer a -2 penalty on attack rolls, and cannot turn undead. Their maximum allowable Strength score is 15.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Alchemy, herbalism, pottery",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Apothecars are the holy alchemists of the church of Mystra. Their main function is the fabrication and identification of potions, salves, ointments, and elixirs. They are a proud line of priests, many of them having been in Mystra's service for generations.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Gnome, half-elf, human\n|-\n| **Ability Requirements** || Intelligence 14,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Alchemy, herbalism, pottery\n|-\n| **Recommended Proficiencies** || Spellcraft\n|}\n## Overview\nApothecars are the holy alchemists of the church of Mystra. Their main function is the fabrication and identification of potions, salves, ointments, and elixirs. They are a proud line of priests, many of them having been in Mystra's service for generations.\n\n## Description\nApothecars wear the traditional midnight blue robes of Mystran clergy, and always have a silver holy symbol around their necks. Aside from those two details, Apothecars look nothing else like their fellow clergy, mostly due to side effects of long-term alchemical work and exposure to weird substances. Many apothecars are accompanied by a lingering scent of chemicals. Most apothecars' hair is frizzy, if not burnt in patches. The hands of an apothecar are stained with sundry substances of wildly various colors.\n\n## Role-Playing\nApothecars are extremely proud of their positions in the church. They know that their fellow clergy (and many other NPCs) come to them for help in this unique field of expertise.\n\nLong-term exposure to alchemical fumes also causes bouts of eccentricity in apothecars. Most of the time, this is manifested in extremes of behavior and emotion. Loud apothecars talk loudly. Excitable apothecars are very excitable, and so on.\n\n## Special Abilities\nApothecars have a 5% likelihood per level to identify a potion by just smelling it and a 10% chance per level to identify a potion by one small taste. Their base chance of successfully brewing a potion is 85%.\n\n## Special Disadvantages\nGiven their usual environment of tower laboratories, apothecars are ill-suited for combat and suffer a -2 penalty on attack rolls, and cannot turn undead. Their maximum allowable Strength score is 15.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Gnome, half-elf, human\n|-\n| '''Ability Requirements''' || [[Intelligence]] 14,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Alchemy (Proficiency)|Alchemy]], [[Herbalism (Proficiency)|herbalism]], [[Pottery (Proficiency)|pottery]]\n|-\n| '''Recommended Proficiencies''' || [[Spellcraft (Proficiency)|Spellcraft]]\n|}__TOC__\n==Overview==\nApothecars are the holy alchemists of the church of Mystra. Their main function is the fabrication and identification of potions, salves, ointments, and elixirs. They are a proud line of priests, many of them having been in Mystra's service for generations.\n\n==Description==\nApothecars wear the traditional midnight blue robes of Mystran clergy, and always have a silver holy symbol around their necks. Aside from those two details, Apothecars look nothing else like their fellow clergy, mostly due to side effects of long-term alchemical work and exposure to weird substances. Many apothecars are accompanied by a lingering scent of chemicals. Most apothecars' hair is frizzy, if not burnt in patches. The hands of an apothecar are stained with sundry substances of wildly various colors.\n\n==Role-Playing==\nApothecars are extremely proud of their positions in the church. They know that their fellow clergy (and many other NPCs) come to them for help in this unique field of expertise.\n\nLong-term exposure to alchemical fumes also causes bouts of eccentricity in apothecars. Most of the time, this is manifested in extremes of behavior and emotion. Loud apothecars talk loudly. Excitable apothecars are very excitable, and so on.\n\n==Special Abilities==\nApothecars have a 5% likelihood per level to identify a potion by just smelling it and a 10% chance per level to identify a potion by one small taste. Their base chance of successfully brewing a potion is 85%.\n\n==Special Disadvantages==\nGiven their usual environment of tower laboratories, apothecars are ill-suited for combat and suffer a -2 penalty on attack rolls, and cannot turn undead. Their maximum allowable Strength score is 15.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 14, "Wisdom": 9],
                alignments: [],
                races: "Gnome, half-elf, human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Alchemy", "herbalism", "pottery"],
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
                notes: "Given their usual environment of tower laboratories, apothecars are ill-suited for combat and suffer a -2 penalty on attack rolls, and cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Mystra",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Apothecar"
    )

let embeddedKit042: Kit = Kit(
        id: "mystra_monitor",
        name: "Mystra - Monitor",
        wikiPageTitle: "Mystra - Monitor (Character Kit)",
        redirectAliases: ["Monitor (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Magic is a force of great power and presence in the Realms, and Mystra desired a special form of priest who could watch over the different uses of magic power and were created. Monitors keep the balance of magical power, destroy detrimental and cursed magical items, and help mages that are unjustly accused of crimes. Imagine a priest who is also a mage who is also a detective, and one gets the idea of what a monitor does.",
            requirements: "Intelligence 12, Wisdom 9",
            specialBenefits: "All Monitors can cast identify once a day. However, Monitors do not have to actually handle the item in order to successfully identify it; they need only see it. The spell accuracy is 15% per level, with a 99% maximum chance of classifying the item. Monitors can also attempt to dispel magic once per day plus one additional casting per day for every three levels of a monitor's experience. Monitors can detect magic three times a day. They also can turn undead, a special boon from Kelemvor, since he and Mystra were allies and friends during their mortal lives. Areas of wild magic have no effect on monitors or their spells.",
            specialHindrances: "Monitors are limited to using the weapons accessible to wizards, such as staves, daggers, darts, knives, and slings. They can, however, wear any armor they wish. Certain cities where magic is regulated and restricted (Hillsfar, for example) have a strong dislike of monitors. They see a monitor as a pesky attorney trying to get arrested mages freed on technicalities in Mystra's name. As a result, in magic-hostile cities, monitors are penalized at -2 on interactions with municipal government NPCs. Monitors cannot cast any priests spells from the Combat, Necromantic, Plant, or Weather spheres.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Spellcraft",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Magic is a force of great power and presence in the Realms, and Mystra desired a special form of priest who could watch over the different uses of magic power and were created.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Elf, half-elf, human\n|-\n| **Ability Requirements** || Intelligence 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Spellcraft\n|-\n| **Recommended Proficiencies** || Religion\n|}\n## Overview\nMagic is a force of great power and presence in the Realms, and Mystra desired a special form of priest who could watch over the different uses of magic power and were created.\n\nMonitors keep the balance of magical power, destroy detrimental and cursed magical items, and help mages that are unjustly accused of crimes.\n\nImagine a priest who is also a mage who is also a detective, and one gets the idea of what a monitor does.\n\n## Description\nMystra's color is blue, and the monitors follow their Lady's tastes. Monitors wear soft robes of midnight blue with plenty of freedom of movement for somatic gestures. Monitors wear a silver necklace made of a series of stars strung together. It is their badge of office, as well as Mystra's holy symbol.\n\nMonitors actually embrace a lawful, balanced attitude towards magic that tends to be more reminiscent of Mystra from before the Time of Troubles. The monitors all have sharp, analytical minds and keen senses; their minds are always working.\n\nWhile well-versed and highly focused on magic, magical theory, and proper use of spells, monitors are quite lacking in social graces. These attributes make the monitors seem brusque and abrupt, offending others around them. They do not intend to be offensive; they are simply single-minded in either destroying an item, restoring the magical balance, or clearing some poor wizard falsely accused.\n\n## Special Abilities\nAll Monitors can cast identify once a day. However, Monitors do not have to actually handle the item in order to successfully identify it; they need only see it. The spell accuracy is 15% per level, with a 99% maximum chance of classifying the item. Monitors can also attempt to dispel magic once per day plus one additional casting per day for every three levels of a monitor's experience.\n\nMonitors can detect magic three times a day. They also can turn undead, a special boon from Kelemvor, since he and Mystra were allies and friends during their mortal lives.\n\nAreas of wild magic have no effect on monitors or their spells.\n\n## Special Disadvantages\nMonitors are limited to using the weapons accessible to wizards, such as staves, daggers, darts, knives, and slings. They can, however, wear any armor they wish. Certain cities where magic is regulated and restricted (Hillsfar, for example) have a strong dislike of monitors. They see a monitor as a pesky attorney trying to get arrested mages freed on technicalities in Mystra's name. As a result, in magic-hostile cities, monitors are penalized at -2 on interactions with municipal government NPCs.\n\nMonitors cannot cast any priests spells from the Combat, Necromantic, Plant, or Weather spheres.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Elf, half-elf, human\n|-\n| '''Ability Requirements''' || [[Intelligence]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Spellcraft (Proficiency)|Spellcraft]]\n|-\n| '''Recommended Proficiencies''' || [[Religion (Proficiency)|Religion]]\n|}__TOC__\n==Overview==\nMagic is a force of great power and presence in the Realms, and Mystra desired a special form of priest who could watch over the different uses of magic power and were created.\n\nMonitors keep the balance of magical power, destroy detrimental and cursed magical items, and help mages that are unjustly accused of crimes.\n\nImagine a priest who is also a mage who is also a detective, and one gets the idea of what a monitor does.\n\n==Description==\nMystra's color is blue, and the monitors follow their Lady's tastes. Monitors wear soft robes of midnight blue with plenty of freedom of movement for somatic gestures. Monitors wear a silver necklace made of a series of stars strung together. It is their badge of office, as well as Mystra's holy symbol.\n\nMonitors actually embrace a lawful, balanced attitude towards magic that tends to be more reminiscent of Mystra from before the Time of Troubles. The monitors all have sharp, analytical minds and keen senses; their minds are always working.\n\nWhile well-versed and highly focused on magic, magical theory, and proper use of spells, monitors are quite lacking in social graces. These attributes make the monitors seem brusque and abrupt, offending others around them. They do not intend to be offensive; they are simply single-minded in either destroying an item, restoring the magical balance, or clearing some poor wizard falsely accused.\n\n==Special Abilities==\nAll Monitors can cast identify once a day. However, Monitors do not have to actually handle the item in order to successfully identify it; they need only see it. The spell accuracy is 15% per level, with a 99% maximum chance of classifying the item. Monitors can also attempt to dispel magic once per day plus one additional casting per day for every three levels of a monitor's experience.\n\nMonitors can detect magic three times a day. They also can turn undead, a special boon from Kelemvor, since he and Mystra were allies and friends during their mortal lives.\n\nAreas of wild magic have no effect on monitors or their spells.\n\n==Special Disadvantages==\nMonitors are limited to using the weapons accessible to wizards, such as staves, daggers, darts, knives, and slings. They can, however, wear any armor they wish. Certain cities where magic is regulated and restricted (Hillsfar, for example) have a strong dislike of monitors. They see a monitor as a pesky attorney trying to get arrested mages freed on technicalities in Mystra's name. As a result, in magic-hostile cities, monitors are penalized at -2 on interactions with municipal government NPCs.\n\nMonitors cannot cast any priests spells from the Combat, Necromantic, Plant, or Weather spheres.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 12, "Wisdom": 9],
                alignments: [],
                races: "Elf, half-elf, human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Spellcraft"],
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
        deity: "Mystra",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Monitor"
    )

let embeddedKit043: Kit = Kit(
        id: "natural_philosopher",
        name: "Natural Philosopher",
        wikiPageTitle: "Natural Philosopher (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "Xenia, a typical Natural Philosopher, delights in the study of new plants and animals. She thinks nothing of venturing into a haunted forest to observe a rare circle of toadstools or visiting a dragon's den to observe firsthand the miracle of a hatching. She rarely interferes with her subject of study, preferring to observe and sketch rather than bring home specimens. Natural Philosophers often undertake adventures out of sheer curiosity. This becomes a good role for an NPC druid: Xenia (as either a doddering old sage or a brash young student) hires a party to accompany her on a dangerous scientific expedition to visit a living island spotted in a sahuagin-controlled ocean. A party also might accompany her to study the ecology of the salamander on the Elemental Plane of Fire or to check out a rumor that a previously extinct species of giant owl now lives in the woods by a lich's castle.",
            requirements: nil,
            specialBenefits: "The Natural Philosopher may use weapon proficiency slots for nonweapon proficiencies. This allows Xenia to devote multiple slots to a single proficiency (such as animal lore, herbalism, or weather sense), making her an expert in zoology, botany, or meteorology.",
            specialHindrances: "Remember to reflect in your role-playing the Natural Philosopher's insatiable curiosity. For instance, Xenia would rather study a new monster than kill it or run away. She finds puzzles and riddles irresistible and risks even her life to find the answers.",
            wealthOptions: "3d6x10 gp.",
            weaponProficiencies: "Recommended—staff.",
            nonweaponProficiencies: "* Bonus—ancient history. * Recommended—(general) artistic ability, languages (modern), weather sense; (priest) herbalism, languages (ancient), reading/writing; (warrior) animal lore.",
            equipment: "The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "From youth, the unbridled curiosity of Natural Philosophers has lent them a fascination about everything from the characteristics of plants and animals to the workings of natural forces like lightning and weather, in addition to the ancient history of the druidic order.",
            fullText: "## Natural Philosopher\nFrom youth, the unbridled curiosity of Natural Philosophers has lent them a fascination about everything from the characteristics of plants and animals to the workings of natural forces like lightning and weather, in addition to the ancient history of the druidic order. Besides the usual ability score requirements, a druid needs at least Intelligence 15 for this kit.\n\n**Role:** Xenia, a typical Natural Philosopher, delights in the study of new plants and animals. She thinks nothing of venturing into a haunted forest to observe a rare circle of toadstools or visiting a dragon's den to observe firsthand the miracle of a hatching. She rarely interferes with her subject of study, preferring to observe and sketch rather than bring home specimens.\n\nNatural Philosophers often undertake adventures out of sheer curiosity. This becomes a good role for an NPC druid: Xenia (as either a doddering old sage or a brash young student) hires a party to accompany her on a dangerous scientific expedition to visit a living island spotted in a sahuagin-controlled ocean. A party also might accompany her to study the ecology of the salamander on the Elemental Plane of Fire or to check out a rumor that a previously extinct species of giant owl now lives in the woods by a lich's castle.\n\n**Branch Restrictions:** Arctic and jungle druids cannot take this kit, as their harsh home terrain forces them to devote their time to mere survival, not scientific pursuits.\n\n**Weapon Proficiencies:** *Recommended*—staff.\n\n**Secondary Skills:** Hunter, navigator, scribe.\n\n**Nonweapon Proficiencies:**\n* *Bonus*—ancient history.\n* *Recommended*—(general) artistic ability, languages (modern), weather sense; (priest) herbalism, languages (ancient), reading/writing; (warrior) animal lore.\n\n**Equipment:** The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp.\n\n**Special Benefits:** The Natural Philosopher may use weapon proficiency slots for nonweapon proficiencies. This allows Xenia to devote multiple slots to a single proficiency (such as animal lore, herbalism, or weather sense), making her an expert in zoology, botany, or meteorology.\n\n**Special Hindrances:** Remember to reflect in your role-playing the Natural Philosopher's insatiable curiosity. For instance, Xenia would rather study a new monster than kill it or run away. She finds puzzles and riddles irresistible and risks even her life to find the answers.\n\n**Wealth Options:** 3d6x10 gp.",
            rawWikitext: "{{Sidebar CDH Ch2}}__NOTOC__\n==Natural Philosopher==\nFrom youth, the unbridled curiosity of Natural Philosophers has lent them a fascination about everything from the characteristics of plants and animals to the workings of natural forces like lightning and weather, in addition to the ancient history of the druidic order. Besides the usual ability score requirements, a druid needs at least Intelligence 15 for this kit.\n\n'''Role:''' Xenia, a typical Natural Philosopher, delights in the study of new plants and animals. She thinks nothing of venturing into a haunted forest to observe a rare circle of toadstools or visiting a dragon's den to observe firsthand the miracle of a hatching. She rarely interferes with her subject of study, preferring to observe and sketch rather than bring home specimens.\n\nNatural Philosophers often undertake adventures out of sheer curiosity. This becomes a good role for an NPC druid: Xenia (as either a doddering old sage or a brash young student) hires a party to accompany her on a dangerous scientific expedition to visit a living island spotted in a sahuagin-controlled ocean. A party also might accompany her to study the ecology of the salamander on the Elemental Plane of Fire or to check out a rumor that a previously extinct species of giant owl now lives in the woods by a lich's castle.\n\n'''Branch Restrictions:''' Arctic and jungle druids cannot take this kit, as their harsh home terrain forces them to devote their time to mere survival, not scientific pursuits.\n\n'''Weapon Proficiencies:''' ''Recommended''—staff.\n\n'''Secondary Skills:''' Hunter, navigator, scribe.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus''—[[Ancient History (Proficiency)|ancient history]].\n* ''Recommended''—(general) [[Artistic Ability (Proficiency)|artistic ability]], [[Languages, Modern (Proficiency)|languages (modern)]], [[Weather Sense (Proficiency)|weather sense]]; (priest) [[Herbalism (Proficiency)|herbalism]], [[Languages, Ancient (Proficiency)|languages (ancient)]], [[Reading/Writing (Proficiency)|reading/writing]]; (warrior) [[Animal Lore (Proficiency)|animal lore]].\n\n'''Equipment:''' The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' The Natural Philosopher may use weapon proficiency slots for nonweapon proficiencies. This allows Xenia to devote multiple slots to a single proficiency (such as animal lore, herbalism, or weather sense), making her an expert in zoology, botany, or meteorology.\n\n'''Special Hindrances:''' Remember to reflect in your role-playing the Natural Philosopher's insatiable curiosity. For instance, Xenia would rather study a new monster than kill it or run away. She finds puzzles and riddles irresistible and risks even her life to find the answers.\n\n'''Wealth Options:''' 3d6x10 gp.\n\n{{Navbox The Complete Druid's Handbook}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 15],
                alignments: ["True Neutral"],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["staff"],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["ancient history"],
                recommended: ["artistic ability", "languages", "weather sense", "herbalism", "languages", "reading/writing", "animal lore"],
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

let embeddedKit044: Kit = Kit(
        id: "noble_s_clerk",
        name: "Noble's Clerk",
        wikiPageTitle: "Noble's Clerk (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "A noble's clerk may serve as an officer of the palace or manor for a noble, as a tutor or scholarly counselor, as an entertainer, or he may provide advice and services for an illiterate master. He may also be a royal courier or licensed merchant-adventurer. Since he is denied both the skills of the warrior and the authority of the Church, he must be more shrewd and indirect in his methods. Not being bound by the honor of the warrior or the sanctity of the priest, he may rely on deception and stealth to maneuver toward his goals. Further, since the clerk's status is lower than that of warriors and priests, he has readier access to the common classes, and he is able to obtain information and favors through them.",
            requirements: nil,
            specialBenefits: "Parchment, writing ink, and sealing wax are provided without cost by the clerk's patron.",
            specialHindrances: "The clerk has low social status compared with warriors or churchmen: -3 reaction unless in the company of lord or patron. Category:Character Kit Category:Character Kit CPCS",
            wealthOptions: nil,
            weaponProficiencies: "Any weapon normally permitted to the thief class and available in the Carolingian period.",
            nonweaponProficiencies: "* Bonus— Read/Write; * Required— None; * Recommended— Etiquette, Stewardship, Statecraft, Local History, Appraising, Alertness*, Fast-Talking*, Information Gathering*, Intimidation*, Observation*. : ''See The Complete Thief's Handbook for these non-weapon proficiencies.",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "A noble's clerk is an educated noble or commoner who rejects both priest and warrior paths.",
            fullText: "## Noble's Clerk Kit (Rogue Kit)\n\n**Description:** A noble's clerk is an educated noble or commoner who rejects both priest and warrior paths.\n\n**Role:** A noble's clerk may serve as an officer of the palace or manor for a noble, as a tutor or scholarly counselor, as an entertainer, or he may provide advice and services for an illiterate master. He may also be a royal courier or licensed merchant-adventurer. Since he is denied both the skills of the warrior and the authority of the Church, he must be more shrewd and indirect in his methods. Not being bound by the honor of the warrior or the sanctity of the priest, he may rely on deception and stealth to maneuver toward his goals. Further, since the clerk's status is lower than that of warriors and priests, he has readier access to the common classes, and he is able to obtain information and favors through them.\n\n**Secondary Skills:** Scribe.\n\n**Weapon Proficiencies:** Any weapon normally permitted to the thief class and available in the Carolingian period.\n\n**Nonweapon Proficiencies:**\n* *Bonus—* Read/Write;\n* *Required—* None;\n* *Recommended—* Etiquette, Stewardship, Statecraft, Local History, Appraising, Alertness*, Fast-Talking*, Information Gathering*, Intimidation*, Observation*.\n: ''See The Complete Thief's Handbook for these non-weapon proficiencies.\n\n**Skill Progression:** The stealth and listening skills are most useful, along with picking pockets. Manual dexterity and fast-talking are essential in intercepting documents and parcels for private examination.\n\n**Special Benefits:** Parchment, writing ink, and sealing wax are provided without cost by the clerk's patron.\n\n**Special Hindrances:** The clerk has low social status compared with warriors or churchmen: -3 reaction unless in the company of lord or patron.",
            rawWikitext: "{{Sidebar CPCS Ch3}}\n==Noble's Clerk Kit (Rogue Kit)==\n\n'''Description:''' A noble's clerk is an educated noble or commoner who rejects both priest and warrior paths.\n\n'''Role:''' A noble's clerk may serve as an officer of the palace or manor for a noble, as a tutor or scholarly counselor, as an entertainer, or he may provide advice and services for an illiterate master. He may also be a royal courier or licensed merchant-adventurer. Since he is denied both the skills of the warrior and the authority of the Church, he must be more shrewd and indirect in his methods. Not being bound by the honor of the warrior or the sanctity of the priest, he may rely on deception and stealth to maneuver toward his goals. Further, since the clerk's status is lower than that of warriors and priests, he has readier access to the common classes, and he is able to obtain information and favors through them.\n\n'''Secondary Skills:''' Scribe.\n\n'''Weapon Proficiencies:''' Any weapon normally permitted to the thief class and available in the Carolingian period.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus—'' [[Reading/Writing (Proficiency)|Read/Write]];\n* ''Required—'' None;\n* ''Recommended—'' [[Etiquette (Proficiency)|Etiquette]], [[Stewardship (Proficiency)|Stewardship]], [[Statecraft (Proficiency)|Statecraft]], [[Local History (Proficiency)|Local History]], [[Appraising (Proficiency)|Appraising]], [[Alertness (Proficiency)|Alertness]]*, [[Fast-talking (Proficiency)|Fast-Talking]]*, [[Information Gathering (Proficiency)|Information Gathering]]*, [[Intimidation (Proficiency)|Intimidation]]*, [[Observation (Proficiency)|Observation]]*.\n: ''See The Complete Thief's Handbook for these non-weapon proficiencies.\n\n'''Skill Progression:''' The stealth and listening skills are most useful, along with picking pockets. Manual dexterity and fast-talking are essential in intercepting documents and parcels for private examination.\n\n'''Special Benefits:''' Parchment, writing ink, and sealing wax are provided without cost by the clerk's patron.\n\n'''Special Hindrances:''' The clerk has low social status compared with warriors or churchmen: -3 reaction unless in the company of lord or patron.\n\n{{Navbox Charlemagne's Paladins Campaign Sourcebook}}\n[[Category:Character Kit]]\n[[Category:Character Kit CPCS]]"
        ),
        categories: ["Character Kit", "Character Kit CPCS"],
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
                notes: "Any weapon normally permitted to the thief class and available in the Carolingian period."
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Read/Write"],
                recommended: ["Etiquette", "Stewardship", "Statecraft", "Local History", "Appraising", "Alertness"],
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

let embeddedKit045: Kit = Kit(
        id: "nobleman_priest",
        name: "Nobleman Priest",
        wikiPageTitle: "Nobleman Priest (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "In the campaign, the Nobleman Priest is an aggravating snob (though he might not be aware of his snobbery). He is a fun role to play, but he'd better have some redeeming features if the other PCs are to continue to associate with him. If he does have redeeming features, it's very likely that some PCs will try to \"reform\" him to their own way of thinking.",
            requirements: nil,
            specialBenefits: "The Nobleman Priest starts with more gold than other priests; see below under Wealth Options. The Nobleman Priest receives a +3 reaction from any noble of his own culture, and a +2 from nobles of other cultures. The DM can ignore this if there is a cultural hatred between those people and the priest's culture or the priest's god. When travelling, he can demand shelter from anyone in his own land; he can demand shelter for two people multiplied by the priest's experience level (if he's eighth level, he can demand shelter for himself and a retinue of fifteen more people).",
            specialHindrances: "The Nobleman Priest is expected to live well. If he has enough money to do so, he may only buy high-quality goods, and so must spend at least two times the minimum necessary money for anything he buys. If a basic long sword costs 15 gp, he won't buy one worth less than 30 gp; the extra money goes into quality, engraving, etc. (He can't save money by having a friend or follower buy cheaper things for him; he's just not satisfied with anything less than good-quality merchandise.) If the priest is broke and cannot spend this extra money, he can then settle for lesser goods... but the other nobles of his culture, if they see him with shabby accoutrements, will mock him, and he does not get his reaction bonus until once again all his goods are high-quality goods. In fact, if his gear and possessions look sufficiently shabby (DM's discretion), people may not believe him to be a nobleman at all, and may refuse him the shelter he could ordinarily demand. (This happens most often if a nobleman priest is robbed of all his clothes and goods and left to fend for himself.) As he can demand shelter of others, other Nobleman Priests can demand shelter of him. This can be expensive if they decide to stay for awhile. This is also a good way for the DM to bleed extra money from the priest if he seems to have too much.",
            wealthOptions: "The Nobleman Priest begins play with more gold than other priests. He gets 225 gp plus the standard 3d6x10 gp. But he must spend a good portion of that on the Equipment required of him. If the priest abandons this kit, that money doesn't magically \"go away,\" but as part of his social ostracization the character should suffer some sort of financial loss, equal to at least 225 gp, as determined by the DM. (Perhaps a malicious ex-friend destroys some of his property; perhaps a petty-minded business acquaintance betrays him on a business deal.)",
            weaponProficiencies: "* Required: None. * Recommended: Long sword, bastard sword, lance, flails (all), maces (all), if allowed by the priest's actual priest class.",
            nonweaponProficiencies: "* Bonus Proficiencies: (General) Etiquette, Heraldry, Riding (Land-Based). * Recommended: (General) Animal Training, Dancing, (Warrior, double slots unless the priest class has a nonweapon proficiency group crossover including the Warrior group) Gaming, Hunting, (Priest) Local History, Musical Instrument, Reading/Writing.",
            equipment: "The Nobleman Priest may spend his gold as he chooses # but he has certain minimum standards he cannot violate. Before starting play, he must buy: (1) A suit of armor (if he is permitted to by his priest-class... and, unless his class limits him to lesser armor, he cannot buy armor less protective than brigandine or scale mail). (2) At least one weapon larger than a dagger (again, if his priest-class so permits him). (3) A horse (at least a riding horse), riding saddle, bit & bridle, horseshoes and shoeing, halter and saddle blanket."
        ),
        description: KitDescription(
            briefSummary: "This priest was a member of a noble family and entered a priesthood. But even as a priest he keeps his opinions about the superiority of the ruling classes and his tastes for the finer things in life; he doesn't abandon his love of good food, good furnishings, comfort, the arts, intellectual stimulation, and so forth.",
            fullText: "## Nobleman Priest\n**Description:** This priest was a member of a noble family and entered a priesthood. But even as a priest he keeps his opinions about the superiority of the ruling classes and his tastes for the finer things in life; he doesn't abandon his love of good food, good furnishings, comfort, the arts, intellectual stimulation, and so forth.\n\nThe Nobleman Priest prefers the company of nobles and is often appointed as an advisor to a noble family, a ruler, an important local governor, etc. He has less concern for the lives and welfare of commoners. When pressed, he will perform any and all priestly duties for commoners, but he usually seeks to avoid these duties; when he is a low-level character, he'll keep himself away from common folk as much as possible in order to avoid these inconveniences, and when he is higher-level he will assign a subordinate or a follower to attend their needs.\n\nThe Nobleman Priest is not necessarily evil or a bad person. In fact, he often adheres to a code of chivalric behavior much like a knight's. But he does have strong social prejudices which color his thinking.\n\nImportant note: A nobleman can become a priest and not take the Nobleman Priest kit. This sort of priest lives more frugally, like other priests, and does not have to have a disdain for the lower social classes; Nobleman Priests do not count him among their ranks.\n\nThere are no special requirements to be a Nobleman Priest.\n\nIf a Nobleman Priest player-character ever decides that he is wrong in his attitudes (which can occur in especially dramatic fashion if he is affected by the self-sacrifice of a commoner who has saved him, or if he falls in love with a character of the common social classes), he may choose to abandon this kit. If he does this, he will be ostracized by most of the nobles who were previously counted as his friends (the DM can have one or two more broad-minded nobles still count him a friend, and the player-characters can make up their own minds on the subject); he may even be exiled from his own family. As with any kit abandonment, he loses all other benefits and hindrances of the kit.\n\n**Barred:** None.\n\n**Role**: In the campaign, the Nobleman Priest is an aggravating snob (though he might not be aware of his snobbery). He is a fun role to play, but he'd better have some redeeming features if the other PCs are to continue to associate with him. If he does have redeeming features, it's very likely that some PCs will try to \"reform\" him to their own way of thinking.\n\n**Secondary Skills:** Nobleman Priests may choose or random-roll their Secondary Skill.\n\n**Weapon Proficiencies:**\n* *Required:* None.\n* *Recommended:* Long sword, bastard sword, lance, flails (all), maces (all), if allowed by the priest's actual priest class.\n\n**Nonweapon Proficiencies:**\n* *Bonus Proficiencies:* (General) Etiquette, Heraldry, Riding (Land-Based).\n* *Recommended:* (General) Animal Training, Dancing, (Warrior, double slots unless the priest class has a nonweapon proficiency group crossover including the Warrior group) Gaming, Hunting, (Priest) Local History, Musical Instrument, Reading/Writing.\n\n**Equipment:** The Nobleman Priest may spend his gold as he chooses # but he has certain minimum standards he cannot violate. Before starting play, he must buy:\n\n(1) A suit of armor (if he is permitted to by his priest-class...  and, unless his class limits him to lesser armor, he cannot buy armor less protective than brigandine or scale mail).\n\n(2) At least one weapon larger than a dagger (again, if his priest-class so permits him).\n\n(3) A horse (at least a riding horse), riding saddle, bit & bridle, horseshoes and shoeing, halter and saddle blanket.\n\n**Special Benefits:** The Nobleman Priest starts with more gold than other priests; see below under Wealth Options.\n\nThe Nobleman Priest receives a +3 reaction from any noble of his own culture, and a +2 from nobles of other cultures. The DM can ignore this if there is a cultural hatred between those people and the priest's culture or the priest's god.\n\nWhen travelling, he can demand shelter from anyone in his own land; he can demand shelter for two people multiplied by the priest's experience level (if he's eighth level, he can demand shelter for himself and a retinue of fifteen more people).\n\n**Special Hindrances:** The Nobleman Priest is expected to live well. If he has enough money to do so, he may only buy high-quality goods, and so must spend at least two times the minimum necessary money for anything he buys. If a basic long sword costs 15 gp, he won't buy one worth less than 30 gp; the extra money goes into quality, engraving, etc. (He can't save money by having a friend or follower buy cheaper things for him; he's just not satisfied with anything less than good-quality merchandise.)\n\nIf the priest is broke and cannot spend this extra money, he can then settle for lesser goods...  but the other nobles of his culture, if they see him with shabby accoutrements, will mock him, and he does not get his reaction bonus until once again all his goods are high-quality goods. In fact, if his gear and possessions look sufficiently shabby (DM's discretion), people may not believe him to be a nobleman at all, and may refuse him the shelter he could ordinarily demand. (This happens most often if a nobleman priest is robbed of all his clothes and goods and left to fend for himself.)\n\nAs he can demand shelter of others, other Nobleman Priests can demand shelter of him. This can be expensive if they decide to stay for awhile. This is also a good way for the DM to bleed extra money from the priest if he seems to have too much.\n\n**Wealth Options:** The Nobleman Priest begins play with more gold than other priests. He gets 225 gp plus the standard 3d6x10 gp. But he must spend a good portion of that on the Equipment required of him. If the priest abandons this kit, that money doesn't magically \"go away,\" but as part of his social ostracization the character should suffer some sort of financial loss, equal to at least 225 gp, as determined by the DM. (Perhaps a malicious ex-friend destroys some of his property; perhaps a petty-minded business acquaintance betrays him on a business deal.)\n\n**Races:** This kit has no special requirements for race. The DM may decide that not all races have the same kind of social snobbery that humans do, in which case that race could not take this kit.",
            rawWikitext: "{{Sidebar CPrH Ch4}}__NOTOC__\n==Nobleman Priest==\n'''Description:''' This priest was a member of a noble family and entered a priesthood. But even as a priest he keeps his opinions about the superiority of the ruling classes and his tastes for the finer things in life; he doesn't abandon his love of good food, good furnishings, comfort, the arts, intellectual stimulation, and so forth.\n\nThe Nobleman Priest prefers the company of nobles and is often appointed as an advisor to a noble family, a ruler, an important local governor, etc. He has less concern for the lives and welfare of commoners. When pressed, he will perform any and all priestly duties for commoners, but he usually seeks to avoid these duties; when he is a low-level character, he'll keep himself away from common folk as much as possible in order to avoid these inconveniences, and when he is higher-level he will assign a subordinate or a follower to attend their needs.\n\nThe Nobleman Priest is not necessarily evil or a bad person. In fact, he often adheres to a code of chivalric behavior much like a knight's. But he does have strong social prejudices which color his thinking.\n\nImportant note: A nobleman can become a priest and not take the Nobleman Priest kit. This sort of priest lives more frugally, like other priests, and does not have to have a disdain for the lower social classes; Nobleman Priests do not count him among their ranks.\n\nThere are no special requirements to be a Nobleman Priest.\n\nIf a Nobleman Priest player-character ever decides that he is wrong in his attitudes (which can occur in especially dramatic fashion if he is affected by the self-sacrifice of a commoner who has saved him, or if he falls in love with a character of the common social classes), he may choose to abandon this kit. If he does this, he will be ostracized by most of the nobles who were previously counted as his friends (the DM can have one or two more broad-minded nobles still count him a friend, and the player-characters can make up their own minds on the subject); he may even be exiled from his own family. As with any kit abandonment, he loses all other benefits and hindrances of the kit.\n\n'''Barred:''' None.\n\n'''Role''': In the campaign, the Nobleman Priest is an aggravating snob (though he might not be aware of his snobbery). He is a fun role to play, but he'd better have some redeeming features if the other PCs are to continue to associate with him. If he does have redeeming features, it's very likely that some PCs will try to \"reform\" him to their own way of thinking.\n\n'''Secondary Skills:''' Nobleman Priests may choose or random-roll their Secondary Skill.\n\n'''Weapon Proficiencies:'''\n* ''Required:'' None.\n* ''Recommended:'' Long sword, bastard sword, lance, flails (all), maces (all), if allowed by the priest's actual priest class.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus Proficiencies:'' (General) Etiquette, Heraldry, Riding (Land-Based).\n* ''Recommended:'' (General) Animal Training, Dancing, (Warrior, double slots unless the priest class has a nonweapon proficiency group crossover including the Warrior group) Gaming, Hunting, (Priest) Local History, Musical Instrument, Reading/Writing.\n\n'''Equipment:''' The Nobleman Priest may spend his gold as he chooses # but he has certain minimum standards he cannot violate. Before starting play, he must buy:\n\n(1) A suit of armor (if he is permitted to by his priest-class...  and, unless his class limits him to lesser armor, he cannot buy armor less protective than brigandine or scale mail).\n\n(2) At least one weapon larger than a dagger (again, if his priest-class so permits him).\n\n(3) A horse (at least a riding horse), riding saddle, bit & bridle, horseshoes and shoeing, halter and saddle blanket.\n\n'''Special Benefits:''' The Nobleman Priest starts with more gold than other priests; see below under Wealth Options.\n\nThe Nobleman Priest receives a +3 reaction from any noble of his own culture, and a +2 from nobles of other cultures. The DM can ignore this if there is a cultural hatred between those people and the priest's culture or the priest's god.\n\nWhen travelling, he can demand shelter from anyone in his own land; he can demand shelter for two people multiplied by the priest's experience level (if he's eighth level, he can demand shelter for himself and a retinue of fifteen more people).\n\n'''Special Hindrances:''' The Nobleman Priest is expected to live well. If he has enough money to do so, he may only buy high-quality goods, and so must spend at least two times the minimum necessary money for anything he buys. If a basic long sword costs 15 gp, he won't buy one worth less than 30 gp; the extra money goes into quality, engraving, etc. (He can't save money by having a friend or follower buy cheaper things for him; he's just not satisfied with anything less than good-quality merchandise.)\n\nIf the priest is broke and cannot spend this extra money, he can then settle for lesser goods...  but the other nobles of his culture, if they see him with shabby accoutrements, will mock him, and he does not get his reaction bonus until once again all his goods are high-quality goods. In fact, if his gear and possessions look sufficiently shabby (DM's discretion), people may not believe him to be a nobleman at all, and may refuse him the shelter he could ordinarily demand. (This happens most often if a nobleman priest is robbed of all his clothes and goods and left to fend for himself.)\n\nAs he can demand shelter of others, other Nobleman Priests can demand shelter of him. This can be expensive if they decide to stay for awhile. This is also a good way for the DM to bleed extra money from the priest if he seems to have too much.\n\n'''Wealth Options:''' The Nobleman Priest begins play with more gold than other priests. He gets 225 gp plus the standard 3d6x10 gp. But he must spend a good portion of that on the Equipment required of him. If the priest abandons this kit, that money doesn't magically \"go away,\" but as part of his social ostracization the character should suffer some sort of financial loss, equal to at least 225 gp, as determined by the DM. (Perhaps a malicious ex-friend destroys some of his property; perhaps a petty-minded business acquaintance betrays him on a business deal.)\n\n'''Races:''' This kit has no special requirements for race. The DM may decide that not all races have the same kind of social snobbery that humans do, in which case that race could not take this kit.\n\n{{Navbox The Complete Priest's Handbook}}\n[[Category:Character Kit]]\n[[Category:Character Kit CPrH]]"
        ),
        categories: ["Character Kit", "Character Kit CPrH"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: [:],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["Long sword", "bastard sword", "lance", "flails", "maces"],
                forbidden: [],
                notes: "if allowed by the priest's actual priest class."
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Etiquette", "Heraldry", "Riding "],
                recommended: ["Animal Training", "Dancing", "(Warrior", "Hunting", "Local History", "Musical Instrument", "Reading/Writing"],
                notes: "; double slots unless the priest class has a nonweapon proficiency group crossover including the Warrior group) Gaming"
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
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit046: Kit = Kit(
        id: "oghma_holy_singer",
        name: "Oghma - Holy Singer",
        wikiPageTitle: "Oghma - Holy Singer (Character Kit)",
        redirectAliases: ["Priests of Oghma (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Holy singers are special priests of Oghma whose expertise lies in singing, peacekeeping, and arbitration. Just as they seek harmony in their vocals, holy singers seek it in not only to help resolve disputes, but to sing at the inevitable celebration held when both sides come to an agreement.",
            requirements: "Charisma 14, Wisdom 9",
            specialBenefits: "Holy singers are held in such high regard as impartial arbiters that they gain a +2 to reactions with NPCs. Singing something makes it easier to remember. Therefore, when a situation comes up that requires the characters to remember something that happened to them in the recent past, the holy singer can make an ability check using Intelligence with a +2 bonus. A successful roll means that the details are well-remembered by the holy singer. Holy singers turn undead by singing to banish them. They can also create a ''protection from evil 10' radius'' by singing, although this can only be done once per week per level of the singer. When casting their clerical spells, holy singers can sing them and forgo the somatic component. This adds 2 to the casting time. Of course, this option is only open if the holy singer is able to sing and the song is not somehow being impeded.",
            specialHindrances: "Singing is such a central point of the life of a holy singer that sudden deprivation of song has traumatic effects. If a silence spell is cast upon a holy singer, he or she immediately suffers the effects of a confusion spell. Since the more experienced holy singers are even more accustomed to song, the confusion effects last for two rounds per level of the singer. If a holy singer fails a singing proficiency check, he must make a straight, unmodified saving throw vs petrification. Failure means the holy singer is utterly humiliated, and will remove himself from the listeners for one hour per level of the singer.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Musical instrument, singing",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Holy singers are special priests of Oghma whose expertise lies in singing, peacekeeping, and arbitration. Just as they seek harmony in their vocals, holy singers seek it in not only to help resolve disputes, but to sing at the inevitable celebration held when both sides come to an agreement.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Elf, half-elf, human\n|-\n| **Ability Requirements** || Charisma 14,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Musical instrument, singing\n|-\n| **Recommended Proficiencies** || Etiquette, law\n|}\n## Overview\nHoly singers are special **priests of Oghma** whose expertise lies in singing, peacekeeping, and arbitration. Just as they seek harmony in their vocals, holy singers seek it in not only to help resolve disputes, but to sing at the inevitable celebration held when both sides come to an agreement.\n\n## Description\nHoly singers wear white tunics and trousers, and a black vest trimmed with gold. Instead of the small, box-like hat normally worn by the clergy of Oghma, a holy singer wears a crimson hat with a feather stuck in it.\n\nGiven their role in the church, holy singers always look neat and clean, well-poised, and their voices are always clear and strong.\n\n## Role-Playing\nSong is the heart and soul of holy singers. Why would one ever simply speak something when it can be sung? Even the holy scriptures of Oghma and its prayers to the deity are sung.\n\nDespite bardic tendencies and their reputation for being prideful, arrogant, and self-promoting, the holy singers are actually humble in their dealings. They have transcended the normal mortal desires for attention, and now sing for the glory of Oghma or to share Oghma's harmony with others in mediation and song alike. There is a strong sense of divine nobility in their words and deeds.\n\n## Special Abilities\nHoly singers are held in such high regard as impartial arbiters that they gain a +2 to reactions with NPCs.\n\nSinging something makes it easier to remember. Therefore, when a situation comes up that requires the characters to remember something that happened to them in the recent past, the holy singer can make an ability check using Intelligence with a +2 bonus. A successful roll means that the details are well-remembered by the holy singer.\n\nHoly singers turn undead by singing to banish them. They can also create a *protection from evil 10' radius* by singing, although this can only be done once per week per level of the singer.\n\nWhen casting their clerical spells, holy singers can sing them and forgo the somatic component. This adds 2 to the casting time. Of course, this option is only open if the holy singer is able to sing and the song is not somehow being impeded.\n\n## Special Disadvantages\nSinging is such a central point of the life of a holy singer that sudden deprivation of song has traumatic effects. If a silence spell is cast upon a holy singer, he or she immediately suffers the effects of a confusion spell. Since the more experienced holy singers are even more accustomed to song, the confusion effects last for two rounds per level of the singer.\n\nIf a holy singer fails a singing proficiency check, he must make a straight, unmodified saving throw vs petrification. Failure means the holy singer is utterly humiliated, and will remove himself from the listeners for one hour per level of the singer.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Elf, half-elf, human\n|-\n| '''Ability Requirements''' || [[Charisma]] 14,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Musical Instrument (Proficiency)|Musical instrument]], [[Singing (Proficiency)|singing]]\n|-\n| '''Recommended Proficiencies''' || [[Etiquette (Proficiency)|Etiquette]], [[Law (Proficiency)|law]]\n|}__TOC__\n==Overview==\nHoly singers are special '''priests of Oghma''' whose expertise lies in singing, peacekeeping, and arbitration. Just as they seek harmony in their vocals, holy singers seek it in not only to help resolve disputes, but to sing at the inevitable celebration held when both sides come to an agreement.\n\n==Description==\nHoly singers wear white tunics and trousers, and a black vest trimmed with gold. Instead of the small, box-like hat normally worn by the clergy of Oghma, a holy singer wears a crimson hat with a feather stuck in it.\n\nGiven their role in the church, holy singers always look neat and clean, well-poised, and their voices are always clear and strong.\n\n==Role-Playing==\nSong is the heart and soul of holy singers. Why would one ever simply speak something when it can be sung? Even the holy scriptures of Oghma and its prayers to the deity are sung.\n\nDespite bardic tendencies and their reputation for being prideful, arrogant, and self-promoting, the holy singers are actually humble in their dealings. They have transcended the normal mortal desires for attention, and now sing for the glory of Oghma or to share Oghma's harmony with others in mediation and song alike. There is a strong sense of divine nobility in their words and deeds.\n\n==Special Abilities==\nHoly singers are held in such high regard as impartial arbiters that they gain a +2 to reactions with NPCs.\n\nSinging something makes it easier to remember. Therefore, when a situation comes up that requires the characters to remember something that happened to them in the recent past, the holy singer can make an ability check using Intelligence with a +2 bonus. A successful roll means that the details are well-remembered by the holy singer.\n\nHoly singers turn undead by singing to banish them. They can also create a ''protection from evil 10' radius'' by singing, although this can only be done once per week per level of the singer.\n\nWhen casting their clerical spells, holy singers can sing them and forgo the somatic component. This adds 2 to the casting time. Of course, this option is only open if the holy singer is able to sing and the song is not somehow being impeded.\n\n==Special Disadvantages==\nSinging is such a central point of the life of a holy singer that sudden deprivation of song has traumatic effects. If a silence spell is cast upon a holy singer, he or she immediately suffers the effects of a confusion spell. Since the more experienced holy singers are even more accustomed to song, the confusion effects last for two rounds per level of the singer.\n\nIf a holy singer fails a singing proficiency check, he must make a straight, unmodified saving throw vs petrification. Failure means the holy singer is utterly humiliated, and will remove himself from the listeners for one hour per level of the singer.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9, "Charisma": 14],
                alignments: [],
                races: "Elf, half-elf, human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Musical instrument", "singing"],
                recommended: ["Etiquette", "law"],
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
        deity: "Oghma",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Holy Singer"
    )

let embeddedKit047: Kit = Kit(
        id: "oghma_quill",
        name: "Oghma - Quill",
        wikiPageTitle: "Oghma - Quill (Character Kit)",
        redirectAliases: ["Quill (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Apart from being the patron deity of bards, Oghma is also the deity of knowledge. The quills are a special branch within Oghma's clergy that concentrates on the finding and recording of knowledge.",
            requirements: "Intelligence 12, Wisdom 9",
            specialBenefits: "On proficiency checks involving ancient history, folklore, and local history, quills gain a +1 bonus for every three levels of experience. They also have access to the ingredients for writing clerical scrolls, and can use such ingredients for free, once a tenday. Quills automatically gain the reading/writing proficiency for free with each language they learn.",
            specialHindrances: "Quills cannot turn undead, nor use spells from the Combat or Necromantic spheres. Combat is not overly emphasized in this priest's training. Therefore, quills can only use small- or medium- sized weapons. They are also limited to light armor, such as leather or studded leather, and small shields.",
            wealthOptions: "3d6",
            weaponProficiencies: "1",
            nonweaponProficiencies: "Folklore, reading/writing",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Apart from being the patron deity of bards, Oghma is also the deity of knowledge. The quills are a special branch within Oghma's clergy that concentrates on the finding and recording of knowledge.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Intelligence 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 1\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Folklore, reading/writing\n|-\n| **Recommended Proficiencies** || Ancient history, local history\n|}\n## Overview\nApart from being the patron deity of bards, Oghma is also the deity of knowledge. The quills are a special branch within Oghma's clergy that concentrates on the finding and recording of knowledge.\n\n## Description\nQuills wear the traditional white tunics and trousers, black vests trimmed with gold, and a small, tan, box-like hat. Many also wear a sleeve protector on the forearm of their writing hand, to protect their shirt sleeve from the ink. These protectors are normally ornamented and serve as a form of recognition.\n\nMost quills have a rather bookish, scholarly appearance; a quill is definitely not the sort of person one would commonly find traipsing about a dungeon.\n\n## Role-Playing\nQuills are diligent, inquisitive, well-read priests who take great pride in their roles as recorders of great deeds. They may not be Oghma's best singers, but they have great memories and good speaking voices.\n\n## Special Abilities\nOn proficiency checks involving ancient history, folklore, and local history, quills gain a +1 bonus for every three levels of experience. They also have access to the ingredients for writing clerical scrolls, and can use such ingredients for free, once a tenday.\n\nQuills automatically gain the reading/writing proficiency for free with each language they learn.\n\n## Special Disadvantages\nQuills cannot turn undead, nor use spells from the Combat or Necromantic spheres.\n\nCombat is not overly emphasized in this priest's training. Therefore, quills can only use small- or medium- sized weapons. They are also limited to light armor, such as leather or studded leather, and small shields.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Intelligence]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 1\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Folklore (Proficiency)|Folklore]], [[Reading/Writing (Proficiency)|reading/writing]]\n|-\n| '''Recommended Proficiencies''' || [[Ancient History (Proficiency)|Ancient history]], [[Local History (Proficiency)|local history]]\n|}__TOC__\n==Overview==\nApart from being the patron deity of bards, Oghma is also the deity of knowledge. The quills are a special branch within Oghma's clergy that concentrates on the finding and recording of knowledge.\n\n==Description==\nQuills wear the traditional white tunics and trousers, black vests trimmed with gold, and a small, tan, box-like hat. Many also wear a sleeve protector on the forearm of their writing hand, to protect their shirt sleeve from the ink. These protectors are normally ornamented and serve as a form of recognition.\n\nMost quills have a rather bookish, scholarly appearance; a quill is definitely not the sort of person one would commonly find traipsing about a dungeon.\n\n==Role-Playing==\nQuills are diligent, inquisitive, well-read priests who take great pride in their roles as recorders of great deeds. They may not be Oghma's best singers, but they have great memories and good speaking voices.\n\n==Special Abilities==\nOn proficiency checks involving [[Ancient History (Proficiency)|ancient history]], [[Folklore (Proficiency)|folklore]], and [[Local History (Proficiency)|local history]], quills gain a +1 bonus for every three levels of experience. They also have access to the ingredients for writing clerical scrolls, and can use such ingredients for free, once a tenday.\n\nQuills automatically gain the reading/writing proficiency for free with each language they learn.\n\n==Special Disadvantages==\nQuills cannot turn undead, nor use spells from the Combat or Necromantic spheres.\n\nCombat is not overly emphasized in this priest's training. Therefore, quills can only use small- or medium- sized weapons. They are also limited to light armor, such as leather or studded leather, and small shields.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Folklore", "reading/writing"],
                recommended: ["Ancient history", "local history"],
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
                notes: "Quills cannot turn undead, nor use spells from the Combat or Necromantic spheres"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Oghma",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Quill"
    )

let embeddedKit048: Kit = Kit(
        id: "outlaw_druid",
        name: "Outlaw Druid",
        wikiPageTitle: "Outlaw Druid (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "Because an outlaw band often fights in the wilderness (ambushing enemies along forest roads or defending against patrols), the druid's powers and skills naturally come to the forefront. One such Outlaw druid is Mackay. (See illustration on this page.) Outside combat, he proves excellent at gathering information and using his priestly curative powers. Depending on the nature and alignment of those in the group, you can role-play the Outlaw druid as just another party member or as the band's spiritual (or actual) leader.",
            requirements: nil,
            specialBenefits: "None.",
            specialHindrances: "Local authorities are always hunting for Outlaws like Mackay. Capture means imprisonment—or worse.",
            wealthOptions: "3d6x10 gp.",
            weaponProficiencies: "Recommended—scimitar, sling, staff.",
            nonweaponProficiencies: "* Bonus—set snares. * Recommended—(general) animal training, brewing, rope use, singing, weather sense; (priest) healing, herbalism, local history, religion; (rogue, double slot) disguise; (warrior) animal lore, tracking.",
            equipment: "The druid should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "In a region where evil forces have triumphed and hold a position of authority, good people who resist have turned outlaw. From their exile in the wilderness, these folk conduct guerrilla warfare against the cruel victors in the fashion of Robin Hood and his Merry Men.",
            fullText: "## Outlaw Druid\nIn a region where evil forces have triumphed and hold a position of authority, good people who resist have turned outlaw. From their exile in the wilderness, these folk conduct guerrilla warfare against the cruel victors in the fashion of Robin Hood and his Merry Men. Since the balance has swung so far to the side of evil, the druid may freely act as a military commander in the struggle to overthrow the oppressors. In some situations, the druidic order itself may be outlawed; then the Outlaw druid faces threats like widespread persecution of druid followers and burning of sacred groves.\n\n**Role:** Because an outlaw band often fights in the wilderness (ambushing enemies along forest roads or defending against patrols), the druid's powers and skills naturally come to the forefront. One such Outlaw druid is Mackay. (See illustration on this page.) Outside combat, he proves excellent at gathering information and using his priestly curative powers. Depending on the nature and alignment of those in the group, you can role-play the Outlaw druid as just another party member or as the band's spiritual (or actual) leader.\n\n**Weapon Proficiencies:** Recommended—scimitar, sling, staff.\n\n**Secondary Skills:** Farmer, forester, hunter, weaponsmith.\n\n**Nonweapon Proficiencies:**\n* *Bonus*—set snares.\n* *Recommended*—(general) animal training, brewing, rope use, singing, weather sense; (priest) healing, herbalism, local history, religion; (rogue, double slot) disguise; (warrior) animal lore, tracking.\n\n**Equipment:** The druid should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp.\n\n**Special Benefits:** None.\n\n**Special Hindrances:** Local authorities are always hunting for Outlaws like Mackay. Capture means imprisonment—or worse.\n\n**Wealth Options:** 3d6x10 gp.",
            rawWikitext: "{{For|other Outlaw Character Kits|Outlaw}}\n{{Sidebar CDH Ch2}}__NOTOC__\n==Outlaw Druid==\nIn a region where evil forces have triumphed and hold a position of authority, good people who resist have turned outlaw. From their exile in the wilderness, these folk conduct guerrilla warfare against the cruel victors in the fashion of Robin Hood and his Merry Men. Since the balance has swung so far to the side of evil, the druid may freely act as a military commander in the struggle to overthrow the oppressors. In some situations, the druidic order itself may be outlawed; then the Outlaw druid faces threats like widespread persecution of druid followers and burning of sacred groves.\n\n'''Role:''' Because an outlaw band often fights in the wilderness (ambushing enemies along forest roads or defending against patrols), the druid's powers and skills naturally come to the forefront. One such Outlaw druid is Mackay. (See illustration on this page.) Outside combat, he proves excellent at gathering information and using his priestly curative powers. Depending on the nature and alignment of those in the group, you can role-play the Outlaw druid as just another party member or as the band's spiritual (or actual) leader.\n\n'''Weapon Proficiencies:''' Recommended—scimitar, sling, staff.\n\n'''Secondary Skills:''' Farmer, forester, hunter, weaponsmith.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus''—[[Set Snares (Proficiency)|set snares]].\n* ''Recommended''—(general) [[Animal Training (Proficiency)|animal training]], [[Brewing (Proficiency)|brewing]], [[Rope Use (Proficiency)|rope use]], [[Singing (Proficiency)|singing]], [[Weather Sense (Proficiency)|weather sense]]; (priest) [[Healing (Proficiency)|healing]], [[Herbalism (Proficiency)|herbalism]], [[Local History (Proficiency)|local history]], [[Religion (Proficiency)|religion]]; (rogue, double slot) [[Disguise (Proficiency)|disguise]]; (warrior) [[Animal Lore (Proficiency)|animal lore]], [[Tracking (Proficiency)|tracking]].\n\n'''Equipment:''' The druid should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' None.\n\n'''Special Hindrances:''' Local authorities are always hunting for Outlaws like Mackay. Capture means imprisonment—or worse.\n\n'''Wealth Options:''' 3d6x10 gp.\n\n{{Navbox The Complete Druid's Handbook}}"
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
                recommended: ["scimitar", "sling", "staff"],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["set snares"],
                recommended: ["animal training", "brewing", "rope use", "singing", "weather sense", "healing", "herbalism", "local history", "religion", "(rogue", "double slot) disguise", "animal lore", "tracking"],
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

let embeddedKit049: Kit = Kit(
        id: "outlaw_priest",
        name: "Outlaw Priest",
        wikiPageTitle: "Outlaw Priest (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "This sort of priest has one of two roles, depending on the situation. # With the first situation mentioned above, the priest has joined an outlaw or pirate band. In the campaign, then, he's the rogue priest who has decided that the band deserves his priestly guidance, and that this is more important than the demands of his priestly order. The priest either agrees with the band's outlaw activities or ignores them; his concern is that they receive the blessings of his god. Perhaps, too, he thinks that they'll be a more ethical group with him around; he may be present to keep them from performing acts of brutality or rapine, which they might undertake were he not present. # In the second situation mentioned above, the priest is a rogue visionary who thinks that he must serve his god in a way not approved of by the normal priesthood. This character is probably someone who went through the temple's normal priestly training, decided that there was something wrong or lacking in it, and set out to found his own order. A classic example of this is the situation where a priesthood has become corrupt and lazy, and a reformer priest has appeared to try to return the worship of the god to its former honorable state; the corrupt priests naturally wish to maintain the status quo.",
            requirements: nil,
            specialBenefits: "The main benefit of this kit is that the priest does not have any superiors. He takes orders from no superior religious authority (unless the god himself chooses to issue some).",
            specialHindrances: "The outlaw priest is opposed by the normal priestly order serving his god. When they hear of his plans, they try to thwart them (break up religious meetings, disrupt building of his temple, etc.). This priest never gets to build a temple at cut-rate prices; he must always spend the whole amount to build his temple. (If he ever abandons his kit, the regular priesthood may accept his temple as one belonging to the priesthood, but will never recompense him half the money it took to build it.) If the outlaw priest is part of an outlaw or pirate band, he is sought by the same authorities that seek that band, and will pay the same penalties under the law as they do if he is caught.",
            wealthOptions: "Outlaw priests get the standard 3d6x10 gp for starting gold.",
            weaponProficiencies: "Required: None. Recommended: If Pirate, cutlass*, belaying pin*, bill. If Outlaw, weapon choices appropriate for the outlaw band. (The \"*\" symbol refers to weapons introduced in ''The Complete Fighter's Handbook''.)",
            nonweaponProficiencies: "Bonus Proficiency: Religion.",
            equipment: "No restrictions. Within the context of the campaign, if this is a pirate or outlaw band, it's a bad idea to wear metal armor (banded, brigandine, bronze plate, chain, field plate, full plate, plate mail, and ring mail). Metal armor drags pirates down to their deaths when they fall overboard; and it's noisy when worn by outlaws trying to ambush their prey. But this is just a factor the DM needs to remember, not a restriction on the kit."
        ),
        description: KitDescription(
            briefSummary: "This priest has decided to become part of some sort of outlaw community and serve that community's religious needs. The trouble is, for the character to take this kit, this group or community must be sufficiently outlawed that the priesthood in question does not approve of it.",
            fullText: "## Outlaw Priest\n**Description:** This priest has decided to become part of some sort of outlaw community and serve that community's religious needs. The trouble is, for the character to take this kit, this group or community must be sufficiently outlawed that the priesthood in question does not approve of it. Alternatively, the priest may have decided that the god's priesthood is not serving him in an appropriate way, and he will have decided to create his own priestly order serving the same god. In this case, too, the regular priesthood does not approve of him. In either case, the priest must believe that he is still serving the god in a fashion that the god approves of. (The DM, obviously, must agree.)\n\nFriar Tuck, the cleric who tended to Robin Hood's Merry Men, is the classic example of this type of priest.\n\nThis priest, in the pursuit of his duties, is opposed by other priests serving the same god. In addition, if he's identified himself with an outlaw or pirate band, he'll be wanted by the authorities as a member of that band.\n\nThere are no special ability-score requirements to be an Outlaw Priest.\n\nA priest abandons this kit by leaving the outlaw band or opposing/disbanding the new religious order, whichever is pertinent. Additionally, by role-playing in the campaign, he must answer all the charges pressed against him by the authorities (he might do this by being tried and going to prison for a time, or paying reparations, or accepting tasks of penance from his temple); if he does not, he will continue to be opposed by his temple and wanted by the authorities.\n\n**Barred:** Priests of the gods of Community may not take this kit. Priests of no Philosophy or Force may take this kit. (They can associate themselves with pirate or outlaw bands, but there is no censure within their orders because of it, and therefore no disadvantage to belonging to such a band.)\n\n**Role:** This sort of priest has one of two roles, depending on the situation.\n\n# With the first situation mentioned above, the priest has joined an outlaw or pirate band. In the campaign, then, he's the rogue priest who has decided that the band deserves his priestly guidance, and that this is more important than the demands of his priestly order. The priest either agrees with the band's outlaw activities or ignores them; his concern is that they receive the blessings of his god. Perhaps, too, he thinks that they'll be a more ethical group with him around; he may be present to keep them from performing acts of brutality or rapine, which they might undertake were he not present.\n# In the second situation mentioned above, the priest is a rogue visionary who thinks that he must serve his god in a way not approved of by the normal priesthood. This character is probably someone who went through the temple's normal priestly training, decided that there was something wrong or lacking in it, and set out to found his own order. A classic example of this is the situation where a priesthood has become corrupt and lazy, and a reformer priest has appeared to try to return the worship of the god to its former honorable state; the corrupt priests naturally wish to maintain the *status quo*.\n\n**Secondary Skills:** The priest can choose his own secondary skill. If he's part of a pirate band, he may wish to choose Sailor, Shipwright or Navigator. If he's part of a landbound outlaw band, he might choose Forester, Hunter, or Trapper/Furrier. He may decide on none of these and make a decision based on his life before he entered the priesthood.\n\n**Weapon Proficiencies:** *Required:* None. *Recommended:* If Pirate, cutlass*, belaying pin*, bill. If Outlaw, weapon choices appropriate for the outlaw band. (The \"*\" symbol refers to weapons introduced in *The Complete Fighter's Handbook*.)\n\n**Nonweapon Proficiencies:** *Bonus Proficiency:* Religion.\n\n**Recommended Proficiencies (Pirate Priest):** Pirate's\n* *Bonus Proficiencies:* (General) Rope Use, Seamanship, Swimming, Weather Sense, (Warrior, double slots unless priest-class dictates otherwise) Navigation, (Priest) Engineering (for shipbuilding), Reading/Writing (for mapmaking), (Rogue, double slots unless priest-class dictates otherwise) Appraising, Set Snares (in association with Rope Use skill), Tightrope Walking, Tumbling, (Wizard, double slots unless priest-class dictates otherwise) Engineering (for shipbuilding), Reading/Writing (for mapmaking).\n\n**Recommended Proficiencies (Outlaw Priest):** (General) Direction Sense, Fire-Building, Riding (Land-Based), (Warrior, double slots unless priest-class dictates otherwise) Animal Lore, Bowyer/Fletcher, Endurance, Hunting, Running, Set Snares, Survival, Tracking, (Priest) Healing, Herbalism, Local History, (Rogue, double slots unless priest-class dictates otherwise) Disguise.\n\n**Equipment:** No restrictions. Within the context of the campaign, if this is a pirate or outlaw band, it's a bad idea to wear metal armor (banded, brigandine, bronze plate, chain, field plate, full plate, plate mail, and ring mail). Metal armor drags pirates down to their deaths when they fall overboard; and it's noisy when worn by outlaws trying to ambush their prey. But this is just a factor the DM needs to remember, not a restriction on the kit.\n\n**Special Benefits:** The main benefit of this kit is that the priest does not have any superiors. He takes orders from no superior religious authority (unless the god himself chooses to issue some).\n\n**Special Hindrances:** The outlaw priest is opposed by the normal priestly order serving his god. When they hear of his plans, they try to thwart them (break up religious meetings, disrupt building of his temple, etc.). This priest never gets to build a temple at cut-rate prices; he must always spend the whole amount to build his temple. (If he ever abandons his kit, the regular priesthood may accept his temple as one belonging to the priesthood, but will never recompense him half the money it took to build it.) If the outlaw priest is part of an outlaw or pirate band, he is sought by the same authorities that seek that band, and will pay the same penalties under the law as they do if he is caught.\n\n**Wealth Options:** Outlaw priests get the standard 3d6x10 gp for starting gold.\n\n**Races:** No special restrictions.",
            rawWikitext: "{{For|other Outlaw Character Kits|Outlaw}}\n{{Sidebar CPrH Ch4}}__NOTOC__\n==Outlaw Priest==\n'''Description:''' This priest has decided to become part of some sort of outlaw community and serve that community's religious needs. The trouble is, for the character to take this kit, this group or community must be sufficiently outlawed that the priesthood in question does not approve of it. Alternatively, the priest may have decided that the god's priesthood is not serving him in an appropriate way, and he will have decided to create his own priestly order serving the same god. In this case, too, the regular priesthood does not approve of him. In either case, the priest must believe that he is still serving the god in a fashion that the god approves of. (The DM, obviously, must agree.)\n\nFriar Tuck, the cleric who tended to Robin Hood's Merry Men, is the classic example of this type of priest.\n\nThis priest, in the pursuit of his duties, is opposed by other priests serving the same god. In addition, if he's identified himself with an outlaw or pirate band, he'll be wanted by the authorities as a member of that band.\n\nThere are no special ability-score requirements to be an Outlaw Priest.\n\nA priest abandons this kit by leaving the outlaw band or opposing/disbanding the new religious order, whichever is pertinent. Additionally, by role-playing in the campaign, he must answer all the charges pressed against him by the authorities (he might do this by being tried and going to prison for a time, or paying reparations, or accepting tasks of penance from his temple); if he does not, he will continue to be opposed by his temple and wanted by the authorities.\n\n'''Barred:''' Priests of the gods of Community may not take this kit. Priests of no Philosophy or Force may take this kit. (They can associate themselves with pirate or outlaw bands, but there is no censure within their orders because of it, and therefore no disadvantage to belonging to such a band.)\n\n'''Role:''' This sort of priest has one of two roles, depending on the situation.\n\n# With the first situation mentioned above, the priest has joined an outlaw or pirate band. In the campaign, then, he's the rogue priest who has decided that the band deserves his priestly guidance, and that this is more important than the demands of his priestly order. The priest either agrees with the band's outlaw activities or ignores them; his concern is that they receive the blessings of his god. Perhaps, too, he thinks that they'll be a more ethical group with him around; he may be present to keep them from performing acts of brutality or rapine, which they might undertake were he not present.\n# In the second situation mentioned above, the priest is a rogue visionary who thinks that he must serve his god in a way not approved of by the normal priesthood. This character is probably someone who went through the temple's normal priestly training, decided that there was something wrong or lacking in it, and set out to found his own order. A classic example of this is the situation where a priesthood has become corrupt and lazy, and a reformer priest has appeared to try to return the worship of the god to its former honorable state; the corrupt priests naturally wish to maintain the ''status quo''.\n\n'''Secondary Skills:''' The priest can choose his own secondary skill. If he's part of a pirate band, he may wish to choose Sailor, Shipwright or Navigator. If he's part of a landbound outlaw band, he might choose Forester, Hunter, or Trapper/Furrier. He may decide on none of these and make a decision based on his life before he entered the priesthood.\n\n'''Weapon Proficiencies:''' ''Required:'' None. ''Recommended:'' If Pirate, cutlass*, belaying pin*, bill. If Outlaw, weapon choices appropriate for the outlaw band. (The \"*\" symbol refers to weapons introduced in ''The Complete Fighter's Handbook''.)\n\n'''Nonweapon Proficiencies:''' ''Bonus Proficiency:'' [[Religion (Proficiency)|Religion]].\n\n'''Recommended Proficiencies (Pirate Priest):''' Pirate's\n* ''Bonus Proficiencies:'' (General) [[Rope Use (Proficiency)|Rope Use]], [[Seamanship (Proficiency)|Seamanship]], [[Swimming (Proficiency)|Swimming]], [[Weather Sense (Proficiency)|Weather Sense]], (Warrior, double slots unless priest-class dictates otherwise) [[Navigation (Proficiency)|Navigation]], (Priest) [[Engineering (Proficiency)|Engineering]] (for shipbuilding), [[Reading/Writing (Proficiency)|Reading/Writing]] (for mapmaking), (Rogue, double slots unless priest-class dictates otherwise) [[Appraising (Proficiency)|Appraising]], [[Set Snares (Proficiency)|Set Snares]] (in association with Rope Use skill), [[Tightrope Walking (Proficiency)|Tightrope Walking]], [[Tumbling (Proficiency)|Tumbling]], (Wizard, double slots unless priest-class dictates otherwise) [[Engineering (Proficiency)|Engineering]] (for shipbuilding), [[Reading/Writing (Proficiency)|Reading/Writing]] (for mapmaking).\n\n'''Recommended Proficiencies (Outlaw Priest):''' (General) [[Direction Sense (Proficiency)|Direction Sense]], [[Fire-building (Proficiency)|Fire-Building]], [[Riding, Land-Based (Proficiency)|Riding (Land-Based)]], (Warrior, double slots unless priest-class dictates otherwise) [[Animal Lore (Proficiency)|Animal Lore]], [[Bowyer/Fletcher (Proficiency)|Bowyer/Fletcher]], [[Endurance (Proficiency)|Endurance]], [[Hunting (Proficiency)|Hunting]], [[Running (Proficiency)|Running]], [[Set Snares (Proficiency)|Set Snares]], [[Survival (Proficiency)|Survival]], [[Tracking (Proficiency)|Tracking]], (Priest) [[Healing (Proficiency)|Healing]], [[Herbalism (Proficiency)|Herbalism]], [[Local History (Proficiency)|Local History]], (Rogue, double slots unless priest-class dictates otherwise) [[Disguise (Proficiency)|Disguise]].\n\n'''Equipment:''' No restrictions. Within the context of the campaign, if this is a pirate or outlaw band, it's a bad idea to wear metal armor (banded, brigandine, bronze plate, chain, field plate, full plate, plate mail, and ring mail). Metal armor drags pirates down to their deaths when they fall overboard; and it's noisy when worn by outlaws trying to ambush their prey. But this is just a factor the DM needs to remember, not a restriction on the kit.\n\n'''Special Benefits:''' The main benefit of this kit is that the priest does not have any superiors. He takes orders from no superior religious authority (unless the god himself chooses to issue some).\n\n'''Special Hindrances:''' The outlaw priest is opposed by the normal priestly order serving his god. When they hear of his plans, they try to thwart them (break up religious meetings, disrupt building of his temple, etc.). This priest never gets to build a temple at cut-rate prices; he must always spend the whole amount to build his temple. (If he ever abandons his kit, the regular priesthood may accept his temple as one belonging to the priesthood, but will never recompense him half the money it took to build it.) If the outlaw priest is part of an outlaw or pirate band, he is sought by the same authorities that seek that band, and will pay the same penalties under the law as they do if he is caught.\n\n'''Wealth Options:''' Outlaw priests get the standard 3d6x10 gp for starting gold.\n\n'''Races:''' No special restrictions.\n\n{{Navbox The Complete Priest's Handbook}}\n[[Category:Character Kit]]\n[[Category:Character Kit CPrH]]"
        ),
        categories: ["Character Kit", "Character Kit CPrH"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: [:],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["cutlass"],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Proficiency: Religion"],
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
            startingCash: "3d6x10 gp"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit050: Kit = Kit(
        id: "pacifist_druid",
        name: "Pacifist Druid",
        wikiPageTitle: "Pacifist Druid (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "The restrictions on the druid's actions (below) make this a challenging role to play, and one that works best within a party of good-aligned adventurers. To give the player of a Pacifist druid a chance to shine, the DM should design adventures in which the character can help negotiate a diplomatic settlement of a crisis between neighboring lords or where party members sometimes can win over opponents by negotiation or moral persuasion. For example, suppose a tribe of goblins menaces human lands. The DM alone knows that the goblins actually were displaced from their old caverns by an evil vampire and would return home if someone destroyed the vampire. A scenario like this gives a clever Pacifist druid, such as Lark (above) a chance to talk to the goblins, discover why they intruded into human land, then convince the party to ally with them against the vampire.",
            requirements: nil,
            specialBenefits: "The Pacifist druid can use some or all of her weapon proficiency slots to buy nonweapon proficiencies. Pacifists such as Lark have the ability to speak soothing words to ease tempers and calm savage beasts. This power can remove the effects of a fear spell, calm an enraged animal, or pacify a hostile crowd. Lark can use this power a number of times per day equal to her experience level. Using soothing words accomplishes one of the following: * Negates one fear spell (or similar monster ability) on a single victim; * Halts a single creature's berserker rage; or * Temporarily calms down a number of animals, characters, or monsters (whose combined levels or Hit Dice total no more than twice the druid's level). A calmed group usually remains calm for 1d4+1 rounds, as long as others refrain from hostile action against them, their allies, or their property. During this time, the druid or others can attempt to escape or to negotiate a resolution to the situation.",
            specialHindrances: "You, the player, must role-play this druid as a strict pacifist. A character like Lark does not totally oppose others who do harm when necessary—after all, animals kill for food. However, she never injures a person or animal herself. In addition, she encourages her companions to use the minimum required force during encounters: to ask foes to surrender before attacking them, let retreating enemies flee if she thinks they won't be a menace again, and so on. Use of herbal brews or magic that does not permanently harm enemies is perfectly appropriate. For instance, Lark can entangle foes, turn them into trees, use sleeping poison, etc. However, she absolutely refuses to let harm come to captives or innocents under her care; in fact, she uses her powers and risks her life to protect them. The Pacifist druid's code against violence does not extend to evil undead. These creatures are already dead but need help finding their rest; in other words, the druid will destroy them. Like all Pacifists, Lark eats only vegetarian meals. (You, the player, decide whether your Pacifist character eats fish.) She won't prevent others from eating meat, but usually expresses disapproval. High-level Pacifists find themselves disadvantaged when attempting to advance a level, as winning a druidic challenge usually requires violent behavior. However, if Lark wanted to even up her chances in the challenge, she either could get her opponent to agree to a nonviolent contest, or she could win using harmless tricks or magic. Finally, the player cannot roll or choose the following secondary skills: armorer, hunter, trapper/furrier, or weaponsmith.",
            wealthOptions: "3d6x10 gp.",
            weaponProficiencies: "Recommended—staff.",
            nonweaponProficiencies: "* Bonus—healing. * Recommended—(general) brewing, cooking; (priest) herbalism, religion, spellcraft; (warrior) animal lore, survival.",
            equipment: "A Pacifist like Lark can purchase no weapons except darts or a staff. She should spend her entire initial allotment of gold pieces on equipment, as she loses unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "The Pacifist druid believes in the sanctity of all life, but especially that of creatures with animal Intelligence or higher.",
            fullText: "## Pacifist\nThe Pacifist druid believes in the sanctity of all life, but especially that of creatures with animal Intelligence or higher.\n\n**Role:** The restrictions on the druid's actions (below) make this a challenging role to play, and one that works best within a party of good-aligned adventurers. To give the player of a Pacifist druid a chance to shine, the DM should design adventures in which the character can help negotiate a diplomatic settlement of a crisis between neighboring lords or where party members sometimes can win over opponents by negotiation or moral persuasion.\n\nFor example, suppose a tribe of goblins menaces human lands. The DM alone knows that the goblins actually were displaced from their old caverns by an evil vampire and would return home if someone destroyed the vampire. A scenario like this gives a clever Pacifist druid, such as Lark (above) a chance to talk to the goblins, discover why they intruded into human land, then convince the party to ally with them against the vampire.\n\n**Branch Restrictions:** None.\n\n**Weapon Proficiencies:** *Recommended*—staff.\n\n**Secondary Skills:** Farmer, groom.\n\n**Nonweapon Proficiencies:**\n* *Bonus*—healing.\n* *Recommended*—(general) brewing, cooking; (priest) herbalism, religion, spellcraft; (warrior) animal lore, survival.\n\n**Equipment:** A Pacifist like Lark can purchase no weapons except darts or a staff. She should spend her entire initial allotment of gold pieces on equipment, as she loses unspent starting money in excess of 1 gp.\n\n**Special Benefits:** The Pacifist druid can use some or all of her weapon proficiency slots to buy nonweapon proficiencies.\n\nPacifists such as Lark have the ability to speak soothing words to ease tempers and calm savage beasts. This power can remove the effects of a *fear* spell, calm an enraged animal, or pacify a hostile crowd. Lark can use this power a number of times per day equal to her experience level. Using soothing words accomplishes one of the following:\n* Negates one *fear* spell (or similar monster ability) on a single victim;\n* Halts a single creature's berserker rage; or\n* Temporarily calms down a number of animals, characters, or monsters (whose combined levels or Hit Dice total no more than twice the druid's level). A calmed group usually remains calm for 1d4+1 rounds, as long as others refrain from hostile action against them, their allies, or their property. During this time, the druid or others can attempt to escape or to negotiate a resolution to the situation.\n\n**Special Hindrances:** You, the player, must role-play this druid as a strict pacifist. A character like Lark does not totally oppose others who do harm when necessary—after all, animals kill for food. However, she never injures a person or animal herself. In addition, she encourages her companions to use the minimum required force during encounters: to ask foes to surrender before attacking them, let retreating enemies flee if she thinks they won't be a menace again, and so on.\n\nUse of herbal brews or magic that does not permanently harm enemies is perfectly appropriate. For instance, Lark can *entangle* foes, turn them into trees, use sleeping poison, etc. However, she absolutely refuses to let harm come to captives or innocents under her care; in fact, she uses her powers and risks her life to protect them.\n\nThe Pacifist druid's code against violence does not extend to evil undead. These creatures are already dead but need help finding their rest; in other words, the druid will destroy them.\n\nLike all Pacifists, Lark eats only vegetarian meals. (You, the player, decide whether your Pacifist character eats fish.) She won't prevent others from eating meat, but usually expresses disapproval.\n\nHigh-level Pacifists find themselves disadvantaged when attempting to advance a level, as winning a druidic challenge usually requires violent behavior. However, if Lark wanted to even up her chances in the challenge, she either could get her opponent to agree to a nonviolent contest, or she could win using harmless tricks or magic.\n\nFinally, the player cannot roll or choose the following secondary skills: armorer, hunter, trapper/furrier, or weaponsmith.\n\n**Wealth Options:** 3d6x10 gp.",
            rawWikitext: "{{Sidebar CDH Ch2}}__NOTOC__\n==Pacifist==\nThe Pacifist druid believes in the sanctity of all life, but especially that of creatures with animal Intelligence or higher.\n\n'''Role:''' The restrictions on the druid's actions (below) make this a challenging role to play, and one that works best within a party of good-aligned adventurers. To give the player of a Pacifist druid a chance to shine, the DM should design adventures in which the character can help negotiate a diplomatic settlement of a crisis between neighboring lords or where party members sometimes can win over opponents by negotiation or moral persuasion.\n\nFor example, suppose a tribe of goblins menaces human lands. The DM alone knows that the goblins actually were displaced from their old caverns by an evil vampire and would return home if someone destroyed the vampire. A scenario like this gives a clever Pacifist druid, such as Lark (above) a chance to talk to the goblins, discover why they intruded into human land, then convince the party to ally with them against the vampire.\n\n'''Branch Restrictions:''' None.\n\n'''Weapon Proficiencies:''' ''Recommended''—staff.\n\n'''Secondary Skills:''' Farmer, groom.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus''—[[Healing (Proficiency)|healing]].\n* ''Recommended''—(general) [[Brewing (Proficiency)|brewing]], [[Cooking (Proficiency)|cooking]]; (priest) [[Herbalism (Proficiency)|herbalism]], [[Religion (Proficiency)|religion]], [[Spellcraft (Proficiency)|spellcraft]]; (warrior) [[Animal Lore (Proficiency)|animal lore]], [[Survival (Proficiency)|survival]].\n\n'''Equipment:''' A Pacifist like Lark can purchase no weapons except darts or a staff. She should spend her entire initial allotment of gold pieces on equipment, as she loses unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' The Pacifist druid can use some or all of her weapon proficiency slots to buy nonweapon proficiencies.\n\nPacifists such as Lark have the ability to speak soothing words to ease tempers and calm savage beasts. This power can remove the effects of a ''fear'' spell, calm an enraged animal, or pacify a hostile crowd. Lark can use this power a number of times per day equal to her experience level. Using soothing words accomplishes one of the following:\n* Negates one ''fear'' spell (or similar monster ability) on a single victim;\n* Halts a single creature's berserker rage; or\n* Temporarily calms down a number of animals, characters, or monsters (whose combined levels or Hit Dice total no more than twice the druid's level). A calmed group usually remains calm for 1d4+1 rounds, as long as others refrain from hostile action against them, their allies, or their property. During this time, the druid or others can attempt to escape or to negotiate a resolution to the situation.\n\n'''Special Hindrances:''' You, the player, must role-play this druid as a strict pacifist. A character like Lark does not totally oppose others who do harm when necessary—after all, animals kill for food. However, she never injures a person or animal herself. In addition, she encourages her companions to use the minimum required force during encounters: to ask foes to surrender before attacking them, let retreating enemies flee if she thinks they won't be a menace again, and so on.\n\nUse of herbal brews or magic that does not permanently harm enemies is perfectly appropriate. For instance, Lark can ''entangle'' foes, turn them into trees, use sleeping poison, etc. However, she absolutely refuses to let harm come to captives or innocents under her care; in fact, she uses her powers and risks her life to protect them.\n\nThe Pacifist druid's code against violence does not extend to evil undead. These creatures are already dead but need help finding their rest; in other words, the druid will destroy them.\n\nLike all Pacifists, Lark eats only vegetarian meals. (You, the player, decide whether your Pacifist character eats fish.) She won't prevent others from eating meat, but usually expresses disapproval.\n\nHigh-level Pacifists find themselves disadvantaged when attempting to advance a level, as winning a druidic challenge usually requires violent behavior. However, if Lark wanted to even up her chances in the challenge, she either could get her opponent to agree to a nonviolent contest, or she could win using harmless tricks or magic.\n\nFinally, the player cannot roll or choose the following secondary skills: armorer, hunter, trapper/furrier, or weaponsmith.\n\n'''Wealth Options:''' 3d6x10 gp.\n\n{{Navbox The Complete Druid's Handbook}}"
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
                recommended: ["staff"],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["healing"],
                recommended: ["brewing", "cooking", "herbalism", "religion", "spellcraft", "animal lore", "survival"],
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

let embeddedKit051: Kit = Kit(
        id: "pacifist_priest",
        name: "Pacifist Priest",
        wikiPageTitle: "Pacifist Priest (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "In a campaign, this priest can be a real aggravation to the more combat-oriented player-characters. Therefore, the DM should allow this priest in only the following situations: # When he's an NPC, so that the DM doesn't have to work to contrive to keep him with the party all the time (they'll have an easier time of abandoning him if they wish); # When he's part of a specific quest or mission (i.e., they must accompany him and guard him throughout the quest or it will automatically fail); or # When all the PCs are pacifists (this would be a very unusual campaign or quest, indeed...). Note, though, that just because the priest demands peacefulness of all around him, his allies don't have to obey. However, it is inevitable that in combat situations the player of the pacifist priest will feel left out (he can't fight); additionally, he'll feel compelled by his philosophy to argue with the other PCs, to chide them for their violence, which will get on their nerves. Therefore, the DM should keep such quests short, so that the pacifist priest doesn't drive the other characters to the point that they'll kill him.",
            requirements: nil,
            specialBenefits: "This priest is a very compelling personality. He receives a +2 to his Charisma score (his Charisma cannot exceed 18 from this bonus), and, in addition to any reaction bonus that his heightened Charisma gives him, he receives a +2 reaction from anyone who is not utterly opposed to his philosophy. (Beings opposed to his philosophy include priests and devoted adherents of the gods, forces and philosophies mentioned above under \"Barred,\" and certain warlike nonhuman races like orcs, ogres and trolls.)",
            specialHindrances: "This priest may never wear armor, and may never use weapons, spells or any other tactics to harm a human, demihuman, nonhuman, or monster. If he ever violates this decree, his god will not punish him (because the pacifist's oath is one he took for himself, not for his god), but his own guilt will deprive him of all magic spells for the span of one month. (If the DM wishes, if the priest is a follower of the god of Peace, the god can instead punish him as a \"Betrayal of Goals\" from the Role-Playing chapter.) Naturally, if he later abandons the kit, he can resume the wearing of armor and use of weapons according to his priest-class.",
            wealthOptions: "This priest gets the usual 3d6x10 gp.",
            weaponProficiencies: "The Pacifist Priest may not know any Weapon Proficiency except bow and dart, and may know them only if his true priest-class allows them. The priest may only use these weapons in competition, as described below under \"Special Hindrances.\" The priest still receives all his Weapon Proficiency slots, and if he ever abandons this kit may \"spend\" them at a rate of two slots every experience level.",
            nonweaponProficiencies: "Bonus Proficiency: Etiquette. * Recommended: Languages (Modern), Languages (Ancient), Ancient History, Singing, Musical Instrument, Reading/Writing.",
            equipment: "This priest may not buy any armor, and may not buy any weapon except dagger or knife (for eating only), and bow and dart (if he has proficiency with them)."
        ),
        description: KitDescription(
            briefSummary: "This priest is devoted to the cause of peace. He is a champion of passive resistance, of achieving one's ends without resorting to violence of any kind.",
            fullText: "## Pacifist Priest\n**Description:** This priest is devoted to the cause of peace. He is a champion of passive resistance, of achieving one's ends without resorting to violence of any kind.\n\nThere are no special requirements to be a priest of this sort. Nor are there special rules for abandonment of the kit, if the character eventually feels that he needs to be wielding force to achieve his ends.\n\n**Barred:** Priests of the following gods, forces and philosophies may not be Pacifist Priests: Disease, Evil, Justice/Revenge, War.\n\n**Role:** In a campaign, this priest can be a real aggravation to the more combat-oriented player-characters. Therefore, the DM should allow this priest in only the following situations:\n# When he's an NPC, so that the DM doesn't have to work to contrive to keep him with the party all the time (they'll have an easier time of abandoning him if they wish);\n# When he's part of a specific quest or mission (i.e., they must accompany him and guard him throughout the quest or it will automatically fail); or\n# When all the PCs are pacifists (this would be a very unusual campaign or quest, indeed...).\n\nNote, though, that just because the priest demands peacefulness of all around him, his allies don't have to obey. However, it is inevitable that in combat situations the player of the pacifist priest will feel left out (he can't fight); additionally, he'll feel compelled by his philosophy to argue with the other PCs, to chide them for their violence, which will get on their nerves. Therefore, the DM should keep such quests short, so that the pacifist priest doesn't drive the other characters to the point that they'll kill him.\n\n**Secondary Skills:** This priest may choose or random-roll his secondary skill. It may not be Armorer, Hunter, or Trapper/Furrier (if he rolls one of these up randomly, he may re-roll).\n\n**Weapon Proficiencies:** The Pacifist Priest may not know any Weapon Proficiency except bow and dart, and may know them only if his true priest-class allows them. The priest may only use these weapons in competition, as described below under \"Special Hindrances.\" The priest still receives all his Weapon Proficiency slots, and if he ever abandons this kit may \"spend\" them at a rate of two slots every experience level.\n\n**Nonweapon Proficiencies:** Bonus Proficiency: Etiquette.\n* *Recommended:* Languages (Modern), Languages (Ancient), Ancient History, Singing, Musical Instrument, Reading/Writing.\n\n**Equipment:** This priest may not buy any armor, and may not buy any weapon except dagger or knife (for eating only), and bow and dart (if he has proficiency with them).\n\n**Special Benefits:** This priest is a very compelling personality. He receives a +2 to his Charisma score (his Charisma cannot exceed 18 from this bonus), and, in addition to any reaction bonus that his heightened Charisma gives him, he receives a +2 reaction from anyone who is not utterly opposed to his philosophy. (Beings opposed to his philosophy include priests and devoted adherents of the gods, forces and philosophies mentioned above under \"Barred,\" and certain warlike nonhuman races like orcs, ogres and trolls.) \n\n**Special Hindrances:** This priest may never wear armor, and may never use weapons, spells or any other tactics to harm a human, demihuman, nonhuman, or monster. If he ever violates this decree, his *god* will not punish him (because the pacifist's oath is one he took for himself, not for his god), but his own guilt will deprive him of all magic spells for the span of one month. (If the DM wishes, if the priest is a follower of the god of Peace, the god can instead punish him as a \"Betrayal of Goals\" from the **Role-Playing** chapter.) Naturally, if he later abandons the kit, he can resume the wearing of armor and use of weapons according to his priest-class.\n\n**Wealth Options:** This priest gets the usual 3d6x10 gp.\n\n**Races:** No special limitations.",
            rawWikitext: "{{Sidebar CPrH Ch4}}__NOTOC__\n==Pacifist Priest==\n'''Description:''' This priest is devoted to the cause of peace. He is a champion of passive resistance, of achieving one's ends without resorting to violence of any kind.\n\nThere are no special requirements to be a priest of this sort. Nor are there special rules for abandonment of the kit, if the character eventually feels that he needs to be wielding force to achieve his ends.\n\n'''Barred:''' Priests of the following gods, forces and philosophies may not be Pacifist Priests: Disease, Evil, Justice/Revenge, War.\n\n'''Role:''' In a campaign, this priest can be a real aggravation to the more combat-oriented player-characters. Therefore, the DM should allow this priest in only the following situations:\n# When he's an NPC, so that the DM doesn't have to work to contrive to keep him with the party all the time (they'll have an easier time of abandoning him if they wish);\n# When he's part of a specific quest or mission (i.e., they must accompany him and guard him throughout the quest or it will automatically fail); or\n# When all the PCs are pacifists (this would be a very unusual campaign or quest, indeed...).\n\nNote, though, that just because the priest demands peacefulness of all around him, his allies don't have to obey. However, it is inevitable that in combat situations the player of the pacifist priest will feel left out (he can't fight); additionally, he'll feel compelled by his philosophy to argue with the other PCs, to chide them for their violence, which will get on their nerves. Therefore, the DM should keep such quests short, so that the pacifist priest doesn't drive the other characters to the point that they'll kill him.\n\n'''Secondary Skills:''' This priest may choose or random-roll his secondary skill. It may not be Armorer, Hunter, or Trapper/Furrier (if he rolls one of these up randomly, he may re-roll).\n\n'''Weapon Proficiencies:''' The Pacifist Priest may not know any Weapon Proficiency except bow and dart, and may know them only if his true priest-class allows them. The priest may only use these weapons in competition, as described below under \"Special Hindrances.\" The priest still receives all his Weapon Proficiency slots, and if he ever abandons this kit may \"spend\" them at a rate of two slots every experience level.\n\n'''Nonweapon Proficiencies:''' Bonus Proficiency: Etiquette.\n* ''Recommended:'' Languages (Modern), Languages (Ancient), Ancient History, Singing, Musical Instrument, Reading/Writing.\n\n'''Equipment:''' This priest may not buy any armor, and may not buy any weapon except dagger or knife (for eating only), and bow and dart (if he has proficiency with them).\n\n'''Special Benefits:''' This priest is a very compelling personality. He receives a +2 to his Charisma score (his Charisma cannot exceed 18 from this bonus), and, in addition to any reaction bonus that his heightened Charisma gives him, he receives a +2 reaction from anyone who is not utterly opposed to his philosophy. (Beings opposed to his philosophy include priests and devoted adherents of the gods, forces and philosophies mentioned above under \"Barred,\" and certain warlike nonhuman races like orcs, ogres and trolls.) \n\n'''Special Hindrances:''' This priest may never wear armor, and may never use weapons, spells or any other tactics to harm a human, demihuman, nonhuman, or monster. If he ever violates this decree, his ''god'' will not punish him (because the pacifist's oath is one he took for himself, not for his god), but his own guilt will deprive him of all magic spells for the span of one month. (If the DM wishes, if the priest is a follower of the god of Peace, the god can instead punish him as a \"Betrayal of Goals\" from the '''Role-Playing''' chapter.) Naturally, if he later abandons the kit, he can resume the wearing of armor and use of weapons according to his priest-class.\n\n'''Wealth Options:''' This priest gets the usual 3d6x10 gp.\n\n'''Races:''' No special limitations.\n\n{{Navbox The Complete Priest's Handbook}}\n[[Category:Character Kit]]\n[[Category:Character Kit CPrH]]"
        ),
        categories: ["Character Kit", "Character Kit CPrH"],
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
                notes: "The Pacifist Priest may not know any Weapon Proficiency except bow and dart, and may know them only if his true priest-class allows them. The priest may only use these weapons in competition, as described below under \"Special Hindrances.\" The priest still receives all his Weapon Proficiency slots, and if he ever abandons this kit may \"spend\" them at a rate of two slots every experience level."
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Proficiency: Etiquette"],
                recommended: ["Languages", "Languages", "Ancient History", "Singing", "Musical Instrument", "Reading/Writing"],
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
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit052: Kit = Kit(
        id: "pardoner",
        name: "Pardoner",
        wikiPageTitle: "Pardoner (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Outwardly, the Pardoner serves the Church as a reverent collector of alms, charity for the poor. Depending on his background, sophistication, and audience, he may appear a pious citizen, a priest, a monk, or even a member of a Military Order. He can quote scripture and the Canon of the Church with the fervor of a prophet, but the Pardoner's piety is only a clever facade. Through his knowledge of religion, he manipulates the faith of pious Christians for his own monetary gain. For a suitable donation, this rogue can provide any Christian with an indulgence signed by the Pope, or a multitude of holy relics, each accompanied by a certificate of authenticity. Though he claims that any donations will support the Church of the Holy Sepulcher, the Hospitaller's Orphanage in Jerusalem, or some other charitable institution—in reality, all contributions go directly into the Pardoner's velvet-lined pocket.",
            requirements: "Franks and Europeans—but not local Christians—may adopt this kit as either rogues or bards. Because this profession demands some background in religion and the practices of the Latin Church, the Pardoner must have Intelligence 13 and Charisma 15 (minimum for bards). Pardoners are neutral or evil. Those of good alignment would never tolerate the constant hypocrisy required for this profession. Because this kit might promote strife within an adventuring group (and thus shorten the PC's life span), it is best played as neutral with a strong dose of humor, or kept as NPCs only.",
            specialBenefits: "The Pardoner may choose nonweapon proficiencies available to priests with no penalty. His primary skill, however, is the ability to elicit donations. The rogue's ability is based on his percentage chance to pick pockets, modified by his loyalty base (up to +8% for 18 Charisma). Dexterity bonuses that apply to picking pockets never affect the chance to elicit donations. Those seeking to elicit more than a few dirhams per contributor incur penalties (-10% if eliciting 1-10 dinars; -25% if seeking a larger donation). The Pardoner's ability in this skill can never exceed 95% (including bonuses). As with the picking-pockets ability check, the DM decides the maximum amount a contributor can afford to donate; obviously, a Pardoner cannot extract a 25 gp donation from a peasant, regardless of his eloquence. For each level of ability, the Pardoner can locate and solicit from one likely contributor during each day.",
            specialHindrances: "The Pardoner is a wanderer, traveling from town to town before the local secular and religious authorities learn of his solicitations. He must approach a true cleric with caution, however, as any ordained priest of 4th level or higher can pierce the Pardoner's religious facade with a successful Wisdom check.",
            wealthOptions: "The Pardoner embarks on his career with the customary 2d6×10 gp. Category:Character Kit Category:Character Kit The Crusades Campaign Sourcebook",
            weaponProficiencies: "The Pardoner may learn any weapon appropriate for his disguise. While posing as a priest, he may use a mace or a staff. As an agent of the Hospitallers, he might carry a sword.",
            nonweaponProficiencies: "* Required: modern languages (Latin), read/write (Latin), religion. * Recommended: etiquette; ancient history, astrology, local history; appraising, disguise, forgery, reading lips, ventriloquism. * Forbidden: None.",
            equipment: "As with his weapon proficiencies, the Pardoner's current role determines his equipment. While posing as a priest, for instance, he would make sure to keep his copied or stolen vestments neat and authentic. All-important props, such as a Bible and crucifix, complete the charlatan's disguise."
        ),
        description: KitDescription(
            briefSummary: "Pardoner (Christian). A Pardoner poses as a priest or prophet to prey on the charity and faith of devout Christians. At a time when miracles and holy relics were commonplace, there was no way to prove that a bit of bone actually came from any given saint.",
            fullText: "## Pardoner (Rogue Kit)(Christian)\n**Pardoner** (Christian). A Pardoner poses as a priest or prophet to prey on the charity and faith of devout Christians. At a time when miracles and holy relics were commonplace, there was no way to prove that a bit of bone actually came from any given saint. Everyone knew that relics were powerless unless the owner had faith in their divine power. During the era of the Crusades, as we have seen, Christians had an abundance of faith. By the 13th century, these charlatans were a standard fixture of Medieval European life, offering everyone a holy relic or absolution from their sins—for the right price, of course. For inspiration for this kit, see Chaucer's Canterbury Tales.\n\n**Requirements:** Franks and Europeans—but not local Christians—may adopt this kit as either rogues or bards. Because this profession demands some background in religion and the practices of the Latin Church, the Pardoner must have Intelligence 13 and Charisma 15 (minimum for bards).\n\nPardoners are neutral or evil. Those of good alignment would never tolerate the constant hypocrisy required for this profession. Because this kit might promote strife within an adventuring group (and thus shorten the PC's life span), it is best played as neutral with a strong dose of humor, or kept as NPCs only.\n\n**Role:** Outwardly, the Pardoner serves the Church as a reverent collector of alms, charity for the poor. Depending on his background, sophistication, and audience, he may appear a pious citizen, a priest, a monk, or even a member of a Military Order. He can quote scripture and the Canon of the Church with the fervor of a prophet, but the Pardoner's piety is only a clever facade. Through his knowledge of religion, he manipulates the faith of pious Christians for his own monetary gain.\n\nFor a suitable donation, this rogue can provide any Christian with an indulgence signed by the Pope, or a multitude of holy relics, each accompanied by a certificate of authenticity. Though he claims that any donations will support the Church of the Holy Sepulcher, the Hospitaller's Orphanage in Jerusalem, or some other charitable institution—in reality, all contributions go directly into the Pardoner's velvet-lined pocket.\n\n**Weapon Proficiencies:** The Pardoner may learn any weapon appropriate for his disguise. While posing as a priest, he may use a mace or a staff. As an agent of the Hospitallers, he might carry a sword.\n\n**Nonweapon Proficiencies:**\n* *Required:* modern languages (Latin), read/write (Latin), religion.\n* *Recommended:* etiquette; ancient history, astrology, local history; appraising, disguise, forgery, reading lips, ventriloquism.\n* *Forbidden:* None.\n\n**Equipment:** As with his weapon proficiencies, the Pardoner's current role determines his equipment. While posing as a priest, for instance, he would make sure to keep his copied or stolen vestments neat and authentic. All-important props, such as a Bible and crucifix, complete the charlatan's disguise.\n\n**Special Benefits:** The Pardoner may choose nonweapon proficiencies available to priests with no penalty. His primary skill, however, is the ability to elicit donations. The rogue's ability is based on his percentage chance to pick pockets, modified by his loyalty base (up to +8% for 18 Charisma). Dexterity bonuses that apply to picking pockets never affect the chance to elicit donations. Those seeking to elicit more than a few dirhams per contributor incur penalties (-10% if eliciting 1-10 dinars; -25% if seeking a larger donation).\n\nThe Pardoner's ability in this skill can never exceed 95% (including bonuses). As with the picking-pockets ability check, the DM decides the maximum amount a contributor can afford to donate; obviously, a Pardoner cannot extract a 25 gp donation from a peasant, regardless of his eloquence. For each level of ability, the Pardoner can locate and solicit from one likely contributor during each day.\n\n**Special Hindrances:** The Pardoner is a wanderer, traveling from town to town before the local secular and religious authorities learn of his solicitations. He must approach a true cleric with caution, however, as any ordained priest of 4th level or higher can pierce the Pardoner's religious facade with a successful Wisdom check.\n\n**Wealth Options:** The Pardoner embarks on his career with the customary 2d6×10 gp.",
            rawWikitext: "{{Sidebar CrCS Ch3}}__NOTOC__\n==Pardoner (Rogue Kit)(Christian)==\n'''Pardoner''' (Christian). A Pardoner poses as a priest or prophet to prey on the charity and faith of devout Christians. At a time when miracles and holy relics were commonplace, there was no way to prove that a bit of bone actually came from any given saint. Everyone knew that relics were powerless unless the owner had faith in their divine power. During the era of the Crusades, as we have seen, Christians had an abundance of faith. By the 13th century, these charlatans were a standard fixture of Medieval European life, offering everyone a holy relic or absolution from their sins—for the right price, of course. For inspiration for this kit, see Chaucer's Canterbury Tales.\n\n'''Requirements:''' Franks and Europeans—but not local Christians—may adopt this kit as either rogues or bards. Because this profession demands some background in religion and the practices of the Latin Church, the Pardoner must have [[Intelligence]] 13 and [[Charisma]] 15 (minimum for bards).\n\nPardoners are neutral or evil. Those of good alignment would never tolerate the constant hypocrisy required for this profession. Because this kit might promote strife within an adventuring group (and thus shorten the PC's life span), it is best played as neutral with a strong dose of humor, or kept as NPCs only.\n\n'''Role:''' Outwardly, the Pardoner serves the Church as a reverent collector of alms, charity for the poor. Depending on his background, sophistication, and audience, he may appear a pious citizen, a priest, a monk, or even a member of a Military Order. He can quote scripture and the Canon of the Church with the fervor of a prophet, but the Pardoner's piety is only a clever facade. Through his knowledge of religion, he manipulates the faith of pious Christians for his own monetary gain.\n\nFor a suitable donation, this rogue can provide any Christian with an indulgence signed by the Pope, or a multitude of holy relics, each accompanied by a certificate of authenticity. Though he claims that any donations will support the Church of the Holy Sepulcher, the Hospitaller's Orphanage in Jerusalem, or some other charitable institution—in reality, all contributions go directly into the Pardoner's velvet-lined pocket.\n\n'''Weapon Proficiencies:''' The Pardoner may learn any weapon appropriate for his disguise. While posing as a priest, he may use a mace or a staff. As an agent of the Hospitallers, he might carry a sword.\n\n'''Nonweapon Proficiencies:'''\n* ''Required:'' [[Languages, Modern (Proficiency)|modern languages]] (Latin), [[Reading/Writing (Proficiency)|read/write]] (Latin), [[Religion (Proficiency)|religion]].\n* ''Recommended:'' [[Etiquette (Proficiency)|etiquette]]; [[Ancient History (Proficiency)|ancient history]], [[Astrology (Proficiency)|astrology]], [[Local History (Proficiency)|local history]]; [[Appraising (Proficiency)|appraising]], [[Disguise (Proficiency)|disguise]], [[Forgery (Proficiency)|forgery]], [[Reading Lips (Proficiency)|reading lips]], [[Ventriloquism (Proficiency)|ventriloquism]].\n* ''Forbidden:'' None.\n\n'''Equipment:''' As with his weapon proficiencies, the Pardoner's current role determines his equipment. While posing as a priest, for instance, he would make sure to keep his copied or stolen vestments neat and authentic. All-important props, such as a Bible and crucifix, complete the charlatan's disguise.\n\n'''Special Benefits:''' The Pardoner may choose nonweapon proficiencies available to priests with no penalty. His primary skill, however, is the ability to elicit donations. The rogue's ability is based on his percentage chance to pick pockets, modified by his loyalty base (up to +8% for 18 Charisma). Dexterity bonuses that apply to picking pockets never affect the chance to elicit donations. Those seeking to elicit more than a few dirhams per contributor incur penalties (-10% if eliciting 1-10 dinars; -25% if seeking a larger donation).\n\nThe Pardoner's ability in this skill can never exceed 95% (including bonuses). As with the picking-pockets ability check, the DM decides the maximum amount a contributor can afford to donate; obviously, a Pardoner cannot extract a 25 gp donation from a peasant, regardless of his eloquence. For each level of ability, the Pardoner can locate and solicit from one likely contributor during each day.\n\n'''Special Hindrances:''' The Pardoner is a wanderer, traveling from town to town before the local secular and religious authorities learn of his solicitations. He must approach a true cleric with caution, however, as any ordained priest of 4th level or higher can pierce the Pardoner's religious facade with a successful Wisdom check.\n\n'''Wealth Options:''' The Pardoner embarks on his career with the customary 2d6×10 gp.\n\n{{Navbox The Crusades Campaign Sourcebook}}\n[[Category:Character Kit]]\n[[Category:Character Kit The Crusades Campaign Sourcebook]]"
        ),
        categories: ["Character Kit", "Character Kit The Crusades Campaign Sourcebook"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 13, "Charisma": 15],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: "The Pardoner may learn any weapon appropriate for his disguise. While posing as a priest, he may use a mace or a staff. As an agent of the Hospitallers, he might carry a sword."
            ),
            proficiencies: KitProficiencyRules(
                bonus: [],
                recommended: ["etiquette", "ancient history", "astrology", "local history", "appraising", "disguise", "forgery", "reading lips", "ventriloquism"],
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
            startingCash: "2d6x10 gp"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit053: Kit = Kit(
        id: "peasant_priest",
        name: "Peasant Priest",
        wikiPageTitle: "Peasant Priest (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "In the campaign, the Peasant Priest devotes himself to the needs of the common man. If he's part of an adventuring party, he won't support any plans which endanger or exploit the peasants or serfs, and will try to recommend plans which advantage them. (For example, if the party wants to use the locals to help lure the dragon out of its cave, so that the locals will be the first ones flamed and eaten, the priest will object. But if the locals are to be along as support troops, and have information and chances of success and survival at least equal to the player-characters', he won't have any such objection.) He'll insist that treasures be shared with the locals of the area where the treasure was found. (Assuming that the treasure is split into even shares among party members, he'll insist that the local peasant community receive two shares, for example.) In a greedy or tight-fisted party, the party might refuse his requests, which doesn't mean the priest has to attack them or steal from them... but this will inevitably result in the priest becoming disillusioned with the party.",
            requirements: nil,
            specialBenefits: "The Peasant Priest always has shelter when he's in his own community; his own people will shelter him even from the land's rightful authorities. Among peasants of other communities, he cannot count on this benefit, but he receives a +2 reaction adjustment from all peasants.",
            specialHindrances: "The Peasant Hero's great limitation is described above under \"Equipment.\"",
            wealthOptions: "The Peasant Priest gets the standard 3d6x10 gp starting money. Of the money he receives, no more than 75 gp may be spent on goods other than weapons.",
            weaponProficiencies: "The player may choose his character's weapon proficiencies, subject to the limitations of the priest's actual priest-class. The DM may insist that the character start out the campaign only with proficiencies appropriate to a peasant, such as short sword, spear, bow, footman's weapons and the like; long swords (and bigger blades), horseman's weapons, exotic polearms, lances, tridents and the like are not. This should only be a restriction when the character is first created; afterwards, he can learn any weapon his priest-class allows him.",
            nonweaponProficiencies: "* Bonus Proficiencies: Agriculture or Fishing (player choice), Weather Sense or Animal Lore (player choice). * Recommended: Any of the General proficiencies.",
            equipment: "The Peasant Priest has restrictions on the way he spends his money. Other than weapons, with which he has no monetary limitation, he may own only one object worth as much as 15 gp, and other than that one object may own nothing worth more than 10 gp. He may never own more than 75 gp worth of (non-weapon) property at any one time. If he receives money or gifts which put him above that limit, he must give away money and possessions until once again he is within the 75 gp limitation."
        ),
        description: KitDescription(
            briefSummary: "The Peasant Priest is the antithesis of the Nobleman Priest above. He's a champion of the common man, and prefers serving the commoner to any association with nobles. He has taken a vow of poverty; he believes he should sacrifice his worldly goods to the glory of his deity.",
            fullText: "## Peasant Priest\n**Description:** The Peasant Priest is the antithesis of the Nobleman Priest above. He's a champion of the common man, and prefers serving the commoner to any association with nobles. He has taken a vow of poverty; he believes he should sacrifice his worldly goods to the glory of his deity.\n\nNote that the Peasant Priest need not have been born a peasant; he could have been born a nobleman and later abandoned that lifestyle and the privileges of his class.\n\nThere are no ability-score requirements to be a Peasant Priest.\n\nThere are no special rules for abandonment of this kit.\n\n**Barred:** Priests of the following gods, forces, and philosophies may not take this kit: Evil, Good, Prosperity.\n\n**Role:** In the campaign, the Peasant Priest devotes himself to the needs of the common man. If he's part of an adventuring party, he won't support any plans which endanger or exploit the peasants or serfs, and will try to recommend plans which advantage them. (For example, if the party wants to use the locals to help lure the dragon out of its cave, so that the locals will be the first ones flamed and eaten, the priest will object. But if the locals are to be along as support troops, and have information and chances of success and survival at least equal to the player-characters', he won't have any such objection.) He'll insist that treasures be shared with the locals of the area where the treasure was found. (Assuming that the treasure is split into even shares among party members, he'll insist that the local peasant community receive two shares, for example.) In a greedy or tight-fisted party, the party might refuse his requests, which doesn't mean the priest has to attack them or steal from them... but this will inevitably result in the priest becoming disillusioned with the party.\n\n**Secondary Skills:** The player may choose his priest's secondary skill.\n\n**Weapon Proficiencies:** The player may choose his character's weapon proficiencies, subject to the limitations of the priest's actual priest-class. The DM may insist that the character start out the campaign only with proficiencies appropriate to a peasant, such as short sword, spear, bow, footman's weapons and the like; long swords (and bigger blades), horseman's weapons, exotic polearms, lances, tridents and the like are not. This should only be a restriction when the character is first created; afterwards, he can learn any weapon his priest-class allows him.\n\n**Nonweapon Proficiencies:**\n* *Bonus Proficiencies:* Agriculture *or* Fishing (player choice), Weather Sense *or* Animal Lore (player choice).\n* *Recommended:* Any of the General proficiencies.\n\n**Equipment:** The Peasant Priest has restrictions on the way he spends his money. Other than weapons, with which he has no monetary limitation, he may own only one object worth as much as 15 gp, and other than that one object may own nothing worth more than 10 gp. He may never own more than 75 gp worth of (non-weapon) property at any one time. If he receives money or gifts which put him above that limit, he must give away money and possessions until once again he is within the 75 gp limitation.\n\n**Special Benefits:** The Peasant Priest always has shelter when he's in his own community; his own people will shelter him even from the land's rightful authorities. Among peasants of other communities, he cannot count on this benefit, but he receives a +2 reaction adjustment from all peasants.\n\n**Special Hindrances:** The Peasant Hero's great limitation is described above under \"Equipment.\"\n\n**Wealth Options:** The Peasant Priest gets the standard 3d6x10 gp starting money. Of the money he receives, no more than 75 gp may be spent on goods other than weapons.\n\n**Races:** No special limitation.",
            rawWikitext: "{{Sidebar CPrH Ch4}}__NOTOC__\n==Peasant Priest==\n'''Description:''' The Peasant Priest is the antithesis of the Nobleman Priest above. He's a champion of the common man, and prefers serving the commoner to any association with nobles. He has taken a vow of poverty; he believes he should sacrifice his worldly goods to the glory of his deity.\n\nNote that the Peasant Priest need not have been born a peasant; he could have been born a nobleman and later abandoned that lifestyle and the privileges of his class.\n\nThere are no ability-score requirements to be a Peasant Priest.\n\nThere are no special rules for abandonment of this kit.\n\n'''Barred:''' Priests of the following gods, forces, and philosophies may not take this kit: Evil, Good, Prosperity.\n\n'''Role:''' In the campaign, the Peasant Priest devotes himself to the needs of the common man. If he's part of an adventuring party, he won't support any plans which endanger or exploit the peasants or serfs, and will try to recommend plans which advantage them. (For example, if the party wants to use the locals to help lure the dragon out of its cave, so that the locals will be the first ones flamed and eaten, the priest will object. But if the locals are to be along as support troops, and have information and chances of success and survival at least equal to the player-characters', he won't have any such objection.) He'll insist that treasures be shared with the locals of the area where the treasure was found. (Assuming that the treasure is split into even shares among party members, he'll insist that the local peasant community receive two shares, for example.) In a greedy or tight-fisted party, the party might refuse his requests, which doesn't mean the priest has to attack them or steal from them... but this will inevitably result in the priest becoming disillusioned with the party.\n\n'''Secondary Skills:''' The player may choose his priest's secondary skill.\n\n'''Weapon Proficiencies:''' The player may choose his character's weapon proficiencies, subject to the limitations of the priest's actual priest-class. The DM may insist that the character start out the campaign only with proficiencies appropriate to a peasant, such as short sword, spear, bow, footman's weapons and the like; long swords (and bigger blades), horseman's weapons, exotic polearms, lances, tridents and the like are not. This should only be a restriction when the character is first created; afterwards, he can learn any weapon his priest-class allows him.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus Proficiencies:'' Agriculture ''or'' Fishing (player choice), Weather Sense ''or'' Animal Lore (player choice).\n* ''Recommended:'' Any of the General proficiencies.\n\n'''Equipment:''' The Peasant Priest has restrictions on the way he spends his money. Other than weapons, with which he has no monetary limitation, he may own only one object worth as much as 15 gp, and other than that one object may own nothing worth more than 10 gp. He may never own more than 75 gp worth of (non-weapon) property at any one time. If he receives money or gifts which put him above that limit, he must give away money and possessions until once again he is within the 75 gp limitation.\n\n'''Special Benefits:''' The Peasant Priest always has shelter when he's in his own community; his own people will shelter him even from the land's rightful authorities. Among peasants of other communities, he cannot count on this benefit, but he receives a +2 reaction adjustment from all peasants.\n\n'''Special Hindrances:''' The Peasant Hero's great limitation is described above under \"Equipment.\"\n\n'''Wealth Options:''' The Peasant Priest gets the standard 3d6x10 gp starting money. Of the money he receives, no more than 75 gp may be spent on goods other than weapons.\n\n'''Races:''' No special limitation.\n\n{{Navbox The Complete Priest's Handbook}}\n[[Category:Character Kit]]\n[[Category:Character Kit CPrH]]"
        ),
        categories: ["Character Kit", "Character Kit CPrH"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: [:],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["short sword", "spear", "bow", "footman's weapons"],
                forbidden: [],
                notes: "The player may choose his character's weapon proficiencies, subject to the limitations of the priest's actual priest-class. The DM may insist that the character start out the campaign only with proficiencies appropriate to a peasant, such as short sword, spear, bow, footman's weapons and the like; long swords (and bigger blades), horseman's weapons, exotic polearms, lances, tridents and the like are not. This should only be a restriction when the character is first created; afterwards, he can learn any weapon his priest-class allows him."
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Agriculture or Fishing"],
                recommended: [],
                notes: "Weather Sense or Animal Lore ; Any of the General proficiencies."
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
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit054: Kit = Kit(
        id: "planewalker_priest",
        name: "Planewalker Priest",
        wikiPageTitle: "Planewalker Priest (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Moreso than their prime-material counterparts, planewalking priests are the direct representatives of their chosen deities. As they travel the planes, they act as the eyes, ears, and sometimes the manipulative hands of the powers they serve. As such, they develop relationships with folks throughout the Great Ring (and to some extent, the Inner Planes), malting friends and contacts wherever they go.",
            requirements: nil,
            specialBenefits: "Planewalking priests have two very different benefits. The first is simple and straightforward. Since they cannot rely on having spells to cast as they move about the planes, planewalker priests have honed their combat skills. On a plane where his spellcasting powers are diminished, a planewalker priest gains a +1 bonus to attack and damage rolls. Until after 10th level, this keeps the priest on a comparable (albeit still slightly weaker) standing with a fighter of similar level. Second, planewalker priests have contacts scattered throughout the planes. The player should pick three planes where his character knows someone. These contacts may be friends, mere acquaintances, or even bashers that the priest knows only through mutual acquaintances. Nevertheless, they can be sources of information and help. The DM should determine the exact location and nature of these contacts, possibly creating them as full-fledged NPCs.",
            specialHindrances: "Planewalker priests are frequently called upon to serve their powers directly on missions throughout the planes. Planewalker priests must obey any command of the proxies of their deity, who commonly give them tasks. Priests find themselves saddled with additional responsibilities and errands to run for their high-ups as they travel the planes. They also must keep a constant eye and ear on situations that may affect their power's domain or agenda.",
            wealthOptions: nil,
            weaponProficiencies: "As normal priests.",
            nonweaponProficiencies: "* Bonus—Etiquette. * Required—Local history (power's realm). * Recommended—Ancient history, planology, religion.",
            equipment: "As a normal priest."
        ),
        description: KitDescription(
            briefSummary: "Out on the planes, nobody's got to watch their backs more than priests. Sure, they've got a power backing them up, but that means they've got automatic enemies as well.",
            fullText: "Out on the planes, nobody's got to watch their backs more than priests. Sure, they've got a power backing them up, but that means they've got automatic enemies as well. A priest of Lathander is asking for a lot of extra trouble if he makes his way to Gehenna, just as a cleric of Morgion is going to have his hands full on Ysgard. (That doesn't mean priests can't travel to realms of gods that oppose their powers—it happens all the time. Sometimes a blood's just got to do what he's got to do).\n\nDepending on what plane they're on, priests are usually either the best or the least prepared of any planewalker. Planewalker priests know that their deities' power diminishes and increases depending on where they stand, and so they're prepared for these contingencies. A priest of St Cuthbert named Henton was known for saying that while some of his spells worked only some of the time on some of the planes, a cudgel applied forcefully to a berk's skull worked anytime, anywhere.\n\nLike other planewalkers, the real measure of a priest isn't so much what he can do as what (and who) he knows. Contacts are important to a planewalker priest, since he knows it's essential to remain well-lanned.\n\nPower keys are immeasurably helpful, but a body can't count on having them. In fact, planewalker priests have to learn not to count on their spells at all—they come and go with alarming regularity. Instead, scrolls and magical items become the priest's best friend, and in a fight, priests need to rely on weapons and normal combat skills.\n\nThis kit is appropriate for clerics and most specialty priests.\n\n**Role:** Moreso than their prime-material counterparts, planewalking priests are the direct representatives of their chosen deities. As they travel the planes, they act as the eyes, ears, and sometimes the manipulative hands of the powers they serve. As such, they develop relationships with folks throughout the Great Ring (and to some extent, the Inner Planes), malting friends and contacts wherever they go.\n\n**Weapon Proficiencies:** As normal priests.\n\n**Nonweapon Proficiencies:** \n* *Bonus*—Etiquette.\n* *Required*—Local history (power's realm).\n* *Recommended*—Ancient history, planology, religion.\n\n**Equipment:** As a normal priest.\n\n**Special Benefits:** Planewalking priests have two very different benefits. The first is simple and straightforward. Since they cannot rely on having spells to cast as they move about the planes, planewalker priests have honed their combat skills. On a plane where his spellcasting powers are diminished, a planewalker priest gains a +1 bonus to attack and damage rolls. Until after 10th level, this keeps the priest on a comparable (albeit still slightly weaker) standing with a fighter of similar level.\n\nSecond, planewalker priests have contacts scattered throughout the planes. The player should pick three planes where his character knows someone. These contacts may be friends, mere acquaintances, or even bashers that the priest knows only through mutual acquaintances. Nevertheless, they can be sources of information and help. The DM should determine the exact location and nature of these contacts, possibly creating them as full-fledged NPCs.\n\n**Special Hindrances:**Planewalker priests are frequently called upon to serve their powers directly on missions throughout the planes. Planewalker priests must obey any command of the proxies of their deity, who commonly give them tasks. Priests find themselves saddled with additional responsibilities and errands to run for their high-ups as they travel the planes. They also must keep a constant eye and ear on situations that may affect their power's domain or agenda.",
            rawWikitext: "{{Sidebar PWH Ch6}}__TOC__\nOut on the planes, nobody's got to watch their backs more than priests. Sure, they've got a power backing them up, but that means they've got automatic enemies as well. A priest of Lathander is asking for a lot of extra trouble if he makes his way to [[Gehenna (PWH)|Gehenna]], just as a cleric of Morgion is going to have his hands full on [[Ysgard (PWH)|Ysgard]]. (That doesn't mean priests can't travel to realms of gods that oppose their powers—it happens all the time. Sometimes a blood's just got to do what he's got to do).\n\nDepending on what plane they're on, priests are usually either the best or the least prepared of any planewalker. Planewalker priests know that their deities' power diminishes and increases depending on where they stand, and so they're prepared for these contingencies. A priest of St Cuthbert named Henton was known for saying that while some of his spells worked only some of the time on some of the planes, a cudgel applied forcefully to a berk's skull worked anytime, anywhere.\n\nLike other planewalkers, the real measure of a priest isn't so much what he can do as what (and who) he knows. Contacts are important to a planewalker priest, since he knows it's essential to remain well-lanned.\n\nPower keys are immeasurably helpful, but a body can't count on having them. In fact, planewalker priests have to learn not to count on their spells at all—they come and go with alarming regularity. Instead, scrolls and magical items become the priest's best friend, and in a fight, priests need to rely on weapons and normal combat skills.\n\nThis kit is appropriate for clerics and most specialty priests.\n\n'''Role:''' Moreso than their prime-material counterparts, planewalking priests are the direct representatives of their chosen deities. As they travel the planes, they act as the eyes, ears, and sometimes the manipulative hands of the powers they serve. As such, they develop relationships with folks throughout [[The Great Ring (PWH)|the Great Ring]] (and to some extent, the Inner Planes), malting friends and contacts wherever they go.\n\n'''Weapon Proficiencies:''' As normal priests.\n\n'''Nonweapon Proficiencies:''' \n* ''Bonus''—[[Etiquette (Proficiency)|Etiquette]].\n* ''Required''—[[Local History (Proficiency)|Local history]] (power's realm).\n* ''Recommended''—[[Ancient History (Proficiency)|Ancient history]], [[Planology (Proficiency)|planology]], [[Religion (Proficiency)|religion]].\n\n'''Equipment:''' As a normal priest.\n\n'''Special Benefits:''' Planewalking priests have two very different benefits. The first is simple and straightforward. Since they cannot rely on having spells to cast as they move about the planes, planewalker priests have honed their combat skills. On a plane where his spellcasting powers are diminished, a planewalker priest gains a +1 bonus to attack and damage rolls. Until after 10th level, this keeps the priest on a comparable (albeit still slightly weaker) standing with a fighter of similar level.\n\nSecond, planewalker priests have contacts scattered throughout the planes. The player should pick three planes where his character knows someone. These contacts may be friends, mere acquaintances, or even bashers that the priest knows only through mutual acquaintances. Nevertheless, they can be sources of information and help. The DM should determine the exact location and nature of these contacts, possibly creating them as full-fledged NPCs.\n\n'''Special Hindrances:'''Planewalker priests are frequently called upon to serve their powers directly on missions throughout the planes. Planewalker priests must obey any command of the proxies of their deity, who commonly give them tasks. Priests find themselves saddled with additional responsibilities and errands to run for their high-ups as they travel the planes. They also must keep a constant eye and ear on situations that may affect their power's domain or agenda.\n\n{{Navbox The Planewalker's Handbook}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: [:],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["As normal priests"],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Etiquette"],
                recommended: ["Ancient history", "planology", "religion"],
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

let embeddedKit055: Kit = Kit(
        id: "preacher",
        name: "Preacher",
        wikiPageTitle: "Preacher (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The preacher is most appropriate in campaigns set in the New World or in fantastic/historical campaigns where the supernatural regularly intrudes into the natural world.",
            requirements: "Wisdom 9+, non-evil alignment.",
            specialBenefits: "A preacher has the standard cleric's ability to turn undead. It extends beyond undead, however, to include all supernatural creatures. Against undead the preacher has full effectiveness, but against other supernatural creatures he has a -2 penalty on his die roll. Supernatural creatures are not physically turned, but instead are held at bay. They cannot attack the preacher or anyone else within 6 feet of him, neither can they approach within 10 feet of the preacher. If the result of the turning attempt was \"D,\" the creatures are not destroyed but must flee and cannot return for six hours. A preacher cannot cast spells as shown on Table 24 (page 33, PHB). Beginning at 2nd level, however, he can cast bonus spells that he earns for high Wisdom as shown on Table 5 (page 17, PHB). The character cannot cast spells beyond his experience level, as shown on Table 24. Also, these are spells he can cast per week rather than per day. A week always starts on Sunday and ends on Saturday. The preacher gains access to spheres as shown below.",
            specialHindrances: "A preacher is never allowed to conceal his religion or deceive people about it. He must tithe to the closest church of his religion. If Roman Catholic, he must do what he can to alleviate suffering and poverty. He must never take a life except in self defense.",
            wealthOptions: "A preacher starts the game with 2d6 x £4. Only chaotic preachers need to gamble £2 per month.",
            weaponProficiencies: "While preachers are not generally expected to fight, they can learn any weapon proficiencies.",
            nonweaponProficiencies: "* Required proficiencies: religion. * Recommended proficiencies: reading/writing, spellcraft.",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "The preacher is most likely a wandering priest or minister. He can serve any religion. His goal is to spread his faith, whether to non-Christians in the new world or heretics in Europe. He also confronts evil with the power of his faith and strives to protect the divine order in all things.",
            fullText: "## Preacher (Priest Kit)\nThe preacher is most likely a wandering priest or minister. He can serve any religion. His goal is to spread his faith, whether to non-Christians in the new world or heretics in Europe. He also confronts evil with the power of his faith and strives to protect the divine order in all things.\n\n**Requirements:** Wisdom 9+, non-evil alignment.\n\n**Role:** The preacher is most appropriate in campaigns set in the New World or in fantastic/historical campaigns where the supernatural regularly intrudes into the natural world.\n\n**Weapon Proficiencies:** While preachers are not generally expected to fight, they can learn any weapon proficiencies.\n\n**Nonweapon Proficiencies:**\n* *Required proficiencies:* religion.\n* *Recommended proficiencies:* reading/writing, spellcraft.\n\n**Armor/Weapons:** A preacher can wear any armor and use any sort of weapon, but carrying anything other than a dagger or pistol is considered odd and unusual.\n\n**Special Benefits:** A preacher has the standard cleric's ability to turn undead. It extends beyond undead, however, to include all supernatural creatures. Against undead the preacher has full effectiveness, but against other supernatural creatures he has a -2 penalty on his die roll.\n\nSupernatural creatures are not physically turned, but instead are held at bay. They cannot attack the preacher or anyone else within 6 feet of him, neither can they approach within 10 feet of the preacher. If the result of the turning attempt was \"D,\" the creatures are not destroyed but must flee and cannot return for six hours.\n\nA preacher cannot cast spells as shown on Table 24 (page 33, PHB). Beginning at 2nd level, however, he can cast bonus spells that he earns for high Wisdom as shown on Table 5 (page 17, PHB). The character cannot cast spells beyond his experience level, as shown on Table 24. Also, these are spells he can cast per week rather than per day. A week always starts on Sunday and ends on Saturday. The preacher gains access to spheres as shown below.\n\n{| class=\"article-table\"\n! Levels | Spheres\n|-\n| 2-3 | All\n|-\n| 4-5 | Charm<sup>1</sup>\n|-\n| 6-7 | Protection<sup>2</sup>\n|-\n| 8-9 | Divination<sup>3</sup>\n|-\n| 10+ | Healing\n|}\n: <sup>1</sup> Except *hold person*.\n: <sup>2</sup> Except *barkskin*.\n: <sup>3</sup> Only *detect magic*, *detect poison*, *augury*, *detect charm*, *locate object*, and *divination*.\n\n**Special Hindrances:** A preacher is never allowed to conceal his religion or deceive people about it. He must tithe to the closest church of his religion. If Roman Catholic, he must do what he can to alleviate suffering and poverty. He must never take a life except in self defense.\n\n**Wealth Option:** A preacher starts the game with 2d6 x £4. Only chaotic preachers need to gamble £2 per month.\n\n**Notes:** In a purely historical campaign with no real supernatural elements, preachers should not be allowed to cast spells at all. In games with very slight supernatural elements, DMs may limit preachers to one spell per day. In any event, assume that most of the spell effects are not magical at all, but the result of intimidation and self-fulfilling prophecies, brought about largely by the preacher's and observers' belief that they will happen.",
            rawWikitext: "{{Sidebar MFCS Ch3}}__NOTOC__\n==Preacher (Priest Kit)==\nThe preacher is most likely a wandering priest or minister. He can serve any religion. His goal is to spread his faith, whether to non-Christians in the new world or heretics in Europe. He also confronts evil with the power of his faith and strives to protect the divine order in all things.\n\n'''Requirements:''' [[Wisdom]] 9+, non-evil alignment.\n\n'''Role:''' The preacher is most appropriate in campaigns set in the New World or in fantastic/historical campaigns where the supernatural regularly intrudes into the natural world.\n\n'''Weapon Proficiencies:''' While preachers are not generally expected to fight, they can learn any weapon proficiencies.\n\n'''Nonweapon Proficiencies:'''\n* ''Required proficiencies:'' [[Religion (Proficiency)|religion]].\n* ''Recommended proficiencies:'' [[Reading/Writing (Proficiency)|reading/writing]], [[Spellcraft (Proficiency)|spellcraft]].\n\n'''Armor/Weapons:''' A preacher can wear any armor and use any sort of weapon, but carrying anything other than a dagger or pistol is considered odd and unusual.\n\n'''Special Benefits:''' A preacher has the standard cleric's ability to turn undead. It extends beyond undead, however, to include all supernatural creatures. Against undead the preacher has full effectiveness, but against other supernatural creatures he has a -2 penalty on his die roll.\n\nSupernatural creatures are not physically turned, but instead are held at bay. They cannot attack the preacher or anyone else within 6 feet of him, neither can they approach within 10 feet of the preacher. If the result of the turning attempt was \"D,\" the creatures are not destroyed but must flee and cannot return for six hours.\n\nA preacher cannot cast spells as shown on Table 24 (page 33, PHB). Beginning at 2nd level, however, he can cast bonus spells that he earns for high Wisdom as shown on Table 5 (page 17, PHB). The character cannot cast spells beyond his experience level, as shown on Table 24. Also, these are spells he can cast per week rather than per day. A week always starts on Sunday and ends on Saturday. The preacher gains access to spheres as shown below.\n\n{| class=\"article-table\"\n! Levels | Spheres\n|-\n| 2-3 | All\n|-\n| 4-5 | Charm<sup>1</sup>\n|-\n| 6-7 | Protection<sup>2</sup>\n|-\n| 8-9 | Divination<sup>3</sup>\n|-\n| 10+ | Healing\n|}\n: <sup>1</sup> Except ''[[Hold Person (Priest Spell)|hold person]]''.\n: <sup>2</sup> Except ''[[Barkskin (Priest Spell)|barkskin]]''.\n: <sup>3</sup> Only ''[[Detect Magic (Priest Spell)|detect magic]]'', ''[[Detect Poison (Priest Spell)|detect poison]]'', ''[[Augury (Priest Spell)|augury]]'', ''[[Detect Charm (Priest Spell)|detect charm]]'', ''[[Locate Object (Priest Spell)|locate object]]'', and ''[[Divination (Priest Spell)|divination]]''.\n\n'''Special Hindrances:''' A preacher is never allowed to conceal his religion or deceive people about it. He must tithe to the closest church of his religion. If Roman Catholic, he must do what he can to alleviate suffering and poverty. He must never take a life except in self defense.\n\n'''Wealth Option:''' A preacher starts the game with 2d6 x £4. Only chaotic preachers need to gamble £2 per month.\n\n'''Notes:''' In a purely historical campaign with no real supernatural elements, preachers should not be allowed to cast spells at all. In games with very slight supernatural elements, DMs may limit preachers to one spell per day. In any event, assume that most of the spell effects are not magical at all, but the result of intimidation and self-fulfilling prophecies, brought about largely by the preacher's and observers' belief that they will happen.\n\n{{Navbox A Mighty Fortress Campaign Sourcebook}}\n[[Category:Character Kit]]\n[[Category:Character Kit MFCS]]"
        ),
        categories: ["Character Kit", "Character Kit MFCS"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: "While preachers are not generally expected to fight; they can learn any weapon proficiencies"
            ),
            proficiencies: KitProficiencyRules(
                bonus: [],
                recommended: ["reading/writing", "spellcraft"],
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
            startingCash: "2d6"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit056: Kit = Kit(
        id: "prophet_priest",
        name: "Prophet Priest",
        wikiPageTitle: "Prophet Priest (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "In the campaign, the Prophet Priest is partly a tool for the DM; the DM can use the character to supply clues and even red herrings to the characters. His is often a thankless job, and he is often a bit alienated from the normal folk (see \"Special Hindrances\" below).",
            requirements: nil,
            specialBenefits: "The character receives the Medium Granted Power \"Prophecy\" from the Designing Faiths chapter. However, it's more limited than the Prophecy which is granted to priests of the god of Prophecy. With this power, priests may receive visions from the god at any time the DM decides, but may only deliberately sink into a trance in order to receive a vision once per day.",
            specialHindrances: "It's not normal for anyone but priests of the god of Prophecy to be prophets. Therefore, normal people are a little edgy around other prophets, and react to them at a -2 reaction adjustment. (This adjustment may never result in a reaction worse than Cautious, however.)",
            wealthOptions: "This priest receives the normal 3d6x10 gp starting gold.",
            weaponProficiencies: "* Required: None. * Recommended: Any that the priest's actual priest-class permits.",
            nonweaponProficiencies: "Bonus Proficiency: Weather Sense. * Recommended: None special.",
            equipment: "No special restrictions."
        ),
        description: KitDescription(
            briefSummary: "A prophet is one who receives signs, dreams, or clues about the future from his god. Priests of the god of prophecy are prophets, but they aren't the only prophets. Priests of other gods can receive and pass along prophecies.",
            fullText: "## Prophet Priest\n**Description:** A prophet is one who receives signs, dreams, or clues about the future from his god. Priests of the god of prophecy are prophets, but they aren't the *only* prophets. Priests of other gods can receive and pass along prophecies. However, since this is rarer, the DM has the right to approve or disapprove any character taking this Priest Kit.\n\nTo be a Prophet Priest, the character must have a Wisdom of 15 or better.\n\nA character may not abandon this kit. As long as he is a priest, he is a Prophet Priest.\n\n**Barred:** Priests of the god of Prophecy may not take this kit. All other priests may. (Priests of philosophies or forces don't receive their prophecies from a god; their prophecies are more like psychic impressions.)\n\n**Role:** In the campaign, the Prophet Priest is partly a tool for the DM; the DM can use the character to supply clues and even red herrings to the characters. His is often a thankless job, and he is often a bit alienated from the normal folk (see \"Special Hindrances\" below). \n\n**Secondary Skills:** The priest may choose his own secondary skill.\n\n**Weapon Proficiencies:**\n* *Required:* None.\n* *Recommended:* Any that the priest's actual priest-class permits.\n\n**Nonweapon Proficiencies:** Bonus Proficiency: Weather Sense.\n* *Recommended:* None special.\n\n**Equipment:** No special restrictions.\n\n**Special Benefits:** The character receives the Medium Granted Power \"Prophecy\" from the Designing Faiths chapter. However, it's more limited than the Prophecy which is granted to priests of the god of Prophecy. With this power, priests may receive visions from the god at any time the DM decides, but may only deliberately sink into a trance in order to receive a vision once per day.\n\n**Special Hindrances:** It's not normal for anyone but priests of the god of Prophecy to be prophets. Therefore, normal people are a little edgy around other prophets, and react to them at a  -2  reaction adjustment. (This adjustment may never result in a reaction worse than Cautious, however.)\n\n**Wealth Options:** This priest receives the normal 3d6x10 gp starting gold.\n\n**Races:** No special limitations.",
            rawWikitext: "{{Sidebar CPrH Ch4}}__NOTOC__\n==Prophet Priest==\n'''Description:''' A prophet is one who receives signs, dreams, or clues about the future from his god. Priests of the god of prophecy are prophets, but they aren't the ''only'' prophets. Priests of other gods can receive and pass along prophecies. However, since this is rarer, the DM has the right to approve or disapprove any character taking this Priest Kit.\n\nTo be a Prophet Priest, the character must have a Wisdom of 15 or better.\n\nA character may not abandon this kit. As long as he is a priest, he is a Prophet Priest.\n\n'''Barred:''' Priests of the god of Prophecy may not take this kit. All other priests may. (Priests of philosophies or forces don't receive their prophecies from a god; their prophecies are more like psychic impressions.)\n\n'''Role:''' In the campaign, the Prophet Priest is partly a tool for the DM; the DM can use the character to supply clues and even red herrings to the characters. His is often a thankless job, and he is often a bit alienated from the normal folk (see \"Special Hindrances\" below). \n\n'''Secondary Skills:''' The priest may choose his own secondary skill.\n\n'''Weapon Proficiencies:'''\n* ''Required:'' None.\n* ''Recommended:'' Any that the priest's actual priest-class permits.\n\n'''Nonweapon Proficiencies:''' Bonus Proficiency: Weather Sense.\n* ''Recommended:'' None special.\n\n'''Equipment:''' No special restrictions.\n\n'''Special Benefits:''' The character receives the Medium Granted Power \"Prophecy\" from the Designing Faiths chapter. However, it's more limited than the Prophecy which is granted to priests of the god of Prophecy. With this power, priests may receive visions from the god at any time the DM decides, but may only deliberately sink into a trance in order to receive a vision once per day.\n\n'''Special Hindrances:''' It's not normal for anyone but priests of the god of Prophecy to be prophets. Therefore, normal people are a little edgy around other prophets, and react to them at a  -2  reaction adjustment. (This adjustment may never result in a reaction worse than Cautious, however.)\n\n'''Wealth Options:''' This priest receives the normal 3d6x10 gp starting gold.\n\n'''Races:''' No special limitations.\n\n{{Navbox The Complete Priest's Handbook}}\n[[Category:Character Kit]]\n[[Category:Character Kit CPrH]]"
        ),
        categories: ["Character Kit", "Character Kit CPrH"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 15],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: "* Required: None. * Recommended: Any that the priest's actual priest-class permits."
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Proficiency: Weather Sense"],
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
            startingCash: "3d6x10 gp"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit057: Kit = Kit(
        id: "protector_of_the_faith",
        name: "Protector of the Faith",
        wikiPageTitle: "Protector of the Faith (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Protectors of the faith are found in armies throughout Europe, but usually in units composed almost entirely of other protectors. They may accompany missionaries into dangerous territory. They fight only for religious causes, never joining in secular conflicts. They are disciplined and courageous. Many Calvinists are drawn to this kit.",
            requirements: "Wisdom 9+, Strength 12+.",
            specialBenefits: "A protector of the faith can recognize evil creatures and evil works within 60 feet by concentrating on the creatures or objects for one round. He gains a +1 bonus to his THACO when fighting something that he has recognized as evil or that is clearly an enemy of his religion. He gets a +2 bonus on saving throws related to fear of the supernatural.",
            specialHindrances: "A protector must tithe to his church. He can never use, own, or willingly allow himself to benefit from a magical item or wizardly magic.",
            wealthOptions: "A protector starts with 4d6 x £4. He does not gamble. Category:Character Kit Category:Character Kit MFCS",
            weaponProficiencies: "There are no weapon restrictions for protectors of the faith.",
            nonweaponProficiencies: "* Required proficiencies: religion. * Recommended proficiencies: riding, reading/writing.",
            equipment: "A protector of the faith can wear any sort of armor and use any equipment. Whenever possible he must carry his Bible or prayer book with him."
        ),
        description: KitDescription(
            briefSummary: "The protector of the faith is a soldier who fights only for the cause of his church. Religious faith is the propelling force in his life. He is single-minded, driven, pious, righteous, and honest.",
            fullText: "## Protector of the Faith (Priest Kit)\nThe protector of the faith is a soldier who fights only for the cause of his church. Religious faith is the propelling force in his life. He is single-minded, driven, pious, righteous, and honest.\n\n**Requirements:** Wisdom 9+, Strength 12+.\n\n**Role:** Protectors of the faith are found in armies throughout Europe, but usually in units composed almost entirely of other protectors. They may accompany missionaries into dangerous territory. They fight only for religious causes, never joining in secular conflicts. They are disciplined and courageous. Many Calvinists are drawn to this kit.\n\n**Weapon Proficiencies:** There are no weapon restrictions for protectors of the faith.\n\n**Nonweapon Proficiencies:**\n* *Required proficiencies:* religion.\n* *Recommended proficiencies:* riding, reading/writing.\n\n**Armor/Equipment:** A protector of the faith can wear any sort of armor and use any equipment. Whenever possible he must carry his Bible or prayer book with him.\n\n**Special Benefits:** A protector of the faith can recognize evil creatures and evil works within 60 feet by concentrating on the creatures or objects for one round. He gains a +1 bonus to his THACO when fighting something that he has recognized as evil or that is clearly an enemy of his religion. He gets a +2 bonus on saving throws related to fear of the supernatural.\n\n**Special Hindrances:** A protector must tithe to his church. He can never use, own, or willingly allow himself to benefit from a magical item or wizardly magic.\n\n**Wealth Option:** A protector starts with 4d6 x £4. He does not gamble.",
            rawWikitext: "{{Sidebar MFCS Ch3}}__NOTOC__\n==Protector of the Faith (Priest Kit)==\nThe protector of the faith is a soldier who fights only for the cause of his church. Religious faith is the propelling force in his life. He is single-minded, driven, pious, righteous, and honest.\n\n'''Requirements:''' [[Wisdom]] 9+, [[Strength]] 12+.\n\n'''Role:''' Protectors of the faith are found in armies throughout Europe, but usually in units composed almost entirely of other protectors. They may accompany missionaries into dangerous territory. They fight only for religious causes, never joining in secular conflicts. They are disciplined and courageous. Many Calvinists are drawn to this kit.\n\n'''Weapon Proficiencies:''' There are no weapon restrictions for protectors of the faith.\n\n'''Nonweapon Proficiencies:'''\n* ''Required proficiencies:'' [[Religion (Proficiency)|religion]].\n* ''Recommended proficiencies:'' [[Riding, Land-Based (Proficiency)|riding]], [[Reading/Writing (Proficiency)|reading/writing]].\n\n'''Armor/Equipment:''' A protector of the faith can wear any sort of armor and use any equipment. Whenever possible he must carry his Bible or prayer book with him.\n\n'''Special Benefits:''' A protector of the faith can recognize evil creatures and evil works within 60 feet by concentrating on the creatures or objects for one round. He gains a +1 bonus to his THACO when fighting something that he has recognized as evil or that is clearly an enemy of his religion. He gets a +2 bonus on saving throws related to fear of the supernatural.\n\n'''Special Hindrances:''' A protector must tithe to his church. He can never use, own, or willingly allow himself to benefit from a magical item or wizardly magic.\n\n'''Wealth Option:''' A protector starts with 4d6 x £4. He does not gamble.\n\n{{Navbox A Mighty Fortress Campaign Sourcebook}}\n[[Category:Character Kit]]\n[[Category:Character Kit MFCS]]"
        ),
        categories: ["Character Kit", "Character Kit MFCS"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Strength": 12, "Wisdom": 9],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: "There are no weapon restrictions for protectors of the faith"
            ),
            proficiencies: KitProficiencyRules(
                bonus: [],
                recommended: ["riding", "reading/writing"],
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
            startingCash: "4d6"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit058: Kit = Kit(
        id: "savage_druid",
        name: "Savage - Druid",
        wikiPageTitle: "Savage - Druid (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "Rather than associate with a particular tribe—as do most shamans or witch doctors—the Savage druid adopts a neutral position, mediating intertribal feuds and handling relations between human tribes and neighboring humanoids, demihumans, or intelligent monsters. Most Savages live as hermits in the wild, although if Haro gains high rank, he could control a coalition of tribespeople, nonhumans, and animals. If Haro joins a party in more civilized lands, he occupies the role of outsider and observer. The Savage character should act puzzled by some aspects of more advanced civilization, impressed, amused, or disgusted by others. The Savage druid's reaction to big cities is unlikely to be favorable!",
            requirements: nil,
            specialBenefits: "The Savage druid's body is covered with ceremonial scars and tattoos. These eliminate the need to use the holy symbol of Haro's branch when casting spells—his tattoos and other markings are as effective as holy symbols other druids use.",
            specialHindrances: "Haro, like most Savage druids, has an unusual and imposing appearance. While he could alter his primitive dress easily, his strange accent, weathered appearance, tattoos, and scars mark him as a foreigner when he travels in civilized lands. These alien features give him a -2 reaction penalty among civilized NPCs; players can decide how their PCs react.",
            wealthOptions: "3d6x5 gp. Savage druids begin adventuring unfamiliar with money; all their starting wealth is actually an equivalent value in goods.",
            weaponProficiencies: "Savage druids are restricted to a choice of blowgun, club, dagger, harpoon, knife, spear, or staff. After adventuring in civilized lands (advancing at least one level doing so), they can learn other weapon proficiencies.",
            nonweaponProficiencies: "* Bonus—fire-building, survival. * Recommended—(general) direction sense, fishing, swimming, weather sense; (priest) healing, herbalism, local history, musical instrument; (warrior) animal lore, endurance, mountaineering, running, set snares, tracking.",
            equipment: "The Savage druid can buy no armor (though he may acquire a wooden shield) and can buy only those weapons listed above under \"Weapon Proficiencies.\" He should spend his entire initial allotment of gold pieces on equipment, as he loses any unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "This druid lives in primitive Stone Age tribe, usually in a rain forest. Haro, a typical Savage druid (pictured on the next page), differs from a savage priest, shaman, or witch doctor in that he belongs to the worldwide druidic order and, of course, to a druidic branch.",
            fullText: "## Savage\nThis druid lives in primitive Stone Age tribe, usually in a rain forest. Haro, a typical Savage druid (pictured on the next page), differs from a savage priest, shaman, or witch doctor in that he belongs to the worldwide druidic order and, of course, to a druidic branch. Some Savage druids work and live among primitive tribes as missionaries from more civilized cultures.\n\n**Role:** Rather than associate with a particular tribe—as do most shamans or witch doctors—the Savage druid adopts a neutral position, mediating intertribal feuds and handling relations between human tribes and neighboring humanoids, demihumans, or intelligent monsters. Most Savages live as hermits in the wild, although if Haro gains high rank, he could control a coalition of tribespeople, nonhumans, and animals.\n\nIf Haro joins a party in more civilized lands, he occupies the role of outsider and observer. The Savage character should act puzzled by some aspects of more advanced civilization, impressed, amused, or disgusted by others. The Savage druid's reaction to big cities is unlikely to be favorable!\n\n**Branch Restrictions:** None.\n\n**Weapon Proficiencies:** Savage druids are restricted to a choice of blowgun, club, dagger, harpoon, knife, spear, or staff. After adventuring in civilized lands (advancing at least one level doing so), they can learn other weapon proficiencies.\n\n**Secondary Skills:** Hunter.\n\n**Nonweapon Proficiencies:**\n* *Bonus*—fire-building, survival.\n* *Recommended*—(general) direction sense, fishing, swimming, weather sense; (priest) healing, herbalism, local history, musical instrument; (warrior) animal lore, endurance, mountaineering, running, set snares, tracking.\n\n**Equipment:** The Savage druid can buy no armor (though he may acquire a wooden shield) and can buy only those weapons listed above under \"Weapon Proficiencies.\" He should spend his entire initial allotment of gold pieces on equipment, as he loses any unspent starting money in excess of 1 gp.\n\n**Special Benefits:** The Savage druid's body is covered with ceremonial scars and tattoos. These eliminate the need to use the holy symbol of Haro's branch when casting spells—his tattoos and other markings are as effective as holy symbols other druids use.\n\n**Special Hindrances:** Haro, like most Savage druids, has an unusual and imposing appearance. While he could alter his primitive dress easily, his strange accent, weathered appearance, tattoos, and scars mark him as a foreigner when he travels in civilized lands. These alien features give him a -2 reaction penalty among civilized NPCs; players can decide how their PCs react.\n\n**Wealth Options:** 3d6x5 gp. Savage druids begin adventuring unfamiliar with money; all their starting wealth is actually an equivalent value in goods.",
            rawWikitext: "{{See also|Savage - POSP (Character Kit)|Savage - Fighter (Character Kit)}}\n{{Sidebar CDH Ch2}}__NOTOC__\n==Savage==\nThis druid lives in primitive Stone Age tribe, usually in a rain forest. Haro, a typical Savage druid (pictured on the next page), differs from a savage priest, shaman, or witch doctor in that he belongs to the worldwide druidic order and, of course, to a druidic branch. Some Savage druids work and live among primitive tribes as missionaries from more civilized cultures.\n\n'''Role:''' Rather than associate with a particular tribe—as do most shamans or witch doctors—the Savage druid adopts a neutral position, mediating intertribal feuds and handling relations between human tribes and neighboring humanoids, demihumans, or intelligent monsters. Most Savages live as hermits in the wild, although if Haro gains high rank, he could control a coalition of tribespeople, nonhumans, and animals.\n\nIf Haro joins a party in more civilized lands, he occupies the role of outsider and observer. The Savage character should act puzzled by some aspects of more advanced civilization, impressed, amused, or disgusted by others. The Savage druid's reaction to big cities is unlikely to be favorable!\n\n'''Branch Restrictions:''' None.\n\n'''Weapon Proficiencies:''' Savage druids are restricted to a choice of blowgun, club, dagger, harpoon, knife, spear, or staff. After adventuring in civilized lands (advancing at least one level doing so), they can learn other weapon proficiencies.\n\n'''Secondary Skills:''' Hunter.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus''—[[Fire-building (Proficiency)|fire-building]], [[Survival (Proficiency)|survival]].\n* ''Recommended''—(general) [[Direction Sense (Proficiency)|direction sense]], [[Fishing (Proficiency)|fishing]], [[Swimming (Proficiency)|swimming]], [[Weather Sense (Proficiency)|weather sense]]; (priest) [[Healing (Proficiency)|healing]], [[Herbalism (Proficiency)|herbalism]], [[Local History (Proficiency)|local history]], [[Musical Instrument (Proficiency)|musical instrument]]; (warrior) [[Animal Lore (Proficiency)|animal lore]], [[Endurance (Proficiency)|endurance]], [[Mountaineering (Proficiency)|mountaineering]], [[Running (Proficiency)|running]], [[Set Snares (Proficiency)|set snares]], [[Tracking (Proficiency)|tracking]].\n\n'''Equipment:''' The Savage druid can buy no armor (though he may acquire a wooden shield) and can buy only those weapons listed above under \"Weapon Proficiencies.\" He should spend his entire initial allotment of gold pieces on equipment, as he loses any unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' The Savage druid's body is covered with ceremonial scars and tattoos. These eliminate the need to use the holy symbol of Haro's branch when casting spells—his tattoos and other markings are as effective as holy symbols other druids use.\n\n'''Special Hindrances:''' Haro, like most Savage druids, has an unusual and imposing appearance. While he could alter his primitive dress easily, his strange accent, weathered appearance, tattoos, and scars mark him as a foreigner when he travels in civilized lands. These alien features give him a -2 reaction penalty among civilized NPCs; players can decide how their PCs react.\n\n'''Wealth Options:''' 3d6x5 gp. Savage druids begin adventuring unfamiliar with money; all their starting wealth is actually an equivalent value in goods.\n\n{{Navbox The Complete Druid's Handbook}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: [:],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["blowgun", "club", "dagger", "harpoon", "knife", "spear", "staff"],
                forbidden: [],
                notes: "Savage druids are restricted to a choice of blowgun, club, dagger, harpoon, knife, spear, or staff. After adventuring in civilized lands (advancing at least one level doing so), they can learn other weapon proficiencies."
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["fire-building", "survival"],
                recommended: ["direction sense", "fishing", "swimming", "weather sense", "healing", "herbalism", "local history", "musical instrument", "animal lore", "endurance", "mountaineering", "running", "set snares", "tracking"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .specific(["shield"]),
                shieldsAllowed: .specific(["shield"]),
                metalAllowed: false,
                maxArmorClass: nil,
                notes: "The Savage druid can buy no armor (though he may acquire a wooden shield) and can buy only those weapons listed above under \"Weapon Proficiencies.\" He should spend his entire initial allotment of gold pieces on equipment, as he loses any unspent starting money in excess of 1 gp."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: "3d6x5 gp"
        ),
        deity: "Savage",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Druid"
    )

let embeddedKit059: Kit = Kit(
        id: "savage_priest",
        name: "Savage Priest",
        wikiPageTitle: "Savage Priest (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "In a campaign, this character usually plays the role of the primitive who finds his world-view shattered by his experiences in the outer world... but who might teach his \"civilized\" companions something about simple truth and justice as he adventures with them. The DM should insist that the character role-play his tribal origins in the first four or five experience levels, until the character is more used to the outside world; this priest will be baffled by \"high-technology\" inventions (iron and steel weapons, boats made out of more than a single log, hourglasses, anything more sophisticated than the tools of his tribe), by civilized morals and ethics, and especially by the strangeness and unfairness of the laws of civilized men.",
            requirements: nil,
            specialBenefits: "The Savage Priest has a special Detect Magic ability, resembling the spell of the same name, which he may use once per day per experience level he has (i.e., a 5th-level savage could use his ability five times per day). The rules for this power are: Detect Magic. The Savage Priest is in tune with nature and can feel when there is something magical in the vicinity. As with the first-level Priest spell, he has a 10% chance per experience level to determine the sphere of the magic.",
            specialHindrances: "The Savage Priest is imposing and strange, and he worships his gods \"all wrong\" (i.e., civilized folk and priests recognize that his rites are different, unlike theirs). Therefore, he suffers a -2 reaction adjustment from all civilized folk (NPCs, that is; PCs can decide for themselves how they react to him).",
            wealthOptions: "The Savage starts out with only 3d6x5 gp. After the campaign starts, he will encounter money, and the player may decide either that he likes the stuff or rejects it as a stupid city-human idea.",
            weaponProficiencies: "The Savage Priest is limited to the weapons his actual priest-class permits him, and is further limited (when he is first created) to the following set of proficiencies: blowgun, long bow, short bow, club, dagger, javelin, knife, sling, spear. After he has adventured in the outer world, the character may learn other proficiencies.",
            nonweaponProficiencies: "* Bonus Proficiencies: (General) Direction Sense or Weather Sense (player choice), (Warrior) Endurance or Survival (player choice). * Recommended: (General) Animal Handling, Animal Training, Fire-Building, Fishing, Riding (Land-based), Rope Use, Swimming, (Warrior, double slots unless the priest-class dictates otherwise) Animal Lore, Bowyer/Fletcher, Hunting, Mountaineering, Running, Set Snares, Tracking, (Priest) Healing, Herbalism, Local History, Religion, (Rogue, double slots unless the priest-class dictates otherwise) Jumping, Tightrope Walking, Tumbling, (Wizard, double slots unless the priest-class dictates otherwise) Herbalism. The Savage may not take Etiquette or Heraldry when first created.",
            equipment: "The Savage Priest, with his starting gold, may buy no armor other than leather armor and shield, and may buy no weapon not listed above under \"Weapon Proficiencies.\" He must spend all his gold when he is created, or lose any \"change\" he has left over. If you have ''The Complete Fighter's Handbook'', use the Equipment rules for the Savage Warrior Kit instead."
        ),
        description: KitDescription(
            briefSummary: "This is a shaman of a savage tribe. This character is a member of the tribe. The tribe itself is a technologically and culturally primitive one (by the standards and in the opinions of more \"civilized\" cultures), but is also one which is attuned to the natural forces of the world.",
            fullText: "## Savage Priest\n**Description:** This is a shaman of a savage tribe. This character is a member of the tribe. The tribe itself is a technologically and culturally primitive one (by the standards and in the opinions of more \"civilized\" cultures), but is also one which is attuned to the natural forces of the world. The Savage Priest interprets the will of his god and acts as an advisor or leader to the members of his tribe.\n\nThis character might be an animal-totem shaman who assigns all the tribal warriors their animal totems. He might be the witch-doctor who insists on the deaths of the adventurers from the outside world. Take a priestess of a nature-god and give her the Savage Priestess kit, and you end up with something very like a nymph. Whether the Savage Priest is good or evil, filthy or clean-limbed depends on the nature of the tribe itself; the DM decides what the tribe is like.\n\nTo be a Savage Priest, a character must have a minimum Strength score of 11 and a minimum Constitution score of 13.\n\nIn abandoning this kit, the character is renouncing his membership with the tribe and accepting citizenship in some other culture. This frequently happens with Savage Priests who join adventuring parties, stay with them in travels through the world, and learn so much of the outside world that they no longer feel like part of their tribe.\n\n**Barred:** Priests of the following god and philosophies may not take this kit: Disease, Divinity of Mankind, Evil, Good.\n\nPriests of the following gods are *most* appropriate to this kit: Animals, Earth, Elemental Forces, Fire, Hunting, Nature, Sky/Weather, Vegetation.\n\n**Role:** In a campaign, this character usually plays the role of the primitive who finds his world-view shattered by his experiences in the outer world... but who might teach his \"civilized\" companions something about simple truth and justice as he adventures with them. The DM should insist that the character role-play his tribal origins in the first four or five experience levels, until the character is more used to the outside world; this priest will be baffled by \"high-technology\" inventions (iron and steel weapons, boats made out of more than a single log, hourglasses, anything more sophisticated than the tools of his tribe), by civilized morals and ethics, and especially by the strangeness and unfairness of the laws of civilized men.\n\n**Secondary Skills:** The Savage Priest character must take Fisher, Forester, Groom, Hunter, or Trapper/Furrier as his Secondary Skill (player choice, based on the activities of his character's tribe).\n\n**Weapon Proficiencies:** The Savage Priest is limited to the weapons his actual priest-class permits him, and is further limited (when he is first created) to the following set of proficiencies: blowgun, long bow, short bow, club, dagger, javelin, knife, sling, spear. After he has adventured in the outer world, the character may learn other proficiencies.\n\n**Nonweapon Proficiencies:**\n* *Bonus Proficiencies:* (General) Direction Sense *or* Weather Sense (player choice), (Warrior) Endurance *or* Survival (player choice).\n* *Recommended:* (General) Animal Handling, Animal Training, Fire-Building, Fishing, Riding (Land-based), Rope Use, Swimming, (Warrior, double slots unless the priest-class dictates otherwise) Animal Lore, Bowyer/Fletcher, Hunting, Mountaineering, Running, Set Snares, Tracking, (Priest) Healing, Herbalism, Local History, Religion, (Rogue, double slots unless the priest-class dictates otherwise) Jumping, Tightrope Walking, Tumbling, (Wizard, double slots unless the priest-class dictates otherwise) Herbalism. The Savage may *not* take Etiquette or Heraldry when first created.\n\n**Equipment:** The Savage Priest, with his starting gold, may buy no armor other than leather armor and shield, and may buy no weapon not listed above under \"Weapon Proficiencies.\" He must spend all his gold when he is created, or lose any \"change\" he has left over.\n\nIf you have *The Complete Fighter's Handbook*, use the Equipment rules for the Savage Warrior Kit instead.\n\n**Special Benefits:** The Savage Priest has a special *Detect Magic* ability, resembling the spell of the same name, which he may use once per day per experience level he has (i.e., a 5th-level savage could use his ability five times per day). The rules for this power are:\n\n*Detect Magic*. The Savage Priest is in tune with nature and can feel when there is something magical in the vicinity. As with the first-level Priest spell, he has a 10% chance per experience level to determine the sphere of the magic.\n\n**Special Hindrances:** The Savage Priest is imposing and strange, and he worships his gods \"all wrong\" (i.e., civilized folk and priests recognize that his rites are different, unlike theirs). Therefore, he suffers a -2 reaction adjustment from all civilized folk (NPCs, that is; PCs can decide for themselves how they react to him).\n\n**Wealth Options:** The Savage starts out with only 3d6x5 gp. After the campaign starts, he will encounter money, and the player may decide either that he likes the stuff or rejects it as a stupid city-human idea.\n\n**Races:** No special limitations.",
            rawWikitext: "{{Sidebar CPrH Ch4}}__NOTOC__\n==Savage Priest==\n'''Description:''' This is a shaman of a savage tribe. This character is a member of the tribe. The tribe itself is a technologically and culturally primitive one (by the standards and in the opinions of more \"civilized\" cultures), but is also one which is attuned to the natural forces of the world. The Savage Priest interprets the will of his god and acts as an advisor or leader to the members of his tribe.\n\nThis character might be an animal-totem shaman who assigns all the tribal warriors their animal totems. He might be the witch-doctor who insists on the deaths of the adventurers from the outside world. Take a priestess of a nature-god and give her the Savage Priestess kit, and you end up with something very like a nymph. Whether the Savage Priest is good or evil, filthy or clean-limbed depends on the nature of the tribe itself; the DM decides what the tribe is like.\n\nTo be a Savage Priest, a character must have a minimum Strength score of 11 and a minimum Constitution score of 13.\n\nIn abandoning this kit, the character is renouncing his membership with the tribe and accepting citizenship in some other culture. This frequently happens with Savage Priests who join adventuring parties, stay with them in travels through the world, and learn so much of the outside world that they no longer feel like part of their tribe.\n\n'''Barred:''' Priests of the following god and philosophies may not take this kit: Disease, Divinity of Mankind, Evil, Good.\n\nPriests of the following gods are ''most'' appropriate to this kit: Animals, Earth, Elemental Forces, Fire, Hunting, Nature, Sky/Weather, Vegetation.\n\n'''Role:''' In a campaign, this character usually plays the role of the primitive who finds his world-view shattered by his experiences in the outer world... but who might teach his \"civilized\" companions something about simple truth and justice as he adventures with them. The DM should insist that the character role-play his tribal origins in the first four or five experience levels, until the character is more used to the outside world; this priest will be baffled by \"high-technology\" inventions (iron and steel weapons, boats made out of more than a single log, hourglasses, anything more sophisticated than the tools of his tribe), by civilized morals and ethics, and especially by the strangeness and unfairness of the laws of civilized men.\n\n'''Secondary Skills:''' The Savage Priest character must take Fisher, Forester, Groom, Hunter, or Trapper/Furrier as his Secondary Skill (player choice, based on the activities of his character's tribe).\n\n'''Weapon Proficiencies:''' The Savage Priest is limited to the weapons his actual priest-class permits him, and is further limited (when he is first created) to the following set of proficiencies: blowgun, long bow, short bow, club, dagger, javelin, knife, sling, spear. After he has adventured in the outer world, the character may learn other proficiencies.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus Proficiencies:'' (General) Direction Sense ''or'' Weather Sense (player choice), (Warrior) Endurance ''or'' Survival (player choice).\n* ''Recommended:'' (General) Animal Handling, Animal Training, Fire-Building, Fishing, Riding (Land-based), Rope Use, Swimming, (Warrior, double slots unless the priest-class dictates otherwise) Animal Lore, Bowyer/Fletcher, Hunting, Mountaineering, Running, Set Snares, Tracking, (Priest) Healing, Herbalism, Local History, Religion, (Rogue, double slots unless the priest-class dictates otherwise) Jumping, Tightrope Walking, Tumbling, (Wizard, double slots unless the priest-class dictates otherwise) Herbalism. The Savage may ''not'' take Etiquette or Heraldry when first created.\n\n'''Equipment:''' The Savage Priest, with his starting gold, may buy no armor other than leather armor and shield, and may buy no weapon not listed above under \"Weapon Proficiencies.\" He must spend all his gold when he is created, or lose any \"change\" he has left over.\n\nIf you have ''The Complete Fighter's Handbook'', use the Equipment rules for the Savage Warrior Kit instead.\n\n'''Special Benefits:''' The Savage Priest has a special ''Detect Magic'' ability, resembling the spell of the same name, which he may use once per day per experience level he has (i.e., a 5th-level savage could use his ability five times per day). The rules for this power are:\n\n''Detect Magic''. The Savage Priest is in tune with nature and can feel when there is something magical in the vicinity. As with the first-level Priest spell, he has a 10% chance per experience level to determine the sphere of the magic.\n\n'''Special Hindrances:''' The Savage Priest is imposing and strange, and he worships his gods \"all wrong\" (i.e., civilized folk and priests recognize that his rites are different, unlike theirs). Therefore, he suffers a -2 reaction adjustment from all civilized folk (NPCs, that is; PCs can decide for themselves how they react to him).\n\n'''Wealth Options:''' The Savage starts out with only 3d6x5 gp. After the campaign starts, he will encounter money, and the player may decide either that he likes the stuff or rejects it as a stupid city-human idea.\n\n'''Races:''' No special limitations.\n\n{{Navbox The Complete Priest's Handbook}}\n[[Category:Character Kit]]\n[[Category:Character Kit CPrH]]"
        ),
        categories: ["Character Kit", "Character Kit CPrH"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Strength": 11, "Constitution": 13],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["blowgun", "long bow", "short bow", "club", "dagger", "javelin", "knife", "sling", "spear"],
                forbidden: [],
                notes: "The Savage Priest is limited to the weapons his actual priest-class permits him, and is further limited (when he is first created) to the following set of proficiencies: blowgun, long bow, short bow, club, dagger, javelin, knife, sling, spear"
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Endurance or Survival "],
                recommended: [],
                notes: "Direction Sense or Weather Sense; (General) Animal Handling, Animal Training, Fire-Building, Fishing, Riding (Land-based), Rope Use, Swimming, (Warrior, double slots unless the priest-class dictates otherwise) Animal Lore, Bowyer/Fletcher, Hunting, Mountaineering, Running, Set Snares, Tracking, (Priest) Healing, Herbalism, Local History, Religion, (Rogue, double slots unless the priest-class dictates otherwise) Jumping, Tightrope Walking, Tumbling, (Wizard, double slots unless the priest-class dictates otherwise) Herbalism. The Savage may not take Etiquette or Heraldry when first created."
            ),
            armor: KitArmorRules(
                allowedTypes: .specific([]),
                shieldsAllowed: .specific([]),
                metalAllowed: false,
                maxArmorClass: nil,
                notes: "No armor allowed for this kit."
            ),
            turnUndead: KitTurnUndeadRules(
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: "3d6x5 gp"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )
