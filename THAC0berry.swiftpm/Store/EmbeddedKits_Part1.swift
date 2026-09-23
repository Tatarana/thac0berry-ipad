import Foundation

/// Parte 1 de 5 dos kits embutidos — ver `EmbeddedKits.swift` pro
/// porquê disso existir (nunca volte pra ler isso de JSON/bundle) e pro porquê
/// de estar dividido em vários arquivos/constantes em vez de um array literal
/// único gigante: um único `[Kit(...), Kit(...), ...]` com todos os kits
/// dá exatamente no erro clássico do type-checker do Swift ("unable to
/// type-check this expression in reasonable time" — que no Swift
/// Playgrounds às vezes só aparece como "Build Failed" sem detalhe nenhum).
/// Cada kit aqui é uma constante com tipo explícito (`: Kit`), o que faz o
/// compilador checar cada um isoladamente e rápido, em vez de tentar inferir
/// o array inteiro de uma vez.


let embeddedKit000: Kit = Kit(
        id: "adviser",
        name: "Adviser",
        wikiPageTitle: "Adviser (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "As an Adviser, Elam is a man of subtlety and mystery. He rarely speaks unless he has something important to say, and he always thinks carefully before he says it. While not a fixture at his lord's court, he keeps an eye on things from a distance, often using animals to observe the ruler. He tends to pop up when most needed or least expected, stay a day or a month, then vanish into the wilds. Always hungry for information, Elam often roams the land disguised as a common traveler (or, at high level, in animal form), listening to the gossip of peasants, traders, and innkeepers to better serve his own interests and those of his lord. As a PC, he carefully considers the purpose and long-term ramifications of each adventure and insists on careful preparation and information gathering before taking action.",
            requirements: nil,
            specialBenefits: "As an Adviser, Elam can purchase the rogue's disguise proficiency at normal rather than double cost. He stays free at the ruler's stronghold (no cost of living), and has the ear of the ruler. The DM should establish an NPC ruler for the druid to advise. Help the DM develop a reason why the ruler trusts the PC, beyond his druidic background. Perhaps Elam is a relative (a cousin and younger son who failed to inherit and so joined the druidic order), or the apprentice of a (recently deceased) older druid who used to tutor the lord. For play balance, the DM should place a 1st-level player character as only one of several counselors to a lord of a small domain—perhaps a knightly manor or a barony. (If you, the player, really want to role-play an Adviser to a king, make it an exiled king trying to regain his crown.) It's up to the PC to increase the lord's influence.",
            specialHindrances: "People of the lord's domain (and immediate neighbors) easily recognize Elam as the court druid. If the lord favors him or if the populace knows him to give good advice, many will ask him to intercede for them with the lord. In addition, he may become a target for his lord's enemies or jealous rival courtiers. On the other hand, if Elam fails to please his master, he will find himself in disfavor at court: He suffers a minimum -2 reaction penalty from the lord and court—possibly from all in the region (if his bad advice led to a spectacular failure, like defeat on the battlefield). Depending on the lord's temper, an Adviser who has fallen into disfavor may face exile or worse until he makes amends.",
            wealthOptions: "3d6x10 gp.",
            weaponProficiencies: "Recommended—staff.",
            nonweaponProficiencies: "* Bonus—etiquette. * Recommended—(general) heraldry, weather sense; (priest) healing, local history, spellcraft; (rogue, double slot) reading lips; (rogue, one slot, per \"Special Benefits\") disguise.",
            equipment: "The Adviser need not spend all starting money on equipment, but can retain any leftover coinage."
        ),
        description: KitDescription(
            briefSummary: "As a druid, your character can act as (or work to become) counselor to a ruler—perhaps a local knight or a high king. Think of Merlin, whom older tales cast as a druid.",
            fullText: "## Adviser\nAs a druid, your character can act as (or work to become) counselor to a ruler—perhaps a local knight or a high king. Think of Merlin, whom older tales cast as a druid.\n\nAn Adviser like the druid Elam (pictured above) tries to make himself indispensable to his lord. The class's well-known neutrality makes a ruler perceive his advice as nonpartisan, while the druid's high Charisma almost guarantees that the lord listens to his counsel. Elam can use his \"eyes in the wilderness\" (described in Chapter 4: Role-playing Druids) to provide his master with timely and vital information.\n\nAt the same time, the druid subtly manipulates his master to serve his own ends. For example, Elam might encourage his lord to hunt in a beautiful forest the druid wishes to protect. Why? Because Elam knows the lord is a jealous man. Once he sees the beautiful forest and its fine animals, the lord will pass a law making the forest a royal game preserve. As a result, the lord's foresters will keep poachers away and prevent peasants from cutting the trees down. The ruler and his courtiers will hunt there only once or twice a year'not enough to threaten the animals seriously.\n\nFor similar reasons, a druidic Adviser like Elam might take over part of the education of the lord's children, ostensibly to teach them herb lore, history, survival, and similar skills. Actually, he uses the opportunity to instill in them a respect for Nature and the neutral world view—and perhaps encourage them to become druids when they grow up.\n\n**Role:** As an Adviser, Elam is a man of subtlety and mystery. He rarely speaks unless he has something important to say, and he always thinks carefully before he says it. While not a fixture at his lord's court, he keeps an eye on things from a distance, often using animals to observe the ruler. He tends to pop up when most needed or least expected, stay a day or a month, then vanish into the wilds.\n\nAlways hungry for information, Elam often roams the land disguised as a common traveler (or, at high level, in animal form), listening to the gossip of peasants, traders, and innkeepers to better serve his own interests and those of his lord. As a PC, he carefully considers the purpose and long-term ramifications of each adventure and insists on careful preparation and information gathering before taking action.\n\n**Branch Restrictions:** None.\n\n**Weapon Proficiencies:** *Recommended*—staff.\n\n**Secondary Skills:** Scribe.\n\n**Nonweapon Proficiencies:**\n* *Bonus*—etiquette.\n* *Recommended*—(general) heraldry, weather sense; (priest) healing, local history, spellcraft; (rogue, double slot) reading lips; (rogue, one slot, per \"Special Benefits\") disguise.\n\n**Equipment:** The Adviser need not spend all starting money on equipment, but can retain any leftover coinage.\n\n**Special Benefits:** As an Adviser, Elam can purchase the rogue's disguise proficiency at normal rather than double cost. He stays free at the ruler's stronghold (no cost of living), and has the ear of the ruler.\n\nThe DM should establish an NPC ruler for the druid to advise. Help the DM develop a reason why the ruler trusts the PC, beyond his druidic background. Perhaps Elam is a relative (a cousin and younger son who failed to inherit and so joined the druidic order), or the apprentice of a (recently deceased) older druid who used to tutor the lord. For play balance, the DM should place a 1st-level player character as only one of several counselors to a lord of a small domain—perhaps a knightly manor or a barony. (If you, the player, really want to role-play an Adviser to a king, make it an exiled king trying to regain his crown.) It's up to the PC to increase the lord's influence.\n\n**Special Hindrances:** People of the lord's domain (and immediate neighbors) easily recognize Elam as the court druid. If the lord favors him or if the populace knows him to give good advice, many will ask him to intercede for them with the lord. In addition, he may become a target for his lord's enemies or jealous rival courtiers.\n\nOn the other hand, if Elam fails to please his master, he will find himself in disfavor at court: He suffers a minimum -2 reaction penalty from the lord and court—possibly from all in the region (if his bad advice led to a spectacular failure, like defeat on the battlefield). Depending on the lord's temper, an Adviser who has fallen into disfavor may face exile or worse until he makes amends.\n\n**Wealth Options:** 3d6x10 gp.",
            rawWikitext: "{{Sidebar CDH Ch2}}__NOTOC__\n==Adviser==\nAs a druid, your character can act as (or work to become) counselor to a ruler—perhaps a local knight or a high king. Think of Merlin, whom older tales cast as a druid.\n\nAn Adviser like the druid Elam (pictured above) tries to make himself indispensable to his lord. The class's well-known neutrality makes a ruler perceive his advice as nonpartisan, while the druid's high Charisma almost guarantees that the lord listens to his counsel. Elam can use his \"eyes in the wilderness\" (described in Chapter 4: Role-playing Druids) to provide his master with timely and vital information.\n\nAt the same time, the druid subtly manipulates his master to serve his own ends. For example, Elam might encourage his lord to hunt in a beautiful forest the druid wishes to protect. Why? Because Elam knows the lord is a jealous man. Once he sees the beautiful forest and its fine animals, the lord will pass a law making the forest a royal game preserve. As a result, the lord's foresters will keep poachers away and prevent peasants from cutting the trees down. The ruler and his courtiers will hunt there only once or twice a year'not enough to threaten the animals seriously.\n\nFor similar reasons, a druidic Adviser like Elam might take over part of the education of the lord's children, ostensibly to teach them herb lore, history, survival, and similar skills. Actually, he uses the opportunity to instill in them a respect for Nature and the neutral world view—and perhaps encourage them to become druids when they grow up.\n\n'''Role:''' As an Adviser, Elam is a man of subtlety and mystery. He rarely speaks unless he has something important to say, and he always thinks carefully before he says it. While not a fixture at his lord's court, he keeps an eye on things from a distance, often using animals to observe the ruler. He tends to pop up when most needed or least expected, stay a day or a month, then vanish into the wilds.\n\nAlways hungry for information, Elam often roams the land disguised as a common traveler (or, at high level, in animal form), listening to the gossip of peasants, traders, and innkeepers to better serve his own interests and those of his lord. As a PC, he carefully considers the purpose and long-term ramifications of each adventure and insists on careful preparation and information gathering before taking action.\n\n'''Branch Restrictions:''' None.\n\n'''Weapon Proficiencies:''' ''Recommended''—staff.\n\n'''Secondary Skills:''' Scribe.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus''—[[Etiquette (Proficiency)|etiquette]].\n* ''Recommended''—(general) [[Heraldry (Proficiency)|heraldry]], [[Weather Sense (Proficiency)|weather sense]]; (priest) [[Healing (Proficiency)|healing]], [[Local History (Proficiency)|local history]], [[Spellcraft (Proficiency)|spellcraft]]; (rogue, double slot) [[Reading Lips (Proficiency)|reading lips]]; (rogue, one slot, per \"Special Benefits\") disguise.\n\n'''Equipment:''' The Adviser need not spend all starting money on equipment, but can retain any leftover coinage.\n\n'''Special Benefits:''' As an Adviser, Elam can purchase the rogue's disguise proficiency at normal rather than double cost. He stays free at the ruler's stronghold (no cost of living), and has the ear of the ruler.\n\nThe DM should establish an NPC ruler for the druid to advise. Help the DM develop a reason why the ruler trusts the PC, beyond his druidic background. Perhaps Elam is a relative (a cousin and younger son who failed to inherit and so joined the druidic order), or the apprentice of a (recently deceased) older druid who used to tutor the lord. For play balance, the DM should place a 1st-level player character as only one of several counselors to a lord of a small domain—perhaps a knightly manor or a barony. (If you, the player, really want to role-play an Adviser to a king, make it an exiled king trying to regain his crown.) It's up to the PC to increase the lord's influence.\n\n'''Special Hindrances:''' People of the lord's domain (and immediate neighbors) easily recognize Elam as the court druid. If the lord favors him or if the populace knows him to give good advice, many will ask him to intercede for them with the lord. In addition, he may become a target for his lord's enemies or jealous rival courtiers.\n\nOn the other hand, if Elam fails to please his master, he will find himself in disfavor at court: He suffers a minimum -2 reaction penalty from the lord and court—possibly from all in the region (if his bad advice led to a spectacular failure, like defeat on the battlefield). Depending on the lord's temper, an Adviser who has fallen into disfavor may face exile or worse until he makes amends.\n\n'''Wealth Options:''' 3d6x10 gp.\n\n{{Navbox The Complete Druid's Handbook}}"
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
                bonus: ["etiquette"],
                recommended: ["heraldry", "weather sense", "healing", "local history", "spellcraft", "(rogue", "double slot) reading lips", "(rogue", "one slot", "per \"Special Benefits\") disguise"],
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

let embeddedKit001: Kit = Kit(
        id: "amazon_priestess",
        name: "Amazon Priestess",
        wikiPageTitle: "Amazon Priestess (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Among the Amazons, the priestess-types listed immediately above are as highly-regarded as the warrior, and the warrior is the most-admired type of Amazon. Outside the Amazon lands, among male-dominated civilizations, the priestess is looked on as an even more unnatural sort of unnatural woman. In cultures where men and women are approximately equal in influence, the Amazon is looked on as a curiosity, and may even (at the DM's discretion) be looked down on as a representative of a race that hasn't yet come to the conclusion that neither gender should oppress the other. Among player-character adventurers, the Amazon-priestess is likely to prove herself to be a doughty fighter and an effective spellcaster. If the priestess character starts out suffering a bit of discrimination when she's introduced into the campaign, that may be normal according to the culture but the DM shouldn't encourage this attitude, especially after she's proven herself in dangerous situations. Even if the campaign's main culture is discriminatory, the PCs should demonstrate a little more flexibility in their attitudes based on their adventuring experiences.",
            requirements: nil,
            specialBenefits: "Male opponents from cultures where women fighters tend to be rare will be amused, rather than cautious, the first time they confront an Amazon. Therefore, in a fight where such a warrior runs up against an Amazon for the first time, the Amazon gets a +3 to hit and +3 damage on her first blow only. This reflects the fact that her opponent's guard is down. This bonus doesn't work on any Warrior character of fifth level or higher, or a character of any other class at 8th level or higher; in spite of any prejudices he might bear, this character is too seasoned an adventurer to let his guard down that way. At the DM's discretion, he can give a wary, suspicious NPC an Intelligence check; on a successful check, he will see the attack coming and deny the Amazon the bonus. The bonus won't work on any male fighter who comes from a culture where women do regularly fight, or who has had fighting-women comrades or faced fighting-women opponents before, or even who has seen the Amazon hit someone else with this bonus earlier. It doesn't work on player-characters unless the player is role-playing honestly enough to admit that his character would underestimate the Amazon. Once the Amazon hits a character with this bonus, the target (if he survives) will never fall for it again. It can only be used successfully once per victim, ever. But if the Amazon misses a target with this blow, she continues to receive it against this target until she hits him once.",
            specialHindrances: "The Amazon receives a -3 reaction roll adjustment from NPCs from male-dominated societies. Player-characters do not have to demonstrate this hostility unless they want to do so for role-playing purposes, and even then it should fade as they come to respect her.",
            wealthOptions: "The Amazon gets the ordinary 3d6x10 gp as starting money.",
            weaponProficiencies: "* Required: None. * Recommended: Spear, long bow; if possible, various axes and swords.",
            nonweaponProficiencies: "* Bonus Proficiencies: Riding (Land-Based), Animal Training. * Recommended: (General) Animal Handling, (Warrior) Animal Lore, Armorer, Bowyer/Fletcher, Hunting, Running, Survival, Tracking.",
            equipment: "When an Amazon character is first created, she must buy her armor from among the following choices only: Shield, leather, padded, studded leather, brigandine, scale mail, hide, banded mail, bronze plate mail. Once she has adventured elsewhere in the world, she may purchase other types of armor according to her priest-class limitations."
        ),
        description: KitDescription(
            briefSummary: "Amazons are women warriors in a world where most cultures are male-dominated or ruled more or less equally by men and women.",
            fullText: "## Amazon Priestess\n**Description:** Amazons are women warriors in a world where most cultures are male-dominated or ruled more or less equally by men and women. The Amazon civilization is different from the cultures of the rest of the world in that women occupy all the most important occupations and positions in their society; men are either second-class citizens, or are all kept as slaves, or are exiled from the culture altogether. Amazons continually have to defend themselves from the efforts of surrounding civilizations to \"return them to normal,\" and therefore they are very good at war.\n\nSuch civilizations often have one or two specific patron gods. (The deity does not have to be female; in classical mythology, for instance, the Amazons' patron was Ares, the very male god of war.)\n\nThe priestesses of this god interpret the god's will for the Amazons, fight alongside them in times of combat, perform the usual service of guidance (and even marriage, if this is still a function of this specific Amazon society); and sometimes travel through the outer world in an effort to learn what they can of the world of men—in order to protect themselves from it, or to educate themselves and the outer-worlders to reduce misunderstandings between the cultures.\n\nThere are no special ability-score requirements to be an Amazon.\n\nTo abandon this kit, the character would have to renounce her Amazon citizenship... meaning that she would have to identify herself more strongly with another culture.\n\n**Barred:** The DM will decide which gods act as patrons for the Amazon civilization; most Amazon priestesses will serve those specific gods. However, not all Amazon priestesses *have* to serve those specific gods. An Amazon culture could have as its patron the gods of War and Moon, for instance, but a specific Amazon priestess could serve another god. (Since each attribute has its own role to play in any civilization, few gods are really inappropriate.) Note, though, that no Amazon priestess can serve the gods of Disease or Peace. Also, since Amazon warriors must know the use of the spear and long bow, an Amazon priestess who cannot use those weapons will be looked down upon, and won't command the respect of priestesses who can. Therefore, an Amazon will command less respect *unless she is a priestess of one of the following gods*: Community, Competition, Elemental Forces, Good, Hunting, Light, Mischief/Trickery, Moon, Oracles/Prophecy, Race (Human), Sky/Weather, Sun, War, Wind, Wisdom.\n\n**Role:** Among the Amazons, the priestess-types listed immediately above are as highly-regarded as the warrior, and the warrior is the most-admired type of Amazon. Outside the Amazon lands, among male-dominated civilizations, the priestess is looked on as an even more unnatural sort of unnatural woman. In cultures where men and women are approximately equal in influence, the Amazon is looked on as a curiosity, and may even (at the DM's discretion) be looked down on as a representative of a race that hasn't yet come to the conclusion that neither gender should oppress the other.\n\nAmong player-character adventurers, the Amazon-priestess is likely to prove herself to be a doughty fighter and an effective spellcaster. If the priestess character starts out suffering a bit of discrimination when she's introduced into the campaign, that may be normal according to the culture but the DM shouldn't encourage this attitude, especially after she's proven herself in dangerous situations. Even if the campaign's main culture is discriminatory, the PCs should demonstrate a little more flexibility in their attitudes based on their adventuring experiences.\n\n**Secondary Skills:**\n* *Required:* Groom.\n\n**Weapon Proficiencies:**\n* *Required:* None.\n* *Recommended:* Spear, long bow; if possible, various axes and swords.\n\n**Nonweapon Proficiencies:**\n* *Bonus Proficiencies:* Riding (Land-Based), Animal Training.\n* *Recommended:* (General) Animal Handling, (Warrior) Animal Lore, Armorer, Bowyer/Fletcher, Hunting, Running, Survival, Tracking.\n\n**Equipment:** When an Amazon character is first created, she must buy her armor from among the following choices only: Shield, leather, padded, studded leather, brigandine, scale mail, hide, banded mail, bronze plate mail. Once she has adventured elsewhere in the world, she may purchase other types of armor according to her priest-class limitations.\n\n**Special Benefits:** Male opponents from cultures where women fighters tend to be rare will be amused, rather than cautious, the first time they confront an Amazon. Therefore, in a fight where such a warrior runs up against an Amazon for the first time, the Amazon gets a +3 to hit and +3 damage on her *first blow only.* This reflects the fact that her opponent's guard is down.    \n\nThis bonus doesn't work on any Warrior character of fifth level or higher, or a character of any other class at 8th level or higher; in spite of any prejudices he might bear, this character is too seasoned an adventurer to let his guard down that way.\n\nAt the DM's discretion, he can give a wary, suspicious NPC an Intelligence check; on a successful check, he will see the attack coming and deny the Amazon the bonus. \n\nThe bonus won't work on any male fighter who comes from a culture where women do regularly fight, or who has had fighting-women comrades or faced fighting-women opponents before, or even who has seen the Amazon hit someone else with this bonus earlier.\n\nIt doesn't work on player-characters unless the player is role-playing honestly enough to admit that his character would underestimate the Amazon.\n\nOnce the Amazon hits a character with this bonus, the target (if he survives) will never fall for it again. It can only be used successfully once per victim, ever. But if the Amazon misses a target with this blow, she continues to receive it against this target until she hits him once.\n\n**Special Hindrances:** The Amazon receives a -3 reaction roll adjustment from NPCs from male-dominated societies. Player-characters do not have to demonstrate this hostility unless they want to do so for role-playing purposes, and even then it should fade as they come to respect her.\n\n**Wealth Options:** The Amazon gets the ordinary 3d6x10 gp as starting money.\n\n**Races:** None are excluded. Humans, elvish, and half-elvish Amazons are most appropriate. Dwarves would substitute battle axe and warhammer for their weapons and swine for their preferred mounts. Gnomes would substitute throwing axe and short sword, and would ride ponies, and would have Tracking and Survival as their Bonus Nonweapon Proficiencies. Halflings would substitute javelin and sling for their weapons, and Endurance and Set Snares for their Bonus Nonweapon Proficiencies.",
            rawWikitext: "{{Sidebar CPrH Ch4}}__NOTOC__\n==Amazon Priestess==\n'''Description:''' Amazons are women warriors in a world where most cultures are male-dominated or ruled more or less equally by men and women. The Amazon civilization is different from the cultures of the rest of the world in that women occupy all the most important occupations and positions in their society; men are either second-class citizens, or are all kept as slaves, or are exiled from the culture altogether. Amazons continually have to defend themselves from the efforts of surrounding civilizations to \"return them to normal,\" and therefore they are very good at war.\n\nSuch civilizations often have one or two specific patron gods. (The deity does not have to be female; in classical mythology, for instance, the Amazons' patron was Ares, the very male god of war.)\n\nThe priestesses of this god interpret the god's will for the Amazons, fight alongside them in times of combat, perform the usual service of guidance (and even marriage, if this is still a function of this specific Amazon society); and sometimes travel through the outer world in an effort to learn what they can of the world of men—in order to protect themselves from it, or to educate themselves and the outer-worlders to reduce misunderstandings between the cultures.\n\nThere are no special ability-score requirements to be an Amazon.\n\nTo abandon this kit, the character would have to renounce her Amazon citizenship... meaning that she would have to identify herself more strongly with another culture.\n\n'''Barred:''' The DM will decide which gods act as patrons for the Amazon civilization; most Amazon priestesses will serve those specific gods. However, not all Amazon priestesses ''have'' to serve those specific gods. An Amazon culture could have as its patron the gods of War and Moon, for instance, but a specific Amazon priestess could serve another god. (Since each attribute has its own role to play in any civilization, few gods are really inappropriate.) Note, though, that no Amazon priestess can serve the gods of Disease or Peace. Also, since Amazon warriors must know the use of the spear and long bow, an Amazon priestess who cannot use those weapons will be looked down upon, and won't command the respect of priestesses who can. Therefore, an Amazon will command less respect ''unless she is a priestess of one of the following gods'': Community, Competition, Elemental Forces, Good, Hunting, Light, Mischief/Trickery, Moon, Oracles/Prophecy, Race (Human), Sky/Weather, Sun, War, Wind, Wisdom.\n\n'''Role:''' Among the Amazons, the priestess-types listed immediately above are as highly-regarded as the warrior, and the warrior is the most-admired type of Amazon. Outside the Amazon lands, among male-dominated civilizations, the priestess is looked on as an even more unnatural sort of unnatural woman. In cultures where men and women are approximately equal in influence, the Amazon is looked on as a curiosity, and may even (at the DM's discretion) be looked down on as a representative of a race that hasn't yet come to the conclusion that neither gender should oppress the other.\n\nAmong player-character adventurers, the Amazon-priestess is likely to prove herself to be a doughty fighter and an effective spellcaster. If the priestess character starts out suffering a bit of discrimination when she's introduced into the campaign, that may be normal according to the culture but the DM shouldn't encourage this attitude, especially after she's proven herself in dangerous situations. Even if the campaign's main culture is discriminatory, the PCs should demonstrate a little more flexibility in their attitudes based on their adventuring experiences.\n\n'''Secondary Skills:'''\n* ''Required:'' Groom.\n\n'''Weapon Proficiencies:'''\n* ''Required:'' None.\n* ''Recommended:'' Spear, long bow; if possible, various axes and swords.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus Proficiencies:'' Riding (Land-Based), Animal Training.\n* ''Recommended:'' (General) Animal Handling, (Warrior) Animal Lore, Armorer, Bowyer/Fletcher, Hunting, Running, Survival, Tracking.\n\n'''Equipment:''' When an Amazon character is first created, she must buy her armor from among the following choices only: Shield, leather, padded, studded leather, brigandine, scale mail, hide, banded mail, bronze plate mail. Once she has adventured elsewhere in the world, she may purchase other types of armor according to her priest-class limitations.\n\n'''Special Benefits:''' Male opponents from cultures where women fighters tend to be rare will be amused, rather than cautious, the first time they confront an Amazon. Therefore, in a fight where such a warrior runs up against an Amazon for the first time, the Amazon gets a +3 to hit and +3 damage on her ''first blow only.'' This reflects the fact that her opponent's guard is down.    \n\nThis bonus doesn't work on any Warrior character of fifth level or higher, or a character of any other class at 8th level or higher; in spite of any prejudices he might bear, this character is too seasoned an adventurer to let his guard down that way.\n\nAt the DM's discretion, he can give a wary, suspicious NPC an Intelligence check; on a successful check, he will see the attack coming and deny the Amazon the bonus. \n\nThe bonus won't work on any male fighter who comes from a culture where women do regularly fight, or who has had fighting-women comrades or faced fighting-women opponents before, or even who has seen the Amazon hit someone else with this bonus earlier.\n\nIt doesn't work on player-characters unless the player is role-playing honestly enough to admit that his character would underestimate the Amazon.\n\nOnce the Amazon hits a character with this bonus, the target (if he survives) will never fall for it again. It can only be used successfully once per victim, ever. But if the Amazon misses a target with this blow, she continues to receive it against this target until she hits him once.\n\n'''Special Hindrances:''' The Amazon receives a -3 reaction roll adjustment from NPCs from male-dominated societies. Player-characters do not have to demonstrate this hostility unless they want to do so for role-playing purposes, and even then it should fade as they come to respect her.\n\n'''Wealth Options:''' The Amazon gets the ordinary 3d6x10 gp as starting money.\n\n'''Races:''' None are excluded. Humans, elvish, and half-elvish Amazons are most appropriate. Dwarves would substitute battle axe and warhammer for their weapons and swine for their preferred mounts. Gnomes would substitute throwing axe and short sword, and would ride ponies, and would have Tracking and Survival as their Bonus Nonweapon Proficiencies. Halflings would substitute javelin and sling for their weapons, and Endurance and Set Snares for their Bonus Nonweapon Proficiencies.\n\n{{Navbox The Complete Priest's Handbook}}\n[[Category:Character Kit]]\n[[Category:Character Kit CPrH]]"
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
                recommended: ["Spear", "long bow", "various axes and swords"],
                forbidden: [],
                notes: "if possible"
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Riding", "Animal Training"],
                recommended: ["Animal Handling", "Animal Lore", "Armorer", "Bowyer/Fletcher", "Hunting", "Running", "Survival", "Tracking"],
                notes: nil
            ),
            armor: KitArmorRules(
                allowedTypes: .specific(["shield", "leather", "padded", "studded leather", "brigandine", "scale mail", "hide", "banded mail", "plate mail"]),
                shieldsAllowed: .specific(["shield"]),
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "When an Amazon character is first created, she must buy her armor from among the following choices only: Shield, leather, padded, studded leather, brigandine, scale mail, hide, banded mail, bronze plate mail. Once she has adventured elsewhere in the world, she may purchase other types of armor according to her priest-class limitations."
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

let embeddedKit002: Kit = Kit(
        id: "auril_chillbringer",
        name: "Auril - Chillbringer",
        wikiPageTitle: "Auril - Chillbringer (Character Kit)",
        redirectAliases: ["Priests of Auril (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Auril, the Frostmaiden, is the goddess of winter and cold. Her devoted sect of priests, the chillbringers, engage in activities ranging from guiding parties through frozen arctic wastes to summoning winter storms for the glory of Auril. Whatever their task, most \"right-thinking\" folk consider the chillbringers to be rather frightening individuals.",
            requirements: "Wisdom 9",
            specialBenefits: "The ice wrist manacles are magical, and bestow AC 7 protection as well as the abilities of a ring of warmth. The ice daggers are enchanted, and function as daggers +1. Furthermore, if a natural 20 is rolled, the ice dagger does an additional 5 points of cold damage. Once a week per level, a chillbringer can summon a snowstorm, provided the temperature is already below 30 degrees. This storm will last for 1d12 hours, dumping 1d4 inches of snow per experience level. Winds will be at gale force, and the temperature will drop below 20 degrees Fahrenheit or lower. No animal can fly, no missile weapon can be used, movement rates are reduced by half, and all combat is penalized at -4 to attack rolls within the 5-mile radius of the storm. Only priests of Auril are immune to the combat penalty from the snowstorm.",
            specialHindrances: "Chillbringers cannot turn undead. Furthermore, since their faith is one situated in the North, no one born south of Neverwinter can be a chillbringer. Even worse, chillbringers lose all of their spells and powers if they ever venture into those forbidden areas to the south of Neverwinter. Even their magical ice items will melt and vanish before the appointed date, if taken into those lands. Chillbringers are forbidden from using any clerical spells or magical items that create fire or heat.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Survival (arctic)",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Auril, the Frostmaiden, is the goddess of winter and cold. Her devoted sect of priests, the chillbringers, engage in activities ranging from guiding parties through frozen arctic wastes to summoning winter storms for the glory of Auril.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Survival (arctic)\n|-\n| **Recommended Proficiencies** || Weather Sense\n|}\n## Overview\nAuril, the Frostmaiden, is the goddess of winter and cold. Her devoted sect of priests, the chillbringers, engage in activities ranging from guiding parties through frozen arctic wastes to summoning winter storms for the glory of Auril.\n\nWhatever their task, most \"right-thinking\" folk consider the chillbringers to be rather frightening individuals.\n\n## Description\nChillbringers wear long white robes with blue trim. They wear a belt and wrist bracers made of real ice, which miraculously do not melt until the dawn of Greengrass. During the Feast of the Moon, which marks the arrival of winter, new manacles and belts are created. The belt and bracers are made from ice harvested from the Great Glacier, and carved by the highest-ranked clergy of Auril.\n\nChillbringers do not wear armor. During winter, they use enchanted daggers made of ice as their primary weapons. Otherwise, the priests use a hand axe, another one of the symbols of their faith.\n\n## Role-Playing\nChillbringers are like snow itself. Snow can either be a hindrance to growing crops and traveling, or it can be a pleasant thing for romping in. Chillbringers can either call down snow and ice on the unwilling, or serve as expert guides through the cold, giving invaluable advice on how to survive.\n\nMost chillbringers are reclusive. When they do associate with others, it is usually with fellow worshipers of Auril, especially crusaders and clergy.\n\nLike ice itself, most chillbringers are cold and emotionless, an aloof priesthood that only gets involved when there are storms to be called up, or money to be made by lending their services as guides.\n\n## Special Abilities\nThe ice wrist manacles are magical, and bestow AC 7 protection as well as the abilities of a ring of warmth. The ice daggers are enchanted, and function as daggers +1. Furthermore, if a natural 20 is rolled, the ice dagger does an additional 5 points of cold damage.\n\nOnce a week per level, a chillbringer can summon a snowstorm, provided the temperature is already below 30 degrees. This storm will last for 1d12 hours, dumping 1d4 inches of snow per experience level. Winds will be at gale force, and the temperature will drop below 20 degrees Fahrenheit or lower. No animal can fly, no missile weapon can be used, movement rates are reduced by half, and all combat is penalized at -4 to attack rolls within the 5-mile radius of the storm. Only priests of Auril are immune to the combat penalty from the snowstorm.\n\n## Special Disadvantages\nChillbringers cannot turn undead. Furthermore, since their faith is one situated in the North, no one born south of Neverwinter can be a chillbringer. Even worse, chillbringers lose all of their spells and powers if they ever venture into those forbidden areas to the south of Neverwinter. Even their magical ice items will melt and vanish before the appointed date, if taken into those lands.\n\nChillbringers are forbidden from using any clerical spells or magical items that create fire or heat.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Survival (Proficiency)|Survival]] (arctic)\n|-\n| '''Recommended Proficiencies''' || [[Weather Sense (Proficiency)|Weather Sense]]\n|}__TOC__\n==Overview==\nAuril, the Frostmaiden, is the goddess of winter and cold. Her devoted sect of priests, the chillbringers, engage in activities ranging from guiding parties through frozen arctic wastes to summoning winter storms for the glory of Auril.\n\nWhatever their task, most \"right-thinking\" folk consider the chillbringers to be rather frightening individuals.\n\n==Description==\nChillbringers wear long white robes with blue trim. They wear a belt and wrist bracers made of real ice, which miraculously do not melt until the dawn of Greengrass. During the Feast of the Moon, which marks the arrival of winter, new manacles and belts are created. The belt and bracers are made from ice harvested from the Great Glacier, and carved by the highest-ranked clergy of Auril.\n\nChillbringers do not wear armor. During winter, they use enchanted daggers made of ice as their primary weapons. Otherwise, the priests use a hand axe, another one of the symbols of their faith.\n\n==Role-Playing==\nChillbringers are like snow itself. Snow can either be a hindrance to growing crops and traveling, or it can be a pleasant thing for romping in. Chillbringers can either call down snow and ice on the unwilling, or serve as expert guides through the cold, giving invaluable advice on how to survive.\n\nMost chillbringers are reclusive. When they do associate with others, it is usually with fellow worshipers of Auril, especially crusaders and clergy.\n\nLike ice itself, most chillbringers are cold and emotionless, an aloof priesthood that only gets involved when there are storms to be called up, or money to be made by lending their services as guides.\n\n==Special Abilities==\nThe ice wrist manacles are magical, and bestow AC 7 protection as well as the abilities of a ring of warmth. The ice daggers are enchanted, and function as daggers +1. Furthermore, if a natural 20 is rolled, the ice dagger does an additional 5 points of cold damage.\n\nOnce a week per level, a chillbringer can summon a snowstorm, provided the temperature is already below 30 degrees. This storm will last for 1d12 hours, dumping 1d4 inches of snow per experience level. Winds will be at gale force, and the temperature will drop below 20 degrees Fahrenheit or lower. No animal can fly, no missile weapon can be used, movement rates are reduced by half, and all combat is penalized at -4 to attack rolls within the 5-mile radius of the storm. Only priests of Auril are immune to the combat penalty from the snowstorm.\n\n==Special Disadvantages==\nChillbringers cannot turn undead. Furthermore, since their faith is one situated in the North, no one born south of Neverwinter can be a chillbringer. Even worse, chillbringers lose all of their spells and powers if they ever venture into those forbidden areas to the south of Neverwinter. Even their magical ice items will melt and vanish before the appointed date, if taken into those lands.\n\nChillbringers are forbidden from using any clerical spells or magical items that create fire or heat.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Survival"],
                recommended: ["Weather Sense"],
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
                notes: "Chillbringers cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Auril",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Chillbringer"
    )

let embeddedKit003: Kit = Kit(
        id: "avenger",
        name: "Avenger",
        wikiPageTitle: "Avenger (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "This druid is a grim, strong, and silent warrior of the wilds. Torrens has little time for anything but his mission, although he's as patient as a spider when it serves his plans. A loner, he avoids love or friendship, fearing either could compromise his mission; if he associates with a party of adventurers, he treats them as allies, but not as friends. The Avenger rarely speaks more than absolutely necessary to humans and most demihumans (although he may talk to animals or sylvan races like wood elves). He doesn't bother to explain or justify his actions. The Avenger dislikes remaining in one place, and frequently moves on after finishing a particular job.",
            requirements: nil,
            specialBenefits: "The Avenger receives an additional free weapon proficiency slot to use for any proficiency his branch allows.",
            specialHindrances: "The druid's grim and silent demeanor gives the character a -1 penalty to reaction adjustment from people in encounters. Torrens, like all Avengers, cannot have henchmen, hirelings, mercenaries, or servants until he reaches 13th level. He can have any amount of treasure, but cannot own more treasure and equipment than he can carry on his back—any excess must go to a worthy cause.",
            wealthOptions: "3d6x10 gp.",
            weaponProficiencies: "Recommended—scimitar, spear.",
            nonweaponProficiencies: "* Bonus—tracking. * Recommended—(general) animal training; (priest) herbalism; (warrior) animal lore, endurance, set snares, survival.",
            equipment: "The druid should spend his initial allotment of gold pieces entirely on equipment, for he loses any unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "The Avenger druid has seen Nature suffer great wrongs. Take the case of the druid Torrens. (See illustration.) He had hoped to live as a Guardian or Village Druid (listed later in this chapter). However, during his training, forces defiled the area under his protection and slew his mentor.",
            fullText: "## Avenger\nThe Avenger druid has seen Nature suffer great wrongs. Take the case of the druid Torrens. (See illustration.) He had hoped to live as a Guardian or Village Druid (listed later in this chapter). However, during his training, forces defiled the area under his protection and slew his mentor. Maybe he feels he was too gentle, too weak. It doesn't matter. He won't let it happen again.\n\nTorrens the Avenger no longer holds the defensive. Instead, he roams the world seeking wrongs to right and foes to fight. And whether his opponent is a brutal king cutting down an ancient forest to build a fleet of war galleys, or an evil vampire menacing a peaceful halfling village, the Avenger acts to stop him. Permanently.\n\n**Role:** This druid is a grim, strong, and silent warrior of the wilds. Torrens has little time for anything but his mission, although he's as patient as a spider when it serves his plans. A loner, he avoids love or friendship, fearing either could compromise his mission; if he associates with a party of adventurers, he treats them as allies, but not as friends.\n\nThe Avenger rarely speaks more than absolutely necessary to humans and most demihumans (although he may talk to animals or sylvan races like wood elves). He doesn't bother to explain or justify his actions. The Avenger dislikes remaining in one place, and frequently moves on after finishing a particular job.\n\n**Branch Restrictions:** None.\n\n**Weapon Proficiencies:** *Recommended*—scimitar, spear.\n\n**Secondary Skills:** Hunting, weaponsmith.\n\n**Nonweapon Proficiencies:**\n* *Bonus*—tracking.\n* *Recommended*—(general) animal training; (priest) herbalism; (warrior) animal lore, endurance, set snares, survival.\n\n**Equipment:** The druid should spend his initial allotment of gold pieces entirely on equipment, for he loses any unspent starting money in excess of 1 gp.\n\n**Special Benefits:** The Avenger receives an additional *free* weapon proficiency slot to use for any proficiency his branch allows.\n\n**Special Hindrances:** The druid's grim and silent demeanor gives the character a -1 penalty to reaction adjustment from people in encounters. Torrens, like all Avengers, cannot have henchmen, hirelings, mercenaries, or servants until he reaches 13th level. He can have any amount of treasure, but cannot own more treasure and equipment than he can carry on his back—any excess must go to a worthy cause.\n\n**Wealth Options:** 3d6x10 gp.",
            rawWikitext: "{{Sidebar CDH Ch2}}__NOTOC__\n==Avenger==\nThe Avenger druid has seen Nature suffer great wrongs. Take the case of the druid Torrens. (See illustration.) He had hoped to live as a Guardian or Village Druid (listed later in this chapter). However, during his training, forces defiled the area under his protection and slew his mentor. Maybe he feels he was too gentle, too weak. It doesn't matter. He won't let it happen again.\n\nTorrens the Avenger no longer holds the defensive. Instead, he roams the world seeking wrongs to right and foes to fight. And whether his opponent is a brutal king cutting down an ancient forest to build a fleet of war galleys, or an evil vampire menacing a peaceful halfling village, the Avenger acts to stop him. Permanently.\n\n'''Role:''' This druid is a grim, strong, and silent warrior of the wilds. Torrens has little time for anything but his mission, although he's as patient as a spider when it serves his plans. A loner, he avoids love or friendship, fearing either could compromise his mission; if he associates with a party of adventurers, he treats them as allies, but not as friends.\n\nThe Avenger rarely speaks more than absolutely necessary to humans and most demihumans (although he may talk to animals or sylvan races like wood elves). He doesn't bother to explain or justify his actions. The Avenger dislikes remaining in one place, and frequently moves on after finishing a particular job.\n\n'''Branch Restrictions:''' None.\n\n'''Weapon Proficiencies:''' ''Recommended''—scimitar, spear.\n\n'''Secondary Skills:''' Hunting, weaponsmith.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus''—[[Tracking (Proficiency)|tracking]].\n* ''Recommended''—(general) [[Animal Training (Proficiency)|animal training]]; (priest) [[Herbalism (Proficiency)|herbalism]]; (warrior) [[Animal Lore (Proficiency)|animal lore]], [[Endurance (Proficiency)|endurance]], [[Set Snares (Proficiency)|set snares]], [[Survival (Proficiency)|survival]].\n\n'''Equipment:''' The druid should spend his initial allotment of gold pieces entirely on equipment, for he loses any unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' The Avenger receives an additional ''free'' weapon proficiency slot to use for any proficiency his branch allows.\n\n'''Special Hindrances:''' The druid's grim and silent demeanor gives the character a -1 penalty to reaction adjustment from people in encounters. Torrens, like all Avengers, cannot have henchmen, hirelings, mercenaries, or servants until he reaches 13th level. He can have any amount of treasure, but cannot own more treasure and equipment than he can carry on his back—any excess must go to a worthy cause.\n\n'''Wealth Options:''' 3d6x10 gp.\n\n{{Navbox The Complete Druid's Handbook}}"
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
                recommended: ["scimitar", "spear"],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["tracking"],
                recommended: ["animal training", "herbalism", "animal lore", "endurance", "set snares", "survival"],
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

let embeddedKit004: Kit = Kit(
        id: "azuth_golemmaster",
        name: "Azuth - Golemmaster",
        wikiPageTitle: "Azuth - Golemmaster (Character Kit)",
        redirectAliases: ["Priests of Azuth (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The golemmasters are an elite branch of Azuth's church, and golems are their lives' work. These priests build and maintain golems, and they also have a sworn duty to de- stroy rogue golems.",
            requirements: "Intelligence 16, Wisdom 16",
            specialBenefits: "At 12th level and above, a golemmaster can build any type of golem in half the required time for half the price. If he has a manual of golems of the right type, the time and price are quartered for the priest to construct a golem. Golemmasters have a special attack that allows them to attack any golems despite their normal weapon immuni- ties. Any weapon wielded by a golemmaster against a golem is considered a +4 magical weapon in terms of at- tack and damage rolls, since they know how to build them and take them apart. In the hands of a golemmaster, a rod of smiting will totally destroy a golem on a result of 17+.",
            specialHindrances: "A berserk golem always attacks a golemmaster over any other target, with a +2 to its attack roll and its number of attacks per round is doubled.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Artistic ability (sculpting), Stonemasonry",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "The golemmasters are an elite branch of Azuth's church, and golems are their lives' work. These priests build and maintain golems, and they also have a sworn duty to de- stroy rogue golems.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any except halfling\n|-\n| **Ability Requirements** || Intelligence 16,Wisdom 16\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Artistic ability (sculpting), Stonemasonry\n|-\n| **Recommended Proficiencies** || Spellcraft\n|}\n## Overview\nThe golemmasters are an elite branch of Azuth's church, and golems are their lives' work. These priests build and maintain golems, and they also have a sworn duty to de- stroy rogue golems.\n\n## Description\nGolemmasters are intense-looking individuals, usually covered in stone dust, iron filings, blotches of clay, and other materials used to make golems. They wear gray leather aprons and very common clothes.\n\nGolemmasters only wear leather or studded leather armor when they are expecting battle or danger. In those situations, they also favor hammers and staves as weapons.\n\n## Role-Playing\nMany say that golemmasters are touched by a particular madness attributed to Azuth himself. Golemmasters see each golem's fabrication as an active prayer to Azuth, and they are perfectionists when fabricating golems.\n\n## Special Abilities\nAt 12th level and above, a golemmaster can build any type of golem in half the required time for half the price. If he has a manual of golems of the right type, the time and price are quartered for the priest to construct a golem.\n\nGolemmasters have a special attack that allows them to attack any golems despite their normal weapon immuni- ties. Any weapon wielded by a golemmaster against a golem is considered a +4 magical weapon in terms of at- tack and damage rolls, since they know how to build them and take them apart. In the hands of a golemmaster, a rod of smiting will totally destroy a golem on a result of 17+.\n\n## Special Disadvantages\nA berserk golem always attacks a golemmaster over any other target, with a +2 to its attack roll and its number of attacks per round is doubled.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any except halfling\n|-\n| '''Ability Requirements''' || [[Intelligence]] 16,{{br}}[[Wisdom]] 16\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Artistic Ability (Proficiency)|Artistic ability]] (sculpting), Stonemasonry\n|-\n| '''Recommended Proficiencies''' || [[Spellcraft (Proficiency)|Spellcraft]]\n|}__TOC__\n==Overview==\nThe golemmasters are an elite branch of Azuth's church, and golems are their lives' work. These priests build and maintain golems, and they also have a sworn duty to de- stroy rogue golems.\n\n==Description==\nGolemmasters are intense-looking individuals, usually covered in stone dust, iron filings, blotches of clay, and other materials used to make golems. They wear gray leather aprons and very common clothes.\n\nGolemmasters only wear leather or studded leather armor when they are expecting battle or danger. In those situations, they also favor hammers and staves as weapons.\n\n==Role-Playing==\nMany say that golemmasters are touched by a particular madness attributed to Azuth himself. Golemmasters see each golem's fabrication as an active prayer to Azuth, and they are perfectionists when fabricating golems.\n\n==Special Abilities==\nAt 12th level and above, a golemmaster can build any type of golem in half the required time for half the price. If he has a manual of golems of the right type, the time and price are quartered for the priest to construct a golem.\n\nGolemmasters have a special attack that allows them to attack any golems despite their normal weapon immuni- ties. Any weapon wielded by a golemmaster against a golem is considered a +4 magical weapon in terms of at- tack and damage rolls, since they know how to build them and take them apart. In the hands of a golemmaster, a rod of smiting will totally destroy a golem on a result of 17+.\n\n==Special Disadvantages==\nA berserk golem always attacks a golemmaster over any other target, with a +2 to its attack roll and its number of attacks per round is doubled.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 16, "Wisdom": 16],
                alignments: [],
                races: "Any except halfling"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Artistic ability", "Stonemasonry"],
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
                capable: true,
                mode: "allowed",
                notes: "Standard turning according to priest class level."
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Azuth",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Golemmaster"
    )

let embeddedKit005: Kit = Kit(
        id: "azuth_magefriend",
        name: "Azuth - Magefriend",
        wikiPageTitle: "Azuth - Magefriend (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Azuth is the patron god of wizards and mages and all spellcasters to some extent. Magefriends are priests who advise and counsel wizards, much in the same way that Azuth advises and counsels Mystra. Most magefriends are wanderers, as opposed to those who stay cloistered in Azuth's temples. They are a common sight in adventuring parties.",
            requirements: "Intelligence 16, Wisdom 9",
            specialBenefits: "In addition to their normal clerical spells, all Magefriends can acquire and cast wizard spells like wizards of half their level. Magefriends can be specialist wizards, but they must still meet all the qualifications that the particular school has. Wizard spells are gained not through studying spellbooks, but through meditation and prayer, the same way that they gain priest spells.",
            specialHindrances: "Magefriends cannot wear armor, and are limited to the staff, darts, club, and dagger as their weapons. Gnome magefriends must be specialist wizards, choosing the Illusion school of magic. Despite their ability to cast wizard spells, magefriends cannot use magic items that are meant exclusively for wizards, with the exception of wizard spells on scrolls. All magefriends must be lawful neutral. Violation of this alignment results in all mage and priest spells being withheld until atonement is cast on the offender. Magefriends cannot turn undead, nor can they cast priest spells from the Animal, Plant, or Weather spheres. Magefriends also cannot be multi-classed characters, since they already are in some ways.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Alchemy, spellcraft",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Azuth is the patron god of wizards and mages and all spellcasters to some extent. Magefriends are priests who advise and counsel wizards, much in the same way that Azuth advises and counsels Mystra.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any except dwarves and halflings\n|-\n| **Ability Requirements** || Intelligence 16,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || 3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest, Wizard\n|-\n| **Bonus Proficiencies** || Alchemy, spellcraft\n|-\n| **Recommended Proficiencies** || Herbalism, religion\n|}\n## Overview\nAzuth is the patron god of wizards and mages and all spellcasters to some extent. Magefriends are priests who advise and counsel wizards, much in the same way that Azuth advises and counsels Mystra.\n\nMost magefriends are wanderers, as opposed to those who stay cloistered in Azuth's temples. They are a common sight in adventuring parties.\n\n## Description\nA magefriend could in fact pass for a mage himself. Their vestments are long robes of shimmering gray topped by a light blue cloak and hood. The holy symbol of Azuth is also often worn openly. Most magefriends favor a simple staff as their weapon. Like the wizards they advise, magefriends shun armor.\n\n## Role-Playing\nMagefriends combine the best of both the ecclesiastical and magical worlds. They have the wisdom, insight, and spells of the cleric, plus the experience of wizardly spellcasting.\n\nAs befitting a god of law and neutrality, the magefriends are a serious, orderly sect, easily able to lapse into metaphysical discourse at the drop of a hat. Magical power must be wielded, they argue, with logic and rationality as the guiding forces.\n\nThey take their roles as wandering advisors to wizards very seriously. To them, it is a high honor to counsel the wielders of magical energy. Magefriends also spend time coming to the aid of wizards, magical sites, and shrines to Azuth and Mystra both. For a sect of intellectuals, their spell-combat prowess is formidable, and they have no reservations about going into battle.\n\nMystra and Azuth are friends. Consequently, the clerics of both gods freely help those of the other.\n\n## Special Abilities\nIn addition to their normal clerical spells, all Magefriends can acquire and cast wizard spells like wizards of half their level. Magefriends can be specialist wizards, but they must still meet all the qualifications that the particular school has. Wizard spells are gained not through studying spellbooks, but through meditation and prayer, the same way that they gain priest spells.\n\n## Special Disadvantages\nMagefriends cannot wear armor, and are limited to the staff, darts, club, and dagger as their weapons. Gnome magefriends must be specialist wizards, choosing the Illusion school of magic.\n\nDespite their ability to cast wizard spells, magefriends cannot use magic items that are meant exclusively for wizards, with the exception of wizard spells on scrolls.\n\nAll magefriends must be lawful neutral. Violation of this alignment results in all mage and priest spells being withheld until atonement is cast on the offender.\n\nMagefriends cannot turn undead, nor can they cast priest spells from the Animal, Plant, or Weather spheres. Magefriends also cannot be multi-classed characters, since they already are in some ways.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any except dwarves and halflings\n|-\n| '''Ability Requirements''' || [[Intelligence]] 16,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || 3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest, Wizard\n|-\n| '''Bonus Proficiencies''' || [[Alchemy (Proficiency)|Alchemy]], [[Spellcraft (Proficiency)|spellcraft]]\n|-\n| '''Recommended Proficiencies''' || [[Herbalism (Proficiency)|Herbalism]], [[Religion (Proficiency)|religion]]\n|}__TOC__\n==Overview==\nAzuth is the patron god of wizards and mages and all spellcasters to some extent. Magefriends are priests who advise and counsel wizards, much in the same way that Azuth advises and counsels Mystra.\n\nMost magefriends are wanderers, as opposed to those who stay cloistered in Azuth's temples. They are a common sight in adventuring parties.\n\n==Description==\nA magefriend could in fact pass for a mage himself. Their vestments are long robes of shimmering gray topped by a light blue cloak and hood. The holy symbol of Azuth is also often worn openly. Most magefriends favor a simple staff as their weapon. Like the wizards they advise, magefriends shun armor.\n\n==Role-Playing==\nMagefriends combine the best of both the ecclesiastical and magical worlds. They have the wisdom, insight, and spells of the cleric, plus the experience of wizardly spellcasting.\n\nAs befitting a god of law and neutrality, the magefriends are a serious, orderly sect, easily able to lapse into metaphysical discourse at the drop of a hat. Magical power must be wielded, they argue, with logic and rationality as the guiding forces.\n\nThey take their roles as wandering advisors to wizards very seriously. To them, it is a high honor to counsel the wielders of magical energy. Magefriends also spend time coming to the aid of wizards, magical sites, and shrines to Azuth and Mystra both. For a sect of intellectuals, their spell-combat prowess is formidable, and they have no reservations about going into battle.\n\nMystra and Azuth are friends. Consequently, the clerics of both gods freely help those of the other.\n\n==Special Abilities==\nIn addition to their normal clerical spells, all Magefriends can acquire and cast wizard spells like wizards of half their level. Magefriends can be specialist wizards, but they must still meet all the qualifications that the particular school has. Wizard spells are gained not through studying spellbooks, but through meditation and prayer, the same way that they gain priest spells.\n\n==Special Disadvantages==\nMagefriends cannot wear armor, and are limited to the staff, darts, club, and dagger as their weapons. Gnome magefriends must be specialist wizards, choosing the Illusion school of magic.\n\nDespite their ability to cast wizard spells, magefriends cannot use magic items that are meant exclusively for wizards, with the exception of wizard spells on scrolls.\n\nAll magefriends must be lawful neutral. Violation of this alignment results in all mage and priest spells being withheld until atonement is cast on the offender.\n\nMagefriends cannot turn undead, nor can they cast priest spells from the Animal, Plant, or Weather spheres. Magefriends also cannot be multi-classed characters, since they already are in some ways.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 16, "Wisdom": 9],
                alignments: [],
                races: "Any except dwarves and halflings"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Alchemy", "spellcraft"],
                recommended: ["Herbalism", "religion"],
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
                notes: "Magefriends cannot turn undead, nor can they cast priest spells from the Animal, Plant, or Weather spheres"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Azuth",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Magefriend"
    )

let embeddedKit006: Kit = Kit(
        id: "barbarian_berserker_priest",
        name: "Barbarian/Berserker Priest",
        wikiPageTitle: "Barbarian/Berserker Priest (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "In the campaign, the barbarian priest is a spooky, dangerous figure. Like barbarian warriors, he'll be grim and a little alien to his allies from civilized lands. First and foremost, he's a defender of his people, and he'll most often be found wandering in lands other than his own because of some quest set him by the gods or some mystery he's encountered that requires him to travel in order to solve it. When he finds his own tribesmen captured or enslaved in the outer world, which might be a common occurrence, he must do his utmost to free them and return them to his own land, which can imperil other goals he and his player-character allies have... but as a leader and protector of his culture, this is a duty he cannot refuse. (If he were to do so, the god would take it as a betrayal of goals; see the Role-Playing chapter.)",
            requirements: nil,
            specialBenefits: "Barbarians are imposing and dangerous-looking. This tends to make others respect them or at least wish not to make enemies of them. Therefore, barbarian/berserker priests receive a +1 reaction adjustment bonus when encountering NPCs. This becomes a +3 among members of his own culture. If the priest's culture has many Berserker warriors, as per ''The Complete Fighter's Handbook, the priest has an additional special ability. Berserkers normally take ten rounds to go berserk; in the presence of one of their own priests, then can do it in five. Additionally, if the priest, as part of his priestly class, has the incite berserker rage granted power, then berserkers of his culture in his presence can go berserk in one round''. The priest is not required to use his power for this to take place; it just happens.",
            specialHindrances: "The barbarian/berserker priest has a problem in civilized lands: He doesn't respect the authorities and they have learned to be cautious of him. (This sort of priest keeps freeing his enslaved brethren, and, even if he worships a god known to this culture, he does so in a different way that the locals consider wrong.) Therefore, the barbarian/berserker priest receives a -3 reaction adjustment penalty when encountering NPCs in positions of power: Rulers, government officials, etc.",
            wealthOptions: "No special requirements; this priest gets the usual 3d6x10 gp as starting money.",
            weaponProficiencies: "* Required: None. * Recommended: Battle axe, sword/bastard, bow (any), sling, warhammer. Naturally, the priesthood may limit the priest's choice of weapons and not allow him to learn all these.",
            nonweaponProficiencies: "Bonus Proficiency: Endurance. * Recommended: (General) Animal Handling, Animal Training, Direction Sense, Fire-Building, Riding (Land-Based), Weather Sense, Blind-Fighting, Hunting, Mountaineering, Running, Set Snares, Survival, Tracking, Herbalism, Jumping. (Some of these are outside the priest's Nonweapon Proficiency Group Crossovers and will cost twice the listed slots if taken; see the description of the priest class, and the chart at the bottom of the ''Player's Handbook'', page 55, for more details.) The DM may require this priest to take a proficiency in the tribal specialty (Fishing, Agriculture, etc.).",
            equipment: "With his starting gold, the barbarian priest cannot buy armor heavier than splint mail, banded mail, or bronze plate mail. Once he has adventured in the outer world, he can buy any type of armor his priestly requirements allow him to use. With his starting gold, he can buy only weapons appropriate to his tribe (usually battle axe, bows, club, dagger/dirk, footman's flail, mace, or pick, hand/throwing axe, sling, spear, and swords); naturally, priestly restrictions may prevent him from taking some of these, depending on which god he serves."
        ),
        description: KitDescription(
            briefSummary: "This priest is the priest of a culture halfway between what we think of as civilized and savage. His people live at the very edge of or beyond the borders of the edges of the campaign's main civilization. They tend to be very warlike, fighting battles with neighboring tribes and with intruding imperial troops.",
            fullText: "## Barbarian/Berserker Priest\n**Description:** This priest is the priest of a culture halfway between what we think of as civilized and savage. His people live at the very edge of or beyond the borders of the edges of the campaign's main civilization. They tend to be very warlike, fighting battles with neighboring tribes and with intruding imperial troops. Their fighters aren't soldiers; they are warriors, and tend to be deadlier in one-on-one fighting but poorer at formation combat than those of the \"civilized\" nations. These warriors may, in fact, be berserkers (see *The Complete Fighter Handbook*). They are still more in touch with nature and the world than the people of civilized lands. They may have very different customs from civilized folk.\n\nPriests of this community perform the same functions as priests of civilized lands. However, barbarians have more respect for the gods than civilized folk, and priests also are well-respected. Kings and war-chiefs of their culture listen to their counsel. In their culture, those who disagree with them do not insult them or their guidance, and it is forbidden for a warrior to attack a priest of his culture (though defending himself from attack is all right... if he can prove that it was defense, not aggression).\n\nThere are no ability requirements to be a priest of a barbarian or berserker tribe. The warriors of the tribe must have Strength 15, and priests will be most impressive if they can approximate or match that score... but it's not a requirement of the kit.\n\nAs with the Amazon, abandonment of this kit means that the character renounces his allegiance to his tribe or clan and accepts citizenship in some other culture. This means that he must now perform his priestly duties in the fashion of the priests of that culture.\n\n**Barred:** Barbarian tribes tend to have one or two patron gods, and most of their priests will serve those gods. These tend to be gods of natural forces (Agriculture, Animals, Darkness/Night, Earth, Elemental Forces, Fertility, Hunting, Lightning, Metalwork, Nature, Sky/Weather, Thunder) or other barbarian attributes (Strength, War). Gods of the \"softer\" attributes (Arts, Love, Music, etc.) would be represented but their priests would be much rarer. No priesthood is barred among the barbarians, however scarce.\n\n**Role:** In the campaign, the barbarian priest is a spooky, dangerous figure. Like barbarian warriors, he'll be grim and a little alien to his allies from civilized lands. First and foremost, he's a defender of his people, and he'll most often be found wandering in lands other than his own because of some quest set him by the gods or some mystery he's encountered that requires him to travel in order to solve it. When he finds his own tribesmen captured or enslaved in the outer world, which might be a common occurrence, he must do his utmost to free them and return them to his own land, which can imperil other goals he and his player-character allies have...  but as a leader and protector of his culture, this is a duty he cannot refuse. (If he were to do so, the god would take it as a betrayal of goals; see the Role-Playing chapter.)\n\n**Secondary Skills:** The main occupation of the barbarian's tribe determines what sort of secondary skill he knows. If the tribe raises and sells horses, then the Groom secondary skill will be known by all tribesmen. Ask the DM what the tribe's main occupation is and that will determine the required Secondary Skill.\n\n**Weapon Proficiencies:**\n* *Required:* None.\n* *Recommended:* Battle axe, sword/bastard, bow (any), sling, warhammer. Naturally, the priesthood may limit the priest's choice of weapons and not allow him to learn all these.\n\n**Nonweapon Proficiencies:** Bonus Proficiency: Endurance.\n* *Recommended:* (General) Animal Handling, Animal Training, Direction Sense, Fire-Building, Riding (Land-Based), Weather Sense, Blind-Fighting, Hunting, Mountaineering, Running, Set Snares, Survival, Tracking, Herbalism, Jumping. (Some of these are outside the priest's Nonweapon Proficiency Group Crossovers and will cost twice the listed slots if taken; see the description of the priest class, and the chart at the bottom of the *Player's Handbook*, page 55, for more details.) The DM may require this priest to take a proficiency in the tribal specialty (Fishing, Agriculture, etc.).\n\n**Equipment:** With his starting gold, the barbarian priest cannot buy armor heavier than splint mail, banded mail, or bronze plate mail. Once he has adventured in the outer world, he can buy any type of armor his priestly requirements allow him to use. With his starting gold, he can buy only weapons appropriate to his tribe (usually battle axe, bows, club, dagger/dirk, footman's flail, mace, or pick, hand/throwing axe, sling, spear, and swords); naturally, priestly restrictions may prevent him from taking some of these, depending on which god he serves. \n\n**Special Benefits:** Barbarians are imposing and dangerous-looking. This tends to make others respect them or at least wish not to make enemies of them. Therefore, barbarian/berserker priests receive a +1 reaction adjustment bonus when encountering NPCs. This becomes a +3 among members of his own culture.\n\nIf the priest's culture has many Berserker warriors, as per *The Complete Fighter's Handbook*, the priest has an additional special ability. Berserkers normally take ten rounds to go berserk; in the presence of one of their own priests, then can do it in five. Additionally, if the priest, as part of his priestly class, has the *incite berserker rage* granted power, then berserkers of his culture in his presence can go berserk in *one round*. The priest is not required to use his power for this to take place; it just happens.\n\n**Special Hindrances:** The barbarian/berserker priest has a problem in civilized lands: He doesn't respect the authorities and they have learned to be cautious of him. (This sort of priest keeps freeing his enslaved brethren, and, even if he worships a god known to this culture, he does so in a different way that the locals consider wrong.) Therefore, the barbarian/berserker priest receives a -3 reaction adjustment penalty when encountering NPCs in positions of power: Rulers, government officials, etc.\n\n**Wealth Options:** No special requirements; this priest gets the usual 3d6x10 gp as starting money.\n\n**Races:** There are no special restrictions here. Each individual DM has to decide whether or not his demihumans can live in what are considered barbarian cultures. If they can, then they will have priests among them.",
            rawWikitext: "{{Sidebar CPrH Ch4}}__NOTOC__\n==Barbarian/Berserker Priest==\n'''Description:''' This priest is the priest of a culture halfway between what we think of as civilized and savage. His people live at the very edge of or beyond the borders of the edges of the campaign's main civilization. They tend to be very warlike, fighting battles with neighboring tribes and with intruding imperial troops. Their fighters aren't soldiers; they are warriors, and tend to be deadlier in one-on-one fighting but poorer at formation combat than those of the \"civilized\" nations. These warriors may, in fact, be berserkers (see ''The Complete Fighter Handbook''). They are still more in touch with nature and the world than the people of civilized lands. They may have very different customs from civilized folk.\n\nPriests of this community perform the same functions as priests of civilized lands. However, barbarians have more respect for the gods than civilized folk, and priests also are well-respected. Kings and war-chiefs of their culture listen to their counsel. In their culture, those who disagree with them do not insult them or their guidance, and it is forbidden for a warrior to attack a priest of his culture (though defending himself from attack is all right... if he can prove that it was defense, not aggression).\n\nThere are no ability requirements to be a priest of a barbarian or berserker tribe. The warriors of the tribe must have Strength 15, and priests will be most impressive if they can approximate or match that score... but it's not a requirement of the kit.\n\nAs with the Amazon, abandonment of this kit means that the character renounces his allegiance to his tribe or clan and accepts citizenship in some other culture. This means that he must now perform his priestly duties in the fashion of the priests of that culture.\n\n'''Barred:''' Barbarian tribes tend to have one or two patron gods, and most of their priests will serve those gods. These tend to be gods of natural forces (Agriculture, Animals, Darkness/Night, Earth, Elemental Forces, Fertility, Hunting, Lightning, Metalwork, Nature, Sky/Weather, Thunder) or other barbarian attributes (Strength, War). Gods of the \"softer\" attributes (Arts, Love, Music, etc.) would be represented but their priests would be much rarer. No priesthood is barred among the barbarians, however scarce.\n\n'''Role:''' In the campaign, the barbarian priest is a spooky, dangerous figure. Like barbarian warriors, he'll be grim and a little alien to his allies from civilized lands. First and foremost, he's a defender of his people, and he'll most often be found wandering in lands other than his own because of some quest set him by the gods or some mystery he's encountered that requires him to travel in order to solve it. When he finds his own tribesmen captured or enslaved in the outer world, which might be a common occurrence, he must do his utmost to free them and return them to his own land, which can imperil other goals he and his player-character allies have...  but as a leader and protector of his culture, this is a duty he cannot refuse. (If he were to do so, the god would take it as a betrayal of goals; see the Role-Playing chapter.)\n\n'''Secondary Skills:''' The main occupation of the barbarian's tribe determines what sort of secondary skill he knows. If the tribe raises and sells horses, then the Groom secondary skill will be known by all tribesmen. Ask the DM what the tribe's main occupation is and that will determine the required Secondary Skill.\n\n'''Weapon Proficiencies:'''\n* ''Required:'' None.\n* ''Recommended:'' Battle axe, sword/bastard, bow (any), sling, warhammer. Naturally, the priesthood may limit the priest's choice of weapons and not allow him to learn all these.\n\n'''Nonweapon Proficiencies:''' Bonus Proficiency: Endurance.\n* ''Recommended:'' (General) Animal Handling, Animal Training, Direction Sense, Fire-Building, Riding (Land-Based), Weather Sense, Blind-Fighting, Hunting, Mountaineering, Running, Set Snares, Survival, Tracking, Herbalism, Jumping. (Some of these are outside the priest's Nonweapon Proficiency Group Crossovers and will cost twice the listed slots if taken; see the description of the priest class, and the chart at the bottom of the ''Player's Handbook'', page 55, for more details.) The DM may require this priest to take a proficiency in the tribal specialty (Fishing, Agriculture, etc.).\n\n'''Equipment:''' With his starting gold, the barbarian priest cannot buy armor heavier than splint mail, banded mail, or bronze plate mail. Once he has adventured in the outer world, he can buy any type of armor his priestly requirements allow him to use. With his starting gold, he can buy only weapons appropriate to his tribe (usually battle axe, bows, club, dagger/dirk, footman's flail, mace, or pick, hand/throwing axe, sling, spear, and swords); naturally, priestly restrictions may prevent him from taking some of these, depending on which god he serves. \n\n'''Special Benefits:''' Barbarians are imposing and dangerous-looking. This tends to make others respect them or at least wish not to make enemies of them. Therefore, barbarian/berserker priests receive a +1 reaction adjustment bonus when encountering NPCs. This becomes a +3 among members of his own culture.\n\nIf the priest's culture has many Berserker warriors, as per ''The Complete Fighter's Handbook'', the priest has an additional special ability. Berserkers normally take ten rounds to go berserk; in the presence of one of their own priests, then can do it in five. Additionally, if the priest, as part of his priestly class, has the ''incite berserker rage'' granted power, then berserkers of his culture in his presence can go berserk in ''one round''. The priest is not required to use his power for this to take place; it just happens.\n\n'''Special Hindrances:''' The barbarian/berserker priest has a problem in civilized lands: He doesn't respect the authorities and they have learned to be cautious of him. (This sort of priest keeps freeing his enslaved brethren, and, even if he worships a god known to this culture, he does so in a different way that the locals consider wrong.) Therefore, the barbarian/berserker priest receives a -3 reaction adjustment penalty when encountering NPCs in positions of power: Rulers, government officials, etc.\n\n'''Wealth Options:''' No special requirements; this priest gets the usual 3d6x10 gp as starting money.\n\n'''Races:''' There are no special restrictions here. Each individual DM has to decide whether or not his demihumans can live in what are considered barbarian cultures. If they can, then they will have priests among them.\n\n{{Navbox The Complete Priest's Handbook}}\n[[Category:Character Kit]]\n[[Category:Character Kit CPrH]]"
        ),
        categories: ["Character Kit", "Character Kit CPrH"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Strength": 15],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: ["weapons"],
                forbidden: [],
                notes: "Battle axe, sword/bastard, bow (any), sling, warhammer. Naturally, the priesthood may limit the priest's choice of weapons and not allow him to learn all these."
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Proficiency: Endurance"],
                recommended: [],
                notes: "; (General) Animal Handling, Animal Training, Direction Sense, Fire-Building, Riding (Land-Based), Weather Sense, Blind-Fighting, Hunting, Mountaineering, Running, Set Snares, Survival, Tracking, Herbalism, Jumping. (Some of these are outside the priest's Nonweapon Proficiency Group Crossovers and will cost twice the listed slots if taken; see the description of the priest class, and the chart at the bottom of the ''Player's Handbook'', page 55, for more details.) The DM may require this priest to take a proficiency in the tribal specialty (Fishing, Agriculture, etc.)."
            ),
            armor: KitArmorRules(
                allowedTypes: .specific(["banded mail", "plate mail"]),
                shieldsAllowed: .specific([]),
                metalAllowed: true,
                maxArmorClass: nil,
                notes: "With his starting gold, the barbarian priest cannot buy armor heavier than splint mail, banded mail, or bronze plate mail. Once he has adventured in the outer world, he can buy any type of armor his priestly requirements allow him to use. With his starting gold, he can buy only weapons appropriate to his tribe (usually battle axe, bows, club, dagger/dirk, footman's flail, mace, or pick, hand/throwing axe, sling, spear, and swords); naturally, priestly restrictions may prevent him from taking some of these, depending on which god he serves."
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

let embeddedKit007: Kit = Kit(
        id: "beastfriend",
        name: "Beastfriend",
        wikiPageTitle: "Beastfriend (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Druid",
            allowedClasses: ["Druid"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "A Beastfriend like Lasell spends most of her time in the company of animals. In fact, she lives so much of her life around animals that sometimes she lacks social graces among humans. Many Beastfriends are gruff and hostile, preferring the company of honest natural creatures to deceitful humans, demihumans, and humanoids; others like people, but feel shy or tongue-tied around them and sometimes behave with poor manners. Lasell, like most with her kit, usually travels with one or more animal companions to whom she feels especially devoted.",
            requirements: nil,
            specialBenefits: "If Lasell, as a Beastfriend, carefully but fearlessly approaches a tamed or untamed animal, she can try to modify the beast's reaction. The druid can affect only natural animals—that is, those found in the real world (bears, wolves, snakes, etc.), as well as giant or magically enlarged versions of normal animals. When dealing with a nonhostile or domestic animal, the druid can approach and befriend it automatically. Wild beasts or animals trained to fight (like attack dogs or war horses) get a saving throw vs. rods to resist the druid at a minimum penalty of -1. An additional -1 penalty applies for every four full levels the druid has achieved: -2 at 4th level, -3 at 8th, etc. (The druid's power is not magical, though.) If the animal fails to save, the druid may choose to shift its reaction one category either direction on Table 56 (DMG, p.&nbsp;103). The Beastfriend receives a +4 bonus on animal lore, animal training, and animal handling proficiency checks. If she does not have the actual proficiency, she can function as if she did, without the +4 bonus. If Lasell, as a Beastfriend, casts an Animal sphere spell on an animal, the subject saves against it at a -2 penalty. Thanks to her knowledge of animals, a Beastfriend can recognize a lycanthrope (whether in human or animal form) on a successful animal lore check. The Beastfriend notes subtle differences in the behavior of a lycanthrope in animal form compared to a normal animal; she also notices subliminal clues in the movement and behavior of a lycanthrope in human form that point to its animal nature. The Beastfriend may make her one check only after she has been in the lycanthrope's presence for a round.",
            specialHindrances: "A Beastfriend does everything she can to help and treat a hurt animal or free an abused one and will kill an animal only to put a dying beast out of its misery. A Beastfriend who has come to know an animal may not harm it, allow others to hurt it, or send it suicidally into harm's way. In general, the Beastfriend does not recruit animals specifically as bodyguards; rather, she accumulates friends and pets, who may choose to do favors for her, such as scouting or defending her. In return, the druid feeds and shelters them, heals their injuries, and rescues them from captivity. As with all Beastfriends, Lasell's lack of social grace prevents her from learning the etiquette proficiency and gives her a -1 penalty to encounter reactions with those of her own race (except another with her kit).",
            wealthOptions: "3d6x8 gp. Beastfriends have little interest in civilized matters such as money, and seldom venture into towns.",
            weaponProficiencies: "Recommended—staff.",
            nonweaponProficiencies: "* Bonus—animal lore. * Recommended—(general) animal handling, animal training, riding (land-based), riding (airborne); (priest) healing.",
            equipment: "The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "A deep—perhaps instinctive—knowledge of the habits, actions, and behavior of animals comes naturally to a Beastfriend. Lasell, a typical Beastfriend character (pictured on the next page) feels quite protective of animals and fiercely punishes those who inflict unnecessary harm upon them.",
            fullText: "## Beastfriend\nA deep—perhaps instinctive—knowledge of the habits, actions, and behavior of animals comes naturally to a Beastfriend. Lasell, a typical Beastfriend character (pictured on the next page) feels quite protective of animals and fiercely punishes those who inflict unnecessary harm upon them. She has nothing against people hunting for food (which, after all, animals also do) but considers hunting for sport repugnant and the use of animals in gladiatorial games a horrible crime.\n\n**Role:** A Beastfriend like Lasell spends most of her time in the company of animals. In fact, she lives so much of her life around animals that sometimes she lacks social graces among humans. Many Beastfriends are gruff and hostile, preferring the company of honest natural creatures to deceitful humans, demihumans, and humanoids; others like people, but feel shy or tongue-tied around them and sometimes behave with poor manners. Lasell, like most with her kit, usually travels with one or more animal companions to whom she feels especially devoted.\n\n**Branch Restrictions:** None.\n\n**Weapon Proficiencies:** *Recommended*—staff.\n\n**Secondary Skills:** Groom, hunter.\n\n**Nonweapon Proficiencies:**\n* *Bonus*—animal lore.\n* *Recommended*—(general) animal handling, animal training, riding (land-based), riding (airborne); (priest) healing.\n\n**Equipment:** The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp.\n\n**Special Benefits:** If Lasell, as a Beastfriend, carefully but fearlessly approaches a tamed or untamed animal, she can try to modify the beast's reaction. The druid can affect only natural animals—that is, those found in the real world (bears, wolves, snakes, etc.), as well as giant or magically enlarged versions of normal animals. When dealing with a nonhostile or domestic animal, the druid can approach and befriend it automatically. Wild beasts or animals trained to fight (like attack dogs or war horses) get a saving throw vs. rods to resist the druid at a minimum penalty of -1. An additional -1 penalty applies for every four full levels the druid has achieved: -2 at 4th level, -3 at 8th, etc. (The druid's power is not magical, though.) If the animal fails to save, the druid may choose to shift its reaction one category either direction on Table 56 (*DMG*, p.&nbsp;103).\n\nThe Beastfriend receives a +4 bonus on animal lore, animal training, and animal handling proficiency checks. If she does not have the actual proficiency, she can function as if she did, without the +4 bonus.\n\nIf Lasell, as a Beastfriend, casts an Animal sphere spell on an animal, the subject saves against it at a -2 penalty.\n\nThanks to her knowledge of animals, a Beastfriend can recognize a lycanthrope (whether in human or animal form) on a successful animal lore check. The Beastfriend notes subtle differences in the behavior of a lycanthrope in animal form compared to a normal animal; she also notices subliminal clues in the movement and behavior of a lycanthrope in human form that point to its animal nature. The Beastfriend may make her one check only after she has been in the lycanthrope's presence for a round.\n\n**Special Hindrances:** A Beastfriend does everything she can to help and treat a hurt animal or free an abused one and will kill an animal only to put a dying beast out of its misery. A Beastfriend who has come to know an animal may not harm it, allow others to hurt it, or send it suicidally into harm's way. In general, the Beastfriend does not recruit animals specifically as bodyguards; rather, she accumulates friends and pets, who may choose to do favors for her, such as scouting or defending her. In return, the druid feeds and shelters them, heals their injuries, and rescues them from captivity.\n\nAs with all Beastfriends, Lasell's lack of social grace prevents her from learning the etiquette proficiency and gives her a -1 penalty to encounter reactions with those of her own race (except another with her kit).\n\n**Wealth Options:** 3d6x8 gp. Beastfriends have little interest in civilized matters such as money, and seldom venture into towns.",
            rawWikitext: "{{Sidebar CDH Ch2}}__NOTOC__\n==Beastfriend==\nA deep—perhaps instinctive—knowledge of the habits, actions, and behavior of animals comes naturally to a Beastfriend. Lasell, a typical Beastfriend character (pictured on the next page) feels quite protective of animals and fiercely punishes those who inflict unnecessary harm upon them. She has nothing against people hunting for food (which, after all, animals also do) but considers hunting for sport repugnant and the use of animals in gladiatorial games a horrible crime.\n\n'''Role:''' A Beastfriend like Lasell spends most of her time in the company of animals. In fact, she lives so much of her life around animals that sometimes she lacks social graces among humans. Many Beastfriends are gruff and hostile, preferring the company of honest natural creatures to deceitful humans, demihumans, and humanoids; others like people, but feel shy or tongue-tied around them and sometimes behave with poor manners. Lasell, like most with her kit, usually travels with one or more animal companions to whom she feels especially devoted.\n\n'''Branch Restrictions:''' None.\n\n'''Weapon Proficiencies:''' ''Recommended''—staff.\n\n'''Secondary Skills:''' Groom, hunter.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus''—[[Animal Lore (Proficiency)|animal lore]].\n* ''Recommended''—(general) [[Animal Handling (Proficiency)|animal handling]], [[Animal Training (Proficiency)|animal training]], [[Riding, Land-Based (Proficiency)|riding (land-based)]], [[Riding, Airborne (Proficiency)|riding (airborne)]]; (priest) [[Healing (Proficiency)|healing]].\n\n'''Equipment:''' The druid should spend her initial allotment of gold pieces entirely on equipment, as she loses any unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' If Lasell, as a Beastfriend, carefully but fearlessly approaches a tamed or untamed animal, she can try to modify the beast's reaction. The druid can affect only natural animals—that is, those found in the real world (bears, wolves, snakes, etc.), as well as giant or magically enlarged versions of normal animals. When dealing with a nonhostile or domestic animal, the druid can approach and befriend it automatically. Wild beasts or animals trained to fight (like attack dogs or war horses) get a saving throw vs. rods to resist the druid at a minimum penalty of -1. An additional -1 penalty applies for every four full levels the druid has achieved: -2 at 4th level, -3 at 8th, etc. (The druid's power is not magical, though.) If the animal fails to save, the druid may choose to shift its reaction one category either direction on [[DMG Table 56|Table 56 (''DMG'', p.&nbsp;103)]].\n\nThe Beastfriend receives a +4 bonus on animal lore, animal training, and animal handling proficiency checks. If she does not have the actual proficiency, she can function as if she did, without the +4 bonus.\n\nIf Lasell, as a Beastfriend, casts an Animal sphere spell on an animal, the subject saves against it at a -2 penalty.\n\nThanks to her knowledge of animals, a Beastfriend can recognize a lycanthrope (whether in human or animal form) on a successful animal lore check. The Beastfriend notes subtle differences in the behavior of a lycanthrope in animal form compared to a normal animal; she also notices subliminal clues in the movement and behavior of a lycanthrope in human form that point to its animal nature. The Beastfriend may make her one check only after she has been in the lycanthrope's presence for a round.\n\n'''Special Hindrances:''' A Beastfriend does everything she can to help and treat a hurt animal or free an abused one and will kill an animal only to put a dying beast out of its misery. A Beastfriend who has come to know an animal may not harm it, allow others to hurt it, or send it suicidally into harm's way. In general, the Beastfriend does not recruit animals specifically as bodyguards; rather, she accumulates friends and pets, who may choose to do favors for her, such as scouting or defending her. In return, the druid feeds and shelters them, heals their injuries, and rescues them from captivity.\n\nAs with all Beastfriends, Lasell's lack of social grace prevents her from learning the etiquette proficiency and gives her a -1 penalty to encounter reactions with those of her own race (except another with her kit).\n\n'''Wealth Options:''' 3d6x8 gp. Beastfriends have little interest in civilized matters such as money, and seldom venture into towns.\n\n{{Navbox The Complete Druid's Handbook}}"
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
                bonus: ["animal lore"],
                recommended: ["animal handling", "animal training", "riding", "riding", "healing"],
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
            startingCash: "3d6x8 gp"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit008: Kit = Kit(
        id: "beshaba_wormluck",
        name: "Beshaba - Wormluck",
        wikiPageTitle: "Beshaba - Wormluck (Character Kit)",
        redirectAliases: ["Priests of Beshaba (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Beshaba is the goddess of bad luck and accidents. In order to both spread her influence in the Realms and to counter the efforts of the luck goddess Tymora, Beshaba has created the wormlucks, priests of bad fortune. These purveyors of calamities cause bad things to happen around them, though they are just as subject to Beshaba's whims as their victims.",
            requirements: "Wisdom 9",
            specialBenefits: "Three times a week, the player of a wormluck character can alter a die roll to these effects: One victim's die roll changes to an automatic failure; one victim's failed die roll regresses into a disastrous result; or a minor accident (no fatalities) occurs to NPCs encountered by the wormluck.",
            specialHindrances: "Once a day, the wormluck must make a saving throw (no bonuses) vs spell, or one of the above mishaps happens to him. Also, though a wormluck can turn undead, a failed attempt causes all the undead to immediately converge on the unlucky priest.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "None",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Beshaba is the goddess of bad luck and accidents. In order to both spread her influence in the Realms and to counter the efforts of the luck goddess Tymora, Beshaba has created the wormlucks, priests of bad fortune.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || 3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || None\n|-\n| **Recommended Proficiencies** || None\n|}\n## Overview\nBeshaba is the goddess of bad luck and accidents. In order to both spread her influence in the Realms and to counter the efforts of the luck goddess Tymora, Beshaba has created the wormlucks, priests of bad fortune. These purveyors of calamities cause bad things to happen around them, though they are just as subject to Beshaba's whims as their victims.\n\n## Description\nThe wormlucks wear bright red robes over whatever armor they choose. All wormlucks must wear wigs of white hair in imitation of their goddess, although these wigs obviously look false and are badly placed most of the time. This bizarre wardrobe was forced on the wormlucks by the other clergy of Beshaba so no one confuses them with Beshaba's specialty priests.\n\n## Role-Playing\nWormlucks are gloomy, depressing people who walk around with a fatalistic air, which is hardly surprising when considering their patron. They often tend to be pessimists who are highly suspicious of good fortune. To them, good luck is but one shoe of a pair. Once providence occurs, they know that the scales must be balanced and they spend days waiting for misfortune to strike. They don't go looking for trouble, since they know it will find them soon enough.\n\n## Special Abilities\nThree times a week, the player of a wormluck character can alter a die roll to these effects: One victim's die roll changes to an automatic failure; one victim's failed die roll regresses into a disastrous result; or a minor accident (no fatalities) occurs to NPCs encountered by the wormluck.\n\n## Special Disadvantages\nOnce a day, the wormluck must make a saving throw (no bonuses) vs spell, or one of the above mishaps happens to him. Also, though a wormluck can turn undead, a failed attempt causes all the undead to immediately converge on the unlucky priest.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || 3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || None\n|-\n| '''Recommended Proficiencies''' || None\n|}__TOC__\n==Overview==\nBeshaba is the goddess of bad luck and accidents. In order to both spread her influence in the Realms and to counter the efforts of the luck goddess Tymora, Beshaba has created the wormlucks, priests of bad fortune. These purveyors of calamities cause bad things to happen around them, though they are just as subject to Beshaba's whims as their victims.\n\n==Description==\nThe wormlucks wear bright red robes over whatever armor they choose. All wormlucks must wear wigs of white hair in imitation of their goddess, although these wigs obviously look false and are badly placed most of the time. This bizarre wardrobe was forced on the wormlucks by the other clergy of Beshaba so no one confuses them with Beshaba's specialty priests.\n\n==Role-Playing==\nWormlucks are gloomy, depressing people who walk around with a fatalistic air, which is hardly surprising when considering their patron. They often tend to be pessimists who are highly suspicious of good fortune. To them, good luck is but one shoe of a pair. Once providence occurs, they know that the scales must be balanced and they spend days waiting for misfortune to strike. They don't go looking for trouble, since they know it will find them soon enough.\n\n==Special Abilities==\nThree times a week, the player of a wormluck character can alter a die roll to these effects: One victim's die roll changes to an automatic failure; one victim's failed die roll regresses into a disastrous result; or a minor accident (no fatalities) occurs to NPCs encountered by the wormluck.\n\n==Special Disadvantages==\nOnce a day, the wormluck must make a saving throw (no bonuses) vs spell, or one of the above mishaps happens to him. Also, though a wormluck can turn undead, a failed attempt causes all the undead to immediately converge on the unlucky priest.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
        deity: "Beshaba",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Wormluck"
    )

let embeddedKit009: Kit = Kit(
        id: "chauntea_cultivator",
        name: "Chauntea - Cultivator",
        wikiPageTitle: "Chauntea - Cultivator (Character Kit)",
        redirectAliases: ["Priests of Chauntea (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "The cultivator of Chauntea is a priest who concentrates his efforts on blessing the crops, giving advice on life's big and little problems, and delving into the philosophy of Chauntea, specifically keeping track of the religion's parables and sayings. The cultivators are definitely associated with the non-urban wing of the Great Mother's church.",
            requirements: "Wisdom 9",
            specialBenefits: "The cultivator can give a special bless to a farm's crops, once a day. This blessing will make the land produce at 150% its normal yield. A collective field of crops can only be so blessed once a year. Spells from the Plant sphere are doubled in terms of duration, range, area of effect, and damage when cast by a cultivator.",
            specialHindrances: "Cultivators cannot turn undead nor cast spells from the Guardian or Necromantic spheres. They cannot wear metal armor, nor use any sort of shield.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Agriculture",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "The cultivator of Chauntea is a priest who concentrates his efforts on blessing the crops, giving advice on life's big and little problems, and delving into the philosophy of Chauntea, specifically keeping track of the religion's parables and sayings.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Druid\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || 3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Agriculture\n|-\n| **Recommended Proficiencies** || Animal handling\n|}\n## Overview\nThe cultivator of Chauntea is a priest who concentrates his efforts on blessing the crops, giving advice on life's big and little problems, and delving into the philosophy of Chauntea, specifically keeping track of the religion's parables and sayings.\n\nThe cultivators are definitely associated with the non-urban wing of the Great Mother's church.\n\n## Description\nCultivators are clad simply, preferring a humble brown robe and sandals. The higher-ranked cultivators wear belts adorned with gold or silver threads or precious stones. Cultivators of 5th level and higher also wear a rare green rose that doesn't wilt for an entire year. Cultivators grow their hair long, with males sporting a moustache and beard. Leather armor and a staff are the most common defensive and offensive tools.\n\n## Role-Playing\nCultivators are generally concerned with agriculture, and tend to speak and think in agricultural terms. The eternal cycle—sowing, growing, and reaping—is stressed in every action and conversation. There are people who rapidly grow weary of parables about farming and homespun old sayings about crops, but this doesn't stop cultivators from sprinkling their dialogue with them.\n\n## Special Abilities\nThe cultivator can give a special bless to a farm's crops, once a day. This blessing will make the land produce at 150% its normal yield. A collective field of crops can only be so blessed once a year. Spells from the Plant sphere are doubled in terms of duration, range, area of effect, and damage when cast by a cultivator.\n\n## Special Disadvantages\nCultivators cannot turn undead nor cast spells from the Guardian or Necromantic spheres. They cannot wear metal armor, nor use any sort of shield.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Druid\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || 3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Agriculture (Proficiency)|Agriculture]]\n|-\n| '''Recommended Proficiencies''' || [[Animal Handling (Proficiency)|Animal handling]]\n|}__TOC__\n==Overview==\nThe cultivator of Chauntea is a priest who concentrates his efforts on blessing the crops, giving advice on life's big and little problems, and delving into the philosophy of Chauntea, specifically keeping track of the religion's parables and sayings.\n\nThe cultivators are definitely associated with the non-urban wing of the Great Mother's church.\n\n==Description==\nCultivators are clad simply, preferring a humble brown robe and sandals. The higher-ranked cultivators wear belts adorned with gold or silver threads or precious stones. Cultivators of 5th level and higher also wear a rare green rose that doesn't wilt for an entire year. Cultivators grow their hair long, with males sporting a moustache and beard. Leather armor and a staff are the most common defensive and offensive tools.\n\n==Role-Playing==\nCultivators are generally concerned with agriculture, and tend to speak and think in agricultural terms. The eternal cycle—sowing, growing, and reaping—is stressed in every action and conversation. There are people who rapidly grow weary of parables about farming and homespun old sayings about crops, but this doesn't stop cultivators from sprinkling their dialogue with them.\n\n==Special Abilities==\nThe cultivator can give a special bless to a farm's crops, once a day. This blessing will make the land produce at 150% its normal yield. A collective field of crops can only be so blessed once a year. Spells from the Plant sphere are doubled in terms of duration, range, area of effect, and damage when cast by a cultivator.\n\n==Special Disadvantages==\nCultivators cannot turn undead nor cast spells from the Guardian or Necromantic spheres. They cannot wear metal armor, nor use any sort of shield.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Agriculture"],
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
                notes: "Cultivators cannot turn undead nor cast spells from the Guardian or Necromantic spheres"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Chauntea",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Cultivator"
    )

let embeddedKit010: Kit = Kit(
        id: "chauntea_lifewarden",
        name: "Chauntea - Lifewarden",
        wikiPageTitle: "Chauntea - Lifewarden (Character Kit)",
        redirectAliases: ["Lifewarden (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Lifewardens of Chauntea are less concerned with plants and animals and more concerned about the health of humans, demihumans, and humanoids. Their specialty is healing people, brewing potions, and creating antidotes for poisons. Unlike their druidic cousins, the lifewardens are found mostly in towns and cities.",
            requirements: "Wisdom 9",
            specialBenefits: "Lifewardens have a 10% chance per level of diagnosing a disease or identifying a poison. A lifewarden can brew an antidote to any poison that is properly identified. This requires a proficiency check using the herbalism nonweapon proficiency, and takes 11 rounds minus the lifewarden's level. Naturally, the lifewarden must have access to plants and herbs used for the antidote's ingredients. Lifewardens can brew any potion, elixir, or salve that deals with healing or plants, once they reach 9th level. The basic cost of creation is halved, and for every level of the lifewarden above 9th level, the base chance of success goes up by two percent. A lifewarden's curative spells always yield maximum healing results. A cure light wounds heals eight hit points of damage every time.",
            specialHindrances: "Lifewardens can wear only leather or hide armor for protection. They cannot use shields. Lifewardens are limited to clubs and staves for weapons. Lifewardens cannot cast any clerical spells from the Combat sphere. When selecting spells, at least half of the granted spells of any given level must come from the Healing and Necromantic spheres.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Herbalism, healing",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Lifewardens of Chauntea are less concerned with plants and animals and more concerned about the health of humans, demihumans, and humanoids. Their specialty is healing people, brewing potions, and creating antidotes for poisons. Unlike their druidic cousins, the lifewardens are found mostly in towns and cities.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Herbalism, healing\n|-\n| **Recommended Proficiencies** || Brewing, alchemy\n|}\n## Overview\nLifewardens of Chauntea are less concerned with plants and animals and more concerned about the health of humans, demihumans, and humanoids. Their specialty is healing people, brewing potions, and creating antidotes for poisons. Unlike their druidic cousins, the lifewardens are found mostly in towns and cities.\n\n## Description\nLifewardens wear open-front brown cloaks over typical simple clothing such as tunics, blouses, and trousers. As a badge of office, a lifewarden either wears a green sash around her left arm, or a circlet with a small green stone mounted on the front. The latter is usually found on the higher-ranked lifewardens, and is commonly an emerald.\n\nDespite living in \"civilized\" areas, lifewardens still have an aura of health and vigor, as if they've constantly been out in the sun and wind. They even smell like wild flowers or fresh grass after a rainstorm.\n\n## Role-Playing\nTo a lifewarden, the preservation of life is paramount over everything else. If a lifewarden sees injury, he will do everything in his power to bring healing. It doesn't matter if the victim is a human, elf, orc, gnoll, ogre, or giant. A lifewarden does not stop to ponder morality, nor does the idea of a being \"not deserving to be healed\" ever cross a lifewarden's mind.\n\nAny sentient who asks for healing is entitled to it. Obviously, an ogre who is in the midst of attacking the lifewarden's party could not hope to be healed. However, any being who is not involved in a combat situation or shows that he is not responsible for any recent attacks on others can fully expect to be healed. Thus, an evil necromancer whose laboratory just blew up has a right to ask for healing from a lifewarden.\n\n## Special Abilities\nLifewardens have a 10% chance per level of diagnosing a disease or identifying a poison. A lifewarden can brew an antidote to any poison that is properly identified. This requires a proficiency check using the herbalism nonweapon proficiency, and takes 11 rounds minus the lifewarden's level. Naturally, the lifewarden must have access to plants and herbs used for the antidote's ingredients.\n\nLifewardens can brew any potion, elixir, or salve that deals with healing or plants, once they reach 9th level. The basic cost of creation is halved, and for every level of the lifewarden above 9th level, the base chance of success goes up by two percent.\n\nA lifewarden's curative spells always yield maximum healing results. A cure light wounds heals eight hit points of damage every time.\n\n## Special Disadvantages\nLifewardens can wear only leather or hide armor for protection. They cannot use shields. Lifewardens are limited to clubs and staves for weapons.\n\nLifewardens cannot cast any clerical spells from the Combat sphere. When selecting spells, at least half of the granted spells of any given level must come from the Healing and Necromantic spheres.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Herbalism (Proficiency)|Herbalism]], [[Healing (Proficiency)|healing]]\n|-\n| '''Recommended Proficiencies''' || [[Brewing (Proficiency)|Brewing]], [[Alchemy (Proficiency)|alchemy]]\n|}__TOC__\n==Overview==\nLifewardens of Chauntea are less concerned with plants and animals and more concerned about the health of humans, demihumans, and humanoids. Their specialty is healing people, brewing potions, and creating antidotes for poisons. Unlike their druidic cousins, the lifewardens are found mostly in towns and cities.\n\n==Description==\nLifewardens wear open-front brown cloaks over typical simple clothing such as tunics, blouses, and trousers. As a badge of office, a lifewarden either wears a green sash around her left arm, or a circlet with a small green stone mounted on the front. The latter is usually found on the higher-ranked lifewardens, and is commonly an emerald.\n\nDespite living in \"civilized\" areas, lifewardens still have an aura of health and vigor, as if they've constantly been out in the sun and wind. They even smell like wild flowers or fresh grass after a rainstorm.\n\n==Role-Playing==\nTo a lifewarden, the preservation of life is paramount over everything else. If a lifewarden sees injury, he will do everything in his power to bring healing. It doesn't matter if the victim is a human, elf, orc, gnoll, ogre, or giant. A lifewarden does not stop to ponder morality, nor does the idea of a being \"not deserving to be healed\" ever cross a lifewarden's mind.\n\nAny sentient who asks for healing is entitled to it. Obviously, an ogre who is in the midst of attacking the lifewarden's party could not hope to be healed. However, any being who is not involved in a combat situation or shows that he is not responsible for any recent attacks on others can fully expect to be healed. Thus, an evil necromancer whose laboratory just blew up has a right to ask for healing from a lifewarden.\n\n==Special Abilities==\nLifewardens have a 10% chance per level of diagnosing a disease or identifying a poison. A lifewarden can brew an antidote to any poison that is properly identified. This requires a proficiency check using the [[Herbalism (Proficiency)|herbalism]] nonweapon proficiency, and takes 11 rounds minus the lifewarden's level. Naturally, the lifewarden must have access to plants and herbs used for the antidote's ingredients.\n\nLifewardens can brew any potion, elixir, or salve that deals with healing or plants, once they reach 9th level. The basic cost of creation is halved, and for every level of the lifewarden above 9th level, the base chance of success goes up by two percent.\n\nA lifewarden's curative spells always yield maximum healing results. A cure light wounds heals eight hit points of damage every time.\n\n==Special Disadvantages==\nLifewardens can wear only leather or hide armor for protection. They cannot use shields. Lifewardens are limited to clubs and staves for weapons.\n\nLifewardens cannot cast any clerical spells from the Combat sphere. When selecting spells, at least half of the granted spells of any given level must come from the Healing and Necromantic spheres.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Herbalism", "healing"],
                recommended: ["Brewing", "alchemy"],
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
        deity: "Chauntea",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Lifewarden"
    )

let embeddedKit011: Kit = Kit(
        id: "clerics_of_the_cities",
        name: "Clerics of the Cities",
        wikiPageTitle: "Clerics of the Cities (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Cleric",
            allowedClasses: ["Cleric"]
        ),
        sourceBook: "The Complete Cleric's Handbook",
        features: KitFeatures(
            role: "The courageous individuals who brave the streets of the sorcerer-kings tend to spend most of their time quietly preaching to the populace. They try not to gather crowds in numbers that the templars might consider threatening, and they must gauge the political climate before they can deliver their messages of preservation in safety. Priests in cities tend to befriend the common man. If the templars declare a well closed for rationing purposes and they cannot live off the few drops allowed them, a water cleric usually comes to their aid. Similarly, those who worship air have made a name for themselves by helping slaves escape from their cruel masters.",
            requirements: nil,
            specialBenefits: "Clerics frequently act as bards in the crowded cities. They listen as well as they speak, and they have acquired the local history skill.",
            specialHindrances: nil,
            wealthOptions: nil,
            weaponProficiencies: nil,
            nonweaponProficiencies: nil,
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Elemental clerics are less common in the cities. Their powers and spells are usually limited when surrounded by walls, and the inevitable confrontations with the templars are best left to the Veiled Alliance and the druids.",
            fullText: "## Clerics of the Cities\nElemental clerics are less common in the cities. Their powers and spells are usually limited when surrounded by walls, and the inevitable confrontations with the templars are best left to the Veiled Alliance and the druids. When clerics are found in cities, they are usually visitors or they are on some specific mission. Air clerics, for example, often work with underground caravans to free slaves.\n\nThere is rarely a shrine within a city-the templars would almost certainly destroy a shrine as soon as they became aware of it. Instead, clerics quietly prowl the city streets, trying to teach the lessons their patrons have to offer and struggling to achieve their own personal goals.\n\nClerics will work with the Veiled Alliance from time to time, as long as the particular chapter remains hidden from public view. Wise clerics generally prefer to oppose the sorcerer-kings from within; they prefer to be the worm inside the rotting apple.\n\n**Role:** The courageous individuals who brave the streets of the sorcerer-kings tend to spend most of their time quietly preaching to the populace. They try not to gather crowds in numbers that the templars might consider threatening, and they must gauge the political climate before they can deliver their messages of preservation in safety. Priests in cities tend to befriend the common man. If the templars declare a well closed for rationing purposes and they cannot live off the few drops allowed them, a water cleric usually comes to their aid. Similarly, those who worship air have made a name for themselves by helping slaves escape from their cruel masters.\n\n**Alignment:** City priests tend to be neutral toward law and chaos. This may be the result of the need to balance actions under the watchful eyes of the templars. Concerning matters of good and evil, most are neutral or good. Inside the close walls and dark alleys of the cities, people do not put up with evil priests for very long.\n\n**Special Abilities:** Clerics frequently act as bards in the crowded cities. They listen as well as they speak, and they have acquired the local history skill.\n\n**Suggested Proficiencies:** Ancient history, astrology (Air), blacksmithing (Earth and Fire), disguise, healing, heraldry (of templars and the city states), languages, reading/writing.",
            rawWikitext: "{{Sidebar EAFW Ch2}}__NOTOC__\n==Clerics of the Cities==\nElemental clerics are less common in the cities. Their powers and spells are usually limited when surrounded by walls, and the inevitable confrontations with the templars are best left to the Veiled Alliance and the druids. When clerics are found in cities, they are usually visitors or they are on some specific mission. Air clerics, for example, often work with underground caravans to free slaves.\n\nThere is rarely a shrine within a city-the templars would almost certainly destroy a shrine as soon as they became aware of it. Instead, clerics quietly prowl the city streets, trying to teach the lessons their patrons have to offer and struggling to achieve their own personal goals.\n\nClerics will work with the Veiled Alliance from time to time, as long as the particular chapter remains hidden from public view. Wise clerics generally prefer to oppose the sorcerer-kings from within; they prefer to be the worm inside the rotting apple.\n\n'''Role:''' The courageous individuals who brave the streets of the sorcerer-kings tend to spend most of their time quietly preaching to the populace. They try not to gather crowds in numbers that the templars might consider threatening, and they must gauge the political climate before they can deliver their messages of preservation in safety. Priests in cities tend to befriend the common man. If the templars declare a well closed for rationing purposes and they cannot live off the few drops allowed them, a water cleric usually comes to their aid. Similarly, those who worship air have made a name for themselves by helping slaves escape from their cruel masters.\n\n'''Alignment:''' City priests tend to be neutral toward law and chaos. This may be the result of the need to balance actions under the watchful eyes of the templars. Concerning matters of good and evil, most are neutral or good. Inside the close walls and dark alleys of the cities, people do not put up with evil priests for very long.\n\n'''Special Abilities:''' Clerics frequently act as bards in the crowded cities. They listen as well as they speak, and they have acquired the local history skill.\n\n'''Suggested Proficiencies:''' Ancient history, astrology (Air), blacksmithing (Earth and Fire), disguise, healing, heraldry (of templars and the city states), languages, reading/writing.\n\n{{Navbox Earth, Air, Fire and Water}}\n[[Category:Character Kit]]\n[[Category:Character Kit EAFW]]"
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

let embeddedKit012: Kit = Kit(
        id: "cyric_purifier",
        name: "Cyric - Purifier",
        wikiPageTitle: "Cyric - Purifier (Character Kit)",
        redirectAliases: ["Priests of Cyric (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "In the aftermath of the Zhentil Keep/Cyrinishad incident, Cyric commissioned a group of priests to go forth and cleanse the Dark Sun's church of all its half-hearted members. In addition, these so-called purifiers are sworn to fight against the servants of the non-evil gods in an effort to reduce the respective deities' power by reducing the number of worshipers.",
            requirements: "Wisdom 9",
            specialBenefits: "Once per week, a purifier of 5th level or higher can animate a human skull for a period of eight hours per level of the priest. This skull has the hit dice, hit points, and intelligence of the purifier. The skull always hovers about one foot away from the purifier at the height of the purifier's shoulder, shouting the praises of Cyric. The skull has an armor class of 4 and can either bite (1d4 points of damage) or let out a piercing shriek that acts as confusion spell. The latter attack form can only be done twice a day.",
            specialHindrances: "Purifiers cannot cast spells from the Healing sphere, and must have an Intelligence of at least 12. Due to the Zhentil Keep fiasco, purifiers are not welcome in that city as well as many others across the Realms. Many are in fact attacked outright.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Inquisitor",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "In the aftermath of the Zhentil Keep/Cyrinishad incident, Cyric commissioned a group of priests to go forth and cleanse the Dark Sun's church of all its half-hearted members.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Half-elf, human\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Inquisitor\n|-\n| **Recommended Proficiencies** || Religion\n|}\n## Overview\nIn the aftermath of the Zhentil Keep/Cyrinishad incident, Cyric commissioned a group of priests to go forth and cleanse the Dark Sun's church of all its half-hearted members. In addition, these so-called purifiers are sworn to fight against the servants of the non-evil gods in an effort to reduce the respective deities' power by reducing the number of worshipers.\n\n## Description\nPurifiers clad themselves in voluminous robes of deepest black, decorated with crimson streaks. Each priest also wears silver bracers on his wrists, and a silver headband with a skull set against a black sun on the forehead. Purifiers carry an ornate footman's mace as another symbol of office.\n\n## Role-Playing\nAs guardians of the faith, Purifiers are stubbornly loyal to Cyric despite the god's setbacks. They are intellectuals who can argue the merits of their faith, but are not afraid to also be cruel. To them, the worship of Cyric is\n\nthe One True Faith, and all other gods and their worshipers must die.\n\n## Special Abilities\nOnce per week, a purifier of 5th level or higher can animate a human skull for a period of eight hours per level of the priest. This skull has the hit dice, hit points, and intelligence of the purifier. The skull always hovers about one foot away from the purifier at the height of the purifier's shoulder, shouting the praises of Cyric. The skull has an armor class of 4 and can either bite (1d4 points of damage) or let out a piercing shriek that acts as confusion spell. The latter attack form can only be done twice a day.\n\n## Special Disadvantages\nPurifiers cannot cast spells from the Healing sphere, and must have an Intelligence of at least 12.\n\nDue to the Zhentil Keep fiasco, purifiers are not welcome in that city as well as many others across the Realms. Many are in fact attacked outright.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Half-elf, human\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Inquisitor (Character Kit)|Inquisitor]]\n|-\n| '''Recommended Proficiencies''' || [[Religion (Proficiency)|Religion]]\n|}__TOC__\n==Overview==\nIn the aftermath of the Zhentil Keep/Cyrinishad incident, Cyric commissioned a group of priests to go forth and cleanse the Dark Sun's church of all its half-hearted members. In addition, these so-called purifiers are sworn to fight against the servants of the non-evil gods in an effort to reduce the respective deities' power by reducing the number of worshipers.\n\n==Description==\nPurifiers clad themselves in voluminous robes of deepest black, decorated with crimson streaks. Each priest also wears silver bracers on his wrists, and a silver headband with a skull set against a black sun on the forehead. Purifiers carry an ornate footman's mace as another symbol of office.\n\n==Role-Playing==\nAs guardians of the faith, Purifiers are stubbornly loyal to Cyric despite the god's setbacks. They are intellectuals who can argue the merits of their faith, but are not afraid to also be cruel. To them, the worship of Cyric is\n\nthe One True Faith, and all other gods and their worshipers must die.\n\n==Special Abilities==\nOnce per week, a purifier of 5th level or higher can animate a human skull for a period of eight hours per level of the priest. This skull has the hit dice, hit points, and intelligence of the purifier. The skull always hovers about one foot away from the purifier at the height of the purifier's shoulder, shouting the praises of Cyric. The skull has an armor class of 4 and can either bite (1d4 points of damage) or let out a piercing shriek that acts as confusion spell. The latter attack form can only be done twice a day.\n\n==Special Disadvantages==\nPurifiers cannot cast spells from the Healing sphere, and must have an Intelligence of at least 12.\n\nDue to the Zhentil Keep fiasco, purifiers are not welcome in that city as well as many others across the Realms. Many are in fact attacked outright.\n\n{{Navbox Warriors & Priests of the Realms}}"
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
        deity: "Cyric",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Purifier"
    )

let embeddedKit013: Kit = Kit(
        id: "cyric_sword",
        name: "Cyric - Sword",
        wikiPageTitle: "Cyric - Sword (Character Kit)",
        redirectAliases: ["Sword (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "As the god of treachery, strife, deception, and disaster, Cyric needs a branch of his clergy that delights in spreading these influences all over the Realms. The swords are the militants of Cyric's church who actively and openly battle the forces of the good deities.",
            requirements: "Strength 12, Wisdom 9",
            specialBenefits: "Swords have the ranger abilities of move silently and hide in shadows, which are modified by armor and dexterity. They can backstab like thieves of one level less than their current level. When battling an enemy who visibly wears the holy symbol of a good deity, the sword gains a +1 to his attack rolls, damage rolls, and saving throws. The swords of Cyric are not very welcome in Zhentil Keep, and are also openly reviled all over the Moonsea, Dalelands and Cormyr. If a sword is found in any of those places, a cry is raised, and city guards, watchmen, constables, and crusaders from any good temples in the city converge on the sword. These swords are given the option to surrender or die.",
            specialHindrances: "Due to the sheer destructiveness of the swords, they cannot use any spells from the Healing sphere. In addition, they cannot turn or command undead, this limit stemming from Kelemvors enmity towards Cyric. Swords are severely limited in their weaponry. They are allowed to use only long swords (Cyrics former weapon as a mortal), and daggers and nothing else. They do not gain any more weapon proficiency slots",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Blindfighting",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "As the god of treachery, strife, deception, and disaster, Cyric needs a branch of his clergy that delights in spreading these influences all over the Realms. The swords are the militants of Cyric's church who actively and openly battle the forces of the good deities.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Half-elf, human\n|-\n| **Ability Requirements** || Strength 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || Yes\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 0\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Blindfighting\n|-\n| **Recommended Proficiencies** || Religion\n|}\n## Overview\nAs the god of treachery, strife, deception, and disaster, Cyric needs a branch of his clergy that delights in spreading these influences all over the Realms. The swords are the militants of Cyric's church who actively and openly battle the forces of the good deities.\n\n## Description\nThe swords of Cyric are always ready for wars of all kinds. They are thus always clad in either chain, splint, or plate armor. They carry only long swords and daggers. Purple tabards embroidered with Cyric's symbol complete the swords' uniforms. There is always an air of tension around the swords, as if they are waiting for the slightest excuse to kill someone. This is not too far from the truth when dealing with a sword of Cyric.\n\n## Role-Playing\nWhereas the purifiers are happy keeping the doctrine pure by means of discourse and violence, the swords live solely for violence, whether it is overt or subtle. \"The purifiers hatch the plots, and the swords carry them out\" is a common saying around the Moonsea and the Dalelands.\n\nThe hatred of the good religions bums so brightly in the hearts of the swords that they will attack anyone outright who wears a symbol of another god.\n\nStill, the swords can be subtle when the situation warrants. Many savor skulking through alleyways like thieves, releasing rumors to discredit foes politically, or simply poisoning a rival. These are all effective uses of Cyric's strife and treachery. In any case, death, destruction and discord are still the meat and drink of the swords, and they love their work.\n\nLately, the Church of Cyric has decreed that any who have fallen away from the true faith are open targets for the swords.\n\n## Special Abilities\nSwords have the ranger abilities of move silently and hide in shadows, which are modified by armor and dexterity. They can backstab like thieves of one level less than their current level. When battling an enemy who visibly wears the holy symbol of a good deity, the sword gains a +1 to his attack rolls, damage rolls, and saving throws.\n\nThe swords of Cyric are not very welcome in Zhentil Keep, and are also openly reviled all over the Moonsea, Dalelands and Cormyr. If a sword is found in any of those places, a cry is raised, and city guards, watchmen, constables, and crusaders from any good temples in the city converge on the sword. These swords are given the option to surrender or die.\n\n## Special Disadvantages\nDue to the sheer destructiveness of the swords, they cannot use any spells from the Healing sphere. In addition, they cannot turn or command undead, this limit stemming from Kelemvors enmity towards Cyric.\n\nSwords are severely limited in their weaponry. They are allowed to use only long swords (Cyrics former weapon as a mortal), and daggers and nothing else. They do not gain any more weapon proficiency slots",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Half-elf, human\n|-\n| '''Ability Requirements''' || [[Strength]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || Yes\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 0\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Blind-fighting (Proficiency)|Blindfighting]]\n|-\n| '''Recommended Proficiencies''' || [[Religion (Proficiency)|Religion]]\n|}__TOC__\n==Overview==\nAs the god of treachery, strife, deception, and disaster, Cyric needs a branch of his clergy that delights in spreading these influences all over the Realms. The swords are the militants of Cyric's church who actively and openly battle the forces of the good deities.\n\n==Description==\nThe swords of Cyric are always ready for wars of all kinds. They are thus always clad in either chain, splint, or plate armor. They carry only long swords and daggers. Purple tabards embroidered with Cyric's symbol complete the swords' uniforms. There is always an air of tension around the swords, as if they are waiting for the slightest excuse to kill someone. This is not too far from the truth when dealing with a sword of Cyric.\n\n==Role-Playing==\nWhereas the purifiers are happy keeping the doctrine pure by means of discourse and violence, the swords live solely for violence, whether it is overt or subtle. \"The purifiers hatch the plots, and the swords carry them out\" is a common saying around the Moonsea and the Dalelands.\n\nThe hatred of the good religions bums so brightly in the hearts of the swords that they will attack anyone outright who wears a symbol of another god.\n\nStill, the swords can be subtle when the situation warrants. Many savor skulking through alleyways like thieves, releasing rumors to discredit foes politically, or simply poisoning a rival. These are all effective uses of Cyric's strife and treachery. In any case, death, destruction and discord are still the meat and drink of the swords, and they love their work.\n\nLately, the Church of Cyric has decreed that any who have fallen away from the true faith are open targets for the swords.\n\n==Special Abilities==\nSwords have the ranger abilities of move silently and hide in shadows, which are modified by armor and dexterity. They can backstab like thieves of one level less than their current level. When battling an enemy who visibly wears the holy symbol of a good deity, the sword gains a +1 to his attack rolls, damage rolls, and saving throws.\n\nThe swords of Cyric are not very welcome in Zhentil Keep, and are also openly reviled all over the Moonsea, Dalelands and Cormyr. If a sword is found in any of those places, a cry is raised, and city guards, watchmen, constables, and crusaders from any good temples in the city converge on the sword. These swords are given the option to surrender or die.\n\n==Special Disadvantages==\nDue to the sheer destructiveness of the swords, they cannot use any spells from the Healing sphere. In addition, they cannot turn or command undead, this limit stemming from Kelemvors enmity towards Cyric.\n\nSwords are severely limited in their weaponry. They are allowed to use only long swords (Cyrics former weapon as a mortal), and daggers and nothing else. They do not gain any more weapon proficiency slots\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Blindfighting"],
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
                mode: "modified",
                notes: "command undead, this limit stemming from kelemvors enmity towards cyric"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Cyric",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Sword"
    )

let embeddedKit014: Kit = Kit(
        id: "deneir_wordsmith",
        name: "Deneir - Wordsmith",
        wikiPageTitle: "Deneir - Wordsmith (Character Kit)",
        redirectAliases: ["Priests of Deneir (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Wordsmiths are special clerics of Deneir, god of glyphs, images, literature, and art. They act as teachers, scribes, librarians, and translators.",
            requirements: "Intelligence 14, Wisdom 9",
            specialBenefits: "Aside from the Common tongue, wordsmiths get two additional languages and the ability to read and write them for free. Wordsmiths speak languages with such fluency that it becomes almost impossible to tell where the priest is originally from by the way he speaks. For anyone attempting this, they must roll a 1 on a d20 in order to guess the wordsmith's original home by his accent. A wordsmith has a base 20% chance plus 2% per level, of deciphering glyphs, symbols, and other magical writings. In the case of things such as explosive runes, glyphs of warding, or other spell effects activated by reading, the wordsmith must make a saving throw (no bonuses) vs spell. If he succeeds, the effects are not triggered. Otherwise, the effects are unleashed. Wordsmiths gain a +4 bonus to saving throws versus runes, glyphs, symbols, and other reading-activated effects.",
            specialHindrances: "Anyone who cannot read or write well can ask a wordsmith for help, and that help must be given. Whenever a wordsmith enters a town or city, there is a cumulative 10% chance per day that he will wind up doing 2d4 hours of charity work. Wordsmiths cannot turn undead, and they cannot wear any armor.",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Reading/writing",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Wordsmiths are special clerics of Deneir, god of glyphs, images, literature, and art. They act as teachers, scribes, librarians, and translators.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Intelligence 14,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest, Wizard\n|-\n| **Bonus Proficiencies** || Reading/writing\n|-\n| **Recommended Proficiencies** || Ancient language, Artistic ability (calligraphy)\n|}\n## Overview\nWordsmiths are special clerics of Deneir, god of glyphs, images, literature, and art. They act as teachers, scribes, librarians, and translators.\n\n## Description\nNaturally, the one thing all wordsmiths wear is the holy writing kit, a triangular leather belt pouch filled with parchment, ink, and quills. Wordsmiths have a scholarly air about them, and seem generally inoffensive.\n\nWordsmiths wear the traditional tan-white tunics and golden circlets of the faith. They wear medium-length cloaks of bright crimson.\n\nDue to their noncombative exposure to the generally peaceful public, wordsmiths do not wear armor. One might keep a short-hafted one-handed weapon, such as a hammer or horseman's mace, discreetly tucked away for emergencies, or he might rely on his sturdy walking stick (quarterstaff) as a last-minute safeguard.\n\n## Role-Playing\nWordsmiths are intelligent, educated, articulate, creative, learned, and charitable. Although some people may see such intelligence as an excuse to be elitist snobs, wordsmiths are surprisingly discreet about their intellectual abilities.\n\nWordsmiths are the kind of people who always have that elusive word that someone is looking for, though it is always offered in a helpful manner, not in an arrogant fashion.\n\nThere is a small sect of wordsmiths, comprised of poets and writers, who do act overly dramatic and angstridden. They moan and complain about things like \"writer's block\" and \"deadlines,\" and how people constantly change their drafts. The rest of the wordsmiths refuse to indulge these over-sensitive souls.\n\n## Special Abilities\nAside from the Common tongue, wordsmiths get two additional languages and the ability to read and write them for free. Wordsmiths speak languages with such fluency that it becomes almost impossible to tell where the priest is originally from by the way he speaks. For anyone attempting this, they must roll a 1 on a d20 in order to guess the wordsmith's original home by his accent.\n\nA wordsmith has a base 20% chance plus 2% per level, of deciphering glyphs, symbols, and other magical writings. In the case of things such as explosive runes, glyphs of warding, or other spell effects activated by reading, the wordsmith must make a saving throw (no bonuses) vs spell. If he succeeds, the effects are not triggered. Otherwise, the effects are unleashed.\n\nWordsmiths gain a +4 bonus to saving throws versus runes, glyphs, symbols, and other reading-activated effects.\n\n## Special Disadvantages\nAnyone who cannot read or write well can ask a wordsmith for help, and that help must be given. Whenever a wordsmith enters a town or city, there is a cumulative 10% chance per day that he will wind up doing 2d4 hours of charity work.\n\nWordsmiths cannot turn undead, and they cannot wear any armor.",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Intelligence]] 14,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest, Wizard\n|-\n| '''Bonus Proficiencies''' || [[Reading/Writing (Proficiency)|Reading/writing]]\n|-\n| '''Recommended Proficiencies''' || [[Languages, Ancient (Proficiency)|Ancient language]], [[Artistic Ability (Proficiency)|Artistic ability]] (calligraphy)\n|}__TOC__\n==Overview==\nWordsmiths are special clerics of Deneir, god of glyphs, images, literature, and art. They act as teachers, scribes, librarians, and translators.\n\n==Description==\nNaturally, the one thing all wordsmiths wear is the holy writing kit, a triangular leather belt pouch filled with parchment, ink, and quills. Wordsmiths have a scholarly air about them, and seem generally inoffensive.\n\nWordsmiths wear the traditional tan-white tunics and golden circlets of the faith. They wear medium-length cloaks of bright crimson.\n\nDue to their noncombative exposure to the generally peaceful public, wordsmiths do not wear armor. One might keep a short-hafted one-handed weapon, such as a hammer or horseman's mace, discreetly tucked away for emergencies, or he might rely on his sturdy walking stick (quarterstaff) as a last-minute safeguard.\n\n==Role-Playing==\nWordsmiths are intelligent, educated, articulate, creative, learned, and charitable. Although some people may see such intelligence as an excuse to be elitist snobs, wordsmiths are surprisingly discreet about their intellectual abilities.\n\nWordsmiths are the kind of people who always have that elusive word that someone is looking for, though it is always offered in a helpful manner, not in an arrogant fashion.\n\nThere is a small sect of wordsmiths, comprised of poets and writers, who do act overly dramatic and angstridden. They moan and complain about things like \"writer's block\" and \"deadlines,\" and how people constantly change their drafts. The rest of the wordsmiths refuse to indulge these over-sensitive souls.\n\n==Special Abilities==\nAside from the Common tongue, wordsmiths get two additional languages and the ability to read and write them for free. Wordsmiths speak languages with such fluency that it becomes almost impossible to tell where the priest is originally from by the way he speaks. For anyone attempting this, they must roll a 1 on a d20 in order to guess the wordsmith's original home by his accent.\n\nA wordsmith has a base 20% chance plus 2% per level, of deciphering glyphs, symbols, and other magical writings. In the case of things such as explosive runes, glyphs of warding, or other spell effects activated by reading, the wordsmith must make a saving throw (no bonuses) vs spell. If he succeeds, the effects are not triggered. Otherwise, the effects are unleashed.\n\nWordsmiths gain a +4 bonus to saving throws versus runes, glyphs, symbols, and other reading-activated effects.\n\n==Special Disadvantages==\nAnyone who cannot read or write well can ask a wordsmith for help, and that help must be given. Whenever a wordsmith enters a town or city, there is a cumulative 10% chance per day that he will wind up doing 2d4 hours of charity work.\n\nWordsmiths cannot turn undead, and they cannot wear any armor.\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 14, "Wisdom": 9],
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
                bonus: ["Reading/writing"],
                recommended: ["Ancient language", "Artistic ability"],
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
                notes: "Wordsmiths cannot turn undead, and they cannot wear any armor"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Deneir",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Wordsmith"
    )

let embeddedKit015: Kit = Kit(
        id: "eldath_stillwater",
        name: "Eldath - Stillwater",
        wikiPageTitle: "Eldath - Stillwater (Character Kit)",
        redirectAliases: ["Priests of Eldath (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Eldath is the pacifistic goddess of peace, pools, and druid groves. A group of her clergy, sickened by how often priests get involved in battles, decided of their own volition to form a sect of priests devoted to peace and tranquility. The stillwaters are not very popular, since many see them as being too pacifistic to do anyone in the Realms any good. Eldath supports them, however, and seems to be watching over them.",
            requirements: "Wisdom 9",
            specialBenefits: "A stillwater may utter a soothing word a number of times equal to his level per day. This word affects two hit dice of creatures per level of the priest within a 20' radius. Creatures affected by the word cease hostilities and will listen to the cleric for 1d4+1 rounds. At the end of this time, each affected creature must make a saving throw vs spell or end the confrontation completely and walk away peacefully. At 3rd level, stillwaters can cast sleep once per day. Note that they will not allow their compatriots to slaughter any sleeping foes. At 5th level, stillwaters can cast forget once per day. This is cast with the intention of making the enemy forget its anger and why it is fighting in the hope that the enemy will wander away.",
            specialHindrances: "Stillwaters cannot use any weapon nor wear armor. They cannot use any magical item that brings harm to another, nor can they cast any spell that causes disease or harm. Stillwaters can turn undead. : ''\"Here's a jest for you: why are Stillwaters' cloaks dyed brown? To hide the bootprints all over their back! Funny, no? Honestly, I often wonder why they bother. I mean, I am not an overly violent person, but if someone attacks me or some helpless person (especially a beautiful woman), then stand back and watch my swordplay, friend. These priests try to talk to their enemies! Want to know how well it works! Suffice it to say I've seen more grave markers with the words \"cleric of Eldath\" on them than any other words, fiend!\" :: -Mendryll Belarod''",
            wealthOptions: "3d6",
            weaponProficiencies: "0",
            nonweaponProficiencies: "Healing",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Eldath is the pacifistic goddess of peace, pools, and druid groves. A group of her clergy, sickened by how often priests get involved in battles, decided of their own volition to form a sect of priests devoted to peace and tranquility.",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any\n|-\n| **Ability Requirements** || Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 0\n|-\n| **Additional Slot** || 0\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Healing\n|-\n| **Recommended Proficiencies** || None\n|}\n## Overview\nEldath is the pacifistic goddess of peace, pools, and druid groves. A group of her clergy, sickened by how often priests get involved in battles, decided of their own volition to form a sect of priests devoted to peace and tranquility. The stillwaters are not very popular, since many see them as being too pacifistic to do anyone in the Realms any good. Eldath supports them, however, and seems to be watching over them.\n\n## Description\nSerenity is the word used to describe the bearing of the stillwaters. They seem to radiate peace. Stillwaters do not wear any armor, nor do they carry any weapons.\n\nStillwaters wear long, flowing, blue-green robes and gowns, with light brown cloaks. Many wear garlands of flowers in their hair, using flowers that symbolize peace in any given locale, depending on where the stillwater operates from\n\n## Role-Playing\nAll stillwaters want to be as calm and placid as a still, quiet pond. Each cleric feels that achieving a state of perfect peace will bring him closer to Eldath herself.\n\nNo matter how heinous a being is, stillwaters will not raise a hand against them. They believe that inner peace lies within all beings, if only everyone would look deep inside themselves and allow it to come forth. Stillwaters try their best to talk and reason with everyone, pointing out to them the futility of violence.\n\n## Special Abilities\nA stillwater may utter a soothing word a number of times equal to his level per day. This word affects two hit dice of creatures per level of the priest within a 20' radius. Creatures affected by the word cease hostilities and will listen to the cleric for 1d4+1 rounds. At the end of this time, each affected creature must make a saving throw vs spell or end the confrontation completely and walk away peacefully.\n\nAt 3rd level, stillwaters can cast sleep once per day. Note that they will not allow their compatriots to slaughter any sleeping foes.\n\nAt 5th level, stillwaters can cast forget once per day. This is cast with the intention of making the enemy forget its anger and why it is fighting in the hope that the enemy will wander away.\n\n## Special Disadvantages\nStillwaters cannot use any weapon nor wear armor. They cannot use any magical item that brings harm to another, nor can they cast any spell that causes disease or harm.\n\nStillwaters can turn undead.\n\n: *\"Here's a jest for you: why are Stillwaters' cloaks dyed brown? To hide the bootprints all over their back! Funny, no? Honestly, I often wonder why they bother. I mean, I am not an overly violent person, but if someone attacks me or some helpless person (especially a beautiful woman), then stand back and watch my swordplay, friend. These priests try to talk to their enemies! Want to know how well it works! Suffice it to say I've seen more grave markers with the words \"cleric of Eldath\" on them than any other words, fiend!\"*\n\n:: *-Mendryll Belarod*",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any\n|-\n| '''Ability Requirements''' || [[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 0\n|-\n| '''Additional Slot''' || 0\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Healing (Proficiency)|Healing]]\n|-\n| '''Recommended Proficiencies''' || None\n|}__TOC__\n==Overview==\nEldath is the pacifistic goddess of peace, pools, and druid groves. A group of her clergy, sickened by how often priests get involved in battles, decided of their own volition to form a sect of priests devoted to peace and tranquility. The stillwaters are not very popular, since many see them as being too pacifistic to do anyone in the Realms any good. Eldath supports them, however, and seems to be watching over them.\n\n==Description==\nSerenity is the word used to describe the bearing of the stillwaters. They seem to radiate peace. Stillwaters do not wear any armor, nor do they carry any weapons.\n\nStillwaters wear long, flowing, blue-green robes and gowns, with light brown cloaks. Many wear garlands of flowers in their hair, using flowers that symbolize peace in any given locale, depending on where the stillwater operates from\n\n==Role-Playing==\nAll stillwaters want to be as calm and placid as a still, quiet pond. Each cleric feels that achieving a state of perfect peace will bring him closer to Eldath herself.\n\nNo matter how heinous a being is, stillwaters will not raise a hand against them. They believe that inner peace lies within all beings, if only everyone would look deep inside themselves and allow it to come forth. Stillwaters try their best to talk and reason with everyone, pointing out to them the futility of violence.\n\n==Special Abilities==\nA stillwater may utter a soothing word a number of times equal to his level per day. This word affects two hit dice of creatures per level of the priest within a 20' radius. Creatures affected by the word cease hostilities and will listen to the cleric for 1d4+1 rounds. At the end of this time, each affected creature must make a saving throw vs spell or end the confrontation completely and walk away peacefully.\n\nAt 3rd level, stillwaters can cast sleep once per day. Note that they will not allow their compatriots to slaughter any sleeping foes.\n\nAt 5th level, stillwaters can cast forget once per day. This is cast with the intention of making the enemy forget its anger and why it is fighting in the hope that the enemy will wander away.\n\n==Special Disadvantages==\nStillwaters cannot use any weapon nor wear armor. They cannot use any magical item that brings harm to another, nor can they cast any spell that causes disease or harm.\n\nStillwaters can turn undead.\n\n: ''\"Here's a jest for you: why are Stillwaters' cloaks dyed brown? To hide the bootprints all over their back! Funny, no? Honestly, I often wonder why they bother. I mean, I am not an overly violent person, but if someone attacks me or some helpless person (especially a beautiful woman), then stand back and watch my swordplay, friend. These priests try to talk to their enemies! Want to know how well it works! Suffice it to say I've seen more grave markers with the words \"cleric of Eldath\" on them than any other words, fiend!\"''\n\n:: ''-Mendryll Belarod''\n\n{{Navbox Warriors & Priests of the Realms}}"
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
                bonus: ["Healing"],
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
        deity: "Eldath",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Stillwater"
    )

let embeddedKit016: Kit = Kit(
        id: "element_singer",
        name: "Element Singer",
        wikiPageTitle: "Element Singer (Character Kit)",
        redirectAliases: ["Element Singer"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Cleric",
            allowedClasses: ["Cleric"]
        ),
        sourceBook: "The Complete Cleric's Handbook",
        features: KitFeatures(
            role: "Element singers hold positions of leadership and responsibility in their tribes, though those they administer to do not quite know what to make of these clerics. Elves understand the magic of preservers and defilers, but have little knowledge of priestly magic. It frightens them, much as the raging elements frighten them. Those who commune with these terrible forces, therefore, become objects of fear, too. Still, the tribes realize they need the element singers, so they give them an awe-inspired respect. In many cases, the very survival of an elf tribe depends on its element singers. Element singers interpret the omens and portents inherent in the forces of nature. They advise tribal chiefs as to the best courses of action. They lead rites of passage and other tribal rituals. They heal the wounded and cure the sick. When element singers leave their tribes to explore the world of the outsiders, they take with them their beliefs, traditions, and devotions. These clerics are elves through and through—savage, unpredictable, living for each now. Though individual tribes tend to congregate toward a particular element, element singers are not intolerant of other faiths, as long as they are elemental in nature. Those who seek to worship individuals (such as a sorcerer-king) are seen as fools or worse, for no one not even a sorcerer-king can compare to the elements that shape the world.",
            requirements: nil,
            specialBenefits: "Element singers receive one bonus spell at each spell level. For example, if a 3rd-level singer would normally be entitled to two 1st-level spells, this special benefit gives him or her three 1st-level spells instead. This bonus applies to each spell level, but the bonus spells must be selected from the singers elemental sphere.",
            specialHindrances: "Element singers only receive only one initial weapon proficiency slot (instead of two). They must drop everything else they are doing to go to the aid of their tribe whenever they are needed.",
            wealthOptions: "Element singers start play with 3d6x 30 cp as well as the items listed under Equipment above.",
            weaponProficiencies: "Members of this kit may select any weapons allowed to the priest class.",
            nonweaponProficiencies: "Proficiencies for the element singers are as follows. * Bonus Proficiencies Survival (choice of terrain type depends on where the tribe spends most of its time and which element the singer is devoted to). * Required Proficiencies Healing, spellcraft, water find. * Recommended (General) Animal handling, artistic ability, dancing, direction sense, fire-building, heat protection, leatherworking, singing, weather sense. * Recommended (Priest) Ancient history, herbalism, musical instrument, reading/writing, religion, somatic concealment.",
            equipment: "Element singers may use any equipment available to the priest class. They begin play with a bone weapon of excellent tribal make and a holy symbol dedicated to their element of choice."
        ),
        description: KitDescription(
            briefSummary: "The element singer is an elf cleric dedicated to a single elemental force of nature. Most tribes hold those who commune with the elements in awe and treat them with a small measure of fear.",
            fullText: "## Element Singer\nThe element singer is an elf cleric dedicated to a single elemental force of nature. Most tribes hold those who commune with the elements in awe and treat them with a small measure of fear. Elf tribes rarely have more than one or two element singers, though they will accept any number of lesser ritual dancers and battle dancers. Element singers are called by the element they worship—wind singer, flame singer, earth singer, or water singer.\n\nMost of the element singers that outsiders meet are young singers fulfilling their wanderlust as there is no place for them (currently) in their tribe. Others no longer have a tribe, or they are seeking a new tribe because they are compelled to worship an elemental force that is not the one revered by their tribe. A select few have been sent on some far-reaching mission by the force they worship.\n\nElement singers are the true clerics of the elf tribes. Each draws spells from the sphere of the cosmos as well as from the sphere associated with their element of choice. They fulfill roles as tribal clerics, and most have an extreme hatred of templars and defilers who draw power from landmarks associated with their revered element.\n\n**Recommended Tribal Affiliation:** All elf tribes have element singers, so they may have any tribal affiliation desired.\n\n**Role:** Element singers hold positions of leadership and responsibility in their tribes, though those they administer to do not quite know what to make of these clerics. Elves understand the magic of preservers and defilers, but have little knowledge of priestly magic. It frightens them, much as the raging elements frighten them. Those who commune with these terrible forces, therefore, become objects of fear, too. Still, the tribes realize they need the element singers, so they give them an awe-inspired respect. In many cases, the very survival of an elf tribe depends on its element singers.\n\nElement singers interpret the omens and portents inherent in the forces of nature. They advise tribal chiefs as to the best courses of action. They lead rites of passage and other tribal rituals. They heal the wounded and cure the sick. When element singers leave their tribes to explore the world of the outsiders, they take with them their beliefs, traditions, and devotions. These clerics are elves through and through—savage, unpredictable, living for each now.\n\nThough individual tribes tend to congregate toward a particular element, element singers are not intolerant of other faiths, as long as they are elemental in nature. Those who seek to worship individuals (such as a sorcerer-king) are seen as fools or worse, for no one not even a sorcerer-king can compare to the elements that shape the world.\n\n**Weapon Proficiencies** Members of this kit may select any weapons allowed to the priest class.\n\n**Nonweapon Proficiencies** Proficiencies for the element singers are as follows.\n* *Bonus Proficiencies* Survival (choice of terrain type depends on where the tribe spends most of its time and which element the singer is devoted to).\n* *Required Proficiencies* Healing, spellcraft, water find.\n* *Recommended (General)* Animal handling, artistic ability, dancing, direction sense, fire-building, heat protection, leatherworking, singing, weather sense.\n* *Recommended (Priest)* Ancient history, herbalism, musical instrument, reading/writing, religion, somatic concealment.\n\n**Equipment:** Element singers may use any equipment available to the priest class. They begin play with a bone weapon of excellent tribal make and a holy symbol dedicated to their element of choice.\n\n**Special Benefits** Element singers receive one bonus spell at each spell level. For example, if a 3rd-level singer would normally be entitled to two 1st-level spells, this special benefit gives him or her three 1st-level spells instead. This bonus applies to each spell level, but the bonus spells must be selected from the singers elemental sphere.\n\n**Special Hindrances** Element singers only receive only one initial weapon proficiency slot (instead of two). They must drop everything else they are doing to go to the aid of their tribe whenever they are needed.\n\n**Wealth Options** Element singers start play with 3d6x 30 cp as well as the items listed under Equipment above.",
            rawWikitext: "{{Sidebar EoA Ch5}}__NOTOC__\n==Element Singer==\nThe element singer is an elf cleric dedicated to a single elemental force of nature. Most tribes hold those who commune with the elements in awe and treat them with a small measure of fear. Elf tribes rarely have more than one or two element singers, though they will accept any number of lesser ritual dancers and battle dancers. Element singers are called by the element they worship—wind singer, flame singer, earth singer, or water singer.\n\nMost of the element singers that outsiders meet are young singers fulfilling their wanderlust as there is no place for them (currently) in their tribe. Others no longer have a tribe, or they are seeking a new tribe because they are compelled to worship an elemental force that is not the one revered by their tribe. A select few have been sent on some far-reaching mission by the force they worship.\n\nElement singers are the true clerics of the elf tribes. Each draws spells from the sphere of the cosmos as well as from the sphere associated with their element of choice. They fulfill roles as tribal clerics, and most have an extreme hatred of templars and defilers who draw power from landmarks associated with their revered element.\n\n'''Recommended Tribal Affiliation:''' All elf tribes have element singers, so they may have any tribal affiliation desired.\n\n'''Role:''' Element singers hold positions of leadership and responsibility in their tribes, though those they administer to do not quite know what to make of these clerics. Elves understand the magic of preservers and defilers, but have little knowledge of priestly magic. It frightens them, much as the raging elements frighten them. Those who commune with these terrible forces, therefore, become objects of fear, too. Still, the tribes realize they need the element singers, so they give them an awe-inspired respect. In many cases, the very survival of an elf tribe depends on its element singers.\n\nElement singers interpret the omens and portents inherent in the forces of nature. They advise tribal chiefs as to the best courses of action. They lead rites of passage and other tribal rituals. They heal the wounded and cure the sick. When element singers leave their tribes to explore the world of the outsiders, they take with them their beliefs, traditions, and devotions. These clerics are elves through and through—savage, unpredictable, living for each now.\n\nThough individual tribes tend to congregate toward a particular element, element singers are not intolerant of other faiths, as long as they are elemental in nature. Those who seek to worship individuals (such as a sorcerer-king) are seen as fools or worse, for no one not even a sorcerer-king can compare to the elements that shape the world.\n\n'''Weapon Proficiencies''' Members of this kit may select any weapons allowed to the priest class.\n\n'''Nonweapon Proficiencies''' Proficiencies for the element singers are as follows.\n* ''Bonus Proficiencies'' Survival (choice of terrain type depends on where the tribe spends most of its time and which element the singer is devoted to).\n* ''Required Proficiencies'' Healing, spellcraft, water find.\n* ''Recommended (General)'' Animal handling, artistic ability, dancing, direction sense, fire-building, heat protection, leatherworking, singing, weather sense.\n* ''Recommended (Priest)'' Ancient history, herbalism, musical instrument, reading/writing, religion, somatic concealment.\n\n'''Equipment:''' Element singers may use any equipment available to the priest class. They begin play with a bone weapon of excellent tribal make and a holy symbol dedicated to their element of choice.\n\n'''Special Benefits''' Element singers receive one bonus spell at each spell level. For example, if a 3rd-level singer would normally be entitled to two 1st-level spells, this special benefit gives him or her three 1st-level spells instead. This bonus applies to each spell level, but the bonus spells must be selected from the singers elemental sphere.\n\n'''Special Hindrances''' Element singers only receive only one initial weapon proficiency slot (instead of two). They must drop everything else they are doing to go to the aid of their tribe whenever they are needed.\n\n'''Wealth Options''' Element singers start play with 3d6x 30 cp as well as the items listed under Equipment above. \n{{Navbox Elves of Athas}}"
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
                notes: "Members of this kit may select any weapons allowed to the priest class"
            ),
            proficiencies: KitProficiencyRules(
                bonus: [],
                recommended: ["Animal handling", "artistic ability", "dancing", "direction sense", "fire-building", "heat protection", "leatherworking", "singing", "weather sense"],
                notes: "Survival (choice of terrain type depends on where the tribe spends most of its time and which element the singer is devoted to)."
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
            startingCash: "3d6x30"
        ),
        deity: nil,
        pantheon: nil,
        setting: nil,
        titleInChurch: nil
    )

let embeddedKit017: Kit = Kit(
        id: "fighting_monk",
        name: "Fighting-Monk",
        wikiPageTitle: "Fighting-Monk (Character Kit)",
        redirectAliases: [],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Any Priest",
            allowedClasses: ["Cleric", "Druid", "Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "In the campaign, this priest is the philosophical warrior whose principal duty is self-enlightenment. He is less concerned with the ordinary priestly duties (such as guidance, marriage, community service) than those priests, but will still perform them; he just won't go out of his way to look for them, nor will he normally volunteer for them (NPCs must ask his help in these matters). Such characters are usually wanderers, which help make them appropriate for adventuring parties. They do periodically return to their monasteries, to pass on the learning they have acquired on the road, and to brush up on their fighting-skills; the rest of the time they spend out in the world.",
            requirements: nil,
            specialBenefits: "The principal benefit of being a Fighting-Monk is that the character receives two free weapon proficiency slots which he must use to take Specialization in one of the three styles of Unarmed Combat (Punching, Wrestling, or Martial Arts). These were described in greater detail in ''The Complete Fighter's Handbook'', but that information also appears here, in the \"Equipment and Combat\" chapter. The Fighting-Monk is the only priest who can specialize in an Unarmed Combat style. He can specialize in any or all of the three styles, but he may only specialize in one of them at first experience level. As a second benefit, regardless of what it says for the priest's class, the Fighting-Monk has a Nonweapon Proficiency Group Crossover with all five Proficiency Groups (General, Priest, Rogue, Warrior, Wizard). No proficiency he takes will cost double the usual number of slots. The last of the Fighting-Monk's benefits is this: He doesn't have to spend all his starting Weapon Proficiency slots at first level. He can save his unspent proficiencies, and they do not \"go away.\" Later, he can spend them at a rate of one proficiency per experience level to improve his martial arts or buy new martial arts.",
            specialHindrances: "This priest cannot wear any sort of armor. Additionally, if he's a priest-class with Medium Combat Abilities, he must \"give up\" some of his Spheres of Influence. He may have no more than three Major Accesses (one of which must be All) and two Minor Accesses. The player may choose from the accesses he currently has which ones the character loses and which he keeps. Additionally, the priest may never own more things (weapons, treasure, money, etc.) than he can carry on his back.",
            wealthOptions: "The Fighting-Monk gets the usual 3d6x10 gp as starting money.",
            weaponProficiencies: "* Required: See under \"Special Benefits,\" below. Otherwise, the priest may take any weapon proficiencies which his specific priest class allows him; he may not take any the class does not allow him.",
            nonweaponProficiencies: "Bonus Proficiency: Tumbling. * Recommended: Riding (Land-Based), Artistic Ability (any), Dancing, Reading/Writing, Religion.",
            equipment: "See \"Special Hindrances,\" below."
        ),
        description: KitDescription(
            briefSummary: "This priest belongs to an order devoted in large part to the study of fighting styles, especially barehanded martial arts. These monks live and study in monasteries devoted to their orders.",
            fullText: "## Fighting-Monk\n**Description:** This priest belongs to an order devoted in large part to the study of fighting styles, especially barehanded martial arts. These monks live and study in monasteries devoted to their orders. If, for example, they are priests of the god of War, these monks do not live and study in ordinary temples of that god; they have their own secluded monastery away from the normal temples. \n\nThese monks do not confine their war-training to the monasteries, however. They travel the wide world in order to learn the secrets of life, the world, magic and the gods. As an order, they sometimes volunteer their services to rulers in times of war, and act as elite forces against the enemy.\n\nThese monks are most appropriate for an oriental-flavored campaign and the DM may wish to decide that they cannot be used in his campaign. Before you create a Fighting-Monk character, consult your DM and ask if he is allowing the Fighting-Monk kit in his campaign.\n\nIn order to be a fighting-monk, the character must have a Dexterity of 12 or more.\n\nIf a fighting-monk wants to abandon this kit, he must go through a difficult process in order to do so. He must not use any of his unarmed combat techniques for three whole experience levels' worth of time. Once he's reached that third experience level, he has forgotten his unarmed combat techniques and may resume the wearing of armor; and, if he renounced some of his spheres of influence when he became a fighting-monk, may now resume those lost spheres.\n\nAs an example, a fighting-monk priest at 5th level decides to renounce his allegiance to the fighting-monk order. He adventures normally, still not wearing armor but otherwise performing as a normal priest of his priest-class. He abstains from using his unarmed combat techniques. At 8th level, he has abandoned his fighting techniques and may once again wear the armor appropriate to his priest-class.\n\nIf a character forgets himself and uses unarmed combat techniques during this process, he must \"start over.\" It will be three experience levels from his *current* level, from the time he made the slip, until he can resume his priest-class.\n\n**Barred:** A priest of any priesthood which starts out with Poor Fighting Abilities is barred from this choice.\n\n**Role:** In the campaign, this priest is the philosophical warrior whose principal duty is self-enlightenment. He is less concerned with the ordinary priestly duties (such as guidance, marriage, community service) than those priests, but will still perform them; he just won't go out of his way to look for them, nor will he normally volunteer for them (NPCs must ask his help in these matters). Such characters are usually wanderers, which help make them appropriate for adventuring parties. They do periodically return to their monasteries, to pass on the learning they have acquired on the road, and to brush up on their fighting-skills; the rest of the time they spend out in the world.\n\n**Secondary Skills:** This priest may choose or random-roll his secondary skill, if you are using the secondary skills system in addition to the weapon/nonweapon proficiencies system.\n\n**Weapon Proficiencies:**\n* *Required:* See under \"Special Benefits,\" below. Otherwise, the priest may take any weapon proficiencies which his specific priest class allows him; he may not take any the class does not allow him.\n\n**Nonweapon Proficiencies:** Bonus Proficiency: Tumbling.\n* *Recommended:* Riding (Land-Based), Artistic Ability (any), Dancing, Reading/Writing, Religion.\n\n**Equipment:** See \"Special Hindrances,\" below.\n\n**Special Benefits:** The principal benefit of being a Fighting-Monk is that the character receives *two free weapon proficiency slots* which he must use to take Specialization in one of the three styles of Unarmed Combat (Punching, Wrestling, or Martial Arts). These were described in greater detail in *The Complete Fighter's Handbook*, but that information also appears here, in the \"Equipment and Combat\" chapter. The Fighting-Monk is the only priest who can specialize in an Unarmed Combat style. He can specialize in any or all of the three styles, but he may only specialize in one of them at first experience level.\n\nAs a second benefit, regardless of what it says for the priest's class, the Fighting-Monk has a Nonweapon Proficiency Group Crossover with *all five* Proficiency Groups (General, Priest, Rogue, Warrior, Wizard). No proficiency he takes will cost double the usual number of slots.\n\nThe last of the Fighting-Monk's benefits is this: He doesn't have to spend all his starting Weapon Proficiency slots at first level. He can save his unspent proficiencies, and they do not \"go away.\" Later, he can spend them at a rate of one proficiency per experience level to improve his martial arts or buy new martial arts.\n\n**Special Hindrances:** This priest cannot wear any sort of armor. Additionally, if he's a priest-class with Medium Combat Abilities, he must \"give up\" some of his Spheres of Influence. He may have no more than *three* Major Accesses (one of which must be All) and two Minor Accesses. The player may choose from the accesses he currently has which ones the character loses and which he keeps.\n\nAdditionally, the priest may never own more things (weapons, treasure, money, etc.) than he can carry on his back.\n\n**Wealth Options:** The Fighting-Monk gets the usual 3d6x10 gp as starting money.\n\n**Races:** No special limitations. Humans, elves and half-elves seem visually more suited to this kit than dwarves, gnomes, and halflings, but the DM can allow those races to take this kit if he so chooses.",
            rawWikitext: "{{Sidebar CPrH Ch4}}__NOTOC__\n==Fighting-Monk==\n'''Description:''' This priest belongs to an order devoted in large part to the study of fighting styles, especially barehanded martial arts. These monks live and study in monasteries devoted to their orders. If, for example, they are priests of the god of War, these monks do not live and study in ordinary temples of that god; they have their own secluded monastery away from the normal temples. \n\nThese monks do not confine their war-training to the monasteries, however. They travel the wide world in order to learn the secrets of life, the world, magic and the gods. As an order, they sometimes volunteer their services to rulers in times of war, and act as elite forces against the enemy.\n\nThese monks are most appropriate for an oriental-flavored campaign and the DM may wish to decide that they cannot be used in his campaign. Before you create a Fighting-Monk character, consult your DM and ask if he is allowing the Fighting-Monk kit in his campaign.\n\nIn order to be a fighting-monk, the character must have a Dexterity of 12 or more.\n\nIf a fighting-monk wants to abandon this kit, he must go through a difficult process in order to do so. He must not use any of his unarmed combat techniques for three whole experience levels' worth of time. Once he's reached that third experience level, he has forgotten his unarmed combat techniques and may resume the wearing of armor; and, if he renounced some of his spheres of influence when he became a fighting-monk, may now resume those lost spheres.\n\nAs an example, a fighting-monk priest at 5th level decides to renounce his allegiance to the fighting-monk order. He adventures normally, still not wearing armor but otherwise performing as a normal priest of his priest-class. He abstains from using his unarmed combat techniques. At 8th level, he has abandoned his fighting techniques and may once again wear the armor appropriate to his priest-class.\n\nIf a character forgets himself and uses unarmed combat techniques during this process, he must \"start over.\" It will be three experience levels from his ''current'' level, from the time he made the slip, until he can resume his priest-class.\n\n'''Barred:''' A priest of any priesthood which starts out with Poor Fighting Abilities is barred from this choice.\n\n'''Role:''' In the campaign, this priest is the philosophical warrior whose principal duty is self-enlightenment. He is less concerned with the ordinary priestly duties (such as guidance, marriage, community service) than those priests, but will still perform them; he just won't go out of his way to look for them, nor will he normally volunteer for them (NPCs must ask his help in these matters). Such characters are usually wanderers, which help make them appropriate for adventuring parties. They do periodically return to their monasteries, to pass on the learning they have acquired on the road, and to brush up on their fighting-skills; the rest of the time they spend out in the world.\n\n'''Secondary Skills:''' This priest may choose or random-roll his secondary skill, if you are using the secondary skills system in addition to the weapon/nonweapon proficiencies system.\n\n'''Weapon Proficiencies:'''\n* ''Required:'' See under \"Special Benefits,\" below. Otherwise, the priest may take any weapon proficiencies which his specific priest class allows him; he may not take any the class does not allow him.\n\n'''Nonweapon Proficiencies:''' Bonus Proficiency: Tumbling.\n* ''Recommended:'' Riding (Land-Based), Artistic Ability (any), Dancing, Reading/Writing, Religion.\n\n'''Equipment:''' See \"Special Hindrances,\" below.\n\n'''Special Benefits:''' The principal benefit of being a Fighting-Monk is that the character receives ''two free weapon proficiency slots'' which he must use to take Specialization in one of the three styles of Unarmed Combat (Punching, Wrestling, or Martial Arts). These were described in greater detail in ''The Complete Fighter's Handbook'', but that information also appears here, in the \"Equipment and Combat\" chapter. The Fighting-Monk is the only priest who can specialize in an Unarmed Combat style. He can specialize in any or all of the three styles, but he may only specialize in one of them at first experience level.\n\nAs a second benefit, regardless of what it says for the priest's class, the Fighting-Monk has a Nonweapon Proficiency Group Crossover with ''all five'' Proficiency Groups (General, Priest, Rogue, Warrior, Wizard). No proficiency he takes will cost double the usual number of slots.\n\nThe last of the Fighting-Monk's benefits is this: He doesn't have to spend all his starting Weapon Proficiency slots at first level. He can save his unspent proficiencies, and they do not \"go away.\" Later, he can spend them at a rate of one proficiency per experience level to improve his martial arts or buy new martial arts.\n\n'''Special Hindrances:''' This priest cannot wear any sort of armor. Additionally, if he's a priest-class with Medium Combat Abilities, he must \"give up\" some of his Spheres of Influence. He may have no more than ''three'' Major Accesses (one of which must be All) and two Minor Accesses. The player may choose from the accesses he currently has which ones the character loses and which he keeps.\n\nAdditionally, the priest may never own more things (weapons, treasure, money, etc.) than he can carry on his back.\n\n'''Wealth Options:''' The Fighting-Monk gets the usual 3d6x10 gp as starting money.\n\n'''Races:''' No special limitations. Humans, elves and half-elves seem visually more suited to this kit than dwarves, gnomes, and halflings, but the DM can allow those races to take this kit if he so chooses.\n\n{{Navbox The Complete Priest's Handbook}}\n[[Category:Character Kit]]\n[[Category:Character Kit CPrH]]"
        ),
        categories: ["Character Kit", "Character Kit CPrH"],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Dexterity": 12],
                alignments: [],
                races: nil
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: "* Required: See under \"Special Benefits,\" below. Otherwise, the priest may take any weapon proficiencies which his specific priest class allows him; he may not take any the class does not allow him."
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Proficiency: Tumbling"],
                recommended: ["Riding", "Artistic Ability", "Dancing", "Reading/Writing", "Religion"],
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

let embeddedKit018: Kit = Kit(
        id: "gond_holy_builder",
        name: "Gond - Holy Builder",
        wikiPageTitle: "Gond - Holy Builder (Character Kit)",
        redirectAliases: ["Priests of Gond (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Priest's Handbook",
        features: KitFeatures(
            role: "Gond is the god of inventions and artificers, and he has created a special brotherhood of priests called the holy builders. These priests excel in repairing broken things, improving existing designs, and inventing new items and constructs. Sometimes, should Gond be willing, the new inventions even work!",
            requirements: "Intelligence 12, Wisdom 9",
            specialBenefits: "Holy builders take half the time as normal to repair or build anything, including weapons and armor. The following nonweapon proficiencies cost only one slot for holy warriors to purchase or improve: armorer, bowyer/fletcher, engineering, set snares, and weaponsmithing. Also, they gain a +2 bonus when using the proficiencies of armorer, blacksmithing, carpentry, engineering, stonemasonry, and weaponsmithing.",
            specialHindrances: "Holy builders cannot turn undead. Furthermore, they are so constantly distracted by devices around them that they suffer a +2 penalty to their initiative rolls. : ''\"A clergy of tinkerers, they are most annoying indeed! One even disassembled my lute without my say-so, then rebuilt it, claiming that it was improved. When I strummed it, the chord shattered an inn's windows! :: -Mendryll Belarod''",
            wealthOptions: "3d6",
            weaponProficiencies: "2",
            nonweaponProficiencies: "Blacksmithing, carpentry, engineering",
            equipment: nil
        ),
        description: KitDescription(
            briefSummary: "Gond is the god of inventions and artificers, and he has created a special brotherhood of priests called the holy builders. These priests excel in repairing broken things, improving existing designs, and inventing new items and constructs. Sometimes, should Gond be willing, the new inventions even work!",
            fullText: "{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| **Racial Requirements** || Any except elf\n|-\n| **Ability Requirements** || Intelligence 12,Wisdom 9\n|-\n| **Prime Requisite** || Wisdom\n|-\n| **Hit Die Type** || d8\n|-\n| **Attack as** || Priest\n|-\n| **Save as** || Priest\n|-\n| **Advance as** || Priest\n|-\n| **Spell Ability?** || Yes\n|-\n| **Exceptional Strength?** || No\n|-\n| **Exceptional Constitution?** || No\n|-\n| **Starting Cash (x10 gp)** || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| **Weapon Slots** || 2\n|-\n| **Additional Slot** || 4\n|-\n| **Nonproficiency Penalty** || -3\n|-\n| **Nonweapon Slots** || 4\n|-\n| **Additional Slot** || 3\n|-\n| **Available Categories** || General, Priest\n|-\n| **Bonus Proficiencies** || Blacksmithing, carpentry, engineering\n|-\n| **Recommended Proficiencies** || Reading/writing\n|}\n## Overview\nGond is the god of inventions and artificers, and he has created a special brotherhood of priests called the holy builders. These priests excel in repairing broken things, improving existing designs, and inventing new items and constructs. Sometimes, should Gond be willing, the new inventions even work!\n\n## Description\nHoly builders of Gond are hardly what one would expect a priest. to look like. Most holy builders wear leather aprons and clothes of dark colors, making it easier to hide the inevitable grease stains, tears, and scorch marks. Many also have numerous quills, rulers, and hastily scribbled notes on bits of paper or parchment sticking out of their many pockets. If not for Gond's holy symbol of a cog wheel showing prominently on their persons, very few people in the Realms would have any idea that these unkempt people were priests.\n\nMost people look at a device and wonder how to operate it. Holy builders look at the same device and wonder what it can do, how well-built it is, and how can it be improved beyond its initial design. Holy builders love spending their time drawing up designs, taking apart existing devices, and tinkering with anything constructed artificially. When holy builders enter a village or place they have never been before, they cheerfully start right in on repair work that they believe needs doing.\n\nMany holy builders enjoy discussions with secular builders from outside of Gond's temples. One of their great joys is in exchanging ideas and comparing notes. They are so absorbed in doing this that they often times forget to preach Gond's faith to unbelievers. Gond, however, doesn't mind, since the deity sees all acts of building and construction as worship for him.\n\nUnfortunately, holy builders are easily distracted from life-or-death matters by the simple presence of a unique device, gadget, or construct. Rather than cast a spell to wreck an invader's catapult, a holy builder would rather stare at it, taking it apart and putting it together in his mind, mulling over possible improvements, and admiring its craftsmanship.\n\n## Special Abilities\nHoly builders take half the time as normal to repair or build anything, including weapons and armor.\n\nThe following nonweapon proficiencies cost only one slot for holy warriors to purchase or improve: armorer, bowyer/fletcher, engineering, set snares, and weaponsmithing. Also, they gain a +2 bonus when using the proficiencies of armorer, blacksmithing, carpentry, engineering, stonemasonry, and weaponsmithing.\n\n## Special Disadvantages\nHoly builders cannot turn undead. Furthermore, they are so constantly distracted by devices around them that they suffer a +2 penalty to their initiative rolls.\n\n: *\"A clergy of tinkerers, they are most annoying indeed! One even disassembled my lute without my say-so, then rebuilt it, claiming that it was improved. When I strummed it, the chord shattered an inn's windows!*\n\n:: *-Mendryll Belarod*",
            rawWikitext: "{{Sidebar WPR Ch2}}\n{| class=\"article-table\"\n! colspan=\"2\" | Class Information\n|-\n| '''Racial Requirements''' || Any except elf\n|-\n| '''Ability Requirements''' || [[Intelligence]] 12,{{br}}[[Wisdom]] 9\n|-\n| '''Prime Requisite''' || Wisdom\n|-\n| '''Hit Die Type''' || d8\n|-\n| '''Attack as''' || Priest\n|-\n| '''Save as''' || Priest\n|-\n| '''Advance as''' || Priest\n|-\n| '''Spell Ability?''' || Yes\n|-\n| '''Exceptional Strength?''' || No\n|-\n| '''Exceptional Constitution?''' || No\n|-\n| '''Starting Cash (x10 gp)''' || 3d6\n|-\n! colspan=\"2\" | Proficiencies\n|-\n| '''Weapon Slots''' || 2\n|-\n| '''Additional Slot''' || 4\n|-\n| '''Nonproficiency Penalty''' || -3\n|-\n| '''Nonweapon Slots''' || 4\n|-\n| '''Additional Slot''' || 3\n|-\n| '''Available Categories''' || General, Priest\n|-\n| '''Bonus Proficiencies''' || [[Blacksmithing (Proficiency)|Blacksmithing]], [[Carpentry (Proficiency)|carpentry]], [[Engineering (Proficiency)|engineering]]\n|-\n| '''Recommended Proficiencies''' || [[Reading/Writing (Proficiency)|Reading/writing]]\n|}__TOC__\n==Overview==\nGond is the god of inventions and artificers, and he has created a special brotherhood of priests called the holy builders. These priests excel in repairing broken things, improving existing designs, and inventing new items and constructs. Sometimes, should Gond be willing, the new inventions even work!\n\n==Description==\nHoly builders of Gond are hardly what one would expect a priest. to look like. Most holy builders wear leather aprons and clothes of dark colors, making it easier to hide the inevitable grease stains, tears, and scorch marks. Many also have numerous quills, rulers, and hastily scribbled notes on bits of paper or parchment sticking out of their many pockets. If not for Gond's holy symbol of a cog wheel showing prominently on their persons, very few people in the Realms would have any idea that these unkempt people were priests.\n\nMost people look at a device and wonder how to operate it. Holy builders look at the same device and wonder what it can do, how well-built it is, and how can it be improved beyond its initial design. Holy builders love spending their time drawing up designs, taking apart existing devices, and tinkering with anything constructed artificially. When holy builders enter a village or place they have never been before, they cheerfully start right in on repair work that they believe needs doing.\n\nMany holy builders enjoy discussions with secular builders from outside of Gond's temples. One of their great joys is in exchanging ideas and comparing notes. They are so absorbed in doing this that they often times forget to preach Gond's faith to unbelievers. Gond, however, doesn't mind, since the deity sees all acts of building and construction as worship for him.\n\nUnfortunately, holy builders are easily distracted from life-or-death matters by the simple presence of a unique device, gadget, or construct. Rather than cast a spell to wreck an invader's catapult, a holy builder would rather stare at it, taking it apart and putting it together in his mind, mulling over possible improvements, and admiring its craftsmanship.\n\n==Special Abilities==\nHoly builders take half the time as normal to repair or build anything, including weapons and armor.\n\nThe following nonweapon proficiencies cost only one slot for holy warriors to purchase or improve: [[Armorer (Proficiency)|armorer]], [[Bowyer/Fletcher (Proficiency)|bowyer/fletcher]], [[Engineering (Proficiency)|engineering]], [[Set Snares (Proficiency)|set snares]], and [[Weaponsmithing (Proficiency)|weaponsmithing]]. Also, they gain a +2 bonus when using the proficiencies of [[Armorer (Proficiency)|armorer]], [[Blacksmithing (Proficiency)|blacksmithing]], [[Carpentry (Proficiency)|carpentry]], [[Engineering (Proficiency)|engineering]], [[Stonemasonry (Proficiency)|stonemasonry]], and [[Weaponsmithing (Proficiency)|weaponsmithing]].\n\n==Special Disadvantages==\nHoly builders cannot turn undead. Furthermore, they are so constantly distracted by devices around them that they suffer a +2 penalty to their initiative rolls.\n\n: ''\"A clergy of tinkerers, they are most annoying indeed! One even disassembled my lute without my say-so, then rebuilt it, claiming that it was improved. When I strummed it, the chord shattered an inn's windows!''\n\n:: ''-Mendryll Belarod''\n\n{{Navbox Warriors & Priests of the Realms}}"
        ),
        categories: [],
        mechanics: KitMechanics(
            requirements: KitRequirements(
                abilities: ["Intelligence": 12, "Wisdom": 9],
                alignments: [],
                races: "Any except elf"
            ),
            weapons: KitWeaponRules(
                required: [],
                recommended: [],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["Blacksmithing", "carpentry", "engineering"],
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
                capable: false,
                mode: "forbidden",
                notes: "Holy builders cannot turn undead"
            ),
            startingCash: "3d6x10 gp"
        ),
        deity: "Gond",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Holy Builder"
    )

let embeddedKit019: Kit = Kit(
        id: "guardian_druid",
        name: "Guardian - Druid",
        wikiPageTitle: "Guardian - Druid (Character Kit)",
        redirectAliases: ["Guardian (Character Kit)"],
        classEligibility: KitClassEligibility(
            classGroup: "Priest",
            subclass: "Specialty Priest",
            allowedClasses: ["Specialty Priest"]
        ),
        sourceBook: "The Complete Druid's Handbook",
        features: KitFeatures(
            role: "A Guardian lives deep in the wilderness, away from humanity. Like most Guardians, Wazir normally feels wary of strangers, suspecting that they come to exploit or threaten the site he defends. Some Guardians can become fiercely protective: If Wazir were to witness the near-extinction of a particular species of plant or animal, the last few examples of which now live only in his grove, he could grow into an angry and ruthless protector. Such druids may strike out without warning to frighten off or kill intruders or even may make pacts with local monsters to protect the grove. Other Guardians are simply shy hermits who welcome good-intentioned visitors. Perhaps Wazir lives as a lonely, dedicated sentinel; he misses human contact, but his strong sense of duty prevents him from leaving his post undefended. Frequently, a Guardian goes years without seeing another human; Wazir may have as his only friends just the animal or nonhuman residents of his protectorate. As a result, he may seem eccentric or awkward relating to humans—even other druids.",
            requirements: nil,
            specialBenefits: "The druid receives a +1 bonus on saving throws and attack rolls when fighting to protect his guardianship. Enemies suffer a -2 penalty to saving throws while they remain in this protectorate. As a Guardian, Wazir receives the respect of other druids (+1 reaction adjustment) in his circle. (See Chapter 3: The Druidic Order for more on circles.) Although not all Guardians serve as warders of sacred or magical groves, some receive this responsibility. (For details on these special sites, see Chapter 6: Sacred Groves.) A low-level druid character should watch over a grove with no more than one lesser power. In addition, the DM must come up with a good reason why a magical grove falls into the hands of a low-level druid; perhaps the original Guardian, the PC's mentor, met with an unexpected fate while still grooming the character to take over. Whenever a grove has any special abilities, the DM always should take care to limit the power they give the druid. For instance, a grove containing a magical pear tree with unique golden-hued fruit that gives the eater the effect of a treasure finding potion could unbalance a campaign. Perhaps the tree produces only one such magical pear a year—the remaining fruit is normal, although exceptionally succulent. When the special fruit ripens, the druid must turn it over to a messenger from the great druid.",
            specialHindrances: "The druid needs to guard a site containing something others eventually will want. The DM should encourage the player to have the character devote some time to defending the place, setting up magical or normal traps, checking with animal spies, and so on. If the druid, such as Wazir, fails in his guardianship, he becomes seriously depressed. He suffers a -1 penalty on all attack rolls, saving throws, and ability and proficiency checks until he recovers from his loss. He also loses standing in the Order (-2 reaction penalty from other druids in the region, instead of the previous +1 bonus). Wazir cannot recover from this depression until 1d4+1 years pass and he performs some action to atone for his failure. For instance, if a dragon destroyed the ancient stand of elder trees Wazir guarded, he must either defeat the dragon or find a way to restore the forest to life.",
            wealthOptions: "3d6x10 gp.",
            weaponProficiencies: "Recommended—staff.",
            nonweaponProficiencies: "* Bonus—local history (of his guardianship). * Recommended— (priest) herbalism, ancient history, religion; (warrior) animal lore, set snares.",
            equipment: "The druid should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp."
        ),
        description: KitDescription(
            briefSummary: "Some druids establish themselves as the guardians of a particular place—the habitat of an endangered species, a stand of ancient trees, the lair of a dryad, or a sacred grove. Often the druid watches over a sacred grove with magical powers that others try to exploit for selfish or evil purposes.",
            fullText: "## Guardian\n\nSome druids establish themselves as the guardians of a particular place—the habitat of an endangered species, a stand of ancient trees, the lair of a dryad, or a sacred grove. Often the druid watches over a sacred grove with magical powers that others try to exploit for selfish or evil purposes.\n\nThe DM should decide the extent of the Guardian's responsibility—usually one druid protects no more than a few acres of wilderness—and establish why the area needs special druidic attention. For instance, a mountaintop might serve as the nesting place of a rare breed of hawks prized by nobles as hunting falcons, forcing the druid to continually guard against those who want to steal the chicks or eggs.\n\nA druid with the Guardian kit may act as the protector of several places in a lifetime. Say the druidic order places Wazir, a low-level Guardian druid, in charge of a nonmagical grove. If he fulfills his charge (and rises to at least 3rd level), the Order may grant him the responsibility of a magical grove, while a lower-level druid takes over his old position.\n\nIn order to abandon this kit, a Guardian like Wazir has to find someone else (usually a druid of similar level) to take over his guardianship. He must abandon the kit involuntarily if someone destroys or irreparably desecrates his grove. In this case, the Guardian might become a Lost Druid or devote his life to revenge as an Avenger.\n\n**Role:** A Guardian lives deep in the wilderness, away from humanity. Like most Guardians, Wazir normally feels wary of strangers, suspecting that they come to exploit or threaten the site he defends.\n\nSome Guardians can become fiercely protective: If Wazir were to witness the near-extinction of a particular species of plant or animal, the last few examples of which now live only in his grove, he could grow into an angry and ruthless protector. Such druids may strike out without warning to frighten off or kill intruders or even may make pacts with local monsters to protect the grove.\n\nOther Guardians are simply shy hermits who welcome good-intentioned visitors. Perhaps Wazir lives as a lonely, dedicated sentinel; he misses human contact, but his strong sense of duty prevents him from leaving his post undefended.\n\nFrequently, a Guardian goes years without seeing another human; Wazir may have as his only friends just the animal or nonhuman residents of his protectorate. As a result, he may seem eccentric or awkward relating to humans—even other druids.\n\n**Branch Restrictions:** None.\n\n**Weapon Proficiencies:** Recommended—staff.\n\n**Secondary Skills:** Hunter.\n\n**Nonweapon Proficiencies:**\n* *Bonus*—local history (of his guardianship).\n* *Recommended*— (priest) herbalism, ancient history, religion; (warrior) animal lore, set snares.\n\n**Equipment:** The druid should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp.\n\n**Special Benefits:** The druid receives a +1 bonus on saving throws and attack rolls when fighting to protect his guardianship. Enemies suffer a -2 penalty to saving throws while they remain in this protectorate.\n\nAs a Guardian, Wazir receives the respect of other druids (+1 reaction adjustment) in his circle. (See Chapter 3: The Druidic Order for more on circles.)\n\nAlthough not all Guardians serve as warders of sacred or magical groves, some receive this responsibility. (For details on these special sites, see Chapter 6: Sacred Groves.) A low-level druid character should watch over a grove with no more than one lesser power. In addition, the DM must come up with a good reason why a magical grove falls into the hands of a low-level druid; perhaps the original Guardian, the PC's mentor, met with an unexpected fate while still grooming the character to take over.\n\nWhenever a grove has any special abilities, the DM always should take care to limit the power they give the druid. For instance, a grove containing a magical pear tree with unique golden-hued fruit that gives the eater the effect of a *treasure finding* potion could unbalance a campaign. Perhaps the tree produces only one such magical pear a year—the remaining fruit is normal, although exceptionally succulent. When the special fruit ripens, the druid must turn it over to a messenger from the great druid.\n\n**Special Hindrances:** The druid needs to guard a site containing something others eventually will want. The DM should encourage the player to have the character devote some time to defending the place, setting up magical or normal traps, checking with animal spies, and so on.\n\nIf the druid, such as Wazir, fails in his guardianship, he becomes seriously depressed. He suffers a -1 penalty on all attack rolls, saving throws, and ability and proficiency checks until he recovers from his loss. He also loses standing in the Order (-2 reaction penalty from other druids in the region, instead of the previous +1 bonus). Wazir cannot recover from this depression until 1d4+1 years pass *and* he performs some action to atone for his failure.\n\nFor instance, if a dragon destroyed the ancient stand of elder trees Wazir guarded, he must either defeat the dragon or find a way to restore the forest to life.\n\n**Wealth Options:** 3d6x10 gp.",
            rawWikitext: "{{See also|Guardian - Ranger (Character Kit)|Guardian (Wizard Spell)}}\n==Guardian==\n{{Sidebar CDH Ch2}}__NOTOC__\nSome druids establish themselves as the guardians of a particular place—the habitat of an endangered species, a stand of ancient trees, the lair of a dryad, or a sacred grove. Often the druid watches over a sacred grove with magical powers that others try to exploit for selfish or evil purposes.\n\nThe DM should decide the extent of the Guardian's responsibility—usually one druid protects no more than a few acres of wilderness—and establish why the area needs special druidic attention. For instance, a mountaintop might serve as the nesting place of a rare breed of hawks prized by nobles as hunting falcons, forcing the druid to continually guard against those who want to steal the chicks or eggs.\n\nA druid with the Guardian kit may act as the protector of several places in a lifetime. Say the druidic order places Wazir, a low-level Guardian druid, in charge of a nonmagical grove. If he fulfills his charge (and rises to at least 3rd level), the Order may grant him the responsibility of a magical grove, while a lower-level druid takes over his old position.\n\nIn order to abandon this kit, a Guardian like Wazir has to find someone else (usually a druid of similar level) to take over his guardianship. He must abandon the kit involuntarily if someone destroys or irreparably desecrates his grove. In this case, the Guardian might become a Lost Druid or devote his life to revenge as an Avenger.\n\n'''Role:''' A Guardian lives deep in the wilderness, away from humanity. Like most Guardians, Wazir normally feels wary of strangers, suspecting that they come to exploit or threaten the site he defends.\n\nSome Guardians can become fiercely protective: If Wazir were to witness the near-extinction of a particular species of plant or animal, the last few examples of which now live only in his grove, he could grow into an angry and ruthless protector. Such druids may strike out without warning to frighten off or kill intruders or even may make pacts with local monsters to protect the grove.\n\nOther Guardians are simply shy hermits who welcome good-intentioned visitors. Perhaps Wazir lives as a lonely, dedicated sentinel; he misses human contact, but his strong sense of duty prevents him from leaving his post undefended.\n\nFrequently, a Guardian goes years without seeing another human; Wazir may have as his only friends just the animal or nonhuman residents of his protectorate. As a result, he may seem eccentric or awkward relating to humans—even other druids.\n\n'''Branch Restrictions:''' None.\n\n'''Weapon Proficiencies:''' Recommended—staff.\n\n'''Secondary Skills:''' Hunter.\n\n'''Nonweapon Proficiencies:'''\n* ''Bonus''—[[Local History (Proficiency)|local history]] (of his guardianship).\n* ''Recommended''— (priest) [[Herbalism (Proficiency)|herbalism]], [[Ancient History (Proficiency)|ancient history]], [[Religion (Proficiency)|religion]]; (warrior) [[Animal Lore (Proficiency)|animal lore]], [[Set Snares (Proficiency)|set snares]].\n\n'''Equipment:''' The druid should spend his initial allotment of gold pieces entirely on equipment, as he loses any unspent starting money in excess of 1 gp.\n\n'''Special Benefits:''' The druid receives a +1 bonus on saving throws and attack rolls when fighting to protect his guardianship. Enemies suffer a -2 penalty to saving throws while they remain in this protectorate.\n\nAs a Guardian, Wazir receives the respect of other druids (+1 reaction adjustment) in his circle. (See Chapter 3: The Druidic Order for more on circles.)\n\nAlthough not all Guardians serve as warders of sacred or magical groves, some receive this responsibility. (For details on these special sites, see Chapter 6: Sacred Groves.) A low-level druid character should watch over a grove with no more than one lesser power. In addition, the DM must come up with a good reason why a magical grove falls into the hands of a low-level druid; perhaps the original Guardian, the PC's mentor, met with an unexpected fate while still grooming the character to take over.\n\nWhenever a grove has any special abilities, the DM always should take care to limit the power they give the druid. For instance, a grove containing a magical pear tree with unique golden-hued fruit that gives the eater the effect of a ''treasure finding'' potion could unbalance a campaign. Perhaps the tree produces only one such magical pear a year—the remaining fruit is normal, although exceptionally succulent. When the special fruit ripens, the druid must turn it over to a messenger from the great druid.\n\n'''Special Hindrances:''' The druid needs to guard a site containing something others eventually will want. The DM should encourage the player to have the character devote some time to defending the place, setting up magical or normal traps, checking with animal spies, and so on.\n\nIf the druid, such as Wazir, fails in his guardianship, he becomes seriously depressed. He suffers a -1 penalty on all attack rolls, saving throws, and ability and proficiency checks until he recovers from his loss. He also loses standing in the Order (-2 reaction penalty from other druids in the region, instead of the previous +1 bonus). Wazir cannot recover from this depression until 1d4+1 years pass ''and'' he performs some action to atone for his failure.\n\nFor instance, if a dragon destroyed the ancient stand of elder trees Wazir guarded, he must either defeat the dragon or find a way to restore the forest to life.\n\n'''Wealth Options:''' 3d6x10 gp.\n\n{{Navbox The Complete Druid's Handbook}}"
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
                recommended: ["staff"],
                forbidden: [],
                notes: nil
            ),
            proficiencies: KitProficiencyRules(
                bonus: ["local history "],
                recommended: ["herbalism", "ancient history", "religion", "animal lore", "set snares"],
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
        deity: "Guardian",
        pantheon: "Faerûnian",
        setting: "Forgotten Realms",
        titleInChurch: "Druid"
    )
