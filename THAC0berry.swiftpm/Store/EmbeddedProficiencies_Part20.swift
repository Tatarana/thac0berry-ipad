import Foundation

/// Parte 20 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency2000: Proficiency = Proficiency(
    id: "sense_emotion",
    name: "Sense Emotion",
    wikiPageTitle: "Sense Emotion (Proficiency)",
    redirectAliases: ["Sense Emotion (GAP)"],
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
            subAbility: "Wisdom/Intuition",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "If someone is displaying strong emotions on the Astral, he sends out strong waves of energy. Bloods that know how can \"look\" for this emotional energy and follow it back to its source.",
        fullText: "If someone is displaying strong emotions on the Astral, he sends out strong waves of energy. Bloods that know how can \"look\" for this emotional energy and follow it back to its source. A successful check using this proficiency indicates that the energy is detected if it is present.\n\nSince distances on the Astral Plane are relative to a body's perceptions, this ability does not have a \"range.\" Instead, the emotional energy can be detected if the source is less than half an hour's travel time (see \"Racing Through Time: Astral Movement\") away from the blood trying to find it."
    )
)

let embeddedProficiency2001: Proficiency = Proficiency(
    id: "sensory_alteration",
    name: "Sensory Alteration",
    wikiPageTitle: "Sensory Alteration (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizards"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Wizard characters who have this proficiency can increase or decrease the sensory effects of casting by lengthening the casting time of the spell. The casting time must be doubled to use the proficiency.",
        fullText: "Wizard characters who have this proficiency can increase or decrease the sensory effects of casting by lengthening the casting time of the spell. The casting time must be doubled to use the proficiency. On a successful check, the wizard makes the change. Increa ing the effects triples the range at which they are normally detected-they become almost impossible to ignore, especially in an enclosed area like a room or cavern. Decreasing the effects reduces the range to one-quarter (rounded down). This proficiency applies to all sensory effects in play, including additional and grand effects."
    )
)

let embeddedProficiency2002: Proficiency = Proficiency(
    id: "set_snares",
    name: "Set Snares",
    wikiPageTitle: "Set Snares (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue", "Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Dexterity/Aim, Wisdom /Intuition",
            characterPointCost: 3,
            baseRating: "6 (Rogue) 8 (Warrior)"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character can make simple snares and traps, primarily to catch small game. These can include rope snares and spring traps.",
        fullText: "## Player's Handbook\n\nThe character can make simple snares and traps, primarily to catch small game. These can include rope snares and spring traps. A proficiency check must be rolled when the snare is first constructed and every time the snare is set. A failed proficiency check means the trap does not work for some reason. It may be that the workmanship was bad, the character left too much scent in the area, or he poorly concealed the finished work. The exact nature of the problem does not need to be known. The character can also attempt to set traps and snares for larger creatures: tiger pits and net snares, for example. A proficiency check must be rolled, this time with a -4 penalty to the ability score. In both cases, setting a successful snare does not ensure that it catches anything, only that the snare works if triggered. The DM must decide if the trap is triggered.\n\nThief characters (and only thieves) with this proficiency can also attempt to rig man-traps. These can involve such things as crossbows, deadfalls, spiked springboards, etc. The procedure is the same as that for setting a large snare. The DM must determine the amount of damage caused by a man-trap.\n\nSetting a small snare or trap takes one hour of work. Setting a larger trap requires two to three people (only one need have the proficiency) and 2d4 hours of work. Setting a man-trap requires one or more people (depending on its nature) and 1d8 hours of work. To prepare any trap, the character must have appropriate materials on hand.\n\nCharacters with animal lore proficiency gain a +2 bonus to their ability score when attempting to set a snare for the purposes of catching game. Their knowledge of animals and the woods serves them well for this purpose. They gain no benefit when attempting to trap monsters or intelligent beings.\n\n## Player's Option: Skills & Powers\n\nSet Snares: A character with this skill can place small traps and snares along a game trail—a useful aid to gaining food in a non-civilized setting. Given proper materials—supple branches, bowstring or heavy thread—the character can make two snares in an hour without a proficiency check. The character can check the snares after eight hours, rolling a proficiency check for each. These checks can be modified by +2 if the character has the animal lore proficiency, and an additional +2 for the animal empathy trait. Success means that a small animal, such as a rabbit or partridge, has been snared. The checks can be modified up or down by the DM, to reflect the population of animals in the area.\n\nThe character can create a larger snare, such as a pit trap, by making a proficiency check. An 8' deep, 6' square pit requires at least eight hours to make if the ground is soft and a decent shovel is available. Rocky ground, larger pits, and makeshift equipment can increase this time dramatically. Whether anything falls into the large pit is a matter of the DM's interpretation and generosity."
    )
)

let embeddedProficiency2003: Proficiency = Proficiency(
    id: "set_traps",
    name: "Set Traps",
    wikiPageTitle: "Set Traps (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Council of Wyrms"],
    mechanics: ProficiencyMechanics(
        groups: ["Dragons"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity/Intelligence",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows dragons to set traps in their lairs or to prepare trapped areas as ambushes (as emerald dragons are wont to do). A proficiency check must be rolled when the trap is first constructed (and every time it is set).",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nThis proficiency allows dragons to set traps in their lairs or to prepare trapped areas as ambushes (as emerald dragons are wont to do). A proficiency check must be rolled when the trap is first constructed (and every time it is set). A failed check means the trap will not work, though the dragon should not necessarily realize this. Of course, successfully building and setting a trap does not mean it automatically catches anything.\n\nThe complexity of a trap determines how long it takes to construct: small, simple traps (like snares) take one hour; larger, more complex traps take 2d4 hours of work; traps designed to catch intelligent creatures require 2d8 hours. The dragon must have appropriate materials on hand to construct a trap.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency2004: Proficiency = Proficiency(
    id: "shamanic_ritual",
    name: "Shamanic Ritual",
    wikiPageTitle: "Shamanic Ritual (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency is concerned with the correct performance of shamanic ceremonies.",
        fullText: "This proficiency is concerned with the correct performance of shamanic ceremonies.\n\nThe correct performance of ritual is vital to a tribal shaman. If a funeral is not conducted properly, the deceased may rise as some form of undead to terrorize the community. If a sacrifice is not given properly, the spirits will not consider the offering as having been given—which, if the sacrifice is designed to lift an illness or assure a bountiful harvest, may have disastrous results.\n\nIf the DM chooses, he may roll this check.\n\nNonshamans may learn this proficiency if they wish, but they will not be able to sacrifice to the spirits to gain spells and other shamanic powers; at best, nonshamans can use this proficiency to understand what a shaman is doing in a particular ritual, and perform minor sacrifices to appease spirits they have wronged. However, while a failed proficiency check from a shaman generally means the ritual or spell just doesn't work, nonshamans will generally enrage the spirits, who will view their behavior as mockery,\n\nPlayers should be aware that certain spells and shamanic class abilities require a sacrifice to be made, and should be aware that every sacrifice requires a Shamanic Ritual check. If this proficiency does not come with the class as a bonus, it is worth the player's while to choose it for the character."
    )
)

let embeddedProficiency2005: Proficiency = Proficiency(
    id: "ship_repair",
    name: "Ship Repair",
    wikiPageTitle: "Ship Repair (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Intelligence",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This NWP allows the mage to assess the state of the ship and direct the crew to make any necessary repairs. Because of the higher level of maintenance, a ship under the constant care of a mage with this proficiency gains a +1 bonus vs.",
        fullText: "## Dragon Magazine #235\n\nThis NWP allows the mage to assess the state of the ship and direct the crew to make any necessary repairs. Because of the higher level of maintenance, a ship under the constant care of a mage with this proficiency gains a +1 bonus vs. any of the ship’s attacks. The bonus is +1 for every three levels of the mage. A 1st-level mage provides a +1 bonus, a 4th-level mage provides a +2 bonus, etc. The bonus increases by a further +1 if the mage also has the engineering NWP. The proficiency assumes that the mage uses magic such as mending, unseen servant, levitate, and similar spells to help make necessary repairs."
    )
)

let embeddedProficiency2006: Proficiency = Proficiency(
    id: "shipwright",
    name: "Shipwright",
    wikiPageTitle: "Shipwright (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Dexterity",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This character is knowledgeable regarding techniques for ship construction and repair. He can de-",
        fullText: "## The Complete Spacefarer's Handbook\n\nThis character is knowledgeable regarding techniques for ship construction and repair. He can de-\n\nsign and build ships of all types, with a proficiency check being required for unusual features only. The character can perform routine maintenance on spelljamming vessels, including repairing sails and caulking the hull, without a proficiency check. A shipwright need not have other workmen to finish small vessels, but larger vessels require crews of shipwrights and other laborers to build or repair.\n\nA character with the shipwright proficiency is considered a \"trained worker\" for the purpose of ship repair. This proficiency is relevant for ship repairs of all types. (See the Concordance of Arcane Space, Chapter 4, for more details on ship repair.)"
    )
)

let embeddedProficiency2007: Proficiency = Proficiency(
    id: "sign_language",
    name: "Sign Language",
    wikiPageTitle: "Sign Language (Proficiency)",
    redirectAliases: ["Language, Sign"],
    primaryGroup: "General",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence - Dwarf Dexterity - Barbarian",
        checkModifier: 2,
        rawModifier: "+2 - Dwarf +0 - Barbarian",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Sign language is most frequently used by dwarves who were engaged in long running warfare with other dwarves or races. It permits silent communication with anyone who sees and understands the signals.",
        fullText: "## The Complete Book of Dwarves\n\nSign language is most frequently used by dwarves who were engaged in long running warfare with other dwarves or races. It permits silent communication with anyone who sees and understands the signals. The maximum range is usually line of sight in a lit area, or the extent of the receiver's infravision. Sign may be an extensive language capable of handling long conversations, or simply a means of communicating a few easy to understand phrases such as \"attack,\" \"orcs behind the rock,\" or \"you three move left.\" A proficiency check is made when speaking or interpreting sign. The +2 bonus should only be used when giving short, easily recognized commands. More detailed signals require a -1 modifier.\n\n## The Complete Barbarian's Handbook\n\nA character with this proficiency can communicate with hand movements instead of speech. Sign language can convey messages of the same complexity and nuance as a spoken language, providing the participants can see each other's hands.\n\nIf two characters with this proficiency wish to communicate, both must make proficiency checks. If both succeed, they may use sign language to silently converse for a full round. They may continue their conversation by making successful checks on subsequent rounds. During a round when either character fails his check, the communication is garbled; the sender's finger movements weren't precise, the receiver wasn't paying attention, or something blocked the line of sight. On a natural roll of 20, the receiver interprets the message as the opposite of what the sender intended.\n\nA character with this proficiency may also try to convey a simple message to a character without the proficiency. The player must first whisper the phrase to the DM, who decides if the phrase is acceptable. Acceptable phrases include \"Don't move,\" \"Follow me,\" and \"I'm hurt.\" Complicated phrases or those containing proper nouns are unacceptable, such as \"My name is Grog,\" \"Take three steps north, then look up,\" and \"We can find the antidote in Elk Valley.\" If the DM deems the phrase unacceptable, sign language can't be attempted; no proficiency check is necessary. If the DM allows the phrase, the character makes a check.\n\nIf the check succeeds, the phrase is successfully communicated. If the check fails, the phrase is garbled. On a natural roll of 20, the receiver misunderstands the phrase, interpreting it as the opposite of its actual meaning. A character can't attempt to communicate the same phrase more than once to the same recipient.\n\nCrossover Group: General.\n\n## Dark Sun Campaign Setting Revised\n\nThose who have mastered the use of sign language can communicate among themselves without words, provided they can see each other's hands. Signing is a language unto itself: It conveys ideas that any other character who has the sign language proficiency can understand, regardless of his or her native language.\n\nTo use sign language for an entire round, all parties involved must make a successful check. Characters who succeed can converse together for an entire minute; those who fail can't listen. When a PC signs successfully with an NPC, the DM should speak freely with the player for one minute per round. Every round of conversation requires another check. A failed check means that the speaker didn't perform his finger movements accurately, the listener wasn't watching the speaker closely enough, or something else blocked communication.\n\nOn Athas, many groups employ sign language for covert conversations. In some citystates, using sign language can be grounds for imprisonment. Though sign language throughout Athas is generally consistent, some secret societies employ special codes so that unwanted eyes can't decipher specific conversations."
    )
)

let embeddedProficiency2008: Proficiency = Proficiency(
    id: "signalling",
    name: "Signalling",
    wikiPageTitle: "Signaling (Proficiency)",
    redirectAliases: ["Signalling (Proficiency)"],
    primaryGroup: "General",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 2,
        rawModifier: "+2 Dwarf -2 Ranger -2 Barbarian +2 Spacefarer",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency can send and receive messages over long distances. He must designate a specific method, such as drums, smoke signals, or whistling.",
        fullText: "## Barbarian Handbook\n\nA character with this proficiency can send and receive messages over long distances. He must designate a specific method, such as drums, smoke signals, or whistling. If he spends additional slots, he may designate additional methods.\n\nThe recipient must see (or hear) the signal in order to interpret it. He must also have the signaling proficiency and know the same method as the sender. Messages can be sent and received at the rate of 10 words per round.\n\nTo transmit a message, both the sender and receiver must make successful proficiency checks. If either fails his check, the message is garbled; they may try again in the next round. If both checks fail, or either rolls a natural 20, the message is received, but has the opposite of the intended meaning.\n\nCrossover Group: General.\n\n## The Complete Book of Dwarves\n\nThe signalling proficiency allows a character to send messages underground using sound. To send a signal, tap on a section of wall with a rock, hammer, or a piece of metal. The sound will echo through rock to a distance of 1d4 miles. The sound transmitted by this proficiency resembles morse code and it may be used to send extensive messages or short commands and instructions. To send a message, roll a proficiency check. If successful, the message transmits as desired. If not, the message may be only partially understood or complete nonsense. It may even convey a meaning contrary to the message sent. Successful transmission of a message is no guarantee that it will be understood by the receiving end and proficiency checks are required to correctly interpret the message. It is possible to fail to understand an incorrectly sent signal, yet still infer a message from it, one very different from what was intended.\n\n## The Complete Ranger's Handbook\n\nThis proficiency gives the character the ability to send messages over long distances. The character must designate his preferred method for signalling. Typical methods include smoke signals, whistling, waving flags, drums, or reflecting mirrors. For each additional slot spent, the character may choose an additional method.\n\nBecause signalling is essentially a language, messages of reasonable complexity can be communicated. A practiced signaller can transmit as many as 10 words per combat round.\n\nTo interpret the signal, the recipient must be able to see or hear it. He must also have the signalling proficiency and know the same signalling method as the sender. To send a message and have it understood, both the signaller and the recipient must make successful proficiency checks. If one fails his roll, the message is distorted; the message can be sent again in the following round, and proficiency checks may be attempted again. If both checks fail, or if either character rolls a natural 20, an incorrect message was sent and received; the message has the opposite of the intended meaning. Characters without the signalling proficiency, as well as characters who have the proficiency but use a different signalling method, can't understand the signals.\n\nCrossover Groups: General.\n\n## The Complete Spacefarer's Handbook\n\nThis proficiency gives the character the ability to use signalling equipment to send complex messages across wildspace. While any character can use a red smoke grenade to signal danger, a character with this proficiency can send coded messages to other ships using a signalling mirror, light, or flags. The signal transmitted by this proficiency will cross up to 10 miles in wildspace, although it must travel in a straight line. A skilled signaller can send as many as 10 words each combat round.\n\nTo send a message and have it understood, the sender and receiver must both have signalling proficiency and both must roll proficiency checks. If both succeed, the message is understood perfectly. If one fails, the message is distorted, but in an obvious way, so that it can be retransmitted next round. If both checks fail, or if either rolls a natural 20, an erroneous message is received and accepted with a meaning opposite to that intended.\n\n## The Complete Barbarian's Handbook\n\nA character with this proficiency can send and receive messages over long distances. He must designate a specific method, such as drums, smoke signals, or whistling. If he spends additional slots, he may designate additional methods.\n\nThe recipient must see (or hear) the signal in order to interpret it. He must also have the signaling proficiency and know the same method as the sender. Messages can be sent and received at the rate of 10 words per round.\n\nTo transmit a message, both the sender and receiver must make successful proficiency checks. If either fails his check, the message is garbled; they may try again in the next round. If both checks fail, or either rolls a natural 20, the message is received, but has the opposite of the intended meaning.\n\nCrossover Group: General."
    )
)

let embeddedProficiency2009: Proficiency = Proficiency(
    id: "singing",
    name: "Singing",
    wikiPageTitle: "Singing (Proficiency)",
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
            characterPointCost: 2,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character is an accomplished singer and can use this ability to entertain others and perhaps earn a small living (note that bards can do this automatically). No proficiency check is required to sing.",
        fullText: "## Player's Handbook\n\nThe character is an accomplished singer and can use this ability to entertain others and perhaps earn a small living (note that bards can do this automatically). No proficiency check is required to sing. The character can also create choral works on a successful proficiency check.\n\n## Player's Option: Skills & Powers\n\nSinging: The character knows and can perform the many types of songs, including some that involve complex or difficult notes. All songs common to the character's society will be familiar. Rare, archaic, or unusual songs will be known with a proficiency check. Also, characters who have had a chance to hear an unknown song can perform it (–2 modifier, +1 for each time after the first that it is heard).\n\nThe character can compose his own songs, including choral works, with a successful proficiency check. If the character also has the Music/Singing Talent, the character can add +2 to his base score.\n\n## Campaign Option: Council of Wyrms Setting\n\nThis proficiency is described in the Player's Handbook. The dragon can sing with skill without a proficiency check. Composition does require a proficiency check. While it is unusual, it is not unheard of for a young dragon to travel the isles as an entertainer for a brief (in draconic years) period of time.\n\nHatchlings can select this proficiency."
    )
)

let embeddedProficiency2010: Proficiency = Proficiency(
    id: "sleight_of_hand",
    name: "Sleight of Hand",
    wikiPageTitle: "Sleight of Hand (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist", "Rogue"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Dezterity",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A rogue with the sleight of hand proficiency is highly trained in the art of legerdemain.",
        fullText: "## Dragon Magazine #200\n\nA rogue with the sleight of hand proficiency is highly trained in the art of legerdemain. She can, with a flick of her wrists, cause coins and other small objects to vanish up her sleeve, and she can perform many other hand-is-quicker-than-the-eye tricks. This manifests itself as a +30% bonus to the thief's pick-pockets chances, rolled whenever this skill is used (this roll for the purposes of performing sleight of hand only, not picking pockets). Characters without thief abilities who take this proficiency gain a sleight of hand skill (similar to thief skills) at a base chance of success of 40% (modified as for a thief for Dexterity, armor, and race). Easy tricks may be granted a bonus of up to +50%."
    )
)

let embeddedProficiency2011: Proficiency = Proficiency(
    id: "slow_respiration",
    name: "Slow Respiration",
    wikiPageTitle: "Slow Respiration (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "N/A (Dwarf) Wisdom (Spacefarer)",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency has the ability to enter a deep trance and reduce the amount of air he needs to stay alive. To induce the trance, he must be in a restful position, either sitting or lying down.",
        fullText: "## The Complete Book of Dwarves\n\nA character with this proficiency has the ability to enter a deep trance and reduce the amount of air he needs to stay alive. To induce the trance, he must be in a restful position, either sitting or lying down. After concentrating for one turn, pulse and breathing drop well below normal, so that breathing requires only 10% of the rate when resting. The character emerges from his trance at will, fully aware of anything that has occurred nearby.\n\n## The Complete Spacefarer's Handbook\n\nThis proficiency provides the character with the ability to slow his respiration so that he consumes air more slowly. On a successful proficiency check, the character drops into a trance during which he consumes air only one-tenth as quickly as normal.\n\nFor example, the Dread Pirate Luigi is accidentally thrown overboard. Normally, Luigi carries enough air in his personal air envelope for 2-20 turns. However, he is afraid that his crewmen did not notice him falling overboard (as they were all rather drunk at the time), and he wants to preserve himself for as long as possible. If Luigi makes a successful slow respiration proficiency check, his air envelope will last 20-200 turns, greatly improving his chances of being rescued while he is still alive.\n\nStarting the trance takes one turn. Should the proficiency check fail, the character consumes a normal amount of atmosphere for that turn but may attempt to use this proficiency again on the next turn (so long as air remains). If Luigi misses the proficiency check on his first turn but is successful on the second turn, his air envelope will last 11-191 turns (one turn for the turn he missed, plus 10-190 turns for the 1-19 turns of normal breathing he had left, times 10 for his lowered respiration).\n\nThe character is unable to take any action while in the air-preserving trance. However, the character is still aware of everything that is going on and can return to full consciousness in a single round."
    )
)

let embeddedProficiency2012: Proficiency = Proficiency(
    id: "smelting",
    name: "Smelting",
    wikiPageTitle: "Smelting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General (Crafting)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The smelting proficiency is closely tied to the Mining proficiency. Between them they provide all of the metal to the strongholds.",
        fullText: "## The Complete Book of Dwarves\n\nThe smelting proficiency is closely tied to the Mining proficiency. Between them they provide all of the metal to the strongholds. With this proficiency a smelter can be operated. See Chapter 9."
    )
)

let embeddedProficiency2013: Proficiency = Proficiency(
    id: "somatic_concealment",
    name: "Somatic Concealment",
    wikiPageTitle: "Somatic Concealment (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard", "Priest"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Dexterity",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Though spellcasters can mumble verbal components and hide material components in their hands or robes, somatic components are harder to hide.",
        fullText: "## Dark Sun Campaign Setting Revised\n\nThough spellcasters can mumble verbal components and hide material components in their hands or robes, somatic components are harder to hide. The somatic component of any spell, magical or clerical, is apparent to any character watching the spellcaster. On Athas, where spellcasting is often illegal, the ability to hide the necessary gestures becomes important. If movements can be concealed, a spell can be unleashed without calling attention to the caster.\n\nA character using the somatic concealment proficiency must announce to the DM his intention to do so at the beginning of the round. Then, when the character casts his spell, the DM makes the check in secret. A successful check indicates that anyone who can see the wizard doesn't recognize his gestures as being magical in nature. A failed check means that all who can view the casting wizard see his movements for what they really are."
    )
)

let embeddedProficiency2014: Proficiency = Proficiency(
    id: "soothsaying",
    name: "Soothsaying",
    wikiPageTitle: "Soothsaying (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency gives the character a limited ability to see into the future. When he acquires the proficiency, he must select a soothsaying technique.",
        fullText: "This proficiency gives the character a limited ability to see into the future. When he acquires the proficiency, he must select a soothsaying technique. Possibilities include casting pebbles on the ground, snapping a branch and checking the splintered wood, studying the wrinkles on a subject's face, examining the entrails of an animal, or gazing at the stars. Once he selects a technique, he can't change it. To use this proficiency, he must employ his technique; for instance, if his technique involves gazing at the stars, he can't make a soothsaying attempt during the day.\n\nIf he can employ his technique, the character may pose a single yes-or-no question. The question must relate to an event occurring within the next 30 days. Among the acceptable questions: \"Will we find treasure in the dragon's cave?\" \"Will our leader survive until the next full moon?\" \"Are these mushrooms safe to eat?\"\n\nThe DM makes a proficiency check in secret. If the check fails, the character receives no information. If the check succeeds, the DM answers the question honestly; if the DM isn't sure of the correct answer, he may say that the outcome is uncertain. If the character asked a question that the DM wishes to remain unanswered—for instance, he may not want the character to know that the dragon's cave contains treasure—he may decline to give the character any information, even if the check succeeds. On a natural roll of 20, the DM gives the character an incorrect answer.\n\nA character may use this proficiency once per week, regardless of whether the check succeeds or fails.\n\nCrossover Group: Priest."
    )
)
