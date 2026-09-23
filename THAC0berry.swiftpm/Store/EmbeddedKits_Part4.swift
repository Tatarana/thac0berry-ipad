import Foundation

/// Parte 4 de 5 dos kits embutidos — ver `EmbeddedKits.swift` pro
/// porquê disso existir (nunca volte pra ler isso de JSON/bundle) e pro porquê
/// de estar dividido em vários arquivos/constantes em vez de um array literal
/// único gigante: um único `[Kit(...), Kit(...), ...]` com todos os kits
/// dá exatamente no erro clássico do type-checker do Swift ("unable to
/// type-check this expression in reasonable time" — que no Swift
/// Playgrounds às vezes só aparece como "Build Failed" sem detalhe nenhum).
/// Cada kit aqui é uma constante com tipo explícito (`: Kit`), o que faz o
/// compilador checar cada um isoladamente e rápido, em vez de tentar inferir
/// o array inteiro de uma vez.


let embeddedKit060: Kit = Kit(
        id: "scholar_priest",
        name: "Scholar Priest",
        wikiPageTitle: "Scholar Priest (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "In the campaign, this priest is motivated by his desire for knowledge. He'll often be tempted by adventures where he's likely to be able to learn something. If an adventuring party is going to a ruin where a famous library once stood, he'll eagerly join on the faint hope that some scrap of that library still survives. He'll be part of expeditions to visit famous sites or ancient beings who might tell him stories of the past or solve old mysteries. He might be part of an adventure just so that he can chronicle it and preserve its events in history.",
            requirements: nil,
            specialBenefits: "The Scholar Priest can \"spend\" any of his Weapon Proficiency slots on Nonweapon Proficiencies instead. He doesn't have to; he can adhere to the normal pattern of proficiency choice that is appropriate to his priest-class. But if he wishes he may turn Weapon Proficiency slots into Nonweapon slots and thereby become a very skilled character. Also, the Scholar receives a +3 reaction bonus from other scholars, admirers of scholastic concerns, writers, journalists, and people who imagine that they are scholars. Because of this, when the party thinks it is in a situation when no one is willing to help, it may turn out that the mousy clerk, antagonistic king or homely witch they met is an admirer of or even correspondent with the Scholar Priest and will help them.",
            specialHindrances: "Many scholars are egotistical, and debates between scholars can become very heated and personal. Whenever the DM rolls a reaction check from another scholar, he should first roll 1d6. On a 1, the player-character scholar gets a -6 reaction adjustment instead of a +3, because at some time in the past (or even the present) he argued or disagreed with this scholar's pet opinion and offended him completely.",
            wealthOptions: "The Scholar Priest gets the standard 3d6x10 gp starting gold.",
            weaponProficiencies: "* Required: None. * Recommended: Any appropriate to the priest's actual priest-class. Note: See \"Special Benefits,\" below.",
            nonweaponProficiencies: "Bonus Proficiency: Reading/Writing. * Recommended: (General) Artistic Ability, Etiquette, Heraldry, Languages (Modern), (Priest) Ancient History, Astrology, Languages (Ancient), Local History.",
            equipment: "The scholar-priest must always have writing material, quill and ink with him. If ever he loses them, he must regain or replace them as soon as possible, and in the meantime will be recording his experiences in any fashion he can find. Other than that, this kit makes no demands on the way he spends his money."
        ),
        description: KitDescription(
            briefSummary: "This character is a researcher. He's most at home when he's poring over books, scrolls, papyri, clay tablets and other old writings. He's not forbidden from fighting, but is more likely to try to straighten out a bad situation with reason, personal charisma, or even trickery than with a weapon.",
            fullText: "## Scholar Priest\n**Description:** This character is a researcher. He's most at home when he's poring over books, scrolls, papyri, clay tablets and other old writings. He's not forbidden from fighting, but is more likely to try to straighten out a bad situation with reason, personal charisma, or even trickery than with a weapon. His life is dedicated to the assimilation of knowledge (and, usually, the transmission of that knowledge to new generations).\n\nA scholar priest must have an Intelligence ability score of 13 or better.\n\nThis kit cannot be abandoned. A scholar can break off correspondence with other scholars, can choose not to teach, can decide not to do any studying or writing for as long as he likes, but he can always re-enter the academic world.\n\n**Barred**: Priests of the following gods, forces and philosophies cannot take this kit: Competition, Fertility, Life-Death-Rebirth Cycle, Strength, and War.\n\nPriests of the following types are most appropriate for this kit: Arts, Crafts, Culture, Divinity of Mankind, Literature/Poetry, Music/Dance, and Wisdom.\n\n**Role:** In the campaign, this priest is motivated by his desire for knowledge. He'll often be tempted by adventures where he's likely to be able to learn something. If an adventuring party is going to a ruin where a famous library once stood, he'll eagerly join on the faint hope that some scrap of that library still survives. He'll be part of expeditions to visit famous sites or ancient beings who might tell him stories of the past or solve old mysteries. He might be part of an adventure just so that he can chronicle it and preserve its events in history.\n\n**Secondary Skills:** The Scholar Priest must take Scribe as his secondary skill.\n\n**Weapon Proficiencies:**\n* *Required:* None.\n* *Recommended:* Any appropriate to the priest's actual priest-class. Note: See \"Special Benefits,\" below.\n\n**Nonweapon Proficiencies:** Bonus Proficiency: Reading/Writing.\n* *Recommended:* (General) Artistic Ability, Etiquette, Heraldry, Languages (Modern), (Priest) Ancient History, Astrology, Languages (Ancient), Local History.\n\n**Equipment:** The scholar-priest must always have writing material, quill and ink with him. If ever he loses them, he must regain or replace them as soon as possible, and in the meantime will be recording his experiences in any fashion he can find. Other than that, this kit makes no demands on the way he spends his money.\n\n**Special Benefits:** The Scholar Priest can \"spend\" any of his Weapon Proficiency slots on Nonweapon Proficiencies instead. He doesn't have to; he can adhere to the normal pattern of proficiency choice that is appropriate to his priest-class. But if he wishes he may turn Weapon Proficiency slots into Nonweapon slots and thereby become a very skilled character. Also, the Scholar receives a +3 reaction bonus from other scholars, admirers of scholastic concerns, writers, journalists, and people who imagine that they are scholars. Because of this, when the party thinks it is in a situation when no one is willing to help, it may turn out that the mousy clerk, antagonistic king or homely witch they met is an admirer of or even correspondent with the Scholar Priest and will help them.\n\n**Special Hindrances:** Many scholars are egotistical, and debates between scholars can become very heated and personal. Whenever the DM rolls a reaction check from another scholar, he should first roll 1d6. On a 1, the player-character scholar gets a *-6* reaction adjustment instead of a +3, because at some time in the past (or even the present) he argued or disagreed with this scholar's pet opinion and offended him completely.\n\n**Wealth Options:** The Scholar Priest gets the standard 3d6x10 gp starting gold.\n\n**Races:** No special limitations.",
            rawWikitext: "{{Sidebar CPrH Ch4}}__NOTOC__\n==Scholar Priest==\n'''Description:''' This character is a researcher. He's most at home when he's poring over books, scrolls, papyri, clay tablets and other old writings. He's not forbidden from fighting, but is more likely to try to straighten out a bad situation with reason, personal charisma, or even trickery than with a weapon. His life is dedicated to the assimilation of knowledge (and, usually, the transmission of that knowledge to new generations).\n\nA scholar priest must have an Intelligence ability score of 13 or better.\n\nThis kit cannot be abandoned. A scholar can break off correspondence with other scholars, can choose not to teach, can decide not to do any studying or writing for as long as he likes, but he can always re-enter the academic world.\n\n'''Barred''': Priests of the following gods, forces and philosophies cannot take this kit: Competition, Fertility, Life-Death-Rebirth Cycle, Strength, and War.\n\nPriests of the following types are most appropriate for this kit: Arts, Crafts, Culture, Divinity of Mankind, Literature/Poetry, Music/Dance, and Wisdom.\n\n'''Role:''' In the campaign, this priest is motivated by his desire for knowledge. He'll often be tempted by adventures where he's likely to be able to learn something. If an adventuring party is going to a ruin where a famous library once stood, he'll eagerly join on the faint hope that some scrap of that library still survives. He'll be part of expeditions to visit famous sites or ancient beings who might tell him stories of the past or solve old mysteries. He might be part of an adventure just so that he can chronicle it and preserve its events in history.\n\n'''Secondary Skills:''' The Scholar Priest must take Scribe as his secondary skill.\n\n'''Weapon Proficiencies:'''\n* ''Required:'' None.\n* ''Recommended:'' Any appropriate to the priest's actual priest-class. Note: See \"Special Benefits,\" below.\n\n'''Nonweapon Proficiencies:''' Bonus Proficiency: Reading/Writing.\n* ''Recommended:'' (General) Artistic Ability, Etiquette, Heraldry, Languages (Modern), (Priest) Ancient History, Astrology, Languages (Ancient), Local History.\n\n'''Equipment:''' The scholar-priest must always have writing material, quill and ink with him. If ever he loses them, he must regain or replace them as soon as possible, and in the meantime will be recording his experiences in any fashion he can find. Other than that, this kit makes no demands on the way he spends his money.\n\n'''Special Benefits:''' The Scholar Priest can \"spend\" any of his Weapon Proficiency slots on Nonweapon Proficiencies instead. He doesn't have to; he can adhere to the normal pattern of proficiency choice that is appropriate to his priest-class. But if he wishes he may turn Weapon Proficiency slots into Nonweapon slots and thereby become a very skilled character. Also, the Scholar receives a +3 reaction bonus from other scholars, admirers of scholastic concerns, writers, journalists, and people who imagine that they are scholars. Because of this, when the party thinks it is in a situation when no one is willing to help, it may turn out that the mousy clerk, antagonistic king or homely witch they met is an admirer of or even correspondent with the Scholar Priest and will help them.\n\n'''Special Hindrances:''' Many scholars are egotistical, and debates between scholars can become very heated and personal. Whenever the DM rolls a reaction check from another scholar, he should first roll 1d6. On a 1, the player-character scholar gets a ''-6'' reaction adjustment instead of a +3, because at some time in the past (or even the present) he argued or disagreed with this scholar's pet opinion and offended him completely.\n\n'''Wealth Options:''' The Scholar Priest gets the standard 3d6x10 gp starting gold.\n\n'''Races:''' No special limitations.\n\n{{Navbox The Complete Priest's Handbook}}\n[[Category:Character Kit]]\n[[Category:Character Kit CPrH]]"
        ),
        categories: ["Character Kit", "Character Kit CPrH"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 13],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: "* Required: None. * Recommended: Any appropriate to the priest's actual priest-class. Note: See \"Special Benefits,\" below."
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Proficiency: Reading/Writing"],
                recommended: ["Artistic Ability", "Etiquette", "Heraldry", "Languages", "Ancient History", "Astrology", "Languages", "Local History"],
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

let embeddedKit061: Kit = Kit(
        id: "sel_ne_moon_knight",
        name: "Selûne - Moon Knight",
        wikiPageTitle: "Selûne - Moon Knight (Character Kit)",
        redirectAliases: ["Priests of Selune (Character Kit)", "Selune - Moon Knight (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The hostility of Shar, Selûne's counterpart, has caused the latter to commission a more militant priestly order that supplements the Lady's crusaders. This order's members are called the moon knights, and they are intimately tied to Selûne and her power. It is each moon knight's mission to defend the church against attacks from Shar and, if neccessary, carry the battle to the dark goddess' doorstep.",
            requirements: "Strength 12, Wisdom 9",
            specialBenefits: "During the three days of the full moon each month, a moon knight temporarily gains one level, with all the commensurate benefits of that level. Moon knights can turn undead, and during the full moon the moon knights turn undead as if they were two levels higher rather than just one. If any moon knight is infected with lycanthropy, she has a 5% chance per level of controlling her actions during the full moon and in her changed form.",
            specialHindrances: "During the three days of the new moon, the moon knight temporarily loses a level, with all the resultant effects. Moon knights are incapable of turning undead at this time as well. Moon knights can never cast any spell, or use any magic item, that results in darkness.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Blindfighting",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "The hostility of Shar, Selûne's counterpart, has caused the latter to commission a more militant priestly order that supplements the Lady's crusaders. This order's members are called the moon knights, and they are intimately tied to Selûne and her power.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Strength 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || Yes\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest, Warrior\n|-\n| **Bonus Proficiencies** || Blindfighting\n|-\n| **Recommended Proficiencies** || Navigation\n|}\n## Overview\nThe hostility of Shar, Selûne's counterpart, has caused the latter to commission a more militant priestly order that supplements the Lady's crusaders. This order's members are called the moon knights, and they are intimately tied to Selûne and her power. It is each moon knight's mission to defend the church against attacks from Shar and, if neccessary, carry the battle to the dark goddess' doorstep.\n\n## Description\nThe moon knights favor splint armor that is colored silver and white, the twin eyes of Selûne emblazoned on the chest. Each moon knight also wears a helmet with a blue crest, and a midnight blue cloak. For combat, they favor the moon's hand mace.\n\n## Role-Playing\nThe moon knights are a highly militant group of soldier-priests that bear a strong hatred of Shar and her minions. Although they are happy and jovial during times of celebration, this rapidly gives way to fury and bloodlust when an enemy of the church is near.\n\n## Special Abilities\nDuring the three days of the full moon each month, a moon knight temporarily gains one level, with all the commensurate benefits of that level. Moon knights can turn undead, and during the full moon the moon knights turn undead as if they were two levels higher rather than just one. If any moon knight is infected with lycanthropy, she has a 5% chance per level of controlling her actions during the full moon and in her changed form.\n\n## Special Disadvantages\nDuring the three days of the new moon, the moon knight temporarily loses a level, with all the resultant effects. Moon knights are incapable of turning undead at this time as well.\n\nMoon knights can never cast any spell, or use any magic item, that results in darkness.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Strength]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || Yes\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest, Warrior\n|-\n| '''Bonus Proficiencies''' || [[Blind-fighting (Proficiency)|Blindfighting]]\n|-\n| '''Recommended Proficiencies''' || [[Navigation (Proficiency)|Navigation]]\n|}__TOC__\n==Overview==\nThe hostility of Shar, Selûne's counterpart, has caused the latter to commission a more militant priestly order that supplements the Lady's crusaders. This order's members are called the moon knights, and they are intimately tied to Selûne and her power. It is each moon knight's mission to defend the church against attacks from Shar and, if neccessary, carry the battle to the dark goddess' doorstep.\n\n==Description==\nThe moon knights favor splint armor that is colored silver and white, the twin eyes of Selûne emblazoned on the chest. Each moon knight also wears a helmet with a blue crest, and a midnight blue cloak. For combat, they favor the moon's hand mace.\n\n==Role-Playing==\nThe moon knights are a highly militant group of soldier-priests that bear a strong hatred of Shar and her minions. Although they are happy and jovial during times of celebration, this rapidly gives way to fury and bloodlust when an enemy of the church is near.\n\n==Special Abilities==\nDuring the three days of the full moon each month, a moon knight temporarily gains one level, with all the commensurate benefits of that level. Moon knights can turn undead, and during the full moon the moon knights turn undead as if they were two levels higher rather than just one. If any moon knight is infected with lycanthropy, she has a 5% chance per level of controlling her actions during the full moon and in her changed form.\n\n==Special Disadvantages==\nDuring the three days of the new moon, the moon knight temporarily loses a level, with all the resultant effects. Moon knights are incapable of turning undead at this time as well.\n\nMoon knights can never cast any spell, or use any magic item, that results in darkness.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Strength": 12, "Wisdom": 9],
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
                bonus: ["Blindfighting"],
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
                capable: true,
                mode: "modified",
                notes: "turn undead as if they were two levels higher rather than just one"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Selûne",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Moon Knight"
    )

let embeddedKit062: Kit = Kit(
        id: "sel_ne_silver_lady",
        name: "Selûne - Silver Lady",
        wikiPageTitle: "Selûne - Silver Lady (Character Kit)",
        redirectAliases: ["Selune - Silver Lady (Character Kit)", "Silver Lady (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Selûne, goddess of the moon, enjoys a vast variety of worshipers. In an effort to better accommodate the many different factions of her worshipers, the order of the silver ladies was founded. The function of the silver ladies is to act as healers, defenders of women and lycanthropes, midwives, and diviners. With all these responsibilities, they are kept quite busy.",
            requirements: "Wisdom 9",
            specialBenefits: "Once a month, during the full moon, a silver lady can attempt to tell one person's future. This future is limited to events of the next month. When each silver lady starts her career, she must choose a method of divining from the following: cards, tea leaves, the stars, bone-tossing, scrying pool, or dice. The base chance of divination is 40% plus 2% per level of the Lady. The effects of this divination, no matter what form it takes, are identical to those of the 4th-level priests' spell divination, though the foretold events are beyond the one-week limit of that normal spell. Silver ladies can see perfectly well in the dark as if they had infravision. During the three days and nights of the full moon, they are immune to lycanthropy.",
            specialHindrances: "Because these priests are meant to emphasize the part of Selûne's portfolio that makes her watch over the wellbeing of women, only females may be silver ladies of Selûne. However, their duties impose no restrictions on their romantic relationships. There are many married silver ladies still dedicated to Selûne. During the week of the new moon, silver ladies suffer a -1 penalty to attack rolls and saving throws in combat against followers of Shar. For reasons still unknown, silver ladies cannot turn undead, despite this being an ability found in the rest of Selûne's clergy.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Healing, herbalism",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Selûne, goddess of the moon, enjoys a vast variety of worshipers. In an effort to better accommodate the many different factions of her worshipers, the order of the silver ladies was founded. The function of the silver ladies is to act as healers, defenders of women and lycanthropes, midwives, and diviners.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Healing, herbalism\n|-\n| **Recommended Proficiencies** || Astrology\n|}\n## Overview\nSelûne, goddess of the moon, enjoys a vast variety of worshipers. In an effort to better accommodate the many different factions of her worshipers, the order of the silver ladies was founded. The function of the silver ladies is to act as healers, defenders of women and lycanthropes, midwives, and diviners. With all these responsibilities, they are kept quite busy.\n\n## Description\nAll silver ladies are female. The clerics wear robes made of silver threads and silk or satin and top them with white cloaks and hoods. Chain mail is the favored armor under a silver lady's robes. Of course, a smooth-headed mace called the moon's hand is the preferred weapon.\n\n## Role-Playing\nThe silver ladies have a lot to keep them busy, but they still manage to enjoy themselves as worshipers of Selûne.\n\nMost silver ladies have strong sympathetic feelings towards lycanthropes, especially contrite, infected ones.\n\nThey are also very suspicious of cities, nations, or cultures where women are treated as second-class citizens or as property. Silver ladies find special satisfaction in hunting down men who cheat, harass, abandon, or persecute women and forcing the men to somehow compensate their victims. Silver ladies have been known to react violently to seeing any man exploit a woman, sometimes causing quite a public commotion and making themselves unwelcome in cities where certain reprehensible practices, such as slavery, are still quite legal.\n\nBecause of their visions of the future and their love of moonlit night, silver ladies always seem slightly out of step with normal society. They seem to be preoccupied with something intangible, and find it hard to worry about present-day concerns, a behavior which frustrates people around them.\n\n## Special Abilities\nOnce a month, during the full moon, a silver lady can attempt to tell one person's future. This future is limited to events of the next month. When each silver lady starts her career, she must choose a method of divining from the following: cards, tea leaves, the stars, bone-tossing, scrying pool, or dice. The base chance of divination is 40% plus 2% per level of the Lady. The effects of this divination, no matter what form it takes, are identical to those of the 4th-level priests' spell divination, though the foretold events are beyond the one-week limit of that normal spell.\n\nSilver ladies can see perfectly well in the dark as if they had infravision. During the three days and nights of the full moon, they are immune to lycanthropy.\n\n## Special Disadvantages\nBecause these priests are meant to emphasize the part of Selûne's portfolio that makes her watch over the wellbeing of women, only females may be silver ladies of Selûne. However, their duties impose no restrictions on their romantic relationships. There are many married silver ladies still dedicated to Selûne.\n\nDuring the week of the new moon, silver ladies suffer a -1 penalty to attack rolls and saving throws in combat against followers of Shar.\n\nFor reasons still unknown, silver ladies cannot turn undead, despite this being an ability found in the rest of Selûne's clergy.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Healing (Proficiency)|Healing]], [[Herbalism (Proficiency)|herbalism]]\n|-\n| '''Recommended Proficiencies''' || [[Astrology (Proficiency)|Astrology]]\n|}__TOC__\n==Overview==\nSelûne, goddess of the moon, enjoys a vast variety of worshipers. In an effort to better accommodate the many different factions of her worshipers, the order of the silver ladies was founded. The function of the silver ladies is to act as healers, defenders of women and lycanthropes, midwives, and diviners. With all these responsibilities, they are kept quite busy.\n\n==Description==\nAll silver ladies are female. The clerics wear robes made of silver threads and silk or satin and top them with white cloaks and hoods. Chain mail is the favored armor under a silver lady's robes. Of course, a smooth-headed mace called the moon's hand is the preferred weapon.\n\n==Role-Playing==\nThe silver ladies have a lot to keep them busy, but they still manage to enjoy themselves as worshipers of Selûne.\n\nMost silver ladies have strong sympathetic feelings towards lycanthropes, especially contrite, infected ones.\n\nThey are also very suspicious of cities, nations, or cultures where women are treated as second-class citizens or as property. Silver ladies find special satisfaction in hunting down men who cheat, harass, abandon, or persecute women and forcing the men to somehow compensate their victims. Silver ladies have been known to react violently to seeing any man exploit a woman, sometimes causing quite a public commotion and making themselves unwelcome in cities where certain reprehensible practices, such as slavery, are still quite legal.\n\nBecause of their visions of the future and their love of moonlit night, silver ladies always seem slightly out of step with normal society. They seem to be preoccupied with something intangible, and find it hard to worry about present-day concerns, a behavior which frustrates people around them.\n\n==Special Abilities==\nOnce a month, during the full moon, a silver lady can attempt to tell one person's future. This future is limited to events of the next month. When each silver lady starts her career, she must choose a method of divining from the following: cards, tea leaves, the stars, bone-tossing, scrying pool, or dice. The base chance of divination is 40% plus 2% per level of the Lady. The effects of this divination, no matter what form it takes, are identical to those of the 4th-level priests' spell divination, though the foretold events are beyond the one-week limit of that normal spell.\n\nSilver ladies can see perfectly well in the dark as if they had infravision. During the three days and nights of the full moon, they are immune to lycanthropy.\n\n==Special Disadvantages==\nBecause these priests are meant to emphasize the part of Selûne's portfolio that makes her watch over the wellbeing of women, only females may be silver ladies of Selûne. However, their duties impose no restrictions on their romantic relationships. There are many married silver ladies still dedicated to Selûne.\n\nDuring the week of the new moon, silver ladies suffer a -1 penalty to attack rolls and saving throws in combat against followers of Shar.\n\nFor reasons still unknown, silver ladies cannot turn undead, despite this being an ability found in the rest of Selûne's clergy.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Healing", "herbalism"],
                recommended: ["Astrology"],
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
                notes: "For reasons still unknown, silver ladies cannot turn undead, despite this being an ability found in the rest of Selûne's clergy"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Selûne",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Silver Lady"
    )

let embeddedKit063: Kit = Kit(
        id: "sensei",
        name: "Sensei",
        wikiPageTitle: "Sensei (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Cleric",
            allowedClasses: ["Cleric"]
        ),
        sourceBook: "The Complete Cleric's Handbook",
        features: KitFeatures(
            role: "Sensei may be the most dangerous character kit in the campaign. They are students of the art of combat, seeking to defeat their foes physically, mentally, and spiritually. They are supremely confident in their abilities and understand their capabilities and limitations exactly. Mere treasure is not enough to win a sensei's service; they only exercise their skills for worthy causes. In the adventuring party, the sensei is an infiltrator and scout who can strike swiftly to devastating effect. His dedication to self-improvement makes him an unapproachable character who inspires fear in friend and foe alike. There is little room in the sensei's existence for anything but the quest for perfection.",
            requirements: nil,
            specialBenefits: "The sensei is allowed to study martial arts or unarmed combat. He may continue to specialize in these fields, spending additional proficiency slots to improve his attack and damage rolls. In addition to his unarmed combat ability, the sensei also gains a +1 attack bonus with any weapon he is proficient in to reflect his superb training. Sensei can also learn the rogue or warrior skills listed under \"New Nonweapon Proficiencies\" at the normal cost, without paying the one-slot penalty for choosing a proficiency out of the character group. The sensei learns many physical skills in addition to his combat training and psychic advancement.",
            specialHindrances: "The sensei may not wear armor or use magical devices to improve his Armor Class. He will not use magical weapons, either. The sensei believes in his own ability and disdains the use of such crutches in the practice of his art. Since he seeks to master both physical and psionic skills, the sensei is not as devoted to pure psionic study as other psionicists are. He suffers a penalty of 1 PSP per level. A sensei with a Wisdom of 16 would gain 10 PSPs per level, rather than the 11 he normally would.",
            wealthOptions: "Sensei care nothing for material wealth. He begins play with 3d4 × 10 ceramic pieces and may never carry more personal treasure than can fit in a small belt pouch. Category:Character Kit Category:Character Kit WatW",
            weaponProficiencies: "The sensei gains an extra weapon proficiency, which must be spent to learn martial arts. He may choose his other weapons from the following list: dagger, dart, knife, quarterstaff, spear, gythka, or chatkcha. At least half of all weapons proficiencies must be spent on learning unarmed fighting styles. Refer to \"Proficiencies\" in Chapter Four.",
            nonweaponProficiencies: "* Bonus Rejuvenation, tumbling. * Recommended: Blind-fighting, dancing, direction sense, swimming, healing, juggling, jumping, tightrope walking, endurance, running.",
            equipment: "The sensei wears no armor, as it hampers his ability to move. He may use any of the weapons listed above."
        ),
        description: KitDescription(
            briefSummary: "The most powerful characters on Athas combine the study of psionics with the study of another discipline. Dragons study sorcery in conjunction with the Way, while elemental clerics harness the power of their minds to the power of their worship.",
            fullText: "## Sensei\nThe most powerful characters on Athas combine the study of psionics with the study of another discipline. Dragons study sorcery in conjunction with the Way, while elemental clerics harness the power of their minds to the power of their worship. The sensei combines an intensive physical training program with the Way, seeking to become the perfect weapon.\n\nThe sensei are very rare in the Tyr region, since their art is extraordinarily demanding. Few people are even aware that they exist. Each sensei charts his own course in life; there is no organization or school that binds them together. Some may be assassins, others gladiators, and others wandering champions who fight against injustice.\n\nIn addition to the normal psionicist requirements, a sensei must have a Dexterity of 15 or better and a Strength of 13 or better. Only humans muls, and half-elves may become sensei.\n\n**Role:** Sensei may be the most dangerous character kit in the campaign. They are students of the art of combat, seeking to defeat their foes physically, mentally, and spiritually. They are supremely confident in their abilities and understand their capabilities and limitations exactly. Mere treasure is not enough to win a sensei's service; they only exercise their skills for worthy causes.\n\nIn the adventuring party, the sensei is an infiltrator and scout who can strike swiftly to devastating effect. His dedication to self-improvement makes him an unapproachable character who inspires fear in friend and foe alike. There is little room in the sensei's existence for anything but the quest for perfection.\n\n**Preferred Disciplines:** The sensei must choose Psychometabolism or Psychokinesis as his primary discipline. Psychoportation and Telepathy are preferred choices for secondary disciplines.\n\n**Weapon Proficiencies:** The sensei gains an extra weapon proficiency, which must be spent to learn martial arts. He may choose his other weapons from the following list: dagger, dart, knife, quarterstaff, spear, gythka, or chatkcha. At least half of all weapons proficiencies must be spent on learning unarmed fighting styles. Refer to \"Proficiencies\" in Chapter Four.\n\n**Nonweapon Proficiencies:**\n* *Bonus* Rejuvenation, tumbling.\n* *Recommended:* Blind-fighting, dancing, direction sense, swimming, healing, juggling, jumping, tightrope walking, endurance, running.\n\n**Equipment:** The sensei wears no armor, as it hampers his ability to move. He may use any of the weapons listed above.\n\n**Special Benefits:** The sensei is allowed to study martial arts or unarmed combat. He may continue to specialize in these fields, spending additional proficiency slots to improve his attack and damage rolls. In addition to his unarmed combat ability, the sensei also gains a +1 attack bonus with any weapon he is proficient in to reflect his superb training.\n\nSensei can also learn the rogue or warrior skills listed under \"New Nonweapon Proficiencies\" at the normal cost, without paying the one-slot penalty for choosing a proficiency out of the character group. The sensei learns many physical skills in addition to his combat training and psychic advancement.\n\n**Special Hindrances:** The sensei may not wear armor or use magical devices to improve his Armor Class. He will not use magical weapons, either. The sensei believes in his own ability and disdains the use of such crutches in the practice of his art.\n\nSince he seeks to master both physical and psionic skills, the sensei is not as devoted to pure psionic study as other psionicists are. He suffers a penalty of 1 PSP per level. A sensei with a Wisdom of 16 would gain 10 PSPs per level, rather than the 11 he normally would.\n\n**Wealth Options:** Sensei care nothing for material wealth. He begins play with 3d4 × 10 ceramic pieces and may never carry more personal treasure than can fit in a small belt pouch.",
            rawWikitext: "{{Sidebar WatW Ch3}}__NOTOC__\n==Sensei==\nThe most powerful characters on Athas combine the study of psionics with the study of another discipline. Dragons study sorcery in conjunction with the Way, while elemental clerics harness the power of their minds to the power of their worship. The sensei combines an intensive physical training program with the Way, seeking to become the perfect weapon.\n\nThe sensei are very rare in the Tyr region, since their art is extraordinarily demanding. Few people are even aware that they exist. Each sensei charts his own course in life; there is no organization or school that binds them together. Some may be assassins, others gladiators, and others wandering champions who fight against injustice.\n\nIn addition to the normal psionicist requirements, a sensei must have a [[Dexterity]] of 15 or better and a [[Strength]] of 13 or better. Only humans muls, and half-elves may become sensei.\n\n'''Role:''' Sensei may be the most dangerous character kit in the campaign. They are students of the art of combat, seeking to defeat their foes physically, mentally, and spiritually. They are supremely confident in their abilities and understand their capabilities and limitations exactly. Mere treasure is not enough to win a sensei's service; they only exercise their skills for worthy causes.\n\nIn the adventuring party, the sensei is an infiltrator and scout who can strike swiftly to devastating effect. His dedication to self-improvement makes him an unapproachable character who inspires fear in friend and foe alike. There is little room in the sensei's existence for anything but the quest for perfection.\n\n'''Preferred Disciplines:''' The sensei must choose Psychometabolism or Psychokinesis as his primary discipline. Psychoportation and Telepathy are preferred choices for secondary disciplines.\n\n'''Weapon Proficiencies:''' The sensei gains an extra weapon proficiency, which must be spent to learn martial arts. He may choose his other weapons from the following list: dagger, dart, knife, quarterstaff, spear, gythka, or chatkcha. At least half of all weapons proficiencies must be spent on learning unarmed fighting styles. Refer to \"Proficiencies\" in Chapter Four.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus'' [[Rejuvenation (Proficiency)|Rejuvenation]], [[Tumbling (Proficiency)|tumbling]].\n* ''Recommended:'' [[Blind-fighting (Proficiency)|Blind-fighting]], [[Dancing (Proficiency)|dancing]], [[Direction Sense (Proficiency)|direction sense]], [[Swimming (Proficiency)|swimming]], [[Healing (Proficiency)|healing]], [[Juggling (Proficiency)|juggling]], [[Jumping (Proficiency)|jumping]], [[Tightrope Walking (Proficiency)|tightrope walking]], [[Endurance (Proficiency)|endurance]], [[Running (Proficiency)|running]].\n\n'''Equipment:''' The sensei wears no armor, as it hampers his ability to move. He may use any of the weapons listed above.\n\n'''Special Benefits:''' The sensei is allowed to study martial arts or unarmed combat. He may continue to specialize in these fields, spending additional proficiency slots to improve his attack and damage rolls. In addition to his unarmed combat ability, the sensei also gains a +1 attack bonus with any weapon he is proficient in to reflect his superb training.\n\nSensei can also learn the rogue or warrior skills listed under \"New Nonweapon Proficiencies\" at the normal cost, without paying the one-slot penalty for choosing a proficiency out of the character group. The sensei learns many physical skills in addition to his combat training and psychic advancement.\n\n'''Special Hindrances:''' The sensei may not wear armor or use magical devices to improve his Armor Class. He will not use magical weapons, either. The sensei believes in his own ability and disdains the use of such crutches in the practice of his art.\n\nSince he seeks to master both physical and psionic skills, the sensei is not as devoted to pure psionic study as other psionicists are. He suffers a penalty of 1 PSP per level. A sensei with a Wisdom of 16 would gain 10 PSPs per level, rather than the 11 he normally would.\n\n'''Wealth Options:''' Sensei care nothing for material wealth. He begins play with 3d4 × 10 ceramic pieces and may never carry more personal treasure than can fit in a small belt pouch.\n\n{{Navbox The Will and the Way}}\n[[Category:Character Kit]]\n[[Category:Character Kit WatW]]"
        ),
        categories: ["Character Kit", "Character Kit WatW"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Strength": 13, "Dexterity": 15],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["dagger", "dart", "knife", "quarterstaff", "spear", "gythka", "chatkcha"],
                forbidden: [],
                notes: "The sensei gains an extra weapon proficiency, which must be spent to learn martial arts. He may choose his other weapons from the following list: dagger, dart, knife, quarterstaff, spear, gythka, or chatkcha. At least half of all weapons proficiencies must be spent on learning unarmed fighting styles. Refer to \"Proficiencies\" in Chapter Four."
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Rejuvenation", "tumbling"],
                recommended: ["Blind-fighting", "dancing", "direction sense", "swimming", "healing", "juggling", "jumping", "tightrope walking", "endurance", "running"],
                notes: nil
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
            startingCash: "3d4x10"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit064: Kit = Kit(
        id: "shaman_dead_sun",
        name: "Shaman - Dead Sun",
        wikiPageTitle: "Shaman - Dead Sun (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The shaman is alchemist, medicine man, spiritual leader, and witch doctor, all combined in one mysterious, and often frightening, person. He or she is expected to provide healing, watch over births, conduct funeral ceremonies, and generally provide for the tribe. PCs are rarely shamans, but if they are, they should have to explain why they have deserted their responsibilities for the sake of mere adventure!",
            requirements: nil,
            specialBenefits: "Player character shamans have the same bonus proficiencies as shrine clerics.",
            specialHindrances: nil,
            wealthOptions: nil,
            weaponProficiencies: nil,
            nonweaponProficiencies: nil,
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "More common among the primitive tribes is the shaman kit. Belgoi, gith, giants, nomadic humans, thri-kreen, and renegade halflings are all likely to have a shaman in their settlements and lairs. Usually, these priests live a short distance away from native populations, rather than in their midst.",
            fullText: "## Shamans\nMore common among the primitive tribes is the shaman kit. Belgoi, gith, giants, nomadic humans, thri-kreen, and renegade halflings are all likely to have a shaman in their settlements and lairs. Usually, these priests live a short distance away from native populations, rather than in their midst. This helps them to maintain an air of mysticism.\n\nA shaman makes the same pact as other clerics, but often mistakes the elemental beings granting his power for vicious and angry gods. Many earth shamans are known to worship the \"God of the Volcano,\" for instance. That deity does not exist, but entire cultures have arisen based on such false beliefs.\n\nThe local environment usually dictates to which element the shaman allies himself. A tribe that lives on the shoals of the Sea of Silt would perish without a silt shaman, while those who wander freely would most likely be accompanied by a shaman of the air.\n\n**Role:** The shaman is alchemist, medicine man, spiritual leader, and witch doctor, all combined in one mysterious, and often frightening, person. He or she is expected to provide healing, watch over births, conduct funeral ceremonies, and generally provide for the tribe. PCs are rarely shamans, but if they are, they should have to explain why they have deserted their responsibilities for the sake of mere adventure!\n\n**Alignment:** Shamans are almost always lawful, but can be good, neutral, or evil in nature. Evil shamans are feared by their tribes, and they use this fear to cultivate fanaticism and respect.\n\n**Special Abilities:** Player character shamans have the same bonus proficiencies as shrine clerics.\n\n**Suggested Proficiencies:** Agriculture, animal lore (local species), astrology (Air), etiquette (tribal customs), fire building (Fire), healing, languages, mountaineering, navigation (nomadic tribes), religion, riding-land-based, survival, water find.\n\nMany adventurers underestimate the shamans of the scorched, desert wastes. Jurgan, a priest of earth, tells of a pack of templars who made this fatal error.\n\n: *Jurgan sat on the steps of the weapon shop. The owner had permitted him to tell his tales here, after hours, for the past week, and the cleric of earth had drawn quite a crowd tonight. After the wide-eyed throng settled, and the last rays of the dark sun slipped below the city walls, Jurgan began to speak.*\n\n: *\"Even the lowliest creature can topple a sorcerer-king's templars if the enduring earth is his ally. Once I saw a group of the king's men chase a band of belgoi into a shadowy grotto. The templar chief signaled for the others to follow him, and I could hear studded leather clicking as they stum bled and slid down the embankment.*\n\n: *\"The templars believed that their prey was trapped, and they charged the startled savages. But as they waded into the enemy, they noticed a strange look in the eyes of the belgoi. The first few were easily slain, but then the templars saw that there were other shadows in the grotto. They had chased the belgoi into a trap, but the trap had been set for the templars!*\n\n: *\"The templar chief screamed a retreat and his veterans followed him in frantic withdrawal. As they ran, they couldn't help but see the ominous form of a shaman standing on the cliffs above.*\n\n: *\"He was much older than the rest, and his bluish body was covered with ritual scars, strange tattoos, and protruding bones. The shaman smiled at the doomed templars and raised his arms to the earth lords. As he brought his hands back down, the horrified templars saw the entire cliff face begin to shake and tremble.*\n\n: *\"They ran as fast as they could, but the quaking earth slowed their progress. Before they could even scream, a mas sive avalanche of rock and earth had buried them beneath tons of retribution.*\n\n: * \"When the grotto was still again, there was no trace of the overconfident templars, just a pile of bloody stone and flesh-beneath the toothless grin of the old shaman.\"*\n\n: -Jurgan's Tale",
            rawWikitext: "{{Sidebar EAFW Ch2}}__NOTOC__\n==Shamans==\nMore common among the primitive tribes is the shaman kit. Belgoi, gith, giants, nomadic humans, thri-kreen, and renegade halflings are all likely to have a shaman in their settlements and lairs. Usually, these priests live a short distance away from native populations, rather than in their midst. This helps them to maintain an air of mysticism.\n\nA shaman makes the same pact as other clerics, but often mistakes the elemental beings granting his power for vicious and angry gods. Many earth shamans are known to worship the \"God of the Volcano,\" for instance. That deity does not exist, but entire cultures have arisen based on such false beliefs.\n\nThe local environment usually dictates to which element the shaman allies himself. A tribe that lives on the shoals of the Sea of Silt would perish without a silt shaman, while those who wander freely would most likely be accompanied by a shaman of the air.\n\n'''Role:''' The shaman is alchemist, medicine man, spiritual leader, and witch doctor, all combined in one mysterious, and often frightening, person. He or she is expected to provide healing, watch over births, conduct funeral ceremonies, and generally provide for the tribe. PCs are rarely shamans, but if they are, they should have to explain why they have deserted their responsibilities for the sake of mere adventure!\n\n'''Alignment:''' Shamans are almost always lawful, but can be good, neutral, or evil in nature. Evil shamans are feared by their tribes, and they use this fear to cultivate fanaticism and respect.\n\n'''Special Abilities:''' Player character shamans have the same bonus proficiencies as shrine clerics.\n\n'''Suggested Proficiencies:''' Agriculture, animal lore (local species), astrology (Air), etiquette (tribal customs), fire building (Fire), healing, languages, mountaineering, navigation (nomadic tribes), religion, riding-land-based, survival, water find.\n\nMany adventurers underestimate the shamans of the scorched, desert wastes. Jurgan, a priest of earth, tells of a pack of templars who made this fatal error.\n\n: ''Jurgan sat on the steps of the weapon shop. The owner had permitted him to tell his tales here, after hours, for the past week, and the cleric of earth had drawn quite a crowd tonight. After the wide-eyed throng settled, and the last rays of the dark sun slipped below the city walls, Jurgan began to speak.''\n\n: ''\"Even the lowliest creature can topple a sorcerer-king's templars if the enduring earth is his ally. Once I saw a group of the king's men chase a band of belgoi into a shadowy grotto. The templar chief signaled for the others to follow him, and I could hear studded leather clicking as they stum bled and slid down the embankment.''\n\n: ''\"The templars believed that their prey was trapped, and they charged the startled savages. But as they waded into the enemy, they noticed a strange look in the eyes of the belgoi. The first few were easily slain, but then the templars saw that there were other shadows in the grotto. They had chased the belgoi into a trap, but the trap had been set for the templars!''\n\n: ''\"The templar chief screamed a retreat and his veterans followed him in frantic withdrawal. As they ran, they couldn't help but see the ominous form of a shaman standing on the cliffs above.''\n\n: ''\"He was much older than the rest, and his bluish body was covered with ritual scars, strange tattoos, and protruding bones. The shaman smiled at the doomed templars and raised his arms to the earth lords. As he brought his hands back down, the horrified templars saw the entire cliff face begin to shake and tremble.''\n\n: ''\"They ran as fast as they could, but the quaking earth slowed their progress. Before they could even scream, a mas sive avalanche of rock and earth had buried them beneath tons of retribution.''\n\n: '' \"When the grotto was still again, there was no trace of the overconfident templars, just a pile of bloody stone and flesh-beneath the toothless grin of the old shaman.\"''\n\n: -Jurgan's Tale\n\n{{Navbox Earth, Air, Fire and Water}}\n[[Category:Character Kit]]\n[[Category:Character Kit EAFW]]"
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
        deity: "Shaman",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Dead Sun"
    )

let embeddedKit065: Kit = Kit(
        id: "shapeshifter",
        name: "Shapeshifter",
        wikiPageTitle: "Shapeshifter (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "Shapeshifters have mercurial personalities. Although by no means chaotic, they are quick to anger, and easily moved to joy or tears. Rimi, like many Shapeshifter druids, makes an excellent spy or messenger and stands a good chance of being picked as a servant to a high-level druid, an archdruid, or a great druid.",
            requirements: nil,
            specialBenefits: "As a Shapeshifter, Rimi gains her branch's shapechanging power at 1st level rather than at 7th level. However, until she reaches 7th level, the druid can assume only the form of natural creatures whose Hit Dice total no greater than half her level. (A 1st-level Shapeshifter only assumes the form of a creature with 1/2 HD or less.) Rimi can shapechange twice as often as her branch normally allows, which doubles the number of changes she can make daily. (Forest Shapeshifters, then, can change to animal, reptile, and bird form, each twice per day.) However, using this power more than the normal three times per day may have dangerous consequences. (See \"Special Hindrances.\") At 7th level, Rimi the Shapeshifter can transform a portion of her body. Instead of turning into a reptile, she can give herself a snake's fangs, which she can use in an attack to cause 1d2 bite damage plus poison. Rather than turning into a bird, she can transform her arms into a bird's wings and fly at a movement rate of 21. Short of transforming into a bear (or other mammal), she can sprout a bear's claws from her fingers and make two attacks causing 1d3 points of damage each, plus Strength bonus. Each of these actions counts as one change for the day.",
            specialHindrances: "A Shapeshifter regains hit points only when resuming her human form, and then recovers only 1d4 hp. If the druid has 0&nbsp;hp or fewer, she regains none with her human shape. If Rimi uses her Shapeshifter power more than three times per day, she must make a saving throw vs. spell after each extra use. A failure locks her into her current form until the next day, when she can attempt a new saving throw. However, for each failed save, the druid's next one bears a -1 penalty. If Rimi fails three saving throws in succession, she keeps her current animal form permanently, as if she had been reincarnated as that creature. Only a polymorph any object, limited wish, or wish can turn her back to human or another form.",
            wealthOptions: "3d6x5 gp. Shapeshifters spend too much time in animal form to concern themselves with money.",
            weaponProficiencies: "Recommended—staff.",
            nonweaponProficiencies: "Bonus—animal lore. : Recommended—(priest) spellcraft; (warrior) endurance, survival, tracking.",
            equipment: "The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "Shapeshifter druids master their shapechanging powers at a lower experience level than other druids. This ability takes a special gift (perhaps a taint of lycanthropic or silver dragon blood in the druid's family tree) and intense training.",
            fullText: "Shapeshifter druids master their shapechanging powers at a lower experience level than other druids. This ability takes a special gift (perhaps a taint of lycanthropic or silver dragon blood in the druid's family tree) and intense training. But, those who persevere, such as Rimi (pictured on the next page) gain unusual metamorphic powers.\n\n**Role:** Shapeshifters have mercurial personalities. Although by no means chaotic, they are quick to anger, and easily moved to joy or tears. Rimi, like many Shapeshifter druids, makes an excellent spy or messenger and stands a good chance of being picked as a servant to a high-level druid, an archdruid, or a great druid.\n\n**Branch Restrictions:** Only forest, plains, and mountain druids can take this kit, as druids in other branches have limits on their shapechanging powers.\n\n**Weapon Proficiencies:** *Recommended*—staff.\n\n**Secondary Skills:** Hunter, groom.\n\n**Nonweapon Proficiencies:**\n: *Bonus*—animal lore.\n: *Recommended*—(priest) spellcraft; (warrior) endurance, survival, tracking.\n\n**Equipment**: The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp.\n\n**Special Benefits:** As a Shapeshifter, Rimi gains her branch's shapechanging power at 1st level rather than at 7th level. However, until she reaches 7th level, the druid can assume only the form of natural creatures whose Hit Dice total no greater than half her level. (A 1st-level Shapeshifter only assumes the form of a creature with 1/2 HD or less.) Rimi can shapechange *twice as often* as her branch normally allows, which doubles the number of changes she can make daily. (Forest Shapeshifters, then, can change to animal, reptile, and bird form, each twice per day.) However, using this power more than the normal three times per day may have dangerous consequences. (See \"Special Hindrances.\")\n\nAt 7th level, Rimi the Shapeshifter can transform a portion of her body. Instead of turning into a reptile, she can give herself a snake's fangs, which she can use in an attack to cause 1d2 bite damage plus poison. Rather than turning into a bird, she can transform her arms into a bird's wings and fly at a movement rate of 21. Short of transforming into a bear (or other mammal), she can sprout a bear's claws from her fingers and make two attacks causing 1d3 points of damage each, plus Strength bonus. Each of these actions counts as one change for the day.\n\n**Special Hindrances:** A Shapeshifter regains hit points only when resuming her human form, and then recovers only 1d4 hp. If the druid has 0&nbsp;hp or fewer, she regains none with her human shape.\n\nIf Rimi uses her Shapeshifter power more than three times per day, she must make a saving throw vs. spell after each extra use. A failure locks her into her current form until the next day, when she can attempt a new saving throw. However, for each failed save, the druid's next one bears a -1 penalty. If Rimi fails three saving throws in succession, she keeps her current animal form permanently, as if she had been reincarnated as that creature. Only a *polymorph any object, limited wish*, or *wish* can turn her back to human or another form.\n\n**Wealth Options:** 3d6x5 gp. Shapeshifters spend too much time in animal form to concern themselves with money.",
            rawWikitext: "{{Sidebar CDH Ch2}}__NOTOC__\nShapeshifter druids master their shapechanging powers at a lower experience level than other druids. This ability takes a special gift (perhaps a taint of lycanthropic or silver dragon blood in the druid's family tree) and intense training. But, those who persevere, such as Rimi (pictured on the next page) gain unusual metamorphic powers.\n\n'''Role:''' Shapeshifters have mercurial personalities. Although by no means chaotic, they are quick to anger, and easily moved to joy or tears. Rimi, like many Shapeshifter druids, makes an excellent spy or messenger and stands a good chance of being picked as a servant to a high-level druid, an archdruid, or a great druid.\n\n'''Branch Restrictions:''' Only forest, plains, and mountain druids can take this kit, as druids in other branches have limits on their shapechanging powers.\n\n'''Weapon Proficiencies:''' ''Recommended''—staff.\n\n'''Secondary Skills:''' Hunter, groom.\n\n'''Nonweapon Proficiencies:'''\n: ''Bonus''—[[Animal Lore (Proficiency)|animal lore]].\n: ''Recommended''—(priest) [[Spellcraft (Proficiency)|spellcraft]]; (warrior) [[Endurance (Proficiency)|endurance]], [[Survival (Proficiency)|survival]], [[Tracking (Proficiency)|tracking]].\n\n'''Equipment''': The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' As a Shapeshifter, Rimi gains her branch's shapechanging power at 1st level rather than at 7th level. However, until she reaches 7th level, the druid can assume only the form of natural creatures whose Hit Dice total no greater than half her level. (A 1st-level Shapeshifter only assumes the form of a creature with 1/2 HD or less.) Rimi can shapechange ''twice as often'' as her branch normally allows, which doubles the number of changes she can make daily. (Forest Shapeshifters, then, can change to animal, reptile, and bird form, each twice per day.) However, using this power more than the normal three times per day may have dangerous consequences. (See \"Special Hindrances.\")\n\nAt 7th level, Rimi the Shapeshifter can transform a portion of her body. Instead of turning into a reptile, she can give herself a snake's fangs, which she can use in an attack to cause 1d2 bite damage plus poison. Rather than turning into a bird, she can transform her arms into a bird's wings and fly at a movement rate of 21. Short of transforming into a bear (or other mammal), she can sprout a bear's claws from her fingers and make two attacks causing 1d3 points of damage each, plus Strength bonus. Each of these actions counts as one change for the day.\n\n'''Special Hindrances:''' A Shapeshifter regains hit points only when resuming her human form, and then recovers only 1d4 hp. If the druid has 0&nbsp;hp or fewer, she regains none with her human shape.\n\nIf Rimi uses her Shapeshifter power more than three times per day, she must make a saving throw vs. spell after each extra use. A failure locks her into her current form until the next day, when she can attempt a new saving throw. However, for each failed save, the druid's next one bears a -1 penalty. If Rimi fails three saving throws in succession, she keeps her current animal form permanently, as if she had been reincarnated as that creature. Only a ''[[Polymorph Any Object (Wizard Spell)|polymorph any object]], [[Limited Wish (Wizard Spell)|limited wish]]'', or ''[[Wish (Wizard Spell)|wish]]'' can turn her back to human or another form.\n\n'''Wealth Options:''' 3d6x5 gp. Shapeshifters spend too much time in animal form to concern themselves with money.\n\n{{Navbox The Complete Druid's Handbook}}"
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
                bonus: ["animal lore. "],
                recommended: ["spellcraft", "endurance", "survival", "tracking"],
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
            startingCash: "3d6x5 gp"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit066: Kit = Kit(
        id: "shar_darkcloak",
        name: "Shar - Darkcloak",
        wikiPageTitle: "Shar - Darkcloak (Character Kit)",
        redirectAliases: ["Priests of Shar (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Despite Shar's evil alignment and her being the goddess of night, darkness, and loss, there is another side to the goddess, a side that is actually beneficial. The Darkcloaks are members of Shar's clergy that function as oracles and care-givers to the emotionally damaged. The Darkcloaks bring the bliss of forgetfulness to such troubled souls. The Darkcloaks have actually made some progress in seeing Shar's faith become a socially acceptable one.",
            requirements: "Wisdom 9",
            specialBenefits: "All darkcloaks can see in the dark, courtesy of infravision. This has a range of 60' for those without infravision or adds 60' of infravision for those who have it already. Darkcloaks can cast forget once per level, each day. A darkcloak's augury is always successful, even though they give the results in riddles and evasive phrases. A darkcloak of 3rd level or higher can act as an oracle, telling the future for one questioner per day. The base chance of accuracy is 40%, plus 5% per level above 3rd. Once a day, a darkcloak of 5th level or higher can utter a soothing word that will eliminate one bad memory from the victim, provided the latter allows the darkcloak to use this ability on them. A darkcloak of 7th level or higher has access to a special perfume. If the smeller fails a save vs. poison when within 5' of a darkcloak, they are affected by a forget spell. One application lasts for a day. Darkcloaks are immune to the perfume's effects. If anyone else wears the perfume, they smell as if sprayed by a skunk (-4 temporary Charisma loss). Since darkcloaks do some good to people, they can have non-evil priests. Darkcloaks can be true neutral, neutral good, or lawful neutral.",
            specialHindrances: "Darkcloaks are not suited for combat. They fight at a -2 penalty to hit in bright sunlight, or during the full moon. They are also surprised on a 1-4 on a d10 under those conditions. Darkcloaks can only take the reversed forms of spells from the Light sphere of clerical magic. Additionally, they cannot take any spells from the Combat sphere of magic. Despite their benevolence, darkcloaks are often identified with the evils brought by the rest of Shar's faithful and suffer a -2 reaction penalty accordingly.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "None",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Despite Shar's evil alignment and her being the goddess of night, darkness, and loss, there is another side to the goddess, a side that is actually beneficial.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || None\n|-\n| **Recommended Proficiencies** || Astrology\n|}\n## Overview\nDespite Shar's evil alignment and her being the goddess of night, darkness, and loss, there is another side to the goddess, a side that is actually beneficial.\n\nThe Darkcloaks are members of Shar's clergy that function as oracles and care-givers to the emotionally damaged. The Darkcloaks bring the bliss of forgetfulness to such troubled souls. The Darkcloaks have actually made some progress in seeing Shar's faith become a socially acceptable one.\n\n## Description\nDarkcloaks, like their names, are clad in long black hoods and cloaks, all trimmed with purple. Their garments are black as midnight, and usually leave little to the imagination. Darkcloaks have a special perfume scent that some people swear has amnesiatic properties, but this has never been proven, and the clergy of Shar is not saying anything on the matter.\n\nDarkcloaks believe that life is full of pain, and only the emotional oblivion of Shar makes it tolerable. Unlike their nightbringer brethren, the darkcloaks actually have compassion towards the sufferers of mental anguish.\n\nPreferring to cultivate a reputation as mysterious folk, the darkcloaks frame their oracular proclamations in obscure riddles and mysterious symbols.\n\n## Special Abilities\nAll darkcloaks can see in the dark, courtesy of infravision. This has a range of 60' for those without infravision or adds 60' of infravision for those who have it already. Darkcloaks can cast forget once per level, each day. A darkcloak's augury is always successful, even though\n\nthey give the results in riddles and evasive phrases.\n\nA darkcloak of 3rd level or higher can act as an oracle, telling the future for one questioner per day. The base chance of accuracy is 40%, plus 5% per level above 3rd.\n\nOnce a day, a darkcloak of 5th level or higher can utter a soothing word that will eliminate one bad memory from the victim, provided the latter allows the darkcloak to use this ability on them.\n\nA darkcloak of 7th level or higher has access to a special perfume. If the smeller fails a save vs. poison when within 5' of a darkcloak, they are affected by a forget spell. One application lasts for a day. Darkcloaks are immune to the perfume's effects. If anyone else wears the perfume, they smell as if sprayed by a skunk (-4 temporary Charisma loss).\n\nSince darkcloaks do some good to people, they can have non-evil priests. Darkcloaks can be true neutral, neutral good, or lawful neutral.\n\n## Special Disadvantages\nDarkcloaks are not suited for combat. They fight at a -2 penalty to hit in bright sunlight, or during the full moon. They are also surprised on a 1-4 on a d10 under those conditions.\n\nDarkcloaks can only take the reversed forms of spells from the Light sphere of clerical magic. Additionally, they cannot take any spells from the Combat sphere of magic.\n\nDespite their benevolence, darkcloaks are often identified with the evils brought by the rest of Shar's faithful and suffer a -2 reaction penalty accordingly.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || None\n|-\n| '''Recommended Proficiencies''' || [[Astrology (Proficiency)|Astrology]]\n|}__TOC__\n==Overview==\nDespite Shar's evil alignment and her being the goddess of night, darkness, and loss, there is another side to the goddess, a side that is actually beneficial.\n\nThe Darkcloaks are members of Shar's clergy that function as oracles and care-givers to the emotionally damaged. The Darkcloaks bring the bliss of forgetfulness to such troubled souls. The Darkcloaks have actually made some progress in seeing Shar's faith become a socially acceptable one.\n\n==Description==\nDarkcloaks, like their names, are clad in long black hoods and cloaks, all trimmed with purple. Their garments are black as midnight, and usually leave little to the imagination. Darkcloaks have a special perfume scent that some people swear has amnesiatic properties, but this has never been proven, and the clergy of Shar is not saying anything on the matter.\n\nDarkcloaks believe that life is full of pain, and only the emotional oblivion of Shar makes it tolerable. Unlike their nightbringer brethren, the darkcloaks actually have compassion towards the sufferers of mental anguish.\n\nPreferring to cultivate a reputation as mysterious folk, the darkcloaks frame their oracular proclamations in obscure riddles and mysterious symbols.\n\n==Special Abilities==\nAll darkcloaks can see in the dark, courtesy of infravision. This has a range of 60' for those without infravision or adds 60' of infravision for those who have it already. Darkcloaks can cast forget once per level, each day. A darkcloak's augury is always successful, even though\n\nthey give the results in riddles and evasive phrases.\n\nA darkcloak of 3rd level or higher can act as an oracle, telling the future for one questioner per day. The base chance of accuracy is 40%, plus 5% per level above 3rd.\n\nOnce a day, a darkcloak of 5th level or higher can utter a soothing word that will eliminate one bad memory from the victim, provided the latter allows the darkcloak to use this ability on them.\n\nA darkcloak of 7th level or higher has access to a special perfume. If the smeller fails a save vs. poison when within 5' of a darkcloak, they are affected by a forget spell. One application lasts for a day. Darkcloaks are immune to the perfume's effects. If anyone else wears the perfume, they smell as if sprayed by a skunk (-4 temporary [[Charisma]] loss).\n\nSince darkcloaks do some good to people, they can have non-evil priests. Darkcloaks can be true neutral, neutral good, or lawful neutral.\n\n==Special Disadvantages==\nDarkcloaks are not suited for combat. They fight at a -2 penalty to hit in bright sunlight, or during the full moon. They are also surprised on a 1-4 on a d10 under those conditions.\n\nDarkcloaks can only take the reversed forms of spells from the Light sphere of clerical magic. Additionally, they cannot take any spells from the Combat sphere of magic.\n\nDespite their benevolence, darkcloaks are often identified with the evils brought by the rest of Shar's faithful and suffer a -2 reaction penalty accordingly.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: [],
                recommended: ["Astrology"],
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
        deity: "Shar",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Darkcloak"
    )

let embeddedKit067: Kit = Kit(
        id: "shar_nightbringer",
        name: "Shar - Nightbringer",
        wikiPageTitle: "Shar - Nightbringer (Character Kit)",
        redirectAliases: ["Nightbringer (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Shar's greatest enemy is Selûne, the goddess of the moon. Even though she has a group of crusaders, Shar insists on also having a branch of her clergy that is devoted to nothing else but bringing darkness to all (figuratively and literally) and directly opposing Selûne and her worshipers. Thus, the nightbringers were created.",
            requirements: "Wisdom 9",
            specialBenefits: "All nightbringers have the move silently and hide in shadows abilities of rangers. These are, of course, subject to armor, race, and dexterity modifiers. In combat against Selûne's worshipers, nightbringers get a +1 to attack and damage rolls, and a +4 bonus to their morale. If there are multiple opponents, nightbringers will ignore them and focus on a target known to be a worshiper of Selûne. At fifth level, nightbringers can cast darkness three times a day. At seventh level, nightbringers can cast continual darkness once a day. Starting at 9th level, nightbringers can call upon the power of Shar once during the week of the new moon. This power grants an increase in experience levels as if he drank a potion of heroism (1d4 levels with additional 1d6 hit points per level). These effects last until the immediate melee encounter is over. This power affects only the nightbringer and is not nullified by his experience levels like a potion of heroism is.",
            specialHindrances: "Nightbringers fight at a -2 penalty to hit in bright sunlight or during a night of the full moon. They are also surprised on a 1-4 on a d10 under those conditions. Nightbringers can only take the reversed forms of spells from the Light sphere of clerical magic. Nightbringers cannot cast spells from either the Sun or the Weather spheres. : ''\"I've encountered nightbringers before, but all I recall is that they enjoy playing with people's minds, doing little more than instilling in them a fear of the dark.\" :: -Mendryll Belarod''",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Blind-fighting",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Shar's greatest enemy is Selûne, the goddess of the moon. Even though she has a group of crusaders, Shar insists on also having a branch of her clergy that is devoted to nothing else but bringing darkness to all (figuratively and literally) and directly opposing Selûne and her worshipers.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Blind-fighting\n|-\n| **Recommended Proficiencies** || None\n|}\n## Overview\nShar's greatest enemy is Selûne, the goddess of the moon. Even though she has a group of crusaders, Shar insists on also having a branch of her clergy that is devoted to nothing else but bringing darkness to all (figuratively and literally) and directly opposing Selûne and her worshipers. Thus, the nightbringers were created.\n\n## Description\nNighibringers wear tunics and leggings of deep purple with black trim, over which lies a voluminous cloak and hood of black with purple trim. A black disk adorns the front of the tunic.\n\nThey prefer weapons that are easily concealable, such as daggers, clubs, blowguns, hand axes, or even horseman's maces. Any armor is permitted, but the nightbringers prefer armor that is quiet and offers a good degree of flexibility like leather.\n\n## Role-Playing\nNightbringers are the children of Shar in every way. They are dark-humored, soft-spoken folk, who make no sudden moves to draw attention to themselves. They enjoy making others paranoid by wondering aloud \"What could the darkness be concealing?\"\n\nTo the nightbringers, filling someone with terror, dread, and uncertainty is even more satisfying than killing them. Bear in mind that nightbringers are not indiscriminate murderers. Only the servants of Selûne inspire overt homicidal impulses in them.\n\n## Special Abilities\nAll nightbringers have the *move silently* and *hide in shadows* abilities of rangers. These are, of course, subject to armor, race, and dexterity modifiers.\n\nIn combat against Selûne's worshipers, nightbringers get a +1 to attack and damage rolls, and a +4 bonus to their morale. If there are multiple opponents, nightbringers will ignore them and focus on a target known to be a worshiper of Selûne.\n\nAt fifth level, nightbringers can cast darkness three times a day. At seventh level, nightbringers can cast continual darkness once a day. Starting at 9th level, nightbringers can call upon the power of Shar once during the week of the new moon. This power grants an increase in experience levels as if he drank a potion of heroism (1d4 levels with additional 1d6 hit points per level). These effects last until the immediate melee encounter is over. This power affects only the nightbringer and is not nullified by his experience levels like a potion of heroism is.\n\n## Special Disadvantages\nNightbringers fight at a -2 penalty to hit in bright sunlight or during a night of the full moon. They are also surprised on a 1-4 on a d10 under those conditions.\n\nNightbringers can only take the reversed forms of spells from the Light sphere of clerical magic. Nightbringers cannot cast spells from either the Sun or the Weather spheres.\n\n: *\"I've encountered nightbringers before, but all I recall is that they enjoy playing with people's minds, doing little more than instilling in them a fear of the dark.\"*\n\n:: *-Mendryll Belarod*",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Blind-fighting (Proficiency)|Blind-fighting]]\n|-\n| '''Recommended Proficiencies''' || None\n|}__TOC__\n==Overview==\nShar's greatest enemy is Selûne, the goddess of the moon. Even though she has a group of crusaders, Shar insists on also having a branch of her clergy that is devoted to nothing else but bringing darkness to all (figuratively and literally) and directly opposing Selûne and her worshipers. Thus, the nightbringers were created.\n\n==Description==\nNighibringers wear tunics and leggings of deep purple with black trim, over which lies a voluminous cloak and hood of black with purple trim. A black disk adorns the front of the tunic.\n\nThey prefer weapons that are easily concealable, such as daggers, clubs, blowguns, hand axes, or even horseman's maces. Any armor is permitted, but the nightbringers prefer armor that is quiet and offers a good degree of flexibility like leather.\n\n==Role-Playing==\nNightbringers are the children of Shar in every way. They are dark-humored, soft-spoken folk, who make no sudden moves to draw attention to themselves. They enjoy making others paranoid by wondering aloud \"What could the darkness be concealing?\"\n\nTo the nightbringers, filling someone with terror, dread, and uncertainty is even more satisfying than killing them. Bear in mind that nightbringers are not indiscriminate murderers. Only the servants of Selûne inspire overt homicidal impulses in them.\n\n==Special Abilities==\nAll nightbringers have the ''move silently'' and ''hide in shadows'' abilities of rangers. These are, of course, subject to armor, race, and dexterity modifiers.\n\nIn combat against Selûne's worshipers, nightbringers get a +1 to attack and damage rolls, and a +4 bonus to their morale. If there are multiple opponents, nightbringers will ignore them and focus on a target known to be a worshiper of Selûne.\n\nAt fifth level, nightbringers can cast darkness three times a day. At seventh level, nightbringers can cast continual darkness once a day. Starting at 9th level, nightbringers can call upon the power of Shar once during the week of the new moon. This power grants an increase in experience levels as if he drank a potion of heroism (1d4 levels with additional 1d6 hit points per level). These effects last until the immediate melee encounter is over. This power affects only the nightbringer and is not nullified by his experience levels like a potion of heroism is.\n\n==Special Disadvantages==\nNightbringers fight at a -2 penalty to hit in bright sunlight or during a night of the full moon. They are also surprised on a 1-4 on a d10 under those conditions.\n\nNightbringers can only take the reversed forms of spells from the Light sphere of clerical magic. Nightbringers cannot cast spells from either the Sun or the Weather spheres.\n\n: ''\"I've encountered nightbringers before, but all I recall is that they enjoy playing with people's minds, doing little more than instilling in them a fear of the dark.\"''\n\n:: ''-Mendryll Belarod''\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Blind-fighting"],
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
        deity: "Shar",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Nightbringer"
    )

let embeddedKit068: Kit = Kit(
        id: "sharess_indulgent",
        name: "Sharess - Indulgent",
        wikiPageTitle: "Sharess - Indulgent (Character Kit)",
        redirectAliases: ["Priests of Sharess (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Sharess is the goddess of hedonism, lust, and sensual fulfilment, and she is venerated in a number of cities such as Waterdeep, Calimport, and other ports on the Sword Coast. The indulgents are select priests who specialize in seduction, spying, and celebrations. Even though Sune's silkwhispers seem to fulfil a similar role, the indulgents have a bit of a darker nature, something they have received from their goddess. Consequently, indulgents can be nasty and violent when they need be.",
            requirements: "Charisma 16, Wisdom 12",
            specialBenefits: "When dealing with NPCs, a Friendly result on the interaction table pries one secret from the victim. In order for an indulgent to do this, he must spend at least 30 minutes alone with the target in a comfortable environment. The indulgent can make as many attempts per night, successful or not, as he has levels. This ability can be used against PCs as well. The PC, however, gets a saving throw vs. petrification to resist the effect (count only bonuses from a high Wisdom score for the saving throw). Instead of getting information, the priest can use the ability to place a smitten target under a charm person effect that lasts for 12 hours. Indulgents can spend two hours preparing a party. The priest makes an ability check using Charisma. A success means that the party goes very well, and the indulgent has a +3 reaction bonus when dealing with important NPC guests for the next 30 days.",
            specialHindrances: "The indulgent's special abilities work only on the members of her own race, although a DM may make exceptions for half-elves. Indulgents cannot turn undead, nor can they wear armor.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Dancing",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Sharess is the goddess of hedonism, lust, and sensual fulfilment, and she is venerated in a number of cities such as Waterdeep, Calimport, and other ports on the Sword Coast. The indulgents are select priests who specialize in seduction, spying, and celebrations.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Charisma 16,Wisdom 12\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Dancing\n|-\n| **Recommended Proficiencies** || None\n|}\n## Overview\nSharess is the goddess of hedonism, lust, and sensual fulfilment, and she is venerated in a number of cities such as Waterdeep, Calimport, and other ports on the Sword Coast. The indulgents are select priests who specialize in seduction, spying, and celebrations.\n\nEven though Sune's silkwhispers seem to fulfil a similar role, the indulgents have a bit of a darker nature, something they have received from their goddess. Consequently, indulgents can be nasty and violent when they need be.\n\n## Description\nIndulgents are extremely attractive priests and priestesses who favor outfits of lace or satin, usually in shades or patterns of white, black, or red. The females enjoy the lace costumes, while males favor the satin robes. A cloak of richest velvet, usually dyed crimson, completes the outfit of an indulgent. These cloaks are fur-lined in the winter. The holy symbol of Sharess, a pair of ruby red\n\nfeminine lips, is normally worn on a light chain anklet by her worshipers. Sharess' priests also wear her holy symbol on chain choker-necklaces.\n\nIndulgents do not wear armor, and they prefer quiet weapons such as daggers, garrotes, or darts. Some of these devotees have few compunctions against using debilitating, nonlethal poisons.\n\n## Role-Playing\nIndulgents are sexy, smug, dangerous, and completely ready to break all the boundaries and limits of social conventions, no matter what country or city they are in. Like their goddess, they favor excess in all things, be it pleasure, duty, or danger. If they can get some sort of satisfaction and fulfillment from it, so much the better.\n\nThey do not get along with the clergy of Sune, who believe that Sharess and her followers go too far much too quickly. While there is no overt violence between them, each clergy has been known to sabotage the other's parties and romantic rendezvous.\n\nIndulgents enjoy hiring themselves out as spies, seducing secrets out of gullible victims.\n\n## Special Abilities\nWhen dealing with NPCs, a Friendly result on the interaction table pries one secret from the victim. In order for an indulgent to do this, he must spend at least 30 minutes alone with the target in a comfortable environment. The indulgent can make as many attempts per night, successful or not, as he has levels. This ability can be used against PCs as well. The PC, however, gets a saving throw vs. petrification to resist the effect (count only bonuses from a high Wisdom score for the saving throw).\n\nInstead of getting information, the priest can use the ability to place a smitten target under a charm person effect that lasts for 12 hours.\n\nIndulgents can spend two hours preparing a party. The priest makes an ability check using Charisma. A success means that the party goes very well, and the indulgent has a +3 reaction bonus when dealing with important NPC guests for the next 30 days.\n\n## Special Disadvantages\nThe indulgent's special abilities work only on the members of her own race, although a DM may make exceptions for half-elves. Indulgents cannot turn undead, nor can they wear armor.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Charisma]] 16,{{br}}[[Wisdom]] 12\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Dancing (Proficiency)|Dancing]]\n|-\n| '''Recommended Proficiencies''' || None\n|}__TOC__\n==Overview==\nSharess is the goddess of hedonism, lust, and sensual fulfilment, and she is venerated in a number of cities such as Waterdeep, Calimport, and other ports on the Sword Coast. The indulgents are select priests who specialize in seduction, spying, and celebrations.\n\nEven though Sune's silkwhispers seem to fulfil a similar role, the indulgents have a bit of a darker nature, something they have received from their goddess. Consequently, indulgents can be nasty and violent when they need be.\n\n==Description==\nIndulgents are extremely attractive priests and priestesses who favor outfits of lace or satin, usually in shades or patterns of white, black, or red. The females enjoy the lace costumes, while males favor the satin robes. A cloak of richest velvet, usually dyed crimson, completes the outfit of an indulgent. These cloaks are fur-lined in the winter. The holy symbol of Sharess, a pair of ruby red\n\nfeminine lips, is normally worn on a light chain anklet by her worshipers. Sharess' priests also wear her holy symbol on chain choker-necklaces.\n\nIndulgents do not wear armor, and they prefer quiet weapons such as daggers, garrotes, or darts. Some of these devotees have few compunctions against using debilitating, nonlethal poisons.\n\n==Role-Playing==\nIndulgents are sexy, smug, dangerous, and completely ready to break all the boundaries and limits of social conventions, no matter what country or city they are in. Like their goddess, they favor excess in all things, be it pleasure, duty, or danger. If they can get some sort of satisfaction and fulfillment from it, so much the better.\n\nThey do not get along with the clergy of Sune, who believe that Sharess and her followers go too far much too quickly. While there is no overt violence between them, each clergy has been known to sabotage the other's parties and romantic rendezvous.\n\nIndulgents enjoy hiring themselves out as spies, seducing secrets out of gullible victims.\n\n==Special Abilities==\nWhen dealing with NPCs, a Friendly result on the interaction table pries one secret from the victim. In order for an indulgent to do this, he must spend at least 30 minutes alone with the target in a comfortable environment. The indulgent can make as many attempts per night, successful or not, as he has levels. This ability can be used against PCs as well. The PC, however, gets a saving throw vs. petrification to resist the effect (count only bonuses from a high Wisdom score for the saving throw).\n\nInstead of getting information, the priest can use the ability to place a smitten target under a charm person effect that lasts for 12 hours.\n\nIndulgents can spend two hours preparing a party. The priest makes an ability check using Charisma. A success means that the party goes very well, and the indulgent has a +3 reaction bonus when dealing with important NPC guests for the next 30 days.\n\n==Special Disadvantages==\nThe indulgent's special abilities work only on the members of her own race, although a DM may make exceptions for half-elves. Indulgents cannot turn undead, nor can they wear armor.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 12, "Charisma": 16],
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
                bonus: ["Dancing"],
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
                notes: "Indulgents cannot turn undead, nor can they wear armor"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Sharess",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Indulgent"
    )

let embeddedKit069: Kit = Kit(
        id: "shaundakul_windrider",
        name: "Shaundakul - Windrider",
        wikiPageTitle: "Shaundakul - Windrider (Character Kit)",
        redirectAliases: ["Priests of Shaundakul (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Shaundakul is a minor lesser deity who was formerly the god of travel and exploration during Myth Drannor's heyday. Nowadays, a handful of his clergy call themselves the windriders, and minister to traders, explorers, and adventurers who wander through the forests of Cormanthor. The windriders help the lost and befuddled, but they also painstakingly watch out for looters and those who would desecrate the ruins of Myth Drannor.",
            requirements: "Charisma 13, Wisdom 11",
            specialBenefits: "Windriders can turn undead. They can cast spells from the same limited spheres as the druids, but they cast them at one level above their current level.",
            specialHindrances: "Windriders will not willingly leave the borders of Cormanthor. The borders of this ancient elven land are their sacred charge. Windriders also must help out anyone who specifically calls upon Shaundakul for aid.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Direction sense, firebuilding, survival (Corman thor)",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Shaundakul is a minor lesser deity who was formerly the god of travel and exploration during Myth Drannor's heyday. Nowadays, a handful of his clergy call themselves the windriders, and minister to traders, explorers, and adventurers who wander through the forests of Cormanthor.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Half-elf, human\n|-\n| **Ability Requirements** || Charisma 13, Wisdom 11\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Direction sense, firebuilding, survival (Corman thor)\n|-\n| **Recommended Proficiencies** || Hunting, tracking\n|}\n## Overview\nShaundakul is a minor lesser deity who was formerly the god of travel and exploration during Myth Drannor's heyday. Nowadays, a handful of his clergy call themselves the windriders, and minister to traders, explorers, and adventurers who wander through the forests of Cormanthor. The windriders help the lost and befuddled, but they also painstakingly watch out for looters and those who would desecrate the ruins of Myth Drannor.\n\n## Description\nThe windriders wear leather armor and forest-green cloaks, and they wield long swords and short bows. Windriders never initially let on that they are Shaundakul's clergy. They can pass for \"normal\" adventurers. However, under their armor, windriders all wear small wooden holy symbols of Shaundakul: a disembodied left hand with a pointingindex finger. This status is revealed only when it is clear that the NPCs either need help or need to be stopped.\n\n## Role-Playing\nThe windriders know that, just like Myth Drannor itself, Shaundakul is not what he used to be. Yet, they still continue in their vigilance. Most windriders have an air of sadness, which gives way to a blazing righteous anger if they discover looters and desecrators within the ruins of Myth Drannor. Windriders are fond of traveling and exploring the limits of the Elven Court woods.\n\n## Special Abilities\nWindriders can turn undead. They can cast spells from the same limited spheres as the druids, but they cast them at one level above their current level.\n\n## Special Disadvantages\nWindriders will not willingly leave the borders of Cormanthor. The borders of this ancient elven land are their sacred charge. Windriders also must help out anyone who specifically calls upon Shaundakul for aid.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Half-elf, human\n|-\n| '''Ability Requirements''' || [[Charisma]] 13, [[Wisdom]] 11\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Direction Sense (Proficiency)|Direction sense]], [[Fire-building (Proficiency)|firebuilding]], [[Survival (Proficiency)|survival]] (Corman thor)\n|-\n| '''Recommended Proficiencies''' || [[Hunting (Proficiency)|Hunting]], [[Tracking (Proficiency)|tracking]]\n|}__TOC__\n==Overview==\nShaundakul is a minor lesser deity who was formerly the god of travel and exploration during Myth Drannor's heyday. Nowadays, a handful of his clergy call themselves the windriders, and minister to traders, explorers, and adventurers who wander through the forests of Cormanthor. The windriders help the lost and befuddled, but they also painstakingly watch out for looters and those who would desecrate the ruins of Myth Drannor.\n\n==Description==\nThe windriders wear leather armor and forest-green cloaks, and they wield long swords and short bows. Windriders never initially let on that they are Shaundakul's clergy. They can pass for \"normal\" adventurers. However, under their armor, windriders all wear small wooden holy symbols of Shaundakul: a disembodied left hand with a pointingindex finger. This status is revealed only when it is clear that the NPCs either need help or need to be stopped.\n\n==Role-Playing==\nThe windriders know that, just like Myth Drannor itself, Shaundakul is not what he used to be. Yet, they still continue in their vigilance. Most windriders have an air of sadness, which gives way to a blazing righteous anger if they discover looters and desecrators within the ruins of Myth Drannor. Windriders are fond of traveling and exploring the limits of the Elven Court woods.\n\n==Special Abilities==\nWindriders can turn undead. They can cast spells from the same limited spheres as the druids, but they cast them at one level above their current level.\n\n==Special Disadvantages==\nWindriders will not willingly leave the borders of Cormanthor. The borders of this ancient elven land are their sacred charge. Windriders also must help out anyone who specifically calls upon Shaundakul for aid.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 11, "Charisma": 13],
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
                bonus: ["Direction sense", "firebuilding", "survival"],
                recommended: ["Hunting", "tracking"],
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
        deity: "Shaundakul",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Windrider"
    )

let embeddedKit070: Kit = Kit(
        id: "silvanus_greenlord_lady",
        name: "Silvanus- Greenlord/lady",
        wikiPageTitle: "Silvanus- Greenlord/lady (Character Kit)",
        redirectAliases: ["Priests of Silvanus (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Greenlords and greenladies are a special class of priest of Silvanus. They are devoted to the aggressive defense of both flora and fauna, often to the detriment of \"civilized\" folk in the area. They see cities, roads, and even farmland, as a threat to nature in its pristine state. Most of the time, greenlords keep an eye on civilized expansion, making sure it does not grow too far too fast.",
            requirements: "Wisdom 9",
            specialBenefits: "Greenlords get the ability to speak with animals three times a day at 3rd level, and they can speak with plants three times a day at 5th level. Greenlords also gain the ability to change into an animal once a day. This ability works exactly like the 5th- level druid ability, but the greenlords gain this ability at 3rd level.",
            specialHindrances: "Because of their fanatical defense of wild nature, greenlords are not well-liked among city and town dwellers. To reflect this, greenlords suffer a -2 reaction penalty to NPC interactions in nonwilderness settings. In addition, since the undead are such a horrible contradiction to Silvanus' ideas of nature, a greenlord must make a save vs petrification every time he meets any undead. If he fails the save, the greenlord suffers the effects of fear. Obviously, greenlords cannot turn undead.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Animal lore, tracking",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Greenlords and greenladies are a special class of priest of Silvanus. They are devoted to the aggressive defense of both flora and fauna, often to the detriment of \"civilized\" folk in the area. They see cities, roads, and even farmland, as a threat to nature in its pristine state.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Druid\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Animal lore, tracking\n|-\n| **Recommended Proficiencies** || Animal handling, herbalism\n|}\n## Overview\nGreenlords and greenladies are a special class of priest of Silvanus. They are devoted to the aggressive defense of both flora and fauna, often to the detriment of \"civilized\" folk in the area. They see cities, roads, and even farmland, as a threat to nature in its pristine state. Most of the time, greenlords keep an eye on civilized expansion, making sure it does not grow too far too fast.\n\n## Description\nGreenlords favor leather armor decorated with intricately worked carvings, mostly using a leaf motif. Green cloaks, a bronze neck torc with green gems mounted on the ends, and a simple tan tunic completes the outfit. For weapons, a simple wooden staff is the most common.\n\nGreenlords do not hate humans and demihumans per se, Greenlord/lady but they simply devote extra favor to the flora and fauna\n\n## Role-Playing\ninstead. Greenlords see nature in the \"big picture.\" To them, a forest fire set by lightning is a good thing, since that is nature's way of clearing out deadwood and preventing the overcrowding of tree growth. A wolf pack that has moved into an area is a welcome sight if there is an overabundance of game. If there's a human settlement with livestock nearby, well, that's too bad for the livestock.\n\nThe greenlords will aggressively protect wildlife to the point where they will sabotage human tools to prevent the land from being cultivated. They will often warn away animals from hunting parties. Since greenlords do respect all life, they will do their best not to kill civilized folk, because even the most fanatical greenlords see killing for the sake of saving life to be a contradiction in terms.\n\nGreenlords are perfectly capable of functioning in cities and towns. They merely have no real desire to do so for any length of time. Urban society and its customs are held in high suspicion since the natural world is moved aside for the conveniences and comforts of civilization.\n\nEven though relations with the church of Chauntea are cordial and marked by cooperation, many greenlords see clerics of Chauntea as misguided, half-hearted, and contaminated by too much civilization.\n\n## Special Abilities\nGreenlords get the ability to speak with animals three times a day at 3rd level, and they can speak with plants three times a day at 5th level.\n\nGreenlords also gain the ability to change into an animal once a day. This ability works exactly like the 5th- level druid ability, but the greenlords gain this ability at 3rd level.\n\n## Special Disadvantages\nBecause of their fanatical defense of wild nature, greenlords are not well-liked among city and town dwellers. To reflect this, greenlords suffer a -2 reaction penalty to NPC interactions in nonwilderness settings.\n\nIn addition, since the undead are such a horrible contradiction to Silvanus' ideas of nature, a greenlord must make a save vs petrification every time he meets any undead. If he fails the save, the greenlord suffers the effects of fear. Obviously, greenlords cannot turn undead.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Druid\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Animal Lore (Proficiency)|Animal lore]], [[Tracking (Proficiency)|tracking]]\n|-\n| '''Recommended Proficiencies''' || [[Animal Handling (Proficiency)|Animal handling]], [[Herbalism (Proficiency)|herbalism]]\n|}__TOC__\n==Overview==\nGreenlords and greenladies are a special class of priest of Silvanus. They are devoted to the aggressive defense of both flora and fauna, often to the detriment of \"civilized\" folk in the area. They see cities, roads, and even farmland, as a threat to nature in its pristine state. Most of the time, greenlords keep an eye on civilized expansion, making sure it does not grow too far too fast.\n\n==Description==\nGreenlords favor leather armor decorated with intricately worked carvings, mostly using a leaf motif. Green cloaks, a bronze neck torc with green gems mounted on the ends, and a simple tan tunic completes the outfit. For weapons, a simple wooden staff is the most common.\n\nGreenlords do not hate humans and demihumans per se, Greenlord/lady but they simply devote extra favor to the flora and fauna\n\n==Role-Playing==\ninstead. Greenlords see nature in the \"big picture.\" To them, a forest fire set by lightning is a good thing, since that is nature's way of clearing out deadwood and preventing the overcrowding of tree growth. A wolf pack that has moved into an area is a welcome sight if there is an overabundance of game. If there's a human settlement with livestock nearby, well, that's too bad for the livestock.\n\nThe greenlords will aggressively protect wildlife to the point where they will sabotage human tools to prevent the land from being cultivated. They will often warn away animals from hunting parties. Since greenlords do respect all life, they will do their best not to kill civilized folk, because even the most fanatical greenlords see killing for the sake of saving life to be a contradiction in terms.\n\nGreenlords are perfectly capable of functioning in cities and towns. They merely have no real desire to do so for any length of time. Urban society and its customs are held in high suspicion since the natural world is moved aside for the conveniences and comforts of civilization.\n\nEven though relations with the church of Chauntea are cordial and marked by cooperation, many greenlords see clerics of Chauntea as misguided, half-hearted, and contaminated by too much civilization.\n\n==Special Abilities==\nGreenlords get the ability to speak with animals three times a day at 3rd level, and they can speak with plants three times a day at 5th level.\n\nGreenlords also gain the ability to change into an animal once a day. This ability works exactly like the 5th- level druid ability, but the greenlords gain this ability at 3rd level.\n\n==Special Disadvantages==\nBecause of their fanatical defense of wild nature, greenlords are not well-liked among city and town dwellers. To reflect this, greenlords suffer a -2 reaction penalty to NPC interactions in nonwilderness settings.\n\nIn addition, since the undead are such a horrible contradiction to Silvanus' ideas of nature, a greenlord must make a save vs petrification every time he meets any undead. If he fails the save, the greenlord suffers the effects of fear. Obviously, greenlords cannot turn undead.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Animal lore", "tracking"],
                recommended: ["Animal handling", "herbalism"],
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
                notes: "Obviously, greenlords cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit071: Kit = Kit(
        id: "sune_aesthete",
        name: "Sune - Aesthete",
        wikiPageTitle: "Sune - Aesthete (Character Kit)",
        redirectAliases: ["Priests of Sune (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The aesthetes are a sacred branch of Sune's clergy, devoted to healing disfiguring wounds, removing scars, and promoting the church's ideals of physical beauty.",
            requirements: "Charisma 14, Wisdom 9",
            specialBenefits: "All wounds that could leave a scar will never do so when healed by an aesthete. Protection spells cast by an aesthete have double the normal spell duration. Starting at 5th level, aesthetes can cast regenerate once per week. The recipient regenerates 1 hit point for every 3 turns of full rest he gets during this regeneration effect that lasts for 1d10 hours +1 hour per aesthete's level.",
            specialHindrances: "Aesthetes can only use one weapon, ever. When initially entering melee, an aesthete must make a saving throw vs. paralyzation or suffer a -2 to all rolls due to attempts to protect his face from harm.",
            wealthOptions: "3d6",
            weaponProficiencies: "1",
            nonweaponProficiencies: "Artistic ability (x3)",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "The aesthetes are a sacred branch of Sune's clergy, devoted to healing disfiguring wounds, removing scars, and promoting the church's ideals of physical beauty.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Elf, Human\n|-\n| **Ability Requirements** || Charisma 14,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 1\n|-\n| **Additional Slot** || 0\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Artistic ability (x3)\n|-\n| **Recommended Proficiencies** || Etiquette\n|}\n## Overview\nThe aesthetes are a sacred branch of Sune's clergy, devoted to healing disfiguring wounds, removing scars, and promoting the church's ideals of physical beauty.\n\n## Description\nAesthetes are prime physical specimens of male and female beauty and grace. The priests especially favored of Sune have red hair.\n\nClothing is always made of the finest materials and cut to the latest fashions, although most outfits leave very little to the imagination. No matter how risque the outfit, however, each priest has a red velvet cloak for personal comfort and those rare times when a more modest appearance is called for.\n\n## Role-Playing\nAesthetes divide \"ugly\" people into three categories: those that are born with unattractive appearances, those whose looks have been ruined by wounds, and those who have bad grooming habits. Aesthetes pity the first people but try to bolster their self-images of inner beauty, do all they can to restore the outer visages of the second group of people, and publicly ridicule the third group of people. People will often find themselves the unwilling recipients of fashion advice, grooming tips, or general criticism.\n\n## Special Abilities\nAll wounds that could leave a scar will never do so when healed by an aesthete. Protection spells cast by an aesthete have double the normal spell duration.\n\nStarting at 5th level, aesthetes can cast regenerate once per week. The recipient regenerates 1 hit point for every 3 turns of full rest he gets during this regeneration effect that lasts for 1d10 hours +1 hour per aesthete's level.\n\n## Special Disadvantages\nAesthetes can only use one weapon, ever. When initially entering melee, an aesthete must make a saving throw vs. paralyzation or suffer a -2 to all rolls due to attempts to protect his face from harm.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Elf, Human\n|-\n| '''Ability Requirements''' || [[Charisma]] 14,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 1\n|-\n| '''Additional Slot''' || 0\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Artistic Ability (Proficiency)|Artistic ability]] (x3)\n|-\n| '''Recommended Proficiencies''' || [[Etiquette (Proficiency)|Etiquette]]\n|}__TOC__\n==Overview==\nThe aesthetes are a sacred branch of Sune's clergy, devoted to healing disfiguring wounds, removing scars, and promoting the church's ideals of physical beauty.\n\n==Description==\nAesthetes are prime physical specimens of male and female beauty and grace. The priests especially favored of Sune have red hair.\n\nClothing is always made of the finest materials and cut to the latest fashions, although most outfits leave very little to the imagination. No matter how risque the outfit, however, each priest has a red velvet cloak for personal comfort and those rare times when a more modest appearance is called for.\n\n==Role-Playing==\nAesthetes divide \"ugly\" people into three categories: those that are born with unattractive appearances, those whose looks have been ruined by wounds, and those who have bad grooming habits. Aesthetes pity the first people but try to bolster their self-images of inner beauty, do all they can to restore the outer visages of the second group of people, and publicly ridicule the third group of people. People will often find themselves the unwilling recipients of fashion advice, grooming tips, or general criticism.\n\n==Special Abilities==\nAll wounds that could leave a scar will never do so when healed by an aesthete. Protection spells cast by an aesthete have double the normal spell duration.\n\nStarting at 5th level, aesthetes can cast regenerate once per week. The recipient regenerates 1 hit point for every 3 turns of full rest he gets during this regeneration effect that lasts for 1d10 hours +1 hour per aesthete's level.\n\n==Special Disadvantages==\nAesthetes can only use one weapon, ever. When initially entering melee, an aesthete must make a saving throw vs. paralyzation or suffer a -2 to all rolls due to attempts to protect his face from harm.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9, "Charisma": 14],
                alignments: [],
                races: "Elf, Human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Artistic ability"],
                recommended: ["Etiquette"],
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
        deity: "Sune",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Aesthete"
    )

let embeddedKit072: Kit = Kit(
        id: "sune_silkwhisper",
        name: "Sune - Silkwhisper",
        wikiPageTitle: "Sune - Silkwhisper (Character Kit)",
        redirectAliases: ["Silkwhisper (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "In addition to beauty, Sune's portfolio also covers love and passion. To better represent those two attributes, Sune created the silkwhispers. Silkwhispers are matchmakers, etiquette experts, and seducers or seductresses. The latter functions are important for roles such as spies or negotiators.",
            requirements: "Charisma 16, Intelligence 11, Wisdom 9",
            specialBenefits: "Silkwhispers can cast the 1st-level wizard spell charm person once per day. They regain this spell each day by praying to Sune, just like they do for their priest spells. Since they are masters of distraction, they are more able to spot a falsehood or an avoidance of truth. When a silkwhisper talks to a NPC, the DM can roll an ability check based on the priest's Wisdom, not allowing the rolled result to be seen. If the NPC is not being truthful and the roll is successful, the Silkwhisper senses that the NPC is not being fully honest. Of course, if the silkwhisper fails the check, the DM can still hint, inaccurately, that the priest thinks that the NPC is hiding something.",
            specialHindrances: "Combat is not the Silkwhisper's forte, though they are better at it than the aesthetes. Silkwhispers can choose from this list of weapons: sling, dagger or knife, short sword, blowgun, dart, and club. Silkwhispers cannot wear armor of any type. They must somehow find magical means of defense. If a silkwhisper's Charisma somehow drops below 16, the priest must embark on a quest to regain the lost attribute. This should take at least two months of game time, and be very challenging. Such a quest should involve beauty in some form, either the preservation, protection, or discovery of such. Until such time as the charisma is restored, the silkwhisper must wear a mask or veil, hiding their shame. Silkwhispers cannot turn undead.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Dancing, etiquette",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "In addition to beauty, Sune's portfolio also covers love and passion. To better represent those two attributes, Sune created the silkwhispers.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Elf, half-elf, human\n|-\n| **Ability Requirements** || Charisma 16,Intelligence 11,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Dancing, etiquette\n|-\n| **Recommended Proficiencies** || Artistic ability, reading lips\n|}\n## Overview\nIn addition to beauty, Sune's portfolio also covers love and passion. To better represent those two attributes, Sune created the silkwhispers.\n\nSilkwhispers are matchmakers, etiquette experts, and seducers or seductresses. The latter functions are important for roles such as spies or negotiators.\n\n## Description\nSune's silkwhispers do not dress simply to attract notice— they dress to hold attention as a willing captive with no hope of escape. Female silkwhispers favor sheer, smooth gowns that show off the priestess' figures. Males favor kilts and loose, billowing white silk shirts, if they bother wearing shirts at all. While not noted for their strength, all silkwhispers are muscular and quite physically fit. Long red cloaks and hoods of red velvet are used for comfort and modesty if needed. The cloaks are reversible, with a black lining, should subtlety be necessary.\n\nSilkwhispers are beautiful, charming people who have a complete grasp on the amount of power they have over the opposite sex. Far from being brazen, brainless, vain fools, silkwhispers never overdo it; they know the value of a discreet whisper, a raised eyebrow, the hint of a smile, or the \"accidental\" exposure of a little skin, an artful gesture that appears careless.\n\nSilkwhispers are cunning, intelligent, diplomatic, and well versed in espionage. They are superb actors and actresses, and their best skills involve seductively coercing information out of unsuspecting NPCs.\n\n## Special Abilities\nSilkwhispers can cast the 1st-level wizard spell charm person once per day. They regain this spell each day by praying to Sune, just like they do for their priest spells.\n\nSince they are masters of distraction, they are more able to spot a falsehood or an avoidance of truth. When a silkwhisper talks to a NPC, the DM can roll an ability check based on the priest's Wisdom, not allowing the rolled result to be seen. If the NPC is not being truthful and the roll is successful, the Silkwhisper senses that the NPC is not being fully honest. Of course, if the silkwhisper fails the check, the DM can still hint, inaccurately, that the priest thinks that the NPC is hiding something.\n\n## Special Disadvantages\nCombat is not the Silkwhisper's forte, though they are better at it than the aesthetes. Silkwhispers can choose from this list of weapons: sling, dagger or knife, short sword, blowgun, dart, and club. Silkwhispers cannot wear armor of any type. They must somehow find magical means of defense.\n\nIf a silkwhisper's Charisma somehow drops below 16, the priest must embark on a quest to regain the lost attribute. This should take at least two months of game time, and be very challenging. Such a quest should involve beauty in some form, either the preservation, protection, or discovery of such. Until such time as the charisma is restored, the silkwhisper must wear a mask or veil, hiding their shame.\n\nSilkwhispers cannot turn undead.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Elf, half-elf, human\n|-\n| '''Ability Requirements''' || [[Charisma]] 16,{{br}}[[Intelligence]] 11,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Dancing (Proficiency)|Dancing]], [[Etiquette (Proficiency)|etiquette]]\n|-\n| '''Recommended Proficiencies''' || [[Artistic Ability (Proficiency)|Artistic ability]], [[Reading Lips (Proficiency)|reading lips]]\n|}__TOC__\n==Overview==\nIn addition to beauty, Sune's portfolio also covers love and passion. To better represent those two attributes, Sune created the silkwhispers.\n\nSilkwhispers are matchmakers, etiquette experts, and seducers or seductresses. The latter functions are important for roles such as spies or negotiators.\n\n==Description==\nSune's silkwhispers do not dress simply to attract notice— they dress to hold attention as a willing captive with no hope of escape. Female silkwhispers favor sheer, smooth gowns that show off the priestess' figures. Males favor kilts and loose, billowing white silk shirts, if they bother wearing shirts at all. While not noted for their strength, all silkwhispers are muscular and quite physically fit. Long red cloaks and hoods of red velvet are used for comfort and modesty if needed. The cloaks are reversible, with a black lining, should subtlety be necessary.\n\nSilkwhispers are beautiful, charming people who have a complete grasp on the amount of power they have over the opposite sex. Far from being brazen, brainless, vain fools, silkwhispers never overdo it; they know the value of a discreet whisper, a raised eyebrow, the hint of a smile, or the \"accidental\" exposure of a little skin, an artful gesture that appears careless.\n\nSilkwhispers are cunning, intelligent, diplomatic, and well versed in espionage. They are superb actors and actresses, and their best skills involve seductively coercing information out of unsuspecting NPCs.\n\n==Special Abilities==\nSilkwhispers can cast the 1st-level wizard spell charm person once per day. They regain this spell each day by praying to Sune, just like they do for their priest spells.\n\nSince they are masters of distraction, they are more able to spot a falsehood or an avoidance of truth. When a silkwhisper talks to a NPC, the DM can roll an ability check based on the priest's Wisdom, not allowing the rolled result to be seen. If the NPC is not being truthful and the roll is successful, the Silkwhisper senses that the NPC is not being fully honest. Of course, if the silkwhisper fails the check, the DM can still hint, inaccurately, that the priest thinks that the NPC is hiding something.\n\n==Special Disadvantages==\nCombat is not the Silkwhisper's forte, though they are better at it than the aesthetes. Silkwhispers can choose from this list of weapons: sling, dagger or knife, short sword, blowgun, dart, and club. Silkwhispers cannot wear armor of any type. They must somehow find magical means of defense.\n\nIf a silkwhisper's Charisma somehow drops below 16, the priest must embark on a quest to regain the lost attribute. This should take at least two months of game time, and be very challenging. Such a quest should involve beauty in some form, either the preservation, protection, or discovery of such. Until such time as the charisma is restored, the silkwhisper must wear a mask or veil, hiding their shame.\n\nSilkwhispers cannot turn undead.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 11, "Wisdom": 9, "Charisma": 16],
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
                bonus: ["Dancing", "etiquette"],
                recommended: ["Artistic ability", "reading lips"],
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
                notes: "Silkwhispers cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Sune",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Silkwhisper"
    )

let embeddedKit073: Kit = Kit(
        id: "talona_fang",
        name: "Talona - Fang",
        wikiPageTitle: "Talona - Fang (Character Kit)",
        redirectAliases: ["Priests of Talona (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "A fang is a special type of priest who serves Talona, the lady of poisons and diseases. Fangs have a dual nature, where one aspect brings disease and venom to their victims, and another aspect cures diseases and creates poison antidotes. Heal and harm are the two sides of Talona's fangs.",
            requirements: "Wisdom 9",
            specialBenefits: "Fangs get a +4 bonus to all saving throws vs. poison. A fang can also resist the effects of any poisons he is exposed to and double their onset time to possibly give himself time to neutralize it. A fang can brew poisons and antidotes. A fang must learn one poisoning method from the DUNGEON MASTER® Guide (Injected, Ingested, or Contact). Starting at 3rd level, the fang learns how to brew the first listed poison (and its antidote) of his chosen method. The fang learns how to brew a new poison and antidote every two levels thereafter (two poisons at 5th level, 3 at 7th level, etc.). The poisons are learned in order from the top of the list to the bottom. Once all poisons of one method are known, the fang learns a new method and its poisons. Fangs are immune to disease, even magical diseases like mummy rot, though they are not immune to lycanthropy. They can cure or cause disease once per week for every three levels of the fang.",
            specialHindrances: "Fangs do not like normal melee, as they prefer ambushes and backstabs. They get a +1 penalty on initiative rolls and a -1 penalty on attack rolls if forced to fight in standard melee. Fangs cannot turn undead, and find them disturbing, since poisons cannot hurt them. The melee penalties double when a fang has to fight any undead.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Alchemy, herbalism",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "A fang is a special type of priest who serves Talona, the lady of poisons and diseases. Fangs have a dual nature, where one aspect brings disease and venom to their victims, and another aspect cures diseases and creates poison antidotes. Heal and harm are the two sides of Talona's fangs.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest, Wizard\n|-\n| **Bonus Proficiencies** || Alchemy, herbalism\n|-\n| **Recommended Proficiencies** || Healing\n|}\n## Overview\nA fang is a special type of priest who serves Talona, the lady of poisons and diseases. Fangs have a dual nature, where one aspect brings disease and venom to their victims, and another aspect cures diseases and creates poison antidotes. Heal and harm are the two sides of Talona's fangs.\n\n## Description\nTalona is always represented as an old crone with a hideously scarred and tattooed face. Her fangs fare little better, and most of them voluntarily scar their faces, necks, and bare arms. Tattoos are popular as well, especially on the cheeks and foreheads.\n\nFangs wear a sickly olive-drab, sleeveless overgarment. Most also wear a black wimple that covers their hair and ears, while black leather gloves and a black half-cape are favored accessories. The final touch in a fang's wardrobe is a black iron chain worn around her neck and adorned with a triangular plate that bears the goddess's holy symbol.\n\nFangs reject all armor except for leather that is dyed a sickly green or black. For weapons, fangs rely on darts, daggers, blowguns, and short swords, since these weapons are better at delivering poison-laced wounds.\n\n## Role-Playing\nTalona is a goddess more feared than worshiped, and her priests use that fear to their advantage. They never make overt threats, but, like poison, they insinuate fear by subtle means. When a fang says something, there are at least two other meanings, each with deadlier implications than the previous one.\n\nAlthough fangs do not fear combat, they very rarely enter melee. They believe it is better to use poison or disease to do the killing rather than risk their necks and waste energy with so much swordplay.\n\n## Special Abilities\nFangs get a +4 bonus to all saving throws vs. poison. A fang can also resist the effects of any poisons he is exposed to and double their onset time to possibly give himself time to neutralize it.\n\nA fang can brew poisons and antidotes. A fang must learn one poisoning method from the DUNGEON MASTER® Guide (Injected, Ingested, or Contact). Starting at 3rd level, the fang learns how to brew the first listed poison (and its antidote) of his chosen method. The fang learns how to brew a new poison and antidote every two levels thereafter (two poisons at 5th level, 3 at 7th level, etc.). The poisons are learned in order from the top of the list to the bottom. Once all poisons of one method are known, the fang learns a new method and its poisons.\n\nFangs are immune to disease, even magical diseases like mummy rot, though they are not immune to lycanthropy. They can cure or cause disease once per week for every three levels of the fang.\n\n## Special Disadvantages\nFangs do not like normal melee, as they prefer ambushes and backstabs. They get a +1 penalty on initiative rolls and a -1 penalty on attack rolls if forced to fight in standard melee.\n\nFangs cannot turn undead, and find them disturbing, since poisons cannot hurt them. The melee penalties double when a fang has to fight any undead.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest, Wizard\n|-\n| '''Bonus Proficiencies''' || [[Alchemy (Proficiency)|Alchemy]], [[Herbalism (Proficiency)|herbalism]]\n|-\n| '''Recommended Proficiencies''' || [[Healing (Proficiency)|Healing]]\n|}__TOC__\n==Overview==\nA fang is a special type of priest who serves Talona, the lady of poisons and diseases. Fangs have a dual nature, where one aspect brings disease and venom to their victims, and another aspect cures diseases and creates poison antidotes. Heal and harm are the two sides of Talona's fangs.\n\n==Description==\nTalona is always represented as an old crone with a hideously scarred and tattooed face. Her fangs fare little better, and most of them voluntarily scar their faces, necks, and bare arms. Tattoos are popular as well, especially on the cheeks and foreheads.\n\nFangs wear a sickly olive-drab, sleeveless overgarment. Most also wear a black wimple that covers their hair and ears, while black leather gloves and a black half-cape are favored accessories. The final touch in a fang's wardrobe is a black iron chain worn around her neck and adorned with a triangular plate that bears the goddess's holy symbol.\n\nFangs reject all armor except for leather that is dyed a sickly green or black. For weapons, fangs rely on darts, daggers, blowguns, and short swords, since these weapons are better at delivering poison-laced wounds.\n\n==Role-Playing==\nTalona is a goddess more feared than worshiped, and her priests use that fear to their advantage. They never make overt threats, but, like poison, they insinuate fear by subtle means. When a fang says something, there are at least two other meanings, each with deadlier implications than the previous one.\n\nAlthough fangs do not fear combat, they very rarely enter melee. They believe it is better to use poison or disease to do the killing rather than risk their necks and waste energy with so much swordplay.\n\n==Special Abilities==\nFangs get a +4 bonus to all saving throws vs. poison. A fang can also resist the effects of any poisons he is exposed to and double their onset time to possibly give himself time to neutralize it.\n\nA fang can brew poisons and antidotes. A fang must learn one poisoning method from the DUNGEON MASTER® Guide (Injected, Ingested, or Contact). Starting at 3rd level, the fang learns how to brew the first listed poison (and its antidote) of his chosen method. The fang learns how to brew a new poison and antidote every two levels thereafter (two poisons at 5th level, 3 at 7th level, etc.). The poisons are learned in order from the top of the list to the bottom. Once all poisons of one method are known, the fang learns a new method and its poisons.\n\nFangs are immune to disease, even magical diseases like mummy rot, though they are not immune to lycanthropy. They can cure or cause disease once per week for every three levels of the fang.\n\n==Special Disadvantages==\nFangs do not like normal melee, as they prefer ambushes and backstabs. They get a +1 penalty on initiative rolls and a -1 penalty on attack rolls if forced to fight in standard melee.\n\nFangs cannot turn undead, and find them disturbing, since poisons cannot hurt them. The melee penalties double when a fang has to fight any undead.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Alchemy", "herbalism"],
                recommended: ["Healing"],
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
                notes: "Fangs cannot turn undead, and find them disturbing, since poisons cannot hurt them"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Talona",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Fang"
    )

let embeddedKit074: Kit = Kit(
        id: "talos_chaos_knight",
        name: "Talos - Chaos Knight",
        wikiPageTitle: "Talos - Chaos Knight (Character Kit)",
        redirectAliases: ["Priests of Talos (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "In order to be better served in his role as the embodiment of random destruction, Talos created the chaos knights. These priests, who fanatically adhere to the ethos of chaos colored by evil, revel in destruction of all types, natural and man-made. Chaos knights also serve as the spiritual advisors and \"confessors\" for the crusaders of Talos.",
            requirements: "Wisdom 9",
            specialBenefits: "Chaos knights can detect good at will, 60' in one direction. While Chaos knights can turn away undead, they can also attempt to command any undead except for sentient good undead like archliches. Chaos knights can befoul holy water created by good priests once a day, just by handling the vial and uttering a prayer to Talos. The favored weapon of the chaos knight is the bastard sword. Each chaos knight begins his career by receiving a jet black bastard sword that is considered \"his\" sword. When wielding this sword, the chaos knight gains a +1 to his attack and damage rolls. Chaos knights have access to the Chaos sphere of clerical spells, and gain a bonus of one extra Chaos spell per spell level.",
            specialHindrances: "All Chaos knights must be chaotic evil, following as closely as possible in their god's footsteps. Chaos knights cannot cast any curative spells, spells that raise the dead, regrow limbs, restore levels, or combat poison. However, they can cast the reverse forms of the above spells. Curative spells do not work on Chaos Knights. Healing must come from either bedrest, the healing nonweapon proficiency, or magical items such as a staff of curing, Keoghtom's ointment or potions of healing.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Inquisitor",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "In order to be better served in his role as the embodiment of random destruction, Talos created the chaos knights. These priests, who fanatically adhere to the ethos of chaos colored by evil, revel in destruction of all types, natural and man-made.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Human\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Inquisitor\n|-\n| **Recommended Proficiencies** || Religion\n|}\n## Overview\nIn order to be better served in his role as the embodiment of random destruction, Talos created the chaos knights. These priests, who fanatically adhere to the ethos of chaos colored by evil, revel in destruction of all types, natural and man-made.\n\nChaos knights also serve as the spiritual advisors and \"confessors\" for the crusaders of Talos.\n\n## Description\nChaos knights do indeed resemble knights. They favor plate or splint mail armor decorated with barbs and spikes. This armor is colored jet black. Chaos knights wear full helms, also colored black. A shield is always employed, painted black with a trio of jagged yellow lightning bolts in the center. To top off the whole image, chaos knights wear cloaks and hoods of black, with ragged hems dyed yellow. A wicked-looking bastard sword, the chaos knights' favored weapon is slung across the knight's back in a scabbard (if not already in hand).\n\n## Role-Playing\nThese priests have elevated destruction and the tenets of chaotic evil to a high art. They urge others to commit random acts of destruction and join the revelries of chaos as well.\n\nAll chaos knights tend to be at least a little insane, intoxicated by acts of evil and destruction. On many occasions, chaos knights have died amid such paroxysms of violence, yet all died happily in the process of serving Talos.\n\nThe philosophy adhered to and often quoted by the chaos knights can be summed up as follows: \"Disregard all laws, rules, and social expectations. Follow your own desires, and strike out at those around you before they strike at you. The freedom of chaos is the only true freedom.\"\n\n## Special Abilities\nChaos knights can detect good at will, 60' in one direction. While Chaos knights can turn away undead, they can\n\nalso attempt to command any undead except for sentient good undead like archliches.\n\nChaos knights can befoul holy water created by good priests once a day, just by handling the vial and uttering a prayer to Talos.\n\nThe favored weapon of the chaos knight is the bastard sword. Each chaos knight begins his career by receiving a jet black bastard sword that is considered \"his\" sword. When wielding this sword, the chaos knight gains a +1 to his attack and damage rolls.\n\nChaos knights have access to the Chaos sphere of clerical spells, and gain a bonus of one extra Chaos spell per spell level.\n\n## Special Disadvantages\nAll Chaos knights must be chaotic evil, following as closely as possible in their god's footsteps.\n\nChaos knights cannot cast any curative spells, spells that raise the dead, regrow limbs, restore levels, or combat poison. However, they can cast the reverse forms of the above spells.\n\nCurative spells do not work on Chaos Knights. Healing must come from either bedrest, the healing nonweapon proficiency, or magical items such as a staff of curing, Keoghtom's ointment or potions of healing.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Human\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Inquisitor (Character Kit)|Inquisitor]]\n|-\n| '''Recommended Proficiencies''' || [[Religion (Proficiency)|Religion]]\n|}__TOC__\n==Overview==\nIn order to be better served in his role as the embodiment of random destruction, Talos created the chaos knights. These priests, who fanatically adhere to the ethos of chaos colored by evil, revel in destruction of all types, natural and man-made.\n\nChaos knights also serve as the spiritual advisors and \"confessors\" for the crusaders of Talos.\n\n==Description==\nChaos knights do indeed resemble knights. They favor plate or splint mail armor decorated with barbs and spikes. This armor is colored jet black. Chaos knights wear full helms, also colored black. A shield is always employed, painted black with a trio of jagged yellow lightning bolts in the center. To top off the whole image, chaos knights wear cloaks and hoods of black, with ragged hems dyed yellow. A wicked-looking bastard sword, the chaos knights' favored weapon is slung across the knight's back in a scabbard (if not already in hand).\n\n==Role-Playing==\nThese priests have elevated destruction and the tenets of chaotic evil to a high art. They urge others to commit random acts of destruction and join the revelries of chaos as well.\n\nAll chaos knights tend to be at least a little insane, intoxicated by acts of evil and destruction. On many occasions, chaos knights have died amid such paroxysms of violence, yet all died happily in the process of serving Talos.\n\nThe philosophy adhered to and often quoted by the chaos knights can be summed up as follows: \"Disregard all laws, rules, and social expectations. Follow your own desires, and strike out at those around you before they strike at you. The freedom of chaos is the only true freedom.\"\n\n==Special Abilities==\nChaos knights can detect good at will, 60' in one direction. While Chaos knights can turn away undead, they can\n\nalso attempt to command any undead except for sentient good undead like archliches.\n\nChaos knights can befoul holy water created by good priests once a day, just by handling the vial and uttering a prayer to Talos.\n\nThe favored weapon of the chaos knight is the bastard sword. Each chaos knight begins his career by receiving a jet black bastard sword that is considered \"his\" sword. When wielding this sword, the chaos knight gains a +1 to his attack and damage rolls.\n\nChaos knights have access to the Chaos sphere of clerical spells, and gain a bonus of one extra Chaos spell per spell level.\n\n==Special Disadvantages==\nAll Chaos knights must be chaotic evil, following as closely as possible in their god's footsteps.\n\nChaos knights cannot cast any curative spells, spells that raise the dead, regrow limbs, restore levels, or combat poison. However, they can cast the reverse forms of the above spells.\n\nCurative spells do not work on Chaos Knights. Healing must come from either bedrest, the [[Healing (Proficiency)|healing]] nonweapon proficiency, or magical items such as a staff of curing, Keoghtom's ointment or potions of healing.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Inquisitor"],
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
        deity: "Talos",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Chaos Knight"
    )

let embeddedKit075: Kit = Kit(
        id: "talos_stormrider",
        name: "Talos - Stormrider",
        wikiPageTitle: "Talos - Stormrider (Character Kit)",
        redirectAliases: ["Stormrider (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Talos, being the god of natural forms of destruction as well as destruction in general, has commissioned a sect of priests called stormriders, who can exercise Talos' holy power to calm or raise storms.",
            requirements: "Wisdom 9",
            specialBenefits: "Stormriders have access to certain wizard spells. At 3rd level, a stormrider can cast whispering wind once per day. At 5th level, a stormrider can cast gust of wind once per day. At 7th level, a stormrider can cast a lightning bolt once per day. Once a week after reaching 10th level, a stormrider has a 5% likelihood per level, to a maximum of 90%, of raising a storm or other bad weather conditions. The effects and mechanics on how to affect the weather are identical to the 6th-level wizard spell control weather.",
            specialHindrances: "Stormriders despise non-overcast weather. On clear and partly cloudy days, every die roll of a stormrider is penalized by 2. Followers of Chauntea and Silvanus dislike any followers of Talos simply due to their disruption of natural weather patterns. Stormriders suffer a -4 NPC reaction penalty when encountering said followers.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Weather sense",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Talos, being the god of natural forms of destruction as well as destruction in general, has commissioned a sect of priests called stormriders, who can exercise Talos' holy power to calm or raise storms.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Weather sense\n|-\n| **Recommended Proficiencies** || None\n|}\n## Overview\nTalos, being the god of natural forms of destruction as well as destruction in general, has commissioned a sect of priests called stormriders, who can exercise Talos' holy power to calm or raise storms.\n\n## Description\nMost stormriders favor black cloaks, shirts, and pants. Talos' holy symbol is usually found on a chain around a stormrider's neck. For a weapon, they carry a staff made of wood and iron, topped with a silver ball (damage equal to a footman's mace).\n\nEven on the calmest day, a stormrider looks as if he has just emerged from a violent storm with his face craggy from windburn, his hair tossed wildly, and his clothing whipped around him.\n\n## Role-Playing\nStormriders are chaotic individuals of foul dispositions. They revel in natural destruction, even to the point of foolishly running into the heart of the disaster. Stormriders also enjoy a good bout of looting.\n\n## Special Abilities\nStormriders have access to certain wizard spells. At 3rd level, a stormrider can cast whispering wind once per day. At 5th level, a stormrider can cast gust of wind once per day. At 7th level, a stormrider can cast a lightning bolt once per day.\n\nOnce a week after reaching 10th level, a stormrider has a 5% likelihood per level, to a maximum of 90%, of raising a storm or other bad weather conditions. The effects and mechanics on how to affect the weather are identical to the 6th-level wizard spell control weather.\n\n## Special Disadvantages\nStormriders despise non-overcast weather. On clear and partly cloudy days, every die roll of a stormrider is penalized by 2.\n\nFollowers of Chauntea and Silvanus dislike any followers of Talos simply due to their disruption of natural weather patterns. Stormriders suffer a -4 NPC reaction penalty when encountering said followers.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Weather Sense (Proficiency)|Weather sense]]\n|-\n| '''Recommended Proficiencies''' || None\n|}__TOC__\n==Overview==\nTalos, being the god of natural forms of destruction as well as destruction in general, has commissioned a sect of priests called stormriders, who can exercise Talos' holy power to calm or raise storms.\n\n==Description==\nMost stormriders favor black cloaks, shirts, and pants. Talos' holy symbol is usually found on a chain around a stormrider's neck. For a weapon, they carry a staff made of wood and iron, topped with a silver ball (damage equal to a footman's mace).\n\nEven on the calmest day, a stormrider looks as if he has just emerged from a violent storm with his face craggy from windburn, his hair tossed wildly, and his clothing whipped around him.\n\n==Role-Playing==\nStormriders are chaotic individuals of foul dispositions. They revel in natural destruction, even to the point of foolishly running into the heart of the disaster. Stormriders also enjoy a good bout of looting.\n\n==Special Abilities==\nStormriders have access to certain wizard spells. At 3rd level, a stormrider can cast whispering wind once per day. At 5th level, a stormrider can cast gust of wind once per day. At 7th level, a stormrider can cast a lightning bolt once per day.\n\nOnce a week after reaching 10th level, a stormrider has a 5% likelihood per level, to a maximum of 90%, of raising a storm or other bad weather conditions. The effects and mechanics on how to affect the weather are identical to the 6th-level wizard spell control weather.\n\n==Special Disadvantages==\nStormriders despise non-overcast weather. On clear and partly cloudy days, every die roll of a stormrider is penalized by 2.\n\nFollowers of Chauntea and Silvanus dislike any followers of Talos simply due to their disruption of natural weather patterns. Stormriders suffer a -4 NPC reaction penalty when encountering said followers.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Weather sense"],
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
        deity: "Talos",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Stormrider"
    )

let embeddedKit076: Kit = Kit(
        id: "tempus_battleforge",
        name: "Tempus - Battleforge",
        wikiPageTitle: "Tempus - Battleforge (Character Kit)",
        redirectAliases: ["Priests of Tempus (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Tempus is the god of war and the lord of battles. What sort of conflict can one have without weapons at the ready? The battleforges of Tempus are the weaponers of the church, clerics who seem to be a bit too fond of \"field-testing\" their creations.",
            requirements: "Intelligence 14, Wisdom 9",
            specialBenefits: "Battleforges immediately start out with a suit of plate mail and the choice of one weapon. By looking at any weapon, suit of armor, or shield, a battleforge can correctly discern its magical bonuses and any special abilities. Using nonmagical weapons they themselves forged, battleforges can attack and damage monsters that normally requires a magical weapon to hit.",
            specialHindrances: "Battleforges cannot cast spells from the Animal, Healing, or Plant spheres, nor can they turn undead.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Armorer, weaponsmithing",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Tempus is the god of war and the lord of battles. What sort of conflict can one have without weapons at the ready? The battleforges of Tempus are the weaponers of the church, clerics who seem to be a bit too fond of \"field-testing\" their creations.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Dwarf, gnome, half-elf, human\n|-\n| **Ability Requirements** || Intelligence 14,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Armorer, weaponsmithing\n|-\n| **Recommended Proficiencies** || Blacksmithing\n|}\n## Overview\nTempus is the god of war and the lord of battles. What sort of conflict can one have without weapons at the ready? The battleforges of Tempus are the weaponers of the church, clerics who seem to be a bit too fond of \"field-testing\" their creations.\n\n## Description\nOne bard has wryly observed that battleforges are \"the least banged-up of the clergy of Tempus,\" since battleforges spend much of their time in the weapon foundries. Their task is to make new weapons and armor as the church priests need or demand them.\n\nThe average battleforge wears a sturdy suit of plate armor with a blood-red sash worn diagonally across the chest from shoulder to hip. They favor warhammers and swords in combat. Battleforges never wear helmets.\n\n## Role-Playing\nImagine a blacksmith who creates a set of horseshoes and then cannot resist immediately putting them on a horse and riding it twenty miles. Battleforges come from such a mindset. They see the forging of every weapon or suit of armor as an act of devotion.\n\n## Special Abilities\nBattleforges immediately start out with a suit of plate mail and the choice of one weapon.\n\nBy looking at any weapon, suit of armor, or shield, a battleforge can correctly discern its magical bonuses and any special abilities.\n\nUsing nonmagical weapons they themselves forged, battleforges can attack and damage monsters that normally requires a magical weapon to hit.\n\n## Special Disadvantages\nBattleforges cannot cast spells from the Animal, Healing, or Plant spheres, nor can they turn undead.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Dwarf, gnome, half-elf, human\n|-\n| '''Ability Requirements''' || [[Intelligence]] 14,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Armorer (Proficiency)|Armorer]], [[Weaponsmithing (Proficiency)|weaponsmithing]]\n|-\n| '''Recommended Proficiencies''' || [[Blacksmithing (Proficiency)|Blacksmithing]]\n|}__TOC__\n==Overview==\nTempus is the god of war and the lord of battles. What sort of conflict can one have without weapons at the ready? The battleforges of Tempus are the weaponers of the church, clerics who seem to be a bit too fond of \"field-testing\" their creations.\n\n==Description==\nOne bard has wryly observed that battleforges are \"the least banged-up of the clergy of Tempus,\" since battleforges spend much of their time in the weapon foundries. Their task is to make new weapons and armor as the church priests need or demand them.\n\nThe average battleforge wears a sturdy suit of plate armor with a blood-red sash worn diagonally across the chest from shoulder to hip. They favor warhammers and swords in combat. Battleforges never wear helmets.\n\n==Role-Playing==\nImagine a blacksmith who creates a set of horseshoes and then cannot resist immediately putting them on a horse and riding it twenty miles. Battleforges come from such a mindset. They see the forging of every weapon or suit of armor as an act of devotion.\n\n==Special Abilities==\nBattleforges immediately start out with a suit of plate mail and the choice of one weapon.\n\nBy looking at any weapon, suit of armor, or shield, a battleforge can correctly discern its magical bonuses and any special abilities.\n\nUsing nonmagical weapons they themselves forged, battleforges can attack and damage monsters that normally requires a magical weapon to hit.\n\n==Special Disadvantages==\nBattleforges cannot cast spells from the Animal, Healing, or Plant spheres, nor can they turn undead.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 14, "Wisdom": 9],
                alignments: [],
                races: "Dwarf, gnome, half-elf, human"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Armorer", "weaponsmithing"],
                recommended: ["Blacksmithing"],
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
        deity: "Tempus",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Battleforge"
    )

let embeddedKit077: Kit = Kit(
        id: "tempus_gloryblood",
        name: "Tempus - Gloryblood",
        wikiPageTitle: "Tempus - Gloryblood (Character Kit)",
        redirectAliases: ["Gloryblood (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The glorybloods are the soldier-priests of Tempus in every sense of the word. Not only are they fanatically devout followers of Tempus' teachings, but they specialize in military matters such as strategy, tactics, logistics, and morale.",
            requirements: "Strength 14, Wisdom 9",
            specialBenefits: "In battle, glorybloods inspire their comrades to greater feats of battle. Companions in sight range (maximum 50 yards) get +1 bonuses to attack and damage rolls and saving throws, and +2 bonuses to morale. Once a day per level, at the beginning of an encounter, a gloryblood may call on his tactical knowledge. If he does, everyone of his allies gets a -1 bonus to their initiative rolls.",
            specialHindrances: "Glorybloods cannot cast any spells from the Healing sphere, nor can they turn undead. A gloryblood can never retreat from battle unless he is either opposed by more than three equal-sized foes or an enemy with at least three times as many hit dice as the priest. If he leaves a battle of lesser odds than this for any reason, the gloryblood disgraces his office. His priestly spells and abilities are gone immediately and he is considered a fighter of his current level. He can regain his gloryblood status once he has slain or helped slay as many foes as he has levels. These foes must all be slain in melee combat, and must be of at least equal level/hit dice to him.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Blindfighting",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "The glorybloods are the soldier-priests of Tempus in every sense of the word. Not only are they fanatically devout followers of Tempus' teachings, but they specialize in military matters such as strategy, tactics, logistics, and morale.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Strength 14,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || Yes\n|-\n| **Exceptional Constitution?** || Yes\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Blindfighting\n|-\n| **Recommended Proficiencies** || Endurance, riding, land-based\n|}\n## Overview\nThe glorybloods are the soldier-priests of Tempus in every sense of the word. Not only are they fanatically devout followers of Tempus' teachings, but they specialize in military matters such as strategy, tactics, logistics, and morale.\n\n## Description\nGlorybloods wear battered, bloodied armor of all types, though most wear chain, splint, or plate mail. These priests also use any number of different weapons. Glory bloods would be mistaken for any normal follower of Tempus, but they seem to radiate a definite air of command and authority in battle.\n\n## Role-Playing\nJust as the sight of a king's banner can inspire and rally the troops in war, the glorybloods rouse those around them and lead everyone to that state of glory that can only be achieved through hard-fought battles in Tempus' name. Glorybloods are not mere armchair generals leading the troops from the safety of the rear lines. Rather, they recklessly lead the charge, screaming bloody murder and smiting any enemies that dare get in their way.\n\nMany glorybloods will charge at overwhelming opponents single-handed, heedless of certain death. This exasperates the priest's comrades, as it usually forces them into the battle as well. Glorybloods never ask anyone to attack anything that they themselves wouldn't fight by themselves!\n\nGlorybloods are especially intolerant of mistakes made in combat. If someone misses a target, fumbles a melee attack, or accidently hits a comrad, the gloryblood will insist on improving his comrades' combat skills. The priests command these offenders to attend combat drills at dawn or some other exercises.\n\nIf a gloryblood is ever forced to retreat, he will swear to return someday to \"finish the job.\" From that point on, this return engagement will be foremost in his mind. When he feels confident of his chances for victory against the foe who forced his retreat, he will seek that adversary out and force a confrontation.\n\n## Special Abilities\nIn battle, glorybloods inspire their comrades to greater feats of battle. Companions in sight range (maximum 50 yards) get +1 bonuses to attack and damage rolls and saving throws, and +2 bonuses to morale.\n\nOnce a day per level, at the beginning of an encounter, a gloryblood may call on his tactical knowledge. If he does, everyone of his allies gets a -1 bonus to their initiative rolls.\n\n## Special Disadvantages\nGlorybloods cannot cast any spells from the Healing sphere, nor can they turn undead.\n\nA gloryblood can never retreat from battle unless he is either opposed by more than three equal-sized foes or an enemy with at least three times as many hit dice as the priest. If he leaves a battle of lesser odds than this for any reason, the gloryblood disgraces his office. His priestly spells and abilities are gone immediately and he is considered a fighter of his current level. He can regain his gloryblood status once he has slain or helped slay as many foes as he has levels. These foes must all be slain in melee combat, and must be of at least equal level/hit dice to him.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Strength]] 14,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || Yes\n|-\n| '''Exceptional Constitution?''' || Yes\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Blind-fighting (Proficiency)|Blindfighting]]\n|-\n| '''Recommended Proficiencies''' || [[Endurance (Proficiency)|Endurance]], [[Riding, Land-Based (Proficiency)|riding, land-based]]\n|}__TOC__\n==Overview==\nThe glorybloods are the soldier-priests of Tempus in every sense of the word. Not only are they fanatically devout followers of Tempus' teachings, but they specialize in military matters such as strategy, tactics, logistics, and morale.\n\n==Description==\nGlorybloods wear battered, bloodied armor of all types, though most wear chain, splint, or plate mail. These priests also use any number of different weapons. Glory bloods would be mistaken for any normal follower of Tempus, but they seem to radiate a definite air of command and authority in battle.\n\n==Role-Playing==\nJust as the sight of a king's banner can inspire and rally the troops in war, the glorybloods rouse those around them and lead everyone to that state of glory that can only be achieved through hard-fought battles in Tempus' name. Glorybloods are not mere armchair generals leading the troops from the safety of the rear lines. Rather, they recklessly lead the charge, screaming bloody murder and smiting any enemies that dare get in their way.\n\nMany glorybloods will charge at overwhelming opponents single-handed, heedless of certain death. This exasperates the priest's comrades, as it usually forces them into the battle as well. Glorybloods never ask anyone to attack anything that they themselves wouldn't fight by themselves!\n\nGlorybloods are especially intolerant of mistakes made in combat. If someone misses a target, fumbles a melee attack, or accidently hits a comrad, the gloryblood will insist on improving his comrades' combat skills. The priests command these offenders to attend combat drills at dawn or some other exercises.\n\nIf a gloryblood is ever forced to retreat, he will swear to return someday to \"finish the job.\" From that point on, this return engagement will be foremost in his mind. When he feels confident of his chances for victory against the foe who forced his retreat, he will seek that adversary out and force a confrontation.\n\n==Special Abilities==\nIn battle, glorybloods inspire their comrades to greater feats of battle. Companions in sight range (maximum 50 yards) get +1 bonuses to attack and damage rolls and saving throws, and +2 bonuses to morale.\n\nOnce a day per level, at the beginning of an encounter, a gloryblood may call on his tactical knowledge. If he does, everyone of his allies gets a -1 bonus to their initiative rolls.\n\n==Special Disadvantages==\nGlorybloods cannot cast any spells from the Healing sphere, nor can they turn undead.\n\nA gloryblood can never retreat from battle unless he is either opposed by more than three equal-sized foes or an enemy with at least three times as many hit dice as the priest. If he leaves a battle of lesser odds than this for any reason, the gloryblood disgraces his office. His priestly spells and abilities are gone immediately and he is considered a fighter of his current level. He can regain his gloryblood status once he has slain or helped slay as many foes as he has levels. These foes must all be slain in melee combat, and must be of at least equal level/hit dice to him.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Strength": 14, "Wisdom": 9],
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
                bonus: ["Blindfighting"],
                recommended: ["Endurance", "riding", "land-based"],
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
        deity: "Tempus",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Gloryblood"
    )

let embeddedKit078: Kit = Kit(
        id: "tik",
        name: "Tik",
        wikiPageTitle: "Tik (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Cleric",
            allowedClasses: ["Cleric"]
        ),
        sourceBook: "The Complete Cleric's Handbook",
        features: KitFeatures(
            role: "The Tik is first and foremost a hunter, the hunt for food occupies most of the character's thought processes. The individual hunts whenever possible, collects food, and has little love for staying in one place. In a pack of thri-kreen, the Tik hunts when possible, but might also serve as a scout (kalal) or guardian (tikit). Note that a Tik serving in either one of these roles does not have any of the special advantages and disadvantages of the kits of the same name. A Tik is most often found among humanoids when his or her own pack has been destroyed. A Tik in such a group is usually confused by humanoid behavior and often tries to fit in by performing the same duties he or she would perform for the pack. A Tik with clutch-mates who sleep usually hunts, scouts, or guards while they do so, though it takes awhile to become used to this strange way of \"wasting time.\" The Tik is most strictly guided by tokchak (egg-mind) and tikchak (hunt-mind). When they do travel to villages or cities, they tend to be ignorant of \"civilized\" ways and a target for fear, suspicion, and prejudice.",
            requirements: nil,
            specialBenefits: "Tik have the standard thri-kreen racial bonuses.",
            specialHindrances: "The character suffers no special hindrances other than the prejudices normally suffered by thri-kreen. Since Kik raiders are seen much more often among humanoids, the non-kreen often expect a thri-kreen to be a Kik; they seldom understand or accept that a Trk, though a hunter, does not hunt sapients.",
            wealthOptions: "The Tik receives the standard amount of wealth for his or her character class and forfeits any not spent.",
            weaponProficiencies: "A Tik is, at start, limited to thri-kreen weapons. Proficiency with the gythka is required; the zerka is recommended. Chatkcha is never taken before receiving it for free at 5th level.",
            nonweaponProficiencies: "The proficiencies for the Tik are as follows. * Bonus Proficiencies: Hunting, tracking. Tik track as non-rangers unless they are members of the ranger class. They use their Wisdom as their base score for hunting (essentially a +1 bonus). * Required Proficiencies: Animal lore, survival. * Recommended: Direction sense, endurance, weapon-smithing (kreen). * Barred: Spellcraft, swimming (never available).",
            equipment: "The Tik is limited to thri-kreen equipment until exposed to outside culture. Even then, the character tends to use traditional items."
        ),
        description: KitDescription(
            briefSummary: "Tik are the most common type of thri-kreen, though uncommonly seen by humanoids, because they tend to remain with their packs. The Tik kit is for those who want to role-play a classic thri-kreen.",
            fullText: "## Tik (Hunter)\nTik are the most common type of thri-kreen, though uncommonly seen by humanoids, because they tend to remain with their packs. The Tik kit is for those who want to role-play a classic thri-kreen.\n\n**Character Class:** This kit can be used by any thri-kreen except a cleric, druid, or combination that includes either of these classes.\n\n**Role:** The Tik is first and foremost a hunter, the hunt for food occupies most of the character's thought processes. The individual hunts whenever possible, collects food, and has little love for staying in one place. In a pack of thri-kreen, the Tik hunts when possible, but might also serve as a scout (kalal) or guardian (tikit). Note that a Tik serving in either one of these roles does not have any of the special advantages and disadvantages of the kits of the same name.\n\nA Tik is most often found among humanoids when his or her own pack has been destroyed. A Tik in such a group is usually confused by humanoid behavior and often tries to fit in by performing the same duties he or she would perform for the pack. A Tik with clutch-mates who sleep usually hunts, scouts, or guards while they do so, though it takes awhile to become used to this strange way of \"wasting time.\" The Tik is most strictly guided by tokchak (egg-mind) and tikchak (hunt-mind). When they do travel to villages or cities, they tend to be ignorant of \"civilized\" ways and a target for fear, suspicion, and prejudice.\n\n**Weapon Proficiencies:** A Tik is, at start, limited to thri-kreen weapons. Proficiency with the gythka is required; the zerka is recommended. Chatkcha is never taken before receiving it for free at 5th level.\n\n**Nonweapon Proficiencies:** The proficiencies for the Tik are as follows.\n\n* **Bonus Proficiencies:** Hunting, tracking. Tik track as non-rangers unless they are members of the ranger class. They use their Wisdom as their base score for hunting (essentially a +1 bonus).\n* **Required Proficiencies:** Animal lore, survival.\n* **Recommended:** Direction sense, endurance, weapon-smithing (kreen).\n* **Barred:** Spellcraft, swimming (never available).\n\n**Equipment:** The Tik is limited to thri-kreen equipment until exposed to outside culture. Even then, the character tends to use traditional items.\n\n**Special Benefits:** Tik have the standard thri-kreen racial bonuses.\n\n**Special Hindrances:** The character suffers no special hindrances other than the prejudices normally suffered by thri-kreen.\n\nSince Kik raiders are seen much more often among humanoids, the non-kreen often expect a thri-kreen to be a Kik; they seldom understand or accept that a Trk, though a hunter, does not hunt sapients.\n\n**Wealth Options:** The Tik receives the standard amount of wealth for his or her character class and forfeits any not spent.",
            rawWikitext: "{{Sidebar TKA Ch6}}\n==Tik (Hunter)==\nTik are the most common type of thri-kreen, though uncommonly seen by humanoids, because they tend to remain with their packs. The Tik kit is for those who want to role-play a classic thri-kreen.\n\n'''Character Class:''' This kit can be used by any thri-kreen except a cleric, druid, or combination that includes either of these classes.\n\n'''Role:''' The Tik is first and foremost a hunter, the hunt for food occupies most of the character's thought processes. The individual hunts whenever possible, collects food, and has little love for staying in one place. In a pack of thri-kreen, the Tik hunts when possible, but might also serve as a scout (kalal) or guardian (tikit). Note that a Tik serving in either one of these roles does not have any of the special advantages and disadvantages of the kits of the same name.\n\nA Tik is most often found among humanoids when his or her own pack has been destroyed. A Tik in such a group is usually confused by humanoid behavior and often tries to fit in by performing the same duties he or she would perform for the pack. A Tik with clutch-mates who sleep usually hunts, scouts, or guards while they do so, though it takes awhile to become used to this strange way of \"wasting time.\" The Tik is most strictly guided by tokchak (egg-mind) and tikchak (hunt-mind). When they do travel to villages or cities, they tend to be ignorant of \"civilized\" ways and a target for fear, suspicion, and prejudice.\n\n'''Weapon Proficiencies:''' A Tik is, at start, limited to thri-kreen weapons. Proficiency with the gythka is required; the zerka is recommended. Chatkcha is never taken before receiving it for free at 5th level.\n\n'''Nonweapon Proficiencies:''' The proficiencies for the Tik are as follows.\n\n* '''Bonus Proficiencies:''' Hunting, tracking. Tik track as non-rangers unless they are members of the ranger class. They use their Wisdom as their base score for hunting (essentially a +1 bonus).\n* '''Required Proficiencies:''' Animal lore, survival.\n* '''Recommended:''' Direction sense, endurance, weapon-smithing (kreen).\n* '''Barred:''' Spellcraft, swimming (never available).\n\n'''Equipment:''' The Tik is limited to thri-kreen equipment until exposed to outside culture. Even then, the character tends to use traditional items.\n\n'''Special Benefits:''' Tik have the standard thri-kreen racial bonuses.\n\n'''Special Hindrances:''' The character suffers no special hindrances other than the prejudices normally suffered by thri-kreen.\n\nSince Kik raiders are seen much more often among humanoids, the non-kreen often expect a thri-kreen to be a Kik; they seldom understand or accept that a Trk, though a hunter, does not hunt sapients.\n\n'''Wealth Options:''' The Tik receives the standard amount of wealth for his or her character class and forfeits any not spent.\n\n{{Navbox Thri-Kreen of Athas}}"
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
                recommended: [],
                forbidden: [],
                notes: "A Tik is, at start, limited to thri-kreen weapons. Proficiency with the gythka is required; the zerka is recommended. Chatkcha is never taken before receiving it for free at 5th level."
            ),
            proficiencies: KitProficiencyRules(
                bonus: [],
                recommended: ["Direction sense", "endurance", "weapon-smithing "],
                notes: "Hunting, tracking. Tik track as non-rangers unless they are members of the ranger class. They use their Wisdom as their base score for hunting (essentially a +1 bonus)."
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

let embeddedKit079: Kit = Kit(
        id: "torm_paragon",
        name: "Torm - Paragon",
        wikiPageTitle: "Torm - Paragon (Character Kit)",
        redirectAliases: ["Paragon (Character Kit)", "Priests of Torm (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Paragons are best described as priests who act like paladins, much in the same way as Torm's crusaders, but paragons have much closer ties to the organized church. Thus far, the only paragons of Torm are found operating in the vicinity of Tantras. Paragons focus on completing quests or leading people in a great cause or crusade. With the rise in Torm's popularity (from a corresponding fall in Helm's reputation and church), the paragons always hope to lead new worshipers to great deeds in Torm's name.",
            requirements: "Charisma 15, Wisdom 9",
            specialBenefits: "Paragons have all the special powers of a paladin, except for a paladin's priestly spell abilities. They turn undead at four levels lower than their actual experience level.",
            specialHindrances: "Paragons have all the restrictions of paladins. Additionally, at 6th level and each level after that, a paragon must undergo a quest, commit a heroic deed, or slay a monster of twice the paragon's level singlehandedly before he can advance to the next level.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Religion",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Paragons are best described as priests who act like paladins, much in the same way as Torm's crusaders, but paragons have much closer ties to the organized church. Thus far, the only paragons of Torm are found operating in the vicinity of Tantras.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Human\n|-\n| **Ability Requirements** || Charisma 15, Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || Yes\n|-\n| **Exceptional Constitution?** || Yes\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest, Warrior\n|-\n| **Bonus Proficiencies** || Religion\n|-\n| **Recommended Proficiencies** || Blindfighting\n|}\n## Overview\nParagons are best described as priests who act like paladins, much in the same way as Torm's crusaders, but paragons have much closer ties to the organized church. Thus far, the only paragons of Torm are found operating in the vicinity of Tantras.\n\nParagons focus on completing quests or leading people in a great cause or crusade. With the rise in Torm's popularity (from a corresponding fall in Helm's reputation and church), the paragons always hope to lead new worshipers to great deeds in Torm's name.\n\n## Description\nParagons wear glistening white plate mail, massive pearl-white helms, and sky-blue cloaks. They look every inch the hero, and one would swear that they actually glow with holiness. Paragons favor two-handed swords or bastard swords, and thus refuse to use shields.\n\n## Role-Playing\nParagons are scrupulously honest and fiercely loyal to Torm's credos. They do not utter vows lightly, because they will die before breaking one. Paragons are idealistic heroes who love grand quests and crusades. These holiest of priests deliberately keep a high profile wherever they go to inspire those around them.\n\n## Special Abilities\nParagons have all the special powers of a paladin, except for a paladin's priestly spell abilities. They turn undead at four levels lower than their actual experience level.\n\n## Special Disadvantages\nParagons have all the restrictions of paladins. Additionally, at 6th level and each level after that, a paragon must undergo a quest, commit a heroic deed, or slay a monster of twice the paragon's level singlehandedly before he can advance to the next level.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Human\n|-\n| '''Ability Requirements''' || [[Charisma]] 15, [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || Yes\n|-\n| '''Exceptional Constitution?''' || Yes\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest, Warrior\n|-\n| '''Bonus Proficiencies''' || [[Religion (Proficiency)|Religion]]\n|-\n| '''Recommended Proficiencies''' || [[Blind-fighting (Proficiency)|Blindfighting]]\n|}__TOC__\n==Overview==\nParagons are best described as priests who act like paladins, much in the same way as Torm's crusaders, but paragons have much closer ties to the organized church. Thus far, the only paragons of Torm are found operating in the vicinity of Tantras.\n\nParagons focus on completing quests or leading people in a great cause or crusade. With the rise in Torm's popularity (from a corresponding fall in Helm's reputation and church), the paragons always hope to lead new worshipers to great deeds in Torm's name.\n\n==Description==\nParagons wear glistening white plate mail, massive pearl-white helms, and sky-blue cloaks. They look every inch the hero, and one would swear that they actually glow with holiness. Paragons favor two-handed swords or bastard swords, and thus refuse to use shields.\n\n==Role-Playing==\nParagons are scrupulously honest and fiercely loyal to Torm's credos. They do not utter vows lightly, because they will die before breaking one. Paragons are idealistic heroes who love grand quests and crusades. These holiest of priests deliberately keep a high profile wherever they go to inspire those around them.\n\n==Special Abilities==\nParagons have all the special powers of a paladin, except for a paladin's priestly spell abilities. They turn undead at four levels lower than their actual experience level.\n\n==Special Disadvantages==\nParagons have all the restrictions of paladins. Additionally, at 6th level and each level after that, a paragon must undergo a quest, commit a heroic deed, or slay a monster of twice the paragon's level singlehandedly before he can advance to the next level.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Wisdom": 9, "Charisma": 15],
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
                bonus: ["Religion"],
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
                mode: "modified",
                notes: "turn undead at four levels lower than their actual experience level"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Torm",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Paragon"
    )
