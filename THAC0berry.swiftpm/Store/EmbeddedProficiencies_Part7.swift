import Foundation

/// Parte 7 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency0700: Proficiency = Proficiency(
    id: "deep_diving",
    name: "Deep Diving",
    wikiPageTitle: "Deep Diving (Proficiency)",
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
            subAbility: "Dexterity/Balance, Constitution/Health",
            characterPointCost: 2,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency can add 10 feet per round to his speed of descent when diving into the water, or from the surface.",
        fullText: "A character with this proficiency can add 10 feet per round to his speed of descent when diving into the water, or from the surface. Thus, a character with the deep diving proficiency can descend 30 feet per round, plus modifiers for encumbrance, running start, and height. Likewise, a character with the deep diving proficiency can surface at a rate of 30 feet (not 20 feet) per round.\n\nThis proficiency provides characters with the ability to hold their breath for 2/3 their Constitution scores in rounds, not the 1/3 allowed to most characters. Effects of exceeding the allotted time are the same, regardless of proficiency ratings."
    )
)

let embeddedProficiency0701: Proficiency = Proficiency(
    id: "delude_sensors",
    name: "Delude Sensors",
    wikiPageTitle: "Delude Sensors (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency is somewhat related to the Herbalism proficiency and allows the chaser to identify plants and fungi, as well as clays, sands, and specific minerals.",
        fullText: "## Dragon Magazine #258\n\nThis proficiency is somewhat related to the Herbalism proficiency and allows the chaser to identify plants and fungi, as well as clays, sands, and specific minerals. The proper ingredients, gathered from natural sources, allow the Sheenchaser to concoct a special salve that can fool the sensors and optical scanners used by machine lifforms.\n\nUsing this proficiency requires two checks. The first check is made after spending 1d4 hours foraging in an attempt to find the requisite ingredients. If successful, the proper ingredients are procured to create 1d4 + 2 doses of the salve. The collected ingredients and the prepared salve both go bad after one week + 1d4 days of storage. To be effective, one dose of the salve must be applied in a thin layer upon the clothing, arms, hair, and bare skin. Once applied, the salve remains effective for twenty-four hours.\n\nThe second check is required whenever anyone wearing the salve comes into contact with machine life. If the check is successful, the machine ignores the salved figure as if invisible. If the check fails, the machine identifies the salved figure but suffers a -2 penalty on all actions in conjunction with the protected figure, including attack rolls and saving throws.\n\nIf a successfully salved figure attacks a sheen that was previously ignoring it, the invisibility effect fades, although the machine suffers a -2 penalty on all actions associated with dealing with the salved figure as described above."
    )
)

let embeddedProficiency0702: Proficiency = Proficiency(
    id: "detect_fumes",
    name: "Detect Fumes",
    wikiPageTitle: "Detect Fumes (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -4,
        rawModifier: "-4/-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Detect Fumes permits a chance to detect subtle scents—a whiff of oil, the trace of rubber, and the acrid scent of electricity—that indicate the presence of machine life within 200 feet.",
        fullText: "## Dragon Magazine #258\n\nDetect Fumes permits a chance to detect subtle scents—a whiff of oil, the trace of rubber, and the acrid scent of electricity—that indicate the presence of machine life within 200 feet. In conjunction with the Detect Fumes proficiency, a Wizard with the Tracking proficiency ignores the non-Ranger penalty when following a machine. Attempts to track anything other than a machine incur the standard non-Ranger penalty.\n\nThis proficiency functions passively as well as actively. Whenever a Wizard moves within 200 feet of a sheen, the DM secretly rolls a check at the -4 modifier. If successful, the Sheenchaser becomes aware of nearby machine activity. Note that direction and distance are not disclosed. If the passive check is failed, the DM does not roll again for a minimum of one hour, or until some obvious clue of machine life activity is presented.\n\nA Wizard can also choose to sniff for machine life scents (no more than once per hour). The conscious check requires 3 rounds to accomplish but has only a -1 modifier to the ability check."
    )
)

let embeddedProficiency0703: Proficiency = Proficiency(
    id: "detect_signing",
    name: "Detect Signing",
    wikiPageTitle: "Detect Signing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Detect Signing: This proficiency allows a character to realize when ninja from other clans are communicating using their own clan signs.",
        fullText: "Detect Signing: This proficiency allows a character to realize when ninja from other clans are communicating using their own clan signs. The character who makes a Detect Signing roll recognizes seemingly meaningless symbols as writing and  ordinary speech as having special meaning, although she just will not know the content of the communication.\n\nAt the DM's discretion, a Detect Signing roll made by 2 or more will allow the character to recognize when other sorts of subtle communication are being used, such as thieves' cant.\n\nIf a character makes her Detect Signing roll by 6 or better, she can recognize one word or symbol in a specific communication and understand its meaning. The DM chooses which word the character recognizes. (This is an opportunity for the DM to pass an intriguing clue on to the ninja character.)"
    )
)

let embeddedProficiency0704: Proficiency = Proficiency(
    id: "diagnostics",
    name: "Diagnostics",
    wikiPageTitle: "Diagnostics (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Both the Healing and Diagnostics proficiencies aid victims of trauma and disease.",
        fullText: "## The Complete Paladin's Handbook\n\nBoth the Healing and Diagnostics proficiencies aid victims of trauma and disease. But while the Healing proficiency can be used to restore lost hit points, Diagnostics is mainly concerned with determining the cause of the damage and the prognosis; Diagnostics alone will not heal damage.\n\nWith a successful proficiency check, a character becomes aware all of the following information applicable to a particular patient:\n* If the patient has suffered physical damage, the character can determine the extent of the damage, though he may not be able to ascertain the exact cause (if a victim was attacked by a tiger, the character will know that the victim was clawed by a large animal, but not necessarily the species). The character can recommend treatments and offer prognoses, as with victims of diseases.\n* If the patient has been poisoned, the character knows the antidote (if one exists) and how to prepare it. Note that even if the character knows how to prepare an antidote, he may not have access to the necessary ingredients.\n* The character knows the name of the disease, its cause, how long the patient has had it, and the optimum treatment. If the patient is treated as specified, he suffers the mildest form of the disease and its shortest duration. If the patient declines treatment, or the treatment doesn't work, the character can determine the patient's prognosis with reasonable accuracy. (\"The patient will recover by the end of the month.\" \"The patient will become permanently blind if not treated within a year.\") The character may diagnose both natural and magical diseases.\n* When examining a corpse, the character can determine how the victim died and approximately how long it's been dead. If the victim died of unnatural causes, the character will only be able to determine the general circumstances of the death. For example, if an evil wizard incinerated the victim with a fireball, a successful diagnostics check might reveal that the victim burned to death very rapidly as a result of some type of magic, but not that it was affected by a fireball.\n\nA character with this proficiency may diagnose himself or any other character, or animals, except for supernatural creatures (such as a ghost or skeleton) and creatures from another plane of existence (like a xorn or aerial servant). He may attempt to diagnose an individual or creature only once.\n\nIf a character also has the Healing proficiency, he may modify all Diagnostic checks by +1.\n\nCrossover Groups: Priest."
    )
)

let embeddedProficiency0705: Proficiency = Proficiency(
    id: "digital_persuasion",
    name: "Digital Persuasion",
    wikiPageTitle: "Digital Persuasion (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1/2 Slot(s)",
        relevantAbility: "Intelligence",
        checkModifier: -4,
        rawModifier: "-4",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency gives the Wizard a crude ability to selectively short-circuit the intelligence chip of a machine life form.",
        fullText: "## Dragon Magazine #258\n\nThis proficiency gives the Wizard a crude ability to selectively short-circuit the intelligence chip of a machine life form. This proficiency can never be used on an unconscious sheen, is applicable only to a disabled machine (a machine brought to below 0 hit points).\n\nA Wizard with this proficiency must spend 1d4 + 2 turns attempting to affect a disabled sheen, at the end of which time the proficiency check is rolled. If successful, the sheen's base programming has become altered in some fashion (see below). The results of the program change take effect when the sheen's self-repair subroutines naturally bring it to positive hit points. If the check fails, the Wizard has permanently scrambled the sheen's AI chip—the self-repair mechanism is also disabled, permanently “killing” the sheen.\n\nSuccessful proficiency checks indicate some change in the base programming, as shown on the Digital Persuasion Results Table. Note that each additional rank of this skill only costs one slot, and with each additional rank, the chaser can modify the result on the table below by +1/-1. Thus results 5 and 6 can be obtained only by spending two or an additional 1 or 2 ranks in this skill. (Alternatively, someone with one slot of Machine Language can also modify the roll on the results table by +1/-1.)\n\n{| class=\"article-table\"\n|+ Digital Persuasion Results Table\n! 1d4 || Result\n|-\n| 1 || Sheen returns directly to cyst with false sampling data.\n|-\n| 2 || Sheen returns directly to cyst and never leaves again.\n|-\n| 3 || Sheen reacts toward reprogrammer as if charmed for 1d6+ 6 days but does not attack other sheens.\n|-\n| 4 || Sheen reacts toward reprogrammer as if charmed for 1d6+6 days and attacks other sheens on sight.\n|-\n| 5 || Sheen reacts toward repro- grammer as if permanently charmed, but it does not attack other sheens.\n|-\n| 6 || Sheen reacts toward reprogrammer as if permanently charmed and attacks other sheens if so instructed.\n|}"
    )
)

let embeddedProficiency0706: Proficiency = Proficiency(
    id: "diplomacy",
    name: "Diplomacy",
    wikiPageTitle: "Diplomacy (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Diplomacy: This is the grand art of high diplomacy between states or organizations. A character skilled in diplomacy knows the correct procedures and unwritten rules of negotiations between states or large organizations.",
        fullText: "Diplomacy: This is the grand art of high diplomacy between states or organizations. A character skilled in diplomacy knows the correct procedures and unwritten rules of negotiations between states or large organizations. He is capable of discerning the true intent of the various declarations, statements, and gifts or exchanges that make up a diplomatic encounter, and he is able to take his own wishes and couch them in proper diplomatic terms.\n\nNormally, the character need only make proficiency checks if the negotiations are particularly delicate or difficult. However, if there is a specific goal or compromise the character is working towards, he may attempt a check to see if he can win the other side over to his point. Naturally, the DM can apply a modifier of –8 to +8 depending on what the diplomat's offer means for the parties involved. Requesting the surrender of a vastly superior enemy is next to impossible, unless the character can convince them that they stand to gain something of great value by giving up. In any event, the DM shouldn't use this ability as a substitute for good role-playing by the players."
    )
)

let embeddedProficiency0707: Proficiency = Proficiency(
    id: "direction_sense",
    name: "Direction Sense",
    wikiPageTitle: "Direction Sense (Proficiency)",
    redirectAliases: ["Underground Direction Sense (Proficiency)"],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency has an innate sense of direction. By concentrating for 1d6 rounds, the character can try to determine the direction the party is headed.",
        fullText: "## Player's Handbook\n\nA character with this proficiency has an innate sense of direction. By concentrating for 1d6 rounds, the character can try to determine the direction the party is headed. If the check fails but is less than 20, the character errs by 90 degrees. If a 20 is rolled, the direction chosen is exactly opposite the true heading. (The DM rolls the check.)\n\nFurthermore, when traveling in the wilderness, a character with direction sense has the chance of becoming lost reduced by 5%.\n\n## The Complete Book of Dwarves\n\nDwarves receive a +2 bonus to their modifier when using their direction sense underground. They may use it above ground, but at a -2 penalty to Wisdom. Sundered dwarves should reverse these modifiers to reflect their fear of the underground.\n\n## Campaign Option: Council of Wyrms Setting\n\nThis proficiency gives a dragon that concentrates for 1 d6 rounds a chance to determine its direction of travel. Failure means the dragon is 90 degrees off the mark. A roll of 20 means the dragon is 180 degrees off. Success reduces the chance of getting lost during overland travel by 5%.\n\nFor dragons, this proficiency only works for land travel. For air or sea travel, dragons use the Navigation proficiency.\n\nHatchlings can take this proficiency."
    )
)

let embeddedProficiency0708: Proficiency = Proficiency(
    id: "dirty_tricks",
    name: "Dirty Tricks",
    wikiPageTitle: "Dirty Tricks (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Gladiator (Warrior)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Dirty Tricks: The Dirty Tricks proficiency allows any fighter character (not just a gladiator) to learn how to fight dirty against an opponent.",
        fullText: "## The Complete Gladiator's Handbook\n\nDirty Tricks: The Dirty Tricks proficiency allows any fighter character (not just a gladiator) to learn how to fight dirty against an opponent. Although the exact methods may vary from character to character, the proficiency allows the PC to distract an opponent just long enough to get away with something otherwise not possible.\n\nThe method of trickery must necessarily vary depending on terrain, the opponent, and numerous other factors. Even weather can have a serious effect on the tricks a gladiator can play. The Dirty Tricks proficiency gives a +1 bonus to one of several actions the PC can take in the combat round, provided the PC makes a successful proficiency check. A foe may make a Wisdom check at—2 to detect the trick. A successful Wisdom check negates the Dirty Trick for that round.\n\nThe Dirty Tricks bonus may be applied to the user's attack, initiative, or damage results. The Dirty Trickster may also choose to apply the bonus as a penalty (—1) to an opponent's attack, initiative, or damage. The desired bonus must be announced before the proficiency is checked. A failed check indicates that the enemy is alert to such tricks, and will not fall prey to them later in the combat.\n\nDirty Tricks generally work only once or twice against any given opponent, no matter what forms are used. They remember those who engage in such tricks against them, usually with negative overtones. Only those with Average or lower Intelligence will succumb to a Dirty Trick played twice unless it is exceptionally clever. Players are encouraged to think of the tricks themselves, rather than simply rolling the dice.\n\nEach Dirty Trick played by the PC against the same enemy gives the enemy a +2 on his Wisdom check, making the check for a second Trick at a 0 modifier, the third at a +2, and so on. Unless it can be reasonably expected that the foe would not remember the PC (DM's discretion), this bonus should always be kept in mind. A bonus also applies if the PC has a reputation for Dirty Tricks, when facing someone who would know of this reputation.\n\nSample Dirty Tricks include throwing sand in a foe's eyes, playing dead to lure an enemy into striking distance, clouting him in sensitive areas, forcing him to spring arena-laid traps, and so forth."
    )
)

let embeddedProficiency0709: Proficiency = Proficiency(
    id: "disguise",
    name: "Disguise",
    wikiPageTitle: "Disguise (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition, Charisma/Leadership",
            characterPointCost: 4,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character with this skill is trained in the art of disguise. He can make himself look like any general type of person of about the same height, age, weight, and race.",
        fullText: "## Player's Handbook\n\nThe character with this skill is trained in the art of disguise. He can make himself look like any general type of person of about the same height, age, weight, and race. A successful proficiency check indicates that the disguise is successful, while a failed roll means the attempt was too obvious in some way.\n\nThe character can also disguise himself as a member of another race or sex. In this case, a -7 penalty is applied to the proficiency check. The character may also attempt to disguise himself as a specific person, with a -10 penalty to the proficiency check. These modifiers are cumulative, thus, it is extremely difficult for a character to disguise himself as a specific person of another race or sex (a -17 penalty to the check).\n\n## Player's Option: Skills & Powers\n\nDisguise: Characters trained in this proficiency can conceal their appearance through makeup and costuming. If they seek simply to alter their appearance without concealing size, sex, or race—for example, to go out in a city without anyone discovering what they look like—they can succeed without a proficiency check.\n\nIf the task is more difficult—the character in disguise meets and talks with an acquaintance, for example—a successful proficiency check is required. Characters who try to alter the appearance of their sex, race, or size, must make successful proficiency checks with a –2 penalty for each category.\n\nCharacters who attempt to disguise themselves as specific persons must make proficiency checks when they encounter and speak with someone who knows the other individuals. All of these checks suffer an inherent –2 penalty.\n\nNote that the talent of impersonation (see traits) can improve a character's success with the disguise proficiency."
    )
)

let embeddedProficiency0710: Proficiency = Proficiency(
    id: "display_weapon_prowess",
    name: "Display Weapon Prowess",
    wikiPageTitle: "Display Weapon Prowess (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters who have this proficiency can put on an impressive display of weapon prowess without fighting at all—swords whooshing in a blur, daggers flashing, arrows splitting melons in two.",
        fullText: "Characters who have this proficiency can put on an impressive display of weapon prowess without fighting at all—swords whooshing in a blur, daggers flashing, arrows splitting melons in two. An individual must use a weapon with which he or she is already proficient, but weapon specialization has no further effect. The \"show\" takes at least a round. Those who are impressed are forced to make a morale check. (Results are outlined below.)\n\nNot everyone is swayed by weapon prowess. Characters must pay attention before this proficiency has an impact. For example, this skill might be useful in staring down a guard at the city gate, but would do nothing against a screaming mob or a charging band of desert raiders.\n\nFurther, characters who have this proficiency must be of equal or higher level (or Hit Dice) than their audience to impress them. For instance, low-level warriors with flashing blades might awe the equally low-level city guards. But bullying their way through the sultan's elite vanguard would be another matter entirely. Creatures of higher level or Hit Dice than an individual using display weapon prowess are not impressed; they do not make morale checks.\n\nMorale Check Results: Characters who make successful morale checks can see that an individual with this proficiency handles a weapon well; otherwise they're unaffected. Characters who fail their morale checks react in a manner suited to the circumstances at hand.\n\nIf the situation isn't desperate, and violence isn't inevitable, characters who fail their checks are likely to try talking to the individual with weapon prowess; else they'll simply back away. They won't surrender outright, but they'll realize that the individual is not the sort to trifle with.\n\nIn some instances, walking away and talking things over are not viable options. For example, if guards at the sultan's treasury fail their checks, they'll stay at their posts and remain willing to fight. If forced into combat, however, they'll suffer a -1 attack penalty.\n\nPlayer characters are not affected by morale checks. If an individual with this proficiency attempts to awe a PC, the DM should provide a frank evaluation of the display, based on level and success. For example, the DM might say, \"She looks darned good with that sword. Your PC might be able to beat her in a fair fight,\" or \"This son of a dark camel looks like he picked up his swordsmanship watching jesters in the marketplace.\" Then it's up to the player to decide how the PC reacts."
    )
)

let embeddedProficiency0711: Proficiency = Proficiency(
    id: "distance_sense",
    name: "Distance Sense",
    wikiPageTitle: "Distance Sense (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
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
        briefSummary: "This proficiency enables a character to estimate the total distance he's traveled in any given day, part of a day, or a number of consecutive days equal to his level.",
        fullText: "## The Complete Ranger's Handbook\n\nThis proficiency enables a character to estimate the total distance he's traveled in any given day, part of a day, or a number of consecutive days equal to his level. For instance, a 7th level character can estimate the distance he's traveled in the previous week. The estimate will be 90% accurate.\n\nCrossover Groups: General."
    )
)

let embeddedProficiency0712: Proficiency = Proficiency(
    id: "dowsing",
    name: "Dowsing",
    wikiPageTitle: "Dowsing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Dowsing: This is the skill of finding lost or hidden items by seeking a disturbance in the subtle natural energies that permeate the earth.",
        fullText: "Dowsing: This is the skill of finding lost or hidden items by seeking a disturbance in the subtle natural energies that permeate the earth. A dowser is attuned to the invisible, intangible eddies and currents of the world around him; by careful and methodical searching, he can detect particular emanations or anomalies.\n\nDowsing has two general uses. First, the character can attempt to detect natural deposits or minerals in the ground, such as water, gold, or other ores. Secondly, the character can attempt to find a specific man-made item that has been lost or hidden, such as a friend's dagger, a buried treasure chest, or the entrance to a barrow mound. The search must be very precise—the dowser will have no luck if he sets out to find 'the most valuable thing in this field' or 'the nearest magical weapon,' but 'Aunt Claire's missing brooch' or 'the gold buried by the pirate Raserid' are suitable searches.\n\nUnlike the spell locate object, the dowser isn't led or directed to the item he seeks; he has to actually pass within 10 feet of the item, or walk over the place where it is buried, and succeed in a proficiency check to detect the item. (The DM should keep this check hidden from the players so that he doesn't give away the location with a failed check.) Dowsing can take a long time; quartering the dirt floor of a cellar 20 square feet might take 1d3 turns, while checking a field or courtyard might take 1d3 hours. Searching an area larger than 100 square yards is impractical—the dowser gets tired of concentrating.\n\nA dowser can detect items or substances within 100 feet of the surface, although very strong or powerful sources may be detected slightly deeper. The dowser can guess the approximate depth of what he's seeking within ±10% when he stumbles across it."
    )
)

let embeddedProficiency0713: Proficiency = Proficiency(
    id: "dowsing_dowsing_dragon",
    name: "Dowsing",
    wikiPageTitle: "Dowsing - Dragon (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The character has been trained in the use of a divining rod. While all rhabdomancers begin with the spell to craft an effective rod, this proficiency covers the insight necessary to interpret the finer meanings of the woods tugging and twitching.",
        fullText: "The character has been trained in the use of a divining rod. While all rhabdomancers begin with the spell to craft an effective rod, this proficiency covers the insight necessary to interpret the finer meanings of the woods tugging and twitching. Apprentice rhabdomancers are taught in the guild the following tenant:\n\nThe fork is held by the two limbs, one in each hand, with the point going first and the rod held horizontally. Then the rhabdomancer walks gently over the places where he seeks an object or affection. He should walk with care to not risk dispersing the emanations that rise from the spot where these things are and cause the rod to slant. For example, if the magician is seeking a deposit of gold ore, upon finding a vein a successful dowsing check reveals the purity of the metal. The proficiency also affects the casting of various divination spells. Some of these are blocked by stonework, thick wood, or metal deposits. A skilled rhabdomancer is able to pierce these “walls” with a successful dowsing check (note the below listing of common Divination spells for those cases in which a dowsing check is required). Otherwise, a DM may call for the rhabdomancer to make a proficiency roll to see if any obscure or additional information is discovered.\n\nAlso, using this proficiency, a rhabdomancer can locate the proper sapling with which to craft a suitable divining rod. Rare wood types that could be used in making a rod could quite possibly require a successful Dowsing check. At the DM’s discretion, a rhabdomancer may forgo learning a new nonweapon proficiency in order to become better skilled at Dowsing. Each abandoned slot adds 1 to the character’s proficiency roll. This allows an edge for high-level rhabdomancers who remain true to their craft."
    )
)

let embeddedProficiency0714: Proficiency = Proficiency(
    id: "dragon_lore",
    name: "Dragon Lore",
    wikiPageTitle: "Dragon Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -4,
        rawModifier: "-4",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Dragon lore is the body of knowledge required to make hunting dragons alone more than just a suicidal endeavor.",
        fullText: "## Dragon Magazine\n\nDragon lore is the body of knowledge required to make hunting dragons alone more than just a suicidal endeavor. With a successful proficiency check, dragon lore allows a PC to evaluate a dragon's tracks, spoor, and shed scales to learn the dragon's age category (plus or minus one category). It also automatically teaches a dragon hunter the basic dragon types, how to distinguish similar-looking subtypes, and the ways to avoid the most common lair traps."
    )
)
