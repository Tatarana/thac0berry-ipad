import Foundation

/// Parte 13 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency1300: Proficiency = Proficiency(
    id: "languages_future",
    name: "Languages, Future",
    wikiPageTitle: "Languages, Future (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["Chronomancer"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency may interpret without error a written work from a specified period or, if operating within the period, may speak the language fluently.",
        fullText: "A character with this proficiency may interpret without error a written work from a specified period or, if operating within the period, may speak the language fluently. The character must first be able to speak a modern antecedent of the language before learning the future version of it. This proficiency can only be learned through study in the appropriate time period or through the teachings of another with the desired knowledge.\n\nFor example, Articus knows the regional human tongue, as well as the languages of the elves and the dwarves. He also has the future languages proficiency covering the age of discovery. Traveling to this future age, the changes in the languages he knows present no problem, and he is able to speak the dialects with ease. While there, he also encounters a gnome. Since he did not know the gnomish language to begin with, his training in future dialects does not help him."
    )
)

let embeddedProficiency1301: Proficiency = Proficiency(
    id: "languages_modern",
    name: "Languages, Modern",
    wikiPageTitle: "Languages, Modern (Proficiency)",
    redirectAliases: ["Modern Languages (Proficiency)"],
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
            subAbility: "Intelligence/Knowledge",
            characterPointCost: 2,
            baseRating: "9"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character has learned one or more languages, other than his native tongue, that are contemporary to the campaign world. For each additional character point spent on modern Languages, the character can speak one additional language.",
        fullText: "## Player's Handbook\n\nThe character has learned one or more languages, other than his native tongue, that are contemporary to the campaign world. For each additional character point spent on modern Languages, the character can speak one additional language.\n\n## Player's Option: Skills & Powers\n\nThe character has learned one or more languages, other than his native tongue, that are contemporary to the campaign world. For each additional character point spent on modern Languages, the character can speak one additional language.\n\n## The Complete Book of Dwarves\n\nThe modern languages dwarves may learn are determined by the campaign background. If a character lives in a stronghold that has had no contact with goblins, he is unlikely to have learned goblin. The languages for dwarves in the Player's Handbook should be considered as suggestions only. Dwarves may learn any language that suits their background. Suggested languages are: deep tongue, drow, elf, gnome, goblin, local human common tongue, kobold, orc, troll, ogre.\n\n## Campaign Option: Council of Wyrms Setting\n\nAs in the Player's Handbook, this allows a dragon to speak any of the current languages used in the isles. These include the languages of the dragons (metallic, gem, chromatic, and High Draconic), the demihuman languages, and the languages of the various monster races.\n\nHatchlings receive their dragon language (metallic, gem, or chromatic) free of charge. They may also take High Draconic if they spend a slot."
    )
)

let embeddedProficiency1302: Proficiency = Proficiency(
    id: "law",
    name: "Law",
    wikiPageTitle: "Law - Dragon (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Tradesman (MotRD)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intellect",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters with this skill have a good understanding of the law, court systems, and related subjects.",
        fullText: "## Dragon Magazine #215\n\nCharacters with this skill have a good understanding of the law, court systems, and related subjects. If a player wishes to spend an extra slot when purchasing this proficiency, his character is assumed to have been admitted to the bar and may practice law. A slot expended in this does not increase the character's chance of success when making a Proficiency Check.\n\nA player selecting this skill may decide that his character has studied a specific type of law. If such is the case, the character gains a +2 bonus to Proficiency Checks made within his area of expertise, but suffers a -2 penalty on all other Law Proficiency Checks. Possible areas of specialization include: business, civil, criminal, and international law."
    )
)

let embeddedProficiency1303: Proficiency = Proficiency(
    id: "law_law",
    name: "Law",
    wikiPageTitle: "Law (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest - PO:SM Warrior", "Priest - Paladin"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence - PO:SM Wisdom - Paladin",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Law: A character with this proficiency is thoroughly familiar with the legal system of his homeland and is skilled in representing cases before judges, officers, nobles, and magistrates.",
        fullText: "## Player's Option: Spells & Magic\n\nLaw: A character with this proficiency is thoroughly familiar with the legal system of his homeland and is skilled in representing cases before judges, officers, nobles, and magistrates. This is a working knowledge of the law, as opposed to the theoretical knowledge of the sage area of study. With a successful proficiency check, the character can build a strong defense for a person accused of a crime; if the judge or jury are fair-minded and honest, he stands an excellent chance of winning his client's case. Of course, corrupt or intimidated officials can still deliver unjust verdicts despite the character's best efforts.\n\n## The Complete Paladin's Handbook\n\nA character with this proficiency is thoroughly familiar with the legal system of his homeland (or any other region of his choice). He knows which laws are rigorously enforced (illegal gambling may be tolerated in one region, aggressively prosecuted in another), and routine legal procedures (such as how to file suit against a debtor). Understanding nuances of the law, such as interpreting fine points of a contract, require proficiency checks.\n\nA successful proficiency check also allows the character to conduct a strong defense when he or a companion stands accused of a crime. If the judge is fair-minded and the evidence of the crime is ambiguous, a successful check will sway the verdict in the defendant's favor; either he receives the smallest possible sentence or fine, or is completely vindicated. However, if the evidence clearly calls for a conviction or the judge is corrupt, a successful proficiency check won't help.\n\nA character may spend additional slots to know the legal systems of other regions. Alternately, he may spend slots to acquire expertise in a particular area of the law, such as tax codes or property rights. Expertise assumes a broad understanding of the chosen area, requiring checks only in extreme instances.\n\nCrossover Groups: Warrior, Priest.\n\n### Law and Paladins\n\nA paladin with the Law proficiency won't defend anyone he believes to be guilty, including his own companions. Though a paladin won't knowingly break the law, he may take advantage of this proficiency to defend himself if wrongly accused of a crime; a failed defense may result in his conviction.\n\n## Warriors & Priests of the Realms\n\nWarrior, Priest\n\n1 slot, Wisdom, 0 modifier\n\nThe law proficiency familiarizes a character with the laws of his city or country. He knows what is legal, how severe each crime is, and what the punishment is. This is identical to the law proficiency as included in the Complete Paladin's Handbook."
    )
)

let embeddedProficiency1304: Proficiency = Proficiency(
    id: "leadership",
    name: "Leadership",
    wikiPageTitle: "Leadership (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: ":For other uses, see Leadership (disambiguation). A character with this proficiency has a commanding manner that makes others of his own kind inclined to respond favorably.",
        fullText: ":For other uses, see Leadership (disambiguation).\nA character with this proficiency has a commanding manner that makes others of his own kind inclined to respond favorably. The character adds his level of experience to his Charisma score when determining reaction adjustments (see Chapter 1 of the Player's Handbook). This reaction bonus is only in effect when he deals with people from his homeland; the reaction bonus does not affect those of evil alignment.\n\nExample: Grog, a 7th-level barbarian, has a Charisma score of 13 and the leadership proficiency. According to Table 6 in the ''Player's Handbook'', he has a standard reaction adjustment of +1. But when dealing with people from his homeland, he has a reaction bonus of +9 (7+13=20; according to Table 6, a Charisma of 20 gives a +9 bonus). When dealing with evil characters from his homeland, however, he uses his standard +1 bonus.\n\nCrossover Group: Warrior."
    )
)

let embeddedProficiency1305: Proficiency = Proficiency(
    id: "leatherworking",
    name: "Leatherworking",
    wikiPageTitle: "Leatherworking (Proficiency)",
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
            subAbility: "Intelligence/Knowledge, Dexterity/Aim",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency enables a character to tan and treat leather and to make clothing and other leather objects. The character can make leather armor, as well as backpacks, saddlebags, saddles, and all sorts of harnesses.",
        fullText: "## Player's Handbook\n\nThis proficiency enables a character to tan and treat leather and to make clothing and other leather objects. The character can make leather armor, as well as backpacks, saddlebags, saddles, and all sorts of harnesses.\n\n## Player's Option: Skills & Powers\n\nLeather working: The character with this skill can skin animals, tan leather, and work that leather into clothing, armor, backpacks and saddlebags, harnesses, etc. These tasks are automatic successes, but the leather worker will have to make a proficiency check when attempting unusual jobs—making a leather patch for a boat hull, for example, or making a usable tent of scraps of hide."
    )
)

let embeddedProficiency1306: Proficiency = Proficiency(
    id: "light_sleeping",
    name: "Light Sleeping",
    wikiPageTitle: "Light Sleeping (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Constitution",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency lets the character receive the benefits of a full night's rest from a one-hour nap. The character must make a proficiency check before going to sleep.",
        fullText: "This proficiency lets the character receive the benefits of a full night's rest from a one-hour nap. The character must make a proficiency check before going to sleep. If the check succeeds, the character awakens in an hour, fully refreshed; he recovers the same amount of lost hit points as if he'd rested for eight hours. If the check fails, he remains asleep, awakening as usual. He may use this proficiency only once per week, regardless of whether it fails or succeeds.\n\nThis proficiency is not effective for purposes of spell memorization.\n\nCrossover Group: Warrior."
    )
)

let embeddedProficiency1307: Proficiency = Proficiency(
    id: "local_dwarf_history",
    name: "Local Dwarf History",
    wikiPageTitle: "Local Dwarf History (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: 2,
        rawModifier: "+2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency is different from the local history proficiency, a character with this proficiency is only knowledgeable about dwarf history. This is chiefly concerned with lineages and events affecting dwarves.",
        fullText: "## The Complete Book of Dwarves\n\nThis proficiency is different from the local history proficiency, a character with this proficiency is only knowledgeable about dwarf history. This is chiefly concerned with lineages and events affecting dwarves. It deals with the founders of the clans and strongholds, and traces the descendants to the present. The battles and events of clan and stronghold are known, as well as the fates of those who have left to establish new homes or who perished while adventuring.\n\nThe extent of geographical knowledge is dependent on the campaign background. Those who have had no contact with the world above may be totally ignorant of what lies on the surface, but will have extensive knowledge of their own stronghold. Those whose relatives have established new strongholds or are members of such strongholds would have knowledge of the area between the two and some knowledge of the geography surrounding them. Even so, most dwarves, unless they live in close proximity to other races, have a very hazy idea of where the sea is, for example.\n\nWhile a character with this proficiency knows dwarf history, his knowledge of the history of other races is minimal. If humans fought a great battle against each other, a dwarf who did not live with humans is not likely to have heard of it. If the battle involved dwarves he would probably know of it. If it involved dwarves from his own stronghold or clan, he would have extensive knowledge of the events leading to it and the course of the battle. As with some other dwarf proficiencies the exact extent of an individual's knowledge is determined by his background.\n\nThe local dwarf history proficiency may be used to entertain other characters. When so engaged, he gains a +2 bonus to his Charisma while dealing with dwarves. With other races he does not gain the bonus, because dwarf stories tend to be dull, slow moving and overly concerned with who is related to whom, their places of origin, and all of the places the heroes' ancestors founded along the way. Trying to tell a dwarf story to hostile beings is likely to incite them to violence. Orcs will not be impressed, even with the best-told dwarf tale."
    )
)

let embeddedProficiency1308: Proficiency = Proficiency(
    id: "local_history",
    name: "Local History",
    wikiPageTitle: "Local History (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Rogue"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge, Charisma/Appearance",
            characterPointCost: 2,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character is a storehouse of facts about the history of a region the size of a large county or a small province.",
        fullText: "## Player's Handbook\n\nThe character is a storehouse of facts about the history of a region the size of a large county or a small province. The character knows when the ruined tower on the hill was built and who built it (and what happened to him), what great heroes and villains fought and fell at the old battlefield, what great treasure is supposed to be kept in a local temple, how the mayor of the next town miraculously grew hair on his balding pate, and more.\n\nThe DM will provide information about local sites and events as the character needs to know them. Furthermore, the character can try to retell these events as entertaining stories. Once the subject is chosen, he can either make a proficiency check and, if successful, add that tale to his repertoire, or actually tell the story to other characters. If the character succeeds in entertaining them, the player need not make a proficiency roll for the character, since he has succeeded. The character can tell these stories to entertain others, granting him a +2 bonus to his Charisma for the encounter. But telling stories to hostile beings is probably not going to do any good.\n\n## Player's Option: Skills & Powers\n\nThe character knows all about the background of a specific area in the campaign world and can use this knowledge to entertain and enlighten others, gaining a +2 bonus to the reaction rolls of NPCs from that area. If a specific question comes up—the identity of a knight's banner seen in the distance, for example—the character can make a proficiency check, with success indicating the correct tidbit of information. A character with the obscure knowledge trait gains a +3 bonus to the proficiency rating.\n\n## The Complete Barbarian's Handbook Modifications\n\nA barbarian with this proficiency must specialize in the legends and lore of his homeland. An oral historian, the barbarian can recite from memory a plethora of information concerning events, characters, and locations from bygone eras.\n\n## Campaign Option: Council of Wyrms Setting\n\nLocal History is described in the Player's Handbook: For dragons, this proficiency provides a storehouse of knowledge about a specific dragon domain, its ruler, clan, demihuman population, and local monsters. This information is provided by the DM as necessary. The character can also tell local tales (and check for a +2 Charisma bonus for an encounter), as decided by the DM.\n\nHatchlings can't select this proficiency.\n\n## Shaman\n\nFor tribal shamans, this proficiency always centers on the spirits whom the community reveres. Tribal shamans with this proficiency, upon making a successful check, receive +10% to the chance that a spirit is \"home\" when they attempt to contact it.\n\nFor other shamans, the history proficiencies operate as normal, although any shaman may choose to specialize in lore about the spirits."
    )
)

let embeddedProficiency1309: Proficiency = Proficiency(
    id: "locksmithing",
    name: "Locksmithing",
    wikiPageTitle: "Locksmithing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Recommended: Troubleshooter, dwarf and gnome thieves.",
        fullText: "## The Complete Thief's Handbook\n\nRecommended: Troubleshooter, dwarf and gnome thieves.\n\nThis is the specialized skill of making locks. It is treated like other \"craft\" proficiencies when checking for success. Also, thieves with this proficiency gain a 10% bonus to their lockpicking skill, because they are intimately familiar with the internal structure and working of so many locks.\n\nBesides troubleshooters, dwarf and gnome thieves of any kit can take the locksmithing proficiency to fill one slot, because of the tradition of craftsmanship and mechanical things in their cultural heritages.\n\n## The Complete Book of Dwarves\n\nWith the locksmithing proficiency a character can make and repair all kinds of mechanical locks. Thieves with this proficiency gain a 10% bonus to their lockpicking skill, because they are intimately familiar with the internal structure and working of locks."
    )
)

let embeddedProficiency1310: Proficiency = Proficiency(
    id: "looting",
    name: "Looting",
    wikiPageTitle: "Looting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["General (Rogue - Thief & Spacefarer Handbooks)"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Required: Burglar.",
        fullText: "## The Complete Thief's Handbook\n\nRequired: Burglar.\n\nRecommended: Adventurer, Bandit, Buccaneer, Thug.\n\nThis proficiency represents a knack for grabbing the best loot in the shortest time. For instance, a cat burglar breaks into a room in a wealthy mansion. He has about two minutes to fill his backpack, so that he can escape before guards are summoned by magical alarms. If his proficiency check succeeds, he is able to recognize and stuff into his pack the most valuable combination of items that is feasible, given his limitations of time and space.\n\n## The Complete Book of Humanoids\n\nThis proficiency represents a knack for grabbing the best loot in the shortest amount of time. A successful proficiency check allows a character to recognize and grab the most valuable combination of items that is feasible, given the situational limits of time and space.\n\n## The Complete Spacefarer's Handbook\n\nThis proficiency represents a knack for grabbing the best loot in the shortest time. It is most useful in seizing treasure from a spelljamming vessel that is breaking up or about to plunge into an atmosphere. If the character's proficiency check is successful, he is able to recognize and stuff into his pack the most valuable combination of items, given the limitations of time and space.\n\n## Campaign Option: Council of Wyrms Setting\n\nLooting represents a knack for grabbing choice bits of treasure in a short amount of time. A successful proficiency check allows a dragon to recognize and grab the most valuable combination of items for its hoard according to the limitations of the situation (time, location, enemies, free claws, etc.).\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency1311: Proficiency = Proficiency(
    id: "lore",
    name: "Lore",
    wikiPageTitle: "Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Council of Wyrms"],
    mechanics: ProficiencyMechanics(
        groups: ["Dragons"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Lore allows a dragon to specialize in a specific area of knowledge. Every slot used to purchase Lore must be assigned a specific subject.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nLore allows a dragon to specialize in a specific area of knowledge. Every slot used to purchase Lore must be assigned a specific subject. Examples of appropriate Lore topics include dragon slayers, fire giants, subterranean realms, sea life, and the undead.\n\nThe DM must determine the level of a particular piece of knowledge when a PC wants to make a Lore check. Does the character know anything useful on the topic in question? The DM assigns a level-student, expert, or master-to each piece. Checks are made at -3, -6, or -9, respectively. If the check fails, the PC lacks that sought-after bit of knowledge. After the adventure, the PC can study (for three, six, or nine weeks, as per the level assigned) to make another check to gain that knowledge.\n\nA specific Lore subject can be slotted up to three times, reflecting a PC's level of expertise (as student, expert, or master). Each level provides a +1 bonus to Lore checks on that subject. Thus a PC with student-level Lore of sea life gets a +1 bonus to those checks, while a master of the subject gets a +3 bonus.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency1312: Proficiency = Proficiency(
    id: "lower_plane_knowledge",
    name: "Lower Plane Knowledge",
    wikiPageTitle: "Lower Plane Knowledge (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: nil,
            characterPointCost: 7,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "(2 slots, Intelligence, -2) This proficiency gives the character some knowledge about a particular lower plane — who lives there, what's needed to survive or get there, etc.",
        fullText: "(2 slots, Intelligence, -2) This proficiency gives the character some knowledge about a particular lower plane — who lives there, what's needed to survive or get there, etc. The character doesn't have automatic knowledge of spell keys, but he does have some knowledge of what kinds of magic may be affected (proficiency check required).\n\nNote that if the ''Player's Option™: Skills & Powers'' book is being used, this skill costs 4 slots and starts at a base score of 7."
    )
)

let embeddedProficiency1313: Proficiency = Proficiency(
    id: "lucid_buffer",
    name: "Lucid Buffer",
    wikiPageTitle: "Lucid Buffer (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Caradhaker Only"],
        slotsRequired: 2,
        rawSlots: "2 slots",
        relevantAbility: "n/a",
        checkModifier: 0,
        rawModifier: "n/a",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Lucid Buffer functions differently depending on how the DM handles illithid psionic abilities.",
        fullText: "## Dragon Magazine #230\n\nLucid Buffer functions differently depending on how the DM handles illithid psionic abilities.\n\nIf the DM treats illithid psionics as spell-like powers (as in the MONSTROUS MANUAL™ book), a character with the lucid buffer proficiency automatically gains a +4 to saving throws to resist an illithid's mind blast, suggestion, charm, and ESP powers. This saving throw applies only when those powers are used by an illithid, illithid-kin (ulitharids, vampiric illithids, ahloons, urophions, neothelids, or elder brains) or similarly “psionic” creatures.\n\nIf the DM uses psionic rules from The Complete Psionics Handbook, an illithid (or other psionic creature) must use the contact power upon a victim to “open” his or her mind before any other power can subsequently affect the victim. A mindstalker with lucid buffer automatically penalizes the contact power score by -4 when an illithid (or another psionic creature) attempts to use contact against the mindstalker. Mindstalkers save against illithid mind blasts as described above.\n\nIf the DM uses psionic rules from either ''PLAYER'S OPTION: Skills & Powers or the DARK SUN® campaign setting (or as described in the Illithid MONSTROUS ARCANA book), an illithid (or other psionic creature) can use any of five psionic attacks to “open” the mind of a victim to further uses of other psionic powers. A caradhaker with lucid buffer'' reduces his MAC (Mental Armor Class) by -4 to resist having his mind opened by psionic attacks from any creature. Mindstalkers save against illithid mind blasts as described above."
    )
)

let embeddedProficiency1314: Proficiency = Proficiency(
    id: "machine_language",
    name: "Machine Language",
    wikiPageTitle: "Machine Language (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency gives the Sheenchaser a crude understanding of the bursts of sound and light that machine life uses during line-of-sight communication with other machines.",
        fullText: "## Dragon Magazine #258\n\nThis proficiency gives the Sheenchaser a crude understanding of the bursts of sound and light that machine life uses during line-of-sight communication with other machines.\n\nThe proficiency can be checked whenever a machine life form is observed to be making buzzes and static-like tones or emitting light pulses. If the check is successful, the chaser gains a general understanding of what the sheen is currently “saying.”\n\nUsually, a sheen that is signaling is providing a running commentary on what it sees in its environment and what its short term plans are in response to its environment. Thus, a sheen might be understood to say, “rough ground ahead predominated by mineral protrusions must navigate to the right 30 degrees organic debris protrusion to the left must investigate ambulatory organisms straight ahead ... must eliminate.” This proficiency becomes more useful if two Sheens are observed communicating with each other, especially if specific information concerning the machine cyst expansion and deployment of sheens in the field is “discussed.”\n\nNote that one slot of Machine Language proficiency suffices to modify a successful Digital Persuasion results table roll by +1/-1."
    )
)
