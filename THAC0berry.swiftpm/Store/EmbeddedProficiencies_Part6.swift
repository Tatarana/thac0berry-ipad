import Foundation

/// Parte 6 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency0600: Proficiency = Proficiency(
    id: "clothesmaking_crude",
    name: "Clothesmaking, Crude",
    wikiPageTitle: "Clothesmaking, Crude (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency enables a character to create simple garments from furs, skins, leaves, and other natural materials. Although crude clothing isn't attractive or stylish, it's generally comfortable and functional.",
        fullText: "This proficiency enables a character to create simple garments from furs, skins, leaves, and other natural materials. Although crude clothing isn't attractive or stylish, it's generally comfortable and functional. Fur cloaks, grass skirts, and hide loincloths are typical examples. (See Chapter 5 for more about primitive clothing.)\n\nCrossover Group: General."
    )
)

let embeddedProficiency0601: Proficiency = Proficiency(
    id: "cobbling",
    name: "Cobbling",
    wikiPageTitle: "Cobbling (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Dexterity/Aim, Intelligence/Knowledge",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character can fashion and repair shoes, boots, and sandals.",
        fullText: "## Player's Handbook\n\nThe character can fashion and repair shoes, boots, and sandals.\n\n## Player's Option: Skills & Powers\n\nA character with this skill can make shoes, boots, and sandals. No checks are normally required, but if the character attempts a field repair of damaged footwear, or tries to fashion shoes from wood or leather that has been scrounged up, a successful check is needed."
    )
)

let embeddedProficiency0602: Proficiency = Proficiency(
    id: "concentration",
    name: "Concentration",
    wikiPageTitle: "Concentration (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Concentration: A character with this talent has rigorously trained himself to ignore distractions of all kinds, deadening his mind to pain or sensation.",
        fullText: "Concentration: A character with this talent has rigorously trained himself to ignore distractions of all kinds, deadening his mind to pain or sensation. This allows a wizard to ignore annoyances or disturbances that might otherwise interfere with the casting of a spell. In order to use this ability, the player must state that his character is concentrating when he begins to cast a spell. If the character is struck by an attack that causes 2 or less points of damage, he is permitted to attempt a proficiency check to ignore the distraction and continue to cast his spell (unless, of course, the damage is enough to render him unconscious.) The wizard can try to ignore grappling or restraining attacks that cause no damage but suffers a –4 penalty to his check. Spells that incapacitate without damaging, such as hold person or command, still interrupt the caster if he fails his saving throw.\n\nA character using this ability must focus on the casting of his spell to the exclusion of all other activity, even direct attacks. Any Dexterity adjustment to his Armor Class is lost, and in addition flank or side attacks are treated as rear attacks, with a +2 bonus to hit instead of a +1."
    )
)

let embeddedProficiency0603: Proficiency = Proficiency(
    id: "concocting",
    name: "Concocting",
    wikiPageTitle: "Concocting (Proficiency)",
    redirectAliases: ["SNS Table 5"],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Special (The Apothecary (SNS) Only)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency enables the character to concoct chemical compounds with specific uses-such as medicines and poisons. It also allows the apothecary to identify various materials-including magical consumables (potions, salves, lotions, and so on).",
        fullText: "## Concocting\n\nThis proficiency enables the character to concoct chemical compounds with specific uses-such as medicines and poisons. It also allows the apothecary to identify various materials-including magical consumables (potions, salves, lotions, and so on).\n\nThis identification is nonmagical in nature. The apothecary can determine only the general nature of the material (for example, this is a poison, this is a healing potion) and not its strength or duration. The identification process is quite long; it takes the apothecary 1d6 hours to identify nonmagical mixtures and 2d12 hours to identify magical potions and such.\n\nIn addition, the materials required for each accurate identification are quite expensive (at least one-tenth of the item's XP value). This is why most apothecaries charge a great deal of money to identify potions and other mixtures.\n\nIf the apothecary rolls a 1 when trying to concoct something, he manages to create a particularly potent brew. A potent concoction has double its normal duration. Alternately, the DM can increase its effectiveness in some other way. However, increasing a potion's strength by more than half is not recommended.\n\nIf the apothecary rolls a 20 when concocting something, he critically fails to create his intended mixture. Because of the extremely volatile nature of the apothecary's chemicals, a critical concoction failure can be quite dangerous. When an apothecary makes such a spectacular failure, the DM should roll another 20-sided die and consult the Eureka Table for the results. Smart apothecaries always identify the results of a failed concoction before tossing it out, as some of the most important concoctions have been discovered by mis take.\n\n{| class=\"article-table\"\n|+ Table 5: Eureka Table\n! Die Roll || Result\n|-\n| 1-2 || Magical Discovery: Roll once on the potion tables in the DMG\n|-\n| 3-4 || Mundane Discovery: The apothecary creates a known mixture\n|-\n| 5-9 || Disappointment: The concoction is useless.\n|-\n| 10-13 || Holy Smokes! A noxious cloud hovers around the apothecary's house for 1d4 days.\n|-\n| 4-16 || Flashftre: The resultant chemical flash blinds the apothecary for 1d4 days.\n|-\n| 17 || Chemical Bum: The apothecary takes 1d8 points of damage and loses the use of his hand for 1d6 days.\n|-\n| 18-19 || Minor Explosion: The apothecary's lab takes 1,000 gp worth of damage and the apothecary suffers 2d6 points of damage.\n|-\n| 20 || Major Explosion: The apothecary takes 4d6 points of damage and his lab is completely destroyed.\n|}"
    )
)

let embeddedProficiency0604: Proficiency = Proficiency(
    id: "contact",
    name: "Contact",
    wikiPageTitle: "Contact (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Not a proficiency in the Psionics Handbook.",
        fullText: "## Complete Psionics Handbook\n\nNot a proficiency in the Psionics Handbook.\n\n## Player's Option: Skills & Powers\n\nContact: This proficiency gives characters access to the psionic attack forms necessary to open a closed mind. Contact allows characters to gain psionic attacks as they become available with level advancement.\n\nPsionicists automatically receive this proficiency. It doesn't take up any of their available slots. As a psionicist increases in level, he automatically receives psionic attack forms as outlined on the Psionic Progression table. Psionic attack forms don't fill up a psionicist's proficiency slots.\n\nWild talents, on the other hand, must select contact and place it in an available nonweapon proficiency slot if they want to gain its benefits. Once contact is slotted, a wild talent selects one psionic attack. He may select an additional attack by placing it in an available nonweapon slot after he has advanced the appropriate number of levels, according to his group's progression rate. Wild talents may never have more than three of the five psionic attack forms.\n\n## Dark Sun Campaign Setting Revised\n\nContact is a proficiency that functions for psionicists and psionic wild talents. Psionicist PCs receive contact as a bonus proficiency, while wild talents must spend an available nonweapon proficiency slot to receive it. For full details on the uses and benefits of this proficiency, see The Way of the Psionicist book."
    )
)

let embeddedProficiency0605: Proficiency = Proficiency(
    id: "cooking",
    name: "Cooking",
    wikiPageTitle: "Cooking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Reason",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "Although all characters have rudimentary cooking skills, the character with this proficiency is an accomplished cook. A proficiency check is required only when attempting to prepare a truly magnificent meal worthy of a master chef.",
        fullText: "## Player's Handbook\n\nAlthough all characters have rudimentary cooking skills, the character with this proficiency is an accomplished cook. A proficiency check is required only when attempting to prepare a truly magnificent meal worthy of a master chef.\n\n## Player's Option: Skills & Powers\n\nThis character knows the basics of food preparation, and he can generally cook, bake, fry, and so forth without a proficiency check. Checks are required if the character attempts to prepare truly gourmet meals, or tries to make a palatable dinner out of unpalatable ingredients—grubs, roots, and bark, for example."
    )
)

let embeddedProficiency0606: Proficiency = Proficiency(
    id: "craft_instrument",
    name: "Craft Instrument",
    wikiPageTitle: "Craft Instrument (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Dexterity",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Those who take this proficiency must specify whether they are skilled at crafting wind, stringed, percussion, or keyboard instruments. It takes an additional proficiency slot to gain one of the other skills.",
        fullText: "## The Complete Bard's Handbook\n\nThose who take this proficiency must specify whether they are skilled at crafting wind, stringed, percussion, or keyboard instruments. It takes an additional proficiency slot to gain one of the other skills. Three additional slots allow the character to take the title \"master craftsman\" as he is able to craft instruments of all forms.\n\nA craftsman must buy materials equal to a quarter of the instrument's sale value. It then takes 1d6 days to craft a wind or percussion instrument, 2d8 days to form a stringed instrument, and 3d10 days to create a keyboard instrument. These times assume that the craftsman is spending 10 hours a day working on the instrument. If craftsman tools (cost 25 gp, weight 5 pounds) are not available, all times are doubled.\n\nThe quality of an instrument is determined by a final proficiency check. Failure results in an instrument of poor quality, while success indicates good quality. A natural 20 indicates that the instrument is nonfunctional, while a natural 1 results in a masterpiece worth twice the normal value.\n\nSimple repairs take only 1d4 hours and require no proficiency check unless the proper tools are not available. However, repairing severe damage requires 1d8 hours and a check is mandatory for success.\n\n## The Complete Book of Humanoids\n\nCharacters with this proficiency must state which type of instrument they are skilled at crafting: wind, stringed, percussion, or keyboard. A slot must be used to gain each additional type of instrument the character wishes to be skilled at crafting. A total of four slots used in this proficiency grants a character the title of \"master craftsman\" who can craft instruments of all forms.\n\nCharacters must buy material equal to one quarter of the instrument's sale value. Wind and percussion instruments require 1d6 days of crafting, stringed instruments 2d8 days, and keyboard instruments 3d1O days. Each day of work requires 10 full hours spent crafting the instrument. If craftsman tools (cost 25 gp, weight 5 pounds) are not available, all times are doubled.\n\nThe crafted instrument's quality is determined by a final proficiency check. A failed check creates an instrument of poor quality, while a success indicates good quality. A natural 20 indicates that the instrument does not work, while a natural 1 produces a masterpiece worth twice its normal value.\n\nSimple repairs to instruments take only 1d4 hours and require no checks unless the proper tools are not available. Repairing severe damage requires 1d8 hours, and a successful proficiency check is necessary to complete the repairs."
    )
)

let embeddedProficiency0607: Proficiency = Proficiency(
    id: "crowd_working",
    name: "Crowd Working",
    wikiPageTitle: "Crowd Working (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Group"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Charisma",
        checkModifier: 2,
        rawModifier: "+2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Almost every bard is familiar with the ways of a crowd. However, those who take crowd working learn all the tricks of the trade.",
        fullText: "## The Complete Bard's Handbook\n\nAlmost every bard is familiar with the ways of a crowd. However, those who take crowd working learn all the tricks of the trade. Such bards are skilled at observing crowds and adjusting their performances accordingly.\n\nAny bard who is using a special ability to adjust the encounter reactions of a crowd (e.g., influence reactions) can make a crowd working proficiency check. If this check is successful, the bard can alter the reactions of the crowd by two levels instead of the typical one.\n\nIf the bard or his group is soliciting money from a crowd, a successful proficiency check indicates that the bard is particularly appealing and the crowd willingly donates twice as much money as it normally would (or conditions improve one category if using the performance rules earlier in this handbook).\n\n## The Complete Book of Humanoids\n\nCharacters with this proficiency are familiar with how to handle crowds. They are skilled at observing crowds and adjusting their behavior accordingly. Humanoids who normally have this skill include all types of humanoid entertainers, from bards and fortune tellers, to acrobats and pit fighters.\n\nThis skill also can be used to adjust the encounter reaction of a crowd. A successful proficiency check will alter the crowd's reaction by two levels (or convinces them to donate twice as much money to the entertainers as they normally would)."
    )
)

let embeddedProficiency0608: Proficiency = Proficiency(
    id: "cryptography",
    name: "Cryptography",
    wikiPageTitle: "Cryptography (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue", "Wizard"],
        slotsRequired: 1,
        rawSlots: "N/A",
        relevantAbility: "N/A",
        checkModifier: 0,
        rawModifier: "N/A",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Reason, Wisdom/Intuition",
            characterPointCost: 3,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "Cryptography: The character with this proficiency has some training and skill in deciphering hidden messages and codes. In its basic form, the character is allowed to make a proficiency check when confronted with a coded message.",
        fullText: "Cryptography: The character with this proficiency has some training and skill in deciphering hidden messages and codes. In its basic form, the character is allowed to make a proficiency check when confronted with a coded message. If successful, the DM can reveal a general overview of the secret missive.\n\nThis proficiency is more fun when used as an aid to role-playing. Ideally, the use of the cryptography proficiency requires a great deal of involvement from the player—and a certain amount of puzzle design by the DM—instead of simply passing a check and demanding that a coded message be explained by the DM.\n\nRather, a character with the cryptography proficiency should have the chance of recognizing a code concealed within a written or spoken message, or perhaps hidden by some other medium—an intricately woven tapestry or sculpted piece of heraldry, for example. The DM will usually roll this check secretly, announcing that the character observes something unusual.\n\nIf the character notices the encoded sigil, the DM should describe it in considerable detail—word for word, if it is a written message. The character can make an additional proficiency check during the course of the decoding; if successful, the DM can provide a significant clue—a name, place, or date that is mentioned, for example. The bulk of the decoding should still be performed by the player."
    )
)

let embeddedProficiency0609: Proficiency = Proficiency(
    id: "crystal_focus",
    name: "Crystal Focus",
    wikiPageTitle: "Crystal Focus (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Psionicist",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Many psionicists find that they can achieve a deeper and more productive psionic trance by focusing their meditations on an inanimate object. Crystals and gemstones are the most frequently used foci, because of their clarity and durability.",
        fullText: "## The Will and the Way\n\nMany psionicists find that they can achieve a deeper and more productive psionic trance by focusing their meditations on an inanimate object. Crystals and gemstones are the most frequently used foci, because of their clarity and durability. A crystal focus gives the psionicist a +1 bonus on power checks for one particular science or devotion.\n\nTo use this proficiency, the psionicist must first attune a crystal to one of his psionic powers. This requires a proficiency check and two hours of meditation. After that, he can use the +1 bonus any time he initiates the power if he has the crystal in contact with his body. A psionicist may only attune one crystal at a time. If he rolls a natural 20 on his power check, the crystal burns out and is destroyed.\nThe crystal doesn't have to be very valuable—a plain quartz crystal is usually enough to establish focus"
    )
)

let embeddedProficiency0610: Proficiency = Proficiency(
    id: "curtain_cognizance",
    name: "Curtain Cognizance",
    wikiPageTitle: "Curtain Cognizance (Proficiency)",
    redirectAliases: ["Curtain Cognizance (GEP)"],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Inteligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The coruscating lights found in areas of the Wall of Color are difficult to interpret, but it is sometimes possible for a body to find specific locations on an adjacent plane based on subtle patterns of light intensity, frequency, duration, and other factors.",
        fullText: "The coruscating lights found in areas of the Wall of Color are difficult to interpret, but it is sometimes possible for a body to find specific locations on an adjacent plane based on subtle patterns of light intensity, frequency, duration, and other factors. In order to use this proficiency, a body must stand before a specific area of the color curtain in the Deep Ethereal. Next, she must take 1 full tum scrutinizing the curtain of light. When a body completes this examination, she's ready to make a proficiency check. A successful check allows the traveler to chart a general path along the curtain to an area that roughly corresponds to the desired location on the plane beyond the vaporous \"doorway.\" Normally, a successful check allows a body to chart a path along the curtain (a trip of 1d10x10 hours) to an area that corresponds to a distance of 1d10 miles in a random direction of the exact location sought. A natural roll of 1 allows a traveler to come within 1 mile (in a random direction) of her desired location. A body who fails this check recognizes her inability to infer any \"landmarks\" from the chasing lights. However, a natural roll of 20 indicates that a body heads off in a randomly rolled direction along the curtain, confidently moving toward what she believes to be the proper direction. A body who fails a curtain cognizance check may not make another check on the same area of the curtain for a full 48 hours."
    )
)

let embeddedProficiency0611: Proficiency = Proficiency(
    id: "dancing",
    name: "Dancing",
    wikiPageTitle: "Dancing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Dexterity/Balance, Charisma/Appearance",
            characterPointCost: 2,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character knows many styles and varieties of dance, from folk dances to formal court balls.",
        fullText: "## Player's Handbook\n\nThe character knows many styles and varieties of dance, from folk dances to formal court balls.\n\n## Player's Option: Skills & Powers\n\nThe character knows and can perform the moves of many types of dances, including some that involve precise and detailed steps. All dances common to the character's society will be familiar. Rare, archaic, or unusual dances will be known with a proficiency check. Also, characters who have had a chance to observe an unknown dance can perform it (–2 modifier, +1 for each time after the first that it is seen performed).\n\nTruly spectacular dances—the kind that win character's campaign-wide acclaim—combine elements of dance proficiency with skills of tumbling, tightrope walking, and jumping.\n\n## The Complete Barbarian's Handbook Modifications\n\nA barbarian with this proficiency knows the ceremonial and recreational dances associated with his homeland. Such dances may be augmented with hoops, sticks, rattles, and other objects that enhance both the complexity and aesthetic quality of the performance.\n\n## Shaman\n\nShamans are only adept in dances required in shamanic rituals. Attempts at performing other dances are made with a -2 to -4 penalty to the proficiency check, depending on factors such as the intricacy of the dance, or whether it is common among the people of the character's culture.\n\nWhen performing shamanic rituals involving dancing, the character receives a +1 bonus to the shamanic ritual check."
    )
)

let embeddedProficiency0612: Proficiency = Proficiency(
    id: "danger_sense",
    name: "Danger Sense",
    wikiPageTitle: "Danger Sense (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Wisdom",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency provides a humanoid character with a sixth sense which warns of impending danger.",
        fullText: "## The Complete Book of Humanoids\n\nThis proficiency provides a humanoid character with a sixth sense which warns of impending danger. On a successful check, the character avoids a trap at the last second or realizes that opponents wait to ambush him due to a sudden warning tingle that cannot be ignored. Characters who make successful checks spot traps before blundering into them and receive initiative against hidden opponents. This proficiency does not work against opponents who are out in the open and making no attempt to hide their actions. Failure indicates that the character senses nothing out of the ordinary and play continues normally.\n\n## The Complete Barbarian's Handbook\n\nThis proficiency provides the character with a sixth sense that warns him of impending danger from traps, hazards, and ambushes. When the character is approximately one round away from triggering the threat (for example, in one round he'll step on a rattlesnake if he keeps moving at his current rate), the DM makes a secret proficiency check. If the check fails, the DM tells him nothing. If the check succeeds, the character feels a tingling in the back of his neck or on the tips of his fingers; the DM tells him the general direction of the threat (in front, to the right, overhead, and so on). The character doesn't learn anything about the type of threat; it might be pool of quicksand, a concealed lion, or a hidden trip wire. It's up to the character to figure out how to respond to the warning.\n\nIf the threat is an impending ambush from an NPC or a creature, the character automatically gains the initiative on the first round of combat (assuming that combat ensues one round after the character is alerted by his danger sense).\n\nThe DM may decide that the character's danger sense does not work against unfamiliar dangers. If an island barbarian has never seen a poisonous snake, he might be oblivious to the rattlesnake's danger. Exotic magical traps or illusions may also circumvent danger sense.\n\nCrossover Group: General.\n\n## Campaign Option: Council of Wyrms Setting\n\nDanger Sense provides a dragon with a sixth sense that warns of impending danger. On a successful check, a dragon avoids a trap at the last second or otherwise senses danger due to a sudden warning tingle that cannot be ignored. This proficiency lets dragons spot traps or receive initiative against hidden opponents, but offers no benefit against opponents who are in the open and making no attempt to hide their actions. A failed proficiency check indicates that the dragon senses nothing out of the ordinary and play continues normally.\n\nHatchlings can take this proficiency."
    )
)

let embeddedProficiency0613: Proficiency = Proficiency(
    id: "dark_lore",
    name: "Dark Lore",
    wikiPageTitle: "Dark Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The Dark Lore proficiency gives the PC a wide-ranging knowledge of the nature of the dark powers of the deserts, peaks, and oceans, and the charms and rituals that can hold them at bay.",
        fullText: "## Dragon Magazine #198\n\nThe Dark Lore proficiency gives the PC a wide-ranging knowledge of the nature of the dark powers of the deserts, peaks, and oceans, and the charms and rituals that can hold them at bay. A priest with this proficiency gains minor access to the Protection sphere of spells, even if he is otherwise not entitled to it, and gains major access to it if he already has minor access. Other characters gain knowledge of which spells and magical items can fend off which monsters.\n\nWith a successful proficiently check, the character knows how to bribe, avert, or ward off a particular type of supernatural creature. He knows the weaknesses and abilities of most supernatural, evil monsters (not including the genies). He also knows their customs, their likes and dislikes, and their enemies, improving the PC’s bribery, haggling, and reaction rolls by +2.\n\nWith powerful creatures of darkness (more HD than the PC has levels), the DM should roll the skill check. The skill still provides the nature of their weakness, if any—but on a failed check the supposed knowledge is completely false, and perhaps even makes the creature stronger.\n\nThis proficiency does not provide any detailed knowledge of genies; the Genie Lore proficiency provides that."
    )
)

let embeddedProficiency0614: Proficiency = Proficiency(
    id: "debate",
    name: "Debate",
    wikiPageTitle: "Debate (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Al-Qadim", "Council of Wyrms"],
    mechanics: ProficiencyMechanics(
        groups: ["Dragons - CoW General - AA"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma - CoW Intelligence - AA",
        checkModifier: -1,
        rawModifier: "-1 - CoW +0 - AA",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "With Debate, a dragon can hold its own in formalized arguments, in dialogues of persuasion, and in discussions involving opposing points of view-all without losing its temper.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nWith Debate, a dragon can hold its own in formalized arguments, in dialogues of persuasion, and in discussions involving opposing points of view-all without losing its temper. While a dragon cannot automatically sway a crowd or convince someone to believe its point of view, the proficiency does allow a dragon to impress others with its acute mental faculties.\n\nA successful proficiency check gives a dragon a +2 bonus to reaction checks when engaged in formal arguments with other dragons or even with members of other intelligent species. A failed check indicates that the dragon has muddled its argument and receives a -1 penalty to reaction checks. The Debate proficiency is extremely useful for those dragons who like to engage in conversation or are active in the Council of Wyrms.\n\nHatchlings can't select this proficiency.\n\n## Arabian Adventures\n\nCharacters with the debate proficiency can hold their own during heated discussions, remaining quick-witted and cool-tempered. They do not gain the ability to convinace guards or holy warriors of their viewpoints, however. Nor can they sway the thinking of unruly hordes or skeptical masses.\n\nThis proficiency does allow them to engage in meaningful arguments, impressing others with their mental faculties. As a result, debaters gain a +2 bonus to encounter reactions. (See Table 59 in Chapter 11 of the DMG.) When they're attempting to smooth ruffled feathers, the bonus is subtracted from the result on the dice. When they're attempting to enrage another character with cheek and guile, the bonus is added to the dice roll.\n\nAn individual with the debate proficiency is quite engaging. As a result, a character verbally battling one-on-one with such a debater is less watchful of his or her surroundings. Pickpocket attempts against that character are at +5 percent, the character's initiative is at +3, and the character's ability or proficiency checks are at -3. (The debater does not suffer these penalties unless doing battle with another debater.)\n\nDebaters cannot automatically preoccupy others, however. An individual must be willing to talk in the first place before a debater can use this proficiency. Further, the proficiency doesn't work unless the targeted individual is at least cautious toward the debater (if they saw eye to eye, there would be nothing to debate). Assuming these conditions are met, the debate begins. It continues until the target makes a d20 roll higher than his or her Intelligence score. (The smarter the individual, the livelier the debate, and the harder it is to end it.) Debate also ends if a sudden action or activity interrupts it-for example, a failed pickpocketing attempt, a sudden attack or magical explosion, a scream from the harem, and so forth. As soon as the debate ends, so do the penalties noted above (to initiative, ability and proficiency checks, and the likelihood of being robbed by a pickpocket).\n\nTwo individuals with the debate proficiency can seek to best each other in verbal sparring. In this case, both make proficiency checks each round until one fails. Both characters are preoccupied; they suffer the penalties noted above while engaging each other in debate."
    )
)
