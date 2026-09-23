import Foundation

/// Parte 21 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency2100: Proficiency = Proficiency(
    id: "sorcerous_dueling",
    name: "Sorcerous Dueling",
    wikiPageTitle: "Sorcerous Dueling (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency involves the study of manipulating magic in a sorcerous duel—the conversion of magical energies into the spell points for use in the tightly controlled, ritual combat.",
        fullText: "## The Complete Sha'ir's Handbook\n\nThis proficiency involves the study of manipulating magic in a sorcerous duel—the conversion of magical energies into the spell points for use in the tightly controlled, ritual combat. Only those sorcerers who have this proficiency may duel, and many secret societies encourage their members to learn this ability."
    )
)

let embeddedProficiency2101: Proficiency = Proficiency(
    id: "sound_analysis",
    name: "Sound Analysis",
    wikiPageTitle: "Sound Analysis (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
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
        briefSummary: "This proficiency allows a character to gauge the size of underground areas by generating noise and analyzing the echoes that return. Using this skill, he can calculate distances up to one mile, and determine sound direction.",
        fullText: "## The Complete Book of Dwarves\n\nThis proficiency allows a character to gauge the size of underground areas by generating noise and analyzing the echoes that return. Using this skill, he can calculate distances up to one mile, and determine sound direction.\n\nTo use sound analysis, the character must work in absolute silence. The sound created must have a sharp, staccato quality. A howl or wail is ineffective, but a clicking sound, or loud \"hey\" works well.\n\nThe PC must make a proficiency check. If the check is successful, he has correctly analyzed the size of the area in question to within plus or minus 25% of its height, width, and length. If the check fails, the echo has become garbled in its reverberations. No further attempts by the PC to analyze that area will succeed, though others with the proficiency may try.\n\nA proficiency check of 5 or less means the character has learned not only the size of the analyzed area, but other details as well: the number of branching side passages, whether there is a straight or wandering corridor, and whether or not water exists.\n\nThe disadvantage of this ability is that, while it is useful for learning about a completely unknown area, it announces the characters to all creatures in hearing range. They will certainly be prepared, and may go looking for the intruders."
    )
)

let embeddedProficiency2102: Proficiency = Proficiency(
    id: "spacemanship",
    name: "Spacemanship",
    wikiPageTitle: "Spacemanship (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Dexterity",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The character with this proficiency is familiar with spelljamming ships. He is qualified to work as a crewman, although he cannot actually navigate.",
        fullText: "## The Complete Spacefarer's Handbook\n\nThe character with this proficiency is familiar with spelljamming ships. He is qualified to work as a crewman, although he cannot actually navigate. Trained spacemen have general knowledge of all parts of their ship, can recognize the insignia of all ship's ranks, know basic information about air consumption, gravity plane orientation, and phlogiston safety, as well as being trained to perform common shipboard tasks. Crews of trained spacemen are necessary to manage any spelljamming ship."
    )
)

let embeddedProficiency2103: Proficiency = Proficiency(
    id: "spell_recovery",
    name: "Spell Recovery",
    wikiPageTitle: "Spell Recovery (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Planescape"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard", "Priest"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Intelligence",
        checkModifier: -5,
        rawModifier: "-5",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "When a berk casts a spell on a plane where it won't work—like an illusion on Mechanus, for example—he loses the spell.",
        fullText: "## The Planewalker's Handbook\n\nWhen a berk casts a spell on a plane where it won't work—like an illusion on Mechanus, for example—he loses the spell. Wizards or priests with this proficiency can attempt to grab hold of the useless, lost spell before it completely fades from their memory. This works only when a spell becomes useless due to the magical conditions of a plane, layer, or realm. Spells that fail simply because of other factors (like magic resistance or successful saving throws) cannot be recovered using this proficiency. Obviously, once a body learns the dark of planar magic, this proficiency won't be as useful, 'cause the berk won't be casting useless spells in the first place."
    )
)

let embeddedProficiency2104: Proficiency = Proficiency(
    id: "spellcraft",
    name: "Spellcraft",
    wikiPageTitle: "Spellcraft (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Reason",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "Although this proficiency does not grant the character any spellcasting powers, it does give him familiarity with the different forms and rites of spellcasting.",
        fullText: "## Player's Handbook\n\nAlthough this proficiency does not grant the character any spellcasting powers, it does give him familiarity with the different forms and rites of spellcasting. If he observes and overhears someone who is casting a spell, or if he examines the material components used, he can attempt to identify the spell being cast. A proficiency check must be rolled to make a correct identification. Wizard specialists gain a +3 bonus to the check when attempting to identify magic of their own school. Note that since the spellcaster must be observed until the very instant of casting, the spellcraft proficiency does not grant an advantage against combat spells. The proficiency is quite useful, however, for identifying spells that would otherwise have no visible effect.\n\nThose talented in this proficiency also have a chance (equal to 1/2 of their normal proficiency check) of recognizing magical or magically endowed constructs for what they are.\n\n## Player's Option: Skills & Powers\n\nSpellcraft: A character with this proficiency gains no actual spell use abilities, but does possess significant knowledge about spellcasting. Observing or overhearing a spell being cast, or a getting a good look at the spell components, lets the character make a proficiency check. Success means the enchantment is recognized. Modify the check by +2 if the character can both see and hear, and add another +2 if the spell components are spotted.\n\nWizards using this proficiency gain +2 to checks made if the spell being studied is one from their own specialty or school. Characters with this proficiency can also make checks to determine if an item is enchanted."
    )
)

let embeddedProficiency2105: Proficiency = Proficiency(
    id: "spellcraft_priest",
    name: "Spellcraft, Priest",
    wikiPageTitle: "Spellcraft, Priest (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Council of Wyrms"],
    mechanics: ProficiencyMechanics(
        groups: ["Dragons"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Unlike the proficiency used by other character races, the unique relationship dragons have with spells and magic requires the Spellcraft (Priest) proficiency in order to cast priest spells.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nUnlike the proficiency used by other character races, the unique relationship dragons have with spells and magic requires the Spellcraft (Priest) proficiency in order to cast priest spells.\n\nUnless a dragon player character takes the dragon-priest kit (see Chapter Three), innate priest spells will become available (to certain dragon types) only at specific levels.\n\nOnce a dragon has taken the Spellcraft (Priest) proficiency, it must wait until its innate priest spell slots open (as the dragon ages) before it can use priest spells. TABLE 5: DRAGON INFORMATION BY AGE (TYPE SPECIFIC shows which dragons have access to priestly magic and at what level. For example, a gold dragon has one priest spell at old age (8th level). See \"Spells\" later in this chapter for more information on dragon spell abilities and how they work.\n\nDragon PC kits that can take Spellcraft (Priest) are gold, silver, bronze, copper, brass, amethyst, sapphire, emerald, topaz, and crystal. The red and blue dragon NPCs also have access to priest spells. Each of these dragon types can also choose to take the dragon -priest kit.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency2106: Proficiency = Proficiency(
    id: "spellcraft_wizard",
    name: "Spellcraft, Wizard",
    wikiPageTitle: "Spellcraft, Wizard (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Council of Wyrms"],
    mechanics: ProficiencyMechanics(
        groups: ["Dragons"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Unlike the proficiency used by other character races, the unique relationship dragons have with spells and magic requires the Spellcraft (Wizard) proficiency in order to cast wizard spells.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nUnlike the proficiency used by other character races, the unique relationship dragons have with spells and magic requires the Spellcraft (Wizard) proficiency in order to cast wizard spells.\n\nUnless a dragon player character takes the dragon-mage kit, innate wizard spells will become available only at specific levels. The dragon must wait until its innate wizard spell slots open (with age) before it can use those spells. TABLE 5: DRAGON INFORMATION BY AGE (TYPE SPECIFIC) shows which dragons have access to wizard magic and at what level. For example, a gold dragon gets one wizard spell at juvenile age (4th level). See \"Spells\" later in this chapter for more information on dragon spells and how they work.\n\nAny dragon type can take Spellcraft (Wizard). Any type of dragon can take the dragon-mage kit.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency2107: Proficiency = Proficiency(
    id: "spelljamming",
    name: "Spelljamming",
    wikiPageTitle: "Spelljamming (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard", "Priest"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters with the spelljamming proficiency are experts at manipulating a spelljamming helm to maneuver a vessel. Any spell-caster can operate a helm, but this proficiency provides additional benefits.",
        fullText: "## The Complete Spacefarer's Handbook\n\nCharacters with the spelljamming proficiency are experts at manipulating a spelljamming helm to maneuver a vessel. Any spell-caster can operate a helm, but this proficiency provides additional benefits.\n* The character can boost the SR of his ship by 1 with a successful proficiency check. This boost lasts only one SPELLJAMMER® campaign combat turn.\n* The character can boost the maneuverability of his ship with a proficiency check. This boost lasts only one turn. A character cannot boost both the speed and maneuverability of his ship at the same time.\n* The character gains a -1 to his die rolls to determine which vessel gets initiative each turn.\n\nIn order to use these benefits, the character must be operating the ship's spelljamming helm. Bystanders cannot help, regardless of their proficiency."
    )
)

let embeddedProficiency2108: Proficiency = Proficiency(
    id: "spelunking",
    name: "Spelunking",
    wikiPageTitle: "Spelunking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Inteligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency has a thorough understanding of caves and underground passages, including their geology, formation, and hazards.",
        fullText: "## The Complete Ranger's Handbook\n\nA character with this proficiency has a thorough understanding of caves and underground passages, including their geology, formation, and hazards. The character generally knows what natural hazards are possible and what general equipment a spelunking party should outfit itself with. A successful proficiency check can reveal the following information:\n* Determine, by studying cracks in the walls and pebbles on the floor, sniffing the air, etc., the likelihood of a cave-in, flash flood, or other natural hazard. This only works with respect to natural formations, and is negated if the natural formations have been shored up, bricked in, or otherwise tampered with.\n* Estimate the time required to excavate a passage blocked with rubble.\n* While exploring extensive underground caverns, a successful check reduces the chance of getting hopelessly lost when confronted by multiple unmarked passages, sinkholes, etc. to a maximum of 30%, assuming good lighting (see DMG Table 81-82).\n\nCrossover Groups: Warrior."
    )
)

let embeddedProficiency2109: Proficiency = Proficiency(
    id: "spirit_lore",
    name: "Spirit Lore",
    wikiPageTitle: "Spirit Lore (Proficiency)",
    redirectAliases: ["Spirit Lore(CBN)"],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard", "Priest"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Charisma",
        checkModifier: -4,
        rawModifier: "-4",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with the spirit lore proficiency knows methods to contact spirits, deities, and extraplanar powers.",
        fullText: "## The Complete Book of Necromancers\n\nA character with the spirit lore proficiency knows methods to contact spirits, deities, and extraplanar powers. He or she can more easily communicate with these beings, gaining a +5% chance of success (no ability check necessary) when attempting divinatory spells such as augury, contact other plane, commune, divination, speak with dead, summon spirits, and so on.\n\nThis ability may also be used to contact the dead without resorting to magic (handy for low-level characters and individuals who do not know magic, such as psionicists). Using pyromancy (divination by candles), tarot cards, and other mystical rites, the character can ask questions of these powers as if using a summon spirit or speak with dead spell (no body required, and there is no applicable time limit).\n\nBefore beginning the contact, the character must prepare for half an hour, making sure that the area has no spirits around to confuse readings. Contact with the dead is established if a successful check is made. A failed roll reveals nothing. If the roll is 10 more under the number needed, a specific spirit can be contacted. A roll of four or more above the needed number (or a 20) reveals incorrect information, perhaps from an evil spirit. Individuals with the psionic ability of spirit sense gain +2 to ability checks.\n\nThe summoner can ask questions of these spirits, but the spirits are not obliged to answer. If annoyed, the spirits can sever the link at will. The questioner can ask 1–3 questions, plus one for every slot above two spent on this proficiency. Contact may not be made more than once per day and is inadvisable more than once per week. The dead do not appreciate being disturbed and may take revenge. The DM can refer to the new 4th-level spell summon spirits for more details about interacting with the dead."
    )
)

let embeddedProficiency2110: Proficiency = Proficiency(
    id: "statecraft",
    name: "Statecraft",
    wikiPageTitle: "Statecraft (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "Unknown",
        relevantAbility: "Unknown",
        checkModifier: 0,
        rawModifier: "Unknown",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Statecraft: This proficiency includes the knowledge and understanding of politics within the state and in the state's dealings with other states.",
        fullText: "## Charlemagne's Paladins Campaign Sourcebook\n\nStatecraft: This proficiency includes the knowledge and understanding of politics within the state and in the state's dealings with other states. It also encompasses the diplomatic skills needed to analyze, guide, and influence people and events to achieve government and personal ends.\n\nA character with this proficiency knows and understands the significance of current events and the major personalities that shape them. He is knowledgeable about the cultures and ambitions of foreign allies and enemies. He also understands the conflicts between prominent counts, churchmen, and royal officers, and he studies the will and whim of the king."
    )
)

let embeddedProficiency2111: Proficiency = Proficiency(
    id: "stewardship",
    name: "Stewardship",
    wikiPageTitle: "Stewardship (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Council of Wyrms"],
    mechanics: ProficiencyMechanics(
        groups: ["Dragons (CWS) General (CPCS)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Younger dragons and kindred often take the stewardship proficiency to help govern the territory of their clans. It provides the administrative knowledge and skills necessary to handle the day -to-day running of a dragon domain.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nYounger dragons and kindred often take the stewardship proficiency to help govern the territory of their clans. It provides the administrative knowledge and skills necessary to handle the day -to-day running of a dragon domain. As most older dragons have little patience for such matters, it falls to trusted vassals and younger family members to handle the proper management of land resources and the servants assigned to them.\n\nA dragon (or demihuman) with this proficiency understands the technical business of land and estate management, as well as the politics and personalities of the ruling class. These characters are alert and sensitive to the power and influence of clan members and demihuman retainers. They know where to seek information and how to achieve the objectives of their dragon lords (and even advance their own personal goals). They recognize the strengths and weaknesses within their area of influence, and they know how to use these to best advantage. Finally, they know how to best impress their dragon lords and whatever guests they may be currently entertaining.\n\nA failed check leads to some social blunder or miscalculation whose ramifications are left to the DM.\n\nHatchlings can't select this proficiency.\n\n## Charlemagne's Paladins Campaign Sourcebook\n\nStewardship: This proficiency provides the administrative knowledge and skills to run a large estate. Land is wealth, and proper management of land resources and the servants and freemen on that land is essential to a noble's well-being. The noble himself needs at least a rudimentary understanding of stewardship, but loyal subordinates are usually entrusted with the management of day-to-day affairs.\n\nA character who has this proficiency understands not only the technical business of land and estate management, but the politics and personalities of the manor and palace. He is alert and sensitive to power and influence in families and retainers of a noble household. He knows where to seek information and how to apply pressure to achieve the objectives of his lord and his own personal ends. He recognizes strengths and weaknesses in a noble household, and he knows how to take advantage of them. He also understands quality and luxury, and he knows how to impress and influence others with hospitality."
    )
)

let embeddedProficiency2112: Proficiency = Proficiency(
    id: "stonemasonry",
    name: "Stonemasonry",
    wikiPageTitle: "Stonemasonry (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Strength",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Strength/Stamina, Wisdom/Intuition",
            characterPointCost: 4,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "A stonemason is able to build structures from stone so that they last many years. He can do simple stone carvings, such as lettering, columns, and flourishes.",
        fullText: "## Player's Handbook\n\nA stonemason is able to build structures from stone so that they last many years. He can do simple stone carvings, such as lettering, columns, and flourishes. The stone can be mortared, carefully fitted without mortar, or loosely fitted and chinked with rocks and earth. A stonemason equipped with his tools (hammers, chisels, wedges, block and tackle) can build a plain section of wall one foot thick, ten feet long, and five feet high in one day, provided the stone has already been cut. A stonemason can also supervise the work of unskilled laborers to quarry stone; one stonemason is needed for every five laborers. Dwarves are among the most accomplished stonemasons in the world; they receive a +2 bonus when using this skill.\n\n## Player's Option: Skills & Powers\n\nStonemasonry: A character with this skill knows how to excavate stone from quarries, cut that stone into blocks, make bricks, mix mortar, lay stone or brick, and carve simple designs and symbols into stone. The mason can lay cobblestones or bricks for roads and courtyards, and the work can include small arches and cantilevered platforms. None of these tasks require proficiency checks. The character's tools include hammers, chisels, trowels, block and tackle, plumb lines, shovels, and wedges. If fully equipped, a typical mason can build a wall, 10' long, 5' high and 1' thick, in one day—if the stone is already cut. The character can erect walls, buildings, pillars, stone abutments for bridges, etc.\n\nThe character can step up the work by making a proficiency check. Also, if the stonemason doesn't have the benefit of the engineering proficiency, checks must be made for wall sections higher than 10', and for structures involving arches or elaborate corners.\n\nA dwarven character receives a +2 bonus when taking this proficiency."
    )
)

let embeddedProficiency2113: Proficiency = Proficiency(
    id: "storytelling",
    name: "Storytelling",
    wikiPageTitle: "Storytelling (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Charisma/Leadership",
            characterPointCost: 5,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "Storytelling: This is the skill of telling tales that can serve to enthrall, entertain, and even educate an audience. With a successful proficiency check, characters can engage listeners in anecdotes, narratives, and yarns.",
        fullText: "Storytelling: This is the skill of telling tales that can serve to enthrall, entertain, and even educate an audience. With a successful proficiency check, characters can engage listeners in anecdotes, narratives, and yarns. For a period of 24 hours after the storytelling, the audience reacts favorably (-1 bonus on reaction rolls) towards the storyteller. A failed roll means that the audience grows bored or, at worst, offended. A character might also use this proficiency when he hears mention of a legend or myth to see whether he has any knowledge of the story behind such a tale."
    )
)

let embeddedProficiency2114: Proficiency = Proficiency(
    id: "style_analysis",
    name: "Style Analysis",
    wikiPageTitle: "Style Analysis (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Style Analysis: This specialized proficiency gives the character knowledge about (not skill in) armed and unarmed combat.",
        fullText: "Style Analysis: This specialized proficiency gives the character knowledge about (not skill in) armed and unarmed combat. After watching someone fight for at least one round, a character with this proficiency can make a Style Analysis check to learn some facts about his subject's fighting style.\n\nIf the character makes his check by the given amount, he learns the facts following that number.\n\n{| class=\"article-table\"\n| 0 || The general style used (e.g., karate, kenjutsu, fencing, etc.).\n|-\n| 2 || How good the practitioner is (e.g., a basic student, an expert, a grand master of the style, etc.).\n|-\n| 4 || Which school of the style is being used (e.g., Odo family sumo wrestling).\n|-\n| 6 || Superficial or transitory weaknesses that the practitioner is currently exhibiting (such as favoring an injured leg). The character with Style Analysis receives a +2 on all attack rolls when fighting the practitioner (unless the practitioner switches styles). The +2 wears off after one day.\n|-\n| 8 || Who the practitioner's teacher probably was (e.g., Odo Kusuke).\n|-\n| 10 || General weaknesses in the practitioner's learning (such as a tendency to favor leftside attacks over right-side ones). The character with Style Analysis receives a +2 on all attack rolls when fighting the practitioner. The +2 wears off after one year.\n|}\n\nNaturally, there are limits to what the character can learn even at the best levels of success. For example, he cannot learn the true identity of a teacher who is not commonly known, though he might be able to identify a style as being the same as another character's, thus inferring a common teacher."
    )
)
