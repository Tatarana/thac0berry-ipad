import Foundation

/// Parte 17 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency1700: Proficiency = Proficiency(
    id: "poetry",
    name: "Poetry",
    wikiPageTitle: "Poetry (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Proficiency in poetry includes the skills of reciting poetry and judging its quality. It also indicates that the character has a repertoire of poems memorized for recital at any time.",
        fullText: "## The Complete Bard's Handbook\n\nProficiency in poetry includes the skills of reciting poetry and judging its quality. It also indicates that the character has a repertoire of poems memorized for recital at any time. No proficiency check is required for a normal recital.\n\nIf the character can read and write, original poems can be written. A successful proficiency check indicates that the poem is of above average quality.\n\n## The Complete Book of Humanoids\n\nThis proficiency includes the skills necessary to recite poetry and judge its quality. It also indicates that a character has a repertoire of poems memorized for recital at any time. No check is required for a normal recital.\n\nIf the character can read and write, original poems can be written. A successful check indicates that the poem is of above average quality.\n\n## The Complete Paladin's Handbook\n\nA character taking this proficiency specializes in either lyric or narrative poetry. Lyric poetry expresses thoughts and feelings, and includes ballads, sonnets, odes, and hymns. Narrative poetry tells stories in verse, some true, some fictional. A character spending two slots may specialize in both forms.\n\nThe proficiency enables the character to judge the quality of poetry in his specialty. He also knows a sizeable repertoire of poems and can recite them with spellbinding skill. No proficiency checks are required for these applications.\n\nThe character can also compose poems in his speciality; a successful check means the poem is of exceptional quality. If the character has the Reading/Writing proficiency, he can record his poems.\n\nCrossover Groups: General.\n\n### Poetry for Paladins\n\nWith permission from the DM, a paladin with the Poetry proficiency may offer a composition to his church (or other designated recipient) instead of a tithe. The paladin must inform the church a month in advance if he intends to offer a composition; either lyric or narrative poetry is acceptable. If the church (that is, the DM) disapproves, the paladin must pay his normal tithe. If the church approves, the paladin may present a composition when his tithe is normally due.\n\nThe composition must be presented at the church or to a church official at a pre-arranged location. The paladin then makes a Poetry proficiency check. If the check fails, the composition is deemed unworthy; the normal tithe must be paid immediately. If the check succeeds, the DM determines the value of the composition; the value is equal to 3d20 gp. If the value is greater than or equal to the normal tithe, no tithe is required that month. The paladin doesn't receive any \"change\" if the value is more than his tithe; the excess value is forfeited.\n\nIf the value is less than the tithe, the paladin subtracts the value from the tithe, then pays the difference (if the paladin owes 20 gp and the value of the composition is 15 gp, he must pay 5 gp). A paladin may exercise this option as often as he likes.\n\n## Campaign Option: Council of Wyrms Setting\n\nThis proficiency includes the skills necessary to recite dragon poetry and judge its quality. It also indicates that a dragon has a repertoire of poems memorized for recital at any time. No check is required for a standard recitation.\n\nIf a dragon has the Reading/Writing proficiency, it can create original poems. A successful check indicates that the created poem is of above average quality. Hatchlings can't select this proficiency."
    )
)

let embeddedProficiency1701: Proficiency = Proficiency(
    id: "politics",
    name: "Politics",
    wikiPageTitle: "Politics (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Unknown",
        checkModifier: 0,
        rawModifier: "Unknown",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Politics: This is political and diplomatic savvy—the ability to navigate the Byzantine complexities of Roman domestic and foreign politics. A character possessing this proficiency is aware of current political events (as news reaches him).",
        fullText: "## The Glory of Rome Campaign Sourcebook\n\nPolitics: This is political and diplomatic savvy—the ability to navigate the Byzantine complexities of Roman domestic and foreign politics. A character possessing this proficiency is aware of current political events (as news reaches him). He knows basic information about major political figures, including everyone serving in the senate. A successful Politics check combined with good role-playing is usually enough to secure an invitation to meet with a magistrate, senator, or other political figure. Influencing them, of course, depends on the character's—and the player's—actions. Politics is a General proficiency, counting as one slot."
    )
)

let embeddedProficiency1702: Proficiency = Proficiency(
    id: "portal_feel",
    name: "Portal Feel",
    wikiPageTitle: "Portal Feel (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Planescape"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3 or -5",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Sometimes a planewalker needs to know what's on the other side of a portal or gate before he steps through. This proficiency also allows a cutter a chance to determine the portal's exit point.",
        fullText: "## The Planewalker's Handbook\n\nSometimes a planewalker needs to know what's on the other side of a portal or gate before he steps through. This proficiency also allows a cutter a chance to determine the portal's exit point. This proficiency is used in two ways.\n\nFirst, a successful check at a -3 penalty grants a general feel for safety. By intuition and observation, a planewalker determines whether a given portal leads into a setting or situation of direct and immediate harm. Obviously, this requires the DM's interpretation.\n\nA second successful check at a -5 penalty divines the location of the other end of a gate or portal. The planewalker may not learn the exact site or position, but at the very least the character'll learn the destination plane. This proficiency doesn't tell the character about the gate key required to open the portal."
    )
)

let embeddedProficiency1703: Proficiency = Proficiency(
    id: "pottery",
    name: "Pottery",
    wikiPageTitle: "Pottery (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Dexterity/Aim",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency can create any type of clay vessel or container commonly used in the campaign world. The character requires a wheel and a kiln, as well as a supply of clay and glaze.",
        fullText: "## Player's Handbook\n\nA character with this proficiency can create any type of clay vessel or container commonly used in the campaign world. The character requires a wheel and a kiln, as well as a supply of clay and glaze. The character can generally create two small- or medium-sized items or one large-sized item per day. The pieces of pottery must then be fired in the kiln for an additional day.\n\nThe raw materials involved cost 3 cp to make a small item, 5 cp to make a medium-sized item, and 1 sp to make a large item.\n\n## Player's Option: Skills & Powers\n\nPottery: The character can create ceramic vessels—jars, bottles, plates, bowls, etc.—of whatever type are in use in the campaign world. A serviceable piece of crockery can be made without a proficiency check. If the character attempts to make a fine-quality piece, it will take about three days for an average-sized object—and a successful proficiency check. Failure means the object is useless; success indicates the degree of excellence, with a roll of 1 indicating that the character has created a work of unique value.\n\nA character with the artistic talent trait gains a +2 to the pottery proficiency rating. Masterpieces of pottery are sculpted by these talented characters.\n\n## The Complete Barbarian's Handbook Modifications\n\nThough barbarians usually don't have potter's wheels, kilns, and glazes, they can still create a surprising variety of earthenware objects. They begin by removing stones, splinters, and other debris from lumps of clay, then knead the clay with water until it softens. They roll the clay into coils, then shape it into bowls, pots, and cups. They may press ornamental pebbles and bones into the sides of the object, or use sharp sticks to etch designs. The objects are then air-dried or placed near a fire to harden.\n\n## Shaman\n\nThis proficiency works as described, except when the character attempts to create clay ritual masks: then the character receives a +1 bonus to the Shamanic Ritual check."
    )
)

let embeddedProficiency1704: Proficiency = Proficiency(
    id: "power_manipulation",
    name: "Power Manipulation",
    wikiPageTitle: "Power Manipulation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Psionicist",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Intelligence",
        checkModifier: -4,
        rawModifier: "-4",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Power manipulation is the skill of amplifying a psionic power or devotion. This proficiency can only be used to manipulate powers in the psionicist's primary discipline.",
        fullText: "## The Will and the Way\n\nPower manipulation is the skill of amplifying a psionic power or devotion. This proficiency can only be used to manipulate powers in the psionicist's primary discipline. When the psionicist initiates or maintains a psionic power, he may use power manipulation to boost its effects. First he initiates the power with a normal power check. Then he may attempt power manipulation by making a proficiency check. The attempt incurs an additional cost of 5 PSPs, whether he succeeds or fails. If the character makes a successful proficiency check, he achieves the result listed for that devotion's power score.\n\nIf the psionicist rolls a natural 20 on the proficiency check, he botches the manipulation attempt and suffers the ill effects of rolling a 20 for that devotion's power check."
    )
)

let embeddedProficiency1705: Proficiency = Proficiency(
    id: "presence",
    name: "Presence",
    wikiPageTitle: "Presence (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Mystic (MotRD)"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Some characters have such spiritual power that their auras are almost tangible, easily detected by others and, particularly, by supernatural creatures.",
        fullText: "## Dragon Magazine #236\n\nSome characters have such spiritual power that their auras are almost tangible, easily detected by others and, particularly, by supernatural creatures. On a successful proficiency check, the character can shift the reaction of a supernatural creature by one level towards the low end of the chart — so that a hostile result becomes threatening, a threatening result becomes cautious, and a cautious result becomes friendly or flight."
    )
)

let embeddedProficiency1706: Proficiency = Proficiency(
    id: "prestidigitation",
    name: "Prestidigitation",
    wikiPageTitle: "Prestidigitation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Prestidigitation: This is the art of street magic or sleight of hand, the trade of the magician.",
        fullText: "Prestidigitation: This is the art of street magic or sleight of hand, the trade of the magician. The character is skilled at concealing or manipulating small items and familiar with such tricks as pulling a coin from a child's ear, separating two joined rings, or causing a pigeon or rabbit to vanish. For the most part, nothing more than manual dexterity and showmanship are required, and any kind of character may learn prestidigitation.\n\nWhile true wizards have little time for these parlor tricks, many apprentices practice with their cantrips by duplicating these feats. A wizard with a cantrip spell handy can really manipulate a small object by briefly levitating it, teleport something small from one hand to the other, or use a tiny dimensional pocket to make an object disappear or seem to contain something it shouldn't.\n\nThere is no particular game effect for prestidigitation, although it is a form of entertainment and can earn a wizard his dinner with a good performance, or possibly distract or fool an NPC under very limited circumstances. For example, a wizard trying to conceal a wand or precious gem from a robber searching him at knifepoint might be able to hide the item with a successful proficiency check."
    )
)

let embeddedProficiency1707: Proficiency = Proficiency(
    id: "project_thoughts",
    name: "Project Thoughts",
    wikiPageTitle: "Project Thoughts (Proficiency)",
    redirectAliases: ["Project Thoughts (GAP)"],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Reason",
            characterPointCost: 4,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "This deceptively named proficiency does not involve mental communication or telepathy in any way. Instead, it is as close to a physical attack as a body gets on the Astral Plane.",
        fullText: "This deceptively named proficiency does not involve mental communication or telepathy in any way. Instead, it is as close to a physical attack as a body gets on the Astral Plane. Simply put, a character with this skill projects her extraneous, random thoughts upon the astral form of another, thus slowing her down as she is caught in the mire of mental drag (see \"Racing Through Nothing: Astral Movement\").\n\nIt works like this: If a body has this proficiency and makes a successful skill check, she can project her thoughts around any figure within sight. If the target has a lower Intelligence score than the projector of the thoughts, the target is slowed down to a stop, held in place (able to act, but not able to move from that point in \"space\"). If the Intelligence score of the target is equal to the projector, the target's movement rate is halved. In any case, this ability affects only movement, not other activities like combat, spellcasting, etc.\n\nThe effect lasts as long as the projector devotes her full concentration. The target can make Intelligence checks each round (starting the round after the initial effect) to attempt to break the hold. The target must remain within the sight of the projector or the hold is automatically broken."
    )
)

let embeddedProficiency1708: Proficiency = Proficiency(
    id: "prophecy",
    name: "Prophecy",
    wikiPageTitle: "Prophecy (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["Seers Only"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows a seer to convey the information he receives through divination magic in a fairly understandable way.",
        fullText: "## Sages & Specialists\n\nThis proficiency allows a seer to convey the information he receives through divination magic in a fairly understandable way. Most information gleaned through divinatory methods comes to the seer in quick, almost explosive visions, or nearly incomprehensible words. The seer can use this prophecy to \"translate\" those visions and words into a format more easily understood by normal men and women. This is not to say that such messages become crystal clear. In fact, these prophecies are still couched in enigmatic and cryptic language. However, without this proficiency, a seer's warnings would be totally incomprehensible.\n\nOnce a seer receives a prophetic vision through the use of his magic, he must make a Prophecy proficiency check. Failure means that he was unable to convey the message of his vision in a way that anyone else can understand.\n\nThe seer can also use this proficiency to decipher prophecies made by others. In order to do this, the seer must have the complete prophecy-either written down or memorized-on hand. He then makes a proficiency check with a -2 penalty. If he succeeds, he is able to get a general sense of the prophecy. Failure, however, indicates that the seer could not decipher the prophecy.\n\nIf the seer fails to interpret a prophecy, he cannot take another shot at it until he has had a full night's sleep. Once he wakes up with a refreshed mind, the seer can attempt to interpret the prophecy again.\n\nIf the prophecy is a particularly long or complicated one, the DM can require several successful checks on the seer's part. Each time a check is passed, the DM should give the seer a short clue as to the meaning of a particular passage from the prophecy. It's still up to the seer to piece the whole thing together.\n\nIf a seer critically fails (rolls a 20) his proficiency check when deciphering a prophecy, he comes up with an interpretation that is totally incorrect. However, he is unaware of his error. The misinterpretation should be something stated by the DM so that the seer (and any who believe his interpretation) will actually work to make the prophecy come true if they are trying to prevent it. For example, if the prophecy states that the party should destroy Oghar's gem, the seer misconstrues the warning and tells the party that they must protect the item. Conversely, if they are struggling to bring the prophecy to fruition, this interpretation will actually set them at cross-purposes to their true desires.\n\nIf the seer entirely misinterpreted a prophecy, he cannot attempt to reinterpret it until he is conclusively shown his error. In addition, he requires a full night's rest before attempting to interpret the prophecy again.\n\nNo equipment is required to make use of this nonweapon proficiency. All the seer needs is either the message from a spell to turn into a prophecy or a prophecy which someone else has made.\n\nThis proficiency costs one slot and is based on Wisdom; it has a -2 check modifier.\n\n## Chronomancer\n\nThis can be used to analyze prophecies for hidden meanings and validity or to construct a prophecy of the chronomancer's own. If confronted with any portion of a prophecy, a successful check alerts the character.\n\nTo analyze an existing prophecy, a certain amount of research is necessary. This depends greatly upon the particular prophecy but should entail 1d6 days of research. Once this has been completed, the character makes five proficiency checks. The first determines which pieces of the prophecy are important. The next helps the character decide just how far this prophecy reaches (whether it involves a single town or could affect an empire). Another check tells the character the state of the prophecy's timing. The next check reveals how the prophecy should conclude. The final check tells who is behind the prophecy or approximately where a certain person or group fits in (that a major member of the prophecy must play the part of the king's advisor in order for it to work, for example).\n\nIf any check (rolled by the DM) is failed but the roll is less than 20, no conclusion can be reached, and no further rolls can be made. Further research (say another 1d4 days) allows the character to pick up at the failed proficiency check and proceed until another failure forces more research.\n\nIf the check roll is a 20, the error is not caught, and the character proceeds with other rolls, all of which are wrong since they are based on faulty assumptions.\n\nOnce all of the rolls have been made, the character may make an additional check at a -2. This check should give the character a few ideas on how to help or hinder the prophecy (at the DM's discretion, of course).\n\nThis proficiency can also be used to construct a prophecy. Three checks are necessary for this to work. To use it, the character must first have some actual knowledge of the event to be prophesied. For every 20 years in the future the event is, a -1 penalty applies.\n\nThe first check gains the player some idea from the DM on motivations for the people affected by the prophecy (why they would want to remember and believe in it). A second check, along with proper action by the character (like presenting to the king a magical sword that is predicted to kill a dragon), establishes the actual beginning of the prophecy. A third check evaluates the work done and finds the weakest spots. If detailed, first-hand knowledge of the future is used, the checks are made without the -1 modifier.\n\nThe character can use this skill to solve a prophecy set forth by the DM. Wits and good role-playing can help. Conversely, when making a prophecy, the player should actually write it down, leaving it for the DM to misinterpret as he likes."
    )
)

let embeddedProficiency1709: Proficiency = Proficiency(
    id: "prophecy_seer",
    name: "Prophecy - Seer",
    wikiPageTitle: "Prophecy - Seer (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows a seer to convey the information he receives through divination magic in a fairly understandable way.",
        fullText: "This proficiency allows a seer to convey the information he receives through divination magic in a fairly understandable way. Most information gleaned through divinatory methods comes to the seer in quick, almost explosive visions, or nearly incomprehensible words. The seer can use this prophecy to \"translate\" those visions and words into a format more easily understood by normal men and women. This is not to say that such messages become crystal clear. In fact, these prophecies are still couched in enigmatic and cryptic language. However, without this proficiency, a seer's warnings would be totally incomprehensible.\n\nOnce a seer receives a prophetic vision through the use of his magic, he must make a Prophecy proficiency check. Failure means that he was unable to convey the message of his vision in a way that anyone else can understand.\n\nThe seer can also use this proficiency to decipher prophecies made by others. In order to do this, the seer must have the complete prophecy-either written down or memorized-on hand. He then makes a proficiency check with a -2 penalty. If he succeeds, he is able to get a general sense of the prophecy. Failure, however, indicates that the seer could not decipher the prophecy.\n\nIf the seer fails to interpret a prophecy, he cannot take another shot at it until he has had a full night's sleep. Once he wakes up with a refreshed mind, the seer can attempt to interpret the prophecy again.\n\nIf the prophecy is a particularly long or complicated one, the DM can require several successful checks on the seer's part. Each time a check is passed, the DM should give the seer a short clue as to the meaning of a particular passage from the prophecy. It's still up to the seer to piece the whole thing together.\n\nIf a seer critically fails (rolls a 20) his proficiency check when deciphering a prophecy, he comes up with an interpretation that is totally incorrect. However, he is unaware of his error. The misinterpretation should be something stated by the DM so that the seer (and any who believe his interpretation) will actually work to make the prophecy come true if they are trying to prevent it. For example, if the prophecy states that the party should destroy Oghar's gem, the seer misconstrues the warning and tells the party that they must protect the item. Conversely, if they are struggling to bring the prophecy to fruition, this interpretation will actually set them at cross-purposes to their true desires.\n\nIf the seer entirely misinterpreted a prophecy, he cannot attempt to reinterpret it until he is conclusively shown his error. In addition, he requires a full night's rest before attempting to interpret the prophecy again.\n\nNo equipment is required to make use of this nonweapon proficiency. All the seer needs is either the message from a spell to turn into a prophecy or a prophecy which someone else has made.\n\nThis proficiency costs one slot and is based on Wisdom; it has a -2 check modifier."
    )
)

let embeddedProficiency1710: Proficiency = Proficiency(
    id: "prospecting",
    name: "Prospecting",
    wikiPageTitle: "Prospecting - Dragon (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency grants knowledge in the practice of searching for valuable metals and minerals.",
        fullText: "This proficiency grants knowledge in the practice of searching for valuable metals and minerals. There are many techniques available, and the character is fairly familiar with those practiced by his culture (or the culture wherein he was taught prospecting). This includes using metal or wood pans and fine meshes to sift through riverbeds and dirt. A successful check performed on a daily or weekly basis indicates that something of worth was found, though usually such results yield only small gains at most."
    )
)

let embeddedProficiency1711: Proficiency = Proficiency(
    id: "psioncraft",
    name: "Psioncraft",
    wikiPageTitle: "Psioncraft (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Council of Wyrms"],
    mechanics: ProficiencyMechanics(
        groups: ["Dragons"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The Psioncraft proficiency, available only to gem dragons, is required in order for a dragon to develop its psionic abilities.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nThe Psioncraft proficiency, available only to gem dragons, is required in order for a dragon to develop its psionic abilities. It allows a dragon to identify a psionic effect, and a successful check will offer clues about the identity and location of the source.\n\nA gem dragon must take Psioncraft to gain the use of its psionic abilities. Unless a dragon player character takes the dragon-psionicist kit, psionic powers become available to a gem dragon only as innate abilities at certain levels. Once a dragon has taken Psioncraft, it must wait until these innate psionic powers develop before it can use them. See \"Special Abilities\" later in this chapter for information on which psionic powers are available and when.\n\nHatchlings can't take this proficiency."
    )
)

let embeddedProficiency1712: Proficiency = Proficiency(
    id: "psionic_detection",
    name: "Psionic Detection",
    wikiPageTitle: "Psionic Detection (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The psionic detection proficiency works much as the psionic sense devotion, but it is much weaker. With this proficiency, an Athasian character uses his latent psionic ability to detect the expenditure of psionic strength points (PSPs) around him.",
        fullText: "## Dark Sun Campaign Setting Revised\n\nThe psionic detection proficiency works much as the psionic sense devotion, but it is much weaker. With this proficiency, an Athasian character uses his latent psionic ability to detect the expenditure of psionic strength points (PSPs) around him.\n\nWhen employing this proficiency, a character must clear his mind and concentrate, taking at least one full round to prepare. A successful check allows the character to detect the expenditure of any PSPs within 50 yards of his location, regardless of intervening material objects. A character can maintain use of the proficiency for successive rounds, but during that time he can't move or perform any other actions. The proficiency check, however, must succeed on the round the PSPs are expended or the character detects nothing.\n\nThis proficiency can only inform a character that PSPs were expended within 50 yards, telling nothing more. The detector can't determine the number of PSPs, their source, the powers drawn upon, or the purpose of the expenditure (whether to initiate a power or to maintain one). Psionic detection isn't cumulative with other detection techniques.\n\nA player whose character has the psionic detection proficiency should remind the DM about that fact every so often. The DM might sometimes secretly roll the proficiency and inform the player of results."
    )
)

let embeddedProficiency1713: Proficiency = Proficiency(
    id: "psionic_lore",
    name: "Psionic Lore",
    wikiPageTitle: "Psionic Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Psionicist",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency represents the study of famous masters of the Way and the methodology of developing mental powers. The character is versed in the standard powers and effects.",
        fullText: "## The Will and the Way\n\nThis proficiency represents the study of famous masters of the Way and the methodology of developing mental powers. The character is versed in the standard powers and effects. With a successful proficiency check, the character can identify the general effects of any psionic devotion or science. For example, the character encounters a dwarf walking across a silt basin without sinking. With a successful check, he can determine that the dwarf is using the Body Equilibrium devotion.\n\nThe second benefit of this proficiency is the ability to recognize attack patterns in mental combat. If the character makes a proficiency check with a -4 penalty, he is able to guess which attack and defense modes his opponent will be using that round and select his own modes accordingly. The DM should make this check in secret; if the PC fails the check, randomly decide which powers he thinks is opponent is using.\n\nIf two characters with psionic lore engage in mental combat, the character with the highest successful proficiency check is able to read his opponent's intentions. If the proficiency checks are the same, neither character gains any information."
    )
)

let embeddedProficiency1714: Proficiency = Proficiency(
    id: "psychic_defense",
    name: "Psychic Defense",
    wikiPageTitle: "Psychic Defense (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Some people are able to develop a rudimentary psionic defense, although they are not psionicists. They may be born with exceptionally strong Wills, or they may have met a teacher who instructed them in the basics of psionic self-defense.",
        fullText: "## The Will and the Way\n\nSome people are able to develop a rudimentary psionic defense, although they are not psionicists. They may be born with exceptionally strong Wills, or they may have met a teacher who instructed them in the basics of psionic self-defense.\n\nWhen a character with this proficiency is attacked by contact or one of the five telepathic attack modes, he may attempt to defend himself mentally. This must be declared after the attacker has announced his attack, but before he resolves it— the defending character can't wait to see if the attack succeeds.\n\nIf the defender makes a successful proficiency check, he manages to prevent contact for that one attack. Each subsequent mental attack provides a cumulative -4 penalty to the proficiency check, so a character who has been attacked three times in one encounter makes his check with a -12 penalty. Unlike a psionicist, whose attackers need three tangents to force contact, the general defender is bested the first time his attacker succeeds and he fails his psychic defense roll.\n\nWhile a character is defending himself psionically, he may move and defend himself normally. However, he may not cast spells or initiate any wild talents. The psychic defender can make melee or missile attacks, but he suffers a -4 penalty to any attack rolls he makes since his attention is divided between his physical surroundings and the mental assault."
    )
)
