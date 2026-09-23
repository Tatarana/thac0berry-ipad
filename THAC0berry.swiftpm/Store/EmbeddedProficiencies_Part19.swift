import Foundation

/// Parte 19 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency1900: Proficiency = Proficiency(
    id: "riding_sea_based",
    name: "Riding, Sea-based",
    wikiPageTitle: "Riding, Sea-based (Proficiency)",
    redirectAliases: ["Riding, Sea-Based (Proficiency)", "Underwater Riding (Proficiency)"],
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
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: nil,
            characterPointCost: 4,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows the character to handle a particular species of sea-based mount The type of mount must be specified when the proficiency is acquired. The character may spend additional slots to enable him to handle other species.",
        fullText: "## The Complete Ranger's Handbook\n\nThis proficiency allows the character to handle a particular species of sea-based mount The type of mount must be specified when the proficiency is acquired. The character may spend additional slots to enable him to handle other species.\n\nIn addition to riding the mount, the proficiency enables the character to do the following:\n* When the mount is on the surface of the water, the character can leap onto its back and spur it to move in the same round. No proficiency check is required.\n* The character can urge the mount to leap over obstacles in the water that are less than 3' high and 5' across (in the direction of the jump). No proficiency check is required. Greater jumps require a proficiency check, with bonuses or penalties assigned by the DM according to the height and breadth of the obstacle and the type and size of mount. Failure means the mount balks; an immediate second check determines if the character stays on the mount or falls off.\n* The character can spur the mount to great speeds. If an initial proficiency check fails, the mount resists moving faster than normal. Otherwise, the mount begins to move up to 2d6 feet per round beyond its normal rate. Proficiency checks must be made every five rounds. So long as the checks succeed, the mount continues to move at the faster rate for up to two turns. After the mount moves at this accelerated rate for two turns, its rate then drops to 2/3 of its normal rate. It can move no faster than 2/3 of its normal rate until allowed to rest for a full hour.\n\nIf the second or any subsequent check fails, the mount's movement drops to half its normal rate. It continues to move at this half-speed rate until allowed to rest for an hour.\n* If a sea-based mount on the surface of the water is attacked, it will normally submerge unless it makes a successful morale roll. If the morale roll fails, the rider can command the mount to re-surface by making a successful proficiency check. If the check fails, the rider can attempt another check each round thereafter, so long as he is physically able. While submerged with the mount and attempting to force it to surface, the rider risks drowning (see Chapter 14 of the ''Player's Handbook''). Because he's exerting himself, the number of rounds the rider can hold his breath is equal to half his Constitution score.\n\nCrossover Groups: General."
    )
)

let embeddedProficiency1901: Proficiency = Proficiency(
    id: "rope_use",
    name: "Rope Use",
    wikiPageTitle: "Rope Use (Proficiency)",
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
            subAbility: "Dexterity/Aim, Wisdom/Intuition",
            characterPointCost: 2,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency enables a character to accomplish amazing feats with rope. A character with rope use proficiency is familiar with all sorts of knots and can tie knots that slip, hold tightly, slide slowly, or loosen with a quick tug.",
        fullText: "## Player's Handbook\n\nThis proficiency enables a character to accomplish amazing feats with rope. A character with rope use proficiency is familiar with all sorts of knots and can tie knots that slip, hold tightly, slide slowly, or loosen with a quick tug. If the character's hands are bound and held with a knot, he can roll a proficiency check (with a -6 penalty) to escape the bonds.\n\nThis character gains a +2 bonus to all attacks made with a lasso. The character also receives a +10% bonus to all climbing checks made while he is using a rope, including attempts to belay (secure the end of a climbing rope) companions.\n\n## Player's Option: Skills & Powers\n\nRope Use: A character with this proficiency can tie knots of all kinds without a proficiency check. The character adds +2 to all mountaineering proficiency checks that involve rope and also gains +10% to climbing chances—if the climb involves a rope.\n\nIf the character is tied up with ropes, or seeks to untie a permanent knot, a proficiency check is required. Success means that the bonds or knots come undone in 2d6 minutes."
    )
)

let embeddedProficiency1902: Proficiency = Proficiency(
    id: "rowing",
    name: "Rowing",
    wikiPageTitle: "Rowing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Strength",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Rowing: Though possibly considered a part of seamanship, rowing is an important skill among the Greeks. Both the biremes and triremes depended upon the strength, stamina, and coordination of their rowers.",
        fullText: "## Age of Heroes Campaign Sourcebook\n\nRowing: Though possibly considered a part of seamanship, rowing is an important skill among the Greeks. Both the biremes and triremes depended upon the strength, stamina, and coordination of their rowers. The character with this skill knows how to use the oars of a vessel, how to pull in concert with other oarsmen, the special maneuvers for ramming other ships, and how to avoid overextending or tiring while rowing. Those without this proficiency tire more quickly and acquire blisters and muscle pulls while trying to learn to row properly."
    )
)

let embeddedProficiency1903: Proficiency = Proficiency(
    id: "rulership",
    name: "Rulership",
    wikiPageTitle: "Rulership (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Council of Wyrms"],
    mechanics: ProficiencyMechanics(
        groups: ["Dragons"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency enhances a dragon's skills as a ruler. Dragons who take this proficiency before attaining a domain of their own learn the techniques of leadership and often serve as administrators and ambassadors for their clans.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nThis proficiency enhances a dragon's skills as a ruler. Dragons who take this proficiency before attaining a domain of their own learn the techniques of leadership and often serve as administrators and ambassadors for their clans.\n\nWhen dealing with vassals of its own clan, a dragon receives a +2 reaction bonus for a successful proficiency check. When dealing with those from outside its domain (or clan territory), a dragon's rulership abilities give a+1 bonus, reflecting the authority and tone of command it displays.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency1904: Proficiency = Proficiency(
    id: "running",
    name: "Running",
    wikiPageTitle: "Running (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Constitution",
        checkModifier: -6,
        rawModifier: "-6",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Strength/Stamina, Constitution/Fitness",
            characterPointCost: 2,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character can move at twice his normal movement rate for a day. At the end of the day he must sleep for eight hours.",
        fullText: "## Player's Handbook\n\nThe character can move at twice his normal movement rate for a day. At the end of the day he must sleep for eight hours. After the first day's movement, the character must roll a proficiency check for success. If the die roll succeeds, the character can continue his running movement the next day. If the die roll fails, the character cannot use his running ability the next day. If involved in a battle during a day he spent running, he suffers a -1 penalty to his attack rolls.\n\n## Player's Option: Skills & Powers\n\nRunning: Characters can add 1/3 their normal top speed to their movement rates for up to 1 turn. After this, they must spend a turn resting, or 6 turns engaged in normal activity before they can sprint again.\n\nAlso, characters can jog steadily, moving at twice their normal movement rates over the course of a day. Eight hours of rest is mandatory after such a stint. Following rest, the characters can make proficiency checks. Success means they can run normally during the upcoming day; failure indicates they cannot use the running ability that day."
    )
)

let embeddedProficiency1905: Proficiency = Proficiency(
    id: "sacred_legends",
    name: "Sacred Legends",
    wikiPageTitle: "Sacred Legends (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency is well-learned in the myths, stories, and tales of a single religion. This knowledge is not the same as the theology and practices that are gained with the religion proficiency.",
        fullText: "## Dragon Magazine #241\n\nA character with this proficiency is well-learned in the myths, stories, and tales of a single religion. This knowledge is not the same as the theology and practices that are gained with the religion proficiency. The character, when confronted with a question or evidence of the faith’s past, may roll this proficiency to recall a specific event or legend that has relevance. For instance, when an ancient idol is discovered, a successful proficiency check might reveal that the statue resembles a long-forgotten paramour of the goddess, and the character could retell some of the important stories about them.\n\nAdditional proficiencies can be chosen to gain knowledge of the sacred legends of other religions."
    )
)

let embeddedProficiency1906: Proficiency = Proficiency(
    id: "sage_knowledge",
    name: "Sage Knowledge",
    wikiPageTitle: "Sage Knowledge (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Sage Knowledge: This proficiency represents a specialized area of knowledge or learning.",
        fullText: "Sage Knowledge: This proficiency represents a specialized area of knowledge or learning. A character with this skill is a fully qualified sage in the area of study chosen and is capable of answering questions concerning the topic after some time spent researching. Refer to Table 62 : Sage Modifiers and Table 63 : Research Times in the DMG. As noted in the DMG , a sage requires an excellent library as a resource—at least 50 to 100 books, costing no less than 10,000 gp altogether. Naturally, a character may be able to strike a deal with a university, monastery, or wizards' guild hall in order to gain access to their library.\n\nIn addition to his ability to perform sage research, the character's high level of learning allows him to make field observations or attempt to come up with knowledge off the top of his head. For example, a sage who studies botany may attempt a proficiency check in order to identify a particular plant, while one who studies toxicology may be able to identify a poison by its symptoms in a victim. These on-the-spot observations should be limited to information any expert could reasonably come up with in the field— identifying a common gemstone is one thing for a geologist, but making a guess about the electrical conductivity of quartz crystal or the enchantments of a magical gem is a different matter entirely.\n\nPurchasing this proficiency at its base cost (2 slots or 5 character points) gives the sage a broad overview of the area of study in question, allowing him to answer general or specific questions in the field. For an additional proficiency slot (or 2 CPs), the character may become an expert in one particular aspect of the topic. For example, a botanist may spend another slot to specialize in moss and lichens, ferns, or all plants found in a particular climate or ecosystem. This detailed knowledge allows the character to attempt to answer exacting questions in the field. The fields of study available to a sage include:\n\nAlchemy: This is the study of magical chemistry, especially as it applies to elemental transmutations and potions, oils, and magical compounds or solvents. Unlike the proficiency of alchemy, the sage knowledge of alchemy concentrates on theories and principals, not on the practical day-to-day manufacture of specific compounds and substances. An alchemist specialist wizard or a character with the alchemy proficiency gains a +2 bonus to his proficiency rating in this area of sage knowledge.\n\nArchitecture: This is the study of the development, theories and styles of architecture. (The architecture proficiency, on the other hand, represents the practical execution of workable building plans.) A sage with this field of study can attempt to identify the age, origins, and general purpose of ruined buildings or structures.\n\nArt: The sage is familiar with the great works of the past as well as the works of the best contemporary artists. If he specializes in one particular art form (sculpture, paintings, ornamental pottery, etc.) he is able to identify works of the masters, spot fakes, and appraise pieces for sale value.\n\nAstrology: This is the history and theoretical background of astrology, not the actual art of prediction. Someone with the astrology proficiency knows that Planet X passing in front of Constellation Y means trouble, but a sage knows why that's a sign of ill fortune. In addition, the sage has the ability to perform historical astrology by working backwards to determine the stars' and planet's alignments for thousands of years in the past. An expert in this field may be familiar with the constellations and beliefs of vanished or dead cultures.\n\nAstronomy: For the astrologer, planets and constellations are representations of greater powers. The astronomer, on the other hand, assigns no characteristics or indications to these heavenly bodies, and instead concentrates on studying their movements in the skies. He can predict eclipses, anticipate the return of comets or meteor showers, and answer questions about the locations or predicted locations of various planets or other bodies in the skies.\n\nBotany: This is the study of plants, ranging from simple cataloguing and observation to detailed studies of life-cycles and ecologies. Areas of specialization include simple plants, water plants, grasses and brush, flowering plants, domesticated plants, plant diseases, and ecological systems such as rain forest, tundra, prairie, etc.\n\nCartography: Cartography is the art of map-making. A sage who specializes in this field knows where to find maps for any given region or area, knows how to interpret maps using various forms of notation, and can attempt to solve or complete encrypted or partial maps.\n\nChemistry: While alchemy focuses on the study of magical substances, chemistry concentrates on the study of the properties of mundane substances. Note that a character with the alchemy proficiency is assumed to use a fair amount of mundane chemistry to produce acids, solvents, and pyrotechnic substances.\n\nCryptography: This is the study of codes, ciphers, and puzzles. A sage with skill in cryptography can attempt to break codes or solve written puzzles with time and study.\n\nEngineering: The character is familiar with the science of building devices, engines, and structures. Sage knowledge of engineering provides a +2 bonus to the character's nonweapon proficiency score in engineering, if he has both proficiencies. The character can specialize in small machines, large machines (water wheels, etc.), siege engineering, fortifications, bridges and roads, or buildings.\n\nFolklore: The sage studies legends and folk tales. By spending another proficiency slot, he can specialize in the folklore of a particular culture or region.\n\nGenealogy: This is the study of lines of descent. A sage with this skill knows research techniques and sources for tracing family trees and is also familiar with the histories of the important royal and noble families.\n\nGeography: A sage with this knowledge has learned about the lands and cultures of his world. He knows general principles of cartography, topography, climatology, and sociology, and can identify individuals or artifacts from other lands.\n\nGeology: Geology is the study of landforms, rock, and the physical makeup of the earth. A sage with knowledge in this area can add a +2 bonus to his rating in the mining nonweapon proficiency and can attempt a proficiency check to identify various sorts of gemstones or precious minerals.\n\nHeraldry: Coats of arms, banners, flags, and standards are all emblazoned with heraldic designs. A sage with this skill is familiar with the evolution of heraldry and the significance of various symbols and colors. He can identify common coats of arms on sight and knows where to research obscure or unknown devices. This area of knowledge adds a +2 bonus to a character's heraldry nonweapon proficiency score.\n\nHistory: A sage with this skill has an excellent grasp of history and the historical methods. Unlike a character with the ancient or local history proficiencies, a sage with this skill is a generalist, but he can be considered an expert on a particular era or culture by spending an additional slot to specialize. Whether or not the historian knows something off the top of his head doesn't matter—he knows exactly where to look when he needs to find out the details of a person's life or an important event. Skill in this field of knowledge provides a +2 bonus to the character's proficiency score in ancient history or local history.\n\nLanguages: A character with a modern language proficiency knows how to speak a second language, and a character with an ancient languages proficiency knows how to read a second language, but a sage who specializes in languages is concerned with the study of the language itself—grammar, syntax and constructs, and vocabulary and word origin. His expertise is limited to one particular tongue, but for each additional slot the linguist may add another language to his field of expertise. This knowledge adds a +2 bonus to the linguist's rating in any modern or ancient language proficiencies he possesses.\n\nLaw: A sage with this field of study is an expert on matters of law. He is familiar with any national constitutions or charters, the origin and history of the law, and important matters of precedent. He can examine contracts, warrants, orders, or decrees and determine if there is a way to enforce or avoid them.\n\nMathematics: The study of abstract or theoretical mathematics may seem unusual in a fantasy setting, but it dates back thousands of years in our own world; the ancient Greeks laid the groundwork for geometry, while algebra was a pastime of Islamic scholars and nobles before the European Renaissance. A dimensionalist gains a +2 bonus on his proficiency rating in this area of study.\n\nMedicine: A sage with this skill studies both the history and development of medicine, as well as current methods and treatments. This provides the character with a +2 bonus to his healing nonweapon proficiency score. In addition, the character may be able to come up with treatments for nonmagical diseases or injuries.\n\nMeteorology: This is the study of weather and weather patterns. A sage with this skill knows historical records and prediction methods. In the field, his knowledge of weather provides a +2 bonus to any weather sense proficiency checks he makes.\n\nMusic: The sage knows the theory and notation systems of music and has studied the works of the great masters. He can attempt to identify unknown pieces or decipher musical puzzles.\n\nMyconology: Myconology is the study of fungi. A myconologist can identify samples of fungus, mold, or spores. He is familiar with dangerous or monstrous varieties as well and may be able to spot these in the wild before he or his companions come to harm. His knowledge of mushrooms and molds gives him a +2 bonus to herbalism nonweapon proficiency checks.\n\nOceanography: A sage with this skill studies the ocean, including weather, marine biology, navigation and charting, and undersea topography. An oceanographer may be able to explain unusual phenomena at sea or discover the location of wrecks or other sites of interest.\n\nPhilosophy: The study of philosophy is the study of logic, ethics, aesthetics, and metaphysics (for game purposes, anyway), and a sage with expertise in this field is conversant with the great thinkers and arguments of his race or culture.\n\nPhysics: In most AD&amp;D campaigns, the study of physics centers around mechanics and thermodynamics; some of the more advanced fields of study simply haven't been invented yet.\n\nPlanes, Inner: Most individuals in a campaign have little to no knowledge of worlds beyond the one in which they live, but a sage with expertise in this field is familiar with the characteristics and properties of the Ethereal Plane and the various Elemental Planes beyond that. He understands how the Inner Planes are aligned and how the multiverse is put together. If he spends an additional slot to specialize, he can be an expert on a particular plane, capable of answering exacting questions on the topic.\n\nPlanes, Outer: The great religions of a campaign tend to disseminate a very limited view of the multiverse, centering on the home of their deity and that of their deity's principal foes. A sage who studies this field has a general understanding with the general arrangement of all the Outer Planes and the characteristics of the Astral Plane. For an additional slot, he can specialize in a particular plane, learning the general properties of its layers, its chief inhabitants and domains, and other important details.\n\nSchool of Magic: A sage with expertise in a school of magic is familiar with the important theories, works, and great mages of that field. By engaging in research and passing a proficiency check, the sage could identify spells or magical items belonging to the school by the item's general effects or appearance. For example, if he was a student of the school of force, he could identify a wand of force or beads of force as if he were trying to answer a specific question. If the sage is also a wizard, he gains a +5% bonus to his chance to learn spells from the school in question. A specialist wizard gains a +2 to his score in this proficiency if the school of magic is his own specialty.\n\nSociology: This is the study of social structures, customs, mores, and ways of life. The sage is also acquainted with past societies and their customs.\n\nTheology: A sage with expertise in this area is conversant with the tenets and beliefs of most major religions, gaining a +2 bonus to his religion nonweapon proficiency check. In addition, he studies the theories and lore surrounding the powers and boundaries of the gods themselves. With research, a theologist can determine what a particular god might or might not be capable of doing.\n\nToxicology: This is the study of poisons, both natural and artificial. A sage with expertise in toxicology can identify poisons both from samples and from examining the symptoms of a poisoned victim. By using toxicology, a sage can also gain a +1 to any healing proficiency check dealing with poisons.\n\nZoology: Zoology is the study of animals. A sage who acquires knowledge in this area has a good overall grasp of the science of zoology, and in addition, he is considered a specialist in one general class of animals or monsters. Each additional slot he spends on this proficiency adds one more type or class to his expertise. Classes of animals available include birds, reptiles, mammals, fish, amphibians, insects, amorphous monsters (slimes, jellies, and molds), aquatic monsters, insectile monsters, reptilian monsters, mammalian monsters, hybrid monsters (griffins, perytons, etc.), and any other reasonable class or grouping the DM allows.\n\nA zoologist can identify common species in the field with a successful proficiency check and may be able to predict behavior or capabilities based on his knowledge of the creature in question."
    )
)

let embeddedProficiency1907: Proficiency = Proficiency(
    id: "sagecraft",
    name: "Sagecraft",
    wikiPageTitle: "Sagecraft (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Council of Wyrms"],
    mechanics: ProficiencyMechanics(
        groups: ["Dragons"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Only dragon characters with the dragon sage kit can select the Sagecraft noncombat proficiency.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nOnly dragon characters with the dragon sage kit can select the Sagecraft noncombat proficiency. Once slotted, the sage gains the knowledge and skill to cast both wizard and priest spells of limited schools and spheres as outlined in the dragon sage kit description.\n\nAdditionally, this proficiency gives the sage bonuses to all lore checks, as described in the kit benefits above.\n\nThis proficiency reflects a sage's familiarity with scholarly research methods and tools, as well as his ability to use specific forms of wizard and priest magic—namely, those most helpful to gathering facts and information."
    )
)

let embeddedProficiency1908: Proficiency = Proficiency(
    id: "salvage",
    name: "Salvage",
    wikiPageTitle: "Salvage (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: -6,
        rawModifier: "-6",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows a Wizard to remove useful bits of functional modules from a deactivated sheen. Such items can sometimes be integrated into items capable of aiding a chaser in future adventures, as described under the Artifice proficiency.",
        fullText: "## Dragon Magazine #258\n\nThis proficiency allows a Wizard to remove useful bits of functional modules from a deactivated sheen. Such items can sometimes be integrated into items capable of aiding a chaser in future adventures, as described under the Artifice proficiency. This proficiency can never be used on an active sheen; it is applicable only on a disabled machine (a machine brought to below 0 hit points).\n\nParticular sheens contain particular modules; see the ''Apprentice's'' description of each sheen to determine what types of modules each possesses. Moreover, the state in which a machine is “deactivated” determines whether salvage is an option. The Salvage Results Table shows how the method used to deactivate the sheen affects the Salvage proficiency check.\n\nTo use this proficiency, the Wizard must spend 1d6 + 2 turns attempting to “salvage” a disabled sheen, at the end of which time the proficiency check is rolled. If successful, the Sheenchaser has managed to detach an undamaged module and—just as importantly—not damage the module while removing it.\n\nThe choice of module removed is governed partly by chance, so the Salvage Results Table governs the choice of module removed. Each additional rank of this skill (1 slot cost) allows the sheenchaser to modify the result of the roll by +1/-1. If a rolled result indicates a module that the sheen does not or cannot possess, reroll the attempt.\n\nOnce a module is removed, it can be successfully incorporated into a useful item for the Wizard with a successful Artifice check. (See the Mechaarana section for examples of new Items created from salvaged material.)\n\n{| class=\"article-table\"\n|+ Salvage Modifiers Table\n! colspan=\"2\" | Deactivated Primarily Through:\n|-\n| Melee || -1\n|-\n| Spells, intrusive || -2\n|-\n| Spells, nonintrusive || +3\n|-\n| colspan=\"2\" | Melee Damage includes all damage from swords, axes, stones, etc. Intrusive spells include all spells that inflict damage directly by channeling energy, such as lightning bolt, fireball, cold, acid, etc. Nonintrusive Spells include spells that deactivate a sheen without causing direct physical damage, including hold machine, pulse, prang, etc.\n|}\n{| class=\"article-table\"\n|+ Salvage Results Table\n! 1d6 || Module Salvaged\n|-\n| 1 || Sensor Ring\n|-\n| 2 || Capacitor\n|-\n| 3 || Lifter*\n|-\n| 4 || Field generator\n|-\n| 5 || Sample Arms\n|-\n| 6 || Plasma generator**\n|-\n| colspan=\"2\" | \n: * Only drifters have lifter modules.\n: ** Only renders and miners have plasma modules.\n|}"
    )
)

let embeddedProficiency1909: Proficiency = Proficiency(
    id: "screed_lore",
    name: "Screed Lore",
    wikiPageTitle: "Screed Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A rare proficiency, screed lore offers expertise in the care and collection of books, tomes, scrolls, and the like. This proficiency is crucial to librarians, sages, and scribes.",
        fullText: "## Dragon Magazine #241\n\nA rare proficiency, screed lore offers expertise in the care and collection of books, tomes, scrolls, and the like. This proficiency is crucial to librarians, sages, and scribes. A check would be required whenever the character handles a particularly delicate or worn manuscript. This proficiency also allows a collection to be searched and a specific volume found. Failed rolls indicated problems from the annoying (a torn page or lost book) to the disastrous (an entire scroll crumbles to dust at the slightest touch) depending on how badly the check fails.\n\nThis proficiency also provides some knowledge of the safeguards used in protecting books. This knowledge covers not only mundane traps, like poison painted along the edges of the pages, but also magical means of safeguarding libraries. The character can attempt a roll at a -5 modifier to notice any evidence of such traps."
    )
)

let embeddedProficiency1910: Proficiency = Proficiency(
    id: "scribe",
    name: "Scribe",
    wikiPageTitle: "Scribe (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Scribe: Before printing came into common use, professional scribes created books by copying manuscripts.",
        fullText: "Scribe: Before printing came into common use, professional scribes created books by copying manuscripts. Even after printing presses were in widespread use, scribes were in demand for their calligraphy and the quality of their illuminated (or illustrated) pages. A character with this proficiency is familiar with a scribe's techniques for preparing pages and working both swiftly and accurately. This is an invaluable skill for a wizard; with a successful proficiency check, the character gains a +5% bonus to any rolls he must make in order to copy or transcribe a spell into his spell book or onto a scroll."
    )
)

let embeddedProficiency1911: Proficiency = Proficiency(
    id: "sculpting",
    name: "Sculpting",
    wikiPageTitle: "Sculpting (Proficiency)",
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
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character with this proficiency can render realistic objects out of stone and clay.",
        fullText: "The character with this proficiency can render realistic objects out of stone and clay. A high level of sculpting proficiency, coupled with the artistic talent trait, means the character can create statues, statuettes, busts, and other objects of rare and valuable beauty."
    )
)

let embeddedProficiency1912: Proficiency = Proficiency(
    id: "seamanship",
    name: "Seamanship",
    wikiPageTitle: "Seamanship (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition, Dexterity/Balance",
            characterPointCost: 3,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character is familiar with boats and ships. He is qualified to work as a crewman, although he cannot actually navigate.",
        fullText: "## Player's Handbook\n\nThe character is familiar with boats and ships. He is qualified to work as a crewman, although he cannot actually navigate. Crews of trained seamen are necessary to manage any ship, and they improve the movement rates of inland boats by 50 percent.\n\n## Player's Option: Skills & Powers\n\nSeamanship: These characters are trained to help operate galleys and sailing ships. They can row, hang rigging, steer a helm, patch canvas, and repair hulls (with tar or pitch). This proficiency does not allow characters to navigate.\n\nThe captain of a vessel, who presumably possesses this skill at a high level, must make proficiency checks to avoid certain hazards of the sea. Such a seaman might take the ship into a reef-lined bay with no difficulty if a local pilot is there to act as a guide. But if the captain has to pick a path through coastal breakers, a failed check might mean a bump on the bottom of the hull, or that the ship has run aground. Bad weather and treacherous currents can penalize these proficiency checks, while fair breezes and superb visibility should convey positive modifiers."
    )
)

let embeddedProficiency1913: Proficiency = Proficiency(
    id: "seamstress_tailor",
    name: "Seamstress/Tailor",
    wikiPageTitle: "Seamstress/Tailor (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Dexterity/Aim, Intelligence/Reason",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character can sew and design clothing. He can also do all kinds of embroidery and ornamental work.",
        fullText: "## Player's Handbook\n\nThe character can sew and design clothing. He can also do all kinds of embroidery and ornamental work. Although no proficiency check is required, the character must have at least needle and thread to work.\n\n## Player's Option: Skills & Powers\n\nA character with this proficiency can sew garments out of all types of cloth—wool, cotton, silk, and well-tanned leather being the most common in the typical campaign world. The character can use needle and thread. The amount of time required for a job naturally varies by its complexity, but proficiency checks are only required if the tailor is attempting to make something truly unique and spectacular—a coronation gown for the queen, perhaps.\n\nThe tailor can also make field repairs on clothing that has been damaged by the vagaries of adventuring. These repairs typically require proficiency checks, with failure indicating that the patch will hold for only a very short time. A halfling character gains a +1 to this proficiency rating."
    )
)

let embeddedProficiency1914: Proficiency = Proficiency(
    id: "seance",
    name: "Seance",
    wikiPageTitle: "Seance (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Psionicist",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist"],
        slotsRequired: 2,
        rawSlots: "2 slots",
        relevantAbility: "Charisma",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with the seance proficiency knows the methods used to contact spirits, deities, or extraplanar powers.",
        fullText: "## Dragon Magazine #200\n\nA character with the seance proficiency knows the methods used to contact spirits, deities, or extraplanar powers. Using ouija boards, pyromancy (divination by candles), tarot cards, etc., the PC can ask questions of these powers as if using a speak with dead spell (no body required, and no time limit given).\n\nBefore beginning the contact, the character must prepare himself for half an hour, making sure the area has no spirits around to confuse readings. Contact with the dead can be established if a successful check is made; a failed roll reveals nothing. If the roll was more than 10 under the number needed, a specific spirit can be contacted. A roll of four or more above the needed number (or a 20) reveals incorrect information—a malevolent spirit, etc.\n\nThe psionicist can ask questions of these spirits, but the spirits are not obliged to answer. If annoyed, the spirit can sever the link at will. The character may ask 1-3 questions, plus one for every slot above two spent on this proficiency. Contact may not be made more than once per day and is unadvisable more than twice a week. The dead hate being disturbed, and some may take revenge.\n\nHowever, even the dead are not omniscient, and mistakes can be made, as noted in the Seance Results Table.\n\n{| class=\"article-table\"\n|+ Seance Results Table\n! 1d100 || Force contacted || Correctness: general question || Correctness: specific question\n|-\n| 01-40 || Spirit, Intelligence 11 – || 70% || 20%\n|-\n| 41-60 || Spirit, Intelligence 12-14 || 80% || 30%\n|-\n| 61-70 || Spirit, Intelligence 15-17 || 90% || 40%\n|-\n| 71-75 || Spirit, Intelligence 18 + || 95% || 50%\n|-\n| 76-80 || Outer-planar creature || 98% || 60%\n|-\n| 81-99 || Malevolent spirit || * || *\n|-\n| 00 || Deity ** || 100% || 90%\n|}\n: * Always gives plausible, incorrect answer.\n: ** Deities hate to be bothered, and will ignore or punish most of those who annoy them unless the gods are especially merciful or the questions directly concern them."
    )
)
