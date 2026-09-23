import Foundation

/// Parte 15 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency1500: Proficiency = Proficiency(
    id: "natural_fighting",
    name: "Natural Fighting",
    wikiPageTitle: "Natural Fighting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Strength",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows humanoids with natural weaponry (claws, fangs, tails, etc.) a +1 damage bonus on all natural weapon attacks. In addition, they receive a free natural attack beyond normal attacks they are allowed.",
        fullText: "This proficiency allows humanoids with natural weaponry (claws, fangs, tails, etc.) a +1 damage bonus on all natural weapon attacks. In addition, they receive a free natural attack beyond normal attacks they are allowed. A successful proficiency check must be made at the beginning of combat to gain the benefits of this skill. Failure indicates that the benefits cannot be used for the duration of the battle."
    )
)

let embeddedProficiency1501: Proficiency = Proficiency(
    id: "naturopathy",
    name: "Naturopathy",
    wikiPageTitle: "Naturopathy (Proficiency)",
    redirectAliases: ["Naturopathy (NWP)"],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -4,
        rawModifier: "-4",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Naturopathy Intelligence-4 Priest, Wizard",
        fullText: "Naturopathy Intelligence-4 Priest, Wizard\n\n1 Slot\n\nOn a failed Herbalism roll, a healer can attempt Naturopathy to address the illness with common plants and foods. Success cures the illness, but healing takes twice as long as normal; failure means that healing takes three times as long once the illness is cured. A Naturopathy roll gains a +1 bonus if the character also successfully employs the Foraging proficiency.\n\nNaturopathy\n\nNaturopathic medicine closely resembles the practices of conventional western medicine, but healers of this form of medicine treat patients only with pure, natural methods, disdaining any pharmaceutical or surgical procedure. It's touted as the \"medicine of the poor\" due to its low cost and ease of procurement. Unlike Ayurvedic or Oriental methods, Naturopathy does not rely on abstract concepts like body types or vital life force, but on the conventional anatomy we know today. It employs botanical treatments, the fundamental basis of contemporary medicine."
    )
)

let embeddedProficiency1502: Proficiency = Proficiency(
    id: "naval_combat",
    name: "Naval Combat",
    wikiPageTitle: "Naval Combat (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters who possess this skill are able to direct the fire of ship-mounted siege engines and respond quickly to the rapidly changing demands of ship-to-ship combat.",
        fullText: "## Wizards & Rogues of the Realms\n\nCharacters who possess this skill are able to direct the fire of ship-mounted siege engines and respond quickly to the rapidly changing demands of ship-to-ship combat. In addition to the many uses a thorough knowledge of this skill grants the character in any given situation, it has specific uses.\n\nWhen the character assumes command of a ship-board weapon like a catapult or ballista, he should make a proficiency check. If the check passes, the accuracy of that weapon substantially improves. The weapon always makes attack rolls using the Warrior table, no matter what class of character is operating it. The weapon also receives an additional +2 bonus applied to the attack roll.\n\nIf the character is called upon to lead a boarding party or to repel such a force for his own ship, he is entitled to make a proficiency check whenever his side is called upon to make a Morale check. If he passes the check, the morale of his forces increases by 2 points.\n\nThese characters are not accustomed to wearing armor. Not only is it uncomfortable, but they believe that armor puts off customers and lowers the price they receive for their merchandise. With the exception of elven chain mail, they cannot wear any form of armor. Magical defenses, like cloaks of protection, are acceptable, however."
    )
)

let embeddedProficiency1503: Proficiency = Proficiency(
    id: "navigation",
    name: "Navigation",
    wikiPageTitle: "Navigation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Warrior", "Wizard (Rogue - Thief's Handbook)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
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
        briefSummary: "The character has learned the arts of navigating by the stars, studying currents, and watching for telltale signs of land, reefs, and hidden danger. This is not particularly useful on land.",
        fullText: "## Player's Handbook\n\nThe character has learned the arts of navigating by the stars, studying currents, and watching for telltale signs of land, reefs, and hidden danger. This is not particularly useful on land. At sea, a successful proficiency check by the navigator reduces the chance of getting lost by 20 percent.\n\n## Player's Option: Skills & Powers\n\nNavigation: Characters with the navigation proficiency know how to fix their locations on the seas and oceans of the campaign world by observing celestial clues. Characters with a sextant (not necessarily available in all campaigns) and a compass, and who can see the stars or observe a sunrise or sunset, will know where they are—no proficiency check is necessary. Such a skilled character can navigate across entire oceans without becoming lost, though bad weather can obscure the celestial clues and blow a vessel far off course.\n\nIf a character does not have the proper tools, or is forced to work with only a general idea of direction (fog obscures the sunset, for example), the DM should secretly make the proficiency check. Success means the character is reasonably accurate in plotting the day's course. Failure means an off-course error that varies by the extent of the failure—a roll of 20 has the character going practically the exact opposite direction!\n\n## The Complete Thief's Handbook\n\nRequired: Buccaneer.\n\nRecommended: Smuggler.\n\nThis proficiency is normally restricted to priests, warriors, and wizards. Its description is on p.&nbsp;61 of the ''Player's Handbook''.\n\n## Campaign Option: Council of Wyrms Setting\n\nNavigation is described in the Player's Handbook. The proficiency allows a dragon to find its way by the stars, currents, and other signs. A successful check reduces the chance of getting lost at sea by 20%. Dragons also use this proficiency when flying long distances (out of their local territory).\n\nHatchlings can take this proficiency."
    )
)

let embeddedProficiency1504: Proficiency = Proficiency(
    id: "necrology",
    name: "Necrology",
    wikiPageTitle: "Necrology (Proficiency)",
    redirectAliases: ["Necrology"],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard", "Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this skill is well versed in the lore of undead creatures. This proficiency may be used to help determine the probable lairs, dining habits, and history of such creatures (no ability check needed).",
        fullText: "## The Complete Book of Necromancers\n\nA character with this skill is well versed in the lore of undead creatures. This proficiency may be used to help determine the probable lairs, dining habits, and history of such creatures (no ability check needed). Whenever a character with this skill confronts an undead, he or she may be able to specifically identify the creature (discerning between a ghast and a common ghoul, for instance). In addition, providing the character makes another successful ability check, he or she recalls the creature's specific weaknesses and natural defenses or immunities. At the DM's discretion, a failed ability check (in either of these cases) will reveal misleading or even completely erroneous information which may actually strengthen or otherwise benefit the undead."
    )
)

let embeddedProficiency1505: Proficiency = Proficiency(
    id: "netherworld_knowledge",
    name: "Netherworld Knowledge",
    wikiPageTitle: "Netherworld Knowledge (Proficiency)",
    redirectAliases: ["Netherworld Knowledge", "Netherworld Lore"],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard", "Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "With this proficiency, a character learns about the cosmology and organization of the AD&D® game multiverse, focusing primarily on the ultimate destination of spirits after death: the Outer Planes.",
        fullText: "## The Complete Book of Necromancers\n\nWith this proficiency, a character learns about the cosmology and organization of the AD&D® game multiverse, focusing primarily on the ultimate destination of spirits after death: the Outer Planes. In addition, the character learns about the behavior of the dangerous creatures that inhabit the nether regions, including such fiends as the tanar'ri and the baatezu. As with necrology (which applies exclusively to undead), netherworld knowledge can reveal the specific weaknesses and natural immunities of beings from the Outer Planes. The proficiency can also be used to classify the exact type of extraplanar creature encountered. Both of these abilities require an ability check, however."
    )
)

let embeddedProficiency1506: Proficiency = Proficiency(
    id: "night_vision",
    name: "Night Vision",
    wikiPageTitle: "Night Vision (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Night Vision: This proficiency improves a character's ability to see in low-light conditions. It is not equal to infravision but is still useful.",
        fullText: "Night Vision: This proficiency improves a character's ability to see in low-light conditions. It is not equal to infravision but is still useful.\n\nTo use his Night Vision, the character must spend five rounds in the type of light he will be moving or waiting in. Until he has spent that amount of time in the dark, this proficiency just does not work. (However, the character can be doing other things while letting his eyes adjust, so long as these other tasks do not expose him to varying light conditions.)\n\nOnce his eyes have adjusted, the character can use his Night Vision at any time. Whenever he looks at something, he must make a Night Vision proficiency check. With a successful check, the character's Visibility Ranges (from the ''Player's Handbook'', Chapter 13) are doubled in the following conditions: Fog (dense or blizzard), Fog (moderate), Night (full moon), Night (no moon), Twilight. Thus, a character under a full moon at night would be able to spot movement at 200 feet rather than at 100 feet.\n\nIf the character with this proficiency is exposed to a change in illumination—such as by having a fireball go off within 500 feet or by having a torch or lamp waved in his face—his eyes are dazzled. His Night Vision is gone and cannot be regained until the character has again spent five rounds letting his eyes adjust."
    )
)

let embeddedProficiency1507: Proficiency = Proficiency(
    id: "numeracy",
    name: "Numeracy",
    wikiPageTitle: "Numeracy (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Al-Qadim"],
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
        briefSummary: "A character with the numeracy proficiency is well-versed in numbers and numerical computations, including accounting, mathematics, and other processes requiring recorded numbers.",
        fullText: "## The Complete Sha'ir's Handbook\n\nA character with the numeracy proficiency is well-versed in numbers and numerical computations, including accounting, mathematics, and other processes requiring recorded numbers. Balancing the books, paying the troops, and figuring total income (as well as arguing with the tax collector) all figure in numeracy. A character without this skill will still be able to perform simple mathematical actions, but their figures may go awry on more complex formula."
    )
)

let embeddedProficiency1508: Proficiency = Proficiency(
    id: "numerology",
    name: "Numerology",
    wikiPageTitle: "Numerology (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Like numeracy, numerology deals with numbers, but from their mystic and magical side.",
        fullText: "## The Complete Sha'ir's Handbook\n\nLike numeracy, numerology deals with numbers, but from their mystic and magical side. Each number has its own presence and power, and an individual's birth hour or favorite number is as revealing as other methods of divination as to his or her future. The numerology proficiency is often used to determine the best time for certain actions, ceremonies, or pronouncements, and in its most skilled level (and the most exact data) can calculate the locations of doorways to other planes."
    )
)

let embeddedProficiency1509: Proficiency = Proficiency(
    id: "nutriment",
    name: "Nutriment",
    wikiPageTitle: "Nutriment (Proficiency)",
    redirectAliases: ["Nutriment (GEP)"],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A body with this proficiency can draw sustenance and nourishment from ethereal mists with a successful proficiency check. Nutriment is a more complex, conscious application of the same principle by which travelers on the Ethereal Plane breathe.",
        fullText: "A body with this proficiency can draw sustenance and nourishment from ethereal mists with a successful proficiency check. Nutriment is a more complex, conscious application of the same principle by which travelers on the Ethereal Plane breathe. When a character successfully uses this proficiency, she converts enough of the possibility found in the ethereal mists into base nutrients for the equivalent of one meal.\n\nA body who uses this proficiency doesn't create gourmet food. Fact is, the nutrition is bland and unsatisfying. For every three uses in a row, a body suffers a -1 penalty to the check. Thus, a cutter who skipped nine real meals and used the nutriment proficiency instead suffers a -3 penalty to her proficiency check."
    )
)

let embeddedProficiency1510: Proficiency = Proficiency(
    id: "observation",
    name: "Observation",
    wikiPageTitle: "Observation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Spelljammer"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest (PO:SM) (Rogue - Thief & Ninja Handbook) (General - Spacefarer Handbook)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Observation: Characters with this proficiency have cultivated exceptional powers of observation. The DM may ask for a proficiency check anytime there is something subtly wrong or unusual in the character's environment.",
        fullText: "## Player's Option: Spells & Magic\n\nObservation: Characters with this proficiency have cultivated exceptional powers of observation. The DM may ask for a proficiency check anytime there is something subtly wrong or unusual in the character's environment. For example, the character may note the fact that the tools of a potter's shop are caked with a different kind of clay than that present in the workshop, or he might notice telltale marks of traffic that indicate the presence of a secret door. The DM shouldn't let this become a substitute for alertness and good thinking on the part of the player; if he's picking up more than one or two clues a game session with this proficiency, it's probably too many.\n\n## The Complete Thief's Handbook\n\nRequired: Beggar, Cutpurse, Investigator, Spy, Swindler, Troubleshooter.\n\nRecommended: Assassin, Bounty Hunter, Burglar, Fence, Smuggler.\n\nCharacters with this proficiency have cultivated exceptionally acute powers of observation. The DM may ask for a proficiency check (or secretly roll it himself) anytime there is something subtly askew; he may also allow characters with observation to increase their chance of finding secret or concealed doors by 1 in 6. The proficiency covers all the senses.\n\nExample: Julina is questioning a man who claims to be a craftsman who has worked on the palace; she is searching for the most discreet entrance. The DM secretly rolls an observation proficiency check; it is successful. \"You notice,\" he tells her, \"that his hands are in beautiful condition, entirely lacking callouses.\" From this observation, Julina may deduce that the man is actually just posing as a craftsman; he may be a con man taking advantage of a few free drinks or coins, or he could even be a spy for her enemies.\n\n## The Complete Book of Humanoids\n\nThis proficiency represents a character's exceptionally acute powers of observation. DMs may ask for checks (or roll them secretly) whenever there is something slightly out of the ordinary. Characters with this proficiency have their chances of finding secret doors increased to 2 in 6, and concealed doors to 3 in 6. This proficiency covers all the senses.\n\n## The Complete Spacefarer's Handbook\n\nCharacters with this proficiency have cultivated exceptionally acute powers of observation. The DM may ask for a proficiency check (or secretly roll one) anytime there is something subtly wrong. He may also allow characters with this proficiency to increase their chances of finding secret or concealed doors by 1 in 6 (even characters who are not elves or half-elves have a 1 in 6 chance using this proficiency). This proficiency covers all of the senses.\n\n## The Complete Ninja's Handbook\n\nObservation: This proficiency, introduced in ''The Complete Thief's Handbook'', gives characters exceptionally acute powers of observation with all five senses. The DM may ask for a proficiency check (or secretly roll one) whenever there is a subtle clue that the character might otherwise overlook. The DM may also allow characters with Observation proficiency to increase their chance of finding secret or concealed doors by 1 in 6.\n\n## Campaign Option: Council of Wyrms Setting\n\nEvery dragon is observant, though some can be better than the norm. This proficiency enhances a dragon's powers of observation. DMs may ask for checks (or roll them secretly) whenever there is something slightly out of the ordinary within a dragon 's area of sight. This also adds +10% bonus to the special dragon senses ability all dragons possess (see \"Common Dragon Abilities,\" in Chapter Three). Hatchlings can take this proficiency.\n\n## Shaman\n\nCharacters with this proficiency have cultivated exceptionally acute powers for observation. The DM may ask for (or secretly roll) a proficiency check anytime there is something subtly askew; he may also allow characters with observation to increase their chance of finding a secret or concealed door by 1."
    )
)

let embeddedProficiency1511: Proficiency = Proficiency(
    id: "omen_interpretation",
    name: "Omen Interpretation",
    wikiPageTitle: "Omen Interpretation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency is able to infer information about the present or future from natural phenomena. Therefore, the character cannot choose when to use the proficiency, nor what questions to seek answers to.",
        fullText: "A character with this proficiency is able to infer information about the present or future from natural phenomena. Therefore, the character cannot choose when to use the proficiency, nor what questions to seek answers to.\n\nOmens are signs hidden within the seemingly mundane or natural world, thought to have been sent by the spirits or deities, giving warnings or  encouragement to mortals. The flight of a rare bird, patterns in the sunset, the color of smoke rising from a campfire, all of these things may be omens containing hints toward the likely outcome of a battle, the wisdom of starting a journey, or any similar matter. This proficiency allows a character to recognize and identify an omen.\n\nIt is possible for a character to seek an Omen. For example, an interpreter might spend a day standing on a hilltop looking for unusual birds, or he or she might spend take a walk through the woods studying the wildlife and plants; After ldlO hours have passed, a successful proficiency check (rolled either by the player or secretly by the DM) means the character identifies an omen, and the DM should then give vague hints regarding the matter he seeks information on. The character has no control over when, or if, an omen appears, and the DM has the option of presenting the character with a false omen if the proficiency check is failed.\n\n{| class=\"article-table\"\n|\nThe following are examples of omens that DMs might weave into their adventures. They are grouped according to their subject; the information in quotation marks is an interpretation of the omen.\n\nBattle\n* The night before a battle the flames of the campfire flicker with a reddish hue—\"one of those around the fire will die if he or she joins the battle tomorrow.\" \n* As the forces gather on the field vultures wheel lazily overhead—\"the vultures are lethargic because they know that there will be few deaths here today.\" \n* A few drops of rain fall from a clear sky as the forces gather—\"the gods/spirits cry, saddened that this battle is to be fought.\" \n* A sacred bird wheels above the battlefield—\"the spirits know that this battle is of great importance, and have sent a messenger to watch for its outcome.\"\n\nBirth\n* Two usually solitary animals (like eagles) are seen together—\"the birth will produce twins\". \n* A snake is found in the house where the woman is in labor—\"the child will be evil and should be abandoned or sent far away.\" A dead mouse is found in the house around the time of the birth—\"the child will not live to adulthood.\" \n* An owl lands on the roof of the house where a woman is in labor—\"the child will be exceedingly wise\" (in other words, would make an ideal apprentice for a shaman).\n\nJourney\n* A vulture is perched watching the travelers as they walk towards it along the road—\"there will be death on this journey.\" \n* As the travelers assemble a cuckoo lands close by—\"one in the group is not all that he or she claims, and should not be trusted.\" \n* As the group begin their journey a fox is spotted in the bushes just up the path—\"an ambush has been set further on.\"\n\nKing/Ruler \n* A lion in the forest is being chased down by a pack of wild dogs—\"the fate of the noble is in the hands of the base.\" One night a storm blows up, and though not particularly ferocious it fells the great old tree that stands in the center of the wood—\"though the danger may not seem great, it may lead to the downfall of the ruler or his/her dynasty.\"\n\nTrade\n* Immediately upon leaving home in the morning, a merchant finds a gold piece in the gutter— \"today will bring many opportunities for easy profit.\" \n* The town's mayor is given a fine, rare, smoked fish by an ambassador or trade envoy, but when he has it served up that evening he nearly chokes on a bone—\"trade with that place (the ambassador's/envoy's city) will bring ruin for this town.\"\n\nWar\n* The call of war goes out, but when one of the I commanding officers goes to fetch his weapons from his vault he finds his sword flecked in rust—\"the armies of the nation are ill-prepared for this coming conflict.\" \n* As the party enter the gates of a city, a single stone falls from the top of its impressive walls— \"if the city is besieged, it will fall, despite its mighty defenses.\" On the morning that the army marches out, they pass a funeral cortege—\"the army is doomed.\" \n* The day that hostilities break out the sunrise bathes the land in a deep golden light—\"the war shall bring the nation vast wealth.\"\n|}"
    )
)

let embeddedProficiency1512: Proficiency = Proficiency(
    id: "omen_reading",
    name: "Omen Reading",
    wikiPageTitle: "Omen Reading (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Omen Reading: There are hundreds of myths and superstitions about the art of divination, or predicting the future through the reading of signs or indications.",
        fullText: "Omen Reading: There are hundreds of myths and superstitions about the art of divination, or predicting the future through the reading of signs or indications. A character with this proficiency is skilled in a form of divination and knows the proper ceremonies and observances to use in order to obtain a valid reading. He is also familiar with the various messages or indications that characterize a form of divination. Omen readers use dozens of different methods for their auguries, including astrology, numerology, reading palms, examining animal entrails, casting bones, dice, or runes, and burning incense to observe the smoke, just to name a few. The exact nature of the character's expertise is up to the player.\n\nTo use this proficiency, the omen reader phrases a general question about a course of action, such as \"Is this a good day to start our journey?,\" \"Should we try to track the orcs to their lair, or wait for their next raid?,\" or \"When will the dragon return?\" The DM then makes a proficiency check in secret; if the character fails, the DM can tell him that the signs were inconclusive, or make up a false answer for a spectacular failure (a natural 20 on the check, for instance). If the omen reader succeeds, the DM can give the character a vague answer based on his assessment of the situation. An omen is usually good, bad, or inconclusive, although an answer of \"a day or two\" or \"proceed, but with caution\" is acceptable as well. Omens aren't guaranteed; if a party ignores a bad omen, they might succeed in their task anyway. An omen is nothing more than the DM's best guess about a course of action.\n\nPerforming the ceremony of reading an omen requires an hour or more. Special tools or supplies, such as runesticks, may be necessary depending on the character's favored form of omen reading. Some superstitious or primitive cultures may place a great deal of weight on omen reading, and a skilled diviner may be held in high regard by these people."
    )
)

let embeddedProficiency1513: Proficiency = Proficiency(
    id: "oration",
    name: "Oration",
    wikiPageTitle: "Oration (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Oration: The character is skilled in speaking convincingly and well.",
        fullText: "## Age of Heroes Campaign Sourcebook\n\nOration: The character is skilled in speaking convincingly and well. The oration skill may be used to add to attempts to persuade NPCs to do something the character wants or might be used to sway the emotions of a crowd, although it's impossible to convince someone to do something contrary to their nature. It can also be used to expound upon one's philosophy or religion. Oration skill helps when making a case for oneself in court, and is also a skill which heralds should have in order to fulfill their duties. Actors might also benefit from this skill."
    )
)

let embeddedProficiency1514: Proficiency = Proficiency(
    id: "oratory",
    name: "Oratory",
    wikiPageTitle: "Oratory (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest - PO:SM Warrior", "Priest - Paladin"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: -1,
        rawModifier: "-1 - PO:SM +0 - Paladin",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Oratory: This is the power to move other people with words and emotion. By captivating an audience, the priest can convince them of the rightness of his words through force of will and dramatic speaking.",
        fullText: "## Player's Option: Spells & Magic\n\nOratory: This is the power to move other people with words and emotion. By captivating an audience, the priest can convince them of the rightness of his words through force of will and dramatic speaking. Priests with this skill can attempt to proselytize (seek converts) among small audiences by proclaiming the glories of their faith and the dangers of nonbelief, but the character must pass his check by a margin of four or more to win any long-lasting converts to the faith. A convert will listen to the priest's suggestions or ideas, but won't necessarily become a follower or hireling of the character.\n\nThe DM can decide how any group of listeners is likely to be affected by the priest's exhortations. If they're inclined to be hostile or are preparing to attack the priest, there's very little he can say to change their minds. However, if the priest passes a proficiency check, he may be able to modify an encounter reaction check by one category—hostile to indifferent, or indifferent to friendly, for example. Optionally, he may be able to encourage the crowd to take a specific action that they're inclined to perform anyway. If an angry crowd wants to see an important prisoner freed because it's rumored he was convicted wrongly, a priest with oratory may be able to push them into storming the jail or convince them to give up and go home. If the player presents an especially moving argument or speech, the proficiency check is made with a +1 to +4 bonus.\n\n## The Complete Paladin's Handbook\n\nThrough inspiring speech and sheer force of personality, a character with this proficiency can influence the opinion of a crowd. Any size crowd may be influenced, so long as they speak the same language as the orator, and can see and hear him clearly.\n\nTo use this proficiency, the orator must address the crowd on one specific topic. For instance, he may attempt to persuade them to rise up against a local despot, leave town because of an impending danger (a monster on the outskirts of town, an advancing evil army), or help search for a missing child.\n\nBefore the orator speaks, the DM must determine the size of the crowd, their level, and their general attitude toward the orator and the topic he's addressing. For small crowds—say, less than five members—determine levels and attitudes individually. Break larger crowds into groups; decide an average level and attitude for each group. Use Table 59 in Chapter 11 of the DMG to access attitudes about the topic; the crowd may be Friendly, Indifferent, Cautious, Threatened, or Hostile.\n\nBefore any rolls are made, or the orator begins speaking, the player tells the DM if the orator will be attempting to adjust the crowd's opinion one level up or down on Table 59. The orator then speaks to the crowd; he must speak uninterrupted for at least 10 rounds.\n\nWhen the orator finishes speaking, roll the Oratory proficiency check. If the check succeeds, make an Intelligence check for each individual in a small crowd, or for each small group in a large crowd. Modify these rolls by a –1 penalty for each 1 by which the orator made the Oratory check. For instance, if the Orator needed a 10 to succeed and rolled a 5, each Intelligence check takes a –5 penalty.\n\nIndividuals or small groups who fail their throws have their opinions about the topic adjusted one level on Table 59 in the DMG. An Indifferent opinion may become Friendly or Cautious, a Cautious opinion may become Indifferent or Threatening. However, all audience members who fail their rolls have their opinions adjusted the same way. The opinions of those who succeed in their rolls remain unchanged by the character's Oratory; however, practically speaking, peer pressure can produce the same results. The DM may override any die roll that produces inappropriate results; for example, an NPC in the crowd who has a long-standing feud with the orator may be unswayed, regardless of the orator's eloquence.\n\nA character may use this proficiency only once on a given crowd. Should the composition of the crowd change to include many new members, the character may make another oratory attempt, providing he speaks on a different topic.\n\nNote that this proficiency elicits only modest changes in attitude. If a crowd feels Indifferent towards a despot, an orator may be able to stir up some ambiguous feelings about him, but he won't be able to convince them to immediately storm the despot's castle. If the crowd is suspicious of a particular religion, the orator may persuade them to be more tolerant, but he shouldn't expect any spontaneous conversions.\n\nCrossover Groups: Warrior, Priest."
    )
)
