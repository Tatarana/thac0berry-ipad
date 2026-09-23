import Foundation

/// Parte 9 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency0900: Proficiency = Proficiency(
    id: "explosive_energy",
    name: "Explosive Energy",
    wikiPageTitle: "Explosive Energy (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Psionicist",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist or Ascetic"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency lets a devotee summon from within an amazing burst of energy (Mana). If a proficiency check is failed, the character collapses for 1d3 rounds.",
        fullText: "This proficiency lets a devotee summon from within an amazing burst of energy (Mana). If a proficiency check is failed, the character collapses for 1d3 rounds. If successful, he adds 5 points to both his Strength and Dexterity for 1d6 rounds. During this time, he must expend the energy in combat or otherwise exhaust himself though physical exertion. No rest is allowed, nor are soft blows or defensive action. When the duration elapses, the character must make another check or fall unconscious for 2d6 rounds; otherwise he must cease all exertive activity for that period."
    )
)

let embeddedProficiency0901: Proficiency = Proficiency(
    id: "falconry",
    name: "Falconry",
    wikiPageTitle: "Falconry (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Inteligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This is most properly the Animal Training (Falcon) proficiency.",
        fullText: "## The Complete Ranger's Handbook\n\nThis is most properly the Animal Training (Falcon) proficiency. A character with this proficiency is an expert in training and handling falcons, enabling him to teach them tricks and tasks (This proficiency also allows the training of hawks at a -1 penalty. Owls are a separate proficiency and can be trained at -2).\n\nA character can teach a falcon 2d4 (2-8) tricks or tasks in any combination. It takes 2d6 weeks to teach the falcon a trick, three months for a task. At the end of a training period, the character makes a proficiency check. If the check succeeds, the falcon has learned the trick or task. If the check fails, the falcon is incapable of learning more.\n\nIf not using falconry training equipment (see Chapter 7), the success roll required for training is penalized by -2.\n\nCrossover Groups: General.\n\nNote: The foregoing is the standard proficiency. Optionally, the training rules for rangers given in Chapter 3 can be used. Training times and number of tricks/tasks may vary.\n\nSample general tasks:\n\nHunting: The falcon is trained to hunt its natural prey: small mammals and game birds; and to return with them to the falconer. Nearly all trained falcons receive this training first.\n\nFerocity: The falcon receives a +1 bonus to all attack and damage rolls, and a +2 morale bonus.\n\nGuard: The falcon shrieks at the approach of strangers. If approached closer than 20' or 30', the falcon will attack unless ordered not to. The bird can recognize designated friends.\n\nHoming: The falcon recognizes one place as its roost and returns there upon command.\n\nLoyalty: The falcon is exceptionally loyal to an individual selected by the trainer. It has a +4 saving throw bonus against charm, control, empathy, or friendship attempts by others. Further, it comes when the individual summons it, guards its master from attack and may perform unusual acts of loyalty as decided by the DM.\n\nSpecies Enemy: The falcon is trained to recognize an entire species as a natural enemy. Its basic reaction will be hostile, it will reject empathy, and have a +4 saving throw bonus against the enemy's charm or control attempts. It will attack the species enemy in preference to others.\n\nTrack: The falcon will track a designated creature and return. It can retrace its path to lead the falconer to the creature.\n\nSample specific tricks:\n\nAttack: The falcon will attack on command a creature designated by the falconer until called off. The falcon's base morale is at least 11. The falcon receives a save vs. rods against another ranger's animal empathy ability.\n\nCapture Prey: A hunt-trained falcon will return with the prey alive and unharmed.\n\nCatch Object: Upon command, the falcon will catch a small object thrown into the air or a small falling object and return to the falconer.\n\nDistract: The falcon is trained to feint at an opponent. The opponent must make a saving throw vs. paralysis or lose its next action.\n\nEye Attack: The falcon is trained to strike at an opponent's eyes. A beak hit has a 25% chance of striking an eye. An opponent struck in the eye is blinded for 1d4 rounds and has a 10% chance of permanently losing sight in the eye.\n\nHand Signals: The falcon can be commanded by hand signals as well as by voice.\n\nHide Object: The falcon takes an object from the falconer, flies away with it, and conceals it. The falcon will retrieve the object on command.\n\nPit Fighting: The falcon is trained as a fighting bird. It has a +2 attack bonus against any fighting bird that is not so trained.\n\nRecall: The falcon will immediately return to the falconer upon receiving the command.\n\nNemesis: The falcon is trained to attack a specific individual. The falcon never checks morale when attacking the individual."
    )
)

let embeddedProficiency0902: Proficiency = Proficiency(
    id: "fast_talking",
    name: "Fast-talking",
    wikiPageTitle: "Fast-talking (Proficiency)",
    redirectAliases: ["CSH Table 11", "CTH Table 3", "Fast-Talking (Proficiency)"],
    primaryGroup: "General",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue - Thief & Spacefarer Handbooks General - Humanoid Handbook"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "Special",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Required: Swindler.",
        fullText: "## The Complete Thief's Handbook\n\nRequired: Swindler.\n\nRecommended: Acrobat, Adventurer, Fence, Investigator, Smuggler, Troubleshooter.\n\nFast-talk is the art of distraction and conning. If a successful proficiency check is made, the fast-talker is able to get away with whatever scam he is attempting. Modifiers are based on the Intelligence and Wisdom of the target, as shown on Table 3. The DM may also introduce modifiers according to the difficulty or plausibility of what the character is attempting.\n\n{| class=\"article-table\"\n|+ Table 3: Fast-Talking Modifiers\n! rowspan=\"2\" | Target's\nIntel.\n! colspan=\"3\" | Target's\n|-\n! Modifier || Wisdom || Modifier\n|-\n| 3 or less || n/a || 3 || -5\n|-\n| 4-5 || -3 || 4-5 || -3\n|-\n| 6-8 || -1 || 6-8 || -1\n|-\n| 9-12 || 0 || 9-12 || 0\n|-\n| 13-15 || +1 || 13-15 || +1\n|-\n| 16-17 || +2 || 16-17 || +3\n|-\n| 18 || +3 || 18 || +5\n|-\n| 19 || +5 || 19+ || n/a\n|-\n| 20 || n/a || || \n|}\nModifiers are cumulative. Targets of Intelligence 3 or less are so dim that attempts to fast-talk them fail automatically because they can't follow what's being said. (Creatures that are so stupid are easy to fool in other ways, however.) Targets with Intelligence of 20 or more or Wisdom of 19 or more are impervious to fast-talking.\n\nExample: Julina the Silent, spy extraordinaire, is discovered by guards as she sneaks around the emperor's palace. She quickly decides to fast-talk them into believing that she is the mistress of the Steward of the palace and she just got lost in the labyrinthine halls. Unknown to Julina, the Steward is an elderly, faithfully and happily-married gentleman; and it is possible that the guards know of this reputation. The DM assumes the guards to have average Intelligence and Wisdom (no modifier), but he adds a -3 modifier because Julina's story contradicts the Steward's reputation. A 1d20 roll of 7 is less than 10 (Julina's Charisma of 13, with the -3 modifier), so she succeeds. The guards buy her story, and suggest that she go where she belongs immediately. If she failed they would call her bluff—and perhaps escort her straight to the door of the Steward and his wife!\n\n## The Complete Book of Humanoids\n\nFast-talk is the art of distraction and conning NPCs. If a successful proficiency check is made, the fast-talker weaves a successful scam. Modifiers are based upon the Intelligence and Wisdom of the NPC target, as shown below. DMs may also introduce modifiers according to the difficulty or plausibility of what the character is attempting, as well as the racial preferences of the target character.\n\n{| class=\"article-table\"\n|+ Fast-Talking Modifiers\n! Target's Intelligence || Mod. || Target's Wisdom || Mod.\n|-\n| 3 or less || NA || 3 || -5\n|-\n| 4-5 || -3 || 4-5 || -3\n|-\n| 6-8 || -1 || 6-8 || -1\n|-\n| 9-12 || 0 || 9-12 || 0\n|-\n| 13-15 || +1 || 13-15 || +1\n|-\n| 16-17 || +2 || 16-17 || +3\n|-\n| 18 || +3 || 18 || +5\n|-\n| 19 || +5 || 19+ || NA\n|-\n| 20+ || NA || || \n|}\nModifiers are cumulative. Targets of Intelligence 3 or less are so dim that attempts to fasttalk them fail automatically because they cannot follow what is being said. Targets with Intelligence of 20 or more or Wisdom of 19 or more are impervious to fast-talking.\n\n## The Complete Spacefarer's Handbook\n\nFast-talk is the art of distraction and conning. If a successful proficiency check is made, the fast-talker is able to get away with whatever scam he is attempting. Modifiers are based on the Intelligence and Wisdom of the target, as shown on Table 11. The DM may also introduce modifiers according to the plausibility of what the character is attempting.\n\n{| class=\"article-table\"\n|+ Table 11: Fast-Talking Modifiers\n! Target's\nAttribute || Modifier\n(Intelligence) || Modifier\n(Wisdom)\n|-\n| 3 || N/A || -5\n|-\n| 4-5 || -3 || -3\n|-\n| 6-8 || -1 || -1\n|-\n| 9-12 || 0 || 0\n|-\n| 13-15 || +1 || +1\n|-\n| 16-17 || +2 || +3\n|-\n| 18 || +3 || +5\n|-\n| 19 || +5 || N/A\n|}\n\nModifiers are cumulative. For example, a character with a Wisdom of 12 and an Intelligence of 15 would given a 0 +1 = +1 modifier on the fast-talking Charisma check roll.\n\nTargets of Intelligence 3 or less are so dim that attempts to fast-talk them fail automatically because they cannot follow what's being said. (Creatures that stupid are easy to fool in other ways, however.) Targets with Intelligence of 20 or more or Wisdom of 19 or more are impervious to fast-talking."
    )
)

let embeddedProficiency0903: Proficiency = Proficiency(
    id: "feign_detect_sleep",
    name: "Feign/Detect Sleep",
    wikiPageTitle: "Feign/Detect Sleep (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Feign/Detect Sleep: People who pretend to be sleeping seldom do it right. However, most people don't know how to tell the fakers from those really asleep.",
        fullText: "Feign/Detect Sleep: People who pretend to be sleeping seldom do it right. However, most people don't know how to tell the fakers from those really asleep. Characters with this proficiency are trained to feign sleep accurately and to determine when others are feigning sleep.\n\nThis skill is of special use to ninja on guard duty and those infiltrating a secure site. A ninja will use this skill when listening to seemingly sleeping guards and guests. If he detects one who is breathing wrong, he can take steps to capture or silence the faker. Likewise, a ninja can use this skill to convince an intruder that he is truly asleep, so that he can creep up on the intruder from behind when his back is turned.\n\nActing proficiency can convey the ability to feign sleep, but the Acting check is made at a –4 penalty instead of the standard –1."
    )
)

let embeddedProficiency0904: Proficiency = Proficiency(
    id: "feign_magic",
    name: "Feign Magic",
    wikiPageTitle: "Feign Magic (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Some characters find it useful to appear to cast magical spells. Perhaps they wish to draw attention to themselves and give a real spellcaster time to cast a spell.",
        fullText: "Some characters find it useful to appear to cast magical spells. Perhaps they wish to draw attention to themselves and give a real spellcaster time to cast a spell. They might wish to conceal the identity of a powerful magical item. They might also wish to conceal the presence of a priestly granted power, psionics, or other magic of an unusual nature. Feign Magic relies on a few handy magic-sounding phrases and movements that the caster learns well enough to utilize skillfully and confidently, as if casting a spell that requires somatic and verbal components. The caster mixes these gestures and words and pretends to cast a spell simultaneously while invoking another effect.\n\nNormally, no proficiency check is required, since watching a person wave his hands and seeing a magic effect appear afterward is not extraordinary in a fantasy world. Suspicious characters, however, have a chance to discover the chicanery, forcing the character to make a proficiency check. If the check fails, the fraud is revealed and the viewer realizes that no magic spell was cast. He must still use intuition, deductive reasoning, or other means to determine the actual source of the unnatural effects (if any were created by another means).\n\nThe die roll is modified by -1 if the watcher is not a spellcaster, +2 if the watcher has the Spellcraft proficiency, +1 if the subject speaks four or more languages (he might recognize some of the words the pretender uses), and -2 if the character using Feign Magic has the Spellcraft proficiency. Other modifiers that are left up to the DM to decide might be invoked if the character uses the proficiency frequently (that is, a Fighter character tries to use Feign Magic every round to divert missiles from the party clerics), the NPCs are alerted to the presence of a fake in the area, or the locals are completely unaware of psionics or variant magic systems and are easily convinced of magic use."
    )
)

let embeddedProficiency0905: Proficiency = Proficiency(
    id: "fey_lore",
    name: "Fey lore",
    wikiPageTitle: "Fey Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Int",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Greenfellows possess this special new proficiency, due to their upbringing in the fey world.",
        fullText: "## Dragon Magazine #237\n\nGreenfellows possess this special new proficiency, due to their upbringing in the fey world. Other characters may eventually learn fey lore, but they must either spend much time within that strange culture or gain it through weeks of reading about the faerie races.\n\nFey Lore: This is the knowledge of the fey folk and their ways. A character can use this proficiency to discern what sort of faerie would lurk in a specific area or terrain, whether or not an item was made by the fey folk, or simply to gather some clue in dealing with such creatures in a diplomatic manner."
    )
)

let embeddedProficiency0906: Proficiency = Proficiency(
    id: "field_of_study",
    name: "Field of Study",
    wikiPageTitle: "Field of Study (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
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
        briefSummary: "Field of study (1): Skill roll = Intelligence -2. This covers everything else in a sage’s field of expertise not already covered under existing proficiencies.",
        fullText: "## Dragon Magazine #163\n\nField of study (1): Skill roll = Intelligence -2. This covers everything else in a sage’s field of expertise not already covered under existing proficiencies. The more detailed a category, the more information the sage has and can turn up in research (and the more expensive the research should be). A hedge wizard with a proficiency in “elven art” who looks at a pair of old vases can tell one is an elven vase made about 1,500 years ago in Myth Drannor, and the other was probably made about 500 years ago in Everska. A hedge wizard with the field of study of “elven art during the rule of King Alfroi” can tell that the first vase was made by the master craftsman Iriam Talltree during his revisionist period, but he can’t tell anything about the second vase at all other than it appears of elven make. Typical major fields of study are: art, folklore, cryptography, languages (doubles the number of languages spoken by the hedge wizard—not all that important with tongues spells available), folklore, genealogy, geography, geology, mathematics, mathemagics, philosophy, and sociology. A failed skill roll means either no knowledge (just missed the number needed) or misinformation (if roll was off by more than four)."
    )
)

let embeddedProficiency0907: Proficiency = Proficiency(
    id: "fire_building",
    name: "Fire-building",
    wikiPageTitle: "Fire-building (Proficiency)",
    redirectAliases: ["Fire-Building (Proficiency)"],
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
            subAbility: "Wisdom/Intuition, Intelligence/Reason",
            characterPointCost: 2,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with fire-building proficiency does not normally need a tinderbox to start a fire. Given some dry wood and small pieces of tinder, he can start a fire in 2d20 minutes.",
        fullText: "## Player's Handbook\n\nA character with fire-building proficiency does not normally need a tinderbox to start a fire. Given some dry wood and small pieces of tinder, he can start a fire in 2d20 minutes. Flint and steel are not required. Wet wood, high winds, or other adverse conditions increase the time to 3d20, and a successful proficiency check must be rolled to start a fire.\n\n## Player's Option: Skills & Powers\n\nA character with this proficiency can build a fire in 1d20 minutes, as long as there is dry wood and some small bits of tinder. Add another d20 minutes for each of these factors: the wood (or tinder) is wet, it's raining or foggy, or the winds are strong. A proficiency check is required if conditions are bad and the character is forced to work without shelter."
    )
)

let embeddedProficiency0908: Proficiency = Proficiency(
    id: "fishing",
    name: "Fishing",
    wikiPageTitle: "Fishing (Proficiency)",
    redirectAliases: ["CBarbH Table 32"],
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
            subAbility: "Wisdom/Intuition, Intelligence/Knowledge",
            characterPointCost: 3,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character is skilled in the art of fishing, be it with hook and line, net, or spear. Each hour the character spends fishing, roll a proficiency check.",
        fullText: "## Player's Handbook\n\nThe character is skilled in the art of fishing, be it with hook and line, net, or spear. Each hour the character spends fishing, roll a proficiency check. If the roll is failed, no fish are caught that hour. Otherwise, a hook and line or a spear will land fish equal to the difference between the die roll and the character's Wisdom score. A net will catch three times this amount.\n\nOf course, no fish can be caught where no fish are found. On the other hand, some areas teem with fish, such as a river or pool during spawning season. The DM may modify the results according to the situation.\n\n## Player's Option: Skills & Powers\n\nA character with this proficiency knows how to catch fish with hook and line, net, and spear. If fish are present in a body of water, a successful proficiency check means the character has caught something. Typically, with a successful check, the fisherman he will catch 1d6 fish in an hour. This number can be doubled if many fish are present. It is reduced to one fish per hour if the character is seeking large quarry—such as sturgeon, muskellunge, giant carp, or salt-water fish.\n\n## The Complete Barbarian's Handbook Modifications\n\nInstead of fishing with hooks and nets, most barbarians use spears or their hands. When fishing, a barbarian makes a proficiency check every hour. If the check succeeds, the number of fish caught equals the difference between the die roll and the barbarian's Wisdom score. An adult can live on two typical game fish (such as trout, bass, or bullhead) per day.\n\nModify the number of fish caught by factoring in the quality of the fishing spot. Consult Table 32 and multiply the base number (the proficiency die roll minus the fisher's Wisdom) by the indicated modifier. These guidelines help determine the quality of the spot:\n\nPoor: Swamp, bog, shallow creek.\n\nAverage: Slow-running stream or river; moderately deep pond or lake; shore of body of water (as opposed to the center); sunny area in warm weather, shaded area in cool weather.\n\nGood: Rapid-running stream or river; deep pond or lake; center of a body of water (as opposed to the shore); shaded area in warm weather, open sunny area in cool weather.\n\n{| class=\"article-table\"\n|+ Table 32: Quality of Fishing Spots\n! Quality || Multiplier\n|-\n| Poor || 1/2 (round down)\n|-\n| Average || 1\n|-\n| Good || 2\n|}\n\nExample: Grog has the fishing proficiency and a Wisdom score of 13. He's fishing in a Poor quality spot. Grog's player rolls an 8. With this roll in an Average spot, Grog would ordinarily catch five fish (13–8). Multiply the base number by the Poor multiplier from Table 32 (1/2). Grog catches two fish (5 x 1/2, rounded down).\n\n## Note from The Complete Paladin's Handbook\n\nA paladin whose ethos demands reverence for life in all forms should refrain from fishing for recreation. However, he may still fish for food.\n\n## Campaign Option: Council of Wyrms Setting\n\nFishing means the character is skilled in the art of fishing. Dragons fish without hooks, lines, nets, or spears. They learn to use their claws and teeth to catch tasty morsels from the water. Proficiency checks are made on an hourly basis, with failure meaning no fish are caught. Local conditions may affect the required rolls and results, though generally success will provide enough fish for a meal.\n\nHatchlings can take this proficiency."
    )
)

let embeddedProficiency0909: Proficiency = Proficiency(
    id: "flintworking",
    name: "Flintworking",
    wikiPageTitle: "Flintworking (Proficiency)",
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
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The character is proficient at making small tools and weapons out of flint or other stone materials. A skilled worker can make a flint arrow-head or ax in about 15 minutes, using only the piece of flint that is to be the tool and another stone.",
        fullText: "## Dragon Magazine #265\n\nThe character is proficient at making small tools and weapons out of flint or other stone materials. A skilled worker can make a flint arrow-head or ax in about 15 minutes, using only the piece of flint that is to be the tool and another stone. Weapons made from flint function as other stone tools. That is, they have a l-in-6 chance of breaking whenever maximum damage is rolled, decided after inflicting the damage. They also inflict less damage than metal weapons (-1 or by description; see ''The Complete Fighter's Handbook or Player's Option: Combat & Tactics'')."
    )
)

let embeddedProficiency0910: Proficiency = Proficiency(
    id: "folklore",
    name: "Folklore",
    wikiPageTitle: "Folklore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters with this proficiency are well versed in the fables, myths, rumors, and legends of one geographic area (Sword Coast, Moonsea, Dalelands, Cormyr, etc.), unlike the local history proficiency, which only deals with facts.",
        fullText: "## Warriors & Priests of the Realms\n\nCharacters with this proficiency are well versed in the fables, myths, rumors, and legends of one geographic area (Sword Coast, Moonsea, Dalelands, Cormyr, etc.), unlike the local history proficiency, which only deals with facts. Folklore can be true, or not. Folklore can be used also to deduce very vague information about the inhabitants (both civilized and monstrous) of the chosen area in terms of history (what tales are told, what is remembered), religion (what the folklore explains or which god is responsible), and culture (how the tale is told, who are the foes in folk tales).\n\nIf the character also has local history for the same geographic area, both proficiencies gain a +1 modifier when attempting to gain information in that area."
    )
)

let embeddedProficiency0911: Proficiency = Proficiency(
    id: "foraging",
    name: "Foraging",
    wikiPageTitle: "Foraging (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior", "Rogue - Ranger General - Barbarian"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "By using this proficiency, a character can search a wilderness area to locate a small amount of a desired material, such as a branch suitable for carving into a bow, enough kindling to start a fire, a medicinal herb, or a component required for a spell.",
        fullText: "## The Complete Ranger's Handbook\n\nBy using this proficiency, a character can search a wilderness area to locate a small amount of a desired material, such as a branch suitable for carving into a bow, enough kindling to start a fire, a medicinal herb, or a component required for a spell. The character must spend 2-8 (2d4) hours searching, and the material must theoretically be available in the area being searched (for instance an icicle isn't available in the desert, nor dry kindling on the ocean floor). The DM doesn't confirm if the material sought is actually available until after the character has searched for the designated period. If the DM decides the material isn't in the area, no proficiency check is necessary; he merely reveals that the search was in vain.\n\nIf the DM decides the material is indeed available, a successful proficiency check means the character has found what he's been looking for. As a rule of thumb, the character locates no more than a handful of the desired material, though the DM may make exceptions (if searching for a few leaves of a particular herb, the character may instead find an entire field).\n\nIf the check fails, the material isn't found. The character may search a different area, requiring another 2–8 hours and a new proficiency check.\n\nCrossover Groups: Warrior, Rogue.\n\n## The Complete Barbarian's Handbook\n\nBy using this proficiency, a character can search a wilderness area in an attempt to locate a desired substance, such as a medicinal herb, a wren's egg, or wild rose.\n\nThe character must search for 2d4 hours in an area where the material is theoretically available (rose petals aren't available in the desert, wren's eggs aren't available in the arctic). The DM decides if the material is actually available; he doesn't reveal this information until the character completes his search. If the DM decides the material isn't in the area, he reveals that the character's search was in vain; no proficiency check is needed.\n\nIf the DM decides the material is available, a successful proficiency check means the character found what he was looking for. Generally, the character locates no more than a handful of the material, though the DM may make exceptions (if searching for rose petals, the character may stumble upon an acre of rose bushes). If the check fails, the material isn't found. The character may search a different area, requiring another 2d4 hours and a new proficiency check.\n\nCrossover Group: General.\n\n## Shaman\n\nBy using this proficiency, characters can search wilderness areas in an attempt to locate a desired substance, such as edible plants, a medicinal herb, or a wren's egg.\n\nThe character must search for 2d4 hours in an area where the material is theoretically available (wren's eggs aren't available in the arctic, for example).\n\nThe DM decides if the material is actually available; if he decides the material isn't available, he reveals that the character's search was in vain; no proficiency check is needed. If the DM decides the material is available, a successful proficiency check means the character found what he was looking for. Generally, the character locates no more than a handful of the material, though the DM may make exceptions. If the check is failed, the material isn't found. The character may search a different area, requiring another 2d4 hours and a new proficiency check.\n\nThis proficiency also helps shamans to survive in wilderness environments. When paired with the Survival, proficiency the character can locate an abundance of edible or potable substances. While every character with survival has an equal chance of locating food in the wilderness, the shaman who also has foraging can locate enough food and water to sustain two people on a successful foraging check in the terrain he is knowledgeable about. (This proficiency has been expanded from its form in ''The Complete Barbarian's Handbook''.)"
    )
)

let embeddedProficiency0912: Proficiency = Proficiency(
    id: "forgery",
    name: "Forgery",
    wikiPageTitle: "Forgery (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Dexterity/Aim, Wisdom/Willpower",
            characterPointCost: 3,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency enables the character to create duplicates of documents and handwriting and to detect such forgeries created by others.",
        fullText: "## Player's Handbook\n\nThis proficiency enables the character to create duplicates of documents and handwriting and to detect such forgeries created by others. To forge a document (military orders, local decrees, etc.) where the handwriting is not specific to a person, the character needs only to have seen a similar document before. To forge a name, an autograph of that person is needed, and a proficiency check with a -2 penalty must be successfully rolled. To forge a longer document written in the hand of some particular person, a large sample of his handwriting is needed, with a -3 penalty to the check.\n\nIt is important to note that the forger always thinks he has been successful; the DM rolls the character's proficiency check in secret and the forger does not learn of a failure until it is too late.\n\nIf the check succeeds, the work will pass examination by all except those intimately familiar with that handwriting or by those with the forgery proficiency who examine the document carefully. If the check is failed, the forgery is detectable to anyone familiar with the type of document or handwriting—if he examines the document closely. If the die roll is a 20, the forgery is immediately detectable to anyone who normally handles such documents without close examination. The forger will not realize this until too late.\n\nFurthermore, those with forgery proficiency may examine a document to learn if it is a forgery. On a successful proficiency roll, the authenticity of any document can be ascertained. If the die roll is failed but a 20 is not rolled, the answer is unknown. If a 20 is rolled, the character reaches the incorrect conclusion.\n\n## Player's Option: Skills & Powers\n\nThis proficiency indicates a skill at creating false documents, mimicking the handwriting of others, and detecting forgeries. No check is required if the character is simply trying to duplicate a style of writing—the issuing of an anonymous military decree, for example. Characters trying to duplicate the signatures of specific individuals must see those signatures; the DM rolls the proficiency checks secretly to see if the forgeries are successful. If a character writes a longer message in a specific hand, the DM rolls the check with a –2 modifier. The DM should also roll the check if a character seeks to determine if another document is a forgery. On a 20, the character makes the wrong assumption, whereas a failure with less than 20 means that the character is not sure of the truth or falsehood of the sample."
    )
)

let embeddedProficiency0913: Proficiency = Proficiency(
    id: "fortune_telling",
    name: "Fortune Telling",
    wikiPageTitle: "Fortune Telling (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["General (Rogue - Thief & Spacefarer Handbooks)"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Charisma",
        checkModifier: 2,
        rawModifier: "+2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Recommended: Swindler.",
        fullText: "## The Complete Thief's Handbook\n\nRecommended: Swindler.\n\nThis nonweapon proficiency covers knowledge of a variety of methods of divination-all of them fake. The thief with Fortune Telling is familiar with numerous devices and methods, such as tarot cards, palm reading, interpreting the flight of sparrows or the arrangement of a sacrificed animal's entrails, and so forth-or at least the thief is familiar enough with these practices to make it appear that he's an authentic soothsayer. (If fortune telling can make accurate predictions in the DM's campaign, this proficiency does not necessarily enable the thief to do so; it confers no magical powers.) The thief makes up the prediction he wishes to tell.\n\nA successful proficiency check indicates that the thief's customer or client believes the fortune he was told to be authentic. If the check fails, the sham is discovered in some way, or the prediction is simply not believed. If the DM wishes, the same modifiers described for fast-talking (above) may be used, based on the Intelligence and Wisdom of the subject and the believability of the fortune predicted.\n\nOptional Rule: If a natural 1 (or another number secretly chosen by the Dungeon Master before the die is rolled) comes up, the event that the thief predicted actually comes true!\n\n## The Complete Book of Humanoids\n\nMany humans and demihumans believe humanoids have mysterious powers and abilities. While many do have abilities which are strange and different, telling the future is not among them (except for the rare shaman or witch doctor). However, few members of other races know this, and that's where the fortune telling proficiency comes in.\n\nWith this proficiency, characters know a variety of methods for divining the future — and they are all fake. Humanoids with this skill employ odd-looking devices, sonorous oratory, or other methods to convince others that they are authentic soothsayers. Common methods include cards, palm reading, counting bumps, casting runes, examining animal entrails, and more. Humanoid fortune tellers put on a good show, then proclaim whatever prediction they want. This is done to gain money from the gullible, to impress other humanoids, or even to substitute for a true diviner when none are available. Humanoids are extremely superstitious, after all, and many tribes are happy to have the services of a fake when no true shaman is available. Without the fortune teller, many tribes might be paralyzed by their fear of the unknown.\n\nA successful proficiency check indicates that the target believes the fortune. If it fails, the sham is discovered or the fortune is simply not believed. Failure for a character trying to convince his tribe of his powers could prove deadly — for the fake! The fast-talking modifiers can be used if the DM desires. Note that PCs are never forced to believe a prediction regardless of the roll.\n\n{| class=\"article-table\"\n| Optional Rule: As an optional rule, the prediction made by the fortune teller actually comes true on a roll of a natural 1 (or some other number chosen secretly by the DM before the check is made).\n|}\n\n## The Complete Spacefarer's Handbook\n\nThis proficiency allows the character to use popularly known methods of predicting the future to per-form a divination. The character has no way to predict the real future using this proficiency, but he can put on a convincing show. He might even get lucky and actually be right!\n\nOn a successful proficiency check, the character is able to convince his customer that the divination is real. (Player characters must make an Intelligence check on 4d6 to recognize the fortune teller as a charlatan.) The character must make up the fortune; there is no magic associated with this proficiency.\n\nFor example, Emile the Aperusa is trying to scrape up a few coins to buy himself dinner. He sets up his palmist's booth on the outskirts of the market, and soon the wife of a wealthy merchant comes by. Emile offers to tell the woman's fortune and will not accept payment unless she believes his tale.\n\nEmile then takes the woman's hand, staring intently at her. He tells an elaborate tale of the woman's future, making several references to a dark-eyed stranger who will fill her nights with passion. He then makes a proficiency check. He succeeds, and the woman tosses him a small pouch containing silver— and the location of her villa."
    )
)

let embeddedProficiency0914: Proficiency = Proficiency(
    id: "fungi_recognition",
    name: "Fungi Recognition",
    wikiPageTitle: "Fungi Recognition (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 3,
        rawModifier: "+3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Although they prefer not to, dwarves sometimes have to survive on a diet of fungi.",
        fullText: "## The Complete Book of Dwarves\n\nAlthough they prefer not to, dwarves sometimes have to survive on a diet of fungi. They would rather use these as supplements to their regular diet, but when times are hard, or when involved in an extended underground expedition, it is useful to be able to tell edible fungi from the poisonous or unwholesome varieties. Approximately 50% of underground fungi are poisonous. They may cause an upset stomach or be so poisonous they cause death. It is impossible to harvest edible fungi without the fungi identification proficiency.\n\nIf the character has plenty of light and an opportunity to study the fungus in question closely for 10 minutes, no proficiency check is required. If he is unable to see the fungus properly, often the case when using infravision, or has to make a hasty decision about edibility, a proficiency check must be made."
    )
)
