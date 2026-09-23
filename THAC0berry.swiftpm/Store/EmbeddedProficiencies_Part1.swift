import Foundation

/// Parte 1 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency0100: Proficiency = Proficiency(
    id: "acting",
    name: "Acting",
    wikiPageTitle: "Acting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Charisma",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Acting enables a character to skillfully portray various roles. Acting is most often used as a form of entertainment; it can also be useful in aiding a disguise.",
        fullText: "## The Complete Bard's Handbook\n\nActing enables a character to skillfully portray various roles. Acting is most often used as a form of entertainment; it can also be useful in aiding a disguise. If both acting and disguise are known, the proficiency check for either is made with a +1 bonus.\n\nProficiency checks are required only if the actor must portray a particularly difficult character or is attempting an \"ad lib\" role (i.e., a nonrehearsed role or on short notice).\n\n## The Complete Book of Humanoids\n\nThis proficiency allows a character to skillfully portray various roles, often as an entertainment. It can also be used to enhance a disguise. If a character has both acting and disguise proficiencies, the check for either is made with a +1 bonus.\n\nProficiency checks are required only if the actor must portray a particularly difficult role or is attempting to \"ad lib\" without rehearsal.\n\n## The Complete Ninja's Handbook\n\nActing: This proficiency, originally presented in ''The Complete Bard's Handbook'', allows a character to skillfully portray another person. Although acting is usually considered a form of entertainment, it can be useful in helping the ninja accomplish mission goals. If the ninja has both the Acting and Disguise proficiencies, the proficiency check for either is made with a +1 bonus.\n\nProficiency checks for Acting are required only if the actor must portray a particularly difficult character or is attempting to ad lib a role (a nonrehearsed role or a performance on short notice)."
    )
)

let embeddedProficiency0101: Proficiency = Proficiency(
    id: "administration",
    name: "Administration",
    wikiPageTitle: "Administration (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Administration: Many temples own substantial amounts of land and property, wielding power over vast areas. Priests who can manage these lands and turn a tidy profit in the name of the church are always in demand.",
        fullText: "Administration: Many temples own substantial amounts of land and property, wielding power over vast areas. Priests who can manage these lands and turn a tidy profit in the name of the church are always in demand. A character with this proficiency is skilled in the management and accounting of enterprises ranging from the agriculture of an entire province to the vineyards of a single small monastery. He knows how to account for money, plan work, and supervise the collection of taxes or the sale of goods."
    )
)

let embeddedProficiency0102: Proficiency = Proficiency(
    id: "agriculture",
    name: "Agriculture",
    wikiPageTitle: "Agriculture (Proficiency)",
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
            subAbility: "Intelligence/Knowledge",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character has a knowledge of the basics of farming. This includes planting, harvesting, storing crops, tending animals, butchering, and other typical farming chores.",
        fullText: "## Player's Handbook\n\nThe character has a knowledge of the basics of farming. This includes planting, harvesting, storing crops, tending animals, butchering, and other typical farming chores.\n\n## Skills & Powers\n\nThis skill includes automatic success at planting, harvesting, storing crops, using an existing irrigation system, tending animals, and butchering. Tasks that require proficiency checks include designing or making an irrigation system, and weed and pest control. The animal empathy and climate sense traits each provide +2 bonuses to relevant agriculture proficiency checks.\n\n## The Complete Barbarian's Handbook Modifications\n\nAgriculture: Available only in the most advanced barbarian cultures, this proficiency gives the character a primitive knowledge of farming techniques. He knows how to care for small herds of livestock, such as goats and sheep. He can raise modest crops in favorable conditions, usually wheat, rice, and other grains. He knows that plants grow better in cultivated soil, and uses sticks and bones to break the ground. He has little or no understanding of irrigation, fertilization, pest control, food preservation, or crop rotation."
    )
)

let embeddedProficiency0103: Proficiency = Proficiency(
    id: "alchemy",
    name: "Alchemy",
    wikiPageTitle: "Alchemy (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard (PO: Spells & Magic) Priest", "Wizard (W&P of the Realms)"],
        slotsRequired: 2,
        rawSlots: "2 Slots (PO: Spells & Magic) 3 slots (W&P of the Realms)",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3 (PO: Spells & Magic) -2 (W&P of the Realms)",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Alchemy: A wizard with this skill is not necessarily an alchemist or a specialist in the school of alchemy, but he is well-versed in the physical aspects of magical research and the properties of various chemicals, reagents, and substances.",
        fullText: "## Player's Option: Spells & Magic\n\nAlchemy: A wizard with this skill is not necessarily an alchemist or a specialist in the school of alchemy, but he is well-versed in the physical aspects of magical research and the properties of various chemicals, reagents, and substances. If the character has access to a decent laboratory, he can use his knowledge to identify unknown elements or compounds, create small doses of acids, incendiaries, or pyrotechnical substances, or (if he is 9th level or higher) brew potions.\n\nRefer to Chapter 5 for information on the size, cost, and equipment of an alchemical laboratory. Naturally, a wizard may be able to defray some of the costs by sharing his facilities or striking some kind of deal with a local wizard's guild; the DM can come up with the details.\n\nIdentifying substances or samples of unknown material requires 1 to 4 days and a successful proficiency check. Simple materials, such as powdered metals or ores, provide the alchemist with a +1 to +4 bonus on his check, at the DM's discretion. Rare, complex, or damaged or incomplete samples might impose a –1 to –4 penalty.\n\nCreating dangerous substances such as acids or burning powders takes 1d3 days and 20–50 gp or (1d4+1) x 10 per vial, or 2–5 days and 50–100 gp or (1d6+4) x 10 per flask. The alchemist must pass a proficiency check in order to successfully manufacture the substance; failing the check with a natural roll of 20 results in an explosion or other mishap that exposes the character to the effects of his work and damages the laboratory for 10%–60% or 1d6 x 10% of its construction value.\n\nAcid inflicts 1d3 points of damage per vial, or 2d4 points of damage per flask, and continues to injure the victim the next round; the vial inflicts 1 point of damage in the second round, and the flask causes 1d3 points of damage. In addition, the flask is large enough to splash creatures near the target; see Grenadelike Missiles in the (DMG). Acid can also burn out a lock or clasp, forcing an item saving throw.\n\nIncendiaries ignite when exposed to air. A flask of incendiary liquid inflicts damage as per burning oil (2d6 points in the first round and 1d6 in the second.) Again, refer to the DMG . Incendiary powders or liquids can easily start fires if used on buildings, dry brush, or other such surfaces.\n\nPyrotechnic materials resemble incendiaries, but create clouds of billowing smoke. A vial creates a cloud of smoke\n\n5 feet high by 5 feet wide by 5 feet deep, obscuring vision.\n\nA flask creates a cloud of smoke 10 feet high by 10 feet wide by 10 feet deep. The clouds persist for 1d3 rounds, depending on the wind and other conditions.\n\nAlchemy is an expensive hobby, to say the least, and it can be a dangerous one as well. If a player character is abusing this proficiency (i.e., walking into a dungeon with 10 flasks of acid in his pack), the DM can require item saving throws for all those beakers anytime the character slips, falls, or is struck by an opponent.\n\nWizards who specialize in the school of alchemy gain a +2 bonus to their proficiency rating in this skill.\n\n## Warriors & Priests of the Realms\n\nA character with the alchemy proficiency must, when purchasing the proficiency, choose the creation of potions or toxins as his alchemical specialty.\n\nA character who specializes in potions must, by nature, be a priest or wizard. He can research and brew potions more easily than a standard wizard or priest. With this proficiency, the base chance for success \nis increased to 80%, and the fabrication time is cut by 30%.\nA character who specializes in toxins can brew poisons and antidotes. Characters with the herbalism proficiency have only a -1 modifier on proficiency checks in order to accomplish this. Once again, production time for the poison is cut by 30%.\n\nFor more information on potions and poisons, see the AD&D DUNGEON MASTER Guide."
    )
)

let embeddedProficiency0104: Proficiency = Proficiency(
    id: "alertness",
    name: "Alertness",
    wikiPageTitle: "Alertness (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General (Rogue - Thief & Dwarf Handbooks)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Required: Burglar.",
        fullText: "## The Complete Thief's Handbook\n\nRequired: Burglar.\n\nRecommended: All.\n\nA character with this proficiency is able to instinctively notice and recognize signs of a disturbance in the immediate vicinity, reducing by 1 in 10 the character's chance of being surprised whenever he makes a successful proficiency check.\n\n## The Complete Book of Dwarves\n\nA character with this proficiency is able to instinctively recognize signs of disturbance in the immediate vicinity. This gives a +1 bonus on the character's surprise rolls when he makes a successful proficiency check.\n\n## The Complete Book of Humanoids\n\nThis proficiency allows a character to instinctively notice and recognize signs of a disturbance in the immediate vicinity. This ability reduces a character's chance of being surprised by 1 if he makes a successful proficiency check. (Note that this replaces the description of this proficiency in the ''Complete Thief's Handbook''.)\n\n## The Complete Ranger's Handbook\n\nA character with this proficiency is exceptionally attuned to his surroundings, able to detect disturbances and notice discrepancies. A successful proficiency check reduces his chance of being surprised by 1. (This replaces the description of this proficiency in ''The Complete Thief's Handbook''.)\n\nCrossover Groups: General.\n\n## The Complete Barbarian's Handbook\n\nA character with this proficiency has an instinctive knack for noticing disturbances and discrepancies in the immediate vicinity. A successful proficiency check reduces the character's chance of being surprised by 1. (This replaces the description of the alertness proficiency in ''The Complete Thief's Handbook''.)\n\nCrossover Group: General.\n\n## Campaign Option: Council of Wyrms Setting\n\nAlertness allows a dragon to instinctively notice and recognize signs of a disturbance in the immediate vicinity. This proficiency reduces a dragon's chance of being surprised by 1 if it makes a successful proficiency check. Hatchlings can take this proficiency.\n\n## Shaman\n\nCharacters with this proficiency have an instinctive knack for noticing disturbances and discrepancies in the immediate vicinity. A successful proficiency check reduces the character's chance of being surprised by one. (This replaces the description of the alertness proficiency in The Complete Thief's Handbook.)"
    )
)

let embeddedProficiency0105: Proficiency = Proficiency(
    id: "alms",
    name: "Alms",
    wikiPageTitle: "Alms (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Alms: Some orders of priests rely on the charity of others for their support and livelihood. A character with this proficiency is able to find food, shelter, and clothing in return for the benefit of his wisdom and a blessing or two for his hosts.",
        fullText: "Alms: Some orders of priests rely on the charity of others for their support and livelihood. A character with this proficiency is able to find food, shelter, and clothing in return for the benefit of his wisdom and a blessing or two for his hosts. The quality of the charity the priest finds may vary widely, depending on the wealth of his prospective hosts, their piety and their recognition of his deity, and the way the priest presents himself. Generally, if there's shelter to be had, the priest can make use of it, but obtaining food or clothing for his companions may require a nonweapon proficiency check at the DM's discretion."
    )
)

let embeddedProficiency0106: Proficiency = Proficiency(
    id: "anatomy",
    name: "Anatomy",
    wikiPageTitle: "Anatomy (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard (Spells & Magic) Wizard", "Priest (Necromancer)"],
        slotsRequired: 2,
        rawSlots: "2 Slots (Spells & Magic) 1 Slot (Necromancer)",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2 (Spells & Magic) +0 (Necromancer)",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency reflects a character's detailed knowledge of the structure and arrangement of the human body, including the location and function of bones, muscles, organs, and other soft tissues.",
        fullText: "## Spells & Magic\n\nThis proficiency reflects a character's detailed knowledge of the structure and arrangement of the human body, including the location and function of bones, muscles, organs, and other soft tissues. This skill has two distinct uses for a wizard; first of all, knowledge of anatomy provides the character with a +2 bonus on any healing proficiency checks he attempts. Secondly, the wizard can use this skill to repair corpses that have been badly damaged. With a successful proficiency check, the wizard can strengthen and reinforce a body, making it more suitable for animation as a mindless undead. This provides a hit point bonus of +1 per die for skeletal remains, or a bonus of +2&amp;nbsp;hp per die for a creature to be animated as a zombie.\n\n## The Complete Book of Necromancers\n\nThis proficiency involves the knowledge of the secret mysteries and intricacies of the human body, including the structure, function, and location of bones, muscles, organs, and other soft tissues. This skill provides the scholarly foundation for the Anatomist's special abilities. This proficiency also comes in handy with certain necromantic spells (such as corpse link, spectral voice, and graft flesh), which require fresh body parts that have been carefully harvested from cadavers.\n\nThis proficiency also has some less gruesome benefits. A detailed knowledge of anatomy can help with both the treatment of disease and the accurate artistic representation of the human body. Characters with the anatomy nonweapon proficiency automatically increase their skill with healing and artistic ability proficiencies (+2 bonus to both ability checks)."
    )
)

let embeddedProficiency0107: Proficiency = Proficiency(
    id: "ancient_geography",
    name: "Ancient Geography",
    wikiPageTitle: "Ancient Geography (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1 or 2",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters with this proficiency are familiar with the location and size of settlements and cities in their native region at some point in the past.",
        fullText: "Characters with this proficiency are familiar with the location and size of settlements and cities in their native region at some point in the past. A successful proficiency check allows characters to determine where a city's limits were during the period they are familiar with, recognize a ruined keep as an ancient ducal seat, and whatever else information the DM deems may have been recorded in ancient documents. If two skill slots are devoted to it, characters' knowledge extends to an entire nation or domain in the campaign setting.\n\nThis proficiency gives a +1 modifier to the characters' spirit lore proficiencies in relation to checks in the region they are familiar with."
    )
)

let embeddedProficiency0108: Proficiency = Proficiency(
    id: "ancient_history",
    name: "Ancient History",
    wikiPageTitle: "Ancient History (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Rogue", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition, Intelligence/Knowledge",
            characterPointCost: 3,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character has learned the legends, lore, and history of some ancient time and place.",
        fullText: "## Player's Handbook\n\nThe character has learned the legends, lore, and history of some ancient time and place. The knowledge must be specific, just as a historian would specialize today in the English Middle Ages, the Italian Renaissance, or the Roman Republic before Caesar. (The DM either can have ancient periods in mind for his game or can allow the players to name and designate them.) Thus, a player character could know details about the Age of Thorac Dragonking or the Time of the Sea-Raiders or whatever else was available.\n\nThe knowledge acquired gives the character familiarity with the principal legends, historical events, characters, locations, battles, breakthroughs (scientific, cultural, and magical), unsolved mysteries, crafts, and oddities of the time. The character must roll a proficiency check to identify places or things he encounters from that age. For example, Rath knows quite a bit about the Coming of the Trolls, a particularly dark period of dwarven history. Moving through some deep caverns, he and his companions stumble across an ancient portal, sealed for untold ages. Studying the handiwork, he realizes (rolls a successful proficiency check) that it bears several seals similar to those he has seen on \"banned\" portals from the time of Angnar, doorways to the legendary realm of Trolhel.\n\n## Player's Option: Skills & Powers\n\nCharacters with this proficiency are familiar with the legends, rulers, and writings of a specific historical period in the campaign world. They will recognize, without a proficiency check, items, scrolls, artwork, etc. of that period. They will know the main historical figures, such as kings and powerful villains, and the major circumstances of those individuals' lives and deaths. With a successful proficiency check they will recall lesser figures, such as lords, knights, and heroes, and recall legendary tales, important sigils, and perhaps be able to decipher a small bit of text, symbols, or hieroglyphics. The obscure knowledge trait provides a +3 to this character's proficiency rating.\n\n## Campaign Option: Council of Wyrms Setting\n\nThe dragon learns the legends, lore, and history of an ancient time and place, including principle legends, events, characters, locations, battles, breakthroughs (scientific, cultural, and magical), unsolved mysteries, crafts, and oddities of the times. Common specific topics of knowledge are the founding of the Council of Wyrms and various historical periods in the Io's Blood chain. Hatchlings can't select this proficiency.\n\n## Shaman\n\nFor tribal shamans, this proficiency always centers on the spirits whom the community reveres. Tribal shamans with this proficiency, upon making a successful check, receive +10% to the chance that a spirit is \"home\" when they attempt to contact it.\n\nFor other shamans, the history proficiencies operate as normal, although any shaman may choose to specialize in lore about the spirits."
    )
)

let embeddedProficiency0109: Proficiency = Proficiency(
    id: "animal_handling",
    name: "Animal Handling",
    wikiPageTitle: "Animal Handling (Proficiency)",
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
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Willpower",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "Proficiency in this area enables a character to exercise a greater-than-normal degree of control over pack animals and beasts of burden.",
        fullText: "## Player's Handbook\n\nProficiency in this area enables a character to exercise a greater-than-normal degree of control over pack animals and beasts of burden. A successful proficiency check indicates that the character has succeeded in calming an excited or agitated animal; in contrast, a character without this proficiency has only a 20% chance of succeeding in the attempt.\n\n## Player's Option: Skills & Powers\n\nThis proficiency allows characters to automatically steer carts, plow horses, etc. With a successful proficiency check, they can soothe domesticated animals and beasts of burden which become agitated or frightened. The characters receive a +1 bonus to proficiency checks made with any of the animal-riding proficiencies, and they receive a +2 bonus to their proficiency rating if they have the animal empathy trait.\n\n## Note from The Complete Ranger's Handbook\n\nA ranger's animal empathy ability (see Chapter 2) can produce essentially the same calming effect on an animal as the animal handling proficiency. If a ranger also has the animal handling proficiency, he may attempt to soothe an animal either by making a proficiency check or by using his animal empathy ability—but not both.\n\nIf an animal is among a ranger's followers, neither animal empathy nor the animal handling proficiency is necessary to control the follower. Use the guidelines in Chapter 3 instead.\n\nThe animal handling proficiency has no effect on a ranger's species enemy.\n\n## Note from The Complete Paladin's Handbook\n\nAnimal Handling: As explained in Chapter 2, a paladin can soothe his bonded mount automatically; the Animal Handling proficiency isn't necessary. The proficiency may be used normally to calm other animals of the same species as the bonded mount, as well as other pack animals and beasts of burden."
    )
)

let embeddedProficiency0110: Proficiency = Proficiency(
    id: "animal_husbandry",
    name: "Animal Husbandry",
    wikiPageTitle: "Animal Husbandry (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Animal Husbandry is the nonweapon proficiency equal to the Groom skill. This proficiency allows the character to properly maintain animals by providing the care they need to stay healthy and fit.",
        fullText: "## Dragon Magazine #247\n\nAnimal Husbandry is the nonweapon proficiency equal to the Groom skill. This proficiency allows the character to properly maintain animals by providing the care they need to stay healthy and fit."
    )
)

let embeddedProficiency0111: Proficiency = Proficiency(
    id: "animal_lore",
    name: "Animal Lore",
    wikiPageTitle: "Animal Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge, Wisdom/Intuition",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency enables a character to observe the actions or habitat of an animal and interpret what is going on. Actions can show how dangerous the creature is, whether it is hungry, protecting its young, or defending a nearby den.",
        fullText: "## Player's Handbook\n\nThis proficiency enables a character to observe the actions or habitat of an animal and interpret what is going on. Actions can show how dangerous the creature is, whether it is hungry, protecting its young, or defending a nearby den. Furthermore, careful observation of signs and behaviors can even indicate the location of a water hole, animal herd, predator, or impending danger, such as a forest fire. The DM will secretly roll a proficiency check. A successful check means the character understood the basic actions of the creature. If the check fails by 4 or less, no information is gained. If the check fails by 5 or more, the character misinterprets the actions of the animal.\n\nA character may also imitate the calls and cries of animals that he is reasonably familiar with, based on his background. This ability is limited by volume. The roar of a tyrannosaurus rex would be beyond the abilities of a normal character. A successful proficiency check means that only magical means can distinguish the character's call from that of the true animal. The cry is sufficient to fool animals, perhaps frightening them away or luring them closer. A failed check means the sound is incorrect in some slight way. A failed call may still fool some listeners, but creatures very familiar with the cry automatically detect a false call. All other creatures and characters are allowed a Wisdom check to detect the fake.\n\nFinally, animal lore increases the chance of successfully setting snares and traps (for hunting) since the character knows the general habits of the creature hunted.\n\n## Player's Option: Skills & Powers\n\nAdventurers with animal lore have a store of knowledge about animal behavior, and without any proficiency check will know the basic feeding and social habits (i.e. herding, nesting, etc.) of animals with which they have past experience.\n\nWith a proficiency check, a character can determine whether an observed animal is intending to attack or to flee, or predict that animals will come along a trail at a certain time of day. This character gets a +2 bonus to checks made using the set snares proficiency.\n\nThe character can imitate the calls of wild animals (except for very large creatures). A successful check means that the imitation is virtually perfect, and even fools animals of the same type. A failed check might fool other characters, but will not deceive the animals.\n\n## The Complete Book of Dwarves\n\nThe effectiveness of this proficiency varies according to the background of the dwarf. A dwarf who has lived his entire life underground knows little about animals living above ground, but he will be very knowledgeable about those underground. In this case, a dwarf gains a +1 modifier to his Intelligence when dealing with underground animals, but has no knowledge of surface creatures. A sundered dwarf who fears the underground may only have knowledge of above ground animals.\n\nDwarves with backgrounds of trade with other races or who live both below and above ground, may have normal animal lore proficiency with no modifiers, knowing both above and below-ground animals.\n\nA character may imitate the calls and cries of animals as described in the Player's Handbook.\n\n## Note from The Complete Paladin's Handbook\n\nAlthough this proficiency allows a character to imitate animal sounds, this ability neither helps nor hinders the paladin when summoning his bonded mount.\n\n## The Complete Barbarian's Handbook Modifications\n\nAll barbarians automatically have the animal lore proficiency for creatures in their homeland terrain (see Chapter 1). In situations where a proficiency check is required, the DM should make an Intelligence check instead.\n\nIf a barbarian spends a slot on this proficiency, he acquires a knowledge of animal lore for creatures other than those native to his homeland terrain. He then uses the rules in the animal lore proficiency description in the ''Player's Handbook''."
    )
)

let embeddedProficiency0112: Proficiency = Proficiency(
    id: "animal_noise",
    name: "Animal Noise",
    wikiPageTitle: "Animal Noise (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General (Rogue - Thief's Handbook)"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Recommended: Bandit, Bounty Hunter, Smuggler.",
        fullText: "## The Complete Thief's Handbook\n\nRecommended: Bandit, Bounty Hunter, Smuggler.\n\nA character with this proficiency is capable of imitating noises made by various animals. A successful proficiency check means that only magic can distinguish the noise from that of the actual animal being imitated. A failed die roll means that the sound varies from the correct noise in some slight way.\n\nIf the die roll fails, this does not mean that all creatures hearing the noise know that the sound is fake. While creatures and humanoids that are very familiar with the noise know this automatically, other creatures or characters in earshot may require Wisdom checks to determine if they detect the fake.\n\nBandits and Smugglers often use this ability for communication on the job, almost as a variant dialect of thieves' cant.\n\n## The Complete Book of Humanoids\n\nA character with this proficiency can imitate the noises made by various animals. A successful check means the character's noise cannot be distinguished from that of the actual animal, except by magical means.\n\nA failed check produces a sound that varies from the animal's in some slight way. Those who are very familiar with the animal will recognize the intended mimicry at once. Other characters must make successful Wisdom checks to determine if they also realize the animal noise is an imitation."
    )
)

let embeddedProficiency0113: Proficiency = Proficiency(
    id: "animal_rending",
    name: "Animal Rending",
    wikiPageTitle: "Animal Rending (Proficiency)",
    redirectAliases: ["CBarbH Table 33"],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 2,
        rawModifier: "+2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency confers expertise in skinning and butchering animal carcasses. It lets a character derive the maximum amount of food from a carcass (see Table 33 in the hunting proficiency entry).",
        fullText: "This proficiency confers expertise in skinning and butchering animal carcasses. It lets a character derive the maximum amount of food from a carcass (see Table 33 in the hunting proficiency entry). It also lets him harvest valuable products from the carcass without damaging them. Such products typically include furs, horns, teeth, hides, and organs. (See the appendix for more about animal products.) Use of this proficiency requires access to the necessary tools.\n\nNo proficiency checks are necessary to butcher most animals, but the DM may require checks in unusual situations. For instance, a check may be required to butcher an animal the character has never seen before, or to successfully harvest a delicate body part (say, the eye of an immature beholder). If the check fails, the character is only able to obtain an average amount of food (the number to the left of the slash on Table 33), or he damages the body part he was attempting to harvest.\n\nCrossover Group: Warrior.\n\n{| class=\"article-table\"\n|+ Table 33: Rations Produced Per Animal\n! Size of game\nanimal || Number of rations*\n|-\n| S || 1-2/2-3\n|-\n| M || 3-4/4-6\n|-\n| L || 5-8/-12\n|-\n| H || 9-15/15-25\n|}\n: * A ration is the food necessary to feed an average adult for one day. The figures to the left of the slash indicate the number of rations obtained when a character of average skill handles the butchering. The figure to the right show the number of rations obtained by a character with the animal rending proficiency."
    )
)

let embeddedProficiency0114: Proficiency = Proficiency(
    id: "animal_training",
    name: "Animal Training",
    wikiPageTitle: "Animal Training (Proficiency)",
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
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Willpower, Charisma/Leadership",
            characterPointCost: 4,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "Characters with this proficiency can train one type of creature (declared when the proficiency is chosen) to obey simple commands and perform tricks.",
        fullText: "## Player's Handbook\n\nCharacters with this proficiency can train one type of creature (declared when the proficiency is chosen) to obey simple commands and perform tricks. A character can spend additional proficiencies to train other types of creatures or can improve his skill with an already chosen type. Creatures typically trained are dogs, horses, falcons, pigeons, elephants, ferrets, and parrots. A character can choose even more exotic creatures and monsters with animal intelligence (although these are difficult to control).\n\nA trainer can work with up to three creatures at one time. The trainer may choose to teach general tasks or specific tricks. A general task gives the creature the ability to react to a number of nonspecific commands to do its job. Examples of tasks include guard and attack, carry a rider, perform heavy labor, hunt, track, or fight alongside soldiers (such as a war horse or elephant). A specific trick teaches the trained creature to do one specific action. A horse may rear on command, a falcon may pluck a designated object, a dog may attack a specific person, or a rat may run through a particular maze. With enough time, a creature can be trained to do both general tasks and specific tricks.\n\nTraining for a general task requires three months of uninterrupted work. Training for a specific trick requires 2d6 weeks. At the end of the training time, a proficiency check is made. If successful, the animal is trained. If the die roll fails, the beast is untrainable. An animal can be trained in 2d4 general tasks or specific tricks, or any combination of the two.\n\nAn animal trainer can also try to tame wild animals (preparing them for training later on). Wild animals can be tamed only when they are very young. The taming requires one month of uninterrupted work with the creature. At the end of the month, a proficiency check is made. If successful, the beast is suitable for training. If the check fails, the creature retains enough of its wild behavior to make it untrainable. It can be kept, though it must be leashed or caged.\n\n## Player's Option: Skills & Powers\n\nAnimal Training: When players choose this proficiency, they must declare what type of creature their characters will learn to train. Suggestions include dogs, falcons, parrots, horses, pigeons, elephants, and ferrets. More exotic animals can be chosen at the DM's option. Monsters with animal intelligence are another possibility, though they can be difficult to control—in effect, requiring more frequent proficiency checks.\n\nTraining of an animal requires a rather lengthy period of time—a matter of weeks, at least, for even the most basic tasks. A character who spends this amount of time will succeed at the training (no check necessary). Such tasks include dogs being trained to stay, come when summoned, and guard a specific location; pigeons returning to the roost; falcons hunting and killing game; and horses bearing saddles and obeying simple riding commands.\n\nMore elaborate tasks also take time to teach, and these require proficiency checks: dogs patrolling a circuit, or retrieving specific objects; and horses performing the maneuvers of a knightly charger are examples.\n\nA character with the animal empathy trait gains a +1 bonus to this proficiency rating.\n\n## Note from The Complete Ranger's Handbook\n\nRangers are more efficient than other characters at training animals. In the Standard method (see Chapter 3) a ranger needs two months to train an animal to perform a general task. Training for a specific trick requires 2d4 weeks. At the end of the training period, he makes a proficiency check. If the check is successful, the animal has learned the task or trick. If the check fails, the ranger may make a second attempt at teaching it the same task (requiring another two months) or trick (requiring another 2d4 weeks), followed by a second proficiency check. If this second proficiency check fails, the animal is too dumb or too stubborn to learn that particular trick or task. The ranger may repeat the training process with a different trick or task. An animal can learn a maximum of 2d4 tasks or tricks, in any combination of the two.\n\nThe animal training proficiency isn't necessary to train followers. Use the guidelines in Chapter 3 instead.\n\nA species enemy can't be trained by the ranger, neither with the follower guidelines nor the animal training proficiency.\n\n## Note from The Complete Paladin's Handbook\n\nA paladin doesn't need the Animal Training proficiency to teach tricks and tasks to his bonded mount. However, if he has this proficiency in the same species as the bonded mount, he earns a +2 bonus to his checks when training the bonded mount. The bonus applies to the bonded mount only, not to other animals of the same species. Should the paladin acquire a different bonded mount, he earns the bonus only if he has the Animal Training proficiency in the same species as the new mount.\n\n## The Complete Barbarian's Handbook Modifications\n\nTo acquire this proficiency, a barbarian must come from a society where animals have been domesticated as pets, mounts, or workers. Generally, a barbarian can only train animals native to his homeland terrain, though the DM may approve related species. For example, with the DM's permission, an arctic barbarian may train a brown bear, even if the polar bear is the only species native to his homeland."
    )
)
