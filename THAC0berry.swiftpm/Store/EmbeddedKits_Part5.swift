import Foundation

/// Parte 5 de 5 dos kits embutidos — ver `EmbeddedKits.swift` pro
/// porquê disso existir (nunca volte pra ler isso de JSON/bundle) e pro porquê
/// de estar dividido em vários arquivos/constantes em vez de um array literal
/// único gigante: um único `[Kit(...), Kit(...), ...]` com todos os kits
/// dá exatamente no erro clássico do type-checker do Swift ("unable to
/// type-check this expression in reasonable time" — que no Swift
/// Playgrounds às vezes só aparece como "Build Failed" sem detalhe nenhum).
/// Cada kit aqui é uma constante com tipo explícito (`: Kit`), o que faz o
/// compilador checar cada um isoladamente e rápido, em vez de tentar inferir
/// o array inteiro de uma vez.


let embeddedKit080: Kit = Kit(
        id: "totemic_druid",
        name: "Totemic Druid",
        wikiPageTitle: "Totemic Druid (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "Totemic Druids tend to adopt characteristics associated with their totem animal. They feel especially protective of their totem animal in the wild and want to befriend the creatures. As a Totemic Druid, Vanier acts to promote the interests of the totem species and its individual members. Even if his totem is traditional prey (a deer, for example), Vanier never hunts the animal himself, nor does he eat its meat. While he usually does not try to ban hunting of his totem (except in the case of endangered species), he opposes cruel or wasteful hunting practices.",
            requirements: nil,
            specialBenefits: "A Totemic Druid like Vanier can shapechange into the form of his totem animal a number of times per day equal to his experience level divided by three (rounded down), plus one. So, a 3rd- to 5th-level Totemic Druid can change twice per day, a 6th- to 8th-level druid can change three times per day, and so on. This ability functions as normal druidic shapechanging, except that the druid does not regain hit points when shapechanging into or out of the totem form; the druid's spirit remains so closely bound with the totem that he fully experiences any damage the animal form took. The Totemic Druid can use this shapechanging ability in addition to his shapechanging granted powers. A Totemic Druid can communicate freely with normal or giant examples of the totem animal species (as with the speak with animals spell). He receives a +4 bonus to any healing, animal training, animal lore, or animal handling proficiency checks related to the totem. A druid who doesn't have one of these proficiencies may behave as though he did when dealing with his totem animal, but does not apply the +4 bonus.",
            specialHindrances: "A Totemic Druid has one fewer nonweapon proficiency slot than normal, as a result of spending so much time in animal form. So, Vanier would start with three slots rather than four.",
            wealthOptions: "3d6x5 gp. Totemic Druids, like Shapeshifters, have a less pressing need for money due to the amount of time they spend in animal form.",
            weaponProficiencies: "Recommended—staff.",
            nonweaponProficiencies: "Bonus—tracking. Recommended—(general) animal handling, animal training; (priest) healing, herbalism; (warrior) animal lore, survival. Note that Totemic Druids have a reduced number of proficiency slots. (See \"Special Hindrances.\")",
            equipment: "The druid should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "The Totemic Druid closely identifies with a particular species of mammal, reptile, or bird. While Vanier, a typical Totemic Druid, stops short of worshiping his totem animal, he believes that particular animal represents his spirit.",
            fullText: "## Totemic Druid\nThe Totemic Druid closely identifies with a particular species of mammal, reptile, or bird. While Vanier, a typical Totemic Druid, stops short of worshiping his totem animal, he believes that particular animal represents his spirit. The Totemic Druid picks a normal (real-world) wild mammal, reptile, or bird as his totem. This creature cannot be larger than a bear or smaller than a mouse. Some common choices include the black bear, bobcat, eagle, owl, wolf, rattlesnake, and beaver. In addition, Vanier's totem animal must correspond to his branch; if Vanier belongs to the desert druid branch, he can select as his totem only an animal that normally lives in the desert.\n\n**Role:** Totemic Druids tend to adopt characteristics associated with their totem animal. They feel especially protective of their totem animal in the wild and want to befriend the creatures. As a Totemic Druid, Vanier acts to promote the interests of the totem species and its individual members.\n\nEven if his totem is traditional prey (a deer, for example), Vanier never hunts the animal himself, nor does he eat its meat. While he usually does not try to ban hunting of his totem (except in the case of endangered species), he opposes cruel or wasteful hunting practices.\n\n**Branch Restrictions:** None.\n\n**Weapon Proficiencies:** *Recommended*—staff.\n\n**Secondary Skills:** Groom, hunter.\n\n**Nonweapon Proficiencies:**\n: *Bonus*—tracking. *Recommended*—(general) animal handling, animal training; (priest) healing, herbalism; (warrior) animal lore, survival.\n\nNote that Totemic Druids have a reduced number of proficiency slots. (See \"Special Hindrances.\")\n\n**Equipment:** The druid should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp.\n\n**Special Benefits:** A Totemic Druid like Vanier can shapechange into the form of his totem animal a number of times per day equal to his experience level divided by three (rounded down), plus one. So, a 3rd- to 5th-level Totemic Druid can change twice per day, a 6th- to 8th-level druid can change three times per day, and so on. This ability functions as normal druidic shapechanging, except that the druid does not regain hit points when shapechanging into or out of the totem form; the druid's spirit remains so closely bound with the totem that he fully experiences any damage the animal form took. The Totemic Druid can use this shapechanging ability *in addition* to his shapechanging granted powers.\n\nA Totemic Druid can communicate freely with normal or giant examples of the totem animal species (as with the *speak with animals spell*). He receives a +4 bonus to any healing, animal training, animal lore, or animal handling proficiency checks related to the totem. A druid who doesn't have one of these proficiencies may behave as though he did when dealing with his totem animal, but does not apply the +4 bonus.\n\n**Special Hindrances:** A Totemic Druid has one fewer nonweapon proficiency slot than normal, as a result of spending so much time in animal form. So, Vanier would start with three slots rather than four.\n\n**Wealth Options:** 3d6x5 gp. Totemic Druids, like Shapeshifters, have a less pressing need for money due to the amount of time they spend in animal form.",
            rawWikitext: "{{Sidebar CDH Ch2}}__NOTOC__\n==Totemic Druid==\nThe Totemic Druid closely identifies with a particular species of mammal, reptile, or bird. While Vanier, a typical Totemic Druid, stops short of worshiping his totem animal, he believes that particular animal represents his spirit. The Totemic Druid picks a normal (real-world) wild mammal, reptile, or bird as his totem. This creature cannot be larger than a bear or smaller than a mouse. Some common choices include the black bear, bobcat, eagle, owl, wolf, rattlesnake, and beaver. In addition, Vanier's totem animal must correspond to his branch; if Vanier belongs to the desert druid branch, he can select as his totem only an animal that normally lives in the desert.\n\n'''Role:''' Totemic Druids tend to adopt characteristics associated with their totem animal. They feel especially protective of their totem animal in the wild and want to befriend the creatures. As a Totemic Druid, Vanier acts to promote the interests of the totem species and its individual members.\n\nEven if his totem is traditional prey (a deer, for example), Vanier never hunts the animal himself, nor does he eat its meat. While he usually does not try to ban hunting of his totem (except in the case of endangered species), he opposes cruel or wasteful hunting practices.\n\n'''Branch Restrictions:''' None.\n\n'''Weapon Proficiencies:''' ''Recommended''—staff.\n\n'''Secondary Skills:''' Groom, hunter.\n\n'''Nonweapon Proficiencies:'''\n: ''Bonus''—tracking. ''Recommended''—(general) animal handling, animal training; (priest) healing, herbalism; (warrior) animal lore, survival.\n\nNote that Totemic Druids have a reduced number of proficiency slots. (See \"Special Hindrances.\")\n\n'''Equipment:''' The druid should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' A Totemic Druid like Vanier can shapechange into the form of his totem animal a number of times per day equal to his experience level divided by three (rounded down), plus one. So, a 3rd- to 5th-level Totemic Druid can change twice per day, a 6th- to 8th-level druid can change three times per day, and so on. This ability functions as normal druidic shapechanging, except that the druid does not regain hit points when shapechanging into or out of the totem form; the druid's spirit remains so closely bound with the totem that he fully experiences any damage the animal form took. The Totemic Druid can use this shapechanging ability ''in addition'' to his shapechanging granted powers.\n\nA Totemic Druid can communicate freely with normal or giant examples of the totem animal species (as with the ''[[Speak with Animals (Priest Spell)|speak with animals]] spell''). He receives a +4 bonus to any healing, animal training, animal lore, or animal handling proficiency checks related to the totem. A druid who doesn't have one of these proficiencies may behave as though he did when dealing with his totem animal, but does not apply the +4 bonus.\n\n'''Special Hindrances:''' A Totemic Druid has one fewer nonweapon proficiency slot than normal, as a result of spending so much time in animal form. So, Vanier would start with three slots rather than four.\n\n'''Wealth Options:''' 3d6x5 gp. Totemic Druids, like Shapeshifters, have a less pressing need for money due to the amount of time they spend in animal form.\n\n{{Navbox The Complete Druid's Handbook}}"
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
                bonus: ["tracking"],
                recommended: [],
                notes: "; (general) animal handling, animal training; (priest) healing, herbalism; (warrior) animal lore, survival. Note that Totemic Druids have a reduced number of proficiency slots. (See \"Special Hindrances.\")"
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
            startingCash: "3d6x5 gp"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit081: Kit = Kit(
        id: "tymora_favored",
        name: "Tymora - Favored",
        wikiPageTitle: "Tymora - Favored (Character Kit)",
        redirectAliases: ["Priests of Tymora (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "As the goddess of good luck, Tymora's favors are frequently sought after by adventurers. In a. lucky inspiration, Tymora realized that it would be useful to have a group of wandering priests who enjoyed adventuring and exploration. The favored are itinerant priests of Tymora who sometimes turn up under lucky circumstances and minister to adventurers and explorers.",
            requirements: "Charisma 12, Wisdom 9",
            specialBenefits: "Once a day, a favored can do one of the following things: turn an enemy's attack roll result into a 1, turn her own attack roll into a 20, make one person in her group gain a +1 on an attack roll for one round, penalize the attack roll of one person on the enemy's side with a -1 penalty, automatically succeed at a proficiency or ability check, or cause an enemy to fail at such a check. The favored can also turn undead.",
            specialHindrances: "Tymora is a fickle goddess, even for the favored. There is a cumulative 2% chance per day that the Special Ability will not work, because Tymora is distracted with someone else that she favors. Once a failure has been reached, the chance resets back to the initial 2%. This likelihood is checked at the beginning of the day. Of course, if the favored unknowingly does not use his special ability that day, well, that's a stroke of luck!",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Direction sense",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "As the goddess of good luck, Tymora's favors are frequently sought after by adventurers. In a. lucky inspiration, Tymora realized that it would be useful to have a group of wandering priests who enjoyed adventuring and exploration.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Charisma 12, Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Direction sense\n|-\n| **Recommended Proficiencies** || Local history, riding, land-based\n|}\n## Overview\nAs the goddess of good luck, Tymora's favors are frequently sought after by adventurers. In a. lucky inspiration, Tymora realized that it would be useful to have a group of wandering priests who enjoyed adventuring and exploration.\n\nThe favored are itinerant priests of Tymora who sometimes turn up under lucky circumstances and minister to adventurers and explorers.\n\n## Description\nThere is no set clerical garb for the favored; arms, armor, and clothing is such a matter of taste that many could pass for \"just another adventurer\". However, the observant will notice the confident, almost cocky grin, and the tell-tale silver disk that is the holy symbol of Lady Luck. Indeed, when the contents of a chamberpot emptied from a second story window manage to cover everyone in\n\nTymora-Favored a group except for one seemingly overconfident adventurer, odds are that the clean one is a favored of Tymora.\n\n## Role-Playing\nThe favored are among the most highly prized clergy to one of the most popular (and thus influential) gods in Faerûn. Life is good. Is it any wonder that the favored seem supremely confident?\n\nPaladins, cavaliers, and other dramatic warriors cannot help but admire the seemingly \"nick of time\" arrival of a favored in the middle of a crisis. Even the dour, violent priests of Tempus, Lord of Battles, are impressed at the recklessness of the favored when the latter priests enter battle. The favored have learned that there is no sense in worrying about the future; Lady Tymora has their luck in her hands. Why, a favored could fight a red dragon and emerge victorious and unscathed, only to choke to death on a chicken bone at the inn where the victory party is held!\n\nThus, the favored, while not foolish, will often throw caution to the wind and trust in luck. Considering how many adventurers die despite their meticulous plans, this is not so ridiculous a tactic.\n\n## Special Abilities\nOnce a day, a favored can do one of the following things: turn an enemy's attack roll result into a 1, turn her own attack roll into a 20, make one person in her group gain a +1 on an attack roll for one round, penalize the attack roll of one person on the enemy's side with a -1 penalty, automatically succeed at a proficiency or ability check, or cause an enemy to fail at such a check.\n\nThe favored can also turn undead.\n\n## Special Disadvantages\nTymora is a fickle goddess, even for the favored. There is a cumulative 2% chance per day that the Special Ability will not work, because Tymora is distracted with someone else that she favors. Once a failure has been reached, the chance resets back to the initial 2%. This likelihood is checked at the beginning of the day. Of course, if the favored unknowingly does not use his special ability that day, well, that's a stroke of luck!",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Charisma]] 12, [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Direction Sense (Proficiency)|Direction sense]]\n|-\n| '''Recommended Proficiencies''' || [[Local History (Proficiency)|Local history]], [[Riding, Land-Based (Proficiency)|riding, land-based]]\n|}__TOC__\n==Overview==\nAs the goddess of good luck, Tymora's favors are frequently sought after by adventurers. In a. lucky inspiration, Tymora realized that it would be useful to have a group of wandering priests who enjoyed adventuring and exploration.\n\nThe favored are itinerant priests of Tymora who sometimes turn up under lucky circumstances and minister to adventurers and explorers.\n\n==Description==\nThere is no set clerical garb for the favored; arms, armor, and clothing is such a matter of taste that many could pass for \"just another adventurer\". However, the observant will notice the confident, almost cocky grin, and the tell-tale silver disk that is the holy symbol of Lady Luck. Indeed, when the contents of a chamberpot emptied from a second story window manage to cover everyone in\n\nTymora-Favored a group except for one seemingly overconfident adventurer, odds are that the clean one is a favored of Tymora.\n\n==Role-Playing==\nThe favored are among the most highly prized clergy to one of the most popular (and thus influential) gods in Faerûn. Life is good. Is it any wonder that the favored seem supremely confident?\n\nPaladins, cavaliers, and other dramatic warriors cannot help but admire the seemingly \"nick of time\" arrival of a favored in the middle of a crisis. Even the dour, violent priests of Tempus, Lord of Battles, are impressed at the recklessness of the favored when the latter priests enter battle. The favored have learned that there is no sense in worrying about the future; Lady Tymora has their luck in her hands. Why, a favored could fight a red dragon and emerge victorious and unscathed, only to choke to death on a chicken bone at the inn where the victory party is held!\n\nThus, the favored, while not foolish, will often throw caution to the wind and trust in luck. Considering how many adventurers die despite their meticulous plans, this is not so ridiculous a tactic.\n\n==Special Abilities==\nOnce a day, a favored can do one of the following things: turn an enemy's attack roll result into a 1, turn her own attack roll into a 20, make one person in her group gain a +1 on an attack roll for one round, penalize the attack roll of one person on the enemy's side with a -1 penalty, automatically succeed at a proficiency or ability check, or cause an enemy to fail at such a check.\n\nThe favored can also turn undead.\n\n==Special Disadvantages==\nTymora is a fickle goddess, even for the favored. There is a cumulative 2% chance per day that the Special Ability will not work, because Tymora is distracted with someone else that she favors. Once a failure has been reached, the chance resets back to the initial 2%. This likelihood is checked at the beginning of the day. Of course, if the favored unknowingly does not use his special ability that day, well, that's a stroke of luck!\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Direction sense"],
                recommended: ["Local history", "riding", "land-based"],
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
        deity: "Tymora",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Favored"
    )

let embeddedKit082: Kit = Kit(
        id: "tymora_luckrider",
        name: "Tymora - Luckrider",
        wikiPageTitle: "Tymora - Luckrider (Character Kit)",
        redirectAliases: ["Luckrider (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "It is said that every back-alley dice game is an act of worship to Tymora. Whether this is true or not, Tymora has commissioned a type of cleric that oversees games of chance. Called the luckriders, these priests make sure that no one is involved in \"luck tampering\" (also known as \"cheating\"). They oversee as well as play in games of chance, and are familiar with the rules to all of them.",
            requirements: "Wisdom 9",
            specialBenefits: "If a luckrider is either playing or watching a game of chance, anyone attempting to cheat using the Gaming proficiency suffers a +1 penalty to the die roll for every experience level of the luckrider. Note that this may be sufficient to push that NPC's proficiency roll to 17 or higher, which means that the person is caught cheating.",
            specialHindrances: "If a luckrider plays a game of chance and rolls a 20, her opponents believe that she has cheated. Furthermore, if a luckrider does cheat in gaming, he loses access to his spells for 24 hours. In combat, if the luckrider successfully calls the number on a d20 attack roll before rolling the die, he hits the target successfully despite the die roll amount needed normally.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Gaming (x2)",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "It is said that every back-alley dice game is an act of worship to Tymora. Whether this is true or not, Tymora has commissioned a type of cleric that oversees games of chance. Called the luckriders, these priests make sure that no one is involved in \"luck tampering\" (also known as \"cheating\").",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Gaming (x2)\n|-\n| **Recommended Proficiencies** || Appraising, reading lips\n|}\n## Overview\nIt is said that every back-alley dice game is an act of worship to Tymora. Whether this is true or not, Tymora has commissioned a type of cleric that oversees games of chance. Called the luckriders, these priests make sure that no one is involved in \"luck tampering\" (also known as \"cheating\"). They oversee as well as play in games of chance, and are familiar with the rules to all of them.\n\n## Description\nLuckriders dress in simple black robes that are neither tight-fitting nor voluminous. A shining silver disk, the sign of Tymora, hangs on a chain around the luckrider's neck at all times.\n\n## Role-Playing\nEven more so than the favored, luckriders eat, drink, and sleep luck. They take games of chance quite seriously, making sure that no one cheats. Just because a cleric of Tymora seems to be enjoying himself in a game of cards doesn't mean he's not on the lookout for cheats.\n\n## Special Abilities\nIf a luckrider is either playing or watching a game of chance, anyone attempting to cheat using the Gaming proficiency suffers a +1 penalty to the die roll for every experience level of the luckrider. Note that this may be sufficient to push that NPC's proficiency roll to 17 or higher, which means that the person is caught cheating.\n\n## Special Disadvantages\nIf a luckrider plays a game of chance and rolls a 20, her opponents believe that she has cheated. Furthermore, if a luckrider does cheat in gaming, he loses access to his spells for 24 hours.\n\nIn combat, if the luckrider successfully calls the number on a d20 attack roll before rolling the die, he hits the target successfully despite the die roll amount needed normally.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Gaming (Proficiency)|Gaming]] (x2)\n|-\n| '''Recommended Proficiencies''' || [[Appraising (Proficiency)|Appraising]], [[Reading Lips (Proficiency)|reading lips]]\n|}__TOC__\n==Overview==\nIt is said that every back-alley dice game is an act of worship to Tymora. Whether this is true or not, Tymora has commissioned a type of cleric that oversees games of chance. Called the luckriders, these priests make sure that no one is involved in \"luck tampering\" (also known as \"cheating\"). They oversee as well as play in games of chance, and are familiar with the rules to all of them.\n\n==Description==\nLuckriders dress in simple black robes that are neither tight-fitting nor voluminous. A shining silver disk, the sign of Tymora, hangs on a chain around the luckrider's neck at all times.\n\n==Role-Playing==\nEven more so than the favored, luckriders eat, drink, and sleep luck. They take games of chance quite seriously, making sure that no one cheats. Just because a cleric of Tymora seems to be enjoying himself in a game of cards doesn't mean he's not on the lookout for cheats.\n\n==Special Abilities==\nIf a luckrider is either playing or watching a game of chance, anyone attempting to cheat using the Gaming proficiency suffers a +1 penalty to the die roll for every experience level of the luckrider. Note that this may be sufficient to push that NPC's proficiency roll to 17 or higher, which means that the person is caught cheating.\n\n==Special Disadvantages==\nIf a luckrider plays a game of chance and rolls a 20, her opponents believe that she has cheated. Furthermore, if a luckrider does cheat in gaming, he loses access to his spells for 24 hours.\n\nIn combat, if the luckrider successfully calls the number on a d20 attack roll before rolling the die, he hits the target successfully despite the die roll amount needed normally.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Gaming"],
                recommended: ["Appraising", "reading lips"],
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
        deity: "Tymora",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Luckrider"
    )

let embeddedKit083: Kit = Kit(
        id: "tyr_hand",
        name: "Tyr - Hand",
        wikiPageTitle: "Tyr - Hand (Character Kit)",
        redirectAliases: ["Priests of Tyr (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The scales are the priests of Tyr who judge evildoers, but Tyr's hands are the priests who actively track down and capture any malefactors. Hands of Tyr are similar to paladins in motivations, but they are still priests and members of Tyr's clergy. Hands are responsible for defending the weak and hunting down criminals and outlaws. If there are no local law authorities or scales of Tyr to judge an apprehended miscreant, the hands often dispense summary justice at the scene of the crime.",
            requirements: "Strength 14, Wisdom 9",
            specialBenefits: "A hand can detect evil at will up to a range of 60 feet, just like paladins can. When a hand reaches 7th level and she is allowed to handle items at the crime scene or any personal effects of an escaped criminal, she can use a unique form of find the path to track down the felon. This ability can be used once a month and, aside from operating until the felon has been captured, has all the normal abilities of a find the path spell.",
            specialHindrances: "If a criminal who is captured personally by a hand escapes justice, the priest will abandon all other duties and obsessively hunt down the felon. The hand's total concentration and full resources are dedicated to hunting down the fugitive of Tyr's judgement. For every twenty days that pass without capturing the criminal, the priest suffers a cumulative -1 (or +1, if applicable) penalty to all die rolls. If 200 days pass without the arrest or death of the criminal, the hand becomes ill and bedridden (Strength 2), and another hand of Tyr or a paladin must pursue the felon. If the criminal is captured or slain, the hand recovers his health and loses any penalties; if the villain isn't captured within a year of escaping, the hand dies.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Law, tracking",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "The scales are the priests of Tyr who judge evildoers, but Tyr's hands are the priests who actively track down and capture any malefactors. Hands of Tyr are similar to paladins in motivations, but they are still priests and members of Tyr's clergy.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Human\n|-\n| **Ability Requirements** || Strength 14,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || Yes\n|-\n| **Exceptional Constitution?** || Yes\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Law, tracking\n|-\n| **Recommended Proficiencies** || Blindfighting\n|}\n## Overview\nThe scales are the **priests of Tyr** who judge evildoers, but Tyr's hands are the priests who actively track down and capture any malefactors. Hands of Tyr are similar to paladins in motivations, but they are still priests and members of Tyr's clergy.\n\nHands are responsible for defending the weak and hunting down criminals and outlaws. If there are no local law authorities or scales of Tyr to judge an apprehended miscreant, the hands often dispense summary justice at the scene of the crime.\n\n## Description\nHands of Tyr wear white plate armor and full helms. Over their armor, they wear white and gold tabards with the symbol of Tyr embroidered in gold on the chest. Each hand wields a warhammer as the primary weapon, and hands never use shields. Hands of Tyr convey an image of themselves as pure, invincible, unstoppable instruments of the law. In that respect, they succeed rather well.\n\n## Role-Playing\nEach hand has the burning obsession to preserve the laws of his home city, province, or kingdom, no matter where they might be in the Realms. The primary duties of the hand are defending the helpless and hunting down criminals anywhere in the Realms and bringing them to justice. \"Thou shalt not get away with it\" is the sacred credo of the hand. Tireless agents of law and good, hands will go to nearly any lengths to catch a lawbreaker. However, a hand will never harm innocents or break any laws to bring a criminal to justice, no matter what the provocation or who the miscreant is.\n\nOn many occasions, the hand forgets to \"defend the weak\" in his passion to aggressively hunt down of criminals who've evaded justice. If the hands have a flaw, it is this single-minded, obsessive pursuit of justice. It often cools their compassion towards the weak and helpless, and leaves little or no mercy for criminals, no matter what provoked their lawbreaking.\n\n## Special Abilities\nA hand can detect evil at will up to a range of 60 feet, just like paladins can.\n\nWhen a hand reaches 7th level and she is allowed to handle items at the crime scene or any personal effects of an escaped criminal, she can use a unique form of find the path to track down the felon. This ability can be used once a month and, aside from operating until the felon has been captured, has all the normal abilities of a find the path spell.\n\n## Special Disadvantages\nIf a criminal who is captured personally by a hand escapes justice, the priest will abandon all other duties and obsessively hunt down the felon. The hand's total concentration and full resources are dedicated to hunting down the fugitive of Tyr's judgement. For every twenty days that pass without capturing the criminal, the priest suffers a cumulative -1 (or +1, if applicable) penalty to all die rolls. If 200 days pass without the arrest or death of the criminal, the hand becomes ill and bedridden (Strength 2), and another hand of Tyr or a paladin must pursue the felon. If the criminal is captured or slain, the hand recovers his health and loses any penalties; if the villain isn't captured within a year of escaping, the hand dies.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Human\n|-\n| '''Ability Requirements''' || [[Strength]] 14,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || Yes\n|-\n| '''Exceptional Constitution?''' || Yes\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Law (Proficiency)|Law]], [[Tracking (Proficiency)|tracking]]\n|-\n| '''Recommended Proficiencies''' || [[Blind-fighting (Proficiency)|Blindfighting]]\n|}__TOC__\n==Overview==\nThe scales are the '''priests of Tyr''' who judge evildoers, but Tyr's hands are the priests who actively track down and capture any malefactors. Hands of Tyr are similar to paladins in motivations, but they are still priests and members of Tyr's clergy.\n\nHands are responsible for defending the weak and hunting down criminals and outlaws. If there are no local law authorities or scales of Tyr to judge an apprehended miscreant, the hands often dispense summary justice at the scene of the crime.\n\n==Description==\nHands of Tyr wear white plate armor and full helms. Over their armor, they wear white and gold tabards with the symbol of Tyr embroidered in gold on the chest. Each hand wields a warhammer as the primary weapon, and hands never use shields. Hands of Tyr convey an image of themselves as pure, invincible, unstoppable instruments of the law. In that respect, they succeed rather well.\n\n==Role-Playing==\nEach hand has the burning obsession to preserve the laws of his home city, province, or kingdom, no matter where they might be in the Realms. The primary duties of the hand are defending the helpless and hunting down criminals anywhere in the Realms and bringing them to justice. \"Thou shalt not get away with it\" is the sacred credo of the hand. Tireless agents of law and good, hands will go to nearly any lengths to catch a lawbreaker. However, a hand will never harm innocents or break any laws to bring a criminal to justice, no matter what the provocation or who the miscreant is.\n\nOn many occasions, the hand forgets to \"defend the weak\" in his passion to aggressively hunt down of criminals who've evaded justice. If the hands have a flaw, it is this single-minded, obsessive pursuit of justice. It often cools their compassion towards the weak and helpless, and leaves little or no mercy for criminals, no matter what provoked their lawbreaking.\n\n==Special Abilities==\nA hand can detect evil at will up to a range of 60 feet, just like paladins can.\n\nWhen a hand reaches 7th level and she is allowed to handle items at the crime scene or any personal effects of an escaped criminal, she can use a unique form of find the path to track down the felon. This ability can be used once a month and, aside from operating until the felon has been captured, has all the normal abilities of a find the path spell.\n\n==Special Disadvantages==\nIf a criminal who is captured personally by a hand escapes justice, the priest will abandon all other duties and obsessively hunt down the felon. The hand's total concentration and full resources are dedicated to hunting down the fugitive of Tyr's judgement. For every twenty days that pass without capturing the criminal, the priest suffers a cumulative -1 (or +1, if applicable) penalty to all die rolls. If 200 days pass without the arrest or death of the criminal, the hand becomes ill and bedridden (Strength 2), and another hand of Tyr or a paladin must pursue the felon. If the criminal is captured or slain, the hand recovers his health and loses any penalties; if the villain isn't captured within a year of escaping, the hand dies.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Law", "tracking"],
                recommended: ["Blindfighting"],
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
        deity: "Tyr",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Hand"
    )

let embeddedKit084: Kit = Kit(
        id: "tyr_scale",
        name: "Tyr - Scale",
        wikiPageTitle: "Tyr - Scale (Character Kit)",
        redirectAliases: ["Scale (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "As the god of justice, Tyr has made it a priority for justice to be adequately served in the Realms. The scales are priests who act as arbiters and judges over any disputes they find, especially in communities with no courts or legal authorities of their own.",
            requirements: "Wisdom 16",
            specialBenefits: "With the balance scales, Tyr's scale can detect lie three times a day. If he wears a ring of truth, he can force someone to answer one question truthfully once per day. No saving throw is allowed against this effect.",
            specialHindrances: "If a scale ever deliberately lies, he is struck dumb until a specialty priest of Tyr casts remove curse on him. When a scale reaches 5th level, he has certainly jailed someone in the past who bears a grudge. The DM should create an evil NPC of 1d6 levels higher than the scale, who will become his sworn enemy.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Law",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "As the god of justice, Tyr has made it a priority for justice to be adequately served in the Realms. The scales are priests who act as arbiters and judges over any disputes they find, especially in communities with no courts or legal authorities of their own.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Human\n|-\n| **Ability Requirements** || Wisdom 16\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Law\n|-\n| **Recommended Proficiencies** || Religion\n|}\n## Overview\nAs the god of justice, Tyr has made it a priority for justice to be adequately served in the Realms. The scales are priests who act as arbiters and judges over any disputes they find, especially in communities with no courts or legal authorities of their own.\n\n## Description\nScales wear white robes of office, and they often wear chain or plate armor underneath them. They carry hammers as their main weapons. When in court, the scale's hammer also act as a symbol of Tyr's presence. In the other hand, the priest holds the other symbol of Tyr's justice: a set of silver balance scales.\n\nThe final piece of the scale's wardrobe is a gleaming white great helm with a sealed visor plate that can effective render the priest blind. In this condition, the scale is ready to judge a case without being distracted by extraneous details or swayed by the parties' appearances and any acts on their parts.\n\n## Role-Playing\nBy their own and their god's natures, scales are stern, humorless, logical, and highly-practical people. They are not concerned with mercy, but solely with justice. Even the cockiest and most cavalier thieves find their knees buckling before their stern presence.\n\n## Special Abilities\nWith the balance scales, Tyr's scale can detect lie three times a day. If he wears a ring of truth, he can force someone to answer one question truthfully once per day. No saving throw is allowed against this effect.\n\n## Special Disadvantages\nIf a scale ever deliberately lies, he is struck dumb until a specialty priest of Tyr casts remove curse on him.\n\nWhen a scale reaches 5th level, he has certainly jailed someone in the past who bears a grudge. The DM should create an evil NPC of 1d6 levels higher than the scale, who will become his sworn enemy.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Human\n|-\n| '''Ability Requirements''' || [[Wisdom]] 16\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Law (Proficiency)|Law]]\n|-\n| '''Recommended Proficiencies''' || [[Religion (Proficiency)|Religion]]\n|}__TOC__\n==Overview==\nAs the god of justice, Tyr has made it a priority for justice to be adequately served in the Realms. The scales are priests who act as arbiters and judges over any disputes they find, especially in communities with no courts or legal authorities of their own.\n\n==Description==\nScales wear white robes of office, and they often wear chain or plate armor underneath them. They carry hammers as their main weapons. When in court, the scale's hammer also act as a symbol of Tyr's presence. In the other hand, the priest holds the other symbol of Tyr's justice: a set of silver balance scales.\n\nThe final piece of the scale's wardrobe is a gleaming white great helm with a sealed visor plate that can effective render the priest blind. In this condition, the scale is ready to judge a case without being distracted by extraneous details or swayed by the parties' appearances and any acts on their parts.\n\n==Role-Playing==\nBy their own and their god's natures, scales are stern, humorless, logical, and highly-practical people. They are not concerned with mercy, but solely with justice. Even the cockiest and most cavalier thieves find their knees buckling before their stern presence.\n\n==Special Abilities==\nWith the balance scales, Tyr's scale can detect lie three times a day. If he wears a ring of truth, he can force someone to answer one question truthfully once per day. No saving throw is allowed against this effect.\n\n==Special Disadvantages==\nIf a scale ever deliberately lies, he is struck dumb until a specialty priest of Tyr casts remove curse on him.\n\nWhen a scale reaches 5th level, he has certainly jailed someone in the past who bears a grudge. The DM should create an evil NPC of 1d6 levels higher than the scale, who will become his sworn enemy.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 16],
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
                bonus: ["Law"],
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
        deity: "Tyr",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Scale"
    )

let embeddedKit085: Kit = Kit(
        id: "umberlee_anchor",
        name: "Umberlee - Anchor",
        wikiPageTitle: "Umberlee - Anchor (Character Kit)",
        redirectAliases: ["Priests of Umberle (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Even without the mercurial gods of the Realms, the sea is a place rife with danger. Storms, navigational hazards, and sea creatures all combine to make water travel a challenging hazard. The anchors are priests who save people from drowning and help guide boats past water hazards. Naturally, a fee is involved for these services.",
            requirements: "Constitution 14, Wisdom 9",
            specialBenefits: "All Anchors can speak with animals at will, though this is limited to marine life. They can turn aquatic undead only. These priests are not limited to evil alignments: they can be true neutral or chaotic neutral as well.",
            specialHindrances: "Anchors cannot wear armor, and they cannot cast any spells that deal with fire or earth. Like tempests, they must donate 30% of their earned fees, but this money goes directly to the church of Umberlee.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Swimming",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Even without the mercurial gods of the Realms, the sea is a place rife with danger. Storms, navigational hazards, and sea creatures all combine to make water travel a challenging hazard. The anchors are priests who save people from drowning and help guide boats past water hazards.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Constitution 14, Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Swimming\n|-\n| **Recommended Proficiencies** || Navigation, Seamanship\n|}\n## Overview\nEven without the mercurial gods of the Realms, the sea is a place rife with danger. Storms, navigational hazards, and sea creatures all combine to make water travel a challenging hazard. The anchors are priests who save people from drowning and help guide boats past water hazards. Naturally, a fee is involved for these services.\n\n## Description\nSince anchors wind up in the water more often that not, they wear just enough clothing to preserve their modesty. This is usually dark blue swimming apparel. When on land, they dress in blue-green bodystockings and they also wear a warm white cloak draped over their shoulders for comfort. Some have a rare tiara of black coral as a badge of distinction among the clergy.\n\nMost anchors favor harpoons, tridents, and daggers for weapons. They reject armor, which tends to make them sink in water.\n\n## Role-Playing\nAn anchor is a cross between a mercenary and a lifeguard. On one hand, the anchors do have a genuine desire to save drowning victims and prevent ships from running aground. On the other hand, they expect to be well paid for it, usually demanding 50gp per level or hit die of the rescued being.\n\n## Special Abilities\nAll Anchors can speak with animals at will, though this is limited to marine life. They can turn aquatic undead only. These priests are not limited to evil alignments: they can be true neutral or chaotic neutral as well.\n\n## Special Disadvantages\nAnchors cannot wear armor, and they cannot cast any spells that deal with fire or earth. Like tempests, they must donate 30% of their earned fees, but this money goes directly to the church of Umberlee.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Constitution]] 14, [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Swimming (Proficiency)|Swimming]]\n|-\n| '''Recommended Proficiencies''' || [[Navigation (Proficiency)|Navigation]], [[Seamanship (Proficiency)|Seamanship]]\n|}__TOC__\n==Overview==\nEven without the mercurial gods of the Realms, the sea is a place rife with danger. Storms, navigational hazards, and sea creatures all combine to make water travel a challenging hazard. The anchors are priests who save people from drowning and help guide boats past water hazards. Naturally, a fee is involved for these services.\n\n==Description==\nSince anchors wind up in the water more often that not, they wear just enough clothing to preserve their modesty. This is usually dark blue swimming apparel. When on land, they dress in blue-green bodystockings and they also wear a warm white cloak draped over their shoulders for comfort. Some have a rare tiara of black coral as a badge of distinction among the clergy.\n\nMost anchors favor harpoons, tridents, and daggers for weapons. They reject armor, which tends to make them sink in water.\n\n==Role-Playing==\nAn anchor is a cross between a mercenary and a lifeguard. On one hand, the anchors do have a genuine desire to save drowning victims and prevent ships from running aground. On the other hand, they expect to be well paid for it, usually demanding 50gp per level or hit die of the rescued being.\n\n==Special Abilities==\nAll Anchors can speak with animals at will, though this is limited to marine life. They can turn aquatic undead only. These priests are not limited to evil alignments: they can be true neutral or chaotic neutral as well.\n\n==Special Disadvantages==\nAnchors cannot wear armor, and they cannot cast any spells that deal with fire or earth. Like tempests, they must donate 30% of their earned fees, but this money goes directly to the church of Umberlee.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Constitution": 14, "Wisdom": 9],
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
                bonus: ["Swimming"],
                recommended: ["Navigation", "Seamanship"],
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
        deity: "Umberlee",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Anchor"
    )

let embeddedKit086: Kit = Kit(
        id: "umberlee_tempest",
        name: "Umberlee - Tempest",
        wikiPageTitle: "Umberlee - Tempest (Character Kit)",
        redirectAliases: ["Tempest (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Umberlee, the goddess of storms, waves, and sea winds, has seen the benefits of creating a sect of priests called tempests. These special priests work with weather, and help fill the coffers of Umberlee with the donations of mariners who want to have smooth sailing for their voyages.",
            requirements: "Wisdom 9",
            specialBenefits: "Tempests can cast certain mage spells that duplicate meteorological phenomena. The eligible spells are: wall of fog, fog cloud, whispering wind, lightning bolt, cone of cold, death fog, incendiary cloud, wind wall, solid fog, control weather, lower water, part water, and gust of wind. Others can be added if mutually agreed to by the players and the DM. These spells are prayed for as if they were clerical spells of their same spell levels, since Umberlee herself grants them. They do replace the regular priest spells the tempest can cast. The tempest casts them at his level of experience as a priest.",
            specialHindrances: "Tampering with the weather is not without its risks. Gods such as Talos, Silvanus, Eldath, and Chauntea do not tolerate such things often. Every time a tempest directly affects the weather (summoning a storm, using the spell control weather), there is a 5% chance that one of the above deities will prevent the spell from happening. Then, in 1d4+1 weeks, a druid or respective specialty priest of 0-3 levels higher (1d4-1) than the tempest will pay a visit to the cleric and convince him of the \"error of his ways\". Most of the time, this is done with call lightning. Tempests must tithe 30% of all the fees paid to him by mariners directly to Umberlee. In other words, the money is thrown into the sea after receiving it. Tempests cannot turn any undead whatsoever, regardless of whether or not it came from the sea.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Weather sense",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Umberlee, the goddess of storms, waves, and sea winds, has seen the benefits of creating a sect of priests called tempests. These special priests work with weather, and help fill the coffers of Umberlee with the donations of mariners who want to have smooth sailing for their voyages.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Half-elf, human\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest, Wizard\n|-\n| **Bonus Proficiencies** || Weather sense\n|-\n| **Recommended Proficiencies** || Seamanship, swimming\n|}\n## Overview\nUmberlee, the goddess of storms, waves, and sea winds, has seen the benefits of creating a sect of priests called tempests. These special priests work with weather, and help fill the coffers of Umberlee with the donations of mariners who want to have smooth sailing for their voyages.\n\n## Description\nThe tempests dress in the traditional bodystocking of blue-green, with a white cape trimmed with white fur. However, some clerics also wear a tiara of jet black coral, a special badge of honor among Umberlee's faithful.\n\nTempests refuse to wear armor and shields, and favor carrying a trident if forced into battle.\n\n## Role-Playing\nLike the waters of the Moonsea in Uktar, the tempests of Umberlee have violent mood swings that go from tranquility to violent physical rage in mere moments.\n\nThese extreme moods are usually triggered by an offense, although the definition of offense is completely in the mind of the tempest and it is totally unpredictable.\n\nDespite their chaotic evil alignment, Tempests can be trusted to do what they are paid for. If a ship captain pays for a good westerly wind and no storms, then it shall be done. Fees are usually 1d4+1 gold pieces for each person on the boat and an additional 3d10 gold pieces for the vessel itself.\n\nThe tempests' chaotic and evil impulses are manifested in fits of destruction when angered. During these tantrums, no one and nothing is safe from their wrath. Tempests are, all in all, extremists. They are fiercely loyal to friends, passionate lovers, and violent brutes to their enemies.\n\n## Special Abilities\nTempests can cast certain mage spells that duplicate meteorological phenomena. The eligible spells are: wall of fog, fog cloud, whispering wind, lightning bolt, cone of cold, death fog, incendiary cloud, wind wall, solid fog, control weather, lower water, part water, and gust of wind. Others can be added if mutually agreed to by the players and the DM.\n\nThese spells are prayed for as if they were clerical spells of their same spell levels, since Umberlee herself grants them. They do replace the regular priest spells the tempest can cast. The tempest casts them at his level of experience as a priest.\n\n## Special Disadvantages\nTampering with the weather is not without its risks. Gods such as Talos, Silvanus, Eldath, and Chauntea do not tolerate such things often. Every time a tempest directly affects the weather (summoning a storm, using the spell control weather), there is a 5% chance that one of the above deities will prevent the spell from happening. Then, in 1d4+1 weeks, a druid or respective specialty priest of 0-3 levels higher (1d4-1) than the tempest will pay a visit to the cleric and convince him of the \"error of his ways\". Most of the time, this is done with call lightning.\n\nTempests must tithe 30% of all the fees paid to him by mariners directly to Umberlee. In other words, the money is thrown into the sea after receiving it.\n\nTempests cannot turn any undead whatsoever, regardless of whether or not it came from the sea.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Half-elf, human\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest, Wizard\n|-\n| '''Bonus Proficiencies''' || [[Weather Sense (Proficiency)|Weather sense]]\n|-\n| '''Recommended Proficiencies''' || [[Seamanship (Proficiency)|Seamanship]], [[Swimming (Proficiency)|swimming]]\n|}__TOC__\n==Overview==\nUmberlee, the goddess of storms, waves, and sea winds, has seen the benefits of creating a sect of priests called tempests. These special priests work with weather, and help fill the coffers of Umberlee with the donations of mariners who want to have smooth sailing for their voyages.\n\n==Description==\nThe tempests dress in the traditional bodystocking of blue-green, with a white cape trimmed with white fur. However, some clerics also wear a tiara of jet black coral, a special badge of honor among Umberlee's faithful.\n\nTempests refuse to wear armor and shields, and favor carrying a trident if forced into battle.\n\n==Role-Playing==\nLike the waters of the Moonsea in Uktar, the tempests of Umberlee have violent mood swings that go from tranquility to violent physical rage in mere moments.\n\nThese extreme moods are usually triggered by an offense, although the definition of offense is completely in the mind of the tempest and it is totally unpredictable.\n\nDespite their chaotic evil alignment, Tempests can be trusted to do what they are paid for. If a ship captain pays for a good westerly wind and no storms, then it shall be done. Fees are usually 1d4+1 gold pieces for each person on the boat and an additional 3d10 gold pieces for the vessel itself.\n\nThe tempests' chaotic and evil impulses are manifested in fits of destruction when angered. During these tantrums, no one and nothing is safe from their wrath. Tempests are, all in all, extremists. They are fiercely loyal to friends, passionate lovers, and violent brutes to their enemies.\n\n==Special Abilities==\nTempests can cast certain mage spells that duplicate meteorological phenomena. The eligible spells are: wall of fog, fog cloud, whispering wind, lightning bolt, cone of cold, death fog, incendiary cloud, wind wall, solid fog, control weather, lower water, part water, and gust of wind. Others can be added if mutually agreed to by the players and the DM.\n\nThese spells are prayed for as if they were clerical spells of their same spell levels, since Umberlee herself grants them. They do replace the regular priest spells the tempest can cast. The tempest casts them at his level of experience as a priest.\n\n==Special Disadvantages==\nTampering with the weather is not without its risks. Gods such as Talos, Silvanus, Eldath, and Chauntea do not tolerate such things often. Every time a tempest directly affects the weather (summoning a storm, using the spell control weather), there is a 5% chance that one of the above deities will prevent the spell from happening. Then, in 1d4+1 weeks, a druid or respective specialty priest of 0-3 levels higher (1d4-1) than the tempest will pay a visit to the cleric and convince him of the \"error of his ways\". Most of the time, this is done with call lightning.\n\nTempests must tithe 30% of all the fees paid to him by mariners directly to Umberlee. In other words, the money is thrown into the sea after receiving it.\n\nTempests cannot turn any undead whatsoever, regardless of whether or not it came from the sea.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9],
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
                bonus: ["Weather sense"],
                recommended: ["Seamanship", "swimming"],
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
        deity: "Umberlee",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Tempest"
    )

let embeddedKit087: Kit = Kit(
        id: "valkur_stormharbor",
        name: "Valkur - Stormharbor",
        wikiPageTitle: "Valkur - Stormharbor (Character Kit)",
        redirectAliases: ["Priests of Valkur (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Valkur is a demipower venerated primarily by sailors. Stormharbors are special priests of Valkur who try their best to intercede on behalf of mariners to a god who tends to be fickle and unpredictable. The stormharbors are attempting to build support for Valkur's church. They want to make it grow by showing that Valkur can indeed be counted upon to protect the helpless from the wrath of either Umberlee or Talos. Now if the priests could only get Valkur to cooperate with them, things would be fine.",
            requirements: "Wisdom 9",
            specialBenefits: "By making an ability check against Wisdom, a stormharbor can determine whether a bad weather condition or disaster comes naturally or arises as a result of the servants of Talos or Umberlee. Stormharbors gain a +1 bonus to these checks per level starting at 3rd level. Valkur sometimes uses dolphins as his sign that his presence is near. All stormharbors can speak with dolphins at will. Three times a day, a stormharbor have a 60% chance plus 1% per level of summoning 1d4 dolphins. They arrive in 3d10 minutes, but only if they are native to the body of water the stormharbor is in. The dolphins will talk to the stormharbor and answer his questions, but they will not take possible fatal risks for the priest. At 7th level, a stormharbor can shapechange into a dolphin twice a day. Shapechanging from human to dolphin form heals 1d6 points of any existing damage.",
            specialHindrances: "At any given time, there is always a chance that Valkur isn't paying attention to his stormharbors. Thus, there is a flat 10% chance that any clerical spell cast by a stormharbor will utterly fail. Stormharbors also cannot turn undead. Since the clergymen of Valkur are trying to build up a popular mariner's faith all over Faerûn, stormharbors must give 40% of all their treasures to the church.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Seamanship, swimming, weather sense",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Valkur is a demipower venerated primarily by sailors. Stormharbors are special priests of Valkur who try their best to intercede on behalf of mariners to a god who tends to be fickle and unpredictable.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Seamanship, swimming, weather sense\n|-\n| **Recommended Proficiencies** || Navigation\n|}\n## Overview\nValkur is a demipower venerated primarily by sailors. Stormharbors are special **priests of Valkur** who try their best to intercede on behalf of mariners to a god who tends to be fickle and unpredictable.\n\nThe stormharbors are attempting to build support for Valkur's church. They want to make it grow by showing that Valkur can indeed be counted upon to protect the helpless from the wrath of either Umberlee or Talos. Now if the priests could only get Valkur to cooperate with them, things would be fine.\n\n## Description\nThe stormharbors try to present Valkur in a stable, serene light to put doubting worshipers' minds at ease. The clergy wears tunics of shimmering deep blue to symbolize placid waters. The stormharbors' outfit is completed by a white clerical stole embroidered with gold threads in designs of dolphins, anchors, lighthouses, and sea gulls and other sea birds for good luck.\n\nStormharbors use clubs, staves, daggers, tridents, and cutlasses in battle. Due to the impediments of armor to a swimmer, stormharbors do not wear any.\n\n## Role-Playing\nThe stormharbors are a clergy anxious to prove that their god Valkur is dependable. Since the clergy is a reflection of the god, they strive to appear tranquil, slow to anger, and not prone to sudden changes of plans, opinions, or mindsets. Reliability and patience are the virtues most embraced by stormharbors. Their reliability is impeccable, since they want others to see that the faith is solid and trustworthy. Their patience is hardearned, because Valkur isn't as trustworthy as a devotee might wish, and the priests need to live with their god's chaotic behavior.\n\n## Special Abilities\nBy making an ability check against Wisdom, a stormharbor can determine whether a bad weather condition or disaster comes naturally or arises as a result of the servants of Talos or Umberlee. Stormharbors gain a +1 bonus to these checks per level starting at 3rd level.\n\nValkur sometimes uses dolphins as his sign that his presence is near. All stormharbors can speak with dolphins at will. Three times a day, a stormharbor have a 60% chance plus 1% per level of summoning 1d4 dolphins. They arrive in 3d10 minutes, but only if they are native to the body of water the stormharbor is in. The dolphins will talk to the stormharbor and answer his questions, but they will not take possible fatal risks for the priest.\n\nAt 7th level, a stormharbor can shapechange into a dolphin twice a day. Shapechanging from human to dolphin form heals 1d6 points of any existing damage.\n\n## Special Disadvantages\nAt any given time, there is always a chance that Valkur isn't paying attention to his stormharbors. Thus, there is a flat 10% chance that any clerical spell cast by a stormharbor will utterly fail. Stormharbors also cannot turn undead.\n\nSince the clergymen of Valkur are trying to build up a popular mariner's faith all over Faerûn, stormharbors must give 40% of all their treasures to the church.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Seamanship (Proficiency)|Seamanship]], [[Swimming (Proficiency)|swimming]], [[Weather Sense (Proficiency)|weather sense]]\n|-\n| '''Recommended Proficiencies''' || [[Navigation (Proficiency)|Navigation]]\n|}__TOC__\n==Overview==\nValkur is a demipower venerated primarily by sailors. Stormharbors are special '''priests of Valkur''' who try their best to intercede on behalf of mariners to a god who tends to be fickle and unpredictable.\n\nThe stormharbors are attempting to build support for Valkur's church. They want to make it grow by showing that Valkur can indeed be counted upon to protect the helpless from the wrath of either Umberlee or Talos. Now if the priests could only get Valkur to cooperate with them, things would be fine.\n\n==Description==\nThe stormharbors try to present Valkur in a stable, serene light to put doubting worshipers' minds at ease. The clergy wears tunics of shimmering deep blue to symbolize placid waters. The stormharbors' outfit is completed by a white clerical stole embroidered with gold threads in designs of dolphins, anchors, lighthouses, and sea gulls and other sea birds for good luck.\n\nStormharbors use clubs, staves, daggers, tridents, and cutlasses in battle. Due to the impediments of armor to a swimmer, stormharbors do not wear any.\n\n==Role-Playing==\nThe stormharbors are a clergy anxious to prove that their god Valkur is dependable. Since the clergy is a reflection of the god, they strive to appear tranquil, slow to anger, and not prone to sudden changes of plans, opinions, or mindsets. Reliability and patience are the virtues most embraced by stormharbors. Their reliability is impeccable, since they want others to see that the faith is solid and trustworthy. Their patience is hardearned, because Valkur isn't as trustworthy as a devotee might wish, and the priests need to live with their god's chaotic behavior.\n\n==Special Abilities==\nBy making an ability check against Wisdom, a stormharbor can determine whether a bad weather condition or disaster comes naturally or arises as a result of the servants of Talos or Umberlee. Stormharbors gain a +1 bonus to these checks per level starting at 3rd level.\n\nValkur sometimes uses dolphins as his sign that his presence is near. All stormharbors can speak with dolphins at will. Three times a day, a stormharbor have a 60% chance plus 1% per level of summoning 1d4 dolphins. They arrive in 3d10 minutes, but only if they are native to the body of water the stormharbor is in. The dolphins will talk to the stormharbor and answer his questions, but they will not take possible fatal risks for the priest.\n\nAt 7th level, a stormharbor can shapechange into a dolphin twice a day. Shapechanging from human to dolphin form heals 1d6 points of any existing damage.\n\n==Special Disadvantages==\nAt any given time, there is always a chance that Valkur isn't paying attention to his stormharbors. Thus, there is a flat 10% chance that any clerical spell cast by a stormharbor will utterly fail. Stormharbors also cannot turn undead.\n\nSince the clergymen of Valkur are trying to build up a popular mariner's faith all over Faerûn, stormharbors must give 40% of all their treasures to the church.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Seamanship", "swimming", "weather sense"],
                recommended: ["Navigation"],
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
                notes: "Stormharbors also cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Valkur",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Stormharbor"
    )

let embeddedKit088: Kit = Kit(
        id: "village_druid",
        name: "Village Druid",
        wikiPageTitle: "Village Druid (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "A Village Druid normally replaces a conventional priest or cleric in villages where most inhabitants subscribe to the druidic ethos. As well as offering protection and guidance, the druid leads the citizenry in ceremonies to observe births (of humans and animals), deaths, marriages, harvests, the changing of the seasons, and so on. (See Chapter 4: Role-playing Druids for details.) This kit suits PCs when the DM decides to set the campaign in a rural area under a threat or perhaps near unexplored ruins.",
            requirements: nil,
            specialBenefits: "With the DM, decide which village a druid like Kabil protects; the druid lives in or near this village. Locals respect Kabil highly and provide him with information about happenings in the area. He receives a +2 reaction bonus from people and domestic animals in the village—as long as he remains diligent about his duties. In addition, the villagers support Kabil at a middle-class lifestyle (DMG, p.&nbsp;34). This hospitality, rather than tithes, represents the generosity of a grateful people willing to provide their Village Druid with the best of everything he needs to live in their midst.",
            specialHindrances: "As a Village Druid, Kabil doesn't have a lot of free time. Locals ask him for help with all their problems, ranging from bandit raids to a child lost in the woods. In addition, the druid must spend at least one day each week attending to village matters: listening to grievances, mediating disputes, finding lost livestock, tending animals, offering advice on crops, curing diseases, delivering babies, etc. If he misses a week, his reaction bonus drops by 1 point (minimum 0) and his income declines a step (from middle class to poor to squalid) as people become less hospitable. The druid can avoid these penalties if he arranges with someone else (another druid or a ranger) to look after the village in his absence. Kabil's villagers also expect him to protect them from serious harm. If he fails or if no one sees him at least making an honest effort the DM may reduce or eliminate his reaction bonus and benefits for as long as the villagers likely would feel resentful. Role-playing can win back a Village Druid's lost respect; Kabil can regain his lost reaction bonus and benefits quickly by doing a great deed to benefit the village, or slowly by simply completing his duties diligently for several months.",
            wealthOptions: "3d6x10 gp.",
            weaponProficiencies: "* Required—sickle or scythe. * Recommended—staff.",
            nonweaponProficiencies: "* Bonus—agriculture. * Recommended—(general) animal training, brewing, rope use, weather sense; (priest) healing, herbalism, local history, religion.",
            equipment: "The druid should spend his initial allotment of gold pieces entirely upon equipment, as he loses all unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "Kabil the Village Druid (next page) associates himself closely with a single rustic village or hamlet. As he gains experience, his influence can extend to cover a shire, barony, or entire region. However, his focus remains rural. A Village Druid always hopes to see ordinary folk live in harmony with Nature.",
            fullText: "## Village Druid\nKabil the Village Druid (next page) associates himself closely with a single rustic village or hamlet. As he gains experience, his influence can extend to cover a shire, barony, or entire region. However, his focus remains rural. A Village Druid always hopes to see ordinary folk live in harmony with Nature.\n\nAs a Village Druid, Kabil's aim is twofold: to keep people from exploiting Nature (by short-sighted agricultural practices, etc.) and to defend and protect villagers who follow the proper druidic path. Thus, although he will not stand idly by to see the wilderness threatened, his more vital interest lies with the local crops, domestic animals, and his own followers. Kabil uses his skills and magic to protect all living things within his village from foes, disease, drought, forest fires, or natural disasters.\n\n**Role:** A Village Druid normally replaces a conventional priest or cleric in villages where most inhabitants subscribe to the druidic ethos. As well as offering protection and guidance, the druid leads the citizenry in ceremonies to observe births (of humans and animals), deaths, marriages, harvests, the changing of the seasons, and so on. (See Chapter 4: Role-playing Druids for details.)\n\nThis kit suits PCs when the DM decides to set the campaign in a rural area under a threat or perhaps near unexplored ruins.\n\n**Branch Restrictions:** None.\n\n**Weapon Proficiencies:**\n* *Required*—sickle or scythe.\n* *Recommended*—staff.\n\n**Secondary Skills:** Farmer, forester, groom.\n\n**Nonweapon Proficiencies:**\n* *Bonus*—agriculture.\n* *Recommended*—(general) animal training, brewing, rope use, weather sense; (priest) healing, herbalism, local history, religion.\n\n**Equipment:** The druid should spend his initial allotment of gold pieces entirely upon equipment, as he loses all unspent starting money in excess of 1 gp.\n\n**Special Benefits:** With the DM, decide which village a druid like Kabil protects; the druid lives in or near this village.\n\nLocals respect Kabil highly and provide him with information about happenings in the area. He receives a +2 reaction bonus from people and domestic animals in the village—as long as he remains diligent about his duties. In addition, the villagers support Kabil at a middle-class lifestyle (*DMG*, p.&nbsp;34). This hospitality, rather than tithes, represents the generosity of a grateful people willing to provide their Village Druid with the best of everything he needs to live in their midst.\n\n**Special Hindrances:** As a Village Druid, Kabil doesn't have a lot of free time. Locals ask him for help with all their problems, ranging from bandit raids to a child lost in the woods. In addition, the druid must spend at least one day each week attending to village matters: listening to grievances, mediating disputes, finding lost livestock, tending animals, offering advice on crops, curing diseases, delivering babies, etc. If he misses a week, his reaction bonus drops by 1 point (minimum 0) and his income declines a step (from middle class to poor to squalid) as people become less hospitable. The druid can avoid these penalties if he arranges with someone else (another druid or a ranger) to look after the village in his absence.\n\nKabil's villagers also expect him to protect them from serious harm. If he fails or if no one sees him at least making an honest effort the DM may reduce or eliminate his reaction bonus and benefits for as long as the villagers likely would feel resentful. Role-playing can win back a Village Druid's lost respect; Kabil can regain his lost reaction bonus and benefits quickly by doing a great deed to benefit the village, or slowly by simply completing his duties diligently for several months.\n\n**Wealth Options:** 3d6x10 gp.",
            rawWikitext: "{{Sidebar CDH Ch2}}__NOTOC__\n==Village Druid==\nKabil the Village Druid (next page) associates himself closely with a single rustic village or hamlet. As he gains experience, his influence can extend to cover a shire, barony, or entire region. However, his focus remains rural. A Village Druid always hopes to see ordinary folk live in harmony with Nature.\n\nAs a Village Druid, Kabil's aim is twofold: to keep people from exploiting Nature (by short-sighted agricultural practices, etc.) and to defend and protect villagers who follow the proper druidic path. Thus, although he will not stand idly by to see the wilderness threatened, his more vital interest lies with the local crops, domestic animals, and his own followers. Kabil uses his skills and magic to protect all living things within his village from foes, disease, drought, forest fires, or natural disasters.\n\n'''Role:''' A Village Druid normally replaces a conventional priest or cleric in villages where most inhabitants subscribe to the druidic ethos. As well as offering protection and guidance, the druid leads the citizenry in ceremonies to observe births (of humans and animals), deaths, marriages, harvests, the changing of the seasons, and so on. (See Chapter 4: Role-playing Druids for details.)\n\nThis kit suits PCs when the DM decides to set the campaign in a rural area under a threat or perhaps near unexplored ruins.\n\n'''Branch Restrictions:''' None.\n\n'''Weapon Proficiencies:'''\n* ''Required''—sickle or scythe.\n* ''Recommended''—staff.\n\n'''Secondary Skills:''' Farmer, forester, groom.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus''—[[Agriculture (Proficiency)|agriculture]].\n* ''Recommended''—(general) [[Animal Training (Proficiency)|animal training]], [[Brewing (Proficiency)|brewing]], [[Rope Use (Proficiency)|rope use]], [[Weather Sense (Proficiency)|weather sense]]; (priest) [[Healing (Proficiency)|healing]], [[Herbalism (Proficiency)|herbalism]], [[Local History (Proficiency)|local history]], [[Religion (Proficiency)|religion]].\n\n'''Equipment:''' The druid should spend his initial allotment of gold pieces entirely upon equipment, as he loses all unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' With the DM, decide which village a druid like Kabil protects; the druid lives in or near this village.\n\nLocals respect Kabil highly and provide him with information about happenings in the area. He receives a +2 reaction bonus from people and domestic animals in the village—as long as he remains diligent about his duties. In addition, the villagers support Kabil at a middle-class lifestyle [[Expenses (DMG)|(''DMG'', p.&nbsp;34)]]. This hospitality, rather than tithes, represents the generosity of a grateful people willing to provide their Village Druid with the best of everything he needs to live in their midst.\n\n'''Special Hindrances:''' As a Village Druid, Kabil doesn't have a lot of free time. Locals ask him for help with all their problems, ranging from bandit raids to a child lost in the woods. In addition, the druid must spend at least one day each week attending to village matters: listening to grievances, mediating disputes, finding lost livestock, tending animals, offering advice on crops, curing diseases, delivering babies, etc. If he misses a week, his reaction bonus drops by 1 point (minimum 0) and his income declines a step (from middle class to poor to squalid) as people become less hospitable. The druid can avoid these penalties if he arranges with someone else (another druid or a ranger) to look after the village in his absence.\n\nKabil's villagers also expect him to protect them from serious harm. If he fails or if no one sees him at least making an honest effort the DM may reduce or eliminate his reaction bonus and benefits for as long as the villagers likely would feel resentful. Role-playing can win back a Village Druid's lost respect; Kabil can regain his lost reaction bonus and benefits quickly by doing a great deed to benefit the village, or slowly by simply completing his duties diligently for several months.\n\n'''Wealth Options:''' 3d6x10 gp.\n\n{{Navbox The Complete Druid's Handbook}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: [:],
                alignments: ["True Neutral"],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: ["sickle or scythe"],
                recommended: ["staff"],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["agriculture"],
                recommended: ["animal training", "brewing", "rope use", "weather sense", "healing", "herbalism", "local history", "religion"],
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

let embeddedKit089: Kit = Kit(
        id: "wanderer",
        name: "Wanderer",
        wikiPageTitle: "Wanderer (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "Wanderers like Fife (right), more gregarious than most druids, enjoy meeting and talking with people—especially rural folk. Although Fife acts carefree, this genial nature masks a keen mind and a strong interest in everything going on around her. Many Wanderers have animal companions.",
            requirements: nil,
            specialBenefits: "A Wanderer like Fife receives a +1 reaction adjustment bonus from bards, rangers and traveling folk such as tinkers and Gypsies. When traveling over long distances, Fife covers ground at a one-third faster rate than a normal traveler would—that is, if a normal person can walk 24 miles in a day without force-marching, the druid can walk 32 miles with the same exertion. Fife, like all Wanderers, simply feels more accustomed to walking long distances than most—plus, she knows short cuts and secret trails. (This heightened speed is cumulative with the ability of many druids 3rd level and higher to travel through overgrowth or other difficult terrain without penalty.) With a Wanderer guide, a party can increase travel time by one-sixth; thus, an unencumbered party led by a Wanderer would travel 28 miles in a day, not 24.",
            specialHindrances: "Constantly on the move, a Wanderer never allows herself to be burdened. Fife cannot have retainers, hirelings, mercenaries, or even servants until she reaches 12th level (but animal companions can travel with her). The druid cannot possess more treasure than she can carry; she either converts the excess into a portable form (gems, etc.) or donates it to a worthy cause, such as the druidic order.",
            wealthOptions: "3d6x10 gp.",
            weaponProficiencies: "Recommended—staff, one other weapon.",
            nonweaponProficiencies: "Bonus—direction sense. : Recommended—(general) animal training, singing, weather sense; (priest) healing, herbalism, religion; (warrior) mountaineering, running, survival, tracking.",
            equipment: "The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses all unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "While most druids eventually settle in a specific locale, Wanderers travel widely, delighting in Nature's infinite variety of life. They typically have a better idea of the \"big picture\" in the world than other druids and usually remain on good terms with local bards and rangers.",
            fullText: "## Wanderer\nWhile most druids eventually settle in a specific locale, Wanderers travel widely, delighting in Nature's infinite variety of life. They typically have a better idea of the \"big picture\" in the world than other druids and usually remain on good terms with local bards and rangers. Druidic leaders often use Wanderers as messengers or missionaries.\n\n**Role:** Wanderers like Fife (right), more gregarious than most druids, enjoy meeting and talking with people—especially rural folk. Although Fife acts carefree, this genial nature masks a keen mind and a strong interest in everything going on around her. Many Wanderers have animal companions.\n\n**Branch Restrictions:** None.\n\n**Weapon Proficiencies:** *Recommended*—staff, one other weapon.\n\n**Secondary Skills:** Hunter, navigator.\n\n**Nonweapon Proficiencies:**\n: *Bonus*—direction sense.\n: *Recommended*—(general) animal training, singing, weather sense; (priest) healing, herbalism, religion; (warrior) mountaineering, running, survival, tracking.\n\n**Equipment:** The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses all unspent starting money in excess of 1 gp.\n\n**Special Benefits:** A Wanderer like Fife receives a +1 reaction adjustment bonus from bards, rangers and traveling folk such as tinkers and Gypsies.\n\nWhen traveling over long distances, Fife covers ground at a one-third faster rate than a normal traveler would—that is, if a normal person can walk 24 miles in a day without force-marching, the druid can walk 32 miles with the same exertion. Fife, like all Wanderers, simply feels more accustomed to walking long distances than most—plus, she knows short cuts and secret trails. (This heightened speed is cumulative with the ability of many druids 3rd level and higher to travel through overgrowth or other difficult terrain without penalty.)\n\nWith a Wanderer guide, a party can increase travel time by one-sixth; thus, an unencumbered party led by a Wanderer would travel 28 miles in a day, not 24.\n\n**Special Hindrances:** Constantly on the move, a Wanderer never allows herself to be burdened. Fife cannot have retainers, hirelings, mercenaries, or even servants until she reaches 12th level (but animal companions can travel with her). The druid cannot possess more treasure than she can carry; she either converts the excess into a portable form (gems, etc.) or donates it to a worthy cause, such as the druidic order.\n\n**Wealth Options:** 3d6x10 gp.",
            rawWikitext: "{{Sidebar CDH Ch2}}__NOTOC__\n==Wanderer==\nWhile most druids eventually settle in a specific locale, Wanderers travel widely, delighting in Nature's infinite variety of life. They typically have a better idea of the \"big picture\" in the world than other druids and usually remain on good terms with local bards and rangers. Druidic leaders often use Wanderers as messengers or missionaries.\n\n'''Role:''' Wanderers like Fife (right), more gregarious than most druids, enjoy meeting and talking with people—especially rural folk. Although Fife acts carefree, this genial nature masks a keen mind and a strong interest in everything going on around her. Many Wanderers have animal companions.\n\n'''Branch Restrictions:''' None.\n\n'''Weapon Proficiencies:''' ''Recommended''—staff, one other weapon.\n\n'''Secondary Skills:''' Hunter, navigator.\n\n'''Nonweapon Proficiencies:'''\n: ''Bonus''—[[Direction Sense (Proficiency)|direction sense]].\n: ''Recommended''—(general) [[Animal Training (Proficiency)|animal training]], [[Singing (Proficiency)|singing]], [[Weather Sense (Proficiency)|weather sense]]; (priest) [[Healing (Proficiency)|healing]], [[Herbalism (Proficiency)|herbalism]], [[Religion (Proficiency)|religion]]; (warrior) [[Mountaineering (Proficiency)|mountaineering]], [[Running (Proficiency)|running]], [[Survival (Proficiency)|survival]], [[Tracking (Proficiency)|tracking]].\n\n'''Equipment:''' The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses all unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' A Wanderer like Fife receives a +1 reaction adjustment bonus from bards, rangers and traveling folk such as tinkers and Gypsies.\n\nWhen traveling over long distances, Fife covers ground at a one-third faster rate than a normal traveler would—that is, if a normal person can walk 24 miles in a day without force-marching, the druid can walk 32 miles with the same exertion. Fife, like all Wanderers, simply feels more accustomed to walking long distances than most—plus, she knows short cuts and secret trails. (This heightened speed is cumulative with the ability of many druids 3rd level and higher to travel through overgrowth or other difficult terrain without penalty.)\n\nWith a Wanderer guide, a party can increase travel time by one-sixth; thus, an unencumbered party led by a Wanderer would travel 28 miles in a day, not 24.\n\n'''Special Hindrances:''' Constantly on the move, a Wanderer never allows herself to be burdened. Fife cannot have retainers, hirelings, mercenaries, or even servants until she reaches 12th level (but animal companions can travel with her). The druid cannot possess more treasure than she can carry; she either converts the excess into a portable form (gems, etc.) or donates it to a worthy cause, such as the druidic order.\n\n'''Wealth Options:''' 3d6x10 gp.\n\n{{Navbox The Complete Druid's Handbook}}"
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
                recommended: ["staff", "one other weapon"],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["direction sense. "],
                recommended: ["animal training", "singing", "weather sense", "healing", "herbalism", "religion", "mountaineering", "running", "survival", "tracking"],
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

let embeddedKit090: Kit = Kit(
        id: "warrior_priest",
        name: "Warrior Priest",
        wikiPageTitle: "Warrior Priest (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "A Warrior Priest is a spiritual leader of the Crusades, responsible for the clerical needs of soldiers and knights in his company. This priest celebrates mass at dawn and before every battle. He discusses tactics with the aristocratic leaders and fights in combat against the Saracens, just like any other brave warrior. This priest has no place in the established hierarchy of the Church. He belongs in an army, military company, or in castles along the frontier, always fighting against the Saracens. A Warrior Priest sees himself as the defender and liberator of Christianity. He is also an ideal member of a Military Order, such as the Templars or the Hospitallers (see Chapter 4).",
            requirements: "Obviously, pacifistic inclinations are antithetical to this priestly vocation. Like all members of the ordained clergy, Warrior Priests swore oaths of celibacy and chastity. Because of the rigors of this kit, they must have minimum Strength 14 and Wisdom 12. Canon law strictly forbade the shedding of blood by priests. During the Crusades, clerics sometimes abandoned this restriction. The Latin hierarchy permitted this so long as the Warrior Priests fought only against the Saracens, or in a just and holy cause that would benefit all of Christianity: for instance, liberation of the Holy Sepulcher, or recovering a lost holy relic. Shedding the blood of a fellow Christian, however, remains unthinkable for these clerics. Faced with such a dilemma, the priest must revert to using a blunt weapon, such as a mace or flail. Misuse of violence for personal goals results in an immediate loss of all priestly powers (including spells) until the errant priest has suitably atoned for his misdeed, as determined by the DM.",
            specialBenefits: "These characters are effective and respected leaders on the battlefield, and hence gain a +1 bonus to Charisma. In addition, all allies fighting in sight of this cleric gain a bonus to morale and saving throws versus fear, +1 for every six levels of the priest.",
            specialHindrances: "Like Monastic Warriors (see elsewhere), these priests are intolerant fanatics and the declared enemies of all Saracens. From their viewpoint, these evil pagans must all be destroyed or, even better, converted to Christianity at the earliest opportunity. A Warrior Priest never trusts or accepts the word of any Saracen except a convert. Because of his fanaticism, the Warrior Priest rarely works alongside Saracen allies willingly, unless he is convinced that such a compromise will positively benefit Christianity or Outremer as a whole. Official treaties with the Saracens are permissible, but only until the army of Christ has gained enough strength to fight them effectively once again. In game terms, this narrow-minded, religious chauvinism results in a -5 penalty on reaction roles with Saracen NPCs and effectively poisons all their long-term relations with Muslims. This greatly restricts their use in campaigns with Muslim PCs; some DMs may wish to use this kit with NPCs only.",
            wealthOptions: "Warrior Priests begin play with 3d6×10 gp. Like paladins, they are expected to tithe 10% of their income (gained in battle, adventuring, or inheritance) to a charitable cause, an established Church, or religious institution, such as a monastery or convent (never another PC). Aside from this almsgiving, the priest may keep as much wealth as desired. Category:Character Kit Category:Character Kit The Crusades Campaign Sourcebook",
            weaponProficiencies: "Members of this kit may take any weapon allowed to the priest class. In addition, for every six levels they attain, Warrior Priests may choose an additional edged melee weapon, such as the sword, lance, spear, or battle axe. They can never learn to use an edged missile weapon, such as a bow or crossbow.",
            nonweaponProficiencies: "* Required: read/write (Latin); ancient languages (Latin). * Recommended: heraldry, modern languages, riding, singing, weather sense; engineering, religion; armorer, endurance, survival, weaponsmithing. * Forbidden: any rogue.",
            equipment: "The Warrior Priest wears only sacramental robes when celebrating mass and performing the daily religious services. On the battlefield, however, he wears the best armor available, along with his vestments."
        ),
        description: KitDescription(
            briefSummary: "Unique to the Crusades, members of this fanatical priesthood adopted a militant philosophy to defend Christianity against the perceived evil of the Saracens. These priests not only advocated war, they practiced it themselves, fighting alongside the knights and soldiers during the Crusades.",
            fullText: "## Warrior Priest (Priest Kit)(Christian)\nUnique to the Crusades, members of this fanatical priesthood adopted a militant philosophy to defend Christianity against the perceived evil of the Saracens. These priests not only advocated war, they practiced it themselves, fighting alongside the knights and soldiers during the Crusades. Classic examples of this kit include Bishop Adhemar of Le Puy, the spiritual leader of the First Crusade, and Turpin, the legendary archbishop from the *Song of Roland*.\n\n**Requirements:** Obviously, pacifistic inclinations are antithetical to this priestly vocation. Like all members of the ordained clergy, Warrior Priests swore oaths of celibacy and chastity. Because of the rigors of this kit, they must have minimum Strength 14 and Wisdom 12.\n\nCanon law strictly forbade the shedding of blood by priests. During the Crusades, clerics sometimes abandoned this restriction. The Latin hierarchy permitted this so long as the Warrior Priests fought only against the Saracens, or in a just and holy cause that would benefit all of Christianity: for instance, liberation of the Holy Sepulcher, or recovering a lost holy relic.\n\nShedding the blood of a fellow Christian, however, remains unthinkable for these clerics. Faced with such a dilemma, the priest must revert to using a blunt weapon, such as a mace or flail. Misuse of violence for personal goals results in an immediate loss of all priestly powers (including spells) until the errant priest has suitably atoned for his misdeed, as determined by the DM.\n\n**Role:** A Warrior Priest is a spiritual leader of the Crusades, responsible for the clerical needs of soldiers and knights in his company. This priest celebrates mass at dawn and before every battle. He discusses tactics with the aristocratic leaders and fights in combat against the Saracens, just like any other brave warrior. This priest has no place in the established hierarchy of the Church. He belongs in an army, military company, or in castles along the frontier, always fighting against the Saracens. A Warrior Priest sees himself as the defender and liberator of Christianity. He is also an ideal member of a Military Order, such as the Templars or the Hospitallers (see Chapter 4).\n\n**Weapon Proficiencies:** Members of this kit may take any weapon allowed to the priest class. In addition, for every six levels they attain, Warrior Priests may choose an additional edged melee weapon, such as the sword, lance, spear, or battle axe. They can never learn to use an edged missile weapon, such as a bow or crossbow.\n\n**Nonweapon Proficiencies:**\n* *Required:* read/write (Latin); ancient languages (Latin).\n* *Recommended:* heraldry, modern languages, riding, singing, weather sense; engineering, religion; armorer, endurance, survival, weaponsmithing.\n* *Forbidden:* any rogue.\n\n**Equipment:** The Warrior Priest wears only sacramental robes when celebrating mass and performing the daily religious services. On the battlefield, however, he wears the best armor available, along with his vestments.\n\n**Special Benefits:** These characters are effective and respected leaders on the battlefield, and hence gain a +1 bonus to Charisma. In addition, all allies fighting in sight of this cleric gain a bonus to morale and saving throws versus fear, +1 for every six levels of the priest.\n\n**Magical Abilities:** Warrior Priests are allowed spells from the following spheres, subject to the restraints imposed by type of campaign (whether historical, legendary, or fantastic—see Chapter 5):\n\n* **Major Access:** Combat, Creation, Divination, Elemental, Protection, Summoning, War (from Tome of Magic).\n* **Minor Access:** All, Charm, Guardian, Healing, Necromantic, Weather, Sun.\n* **Forbidden Spheres:** all others.\n\n**Granted Powers:** Warrior Priests can turn undead and cast out spirits (see Chapter 5).\n\n**Special Hindrances:** Like Monastic Warriors (see elsewhere), these priests are intolerant fanatics and the declared enemies of all Saracens. From their viewpoint, these evil pagans must all be destroyed or, even better, converted to Christianity at the earliest opportunity. A Warrior Priest never trusts or accepts the word of any Saracen except a convert.\n\nBecause of his fanaticism, the Warrior Priest rarely works alongside Saracen allies willingly, unless he is convinced that such a compromise will positively benefit Christianity or Outremer as a whole. Official treaties with the Saracens are permissible, but only until the army of Christ has gained enough strength to fight them effectively once again. In game terms, this narrow-minded, religious chauvinism results in a -5 penalty on reaction roles with Saracen NPCs and effectively poisons all their long-term relations with Muslims. This greatly restricts their use in campaigns with Muslim PCs; some DMs may wish to use this kit with NPCs only.\n\n**Wealth Options:** Warrior Priests begin play with 3d6×10 gp. Like paladins, they are expected to tithe 10% of their income (gained in battle, adventuring, or inheritance) to a charitable cause, an established Church, or religious institution, such as a monastery or convent (never another PC). Aside from this almsgiving, the priest may keep as much wealth as desired.",
            rawWikitext: "{{Sidebar CrCS Ch3}}__NOTOC__\n==Warrior Priest (Priest Kit)(Christian)==\nUnique to the Crusades, members of this fanatical priesthood adopted a militant philosophy to defend Christianity against the perceived evil of the Saracens. These priests not only advocated war, they practiced it themselves, fighting alongside the knights and soldiers during the Crusades. Classic examples of this kit include Bishop Adhemar of Le Puy, the spiritual leader of the First Crusade, and Turpin, the legendary archbishop from the ''Song of Roland''.\n\n'''Requirements:''' Obviously, pacifistic inclinations are antithetical to this priestly vocation. Like all members of the ordained clergy, Warrior Priests swore oaths of celibacy and chastity. Because of the rigors of this kit, they must have minimum Strength 14 and Wisdom 12.\n\nCanon law strictly forbade the shedding of blood by priests. During the Crusades, clerics sometimes abandoned this restriction. The Latin hierarchy permitted this so long as the Warrior Priests fought only against the Saracens, or in a just and holy cause that would benefit all of Christianity: for instance, liberation of the Holy Sepulcher, or recovering a lost holy relic.\n\nShedding the blood of a fellow Christian, however, remains unthinkable for these clerics. Faced with such a dilemma, the priest must revert to using a blunt weapon, such as a mace or flail. Misuse of violence for personal goals results in an immediate loss of all priestly powers (including spells) until the errant priest has suitably atoned for his misdeed, as determined by the DM.\n\n'''Role:''' A Warrior Priest is a spiritual leader of the Crusades, responsible for the clerical needs of soldiers and knights in his company. This priest celebrates mass at dawn and before every battle. He discusses tactics with the aristocratic leaders and fights in combat against the Saracens, just like any other brave warrior. This priest has no place in the established hierarchy of the Church. He belongs in an army, military company, or in castles along the frontier, always fighting against the Saracens. A Warrior Priest sees himself as the defender and liberator of Christianity. He is also an ideal member of a Military Order, such as the Templars or the Hospitallers ([[Ch 4 (CrCS)|see Chapter 4]]).\n\n'''Weapon Proficiencies:''' Members of this kit may take any weapon allowed to the priest class. In addition, for every six levels they attain, Warrior Priests may choose an additional edged melee weapon, such as the sword, lance, spear, or battle axe. They can never learn to use an edged missile weapon, such as a bow or crossbow.\n\n'''Nonweapon Proficiencies:'''\n* ''Required:'' [[Reading/Writing (Proficiency)|read/write]] (Latin); [[Languages, Ancient (Proficiency)|ancient languages]] (Latin).\n* ''Recommended:'' [[Heraldry (Proficiency)|heraldry]], [[Languages, Modern (Proficiency)|modern languages]], [[Riding, Land-Based (Proficiency)|riding]], [[Singing (Proficiency)|singing]], [[Weather Sense (Proficiency)|weather sense]]; [[Engineering (Proficiency)|engineering]], [[Religion (Proficiency)|religion]]; [[Armorer (Proficiency)|armorer]], [[Endurance (Proficiency)|endurance]], [[Survival (Proficiency)|survival]], [[Weaponsmithing (Proficiency)|weaponsmithing]].\n* ''Forbidden:'' any rogue.\n\n'''Equipment:''' The Warrior Priest wears only sacramental robes when celebrating mass and performing the daily religious services. On the battlefield, however, he wears the best armor available, along with his vestments.\n\n'''Special Benefits:''' These characters are effective and respected leaders on the battlefield, and hence gain a +1 bonus to Charisma. In addition, all allies fighting in sight of this cleric gain a bonus to morale and saving throws versus fear, +1 for every six levels of the priest.\n\n'''Magical Abilities:''' Warrior Priests are allowed spells from the following spheres, subject to the restraints imposed by type of campaign (whether historical, legendary, or fantastic—see Chapter 5):\n\n* '''Major Access:''' Combat, Creation, Divination, Elemental, Protection, Summoning, War (from Tome of Magic).\n* '''Minor Access:''' All, Charm, Guardian, Healing, Necromantic, Weather, Sun.\n* '''Forbidden Spheres:''' all others.\n\n'''Granted Powers:''' Warrior Priests can turn undead and cast out spirits (see Chapter 5).\n\n'''Special Hindrances:''' Like Monastic Warriors (see elsewhere), these priests are intolerant fanatics and the declared enemies of all Saracens. From their viewpoint, these evil pagans must all be destroyed or, even better, converted to Christianity at the earliest opportunity. A Warrior Priest never trusts or accepts the word of any Saracen except a convert.\n\nBecause of his fanaticism, the Warrior Priest rarely works alongside Saracen allies willingly, unless he is convinced that such a compromise will positively benefit Christianity or Outremer as a whole. Official treaties with the Saracens are permissible, but only until the army of Christ has gained enough strength to fight them effectively once again. In game terms, this narrow-minded, religious chauvinism results in a -5 penalty on reaction roles with Saracen NPCs and effectively poisons all their long-term relations with Muslims. This greatly restricts their use in campaigns with Muslim PCs; some DMs may wish to use this kit with NPCs only.\n\n'''Wealth Options:''' Warrior Priests begin play with 3d6×10 gp. Like paladins, they are expected to tithe 10% of their income (gained in battle, adventuring, or inheritance) to a charitable cause, an established Church, or religious institution, such as a monastery or convent (never another PC). Aside from this almsgiving, the priest may keep as much wealth as desired.\n\n{{Navbox The Crusades Campaign Sourcebook}}\n[[Category:Character Kit]]\n[[Category:Character Kit The Crusades Campaign Sourcebook]]"
        ),
        categories: ["Character Kit", "Character Kit The Crusades Campaign Sourcebook"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Strength": 14, "Wisdom": 12],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["sword", "lance", "spear", "battle axe"],
                forbidden: [],
                notes: "Members of this kit may take any weapon allowed to the priest class. In addition, for every six levels they attain, Warrior Priests may choose an additional edged melee weapon, such as the sword, lance, spear, or battle axe. They can never learn to use an edged missile weapon, such as a bow or crossbow."
            ),
            proficiencies: KitProficiencyRules(
                bonus: [],
                recommended: ["heraldry", "modern languages", "riding", "singing", "weather sense", "engineering", "religion", "armorer", "endurance", "survival", "weaponsmithing"],
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
