import Foundation

/// Parte 16 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency1600: Proficiency = Proficiency(
    id: "oriental",
    name: "Oriental",
    wikiPageTitle: "Oriental (Proficiency)",
    redirectAliases: ["Oriental (NWP)"],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Warrior", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Oriental Intelligence—3",
        fullText: "Oriental Intelligence—3\n\n1 Slot\n\nPriest, Warrior, Wizard- Those proficient in Oriental herbalism can decrease the recovery time needed for reduced statistics in half. Sapped Strength from the touch of the undead, befuddled Intelligence, and strained Constitutions are examples of ills that the application of Oriental healing can help restore. Those familiar with some type of martial art gain a +1 bonus to their Oriental proficiency check, as both stem from the same ideology.\n\nOriental\n\nChinese or Oriental medicine encompasses many differing techniques such as acupuncture, cupping, moxibustion, and qigong. Acupuncture is the application of thin needles to the various pres sure points of the body. Cupping is the use of a small, heated glass or bamboo cup to induce vacuum and applying it to the epidermis in order to stimulate local circulation. Moxibustion is the placement of a smoldering plug of dried and powdered herbs either on or in close proximity to the body. Qigong is deep breathing and movement exercise, most famous for its part in martial arts styles like Tai Chi Chuan."
    )
)

let embeddedProficiency1601: Proficiency = Proficiency(
    id: "orienteering",
    name: "Orienteering",
    wikiPageTitle: "Orienteering (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "N/A",
        relevantAbility: "N/A",
        checkModifier: 0,
        rawModifier: "N/A",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge, Wisdom/Intuition",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "This is the ability to keep one's bearings on roadless, trackless land. Proficient characters will not get lost as long as they can either see the sky or have the use of a compass.",
        fullText: "This is the ability to keep one's bearings on roadless, trackless land. Proficient characters will not get lost as long as they can either see the sky or have the use of a compass. This means that they can maintain track of a given direction, keeping themselves and their companions traveling in a straight line.\n\nCharacters who possess a map and can track their direction of travel can arrive at specific points—towns, ferry crossings, bridges, monuments, wells, springs, etc.—without proficiency checks.\n\nIf the map is slightly erroneous, or lacking in crucial details, the characters will have to make successful proficiency checks to accurately arrive at a specific point. This check can be modified for increased difficulty based on poor weather or major problems with the map."
    )
)

let embeddedProficiency1602: Proficiency = Proficiency(
    id: "painting",
    name: "Painting",
    wikiPageTitle: "Painting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "N/A",
        relevantAbility: "N/A",
        checkModifier: 0,
        rawModifier: "N/A",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Dexterity/Aim, Wisdom/Intuition",
            characterPointCost: 2,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency is skilled at rendering images with oil, brush, and canvas. The artist can create reasonable portrayals of people, landscapes, and monsters, and he possesses a knowledge of perspective, shading, and composition.",
        fullText: "## Player's Handbook\n\nA character with this proficiency is skilled at rendering images with oil, brush, and canvas. The artist can create reasonable portrayals of people, landscapes, and monsters, and he possesses a knowledge of perspective, shading, and composition. If this proficiency is coupled with the artistic talent trait, the character receives +2 to his base painting score and can create stunningly realistic works, capable of stirring profound reactions in observers—and perhaps worth gold to wealthy NPCs.\n\n## Player's Option: Skills & Powers\n\nPainting: A character with this proficiency is skilled at rendering images with oil, brush, and canvas. The artist can create reasonable portrayals of people, landscapes, and monsters, and he possesses a knowledge of perspective, shading, and composition. If this proficiency is coupled with the artistic talent trait, the character receives +2 to his base painting score and can create stunningly realistic works, capable of stirring profound reactions in observers—and perhaps worth gold to wealthy NPCs."
    )
)

let embeddedProficiency1603: Proficiency = Proficiency(
    id: "papermaking",
    name: "Papermaking",
    wikiPageTitle: "Papermaking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Papermaking: A character with this skill knows how to manufacture paper. This can be an invaluable skill for a wizard, since paper may be fairly rare in many campaign settings.",
        fullText: "Papermaking: A character with this skill knows how to manufacture paper. This can be an invaluable skill for a wizard, since paper may be fairly rare in many campaign settings. Rag pulp, bark, linen, hemp, and wood were all used to make paper in medieval times. The material is pounded or pressed flat and treated with various chemical compounds to bind and strengthen it. At the DM's option, the character may also be familiar with the manufacture of parchment and vellum. Parchment is finely-scraped animal skin, treated with lime and other chemicals; vellum is unusually supple and smooth parchment taken from very young animals.\n\nA wizard who makes his own paper can reduce the costs of manufacturing a spell book by 50%, although this requires one to two weeks of time and a suitable work area. Normally, a traveling spell book costs 100 gp per page, and a standard spell book costs 50 gp per page. If the wizard also knows the bookbinding nonweapon proficiency and binds the volume himself, the cost of the spell book is reduced by 75% altogether."
    )
)

let embeddedProficiency1604: Proficiency = Proficiency(
    id: "persuasion",
    name: "Persuasion",
    wikiPageTitle: "Persuasion (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest - PO:SM General - Ranger"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: -2,
        rawModifier: "-2 - PO:SM +0 - Ranger",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Persuasion: Unlike oratory, which relies on emotion and rhetoric, the art of persuasion is built around intelligent arguments and personal charm.",
        fullText: "## Player's Option: Spells & Magic\n\nPersuasion: Unlike oratory, which relies on emotion and rhetoric, the art of persuasion is built around intelligent arguments and personal charm. A character with this proficiency is able to present especially cogent arguments and explanations in conversation with an individual or small group. With a successful proficiency check, he can convince them to take moderate actions they may be considering already; for example, he may convince city guards to leave without making arrests if a brawl's already finished by the time they get there, or he may convince a court official that he needs an audience with the king. If the player's thoughts and arguments are particularly eloquent and acute, the proficiency check is made with a +1 to +4 bonus.\n\n## The Complete Ranger's Handbook\n\nThis proficiency enables the character to make a compelling argument to convince a subject NPC character to see things his way, respond more favorably, or comply with a request. The character engages the NPC in conversation for at least 10 rounds (meaning that the subject must be willing to talk with the character in the first place); subjects whose attitudes are threatening or hostile aren't affected by this proficiency.\n\nA successful proficiency check means that the subject's reaction is modified by +2 in favor of the character (see Table 59 in Chapter 11 of the DUNGEON MASTER Guide). This bonus is not cumulative with any other reaction modifiers, such as those derived from Charisma; other reaction modifiers don't apply. For every additional slot a character spends on this proficiency, he boosts the reaction modifier by +1 (for example, spending two slots on this proficiency gives a +3 reaction bonus).\n\nCrossover Groups: General."
    )
)

let embeddedProficiency1605: Proficiency = Proficiency(
    id: "pest_control",
    name: "Pest Control",
    wikiPageTitle: "Pest Control (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Thief"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency is used to keep dwarf strongholds free of pests like rats, carrion crawlers, jermalaines, kobolds, and other small creatures.",
        fullText: "## The Complete Book of Dwarves\n\nThis proficiency is used to keep dwarf strongholds free of pests like rats, carrion crawlers, jermalaines, kobolds, and other small creatures. Similar to the set snares proficiency, it is concerned with catching underground pests and does not use snares. Traps are set to trigger metal cages, drop nets, or iron doors that shut off individual tunnel sections. Spring traps or small deadfalls may be rigged (damage 1d6 maximum) using this proficiency. There is no -4 modifier when using pest control to trap larger creatures.\n\nOnly thief characters may use this proficiency to rig larger traps suitable for human or orc sized creatures. These traps may include crossbows, larger deadfalls, and spiked springboards.\n\nA character with this proficiency does not have the ability to make the items required for these devices, he can only set the traps and their triggers.\n\nA proficiency check must be rolled when the trap is set. A failed proficiency check means that the trap will fail to operate. It may not have been set properly, was poorly concealed, or it was too small or too large for the creature to trigger.\n\nSetting a trap takes one hour and the character must have the proper equipment and materials with him.\n\nCharacters with the animal lore proficiency gain a +2 bonus when attempting to set traps to catch animal pests."
    )
)

let embeddedProficiency1606: Proficiency = Proficiency(
    id: "pharmacy",
    name: "Pharmacy",
    wikiPageTitle: "Pharmacy (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This skill allows the character to preserve medicinal herbs and chemicals and prepare medicines from both natural and inorganic ingredients.",
        fullText: "## Dragon Magazine #200\n\nThis skill allows the character to preserve medicinal herbs and chemicals and prepare medicines from both natural and inorganic ingredients. On a successful pharmacy check, the pharmacist can create a medicine to cure certain ailments (the DM should assign a +3 to -10 modifier, depending on the severity and rarity of the disease) using herbs and chemicals. A failed check either does nothing or has nonlethal side effects (DM choice), but a check of 20 results in poisoning!"
    )
)

let embeddedProficiency1607: Proficiency = Proficiency(
    id: "philosophy",
    name: "Philosophy",
    wikiPageTitle: "Philosophy (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Philosophy: This confers a knowledge of current philosophies as well as an understanding of older or more conservative modes of thought.",
        fullText: "## Age of Heroes Campaign Sourcebook\n\nPhilosophy: This confers a knowledge of current philosophies as well as an understanding of older or more conservative modes of thought. This includes questions of morality and the state of human existence; theories of government; thoughts on the proper forms for art, music, and drama; and scientific inquiry, as well as mathematics and aesthetics. Successful use of this proficiency makes characters known for wisdom and thoughtfulness by those who hear them speak, and might give them insight into riddles, puzzles, or problems which occur during the game."
    )
)

let embeddedProficiency1608: Proficiency = Proficiency(
    id: "phlogiston_navigation",
    name: "Phlogiston Navigation",
    wikiPageTitle: "Navigation, Phlogiston (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard", "Priest"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This is the art of navigating from one sphere to another, a separate skill from navigating within a single crystal sphere. It is a difficult and risky activity, but it is sometimes necessary when an planetary locator is not available.",
        fullText: "## The Complete Spacefarer's Handbook\n\nThis is the art of navigating from one sphere to another, a separate skill from navigating within a single crystal sphere. It is a difficult and risky activity, but it is sometimes necessary when an planetary locator is not available.\n\nA spelljamming ship that enters the Flow normally moves randomly, arriving at some other crystal sphere within 10–100 days. With a successful proficiency check from the ship's navigator, the ship arrives at the chosen destination within that time. Of course, the destination must be one that is normally reachable; if there is no path from the current sphere to the desired one, a successful check on this proficiency will not create one.\n\nIf the proficiency check is failed, the ship arrives at a random sphere. (The DM should make the proficiency roll so that the player does not know if he succeeded or not.) On a natural 20, the ship drifts in the phlogiston for 20–200 days; such ships may be in grave danger of exhausting their air supply before returning to a random crystal sphere."
    )
)

let embeddedProficiency1609: Proficiency = Proficiency(
    id: "pilot_airship",
    name: "Pilot Airship",
    wikiPageTitle: "Pilot Airship (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency covers all aspects of flying a Xan Kraban. Characters with this proficiency can serve as competent crewmembers, steer the ship, and know how to maintain the level of uhl gas in the ship.",
        fullText: "## Dragon Magazine #244\n\nThis proficiency covers all aspects of flying a Xan Kraban. Characters with this proficiency can serve as competent crewmembers, steer the ship, and know how to maintain the level of uhl gas in the ship. This proficiency does not provide the benefits of the rope use or navigation proficiencies, which are also useful to windsailors."
    )
)

let embeddedProficiency1610: Proficiency = Proficiency(
    id: "planar_direction_sense",
    name: "Planar Direction Sense",
    wikiPageTitle: "Planar Direction Sense (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Planescape"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Since standard compass directions as most primes know them don't exist on the planes, this proficiency allows another method of judging direction.",
        fullText: "## The Planewalker's Handbook\n\nSince standard compass directions as most primes know them don't exist on the planes, this proficiency allows another method of judging direction. Planar direction sense enables cutters to utilize landmarks and other benchmarks to keep from getting lost. While a planewalker may not know which way is north, he does know how to get back to Plague-Mort, the tower of Nirrecles, or the gate to Sigil."
    )
)

let embeddedProficiency1611: Proficiency = Proficiency(
    id: "planar_sense",
    name: "Planar Sense",
    wikiPageTitle: "Planar Sense (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Planescape"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Similar to the skill of weather sense, this proficiency allows a basher to predict the imminent conditions on any plane.",
        fullText: "## The Planewalker's Handbook\n\nSimilar to the skill of weather sense, this proficiency allows a basher to predict the imminent conditions on any plane. Random changes in air breathability, gravity, ground stability, temperature change, and so on can be predicted up to one hour before they occur. For example, the use of this proficiency on the ever-changing plane of Limbo can warn of a sudden rain of fire, a wave of acidic snow, or a blast of poisonous air.\n\nThis proficiency is of great use on chaotic planes, but is rarely helpful on the unchanging planes of law."
    )
)

let embeddedProficiency1612: Proficiency = Proficiency(
    id: "planar_survival",
    name: "Planar Survival",
    wikiPageTitle: "Planar Survival (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Planescape"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency encompasses a number of different proficiencies, one specific to each plane. No basher will ever learn them all, since there're just too many different environments for a body to fully understand them all.",
        fullText: "## The Planewalker's Handbook\n\nThis proficiency encompasses a number of different proficiencies, one specific to each plane. No basher will ever learn them all, since there're just too many different environments for a body to fully understand them all.\n\nA character with this proficiency knows the general characteristics of a particular plane. Moreover, when on that plane, a basher can determine whether something is safe or not. This proficiency allows a character to check to see whether a plant's edible, the water's safe to drink, or if the gravity is going to change over the next ridge. Only constant and established dangers can be avoided, for this proficiency has its basis in the study of established texts. Something not even suggested in a book (because it is too new, too rare, or too remote) is impossible to detect.\n\nPlanar survival doesn't give a body unlimited knowledge about everything she comes across, however. A plane is just too blasted big for a berk to know everything about it, so the DM is still free to throw plenty of surprises at a character with this skill. Planar survival doesn't grant any knowledge about the denizens of a plane, only the environment.\n\nThis proficiency is a modified version of the \"plane knowledge\" proficiency (described in ''The Factol's Manifesto [2611]''), which is available only to members of the Fated."
    )
)

let embeddedProficiency1613: Proficiency = Proficiency(
    id: "planetology",
    name: "Planetology",
    wikiPageTitle: "Planetology (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard", "Priest"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with the planetology proficiency has studied the various types of planets that may be found within crystal spheres.",
        fullText: "## The Complete Spacefarer's Handbook\n\nA character with the planetology proficiency has studied the various types of planets that may be found within crystal spheres. He is able to identify signs of groundling civilization from space and can determine the climate and probable inhabitants of a world by studying it for a short time (and making a successful proficiency check)."
    )
)

let embeddedProficiency1614: Proficiency = Proficiency(
    id: "planology",
    name: "Planology",
    wikiPageTitle: "Planology (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Planescape"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard", "Priest"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: ": ''Ah, um... the etheroscope says...",
        fullText: ": ''Ah, um... the etheroscope says... it's going to snow.'' — Biologist Gorand Drummerhaven who hasn't a clue about planology.\n\n## The Planewalker's Handbook\n\nThis proficiency allows a basher to examine planar events and predict the future, using a device called a celestial etheroscope (see page 134). It is similar to the astrology proficiency, although its results are more general.\n\nBy observing various planar events through an etheroscope, a character can predict the tides of fortune on a plane. A blood can obtain five different types of results.\n\n{| class=\"article-table\"\n| (1) || Catastrophe. Something horrible is going to happen on the plane in question.\n|-\n| (2—5) || Bad luck. All signs point to negative karma on the plane in question. Minor bad things happen in the lives of the natives, and visitors are at -1 on all die rolls until the phase passes.\n|-\n| (6—15) || Status quo. Things aren't going to change drastically for a while.\n|-\n| (16—19) || Good fortune. The plane is blessed with positive energy. Good things happen for the natives, and nonnatives receive a + 1 bonus to all die rolls for the duration of the phase.\n|-\n| (20) || Providence. Something extremely wonderful happens on the plane (for the inhabitants).\n|}\n\nNumbers in parentheses allow the DM to determine random occurrences (roll 1d20), although most often a DM should choose an appropriate result based on his foreknowledge of upcoming adventures. Random rolls, however, may provide adventure hooks. Regardless, good or bad luck has nothing to do with alignment; some wonderful development for the yugoloths on Gehenna may mean something terrible for the forces of good everywhere else. Similarly, a person of evil alignment who visits Elysium during a phase of good fortune still receives the benefit, since providence transcends alignment. Phases of fortune can last as long as the DM wishes, but no more than a week is suggested, and sometimes they might last no more than a few minutes.\n\nDetermining the current tides of fortune on a plane requires a regular proficiency check. The check modifier has a cumulative -1 penalty for each day into the future the priest or wizard attempts to look. Failed checks at any time reveal inaccurate results, or no results at all. Failure also denies any further attempts for that time period."
    )
)
