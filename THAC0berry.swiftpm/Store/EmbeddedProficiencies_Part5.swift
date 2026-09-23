import Foundation

/// Parte 5 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency0500: Proficiency = Proficiency(
    id: "cerebral_blind",
    name: "Cerebral Blind",
    wikiPageTitle: "Cerebral Blind (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Caradhaker Only"],
        slotsRequired: 2,
        rawSlots: "2 slots",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "When the illithid attempts to use ESP, charm, or suggestion in a non-psionic campaign, or if an illithid successfully “opens” the mind of a caradhaker (either with contact or with a successful psionic attack in a psionic campaign), the mindstalker can attempt to trigger cerebral blind with a successful proficiency check before the illithid can actually make use of the power (or use the secondary psionic science or devotion upon the victim).",
        fullText: "## Dragon Magazine #230\n\nWhen the illithid attempts to use ESP, charm, or suggestion in a non-psionic campaign, or if an illithid successfully “opens” the mind of a caradhaker (either with contact or with a successful psionic attack in a psionic campaign), the mindstalker can attempt to trigger cerebral blind with a successful proficiency check before the illithid can actually make use of the power (or use the secondary psionic science or devotion upon the victim). If the proficiency check fails, the power (or secondary psionic effect) works normally.\n\nIf the proficiency check succeeds, a complex mental blind comes to the surface of the caradhaker's mind. The blind is a mental maze incorporating both linear and analog elements, hundreds of similar but subtly different mental pathways that confuse the illithid for 1d4+1 rounds. While the illithid is confused, it can take no other action; however, neither can the dwarf do anything but mentally “hold” the blind in place, possibly giving his or her compatriots a few free rounds of action.\n\nIn a psionic campaign, cerebral blind gives the caradhaker up to five chances to close his mind (with a successful save vs. paralysis at a -4 penalty). As soon as the dwarf's mind is closed, the illithid is similarly freed from staring helpless at the cerebral blind."
    )
)

let embeddedProficiency0501: Proficiency = Proficiency(
    id: "ceremony",
    name: "Ceremony",
    wikiPageTitle: "Ceremony (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Ceremony: A priest with this proficiency is well-versed in the various rites, observances, and ceremonies of his temple.",
        fullText: "Ceremony: A priest with this proficiency is well-versed in the various rites, observances, and ceremonies of his temple. He is qualified to oversee normal worship or devotions, but conducting the rites in difficult or unusual situations may require a proficiency check. This proficiency also includes familiarity with ceremonies such as weddings, namings, and funerals, and the priest can perform these services appropriately."
    )
)

let embeddedProficiency0502: Proficiency = Proficiency(
    id: "chakra",
    name: "Chakra",
    wikiPageTitle: "Chakra (Proficiency)",
    redirectAliases: ["Chakra (NWP)"],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Chakra Wisdom-2 Priest",
        fullText: "Chakra Wisdom-2 Priest\n\n1 Slot\n\nCharacters proficient with Chakra healing can locate and use the appropriate gems and crystals to restore a patient's health. Characters with the Mining proficiency gain a +1 bonus when attempting to locate and gather crystals.\n\nChakra\n\nLumped together with Crystal and New Age healing, this method of \"medicine\" is based on the belief that all crystals vibrate at a pitch that's harmonious with various parts of the body, and these wavelengths can be used to restore the patient to health. Practice of chakra healing is as simple as placing particular gemstones around the patient's home, carrying them in a pocket, wearing them around the neck or as some other type of jewelry, and touching them as the urge arises. It's based on the belief of many ancient cultures such as the Greeks, Egyptians, and Babylonians that crystals housed spirits, devas, fiends, or fairies."
    )
)

let embeddedProficiency0503: Proficiency = Proficiency(
    id: "chanting",
    name: "Chanting",
    wikiPageTitle: "Chanting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Charisma",
        checkModifier: 2,
        rawModifier: "+2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The character is an accomplished chanter and can use this ability to help fellow workers or soldiers keep pace. Proficiency checks are used to determine the effectiveness of the chanting.",
        fullText: "## The Complete Bard's Handbook\n\nThe character is an accomplished chanter and can use this ability to help fellow workers or soldiers keep pace. Proficiency checks are used to determine the effectiveness of the chanting.\n\nOn a successful proficiency check, those who can hear the chanter become slightly hypnotized by the rhythmic sound, causing the time spent on arduous, repetitive tasks to pass quickly. The DM can, at his option, adjust results for forced marching, rowing, digging, and other such tasks accordingly.\n\n## The Complete Book of Humanoids\n\nChanting is used to keep fellow workers or soldiers in pace. Proficiency checks are used to determine the effectiveness of a character's chanting.\n\nSuccessful checks mean that those who can hear the chanting character become slightly hypnotized by the rhythmic sound, causing the time spent on arduous, repetitive tasks to pass quickly. The DM can, at his option, adjust results for forced marching, rowing, digging, and other similar tasks accordingly.\n\n## Campaign Option: Council of Wyrms Setting\n\nA chanting dragon can keep its servants working on an even pace or its soldiers marching in perfect step. A dragon's chant is a beautiful, haunting melody that causes all who hear it to become slightly hypnotized by the rhythmic sound. This makes the time spent on arduous, repetitive tasks pass more quickly. Hatchlings cannot select this proficiency."
    )
)

let embeddedProficiency0504: Proficiency = Proficiency(
    id: "chaos_shaping",
    name: "Chaos Shaping",
    wikiPageTitle: "Chaos Shaping (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Planescape"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Chaos shaping allows an anarch to use the powers of the subconscious mind to maintain terrain in Limbo.",
        fullText: "## Planes of Chaos\n\nChaos shaping allows an anarch to use the powers of the subconscious mind to maintain terrain in Limbo. In game terms, this means the character uses Wisdom rating rather than Intelligence on the Terrain Maintenance Table, and is free to perform other actions while doing so. (The Book of Chaos has more details about all this, for the DM's purposes.)\n\n{| class=\"article-table\"\n|+ Terrain Maintenance Table\n! Attribute Rating || Radius Of Terrain Generated || Type Of Terrain Generated\n|-\n| 0 || none || none\n|-\n| 1–4 || 10 feet per attribute point || simple (flat meadow)\n|-\n| 5–10 || 10 yards per attribute point || complex (hills, trees, streams)\n|-\n| 11–18 || 100 yards per attribute point || artificial (buildings, streets)\n|-\n| 19+ || 1 mile per attribute point || includes native animals\n|}\n\nIntelligence for conscious maintenance, Wisdom for unconscious maintenance by anarchs trained in chaos shaping.\n\n## The Planewalker's Handbook\n\nFortunately for travelers, the elemental nature of Limbo shapes itself to the will of a hasher's mind. Most of the time, a basher uses his conscious mind to cause bits of solid ground or other terrain to form from the soup of Limbo. Anyone plunged into the plane's soup can manipulate Limbo's matter to some extent, as detailed on the table below. The problem is, unless a body has the chaos shaping proficiency, it all goes away when he sleeps, gets distracted, or just plain forgets.\n\n{| class=\"article-table\"\n! Attribute\nRating* || Radius of Terrain || Type of Terrain\n|-\n| 0 || none || none\n|-\n| 1—4 || 10 feet per attribute point (flat meadow) || simple\n|-\n| 5—10 || 10 yards per attribute point (hills, trees, streams) || complex\n|-\n| 11—18 || 100 yards per attribute point (buildings, streets) || artificial\n|-\n| 19+ || 1 mile per attribute point (complex buildings) || includes native animals\n|}\n: * Intelligence for conscious maintenance by ordinary folks; Wisdom for unconscious maintenance by anarchs trained in chaos shaping (see below).\n\nCertain individuals, known as anarchs, have the innate ability to shape chaos. (The DM should consult the Planes of Chaos boxed set for details on how to determine if a character has this ability.) Untrained anarchs use the table as explained above. But those designated as anarchs can learn the chaos shaping proficiency, which allows a hasher's mind to maintain the terrain, even when the character is distracted or unconscious.\n\nThe trained anarch uses the powers of the subconscious mind to maintain terrain in Limbo. With the proficiency, the character uses Wisdom rather than Intelligence on the Terrain Maintenance Table, and is free to perform other actions while shaping chaos."
    )
)

let embeddedProficiency0505: Proficiency = Proficiency(
    id: "chariot_jump",
    name: "Chariot-jump",
    wikiPageTitle: "Chariot-jump (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 4,
        rawSlots: "4 Slots",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "Special",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This feat is a nonweapon proficiency, and requires 4 proficiency slots. A character must have the charioteering proficiency in order to learn the feat of the chariot-jump.",
        fullText: "## Celts Campaign Sourcebook\n\nThis feat is a nonweapon proficiency, and requires 4 proficiency slots. A character must have the charioteering proficiency in order to learn the feat of the chariot-jump.\n\nBy using this feat, a character can actually jump a chariot over a chasm, a stream, or a low obstacle such as a fallen tree (or a fallen comrade!). The feat requires a Dexterity check, modified according to the nature of the obstacle. A chasm or stream imposes a penalty of -1 per 3 feet of width (round up), while a standing obstacle imposes a penalty of -1 per foot of height. A prone character is about 1 foot high, and a fallen tree can be somewhat higher. There is a -3 penalty for every character in the chariot apart from the charioteer. In all cases, the chariot requires a clear approach distance of at least 30 yards.\n\nIf the proficiency check is successful, the chariot leaps the obstacle and lands safely on the other side. If not, it slams full-tilt into the obstacle, risking damage to the chariot and injury to the horses and passengers."
    )
)

let embeddedProficiency0506: Proficiency = Proficiency(
    id: "charioteering",
    name: "Charioteering",
    wikiPageTitle: "Charioteering (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 2,
        rawModifier: "+2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Dexterity/Balance, Wisdom/Willpower",
            characterPointCost: 4,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with proficiency in this skill is able to safely guide a chariot, over any type of terrain that can normally be negotiated, at a rate 1/3 faster than the normal movement rate for a chariot driven by a character without this proficiency.",
        fullText: "## Player's Handbook\n\nA character with proficiency in this skill is able to safely guide a chariot, over any type of terrain that can normally be negotiated, at a rate 1/3 faster than the normal movement rate for a chariot driven by a character without this proficiency. Note that this proficiency does not impart the ability to move a chariot over terrain that it cannot traverse; even the best charioteer in the world cannot take such a vehicle into the mountains.\n\n## Player's Option: Skills & Powers\n\nA character with this skill can move a chariot at its normal speed, and effectively drive it over a smooth, wide road. The proficient character requires no check to drive or steer the chariot, including traveling across relatively flat, open countryside, charging into battle, and performing the turns, stops, and starts that might be required on the battlefield.\n\nBy making a proficiency check, the character can guide the chariot through obstacles such as deep fords, steeply-climbing terrain, ditches, and rough or rocky ground. Also, with a successful check, the character can add 1/3 to a chariot's movement rate for the duration of a charge or a march. However, failure of this check means that the chariot moves at its normal rate, but that the horses fatigue in half the normal time. Characters with the animal empathy trait gain a +1 bonus to their ratings with this proficiency.\n\nNote that certain obstacles are simply impassable to chariots, including walls, water too deep (or too muddy on the bottom) to ford, thick forests, and mountainous terrain."
    )
)

let embeddedProficiency0507: Proficiency = Proficiency(
    id: "cheesemaking",
    name: "Cheesemaking",
    wikiPageTitle: "Cheesemaking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Inteligence",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows the character who has it to expertly create cheese from the curds of soured milk.",
        fullText: "This proficiency allows the character who has it to expertly create cheese from the curds of soured milk. A proficiency check is required only when attempting to prepare a truly magnificent wheel of cheese as a special gift or for a special celebration."
    )
)

let embeddedProficiency0508: Proficiency = Proficiency(
    id: "chemistry",
    name: "Chemistry (Proficiency)",
    wikiPageTitle: "Chemistry (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2 slots",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Chemistry (2): Skill roll = Intelligence - 2. Chemists can attempt to brew poisons and acids from natural ingredients.",
        fullText: "## Dragon Magazine #163\n\nChemistry (2): Skill roll = Intelligence - 2. Chemists can attempt to brew poisons and acids from natural ingredients. Acids are usually weak, causing 1-4&nbsp;hp damage but not dissolving materials rapidly. Some acids (aqua regia, hydrochloric acid, etc.) are possible but at a -4 modifier to the chemist's skill roll. If gunpowder is used in the campaign, then it requires this proficiency to manufacture it. Use of this proficiency requires the use of a chemist's lab, equal in price to an alchemical lab, and a certain degree of privacy. Any number of works dealing with the history of technology or science can help pinpoint exactly what is possible in a campaign."
    )
)

let embeddedProficiency0509: Proficiency = Proficiency(
    id: "chicanery",
    name: "Chicanery",
    wikiPageTitle: "Chicanery (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "-1",
        checkModifier: 0,
        rawModifier: "Dexterity",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Chicanery: Chicanery is the art of trickery, and gives the character knowledge of several forms of sleight-of-hand tricks, swindles, and deceptions, and the ability to perform them.",
        fullText: "## Age of Heroes Campaign Sourcebook\n\nChicanery: Chicanery is the art of trickery, and gives the character knowledge of several forms of sleight-of-hand tricks, swindles, and deceptions, and the ability to perform them. These range from the old shell-and-pea game to carefully opening a goose egg, stuffing a baby snake inside, sealing it closed again, and covering it with mud to hide the original crack, then presenting it to be cracked open!"
    )
)

let embeddedProficiency0510: Proficiency = Proficiency(
    id: "chitinworking",
    name: "Chitinworking",
    wikiPageTitle: "Chitinworking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "?",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Spending a single slot on this proficiency allows the chitinworker to make designs in a kreen's chitin. Patterns and pictures can be etched and later colored, gems or other tiny objects can be added, and rings can be placed into holes in the chitin.",
        fullText: "## Thri-Kreen of Athas\n\nSpending a single slot on this proficiency allows the chitinworker to make designs in a kreen's chitin. Patterns and pictures can be etched and later colored, gems or other tiny objects can be added, and rings can be placed into holes in the chitin. Placement of gems and so forth requires the chitinworker to break through the chitin, place the object in the wound, and maintain a watch while new chitin grows around it. A chitinworker can also shape the chitin that grows after a wound, eliminating ugly knobs and spines, or causing artistic projections to form. Too-elaborate constructions will break away from the subject's body rather easily, so chitinworkers tend to stick to simple decoration.\n\nTo'ksa prefer body painting to chitinworking, see the above proficiency, artistic ability"
    )
)

let embeddedProficiency0511: Proficiency = Proficiency(
    id: "circuit_tattoo",
    name: "Circuit Tattoo",
    wikiPageTitle: "Circuit Tattoo (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows a Wizard to imprint a personal circuit tattoo that can store machine-specific spells (see New Spells) for later use.",
        fullText: "## Dragon Magazine #258\n\nThis proficiency allows a Wizard to imprint a personal circuit tattoo that can store machine-specific spells (see New Spells) for later use. Such tattoos look quite alien to those versed in the arcana of magic symbology, but to those who understand machine logic, circuit tattoos are germane. Note that only machine-specific spells can be stored in circuit tattoos because the machine spells were created with the foreknowledge that they must be configured to this proficiency. All other spells are unusable for storage in circuit tattoos.\n\nA Wizard with this proficiency must spend 1d4 + 2 hours with the requisite dyes and needles to imprint a circuit tattoo on a portion of skin. A steady hand determines the quality of the tattoo, but a Circuit Tattoo proficiency check is required to determine whether the tattoo is properly crafted to hold a machine-specific spell. If the tattoo is of proper quality, the Wizard must then cast the appropriate spell into the tattoo, according to the guidelines presented below.\n\nA single rank (1 slot) in Circuit Tattoo allows the Wizard to draw only a single special tattoo on his body, and said tattoo can hold only a 1st-level machine-specific spell. Each additional rank allows the Wizard the option to draw another tattoo and store another 1st-level machine spell or else to enhance a rank 1 tattoo, so it can hold 1st- or 2nd-level machine spells. Each additional rank of Circuit Tattoo allows the Wizard the same choice. Thus, someone with 6 ranks of Circuit Tattoo might have a single tattoo capable of holding one 1st- to 6th-level spell. Alternatively, the Wizard might have two tattoos, each capable of holding one 1st- or 2nd-level machine-specific spell, or six tattoos, each capable of holding one 1st-level spell.\n\nAny spell cast into the tattoo remains until triggered by the Wizard. When the spell is triggered, the Wizard indicates target, range, and other parameters just as if normally casting the spell; but the spell is treated as if cast at the level at which it was originally stored in the tattoo. The tattoo itself remains on the Wizard and can be recharged with a machine-specific spell of the appropriate level."
    )
)

let embeddedProficiency0512: Proficiency = Proficiency(
    id: "city_familiarity",
    name: "City Familiarity",
    wikiPageTitle: "City Familiarity (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "City Familiarity (specific city): A character with this proficiency is unusually knowledgeable about one specific community, chosen when the proficiency is purchased.",
        fullText: "City Familiarity (specific city): A character with this proficiency is unusually knowledgeable about one specific community, chosen when the proficiency is purchased. City Familiarity gives the character a good knowledge of the important political and financial figures in the community, an understanding of which families (and criminal organizations) are most important and how they relate to one another and a good grasp of the city's main streets and byways. The character needs no skill check to call on this information. When the character wants more detailed information—such as the precise layout of streets when he's running away from city guards, the name of the number-two man in a specific crime organization, or the knowledge of which politicians are cheapest to bribe—the character must make a proficiency check with a difficulty modifier determined by the DM.\n\nA character must have lived in a city for at least three months before he can purchase the City Familiarity proficiency and—except for the town in which he grew up—he can do so only with DM permission."
    )
)

let embeddedProficiency0513: Proficiency = Proficiency(
    id: "clockwork_creation",
    name: "Clockwork Creation",
    wikiPageTitle: "Clockwork Creation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency is known to the clockwork mages of Zakhara, and is only taught to those devoted to the craft and to very few others.",
        fullText: "## The Complete Sha'ir's Handbook\n\nThis proficiency is known to the clockwork mages of Zakhara, and is only taught to those devoted to the craft and to very few others. This proficiency allows the individual to produce intricate mechanical devices, machines made up of tiny gears and clockwork mechanisms. This skill is required for a clockwork mage to produce a clockwork device. Merely having the proficiency does not grant a non-clockwork mage the ability to create one. This proficiency is used for checks involving mechanical devices construction or repair."
    )
)

let embeddedProficiency0514: Proficiency = Proficiency(
    id: "close_quarter_fighting",
    name: "Close-quarter Fighting",
    wikiPageTitle: "Close-quarter Fighting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior", "Rogue"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Humanoids with this proficiency have learned to fight in the cramped confines of dungeons and underground lairs.",
        fullText: "Humanoids with this proficiency have learned to fight in the cramped confines of dungeons and underground lairs. In such locations, or in other extremely close fighting conditions, characters armed with bludgeoning or piercing weapons (or their own natural weapons) receive a +2 bonus to attack rolls. Slashing weapons cannot be used in closequarter fighting. This bonus is not cumulative with wild-fighting.\n\nA successful proficiency check at the start of combat yields this bonus. Failure means the humanoid fights normally."
    )
)
