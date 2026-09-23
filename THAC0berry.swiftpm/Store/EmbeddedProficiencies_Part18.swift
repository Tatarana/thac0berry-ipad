import Foundation

/// Parte 18 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency1800: Proficiency = Proficiency(
    id: "quick_study",
    name: "Quick Study",
    wikiPageTitle: "Quick Study (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Varies",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Quick Study: This proficiency allows a ninja to temporarily learn enough about a skill, a job, or an area of scholarship to pass as someone who belongs to a related profession.",
        fullText: "Quick Study: This proficiency allows a ninja to temporarily learn enough about a skill, a job, or an area of scholarship to pass as someone who belongs to a related profession.\n\nWhen using this proficiency, the ninja spends one week (eight hours a day) studying the skill she wishes to learn. At the end of the week, the character has a working knowledge of the field studied. Over the next several days, she will be able to pass as a practitioner of that skill, though not as an expert.\n\nWhen she has completed his study and must utilize the skill, the character makes a normal proficiency check with an additional –3 penalty. One week after the character has completed her study, she suffers a –2 penalty because she has forgotten some details of the skill. Each week thereafter, she takes another cumulative –2 penalty.\n\nThis proficiency will not allow a character to demonstrate an expert level of ability with the skill being simulated. If the character undertakes a task that, in the DM's estimation, calls for an especially broad or deep knowledge of the subject, the DM can decide that the character cannot perform the task. The character can then make a normal Intelligence check; success means that she realizes that she's in over her head and cannot succeed.\n\nIt is not possible to spend extra nonweapon proficiency slots on Quick Study to improve the roll. However, it is possible to buy the proficiency more than once in order to study two skills per mission."
    )
)

let embeddedProficiency1801: Proficiency = Proficiency(
    id: "read_qualith",
    name: "Read Qualith",
    wikiPageTitle: "Read Qualith (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Caradhaker Only"],
        slotsRequired: 2,
        rawSlots: "2 slots",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "As described in The Illithiad, mind flayers use a system of writing based on texture and touch called qualith. To the eye, qualith resembles four parallel striated lines.",
        fullText: "## Dragon Magazine #230\n\nAs described in The Illithiad, mind flayers use a system of writing based on texture and touch called qualith. To the eye, qualith resembles four parallel striated lines. To the non-illithid, the writing is fiendishly hard to grasp; full meaning comes only to those able to follow each of the four lines with a tentacle or other appendage simultaneously. Each line modifies the meaning of the other lines; the complete meaning is clear only in the gestalt presented by all four lines together.\n\nMindstalkers believe that to kill the illithids, they must understand the illithids. Thus, some labor to understand the illithid “alphabet.” Those with the read qualith proficiency can run four fingers along the striated lines to attempt to understand the message contained therein. A successful proficiency check allows a basic understanding of a passage or distinct message; fine inferences and nuances cannot be appreciated by non-illithids. Each separate message or passage requires an additional proficiency check to decipher."
    )
)

let embeddedProficiency1802: Proficiency = Proficiency(
    id: "read_spellshadow",
    name: "Read Spellshadow",
    wikiPageTitle: "Read Spellshadow (Proficiency)",
    redirectAliases: ["Read Spellshadow (GAP)"],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
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
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "After a body uses the spell probe spellshadow to discover and reveal a spellshadow (see \"Spellwarp: Astral Magic\"), this proficiency is used to examine the shadow and determine the identity of the caster and the circumstances in which it was cast.",
        fullText: "After a body uses the spell probe spellshadow to discover and reveal a spellshadow (see \"Spellwarp: Astral Magic\"), this proficiency is used to examine the shadow and determine the identity of the caster and the circumstances in which it was cast. Only a basher familiar with the spell used and its parameters can use this proficiency.\n\nA successful check reveals the identity of the caster. If a body manages to do that, a second check determines the time and place that the spell was cast. If these facts are discovered, a third check allows the cutter to determine the recipient, if any (if the spell has no recipient or this detail is obvious, this check can be skipped). Lastly, the fourth check determines whether or not a body learns the situation surrounding the casting of the spell. The situation could include details regarding whether the spell was cast in combat, as part of a deception, etc."
    )
)

let embeddedProficiency1803: Proficiency = Proficiency(
    id: "reading_lips",
    name: "Reading Lips",
    wikiPageTitle: "Reading Lips (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
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
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character can understand the speech of those he can see but not hear. When this proficiency is chosen, the player must specify what language the character can lip read (it must be a language the character can already speak).",
        fullText: "## Player's Handbook\n\nThe character can understand the speech of those he can see but not hear. When this proficiency is chosen, the player must specify what language the character can lip read (it must be a language the character can already speak). To use the proficiency, the character must be within 30 feet of the speaker and be able to see him speak. A proficiency check is made. If the check fails, nothing is learned. If the check is successful, 70% of the conversation is understood. Since certain sounds are impossible to differentiate, the understanding of a lip-read conversation is never better than this.\n\n## Player's Option: Skills & Powers\n\nReading Lips: Characters possessing this proficiency have a chance to understand the speech of those they can see but not hear. The speaker must be clearly visible, less than 30 feet away, and well-illuminated—characters cannot lip-read with infravision. If the speaker is addressing the lip reader and intends to be understood, no proficiency check is necessary. If lip readers attempt to “overhear” speech not directed to them, proficiency checks are required. Success means the gist of the words come through. The trait of empathy adds +2 to checks using this skill."
    )
)

let embeddedProficiency1804: Proficiency = Proficiency(
    id: "reading_writing",
    name: "Reading/Writing",
    wikiPageTitle: "Reading/Writing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard", "Psionicist (Rogue - Thief's Handbook)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge",
            characterPointCost: 2,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character can read and write a modern language he can speak, provided there is someone available to teach the character (another PC, a hireling, or an NPC).",
        fullText: "## Player's Handbook\n\nThe character can read and write a modern language he can speak, provided there is someone available to teach the character (another PC, a hireling, or an NPC). This proficiency does not enable the character to learn ancient languages (see Languages, Ancient).\n\n## Player's Option: Skills & Powers\n\nReading/Writing: The character is literate in a language that is contemporary to the campaign world, provided that the character can speak it (see the modern languages proficiency), For each additional character point spent on reading/writing, the character is literate in one additional language.\n\n## The Complete Thief's Handbook\n\nRecommended: Investigator, Spy.\n\nThis proficiency is normally restricted to priests and wizards. Its description is on p.&nbsp;61 of the ''Player's Handbook.''\n\n## Campaign Option: Council of Wyrms Setting\n\nThe Reading/Writing proficiency is described in the Player's Handbook. It allows a dragon to read and write a modern language it can speak. Each of the dragon languages has a written counterpart. Unless a dragon has a Dexterity score of 13 or better, it cannot make use of pens or brushes for writing on scrolls. Without a high Dexterity, the best a dragon can do is carve runes with its claws.\n\nHatchlings can't take this proficiency."
    )
)

let embeddedProficiency1805: Proficiency = Proficiency(
    id: "realmspace_lore",
    name: "Realmspace Lore",
    wikiPageTitle: "Realmspace Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Forgotten Realms"],
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
        briefSummary: "This proficiency gives the possessor automatic general knowledge about spelljamming and conditions in wildspace and the Phlogiston.",
        fullText: "## Warriors & Priests of the Realms\n\nThis proficiency gives the possessor automatic general knowledge about spelljamming and conditions in wildspace and the Phlogiston.\n\nThe DM may allow the player to read broad sections of material on spelljamming and crystal spheres from the 1989 SPELLJAMMER : AD&D Adventures in Space boxed set, the War Captain's Companion accessory, Lost Ships, and such entries from the two MONSTROUS COMPENDIUM SPELLJAMMER Appendices (MC7 and MC9) as deemed appropriate. An important article on the scro from the DRAGON Magazine Annual 1 (\"Campaign Classics: The Scro,\" page 44) might also be allowed for the player's use.\n\nFurther, a proficiency check grants the character special knowledge about Realmspace. A successful check allows use of the Realmspace accessory, Rock of Bral (if located in the Tears of Selûne), and so forth.\n\nMaterials on other crystal spheres cannot be used, and the DM may also disallow certain areas of knowledge that the character would logically not know, such as details on the mind flayers' operations at Glyth, or any elements of an upcoming wildspace adventure."
    )
)

let embeddedProficiency1806: Proficiency = Proficiency(
    id: "rejuvenation",
    name: "Rejuvenation",
    wikiPageTitle: "Rejuvenation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Psionicist",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Rejuvenation: This proficiency allows a character to recover PSPs while he meditates, as quickly as if he were sleeping. The character achieves a state of deep concentration, in which he focuses and regains his energies.",
        fullText: "## Complete Psionics Handbook\n\nRejuvenation: This proficiency allows a character to recover PSPs while he meditates, as quickly as if he were sleeping. The character achieves a state of deep concentration, in which he focuses and regains his energies. He is still conscious and aware of his surroundings, so he does not suffer any penalties on surprise or initiative rolls, and he is not helpless if attacked (he still can't expend PSPs, however).\n\n## Player's Option: Skills & Powers\n\nRejuvenation: This proficiency allows a psionicist to recover PSPs more quickly than is usual by entering a rejuvenating trance. This state of deep concentration requires a successful proficiency check. For every hour a hero maintains this trance (and makes the check), he regains PSPs at twice the usual rate (one-quarter of his total instead of one-eighth). He can't expend PSPs while in this trance, and his state is much like deep sleep.\n\n## Campaign Option: Council of Wyrms Setting\n\nRejuvenation is only available to gem dragons. It allows a gem dragon to recover PSPs while meditating, as quickly as if sleeping. In this meditative state, the dragon is still conscious and aware of its surroundings-it suffers no penalties on surprise or initiative rolls, and is not helpless if attacked. In this state, the dragon cannot expend PSPs, however. Hatchlings can't select this proficiency."
    )
)

let embeddedProficiency1807: Proficiency = Proficiency(
    id: "relic_dating",
    name: "Relic Dating",
    wikiPageTitle: "Relic Dating (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency proves useful whenever the character comes upon an object of questionable age. He can use this skill to gain an educated guess as to when the item was made.",
        fullText: "## Dragon Magazine #241\n\nThis proficiency proves useful whenever the character comes upon an object of questionable age. He can use this skill to gain an educated guess as to when the item was made. There is no roll necessary for those objects fashioned in the last 20 years (the age of these will be obvious to the character), unless it has been altered through non-magical means to appear much older; in that case, a successful proficiency check reveals the fraud. This proficiency can be combined with ancient history to give more accurate information as to the past of a relic."
    )
)

let embeddedProficiency1808: Proficiency = Proficiency(
    id: "religion",
    name: "Religion",
    wikiPageTitle: "Religion (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard", "Psionicist"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition",
            characterPointCost: 2,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "Characters with religion proficiency know the common beliefs and cults of their homeland and the major faiths of neighboring regions.",
        fullText: "## Player's Handbook\n\nCharacters with religion proficiency know the common beliefs and cults of their homeland and the major faiths of neighboring regions. Ordinary information (type of religious symbol used, basic attitude of the faith, etc.) of any religion is automatically known by the character. Special information, such as how the clergy is organized or the significance of particular holy days, requires a proficiency check.\n\nAdditional proficiencies spent on religion enable the character either to expand his general knowledge into more distant regions (using the guidelines above) or to gain precise information about a single faith. If the latter is chosen, the character is no longer required to make a proficiency check when answering questions about that religion. Such expert knowledge is highly useful to priest characters when dealing with their own and rival faiths.\n\n## Player's Option: Skills & Powers\n\nReligion: A character with this proficiency is familiar with the basic tenets of the major and minor faiths practiced in the campaign world. Observing an act of religious significance—a blessing of warriors before battle, for example—means the character understands the importance of the ritual without a proficiency check. Checks are required to understand the activities of unique or foreign religions. Additional character points spent on this proficiency can expand a character's knowledge to include other religions, or can increase the level of detailed knowledge about the faiths already studied.\n\n## Campaign Option: Council of Wyrms Setting\n\nThis proficiency is described in the Player's Handbook. This is assumed to be one of the following: general knowledge of the prevailing religion among the local vassals, general knowledge of the Custodians of Concordance, general knowledge of a religion of a local monster group, or general knowledge of a personal patron. Specific knowledge requires a proficiency check. Adding a second proficiency in the same religion gives specific knowledge (such as its organization, rites, holy days, etc.). Dragon religion is detailed in Section II.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency1809: Proficiency = Proficiency(
    id: "research",
    name: "Research",
    wikiPageTitle: "Research (Proficiency)",
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
        briefSummary: "Research: A wizard with this skill is well-versed in the theory and application of spell research.",
        fullText: "Research: A wizard with this skill is well-versed in the theory and application of spell research. He is familiar with the use of libraries, laboratories, and other resources, and also has a good grasp of the fundamental processes of experimentation and problem-solving. With a successful proficiency check, the character gains a +5% bonus to his success roll when researching a new spell and only requires one-half the usual amount of time to perform spell research or determine the process necessary to manufacture a particular magical item. However, the amount of money spent on research remains the same because the wizard is still expending the same amount of books and supplies."
    )
)

let embeddedProficiency1810: Proficiency = Proficiency(
    id: "rhetoric",
    name: "Rhetoric",
    wikiPageTitle: "Rhetoric (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma?",
        checkModifier: 0,
        rawModifier: "Unknown",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Rhetoric: A character who has this proficiency has mastered the Greek science of public oratory. He can speak well, but more importantly, he knows the accepted rules and conventions for delivering legal and political speeches.",
        fullText: "## The Glory of Rome Campaign Sourcebook\n\nRhetoric: A character who has this proficiency has mastered the Greek science of public oratory. He can speak well, but more importantly, he knows the accepted rules and conventions for delivering legal and political speeches. Rhetoric was adopted by the Romans after the Punic Wars and became an integral part of the education of upper-class Romans. Many citizens attended the law courts and political speeches not out of interest in the case or issues, but simply to hear the most skilled orators speak.\n\nWhen a character makes a formal speech in Latin or Greek to an audience of educated Romans or Greeks, he may make a Rhetoric proficiency check. If successful, his delivery was excellent (regardless of the content of the speech) and the audience was at least entertained and possibly moved; the DM can give a +5 bonus on subsequent use of Law or Politics proficiencies. However, use of rhetoric does not impress barbarians or proles, nor is it appropriate for haggling with merchants over prices! If two characters with rhetoric get into a debate over an issue, the highest roll that also succeeds wins; only the winner receives a bonus.\n\nRhetoric is a general proficiency, counting as one slot."
    )
)

let embeddedProficiency1811: Proficiency = Proficiency(
    id: "riding_airborne",
    name: "Riding, Airborne",
    wikiPageTitle: "Riding, Airborne (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Willpower, Dexterity/Balance",
            characterPointCost: 4,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character is trained in handling a flying mount. The particular creature must be chosen when the proficiency is chosen.",
        fullText: "## Player's Handbook\n\nThe character is trained in handling a flying mount. The particular creature must be chosen when the proficiency is chosen. Additional proficiency slots can be used to learn how to handle other types of mounts. Unlike land-based riding, a character must have this proficiency (or ride with someone who does) to handle a flying mount. In addition, a proficient character can do the following:\n\n* Leap onto the saddle of the creature (when it is standing on the ground) and spur it airborne as a single action. This requires no proficiency check.\n* Leap from the back of the mount and drop 10 feet to the ground or onto the back of another mount (land-based or flying). Those with only light encumbrance can drop to the ground without a proficiency check. In all other situations, a proficiency check is required. A failed roll means the character takes normal falling damage (for falling flat on his face) or misses his target (perhaps taking large amounts of damage as a result). A character who is dropping to the ground can attempt an immediate melee attack, if his proficiency check is made with a -4 penalty to the ability roll. Failure has the consequences given above.\n* Spur his mount to greater speeds on a successful check, adding 1d4 to the movement rate of the mount. This speed can be maintained for four consecutive rounds. If the check fails, an attempt can be made again the next round. If two checks fail, no attempt can be made for a full turn. After the rounds of increased speed, its movement drops to 2/3 its normal rate and its Maneuverability Class (see Glossary) becomes one class worse. These conditions last until the mount lands and is allowed to rest for at least one hour.\n* The rider can guide the mount with his knees and feet, keeping his hands free. A proficiency check is made only after the character suffers damage. If the check is failed, the character is knocked from the saddle. A second check is allowed to see if the character manages to catch himself (thus hanging from the side by one hand or in some equally perilous position). If this fails, the rider falls. Of course a rider can strap himself into the saddle, although this could be a disadvantage if his mount is slain and plummets toward the ground.\n\n## Player's Option: Skills & Powers\n\nRiding, Airborne and Riding, Land: The riding proficiencies are well-detailed in the ''Player's Handbook''. Characters using the Skills and Powers rules can add +2 to their proficiency score in either category of riding if they possess the trait of animal empathy, and +1 if they have the additional proficiency in animal training. These modifiers are cumulative.\n\n## The Complete Book of Dwarves\n\nThis proficiency is rare among dwarves, and is most frequently found in those living in remote mountain areas, among dwarves who have befriended giant eagles or have tamed and trained winged mounts: griffins, hippogriffs, or others. This proficiency may not be used to leap onto the backs of mounts, unless you also have the jumping proficiency. In other respects, this proficiency is unchanged from the ''Player's Handbook''.\n\n## Note from The Complete Ranger's Handbook\n\nA ranger cannot use his species enemy as an airborne or land-based mount. If the mount is a follower, use the guidelines in Chapter 3 instead of the proficiency rules.\n\n## Note from The Complete Paladin's Handbook\n\nWhen riding his bonded mount, a paladin automatically has all of the benefits of the relevant Riding proficiency; he doesn't need the proficiency itself (see Chapter 2). But if he has the Riding proficiency, he gains a +2 bonus when making all associated checks with his mount. For instance, if he has a war horse bonded mount and the Land-based Riding proficiency, he earns a +2 bonus when attempting to vault into the saddle when the mount is moving. If he has a pegasus bonded mount and the Airborne Riding proficiency, he suffers a –2 penalty (instead of –4) when making checks to see if he falls from his saddle after suffering damage. The bonuses apply only when riding the bonded mount. When riding a creature of the same species as the bonded mount, use the normal Riding proficiency rules.\n\n## The Complete Barbarian's Handbook Modifications\n\nA barbarian may only ride land-based or airborne mounts native to his homeland. Because of his exceptional physical prowess, a barbarian can execute any of the special feats listed in the Player's Handbook descriptions without a saddle. For instance, he can leap onto an airborne mount's bare back and spur it into the air as a single action. He must still make all required proficiency checks."
    )
)

let embeddedProficiency1812: Proficiency = Proficiency(
    id: "riding_camel_specialization",
    name: "Riding, Camel Specialization",
    wikiPageTitle: "Riding, Camel Specialization (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior", "Rogue"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Wisdom",
        checkModifier: 4,
        rawModifier: "+4",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency resembles the one above, but rather than riding and keeping horses, camel-riders become masters of camels.",
        fullText: "This proficiency resembles the one above, but rather than riding and keeping horses, camel-riders become masters of camels. A character with this proficiency gains the following skills:\n* The rider can fall from a camel and suffer no damage upon making a successful proficiency check.\n* The character can vault onto a moving camel upon making a successful check—assuming there are ropes, saddles, or patches of fur to allow such\nmounting. (This feat is more difficult than vaulting onto a horse.) Failure indicates that the individual is sprawled in the dust, but suffers no damage beyond a battered pride.\n* Upon making a successful proficiency check, the camel-rider can grab an item while riding past it, provided the item is within reach (typically having a handhold at least 3 feet above the ground). Living targets can fight back, and if they succeed in striking the rider, the attempt to grab is foiled.\n* The character can ride a camel without a saddle and suffer no discomfort or loss in ability. The character can even use spears or lances while riding bareback.\n* The rider can persuade a camel to move at twice its normal daily movement rate for up to 10 days without ill consequence, provided that a proficiency check is made each day. This does not mean that the rider's camel is moving faster only that the character has urged an otherwise recalcitrant beast to keep to its path.\n\nA rider with this proficiency is also a master at caring for camels, able to identify camel afflictions and immediately discern the quality of a camel. (See Chapter 6 in the DMG.) A camel-rider who also has the animal training proficiency can break a camel of unpleasant traits in 1d4 weeks, provided both proficiency checks are made. Similarly, an individual with both proficiencies can train a camel to perform a particular trick in 1d4 weeks (such as \"come when called\" or \"don't bite unless I give the command\"). Such a trick is not a bonus; it counts toward the total number of feats (2d4) that any camel can learn.\n\nThis proficiency refers only to camels; if any other mount is used, the benefits do not apply. (To receive those benefits, the character must take the land-based riding proficiency for the new mount.)"
    )
)

let embeddedProficiency1813: Proficiency = Proficiency(
    id: "riding_horse_specialization",
    name: "Riding, Horse Specialization",
    wikiPageTitle: "Riding, Horse Specialization (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior", "Rogue"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Wisdom",
        checkModifier: 4,
        rawModifier: "+4",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters with this proficiency can ride and perform stunts on horseback even better than characters with the land-based riding proficiency described in the ''Player's Handbook''.",
        fullText: "Characters with this proficiency can ride and perform stunts on horseback even better than characters with the land-based riding proficiency described in the ''Player's Handbook''. Horse specialization enables a rider to do everything that land-based riding involves, plus the following:\n* The rider suffers no damage from falling from a horse, provided that a proficiency check is made.\n* The character can leap or vault onto a moving horse upon making a successful proficiency check. Failure indicates that the rider lies sprawled in the dust, suffering no damage other than battered pride.\n* While seated, the rider can grab an item from the ground even if the horse is at a full gallop, upon making a successful proficiency check. A handkerchief is easy to snare. A living target, however, has the opportunity to fight back. Should, for example, a damsel happen to punch her would-be rescuer, the horseman's attempt would fail.\n* The character automatically can ride bareback with no discomfort or loss in ability. The character can even use spears or lances without need of a saddle.\n\nIn addition to combat benefits, characters with this proficiency are masters at caring for horses, able to identify horse afflictions and tell immediately the quality of a horse (as noted in Chapter 6 of the ''Dungeon Master's Guide''). Characters who combine this proficiency with animal training can break a horse of unpleasant traits in one to four (1d4) weeks, provided both proficiency checks are made. Similarly, they can use both proficiencies to train a horse to perform a trick in just 1d4 weeks (instead of the usual 2d6 weeks required with animal training alone). A horse can learn only 1d4 tricks in this speedy fashion. The tricks are not bonuses; they count toward the total number of feats (2d4) that any horse can learn.\n\nThis proficiency applies only to horsemanship. If any other mount is used—including related creatures such as zebras or unicorns—the benefits do not apply."
    )
)

let embeddedProficiency1814: Proficiency = Proficiency(
    id: "riding_land_based",
    name: "Riding, Land-Based",
    wikiPageTitle: "Riding, Land-Based (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 3,
        rawModifier: "+3",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Willpower, Dexterity/Balance",
            characterPointCost: 2,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "Those skilled in land riding are proficient in the art of riding and handling horses or other types of ground mounts. When the proficiency slot is filled, the character must declare which type of mount he is proficient in.",
        fullText: "## Player's Handbook\n\nThose skilled in land riding are proficient in the art of riding and handling horses or other types of ground mounts. When the proficiency slot is filled, the character must declare which type of mount he is proficient in. Possibilities include griffons, unicorns, dire wolves, and virtually any creatures used as mounts by humans, demihumans, or humanoids.\n\nA character with riding proficiency can perform all of the following feats. Some of them are automatic, while others require a proficiency check for success.\n* The character can vault onto a saddle whenever the horse or other mount is standing still, even when the character is wearing armor. This does not require a proficiency check. The character must make a check, however, if he wishes to get the mount moving during the same round in which he lands in its saddle. He must also make a proficiency check if he attempts to vault onto the saddle of a moving mount. Failure indicates that the character falls to the ground—presumably quite embarrassed.\n* The character can urge the mount to jump tall obstacles or leap across gaps. No check is required if the obstacle is less than three feet tall or the gap is less than 12 feet wide. If the character wants to roll a proficiency check, the mount can be urged to leap obstacles up to seven feet high, or jump across gaps up to 30 feet wide. Success means that the mount has made the jump. Failure indicates that it balks, and the character must make another proficiency check to see whether he retains his seat or falls to the ground.\n* The character can spur his steed on to great speeds, adding 6 feet per round to the animal's movement rate for up to four turns. This requires a proficiency check each turn to see if the mount can be pushed this hard. If the initial check fails, no further attempts may be made, but the mount can move normally. If the second or subsequent check fails, the mount immediately slows to a walk, and the character must dismount and lead the animal for a turn. In any event, after four turns of racing, the steed must be walked by its dismounted rider for one turn.\n* The character can guide his mount with his knees, enabling him to use weapons that require two hands (such as bows and two-handed swords) while mounted. This feat does not require a proficiency check unless the character takes damage while so riding. In this case, a check is required and failure means that the character falls to the ground and sustains an additional 1d6 points of damage.\n* The character can drop down and hang alongside the steed, using it as a shield against attack. The character cannot make an attack or wear armor while performing this feat. The character's Armor Class is lowered by 6 while this maneuver is performed. Any attacks that would have struck the character's normal Armor Class are considered to have struck the mount instead. No proficiency check is required.\n* The character can leap from the back of his steed to the ground and make a melee attack against any character or creature within 10 feet. The player must roll a successful proficiency check with a -4 penalty to succeed. On a failed roll, the character fails to land on his feet, falls clumsily to the ground, and suffers 1d3 points of damage.\n\n## Player's Option: Skills & Powers\n\nRiding, Airborne and Riding, Land: The riding proficiencies are well-detailed in the ''Player's Handbook''. Characters using the Skills and Powers rules can add +2 to their proficiency score in either category of riding if they possess the trait of animal empathy, and +1 if they have the additional proficiency in animal training. These modifiers are cumulative.\n\n## The Complete Book of Dwarves\n\nBecause of their stout, stocky build, dwarves are uncomfortable riding horses or other animals of similar size. They are capable of riding donkeys, ponies, and smaller creatures. Dwarves may leap onto their saddles. Some suitable mounts for dwarves are dire wolves, giant boars, and giant lizards.\n\n## Note from The Complete Ranger's Handbook\n\nA ranger cannot use his species enemy as an airborne or land-based mount. If the mount is a follower, use the guidelines in Chapter 3 instead of the proficiency rules.\n\n## Note from The Complete Paladin's Handbook\n\nWhen riding his bonded mount, a paladin automatically has all of the benefits of the relevant Riding proficiency; he doesn't need the proficiency itself (see Chapter 2). But if he has the Riding proficiency, he gains a +2 bonus when making all associated checks with his mount. For instance, if he has a war horse bonded mount and the Land-based Riding proficiency, he earns a +2 bonus when attempting to vault into the saddle when the mount is moving. If he has a pegasus bonded mount and the Airborne Riding proficiency, he suffers a –2 penalty (instead of –4) when making checks to see if he falls from his saddle after suffering damage. The bonuses apply only when riding the bonded mount. When riding a creature of the same species as the bonded mount, use the normal Riding proficiency rules.\n\n## The Complete Barbarian's Handbook Modifications\n\nA barbarian may only ride land-based or airborne mounts native to his homeland. Because of his exceptional physical prowess, a barbarian can execute any of the special feats listed in the Player's Handbook descriptions without a saddle. For instance, he can leap onto an airborne mount's bare back and spur it into the air as a single action. He must still make all required proficiency checks."
    )
)
