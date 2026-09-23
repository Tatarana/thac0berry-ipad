import Foundation

/// Parte 4 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency0400: Proficiency = Proficiency(
    id: "body_language",
    name: "Body Language",
    wikiPageTitle: "Body Language (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Psionicist",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with the body language proficiency is able to interpret subtle changes in the behavior of another creature that give away its moods and attitudes.",
        fullText: "## Dragon Magazine #200\n\nA character with the body language proficiency is able to interpret subtle changes in the behavior of another creature that give away its moods and attitudes. Sitting posture, vocal tone, gesticulations, facial movements, and expressions all contribute to this. This skill is effective only on beings of the same race as the user or a closely related race—e.g., a human could not read a dragon's body language. Only intelligent (Int 5+) beings can “read” like this, and the reader must be able to see the subject's body.\n\nOn a successful secret check, the reader can judge the general mood of the subject—happy, scared, depressed, etc. A failed check reveals another mood (DM's choice). If he concentrates, the reader can also tell whether the subject is lying or not. This requires a check at an additional -4 penalty, and the player must actually announce he is doing this; it is not automatic."
    )
)

let embeddedProficiency0401: Proficiency = Proficiency(
    id: "body_manipulation",
    name: "Body Manipulation",
    wikiPageTitle: "Body Manipulation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Dexterity",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency is restricted to xixchil, as they are the only race with sufficiently precise Dexterity to even attempt this difficult skill, or the glands needed to secrete the required chemicals.",
        fullText: "This proficiency is restricted to xixchil, as they are the only race with sufficiently precise Dexterity to even attempt this difficult skill, or the glands needed to secrete the required chemicals.\n\nThis proficiency allows the character to perform bodily modifications on others. Using this proficiency, the character may modify a patient's body through a combination of surgery and chemical changes. The following features may be added to a human or humanoid body:\n\nEnhanced strength The patient gains three points of Strength. (Each point of Strength above 18 adds 10% to exceptional strength.)\n\nEnhanced constitution The patient gains three points of Constitution.\n\nEnhanced dexterity The patient gains three points of Dexterity.\n\nFlight The patient gains large wings which enable him to fly at 24\" with maneuverability class C.\n\nBody armor The patient gains a tough outer shell which acts as AC 2.\n\nEmbedded weapons The patient gains an extra limb which is shaped like a weapon (patient's choice) and has all of the combat features of that non-magical weapon.\n\nInfravision The patient's eyes are modified so that he can see in the dark as an elf.\n\nOnly one modification can be performed on any patient, and all modifications are permanent. Moreover, the patient loses five points of Charisma for undergoing the modification; this loss is also permanent. (Xixchil are notorious for favoring function over appearance.).\n\nPerforming such an extensive modification takes a minimum of two weeks, plus one week per point of the patient's original Constitution score under 12. The patient must also make a system shock roll to survive the treatment.\n\nThe patient must also make a saving throw vs. death magic to avoid a horrible loss. Should this saving throw fail, the DM may choose from one of the following negative effects (or make up a new effect):\n* Loss of limb: patient loses one arm.\n* Susceptibility to poisons: Patient suffers a -2 penalty on all saving throws vs. poison.\n* Weak bone structure: Patient suffers double damage from all bludgeoning weapons.\n* Poor clotting: Patient suffers double damage from all cutting weapons.\n\nSpecial note: This proficiency can change the very tenor of the game, by converting the characters from relatively normal adventurers to freaks. The DM should carefully consider before allowing a player character to have access to this proficiency."
    )
)

let embeddedProficiency0402: Proficiency = Proficiency(
    id: "bookbinding",
    name: "Bookbinding",
    wikiPageTitle: "Bookbinding (Proficiency)",
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
        briefSummary: "Bookbinding: A wizard with this skill is familiar with the process of assembling a book.",
        fullText: "Bookbinding: A wizard with this skill is familiar with the process of assembling a book. Bookbinding is a demanding task; the pages must be glued or sewn to a common backing of some kind, protected by various kinds of varnishes or treatments, and then fastened to a strong and durable cover. Additional chemicals or compounds to ward off mildew and deter moths and bookworms are a necessary precaution.\n\nBookbinding is especially helpful for a wizard assembling a spell book. Normally, a wizard must pay a bookbinder 50 gp per page for a standard spell book, or 100 gp per page for a traveling spell book—see Chapter 7 of the (DMG). A wizard who does this work himself reduces these costs by 50%, although the process takes at least two weeks, plus one day per five pages. If the character passes a proficiency check, his spell book gains a +2 bonus to item saving throws due to the quality and craftsmanship of the work. In addition, the wizard must succeed in a proficiency check if he is dealing with unusual or unsuitable materials, such as metal sheets for pages or dragon scales for a cover."
    )
)

let embeddedProficiency0403: Proficiency = Proficiency(
    id: "bowyer_fletcher",
    name: "Bowyer/Fletcher",
    wikiPageTitle: "Bowyer/Fletcher (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge, Dexterity/Aim",
            characterPointCost: 5,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "This character can make bows and arrows of the types given in Table 44.",
        fullText: "## Player's Handbook\n\nThis character can make bows and arrows of the types given in Table 44.\n\nA weaponsmith is required to fashion arrowheads, but the bowyer/fletcher can perform all other necessary functions. The construction time for a long or short bow is one week, while composite bows require two weeks, and 1d6 arrows can be made in one day.\n\nWhen the construction time for the weapon is completed, the player makes a proficiency check. If the check is successful, the weapon is of fine quality and will last for many years of normal use without breaking. If the check fails, the weapon is still usable, but has a limited life span: An arrow breaks on the first shot; a bow breaks if the character using it rolls an unmodified 1 on his 1d20 attack roll.\n\nOption: If a character wishes to create a weapon of truly fine quality and the DM allows it, the player can opt to use the following alternative procedure for determining the success of his attempt. When the proficiency check is made, any failure means that the weapon is useless. However, a successful check means that the weapon enables the character to add Strength bonuses to attack and damage rolls. Additionally, if the proficiency check is a natural 1, the range of the bow is increased 10 yards for all range classes or is of such fine work that it is suitable for enchantment.\n\n{| class=\"article-table\"\n|+ (Partial) Table 44: Equipment \n! Item\n! Cost\n! (lb.)\n! Size\n! Type6\n! Factor\n! S-M\n! L\n|-\n| Bow\n| —\n| —\n| —\n| —\n| —\n| —\n| —\n|-\n| Composite long bow\n| 100 gp\n| 3\n| L\n| —\n| 7\n| —\n| —\n|-\n| Composite short bow\n| 75 gp\n| 2\n| M\n| —\n| 6\n| —\n| —\n|-\n| Flight arrow\n| 3sp/12\n| *\n| S\n| P\n| —\n| 1d6\n| 1d6\n|-\n| Long bow\n| 75 gp\n| 3\n| L\n| —\n| 8\n| —\n| —\n|-\n| Sheaf arrow\n| 3 sp/6\n| *\n| S\n| P\n| —\n| 1d8\n| 1d8\n|-\n| Short bow\n| 30 gp\n| 2\n| M\n| —\n| 7\n| —\n| —\n|}\n\n## Player's Option: Skills & Powers\n\nThis character can make bows and arrows (but not arrowheads) of the types available in the campaign world. Given appropriate materials, the character can successfully make a bow or 2–12 arrows in a day. (Note that finding the right branch for the bow, or the proper shafts and feathers for the arrows might take several days of searching!)\n\nWeaponsmiths are required to make good steel arrowheads. If none are available, the character can fire harden the wooden tips of his arrows, but these weapons suffer a –1 penalty on all damage rolls, and any arrow that misses its target is 50% likely to be broken."
    )
)

let embeddedProficiency0404: Proficiency = Proficiency(
    id: "bowyer_fletcher_crude",
    name: "Bowyer/Fletcher, Crude",
    wikiPageTitle: "Bowyer/Fletcher, Crude (Proficiency)",
    redirectAliases: ["CBarbH Table 34"],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "With this proficiency, a character can make short bows and arrows. To make short bows, the character must be proficient in the use of short bows.",
        fullText: "With this proficiency, a character can make short bows and arrows. To make short bows, the character must be proficient in the use of short bows. To make arrows, he must be proficient in some type of bow.\n\nIf the character has the hunting proficiency, he receives a +3 bonus to all crude bowyer/fletcher proficiency checks.\n\nBecause crude bows and arrows use natural materials—such as bone, wood, and stone—and fine craftsmanship isn't required, construction time is reduced (see Table 34). Arrowheads must be made by weaponsmiths, but the bowyer/fletcher fashions the bows, shafts, and drawstrings.\n\n{| class=\"article-table\"\n|+ Table 34 Construction lime for Crude Bows and Arrows\n! Weapon !! Construction Time\n|-\n| Arrow, flight || 7/day\n|-\n| Arrow, incendiary or poison || 5/day\n|-\n| Bow, short || 12 days\n|}\nAs with the standard bowyer/fletcher proficiency, weapons made with the crude bowyer/fletcher proficiency must be checked for quality. A failed proficiency check, made when the weapon is completed, means the arrow shatters on the first shot; a bow breaks if the character using it rolls an unmodified 1 on his 1d20 attack roll.\n\nThis proficiency does not allow the option of creating fine quality weapons, including the long bow.\n\nCrossover Group: Warrior."
    )
)

let embeddedProficiency0405: Proficiency = Proficiency(
    id: "brain_nausea",
    name: "Brain Nausea",
    wikiPageTitle: "Brain Nausea (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Caradhaker Only"],
        slotsRequired: 4,
        rawSlots: "4 slots",
        relevantAbility: "Wisdom",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "In non-psionic campaigns, the mental disciplines of the mindstalkers take the form of “evolved proficiencies.” Of course, these proficiencies are much more expensive than usual and thus not easily acquired.",
        fullText: "## Dragon Magazine #230\n\nIn non-psionic campaigns, the mental disciplines of the mindstalkers take the form of “evolved proficiencies.” Of course, these proficiencies are much more expensive than usual and thus not easily acquired. Furthermore, if a mindstalker in a non-psionic campaign takes even one of these evolved proficiencies, he or she immediately accrues the Constitution penalty described above under special hindrances in the mindstalker kit.\n\nBrain nausea allows a caradhaker consciously to change his pheromone biochemistry through mental discipline and biofeedback techniques. When the proficiency is triggered, the caradhaker releases a natural combination of pheromones. This subtle chemical change causes all creatures that come into physical contact with the dwarf subconsciously to prefer not to eat a brain, for the creature's taste preferences have been altered. For most creatures, this is on par with their natural inclinations anyway, but this anti-brain preference goes against an illithid's nature. Since this effect is a subconscious alteration of appetite on a biochemical level, affected creatures are not likely to realize what has happened to them. Of course, illithids can be affected by this proficiency only if they make physical contact with the dwarf, due to their inability to detect odor (see The Illithiad).\n\nAn illithid affected by brain nausea is 95% likely to refrain from extracting and eating the brain of a victim after a successful mind blast or while in the midst of melee. Of course, the illithid might decide to capture the victim to place him or her into a slave gang, use other powers on the victim, or merely leave after a brief encounter with caradhaker foes, feeling inexplicably “full.” No other motivations of the illithid are affected, and the illithid itself does not realize that it is taking any course of action other than what it would have “naturally” decided."
    )
)

let embeddedProficiency0406: Proficiency = Proficiency(
    id: "brewing",
    name: "Brewing",
    wikiPageTitle: "Brewing (Proficiency)",
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
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character is trained in the art of brewing beers and other strong drink. The character can prepare brewing formulas, select quality ingredients, set up and manage a brewery, control fermentation, and age the finished product.",
        fullText: "## Player's Handbook\n\nThe character is trained in the art of brewing beers and other strong drink. The character can prepare brewing formulas, select quality ingredients, set up and manage a brewery, control fermentation, and age the finished product.\n\n## Player's Option: Skills & Powers\n\nThis category includes the brewing of malt beverages, the making of wine, and the distilling of stronger drink. A character can perform all the basic functions of the brewer's art without requiring a proficiency check. If the brewer chooses to make the check, failure means that a batch has been wasted, but success means that a particularly fine vintage has been created.\n\n## Note from The Complete Paladin's Handbook\n\nA paladin whose ethos forbids partaking of strong drink isn't likely to have this proficiency. A paladin with a more liberal ethos may use this proficiency to prepare drinks for others, even if he declines to partake himself."
    )
)

let embeddedProficiency0407: Proficiency = Proficiency(
    id: "bribery",
    name: "Bribery",
    wikiPageTitle: "Bribery (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This skill is open to all rogue characters. If the DM agrees, it may be available to other classes on a case-by-case basis.",
        fullText: "This skill is open to all rogue characters. If the DM agrees, it may be available to other classes on a case-by-case basis. Attempts at bribery are not restricted to those familiar with its intricacies, anyone may attempt to bribe someone else. Those with this skill will be able to determine a \"fair\" price and avoid a potential double-cross. Whenever a character without bribery skill attempts to use this skill, they must make a Charisma check at 4. Failure indicates that the bribe is refused and that the character may be turned over to the watch for his actions. Those with this skill will obviously suffer no such penalty. It's important that the DM not allow the use of bribery skill to replace the role-playing aspects of such transactions. Players who role-play such attempts well should be given a positive modifier to their bribery check while those who do not should suffer for it."
    )
)

let embeddedProficiency0408: Proficiency = Proficiency(
    id: "bureaucracy",
    name: "Bureaucracy",
    wikiPageTitle: "Bureaucracy (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Al-Qadim", "Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest - PO:SM", "Dark Sun Priest", "Rogue - Paladin Priest", "Rogue - Arabian Adventures"],
        slotsRequired: 2,
        rawSlots: "2 Slots 1 slot - Dark Sun",
        relevantAbility: "Intelligence Wisdom - Arabian Adventures Charisma - Dark Sun",
        checkModifier: 0,
        rawModifier: "+0 -2 - Dark Sun",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Bureaucracy: This proficiency encompasses a working knowledge of temple or government organization and protocol, and the skills necessary to navigate through bureaucracies.",
        fullText: "## Player's Option: Spells & Magic\n\nBureaucracy: This proficiency encompasses a working knowledge of temple or government organization and protocol, and the skills necessary to navigate through bureaucracies. The character knows which officials to approach and when to approach them, where records are kept and how to gain access to them, and how to circumvent unfriendly or sluggish bureaucrats. Unless there are extenuating circumstances, the character can get permits or documents completed in half the normal time.\n\nIn addition to these skills, the character can attempt to turn the system against someone else. With a successful proficiency check, the amount of time required to make a decision doubles—permits are misplaced or filled out incorrectly, or important documents are held up on the wrong desk. For example, a character could keep a shady wizard from gaining permission to build a tower in the town, or he might obstruct a thief's request for bond or parole.\n\n## The Complete Paladin's Handbook\n\nThis proficiency encompasses a working knowledge of governmental protocol and the skills necessary to navigate bureaucratic organizations. A character with this proficiency knows which official to approach and the best time to approach him (a tax collector's aide may have better access to information than the tax collector himself; a city clerk may be less harried and more helpful at the beginning of the month than at the end). He knows where government records are kept and the procedures for examining them. He knows how to circumvent sluggish or uncooperative bureaucrats. He obtains permits and other government documentation in half the normal time. No proficiency checks are needed for any of these functions.\n\nA character can also use Bureaucracy to turn the system against someone else. A successful proficiency check doubles the amount of time to make a government decision, causes a permit to be issued under the wrong name, or temporary misplaces an important document. A paladin must be careful with this ability, to avoid breaking the law and violating his ethos.\n\nThe Bureaucracy proficiency covers the governmental organizations in a particular region, usually the character's homeland. He may spend additional slots to expand the proficiency to other regions. Official organizations include government councils, regulatory boards, and church hierarchies. The proficiency is only effective when dealing with organizations of 10 or more members.\n\nCrossover Groups: Priest, Rogue.\n\n## Arabian Adventures\n\nCharacters who boast this proficiency are skilled at dealing with large organizations such as local governments, court systems, and church hierarchies. Bureaucrats at heart, they can obtain favors, justice, and information when others would fail. The proficiency gives them knowledge of the system, patience with its component parts, and mental quickness in realizing whom to talk to and when.\n\nThe bureaucracy proficiency is only effective when a character is dealing with organizations of 10 or more people. The governing of a good-sized city, the adjudicating of a docket of cases before a pasha, the decisions of the official church—all require a large number of individuals, and the bureaucracy proficiency makes a difference. However, a group of village elders in a small town and the lord of an oasis have no need of complex organizations; nor are they impressed by a character who has skill in handling them.\n\nPaperwork and red tape are no problem for characters with this proficiency. They know the proper protocol in dealing with clerks. They can prepare (or make sure others prepare) the required documentation, and they can vouch that all such matters are performed correctly. The normal issuing time for any documentation or permit is halved, and cases for reviews are guaranteed quick attention. No proficiency check is required.\n\nThis proficiency also may be used to turn organized groups against a certain individual, or to make sure that important documents are lost, information is given to the wrong person, or casework is brought up too soon (or forgotten entirely while a prisoner languishes in a dungeon). This kind of bureaucratic maneuver requires a successful proficiency check. If a natural 20 is rolled, the character attempting to pervert the wheels of truth and justice suddenly falls prey to the bureaucracy's own scrutiny. (At the DM's discretion, bribes may be required to set things right, or to prevent a short-term jail sentence.) Otherwise, a failed check doubles the normal amount of time for all decisions and/or issuances.\n\nIf individuals on both sides of an issue are trying to speed and slow the process, they cancel each other out if both proficiency checks succeed.\n\n## Dark Sun Campaign Setting Revised\n\nThe bureaucracy proficiency helps characters in situations involving officials, rules, and established routines. For example, a successful check shortens the time a character spends in a city lockup awaiting judgment. A successful check can also speed the process of gaining an audience with an important templar or other official.\n\nThe bureaucracy proficiency helps a character understand political hierarchies and who to consult to get a job done. A successful check also allows a character to pay 10% less on a tax levied against him; two successful checks in a row allow him to avoid the tax completely.\n\nIn addition to these examples, the bureaucracy proficiency functions in other ways (as allowed by the DM) to let a character understand and use (or abuse) bureaucratic systems with which he's familiar."
    )
)

let embeddedProficiency0409: Proficiency = Proficiency(
    id: "burial_customs",
    name: "Burial Customs",
    wikiPageTitle: "Burial Customs (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The character understands a range of methods for preparing, preserving, and burying the dead. It allows a character to actually assume the role of a mortician.",
        fullText: "## Warriors & Priests of the Realms\n\nThe character understands a range of methods for preparing, preserving, and burying the dead. It allows a character to actually assume the role of a mortician.\n\nEach slot of this skill is limited to burial methods of races and religions; in other words, a human priest of Selûne from Thentia knows how Thentian humans bury their dead and how Selûne's faithful perform funerals and inter the dead, but this skill doesn't tell him how Amnites or dwarves bury their dead.\n\nThis proficiency is broad, and many cultures share similarities. Therefore, with a -3 modifier to Intelligence, the character can try a proficiency check to understand and properly perform burial rituals of either another race/culture or another religion."
    )
)

let embeddedProficiency0410: Proficiency = Proficiency(
    id: "burrow",
    name: "Burrow",
    wikiPageTitle: "Burrow (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Council of Wyrms"],
    mechanics: ProficiencyMechanics(
        groups: ["Dragons"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Strength",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A dragon with this proficiency knows how to tunnel through the ground. Only those dragons with the Burrow movement rate (Br) can select this proficiency, and until they do they cannot travel in this manner.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nA dragon with this proficiency knows how to tunnel through the ground. Only those dragons with the Burrow movement rate (Br) can select this proficiency, and until they do they cannot travel in this manner. Hatchlings can take this proficiency."
    )
)

let embeddedProficiency0411: Proficiency = Proficiency(
    id: "camouflage",
    name: "Camouflage",
    wikiPageTitle: "Camouflage (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Fighter", "Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "By using this proficiency, the character can attempt to conceal himself, his companions, and inanimate objects by using natural or man-made materials. Successful use assumes the availability of all necessary materials.",
        fullText: "## The Complete Ranger's Handbook\n\nBy using this proficiency, the character can attempt to conceal himself, his companions, and inanimate objects by using natural or man-made materials. Successful use assumes the availability of all necessary materials. In forests and jungles, the character can use shrubbery, mud, and other readily available resources. Arctic or similarly barren terrain usually requires special clothing, paints, or other artificial materials (although \"digging in\" is an old trick which may be applicable in such terrain, depending on local conditions). It takes a character a half-hour to camouflage himself or another person, two or three hours to conceal a cart or inanimate object of comparable size, and a half-day to hide a small building.\n\nNeither human, demihuman, monster, nor animal passersby will be able to see a camouflaged character, presuming the character makes a successful proficiency check. Camouflaged companions will also go unnoticed; only one proficiency check is required for the entire group.\n\nObjects may also be camouflaged. Objects the size of a person require no penalty to the check; cart-sized objects require a -1 penalty, while building-sized objects require a -3 penalty. The DM may adjust penalties based on these guidelines.\n\nCamouflaging has no effect on predators that locate prey by scent or other keen senses; a hungry wolf can still sniff out a camouflaged human. A camouflaged person has no protection against a passerby who accidently brushes against or bumps into him. Likewise, a camouflaged person may reveal himself if he sneezes, cries out from the sting of a bee, or makes any other sound.\n\nNote that camouflaging is only necessary for persons or objects that would otherwise be partially or entirely exposed. A person hiding behind a stone wall wouldn't need to be camouflaged to avoid detection, nor would a buried object.\n\nCrossover Groups: Fighter, Rogue.\n\n## Dragon Magazine #200\n\nAn individual with this skill is an expert at outdoor camouflage. Using natural substances (grass, mud, sticks, etc.), he can attempt to blend himself and his companions into the undergrowth. This takes about a turn per person to carry out and is effective only as long as the characters are still and silent. It can be useful for hiding from attackers or as an ambush weapon, granting up to a +4 bonus to surprise others. Buildings can also be camouflaged, taking about two hours to hide a small cottage, although they require maintenance about every week to repair and replace the disguise.\n\nOn a successful check, the character has become effectively invisible to all those more than 30' away, so long as he remains still. Individuals passing closer than 30' are likely to spot something amiss unless the check was passed easily (five or more below the number required). Nobody can be fooled if within 10' of the hidden character. Note that camouflage works only for normal visual sightings; creatures with excellent senses of smell or who can detect heat radiation (infravision) are not affected. Camouflage is successful only in areas with moderate to heavy vegetation; the DM should use common sense."
    )
)

let embeddedProficiency0412: Proficiency = Proficiency(
    id: "carpentry",
    name: "Carpentry",
    wikiPageTitle: "Carpentry (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Strength",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Strength/Stamina, Intelligence/Knowledge",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "The carpentry proficiency enables the character to do woodworking jobs: building houses, cabinetry, joinery, etc. Tools and materials must be available.",
        fullText: "## Player's Handbook\n\nThe carpentry proficiency enables the character to do woodworking jobs: building houses, cabinetry, joinery, etc. Tools and materials must be available. The character can build basic items from experience, without the need for plans. Unusual and more complicated items (a catapult, for example) require plans prepared by an engineer. Truly unusual or highly complex items (wooden clockwork mechanisms, for example) require a proficiency check.\n\n## Player's Option: Skills & Powers\n\nThis character knows the basics of working with wood and can create—with no check required—small structures, fences, platforms, cabinets, carts and wagons. The carpenter can make wooden wheels, but a blacksmith must form the iron rim or the wheel will have a very short life expectancy.\n\nA carpenter might build a short footbridge, a wooden clock, or a dumbwaiter system—these tasks will require a proficiency check. Larger projects such as major bridges, boats, or catapults, require the aid of a character with the engineering proficiency."
    )
)

let embeddedProficiency0413: Proficiency = Proficiency(
    id: "cartography",
    name: "Cartography",
    wikiPageTitle: "Cartography (Proficiency)",
    redirectAliases: ["Cartographer (Proficiency)"],
    primaryGroup: "Wizard",
    campaignSettings: ["Forgotten Realms", "Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["General (Ranger Handbook) Wizard", "Priest", "Rogue (Spacefarer Handbook)"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2 (+0 if Cartographer class)",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency grants skill at map making. A character can draw maps to scale, complete with complex land formations, coastal outlines, and other geographic features.",
        fullText: "## The Complete Ranger's Handbook\n\nThis proficiency grants skill at map making. A character can draw maps to scale, complete with complex land formations, coastal outlines, and other geographic features. The character must be reasonably familiar with the area being mapped.\n\nThe DM makes a proficiency check in secret to determine the accuracy of the map. A successful proficiency check means that the map is correct in all significant details. If the roll fails, the map contains a few errors, possibly a significant one. A roll of exactly 20 means the map contains serious errors, making it useless.\n\nCrossover Groups: General.\n\n## The Complete Spacefarer's Handbook\n\nCharacters with the cartography proficiency are skilled at making maps. They can make maps to scale and can represent complex land formations through the use of perspective drawing and coastal outlines.\n\nA successful proficiency roll indicates that the map is correct in every detail. A failed roll indicates that some details, possibly some significant ones, are in error. A roll of exactly 20 indicates that the map contains a serious error that invalidates it. The success roll for this proficiency should be made by the DM and kept secret from the player.\n\n## Sages & Specialists\n\n﻿This proficiency permits a character to create maps of any kind. To do so, the character must develop an excellent sense of spatial relationships and become a good judge of distances.\n\nWhen called upon to manufacture a new map, the first thing a cartographer must do is research the area to be mapped. The length of this research depends upon the size of the area. Obviously, mapping out the borders of a kingdom is a much more involved task than mapping out the streets of a small town.\n\nWhile performing his research, the character may make several sketches. Once he is done with his research, the cartographer uses these sketches, along with his other notes, to construct the map. The DM then rolls the die and secretly checks the result against the mapper's cartography skill.\n\nIf the check fails, the cartographer comes up with an inaccurate and entirely useless map. The cartographer could sell the poorly made map, but his reputation would suffer, and the purchasers will certainly come looking for the seller once they discover how bad the map is.\n\nIf the DM rolls a 20 on this proficiency check, the cartographer does not realize the inaccurate nature of the map. Otherwise, the character is aware that the map contains flaws. If the DM rolls a 1 on the check, the cartographer has created an almost perfect map. The cartography community at large will use the perfect map as model from which all other maps of the area in question be based. Such a map is worth triple the normal experience points for the cartographer.\n\nA cartographer can also use this proficiency to create a map of a specific area from memory. When making a map entirely from memory- without notes or sketches-the character suffers a-3 penalty to his proficiency check. Success, however, means that the cartographer reproduces a useful map of the area in question. The Cartography proficiency can also be used to estimate distances. In most cases, a cartographer can automatically estimate distances with 90% accuracy. The cartographer can choose to make a proficiency check which, if successful, enables him to judge distances with 100% accuracy. There is no penalty for failing this check.\n\nThis proficiency costs one slot and is based on Intelligence."
    )
)

let embeddedProficiency0414: Proficiency = Proficiency(
    id: "caving",
    name: "Caving",
    wikiPageTitle: "Caving (Proficiency)",
    redirectAliases: ["SNS Table 21"],
    primaryGroup: "General",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "Varies",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The caving proficiency enables a character to function underground. The skill modifier varies depending on the complexity of a character's action.",
        fullText: "The caving proficiency enables a character to function underground. The skill modifier varies depending on the complexity of a character's action. Note that Dwarves and Gnomes receive a +3 bonus to their checks.\n\nBecause they spend so much time underground, spelunkers are exempt from the standard penalty when attempting to determine direction underground. They simply use Direction Sense (a required proficiency) in place of the Caving proficiency.\n\n{| class=\"article-table\"\n|+ Table 21: Caving Penalties\n! Attempt to Detect ||Penalty\n|-\n|Grade or slope in passage || -1\n|-\n|New tunnel or passage construction || -1\n|-\n|Unsafe walls ceilings, and floors || -2\n|-\n|Approximate depth underground || -3\n|-\n|Sliding or shifting walls or rooms || -4\n|-\n|Stonework traps, pits, and deadfalls || -6\n|-\n|Direction underground || -6\n|}"
    )
)
