import Foundation

/// Parte 24 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency2400: Proficiency = Proficiency(
    id: "underwater_communication",
    name: "Underwater Communication",
    wikiPageTitle: "Underwater Communication (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "While most surface dwellers need to leam this ability once in Serôs, any surface-world priests of water powers (such as Umberlee, Eldath, Deep Sashelas, and the like) automatically have this ability as a gift for their piety if they spend more than a tenday in the depths.",
        fullText: "While most surface dwellers need to leam this ability once in Serôs, any surface-world priests of water powers (such as Umberlee, Eldath, Deep Sashelas, and the like) automatically have this ability as a gift for their piety if they spend more than a tenday in the depths."
    )
)

let embeddedProficiency2401: Proficiency = Proficiency(
    id: "underwater_spellcasting",
    name: "Underwater Spellcasting",
    wikiPageTitle: "Underwater Spellcasting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest and Wizard"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The verbal component of spells cannot be done away with (if you use them in your campaign), and spellcasters need to earn how speak and thus cast spells, effectively underwater.",
        fullText: "The verbal component of spells cannot be done away with (if you use them in your campaign), and spellcasters need to earn how speak and thus cast spells, effectively underwater. Characters can become proficient in underwater speech and spellcasting in a marine environment. Through training, proficient PCs relearn how to vocalize the words for their spells and also learn how to better communicate in an undersea environment. They also learn how to cast spells with less broad movements for the spells' somatic components.\n\nSurface-born characters with the Underwater Spellcasting proficiency gain the ability to cast spells underwater and negate the initiative penalty for spellcasting mentioned above. They further benefit by learning to speak underwater as well (consider this to be the equivalent of the Underwater Communication proficiency). This proficiency, which is available under the Priest and Wizard groups, costs two slots and its relevant ability is Intelligence."
    )
)

let embeddedProficiency2402: Proficiency = Proficiency(
    id: "vapor_weave",
    name: "Vapor Weave",
    wikiPageTitle: "Vapor Weave (Proficiency)",
    redirectAliases: ["Vapor Weave (GEP)"],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 3,
        rawSlots: "3",
        relevantAbility: "Constitution",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The mists of the Ethereal Plane are unresolved substances full of possibility.",
        fullText: "The mists of the Ethereal Plane are unresolved substances full of possibility. This potential is lost on most travelers to the Misty Shore, but to those bloods with the vapor weave proficiency, the ethereal fogs are like an endless loom upon which to create desired effects. By concentrating his will (and with a successful proficiency check), an ethereal body can create minor but tangible effects from the ethereal medium for up to one hour per level. When the weaver's concentration lapses, so too does the manifestation, and a body can't manifest a new effect for I full hour while recovering from the mental effort.\n\nLike a cantrip spell, effects brought forth from the fogs are unable to cause a loss of hit points, cannot affect the concentration of spellcasters, and can only create small portions of a desired material. Furthermore, materials created by the vapor weave proficiency are extremely fragile, and a body can't use them as tools of any sort. Lastly, a manifestation of this type cannot duplicate the effects of a spell (save for cantrip), no matter how minor.\n\nExamples of vapor weave include the production of faerie lights, strange aromas, breezes, floating scripts containing only a few words, and the tinklings of \"ethereal\" music. Those cutters proficient in vapor weave can also temporarily stabilize a clump of ephemeral ether up to 1 foot in radius while they concentrate."
    )
)

let embeddedProficiency2403: Proficiency = Proficiency(
    id: "vehicle_handling",
    name: "Vehicle Handling",
    wikiPageTitle: "Vehicle Handling (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity/Dodge",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Vehicle Handling (1 Slot) Dexterity/Dodge",
        fullText: "Vehicle Handling (1 Slot) Dexterity/Dodge\n\nGroup: Warrior\n\nThis proficiency allows the character to control a wagon or chariot under difficult circumstances. The character can roll against this proficiency when a driving check is normally required."
    )
)

let embeddedProficiency2404: Proficiency = Proficiency(
    id: "venom_handling",
    name: "Venom Handling",
    wikiPageTitle: "Venom Handling (Proficiency)",
    redirectAliases: ["Venom Handling"],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard", "Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "With this proficiency, a character learns how to safely use both magical and mundane poisons. There is no danger of such a character accidentally stabbing someone with a poisoned weapon.",
        fullText: "## The Complete Book of Necromancers\n\nWith this proficiency, a character learns how to safely use both magical and mundane poisons. There is no danger of such a character accidentally stabbing someone with a poisoned weapon. Also, the character can identify a poison and a possible antidote by visual inspection of the venom or its symptoms in a victim (with an ability check). In addition, a character can identify naturally occurring animals, plants, or monsters that are poisonous (with an ability check). Any roll which fails by 4 or more results in a misidentification of both the poison and its antidote.\n\nAt the DM's discretion, characters with also the animal handling, herbalism, and brewing nonweapon proficiencies may be able to manufacture some of the more deadly poisons listed on page 73 of the DMG. The cost and time required for such an activity should be adjudicated by the DM, but providing all of the components are personally harvested by the character, it should take no less than 1–6 days to make one dose of poison. Magical poisons cannot be manufactured using this ability."
    )
)

let embeddedProficiency2405: Proficiency = Proficiency(
    id: "ventriloquism",
    name: "Ventriloquism",
    wikiPageTitle: "Ventriloquism (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge, Charisma/Leadership",
            characterPointCost: 4,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character has learned the secrets of \"throwing his voice.\" Although not actually making sound come from somewhere else (like the spell), the character can deceive others into believing this to be so.",
        fullText: "## Player's Handbook\n\nThe character has learned the secrets of \"throwing his voice.\" Although not actually making sound come from somewhere else (like the spell), the character can deceive others into believing this to be so. When using ventriloquism, the supposed source of the sound must be relatively close to the character. The nature of the speaking object and the intelligence of those watching can modify the character's chance of success. If the character makes an obviously inanimate object talk (a book, mug, etc.), a -5 penalty is applied to his ability score. If a believable source (a PC or NPC) is made to appear to speak, a +2 bonus is added to his ability score. The observer's intelligence modifies this as follows:\n\n{| class=\"article-table\"\n! Intelligence\n! Modifier\n|-\n| less than 3\n| +6\n|-\n| 3-5\n| +4\n|-\n| 6-8\n| +2\n|-\n| 9-14\n| 0\n|-\n| 15-16\n| -1\n|-\n| 17-18\n| -2\n|-\n| 19+\n| -4\n|}\n\nA successful proficiency check means the character has successfully deceived his audience. One check must be made for every sentence or response. The character is limited to sounds he could normally make (thus, the roar of a lion is somewhat beyond him).\n\nSince ventriloquism relies on deception, people's knowledge of speech, and assumptions about what should and shouldn't talk, it is effective only on intelligent creatures. Thus, it has no effect on animals and the like. Furthermore, the audience must be watching the character since part of the deception is visual (\"Hey, his lips don't move!\"). Using ventriloquism to get someone to look behind him does not work, since the voice is not actually behind him (this requires the ventriloquism spell). All but those with the gullibility of children realize what is truly happening. They may be amused—or they may not be.\n\n## Player's Option: Skills & Powers\n\nVentriloquism: Characters using this skill can make others believe that sounds and voices are coming from somewhere else. Such a character must pass a proficiency check to deceive an audience. This roll might be modified by some of these factors: the intelligence of the listeners (+/–3); the distance from the ventriloquist to the apparent source of the sound (not more than 20 feet); the believability of the ventriloquist's words and sounds; whether the audience can observe the proficient character; and the length of the ventriloquism display."
    )
)

let embeddedProficiency2406: Proficiency = Proficiency(
    id: "veterinary_healing",
    name: "Veterinary Healing",
    wikiPageTitle: "Veterinary Healing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The character can attempt to heal all types of normal animals, following the same procedures described in the description of the healing proficiency (returns 1-3 hit points if done within one round of wounding, once per creature per day; continued care can restore 1 hit point per day during non-strenuous traveling for up to 6 creatures; gives a +2 to save vs.",
        fullText: "## The Complete Ranger's Handbook\n\nThe character can attempt to heal all types of normal animals, following the same procedures described in the description of the healing proficiency (returns 1-3 hit points if done within one round of wounding, once per creature per day; continued care can restore 1 hit point per day during non-strenuous traveling for up to 6 creatures; gives a +2 to save vs. poison if treated for 5 rounds within a round after poisoning; diagnose disease, magical origins identified, natural diseases take mildest form and shortest duration). Supernatural creatures (such as skeletons or ghouls) or creatures from another plane (such as aerial servants or xorn) cannot be treated with this proficiency.\n\nThis proficiency is not cumulative with the healing proficiency—the first used will take precedence. The veterinary proficiency can be used on humans, demihumans, and humanoids at half the normal chance for success.\n\nCrossover Groups: Priest."
    )
)

let embeddedProficiency2407: Proficiency = Proficiency(
    id: "voice_mimicry",
    name: "Voice Mimicry",
    wikiPageTitle: "Voice Mimicry (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General (Rogue - Thief's Handbook & The Complete Ninja's Handbook)"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "Special",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "2 slots, Charisma, special modifiers.",
        fullText: "## The Complete Thief's Handbook\n\n2 slots, Charisma, special modifiers.\n\nRecommended: Assassin, Spy.\n\nVoice mimicry is the art of convincingly imitating the voices of other people. It is a very demanding skill, needing intense training of and practice with the vocal cords. For this reason it requires two nonweapon proficiency slots.\n\nA character with voice mimicry is able to imitate any accent he has heard. Success is automatic unless people who themselves speak in that accent are his listeners; in such a case, a proficiency roll is required (with a +2 modifier).\n\nMore difficult is the imitation of a specific person's voice. To do this, the thief must, of course, be familiar with the voice. A proficiency check is needed to determine if the imitation is detected; modifiers depend on how well the listeners know the voice that is being mimicked. Success is of course certain if the listener is a stranger, someone who has never heard the original voice. To fool an acquaintance, there is no modifier; while fooling a friend of the subject is at -2, a close friend -5, and someone extremely close (e.g., parent or spouse—someone who has had close contact with the person for years) is at -7.\n\nThis ability is often used in conjunction with the disguise proficiency. Which proficiency must be checked first depends on whether the character is seen or heard. If the disguise first is successful, there is a +5 modifier to the voice mimicry—the listeners have already accepted the appearance, so they are less likely to doubt the voice. If the disguise fails, it doesn't matter how good the voice imitation is. If the voice is successfully mimicked first, it gives a +1 modifier to the disguise check.\n\n## The Complete Book of Humanoids\n\nVoice mimicry is the art of convincingly imitating the voices of other people. It is a very demanding skill, requiring intense training and practice.\n\nA character with voice mimicry can imitate any accent he has heard. Success is automatic unless confronted by those who speak the mimicked accent (which then requires a check with a +2 modifier).\n\nIt is more difficult to imitate a specific person's voice. Characters can only attempt to imitate voices they have heard. A proficiency check must be made to determine if the imitation is detected. Success is certain if the listener is a stranger to the mimicked character. There is no modifier if trying to fool an acquaintance, -2 to fool a friend, -5 a close friend, and -7 for extremely close friends and relatives.\n\n## The Complete Ninja's Handbook\n\nThis proficiency, introduced in ''The Complete Thief's Handbook'', is the art of convincingly imitating the voices of others. It is a demanding skill, requiring intense training of the vocal cords.\n\nA character with Voice Mimicry proficiency can imitate any accent she has heard. Success is automatic, but if people who themselves speak in that accent are the character's listeners, a proficiency roll is required (with a +2 modifier).\n\nTo imitate a specific person's voice, the character must be familiar with that voice. A proficiency check determines if the imitation is detected, with modifiers based on the listeners' knowledge of the voice being mimicked. Success is certain if the listener has never heard the original voice. There is no modifier to fool an acquaintance of the original speaker, but the roll to fool a friend of the subject is penalized at –2. The penalty is –5 to fool a close friend of the subject, and –7 to fool someone who has had close contact with the person for years (a parent or spouse).\n\nWhen Voice Mimicry proficiency is used in conjunction with the Disguise proficiency, the decision on which proficiency to check first depends on whether the character is first seen or heard. If the Disguise proficiency check is rolled first and is successful, the subsequent Voice Mimicry check receives a +5 modifier. (The listeners have already accepted the character's appearance, so they are less likely to doubt the voice.) If the Disguise check fails, it doesn't matter how good the Voice Mimicry is. If the Voice Mimicry check is rolled first and is successful, the subsequent Disguise check receives a +1 modifier."
    )
)

let embeddedProficiency2408: Proficiency = Proficiency(
    id: "warrior_s_scream",
    name: "Warrior's Scream",
    wikiPageTitle: "Warrior's Scream (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Constitution",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This nonweapon proficiency requires 2 slots. The warrior's scream is a terrifying battle cry that strikes fear into the hearts of one's enemies.",
        fullText: "## Celts Campaign Sourcebook\n\nThis nonweapon proficiency requires 2 slots. The warrior's scream is a terrifying battle cry that strikes fear into the hearts of one's enemies. A character may utter the warrior's scream only on the first round of combat with a particular opponent, and gives up his first attack of that round in order to do so.\n\nThis feat requires a Constitution check. If successful, it has the effect of the 3rd-level priest spell prayer, but only on the character who uttered the scream and his current opponent. Opponents must roll a successful saving throw vs. fear to negate the effects of the scream; this saving throw may be rolled at the start of each melee round until it is successful."
    )
)

let embeddedProficiency2409: Proficiency = Proficiency(
    id: "water_divining",
    name: "Water Divining",
    wikiPageTitle: "Water Divining (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Psionicist",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with the water divining proficiency is able to pinpoint accurately the location of possible sources of water, using a Y-shaped willow stick.",
        fullText: "## Dragon Magazine #200\n\nA character with the water divining proficiency is able to pinpoint accurately the location of possible sources of water, using a Y-shaped willow stick. The stick is grasped by two of its arms, and the other arm pulls the diviner toward the largest source of water within a mile. If such a source does not exist, the diviner may still feel false vibrations, if the DM wishes.\n\nThe DM must make the proficiency check secretly; failure reveals nothing, and a roll of more than four above the needed number misleads the diviner.\n\nThe water found is not necessarily potable, and the one-mile range means that water divining is rarely effective on small islands, as the diviner is usually led toward the sea. This proficiency can be used only on the character's home plane.\n\nNotes: DMs running a DARK SUN campaign may decide to raise the cost of this proficiency to two slots or even forbid its use altogether. The water divining proficiency can find only water, not objects or people as the Dowse skill can."
    )
)

let embeddedProficiency2410: Proficiency = Proficiency(
    id: "water_find",
    name: "Water Find",
    wikiPageTitle: "Water Find (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Dark Sun"],
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
        briefSummary: "Even the most barren desert yields water to those who know how to find it.",
        fullText: "## Dark Sun Campaign Setting Revised\n\nEven the most barren desert yields water to those who know how to find it. Small animals burrow in the ground and store water there; some rare plants store water in cistern roots beneath the soil; and seemingly lifeless trees sometimes have moist heartwood.\n\nThe water find proficiency can only be used once per day and takes an hour to perform. During this time, the character can only move half his normal movement rate. A successful check indicates he's found sufficient water to sustain himself for one day. It doesn't mean that he's found enough water to rehydrate, but he won't dehydrate further that day. The character can only find enough water for himself. If he shares his find with others, none of them gains any benefit."
    )
)

let embeddedProficiency2411: Proficiency = Proficiency(
    id: "water_walking",
    name: "Water Walking",
    wikiPageTitle: "Water Walking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Dexterity",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Water Walking: This proficiency allows the character to correctly use mizugumo, the special pontoons that ninja use to walk across still water surfaces. The ninja must make a proficiency check each round.",
        fullText: "Water Walking: This proficiency allows the character to correctly use mizugumo, the special pontoons that ninja use to walk across still water surfaces. The ninja must make a proficiency check each round. An unsuccessful check means the ninja falls into the water with a big splash."
    )
)

let embeddedProficiency2412: Proficiency = Proficiency(
    id: "weakness_identification",
    name: "Weakness Identification",
    wikiPageTitle: "Weakness Identification (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Gladiator (Warrior)"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Weakness Identification: This proficiency, like Tactics, allows the gladiator to assess an opponent for signs of weakness.",
        fullText: "## The Complete Gladiator's Handbook\n\nWeakness Identification: This proficiency, like Tactics, allows the gladiator to assess an opponent for signs of weakness. A successful proficiency check means that the gladiator has located the foe's weakness, whether it lies in fighting style or a fault in the opponent's armor. If the gladiator wants to take the usual penalties for a called shot (+1 to initiative, —4 to attack), he can cause double damage to the opponent for one round only. After such a wound, intelligent opponents adjust their fighting style so that the weakness is not as exposed. Creatures with low\n\nIntelligence or less simply try to minimize the danger by presenting a different side to the attacker. Thus, if two or more gladiators attack a weakened creature, there is a good chance they can continue exploiting its weakness throughout the battle as it shifts the damaged area from one side to another.\n\nThe bonus conferred by this proficiency can be communicated to one's allies. However, if the creature under attack understands the language used to effect this communication, anyone attacking the creature does so with a —2 penalty.\n\nWhen used against a gladiator with the Arena Acting proficiency, the two sides involved must have a proficiency contest. Each character must make their respective Proficiency checks. The degree of success in this is measured by the difference between the target number and the actual die roll. The winner is the character with the higher degree of success. If the winner is using Weakness Identification, he spots the acting through some small flaw in the performance. Likewise, if the Arena Actor has the greater number, the one with Weakness Identification falls for it.\n\nExample: Bythal has an Arena Acting proficiency of his opponent Haarna has a Weakness Identification proficiency of 13. Bythal's roll is a 7, while Haarna's is a 3. Since Haarna's difference is greater at 10 (13-3=10) than Bythal's 7 (14—7=7), Haarna can easily see that Bythal is acting. He is not drawn in, and Bythal's bonus is negated.\n\nThe interchange here can be complicated. Some gladiators take both Arena Acting and Weakness Identification. Arena Acting should be checked first, so that the enemy may be fooled from the first instant he spies his opponent. After the gladiator assumes his weakness, he can begin checking his enemy for the same thing. Both these rolls should be rolled where only the DM can see them, so that the player does not know if he was successful in his various attempts."
    )
)

let embeddedProficiency2413: Proficiency = Proficiency(
    id: "weapon_improvisation",
    name: "Weapon Improvisation",
    wikiPageTitle: "Weapon Improvisation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "On Athas, virtually anything can be (and has been) used as a weapon. A character who has this proficiency makes a check to spot a usable weapon in the surrounding vicinity.",
        fullText: "## Dark Sun Campaign Setting Revised\n\nOn Athas, virtually anything can be (and has been) used as a weapon. A character who has this proficiency makes a check to spot a usable weapon in the surrounding vicinity. A successful check means the character has found a club that does 1d6+1 damage to human-sized and smaller creatures, or 1d3+1 to larger opponents.\n\nThe DM may assign modifiers for the ease or difficulty of finding such a weapon: a market might warrant a +2 bonus, a barren grassland a -2 penalty, and a sandy desert might negate the proficiency.\n\n## The Complete Barbarian's Handbook\n\nWith this proficiency, the character can improvise a weapon from natural materials. He must search the area for 1d6 rounds, then make a proficiency check. If the check fails, he finds nothing useful; he may try again in a different area. If the check succeeds, he finds an object that can be wielded as a club, such as a branch, a bone, or an icicle. The improvised weapon inflicts 1d6+1 damage to man-sized and smaller creatures, or 1d3+1 to larger opponents. On a natural roll of 1 or 2, the object has jagged projections or is sufficiently heavy to cause additional damage: man-sized and smaller creatures suffer 1d6+3 damage, larger opponents suffer 1d3+3 damage.\n\nOn a natural roll of 20, the improvised weapons shatters or splinters on its first use, causing no damage; it's useless thereafter.\n\nThe DM may veto the use of this proficiency in inappropriate environments, such as a barren plain or a snow-filled valley. Likewise, he may impose penalties or bonuses to the check in areas where improvised weapons are exceptionally difficult or easy to find. For example, a hill covered with stones might merit a +1 bonus; an empty plain might merit a -2 penalty.\n\nBarbarians. A barbarian receives a +2 bonus when searching for an improvised weapon in his homeland terrain.\n\nCrossover Group: Warrior."
    )
)

let embeddedProficiency2414: Proficiency = Proficiency(
    id: "weaponsmithing",
    name: "Weaponsmithing",
    wikiPageTitle: "Weaponsmithing (Proficiency)",
    redirectAliases: ["PHB Table 41"],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 3,
        rawSlots: "3 Slots",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3 (-1 Dwarves)",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge, Dexterity/Aim",
            characterPointCost: 5,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "This highly specialized proficiency enables a character to perform the difficult and highly exacting work involved in making metal weapons, particularly those with blades.",
        fullText: "## Player's Handbook\n\nThis highly specialized proficiency enables a character to perform the difficult and highly exacting work involved in making metal weapons, particularly those with blades. The character blends some of the skill of the blacksmith with an ability to create blades of strength and sharpness. A fully equipped smithy is necessary to use this proficiency.\n\nThe time and cost to make various types of weapons are listed on Table 41.\n\n{| class=\"article-table\"\n|+ Table 41: Weapon Construction\n! Weapon\n! Construction Time\n! Material Cost\n|-\n| Arrowhead\n| 10/day\n| 1 cp\n|-\n| Battle Axe\n| 10 days\n| 10 sp\n|-\n| Hand Axe\n| 5 days\n| 5 sp\n|-\n| Dagger\n| 5 days\n| 2 sp\n|-\n| H. Crossbow\n| 20 days\n| 10 sp\n|-\n| L. Crossbow\n| 15 days\n| 5 sp\n|-\n| Fork, Trident\n| 20 days\n| 10 sp\n|-\n| Spear, Lance\n| 4 days\n| 4 sp\n|-\n| Short Sword\n| 20 days\n| 5 sp\n|-\n| Long Sword\n| 30 days\n| 10 sp\n|-\n| 2-hd Sword\n| 45 days\n| 2 gp\n|}\n\n## Player's Option: Skills & Powers\n\nWeaponsmithing: This proficiency allows a character to create metal weapons. The Player's Handbook gives the time and material cost requirements for various types of weapons.\n\nA character who seeks to create a truly exceptional weapon, can make a proficiency check after the item is completed. If the check fails, the weapon is useless, melted down for its bare metal; if the check succeeds, the character has created a weapon that is worth 50% more than the typical example. These are the kinds of weapons selected by wizards for enchantment.\n\nDwarves get a +1 bonus to their rating with this proficiency.\n\n## The Complete Book of Dwarves\n\nA dwarf weaponsmith is not only more skilled than a human one (Intelligence -1, instead of -3), but capable of producing weapons at a faster rate. The costs remain the same.\n\n{| class=\"article-table\"\n|+ Weapon Construction Table\n! Weapon || Construction\nTime || Material\nCost\n|-\n| Arrowhead || 7/day || 1 cp\n|-\n| Battle Axe || 7 days || 10 sp\n|-\n| Hand Axe || 3 days || 5 sp\n|-\n| Dagger || 3 days || 2 sp\n|-\n| Heavy Crossbow || 15 days || 10 sp\n|-\n| Light Crossbow || 12 days || 5 sp\n|-\n| Fork, Trident || 15 days || 10 sp\n|-\n| Spear, Lance || 3 days || 4 sp\n|-\n| Short Sword || 15 days || 5 sp\n|-\n| Long Sword || 23 days || 10 sp\n|-\n| Two-handed Sword || 34 days || 2 gp\n|}"
    )
)
