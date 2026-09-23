import Foundation

/// Parte 25 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency2500: Proficiency = Proficiency(
    id: "weaponsmithing_crude",
    name: "Weaponsmithing, Crude",
    wikiPageTitle: "Weaponsmithing, Crude (Proficiency)",
    redirectAliases: ["CBarbH Table 36"],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows the making simple weapons out of natural materials. This skill is most often found in those from a primitive, tribal, or savage background.",
        fullText: "## The Complete Ranger's Handbook\n\nThis proficiency allows the making simple weapons out of natural materials. This skill is most often found in those from a primitive, tribal, or savage background.\n\nThe crude weapons are limited to natural materials: stone, wood, bone, sinew, reed, and the like. Crude weapons take a certain amount of time to make. The DM may add additional primitive weapons to the basic list.\n\nThe chance for success is based on the character's Wisdom, with a -3 penalty. Any warrior or a character with the hunting proficiency has a +3 bonus. The fashioner must be proficient in the use of the weapon.\n\nIf successful, the weapon can be used normally. If failed, the weapon is so badly flawed as to be useless. On a roll of 20, the weapon seems sound, but will break upon first use. On a roll of 1, the weapon has no chance of breaking except against a harder material.\n\nOptional: Crude weapons check for breaking upon inflicting damage; roll 1d6. Bone weapons break on a roll of 1 or 2, stone weapons break on a roll of 1.\n\n{| class=\"article-table\"\n! Weapon || Construction Time\n|-\n| Arrows || 7/day\n|-\n| Axe, Battle || 4 days\n|-\n| Axe, Hand || 1 day\n|-\n| Axe, Throwing || 6 days\n|-\n| Bow, Long* || 15 days\n|-\n| Bow, Short || 12 days\n|-\n| Dagger || 2 days\n|-\n| Dart || 3 day\n|-\n| Javelin || 1 day\n|-\n| Knife || 2 days\n|-\n| Quarterstaff || 1 day\n|-\n| Spear || 2 days\n|-\n| Staff Sling || 3 days\n|-\n| Warhammer || 5 days\n|}\n: * Seasoning the wood takes 1 year.\n\n## The Complete Barbarian's Handbook\n\nThis proficiency allows the character to make simple nonmetallic weapons using stone, wood, bone, and other natural substances. The character can only fashion weapons for which he has weapon proficiencies. For example, a character with a proficiency in spears can fashion crude spears but not crude axes.\n\nTable 36 summarizes the construction times for various weapons. The DM may augment this list with additional weapons (see Chapter 5 for ideas).\n\nAfter completing a weapon, the character must make a proficiency check. If he has the hunting proficiency, he modifies his checks by +3. If the check fails, the weapon is so badly flawed that it can't be used. On a roll of 20, it breaks on the first use. On a roll of 1, the weapon won't break unless struck against a harder material.\n\nBarbarians: A barbarian may only fashion weapons commonly used in his homeland.\n\nCrossover Group: General (CBarbH Table 30 lists Crossover Group as Warrior instead)\n\n{| class=\"article-table\"\n|+ Table 36: Construction Time for Crude Weapons\n! Weapon || Construction Time\n|-\n| Atlatl || 1 day\n|-\n| Axe, Hand || 1 day\n|-\n| Axe, Throwing || 6 days\n|-\n| Bolas || 1 day\n|-\n| Blowgun || 2 days\n|-\n| Club || 1 day\n|-\n| Dart || 3/day\n|-\n| Javelin || 1 day\n|-\n| Net || 3 days\n|-\n| Knife || 2 days\n|-\n| Sling || 2 days\n|-\n| Staff Sling || 3 days\n|-\n| Spear || 2 days\n|}"
    )
)

let embeddedProficiency2501: Proficiency = Proficiency(
    id: "weather_sense",
    name: "Weather Sense",
    wikiPageTitle: "Weather Sense (Proficiency)",
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
            subAbility: "Wisdom/Intuition",
            characterPointCost: 2,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency enables the character to make intelligent guesses about upcoming weather conditions. A successful proficiency check means the character has correctly guessed the general weather conditions in the next six hours.",
        fullText: "## Player's Handbook\n\nThis proficiency enables the character to make intelligent guesses about upcoming weather conditions. A successful proficiency check means the character has correctly guessed the general weather conditions in the next six hours. A failed check means the character read the signs wrong and forecast the weather incorrectly. The DM should roll the check secretly. A proficiency check can be made once every six hours. However, for every six hours of observation, the character gains a +1 bonus to his ability score (as he watches the weather change, the character gets a better sense of what is coming). This modifier is cumulative, although sleep or other activity that occupies the attention of the character for a long period negates any accumulated bonus.\n\nSometimes impending weather conditions are so obvious that no proficiency check is required. It is difficult not to notice the tornado funnel tearing across the plain or the mass of dark clouds on the horizon obviously headed the character's way. In these cases, the player should be able to deduce what is about to happen to his character anyway.\n\n## Player's Option: Skills & Powers\n\nWeather Knowledge:  A character with this proficiency has a knowledge of winds, humidity, clouds, and seasons and can accurately predict the immediate weather simply by looking at the sky. With a proficiency check the character can predict what will happen during the next 12 hours. Modify the check up to +/–6, with a 0 modifier to predictions for the weather six hours ahead.\n\n## Campaign Option: Council of Wyrms Setting\n\nWeather Sense is described in the Player's Handbook. A successful check means the dragon knows the weather for the next six hours. One check can be made every six hours. For every six hours spent doing nothing but watching the weather, the dragon can add +1 to its ability score.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency2502: Proficiency = Proficiency(
    id: "weaving",
    name: "Weaving",
    wikiPageTitle: "Weaving (Proficiency)",
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
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Reason, Dexterity/Aim",
            characterPointCost: 3,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with weaving proficiency is able to create garments, tapestries, and draperies from wool or cotton. The character requires a spinning apparatus and a loom.",
        fullText: "## Player's Handbook\n\nA character with weaving proficiency is able to create garments, tapestries, and draperies from wool or cotton. The character requires a spinning apparatus and a loom. A weaver can create two square yards of material per day.\n\n## Player's Option: Skills & Powers\n\nWeaving: A character with this skill can weave yarn into cloth, and he can create tapestries, cloaks, and other large swaths from thread. The character can spin wool into yarn with a spinning wheel, and he needs a loom to artfully weave that yarn. A character with the artistic talent trait can use this skill to create exceptionally beautiful cloth. Halflings get a +1 bonus to their rating with this proficiency."
    )
)

let embeddedProficiency2503: Proficiency = Proficiency(
    id: "western",
    name: "Western",
    wikiPageTitle: "Western (Proficiency)",
    redirectAliases: ["Western"],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Western Wisdom-3 Priest",
        fullText: "Western Wisdom-3 Priest\n\n1 Slot\n\nThis proficiency allows the character to perform battlefield surgery such as amputation, extracting arrowheads, or removing flesh-burrowing creatures like rot grubs. The character gains a +1 bonus to this proficiency check if he or she also has the Anatomy proficiency.\n\nWestern\n\nThis is the medieval equivalent to modem medicine. Amputation, invasive surgery, and alchemical drugs are common. Alchemical drugs are medicines. created by artificial means of combining elements into compounds, as well as the knowledge of how a diet's content of vitamins and minerals affects health."
    )
)

let embeddedProficiency2504: Proficiency = Proficiency(
    id: "whistling_humming",
    name: "Whistling/Humming",
    wikiPageTitle: "Whistling/Humming (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Dexterity",
        checkModifier: 2,
        rawModifier: "+2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Almost anyone can whistle or hum. Those who take this proficiency are exceptional whistlers and hummers.",
        fullText: "## The Complete Bard's Handbook\n\nAlmost anyone can whistle or hum. Those who take this proficiency are exceptional whistlers and hummers. They can produce tunes as captivating as most songs. A person with this proficiency is a true master whistler and hummer.\n\nIt is so easy to learn a new tune to whistle or hum that characters with this proficiency can learn numerous tunes. In fact, if a proficiency check is made, a whistler or hummer knows any particular tune in question. In addition, a character with both this proficiency and the animal lore proficiency can mimic any bird call he has heard.\n\nHowever, most adventurers do not take whistling just for the entertainment value. Instead, they are looking for its uses in communication. This communication is possible only among those who know this proficiency. If both characters succeed with their proficiency checks, a single concept can be communicated. Some examples are \"Go around to the side door,\" \"I hear them coming,\" \"Slowly reach out now, the guard doesn't see you.\"\n\n## The Complete Book of Humanoids\n\nCharacters with this proficiency are exceptional whistlers and hummers. They can produce tunes as captivating as most songs. If a successful check is made, the character knows any particular tune in question. If he also has the animal lore proficiency, he can mimic any bird call he has ever heard.\n\nAdventurers also use this proficiency to communicate with each other. This type of communication is only possible among the characters whd have this proficiency. If two or more characters with this proficiency make successful checks, a single concept can be communicated between them."
    )
)

let embeddedProficiency2505: Proficiency = Proficiency(
    id: "wild_fighting",
    name: "Wild Fighting",
    wikiPageTitle: "Wild Fighting (Proficiency)",
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
        briefSummary: "Characters with this proficiency employ an extremely unorthodox and unpredictable fighting style. Wild fighting is ferocious and deadly, without any grace or discipline.",
        fullText: "## The Complete Book of Humanoids\n\nCharacters with this proficiency employ an extremely unorthodox and unpredictable fighting style. Wild fighting is ferocious and deadly, without any grace or discipline. It is also extremely tiring, as part of its nature is that it focuses every bit of energy a character has into the attack.\n\nThe benefits are in the number of attacks the character gets and in the amount of damage attacks inflict. A wild-fighting character gets one more attack per round than normally entitled to. All damage rolls for attacks that hit receive a +3 bonus.\n\nHowever, when wild fighting, a character's attack rolls also are reduced by 3. Also the attacker's armor class is penalized by 3, making it easier to hit him.\n\nTo use wild fighting, a character must make a successful proficiency check at the start of combat. A failure means that the character receives only the penalties of the proficiency and none of the benefits.\n\nWild fighting can only be used twice per day, as it is extremely tiring. After a battle ends, the wild fighter must rest for one hour before he can again call on the proficiency. Resting means doing nothing but resting or engaging in light travel (riding a slow-moving horse, etc.). If the character must walk, he cannot use the proficiency until four hours have passed. Without this rest, a tired character suffers a -3 penalty to all proficiency checks, a -5 to armor class, a -5 to THAC0, and a -3 from damage rolls. These penalties are in effect until the full resting period has elapsed.\n\n## The Complete Barbarian's Handbook\n\nA character with this proficiency has the ability to whip himself into an attack frenzy, employing a fierce fighting style devoid of discipline.\n\nTo use wild fighting, the character must make a proficiency check just before combat ensues. If the check succeeds, he receives the following benefits and penalties:\n\n* He may make one more attack per round beyond his normal limit.\n* He receives +3 to all damage rolls.\n* His Armor Class is penalized by 3 (to a limit of AC 10).\n* His attack rolls are penalized by 3.\n\nIf the check fails, the character receives both of the penalties but neither of the benefits.\n\nRegardless of whether the check succeeds or fails, the character receives the proficiency effects for the duration of the battle or for one hour, whichever comes first.\n\nAfter the battle ends (or an hour expires), the character must rest for an hour before he can use the proficiency again. While he rests, the character may take no actions other than light travel (such as riding a slow-moving horse). If he must walk, he can't use the proficiency until four hours pass. If he neglects to rest, he suffers the following penalties:\n\n* A -3 penalty to all proficiency checks.\n* A -5 penalty to his Armor Class.\n* A -5 penalty to his THACO.\n* 1 extra point of damage from all successful enemy hits.\n\nThe penalties remain in effect until the character rests for the indicated period.\n\nCrossover Group: General. (CBarbH Table 30 lists Crossover Group as Warrior instead.)"
    )
)

let embeddedProficiency2506: Proficiency = Proficiency(
    id: "wildspace_navigation",
    name: "Wildspace Navigation",
    wikiPageTitle: "Navigation, Wildspace (Proficiency)",
    redirectAliases: ["Navigation (Wildspace)"],
    primaryGroup: "Wizard",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard", "Priest"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The character has learned the art of navigating through wildspace, avoiding hazards and using planetary motion to improve speed over long journeys.",
        fullText: "## The Complete Spacefarer's Handbook\n\nThe character has learned the art of navigating through wildspace, avoiding hazards and using planetary motion to improve speed over long journeys. A successful proficiency check allows the character's spelljamming vessel to arrive at its wildspace destination 10% faster than normal. Thus, if it would take 10 days to make the trip normally, the character can steer a course that will take only nine days. An unsuccessful proficiency check indicates that no time is saved; on a roll of 20, travel time increases by 20%."
    )
)

let embeddedProficiency2507: Proficiency = Proficiency(
    id: "wind_sailing",
    name: "Wind-Sailing",
    wikiPageTitle: "Wind-Sailing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This skill allows one to create and control wind-powered sailing devices such as cliff gliders and wind carts. It covers rigging, construction, and sailing techniques.",
        fullText: "This skill allows one to create and control wind-powered sailing devices such as cliff gliders and wind carts. It covers rigging, construction, and sailing techniques. It does not give the character abilities in navigation or astrogation. Larger vehicles can be built, but the difficulty should increase as the cart grows larger."
    )
)

let embeddedProficiency2508: Proficiency = Proficiency(
    id: "winemaking",
    name: "Winemaking",
    wikiPageTitle: "Winemaking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Inteligence",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows characters to create wine from the fermented juice of grapes or other plants and fruits well enough to make a living at it.",
        fullText: "This proficiency allows characters to create wine from the fermented juice of grapes or other plants and fruits well enough to make a living at it. The character will always succeed to some extent; proficiency checks are only required when attempting to prepare a truly magnificent wine as a special gift or for a special celebration."
    )
)

let embeddedProficiency2509: Proficiency = Proficiency(
    id: "wing_buffet",
    name: "Wing Buffet",
    wikiPageTitle: "Wing Buffet (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior (Avariel)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency is special training in the wing-buffer form of attack; it allows a +1 to attack and damage.",
        fullText: "This proficiency is special training in the wing-buffer form of attack; it allows a +1 to attack and damage."
    )
)

let embeddedProficiency2510: Proficiency = Proficiency(
    id: "yoke_pole",
    name: "Yoke-Pole",
    wikiPageTitle: "Yoke-Pole (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The feat of the yoke-pole is a nonweapon proficiency requiring 2 slots, and a character must already have the charioteering proficiency.",
        fullText: "## Celts Campaign Sourcebook\n\nThe feat of the yoke-pole is a nonweapon proficiency requiring 2 slots, and a character must already have the charioteering proficiency.\n\nThis feat involves running along the yoke-pole of a chariot while it is going at full speed—a risky business, as failure will send the character tumbling beneath the horses' hooves and the chariot's wheels. It is used solely to impress, and has very few practical applications—although inventive player characters may find a few.\n\nThe feat requires a Dexterity ability check. Success gains the character a +1 bonus on encounter reactions with all who witness the feat, while failure results in a fall, the individual suffering 2d8 points of damage."
    )
)

let embeddedProficiency2511: Proficiency = Proficiency(
    id: "zero_gravity_combat",
    name: "Zero-Gravity Combat",
    wikiPageTitle: "Zero-Gravity Combat (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior", "Priest", "Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with zero-gravity combat proficiency is skilled at fighting in the absence of gravity.",
        fullText: "## The Complete Spacefarer's Handbook\n\nA character with zero-gravity combat proficiency is skilled at fighting in the absence of gravity. The character suffers a +3 penalty on initiative rolls and a — 1 penalty on all attack rolls (as compared to a +6 initiative penalty and a -2 attack roll penalty for characters without this proficiency; see the Concordance of Arcane Space, Chapter 1).\n\nFurthermore, the character retains the ability to use special combat abilities, such as martial arts, while drifting in space.\n\nFinally the character can roughly steer his course in space by throwing objects away from him and by shifting toward large objects. He cannot control his speed, however, and can only slightly affect his course."
    )
)
