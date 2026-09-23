import Foundation

/// Parte 11 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency1100: Proficiency = Proficiency(
    id: "hands_off_mount_control",
    name: "Hands-Off Mount Control",
    wikiPageTitle: "Hands-Off Mount Control (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Some drake-rider kits require the character to perform actions involving the free use of his or her hands while mounted upon a steed. This ability is especially useful for Wizards and Priests, as many spells require elaborate somatic components.",
        fullText: "## Dragon Magazine #260\n\nSome drake-rider kits require the character to perform actions involving the free use of his or her hands while mounted upon a steed. This ability is especially useful for Wizards and Priests, as many spells require elaborate somatic components. Other drake-riders might find it necessary to employ two-handed weapons such as bows or crossbows. In any case, when the rider's hands are otherwise employed, they cannot be used to direct the rider's mount.\n\nThe Hands-Off Mount Control nonweapon proficiency allows the rider to control his mount by means of pressure from his legs, a subtle shifting in weight, verbal commands, and so on. The profi- ciency allows the character to train his mount to respond to such subtle clues; it does not automati- cally invest such knowledge upon any mount the rider may use. The two must train together for 2d4+2 weeks before the mount respond to the rider's commands. The proficiency requires a riding mount of at least animal intelligence. It can be used on either land-based or aerial mounts."
    )
)

let embeddedProficiency1101: Proficiency = Proficiency(
    id: "harness_subconscious",
    name: "Harness Subconscious",
    wikiPageTitle: "Harness Subconscious (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Psionicist",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Harness Subconscious: This meditative proficiency lets the psionicist temporarily boost his total PSPs. In effect, the proficiency lets him tap into energy reserves that lie deep in his subconscious-reserves which are usually unavailable to him.",
        fullText: "## Complete Psionics Handbook\n\nHarness Subconscious: This meditative proficiency lets the psionicist temporarily boost his total PSPs. In effect, the proficiency lets him tap into energy reserves that lie deep in his subconscious-reserves which are usually unavailable to him. It's like enjoying a shot of psychic adrenaline.\n\nBefore he can harness subconscious energies, the psionicist's PSP total must be at its maximum. He then must spend two days (48 consecutive hours) gathering this energy, taking only necessary breaks for eating and sleeping. At the end of that time, the character makes a proficiency check. If he passes, he increases his PSP total by 20%, rounded up. The increase in PSPs lasts 72 hours. At the end of that time, the character loses as many strength points as he initially gained, regardless of his current total. This loss can never reduce his total below 0 points, however.\n\nDuring the 72 hours of heightened strength, the character cannot recover PSPs if his current total equals or exceeds his usual maximum. Once his current total drops below his usual maximum (i.e., once he has spent all bonus points), he can begin regaining PSPs normally. He cannot recover the lost bonus points, however; he can only recover enough points to return to his usual maximum.\n\n## Player's Option: Skills & Powers\n\nHarness Subconscious: Through the use of this proficiency, a psionicist temporarily boosts his PSP total. To procure these extra PSPs, the psionicist's PSP total must be at its maximum. Two full days (48 consecutive hours) must be spent gathering energy from subconscious reserves. At the end of this time, the psionicist makes a proficiency check. Success increases his PSP total by 20%, rounded up.\n\nThe extra PSPs remain available for 72 hours or until they are used up, whichever comes first. At the end of 72 hours, the psionicist loses as many PSPs as he gained from his current total (though the total won't drop below 0).\n\nDuring the 72 hours of boosted energy, the psionicist can't recover PSPs if his current total equals or exceeds his usual maximum. Once all of the bonus PSPs have been used, PSPs can be recovered normally up to the usual maximum.\n\n## Campaign Option: Council of Wyrms Setting\n\nOnly gem dragons may take the Harness Subconscious proficiency. It allows a gem dragon to temporarily boost its total PSPs (psionic strength points). Before harnessing subconscious energies, a dragon must be at its PSP maximum. The dragon must then spend 48 consecutive hours meditating, taking breaks only to eat and sleep. At the end of this period, the dragon makes a proficiency check. A success increases its PSP total by 20%, rounded up. The increase lasts for 72 hours.\n\nDuring the 72 hours of increased psionic strength, the dragon cannot recover PSPs beyond its usual maximum. At the end of this period, the dragon loses as many PSPs as it gained-but this loss cannot reduce its total below 0.\n\nHatchlings cannot take this proficiency."
    )
)

let embeddedProficiency1102: Proficiency = Proficiency(
    id: "healing",
    name: "Healing",
    wikiPageTitle: "Healing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition, Charisma/Leadership",
            characterPointCost: 4,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character proficient in healing knows how to use natural medicines and basic principles of first aid and doctoring.",
        fullText: "## Player's Handbook\n\nA character proficient in healing knows how to use natural medicines and basic principles of first aid and doctoring. If the character tends another within one round of wounding (and makes a successful proficiency check), his ministrations restore 1d3 hit points (but no more hit points can be restored than were lost in the previous round). Only one healing attempt can be made on a character per day.\n\nIf a wounded character remains under the care of someone with healing proficiency, that character can recover lost hit points at the rate of 1 per day even when traveling or engaging in nonstrenuous activity. If the wounded character gets complete rest, he can recover 2 hit points per day while under such care. Only characters with both healing and herbalism proficiencies can help others recover at the rate of 3 hit points per day of rest. This care does not require a proficiency check, only the regular attention of the proficient character. Up to six patients can be cared for at any time.\n\nA character with healing proficiency can also attempt to aid a poisoned individual, provided the poison entered through a wound. If the poisoned character can be tended to immediately (the round after the character is poisoned) and the care continues for the next five rounds, the victim gains a +2 bonus to his saving throw (delay his saving throw until the last round of tending). No proficiency check is required, but the poisoned character must be tended to immediately (normally by sacrificing any other action by the proficient character) and cannot do anything himself. If the care and rest are interrupted, the poisoned character must immediately roll a normal saving throw for the poison. This result is unalterable by normal means (i.e., more healing doesn't help). Only characters with both healing and herbalism proficiencies can attempt the same treatment for poisons the victim has swallowed or touched (the character uses his healing to diagnose the poison and his herbalist knowledge to prepare a purgative).\n\nA character with healing proficiency can also attempt to diagnose and treat diseases. When dealing with normal diseases, a successful proficiency check automatically reduces the disease to its mildest form and shortest duration. Those who also have herbalism knowledge gain an additional +2 bonus to this check. A proficient character can also attempt to deal with magical diseases, whether caused by spells or creatures. In this case, a successful proficiency check diagnoses the cause of the disease. However, since the disease is magical in nature, it can be treated only by magical means.\n\n## Player's Option: Skills & Powers\n\nCharacters with this proficiency can perform first aid on fresh wounds and can supervise the recovery of themselves and others. If the characters tend a wound on the round immediately after it is inflicted, a successful proficiency check means that 1d3 points of damage have been restored (to a maximum of the damage inflicted the previous round). If they tend a wound within one hour of its infliction, they can heal 1 point with a successful check. No character can benefit from this proficiency more than once a day.\n\nThis proficiency can also help with long-term healing and resisting poison and disease; these procedures are detailed in the ''Player's Handbook''.\n\n## Note from The Complete Paladin's Handbook\n\nA paladin's ability to heal by laying on hands (see Chapter 2) operates independently of this proficiency. A paladin with the Healing proficiency may use it instead of or in addition to laying hands on a damaged character. For example, a 2nd-level paladin with the healing proficiency could lay on hands to heal 4 points of damage, then use his healing proficiency to heal an additional 1d3 points.\n\n## The Complete Barbarian's Handbook Modifications\n\nA barbarian with the healing proficiency may only diagnose and treat diseases common in his homeland terrain. He may not treat a poisoned individual unless the victim is suffering from a natural, nonmagical poison. He must also be familiar with the source of the poison. If the victim has been poisoned by a creature, the creature must be native to the barbarian's homeland terrain. If the victim has been affected by a poisoned weapon, the poison must be from a plant, animal, or mineral found in the barbarian's homeland terrain.\n\n## Campaign Option: Council of Wyrms Setting\n\nHealing is described in the Player's Handbook. A successful check within one round of wounding restores 1d3 hit points (once per character per day); continued care automatically allows 1 (while traveling) or 2 (with complete bed rest) points of healing per day. Of course, a dragon learns to heal other dragons, so this proficiency cannot be used to aid any types of creatures other than a dragon's own kindred. A dragon with this proficiency can always try to help its own kindred.\n\nIf a dragon wishes, it can use additional slots to learn demihuman healing (for the same cost as the Healing proficiency). Demihuman healing covers dwarves, elves, and gnomes.\n\nHatchlings can't select this proficiency.\n\n## Shaman\n\nShamans cannot treat poison victims unless they are aware of what type of poison it is."
    )
)

let embeddedProficiency1103: Proficiency = Proficiency(
    id: "heat_protection",
    name: "Heat Protection",
    wikiPageTitle: "Heat Protection (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character who has the heat protection proficiency has learned to pace himself and use clothing to optimize endurance against the rigors of Athas's heat.",
        fullText: "## Dark Sun Campaign Setting Revised\n\nA character who has the heat protection proficiency has learned to pace himself and use clothing to optimize endurance against the rigors of Athas's heat. With a successful check, the character need only consume half the normal amount of water per day to avoid dehydration.\n\nIn combat, the heat protection proficiency allows a character wearing metal armor to battle better and longer. A successful check each round allows him to avoid the THAC0 penalty for that round. In addition, when he reaches his Constitution score limit to rounds of combat, a successful check allows him to fight for five more rounds. This check can be made at the end of every subsequent five-round period, but once it fails the character collapses from exhaustion.\n\nDehydration is explained in Chapter 8: DM Material. The effects of using metal armor in combat appear in Chapter 3: Money and Equipment."
    )
)

let embeddedProficiency1104: Proficiency = Proficiency(
    id: "heraldry",
    name: "Heraldry",
    wikiPageTitle: "Heraldry (Proficiency)",
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
            characterPointCost: 2,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "The knowledge of heraldry enables the character to identify the different crests and symbols that denote different persons and groups. Heraldry comes in many forms and is used for many different purposes.",
        fullText: "## Player's Handbook\n\nThe knowledge of heraldry enables the character to identify the different crests and symbols that denote different persons and groups. Heraldry comes in many forms and is used for many different purposes. It can be used to identify noblemen, families, guilds, sects, legions, political factions, and castes. The symbols may appear on flags, shields, helmets, badges, embroidery, standards, clothing, coins, and more. The symbols used may include geometric patterns, calligraphed lines of script, fantastic beasts, religious symbols, and magical seals (made for the express purpose of identification). Heraldry can vary from the highly formalized rules and regulations of late medieval Europe to the knowledge of different shield patterns and shapes used by African tribesmen.\n\nThe character automatically knows the different heraldic symbols of his homeland and whom they are associated with. In addition, if the character makes a successful proficiency check, he can correctly identify the signs and symbols of other lands, provided he has at least a passing knowledge of the inhabitants of that land. His heraldry skill is of little use upon first entering a foreign land.\n\n## Player's Option: Skills & Powers\n\nThese characters are familiar with the heraldic symbols of their own lands, and those of neighboring lands. The characters can make proficiency checks when confronted with unusual or rare symbols; success means that they can identify the symbols. A character with the obscure knowledge trait gains a +2 bonus to the use of this proficiency."
    )
)

let embeddedProficiency1105: Proficiency = Proficiency(
    id: "heraldry_space",
    name: "Heraldry, Space",
    wikiPageTitle: "Heraldry, Space (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The knowledge of heraldry enables the character to identify the crests and symbols that denote different persons and groups.",
        fullText: "## The Complete Spacefarer's Handbook\n\nThe knowledge of heraldry enables the character to identify the crests and symbols that denote different persons and groups. In space, this is a matter of interpreting the decorations and pennants on ship hulls, knowing the various types of ships and which races use them.\n\nThus, on a successful Heraldry (Space) proficiency check, the character could identify the pennant at the mast of a nearby hammership as that of the dread captain Clive the Fearsome of Realmspace."
    )
)

let embeddedProficiency1106: Proficiency = Proficiency(
    id: "herbalism",
    name: "Herbalism",
    wikiPageTitle: "Herbalism (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard (Rogue - Thief's Handbook)"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge, Wisdom/Intuition",
            characterPointCost: 3,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "Those with herbalist knowledge can identify plants and fungus and prepare nonmagical potions, poultices, powders, balms, salves, ointments, infusions, and plasters for medical and pseudo-medical purposes.",
        fullText: "## Player's Handbook\n\nThose with herbalist knowledge can identify plants and fungus and prepare nonmagical potions, poultices, powders, balms, salves, ointments, infusions, and plasters for medical and pseudo-medical purposes. They can also prepare natural plant poisons and purgatives. The DM must decide the exact strength of such poisons based on the poison rules in the DMG. A character with both herbalism and healing proficiencies gains bonuses when using his healing talent (see the Healing proficiency).\n\n## Player's Option: Skills & Powers\n\nHerbalism: This skill indicates that a character is familiar with the uses of natural plant products for good and ill. If a character spends a day searching the woods, and makes a successful proficiency check, enough herbs, fungi, roots, leaves, pollen, and pulp has been gleaned for 2d6 doses.\n\nThe most common use of these herbs is as an aid to healing; one dose of herbs can be used in conjunction with the healing proficiency (by the herbalist or another healer). This dose adds +1 point to the wounds cured by a successful healing proficiency check. Even if the healing check fails, the herbs still restore the 1 hit point. With no healing proficiency, the herbs can still be used, but the herbalist needs to roll a successful check to restore the 1 hit point.\n\nThe herbs also can be used to create a poison, either ingested or injected. A single use of poison requires two doses of herbs. The lethality or other effects of the poison (paralysis, unconsciousness, delusions, etc.) must be worked out with the DM.\n\n## The Complete Thief's Handbook\n\nRecommended: Assassin, Bounty Hunter.\n\nA knowledge of herbs, particularly those with poisonous qualities, is of value to Assassins and Bounty Hunters. And Scouts often learn the types and properties of plants in their wilderness journeys. This proficiency is normally restricted to priests and wizards. Its description is on p.&nbsp;59 of the ''Player's Handbook''. See also p.&nbsp;26 of this book for information on the use of this proficiency with the assassin thief kit.\n\n## The Complete Barbarian's Handbook Modifications\n\nA barbarian may only identify and work with vegetation native to his homeland terrain. If he has both the herbalism and healing proficiencies, he may prepare and treat poisons in accordance to the restrictions outlined in the healing proficiency description above. With the DM's permission, assume that a barbarian carries a reasonable number of healing and poisonous herbs from his homeland.\n\n## Campaign Option: Council of Wyrms Setting\n\nHerbalism allows a dragon to identify plants and fungi, and also prepare nonmagical potions, poultices, powders, balms, salves, and ointments for medical purposes. See the Player's Handbook for more details.\n\nHatchlings can't select this proficiency.\n\n## Dragon Magazine\n\nDragon Magazine #269 Expands on the rules for herbalism in the article Herbcraft."
    )
)

let embeddedProficiency1107: Proficiency = Proficiency(
    id: "herding",
    name: "Herding",
    wikiPageTitle: "Herding (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Wisdom",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Herding is the non-weapon proficiency equal to the Herder skill.",
        fullText: "## Dragon Magazine #247\n\nHerding is the non-weapon proficiency equal to the Herder skill.\n\nHerder is the skill of maintaining domestic animals for a living. The primary herd animals are cattle, horses, sheep, and goats. The skill covers learning to live off the animals, maintaining their health, moving them in large groups, breeding them, and knowing how to maximize their use. Thus, a herder would have at least some knowledge of butchering, skinning, tanning, milking, making cheese, shearing, etc."
    )
)

let embeddedProficiency1108: Proficiency = Proficiency(
    id: "hiding",
    name: "Hiding",
    wikiPageTitle: "Hiding (Proficiency)",
    redirectAliases: ["CBarbH Table 35"],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Hiding is the ability to instinctively select the best hiding place under nearly any condition. Humanoids who make successful checks can virtually disappear from view.",
        fullText: "## The Complete Book of Humanoids\n\nHiding is the ability to instinctively select the best hiding place under nearly any condition. Humanoids who make successful checks can virtually disappear from view. Success is determined by modifiers based upon the Intelligence of the character being hidden from. This proficiency operates independently of any natural camouflage or hiding ability the humanoid might already have.\n\n{| class=\"article-table\"\n|+ Hiding Modifiers\n! Opponent's\nIntelligence || Modifier\n|-\n| 3 or less || -5\n|-\n| 4-5 || -3\n|-\n| 6-8 || -1\n|-\n| 9-12 || 0\n|-\n| 13-15 || +1\n|-\n| 16-17 || +2\n|-\n| 18 || +3\n|-\n| 19 || +5\n|-\n| 20+ || +7\n|}\n\n## The Complete Barbarian's Handbook\n\nThis proficiency lets a character use the natural elements of the immediate environment—vegetation, shadows, depressions—to conceal himself. A successful check means he's virtually disappeared from view. The hidden character must remain motionless and silent to prevent discovery.\n\nThe concealed character stays hidden unless the creature or character searching for him makes a successful Intelligence check, modified as shown on Table 35. If more than one character or creature is searching the same area, base the check on the highest Intelligence score in the group.\n\nThe DM may prohibit the use of the hiding proficiency in situations where no natural cover is available (a smooth stone plateau, a featureless room). Further, the proficiency has no effect on creatures who detect their prey with senses other than sight.\n\nBarbarians: As explained in Chapter 1, a barbarian automatically has the hiding proficiency in his homeland terrain. If he spends two slots, he may use this proficiency in all types of terrain.\n\nCrossover Group: General.\n\n{| class=\"article-table\"\n|+ Table 35: Hiding Modifiers\n! Searcher's\nIntelligence || Modifier\n|-\n| 3 or less || -5\n|-\n| 4-5 || -3\n|-\n| 6-8 || -1\n|-\n| 9—12 || 0\n|-\n| 13-15 || +1\n|-\n| 16-17 || +2\n|-\n| 18 || +3\n|-\n| 19 || +5\n|-\n| 20+ || +7\n|}"
    )
)

let embeddedProficiency1109: Proficiency = Proficiency(
    id: "hierarchy_contact",
    name: "Hierarchy Contact",
    wikiPageTitle: "Hierarchy Contact (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Mystic (MotRD)"],
        slotsRequired: 2,
        rawSlots: "2 slots",
        relevantAbility: "Charisma",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters with positions in established church hierarchies or other organized religions may have access to resources unavailable to other characters.",
        fullText: "## Dragon Magazine #236\n\nCharacters with positions in established church hierarchies or other organized religions may have access to resources unavailable to other characters. This proficiency reflects such resources, and indicates that the character knows how to work within his or her hierarchy to get information and other supplies an adventuring party may need. In Bram Stoker's Dracula, Abraham Van Helsing uses holy wafers in a putty to seal the tomb of Lucy Westenra. He could do this because, as he says, “I have an Indulgence.” (Of course, A Gothic Earth Gazetteer notes that Van Helsing is “a very close friend” of Pope Leo XIII. No such close relationship is implied in this proficiency!)\n\nThis proficiency may be used to gather information about a specific place, person, or object. This use of the proficiency is much like consulting a sage, as described in the Dungeon Master® Guide. No proficiency check is required for the character, just a normal success roll for the “sage.”\n\nMonetary resources are not required, but the character must have access to modern means of communication — either telegraph or mail systems. Especially in the latter case, information can be significantly delayed in transit. The fields of study to which the character's contact has access are somewhat limited, at the DM's discretion.\n\nA successful proficiency check gives the character access to consecrated or otherwise special items which may be useful in battling the supernatural. This use of the proficiency is entirely at the DM's discretion, but may provide holy water, blessed weapons, holy wafers or their equivalent, or other such items."
    )
)

let embeddedProficiency1110: Proficiency = Proficiency(
    id: "high_magic",
    name: "High Magic",
    wikiPageTitle: "High Magic (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge, Wisdom/Willpower",
            characterPointCost: 4,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency gives the character a formal knowledge of the most powerful magics in the campaign world (a knowledge of realm magic, for example), including true dweomers and other tenth-level magic.",
        fullText: "This proficiency gives the character a formal knowledge of the most powerful magics in the campaign world (a knowledge of realm magic, for example), including true dweomers and other tenth-level magic. Lesser-known and obscure bits of information will be \"remembered\" with a successful proficiency check. DMs may disallow this proficiency on a case-by-case basis (i.e., an Anuirean regent might know much about realm magic, but his commoner bodyguard will not)."
    )
)

let embeddedProficiency1111: Proficiency = Proficiency(
    id: "hold_breath",
    name: "Hold Breath",
    wikiPageTitle: "Hold Breath (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Constitution",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Hold Breath: This proficiency helps a character hold her breath for extended periods of time. (See the rules in the ''Player's Handbook'', Chapter 14, for the amount of time a character can normally hold her breath.)",
        fullText: "Hold Breath: This proficiency helps a character hold her breath for extended periods of time. (See the rules in the ''Player's Handbook'', Chapter 14, for the amount of time a character can normally hold her breath.)\n\nWith Hold Breath proficiency, a character can hold her breath for half her Constitution score in rounds (rounded up). If the character is exerting herself, this time is halved (again rounding up). When attempting to hold her breath beyond this time, the character rolls the usual\n\nConstitution check each round. The first check has no penalty, but each subsequent check takes a cumulative –1 penalty. Once a check is failed, the character must breathe; if she cannot reach air, she dies."
    )
)

let embeddedProficiency1112: Proficiency = Proficiency(
    id: "homeopathy",
    name: "Homeopathy",
    wikiPageTitle: "Homeopathy (Proficiency)",
    redirectAliases: ["Homeopathy (NWP)"],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -5,
        rawModifier: "-5",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Homeopathy Intelligence -5",
        fullText: "Homeopathy Intelligence -5\n\n1 Slot\n\nPriest, Wizard\n\nHomeopathic herbalism is a \"last ditch\" method of healing. When all else fails and no cure can be found (such as with poisons or diseases like mummy rot), a practitioner of Homeopathy can make a proficiency check and try reintroducing the malady in an attempt at eradicating it. While a success means further damage halts, a failure means the subject is reinfected at one-quarter the virulence of the original malaise, and both \"illnesses\" must be eradicated before the patient can be healed.\n\nHomeopathy\n\nHomeopathy is based on the principle that the functions of the body and spirit are centered in the concept of vital force, or \"life forces.\" Disruption of the vital force by either internal or external events causes an illness or disease called a similimum. A person's vital force then reacts to the disrupting similimum by altering the normal body functions.\n\nTreatment to resolve this conflict have the same similarity as the patient's condition. This concept is the basis of homeopathy: \"Like cures like.\" A serious case of illness is cured by the introduction of a small, diluted sample of the same disease. This method of \"fighting fire with fire\" dates back to ancient Greece."
    )
)

let embeddedProficiency1113: Proficiency = Proficiency(
    id: "horde_summoning",
    name: "Horde Summoning",
    wikiPageTitle: "Horde Summoning (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Charisma",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Though a character may spend the slots to acquire this proficiency at any point in his career, he may only use it when he reaches 10th level. The proficiency enables him to summon a horde of like-minded characters to carry out a specific mission.",
        fullText: "Though a character may spend the slots to acquire this proficiency at any point in his career, he may only use it when he reaches 10th level. The proficiency enables him to summon a horde of like-minded characters to carry out a specific mission.\n\nThe character may only summon a horde in his homeland. Only members from his homeland will join the horde. No evil-aligned members will respond.\n\nTo summon a horde, the character must meet the following conditions:\n\n* He must state a clear and specific mission for the horde, such as \"Defend our homeland from invasion,\" \"Gather food for our starving neighbors,\" or \"Drive the ogres from the forest.\"\n* He must designate a staging area in his homeland where the horde will gather.\n* He must remain in his homeland for a week to spread the word of his intentions.\n\nAt the end of the week, he makes a proficiency check. If the check fails, the horde fails to respond. He may spend another week attempting to rally a horde, making a second proficiency check at the end of this period, this time at a -3 penalty. If the check fails a second time, he cannot rally a horde for a period of one month.\n\nIf the check succeeds, the horde begins to assemble in the staging area at the rate of 500 men and women per week. The total number of members is equal to the summoner's experience point level divided by 2,000. (If the summoner has 1,500,000 experience points, the horde consists of 750 members; 500 arrive the first week, 250 the second week.) The number of members can't exceed the eligible population of the summoner's homeland.\n\nApproximately 90% of the horde consists of 0-level fighters. The remaining 10% consists of 1st-level fighters. The horde also includes one aide for every 500 members, rounded up; the aides have one-half the level of the summoner (rounded up) and should be the same class as the summoner. Additionally, each aide has two assistants; the assistants have one-half the level of the aides (rounded up) and may be any class of the DM's choice. Finally, the DM may include one wizard or priest per 1,000 members (rounded up); these characters have half the level of the summoner. (Example: A 14th-level warrior with 1,500,000 experience points summons a 750-member horde. The horde consists of 675 0-level fighters, 75 1st-level fighters, two 7th-level aides, four 4th-level assistants, and one 7th-level priest.)\n\nThe horde tries to fulfill its mission to the best of their ability. The summoner may not change the mission. If he attempts to do so, the horde immediately disbands and the members return home; the original mission fails. Likewise, if the horde remains inactive for more than two weeks, the members desert; again, the mission is a failure.\n\nOtherwise, the summoner can hold the horde together for a period of weeks equal to his level. Controlling the horde is a full-time job. During this time, the summoner is constantly required to settle disputes, assign duties, and punish the disobedient. Though his aides can handle many of these chores, the ultimate responsibility belongs to the summoner. In any given week that the summoner fails to devote his full attention to his horde, he must make a proficiency check. If the check fails, the horde disbands and the mission is a failure.\n\nIf the mission hasn't been completed in a number of weeks equal to the summoner's level—and the horde is still intact—the summoner may appeal to the horde to stay together longer. The summoner must make a proficiency check; if the horde is on the verge of success or they've managed to accumulate substantial treasure, the DM may modify the check by as much as +4. If the proficiency check succeeds, the horde remains intact for another week. If the check fails, the horde disbands and the mission fails. No horde may stay together for more weeks than 150% of the summoner's level, rounded up. (Theoretically, a 13th-level summoner could keep a horde together for 20 weeks. Note, however, that this would require successful proficiency checks for seven weeks in a row.)\n\nIf the horde disbands after a successful mission, the summoner will have a better chance of rallying them again; for the next year, he receives a +2 bonus when summoning a horde. But if the mission fails, his reputation suffers; he must wait a full year before he can attempt to summon another horde.\n\nBarbarians. A barbarian horde consists entirely of barbarian fighters, in the same proportions described above. At the DM's option, the horde may include a shaman (half the level of the summoner) for every 1,000 members, rounded up. The summoner may not order a horde to undertake a mission that requires them to leave their homeland unless he also has the leadership proficiency.\n\nCrossover Group: Warrior."
    )
)

let embeddedProficiency1114: Proficiency = Proficiency(
    id: "hunting",
    name: "Hunting",
    wikiPageTitle: "Hunting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior (Rogue - Thief's Handbook)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition",
            characterPointCost: 2,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "When in wilderness settings, the character can attempt to stalk and bring down game. A proficiency check must be made with a -1 penalty to the ability score for every nonproficient hunter in the party.",
        fullText: "## Player's Handbook\n\nWhen in wilderness settings, the character can attempt to stalk and bring down game. A proficiency check must be made with a -1 penalty to the ability score for every nonproficient hunter in the party. If the die roll is successful, the hunter (and those with him) have come within 101 to 200 yards (100+1d100) of an animal. The group can attempt to close the range, but a proficiency check must be made for each 20 yards closed. If the stalking is successful, the hunter automatically surprises the game. The type of animal stalked depends on the nature of the terrain and the whim of the DM.\n\n## Player's Option: Skills & Powers\n\nHunting: The hunting proficiency allows a character to find game and get reasonably close to it. The actual kill is handled using rolls to hit and for damage. Hunting is a proficiency that always requires a successful proficiency check when it is used.\n\nIf the check is successful, the hunter will reach a position within 1d100 + 100 yards of the quarry. Generally it will take about 2–12 daylight hours to reach this position, though an abundance or scarcity of game can decrease or increase this time at the DM's option. Night hunting might be possible for characters with infravision.\n\nThe hunter also possesses a basic skill at removing skin from an animal, and butchering the carcass into usable meat. These tasks require no checks.\n\n## The Complete Thief's Handbook\n\nRecommended: Bounty Hunter.\n\nThis proficiency is normally restricted to warriors. Its description is on p.&nbsp;59 of the ''Player's Handbook.''\n\n## Note from The Complete Paladin's Handbook\n\nA paladin whose ethos restricts any type of unnecessary killing will refuse to hunt merely for sport. Unless he has religious or cultural objections to eating meat, he hunts for food. Further, he stalks and kills dangerous animals that pose a threat to himself, his companions, or other innocent people.\n\n## The Complete Barbarian's Handbook Modifications\n\nA barbarian has a +2 bonus when hunting in his homeland terrain, or when hunting an animal native to his homeland terrain. For example, a barbarian from a jungle homeland doesn't qualify for a bonus when hunting in the plains. But if he stalks a jungle animal on the plains (such as a tiger that escaped from a king's private game preserve), he makes his proficiency checks at +2.\n\nTable 33 indicates the number of rations provided by various sizes of game animals. These figures are approximations; the actual numbers depend on the consumers' sizes (a bulky fighter may need more food than a slim cleric), ages (adolescents may eat more than the elderly), health (a healthy character can do with less food than his ailing companion), and activities (a character who spent the day fighting may need more food than a friend who spent the day reading).\n\n{| class=\"article-table\"\n|+ Table 33: Rations Produced Per Animal\n! Size of game animal || Number of rations*\n|-\n| S || 1-2/2-3\n|-\n| M || 3-4/4-6\n|-\n| L || 5-9/8-12\n|-\n| H || 9-15/15-25\n|}\n: * A ration is the food necessary to feed an average adult for one day. The figures to the left of the slash indicate the number of rations obtained when a character of average skill handles the butchering. The figures to the right show the number of rations obtained by a character with the animal rending proficiency (see below).\n\n## Campaign Option: Council of Wyrms Setting\n\nHunting is described in the AD&D Player's Handbook. With this proficiency, a dragon learns to stalk and bring down game with its natural weapons and talents. The DM decides the availability and type of prey. The ability score receives a -1 penalty for every nonhunter present. Success gets the group within 200 yards of the prey (100 +1d100). Closing, if desired, requires a check every 20 yards.\n\nHatchlings can take this proficiency."
    )
)
