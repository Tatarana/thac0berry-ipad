import Foundation

/// Parte 23 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency2300: Proficiency = Proficiency(
    id: "time_sense",
    name: "Time Sense",
    wikiPageTitle: "Time Sense (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["Chronomancer"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The character with this proficiency has an inner clock which allows him to keep track of the time without the aid of devices or astronomical sightings (the sun or stars).",
        fullText: "The character with this proficiency has an inner clock which allows him to keep track of the time without the aid of devices or astronomical sightings (the sun or stars). A successful check means that the character can estimate the time passed since the last verifiable time check within 3d10 minutes.\n\nFor every 24 hours that the character is without a verifiable source, this check must be made. Failure means that the character is off by 1–2 hours. The character knows some- thing is wrong, but that's still his best guess. Subsequent checks are made using previous guesses as a base.\n\nThis ability can also be used to awaken at a certain time. An additional -1 modifier is applied when attempting this. Failure means oversleeping by one hour for every point by which the check is missed (up to four hours)."
    )
)

let embeddedProficiency2301: Proficiency = Proficiency(
    id: "toxicology",
    name: "Toxicology",
    wikiPageTitle: "Toxicology (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Toxicology: In the hands of the ninja, proficiency in Herbalism is bent toward knowledge of knockout drugs and poisons.",
        fullText: "Toxicology: In the hands of the ninja, proficiency in Herbalism is bent toward knowledge of knockout drugs and poisons. A Toxicologist knows more about such drugs than an Herbalist with a similar Intelligence score (hence the lack of penalty), but will not know anything about other types of chemical compounds."
    )
)

let embeddedProficiency2302: Proficiency = Proficiency(
    id: "tracking",
    name: "Tracking",
    wikiPageTitle: "Tracking (Proficiency)",
    redirectAliases: ["PHB Table 39", "PHB Table 40"],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior (Rogue - Thief's Handbook)"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition",
            characterPointCost: 4,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "Characters with tracking proficiency are able to follow the trail of creatures and characters across most types of terrain.",
        fullText: "## Player's Handbook\n\nCharacters with tracking proficiency are able to follow the trail of creatures and characters across most types of terrain. Characters who are not rangers roll a proficiency check with a -6 penalty to their ability scores; rangers have no penalty to their ability scores. In addition, other modifiers are also applied to the attempt, according to Table 39.\n\nThe modifiers in Table 39 are cumulative—total the modifiers for all conditions that apply and combine that with the tracker's Wisdom score to get the modified chance to track.\n\n{| class=\"article-table\"\n|+ Table 39: Tracking Modifiers\n|-\n! Terrain || Modifier\n|-\n| Soft or muddy ground || +4\n|-\n| Thick brush, vines, or reeds || +3\n|-\n| Occasional signs of passage, dust || +2\n|-\n| Normal ground, wood floor || 0\n|-\n| Rocky ground or shallow water || -10\n|-\n| Every two creatures in the group || +1\n|-\n| Every 12 hours since trail was made || -1\n|-\n| Every hour of rain, snow, or sleet || -5\n|-\n| Poor lighting (moon or starlight) || -6\n|-\n| Tracked party attempts to hide trail || -5\n|}\n\nFor example, if Thule's Wisdom score is 16 and he is trying to track through mud (+4), at night (-6), during a sleet storm (-5), his chance to track is 9 (16+4-6-5). (Thule is a ranger so he does not suffer the -6 penalty for non-rangers tracking.)\n\nFor tracking to succeed, the creature tracked must leave some type of trail. Thus, it is virtually impossible to track flying or noncorporeal creatures. The DM may allow this in rare instances, but he should also assign substantial penalties to the attempt.\n\nTo track a creature, the character must first find the trail. Indoors, the tracker must have seen the creature in the last 30 minutes and must begin tracking from the place last seen. Outdoors, the tracker must either have seen the creature, have eyewitness reports of its recent movement (\"Yup, we saw them orcs just high-tail it up that trail there not but yesterday.\"), or must have obvious evidence that the creature is in the area (such as a well-used game trail). If these conditions are met, a proficiency check is rolled. Success means a trail has been found. Failure means no trail has been found. Another attempt cannot be made until the above conditions are met again under different circumstances.\n\nOnce the trail is found, additional proficiency checks are rolled for the following situations:\n* The chance to track decreases (terrain, rain, creatures leaving the group, darkness, etc.).\n* A second track crosses the first.\n* The party resumes tracking after a halt (to rest, eat, fight, etc.).\n\nOnce the tracker fails a proficiency check, another check can be rolled after spending at least one hour searching the area for new signs. If this check is failed, no further attempts can be made. If several trackers are following a trail, a +1 bonus is added to the ability score of the most adept tracker. Once he loses the trail, it is lost to all.\n\nIf the modifiers lower the chance to track below 0 (for example, the modifiers are -11 and the character's Wisdom is 10), the trail is totally lost to that character and further tracking is impossible (even if the chance later improves). Other characters may be able to continue tracking, but that character cannot.\n\nA tracking character can also attempt to identify the type of creatures being followed and the approximate number by rolling a proficiency check. All the normal tracking modifiers apply. One identifying check can be rolled each time a check is rolled to follow the trail. A successful check identifies the creatures (provided the character has some knowledge of that type of creature) and gives a rough estimate of their numbers. Just how accurate this estimate is depends on the DM.\n\nWhen following a trail, the character (and those with him) must slow down, the speed depending on the character's modified chance to track as found from Table 39.\n\nIn the earlier example, Thule has a modified tracking chance of 9, so he moves at 1/2 his normal movement rate.\n\n{| class=\"article-table\"\n|+ Table 40: Movement While Tracking\n! Chance to Track\n! Movement Rate\n|-\n| 1-6 || 1/4 normal\n|-\n| 7-14 || 1/2 normal\n|-\n| 14 or greater || 3/4 normal\n|}\n\n## Player's Option: Skills & Powers\n\nTracking: The detailed tracking procedure described in the ''Player's Handbook is modified as follows for the Skills and Powers'' rules:\n\nNo characters suffer the integral –6 penalty to their ability scores; this difference is reflected in the proficiency rating itself.\n\nRangers gain a +5 bonus to their tracking rating.\n\nCharacters with the animal empathy trait gain +2 to their proficiency score when tracking non-domesticated animals.\n\nCharacters with the animal lore proficiency gain +2 to their proficiency rating when tracking animals—either wild or domesticated.\n\n## The Complete Thief's Handbook\n\nRequired: Bounty Hunter.\n\nRecommended: Assassin.\n\nThis proficiency is normally restricted to warriors. Its description is on p.&nbsp;64 of the ''Player's Handbook.''\n\n## Note from The Complete Ranger's Handbook\n\nMost rangers will have this proficiency in outdoor land terrain without spending any slots, as discussed in Chapter 2. Generally, success chances in urban, man-made, or aquatic terrains are halved, unless a specific kit description says otherwise. Some kits give tracking in alternative terrains instead of the usual outdoor land environment.\n\n## The Complete Barbarian's Handbook Modifications\n\nA barbarian automatically has the tracking proficiency in his homeland terrain (see Chapter 1). If he spends two slots, he acquires the tracking expertise of a ranger of equal level. Generally, his chance of success is halved in urban and man-made terrains.\n\n## Campaign Option: Council of Wyrms Setting\n\nTracking is described in the Player's Handbook. It allows a dragon to trail a creature through most types of terrain. Proficiency checks may be required to find trails, avoid losing trails, and to estimate the type and number of creatures being trailed. Tracking speed varies between one-quarter and three-quarters normal movement rate, depending on the overall chance to track.\n\nDragons use this proficiency as if they were rangers (without the -6 penalty).\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency2303: Proficiency = Proficiency(
    id: "trail_marking",
    name: "Trail Marking",
    wikiPageTitle: "Trail Marking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "By notching trees, scattering pebbles, piling stones, and clipping weeds, the character can mark a trail through any wilderness area.",
        fullText: "## The Complete Ranger's Handbook\n\nBy notching trees, scattering pebbles, piling stones, and clipping weeds, the character can mark a trail through any wilderness area. Providing he moves at 2/3 his normal movement rate, he can mark a continuous trail as long as he likes; however, the longer the trail, the less likely he'll be able to follow it back.\n\nA successful proficiency check enables a backtracking character to follow his own trail for a distance equal to his level in miles. If he fails a check, he loses the trail. For instance, assume a 3rd level character marked a 12-mile trail. His first successful proficiency check enables him to follow this trail back three miles. A second successful proficiency check means he can follow the trail another three miles. The third check fails, and he loses the trail; he's only been able to follow his trail for a total of six miles.\n\nThe tracking proficiency isn't necessary to use the trail marking proficiency. However, when a ranger loses his own marked trail, he may still attempt to follow it using his tracking proficiency. Any other characters with the tracking proficiency may also attempt to follow a ranger's marked trail, using the rules applicable to the tracking proficiency.\n\nA marked trail lasts unless it is obscured by precipitation, a forest fire, or the passage of time (an undisturbed trail marked in a forest should last for weeks, while an arctic trail may last less than a day during periods of heavy precipitation; the DM decides). A ranger or other character with the tracking proficiency may still attempt to follow an obscured trail using the tracking rules.\n\nCrossover Groups: Warrior."
    )
)

let embeddedProficiency2304: Proficiency = Proficiency(
    id: "trail_signs",
    name: "Trail Signs",
    wikiPageTitle: "Trail Signs (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior", "Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Inteligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency can read symbolic messages indicated by an arrangement of stones or other physical objects. The character must designate the method of leaving messages preferred by his family, tribe, or culture.",
        fullText: "## The Complete Ranger's Handbook\n\nA character with this proficiency can read symbolic messages indicated by an arrangement of stones or other physical objects. The character must designate the method of leaving messages preferred by his family, tribe, or culture. Typical methods include piling rocks, stacking branches, or building snow sculptures. When the character encounters such a message, he understands the meaning if he makes a successful proficiency check. (\"A dragon dwells in these woods.\" \"Eat the green berries for restored health.\") The message is meaningless to characters without the trail signs proficiency. A character with the trail signs proficiency who uses methods other than the one encountered can try to read it at half the normal chance for success. This proficiency can also be used to identify the cultural group or tribe that has left a specific trail sign.\n\nCrossover Groups: Warrior, Rogue."
    )
)

let embeddedProficiency2305: Proficiency = Proficiency(
    id: "trailing",
    name: "Trailing",
    wikiPageTitle: "Trailing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "Special",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Required: Assassin, Cutpurse.",
        fullText: "## The Complete Thief's Handbook\n\nRequired: Assassin, Cutpurse.\n\nRecommended: Beggar, Bounty Hunter, Investigator, Spy, Thug, Troubleshooter.\n\nTrailing resembles tracking, except tracking is associated chiefly with the wilderness, and trailing typically is used in major urban centers (i.e., cities and large towns). It is the talent of tailing someone—of keeping a certain distance or even catching up to them, though they may be attempting to blend into a crowd, or at least get lost in the confusion of a street full of people.\n\nA proficiency check is first made to see if the thief is able to trail without being noticed. If the person followed has the alertness proficiency, then the thief suffers a -5 penalty.\n\nIf the thief is noticed, the person being followed may attempt to evade. To keep from losing the trail, the thief must make another proficiency check. A modifier from -3 to +3 (varying from first time in a foreign city to the thief's home neighborhood) may be used, if the DM so chooses, to reflect how well the thief knows the area. Warn the player beforehand if you will apply modifiers (though you needn't tell exactly what they are).\n\nThe DM should feel free to use situational modifiers on these rolls. For example, if a street is relatively clear, the thief should get -1 or -2 on an attempt to follow unnoticed, but +1 or +2 if he has been seen and is chasing after his subject. The opposite numbers could be used for exceptionally crowded situations, or at night.\n\nFor any Trailing proficiency roll, a -3 penalty applies if the person followed has the Trailing proficiency as well (and, presumably, knows better how to foil the tricks of his own trade).\n\nExample: Julina is trailing an NPC through the Imperial capital, because she suspects that he is spying for a rival employer and has information that would be valuable for her. It is nighttime, on a nearly deserted street. The DM informs Julina of this, and says that she'll have trouble going unnoticed (-2 modifier on her first roll, he rules, but does not tell her); but if her quarry does spot her, he'll be easier to chase (+2). The DM also decides that Julina has been in the capital on this job long enough that she's fairly familiar with the streets and alleys, so she will not suffer a penalty on that account. However, unbeknownst to Julina, the spy she follows has both alertness (-5 modifier) and trailing proficiencies (-3 modifier). This means that her first roll has an adjustment of -10; if it fails, the second will have an adjustment of -6. Julina's Dexterity is 17. She needs to roll 7 or lower on her first roll, but gets a 13 and fails. \"The man has spotted you,\" says the Dungeon Master. \"He speeds up and ducks around a corner, into an alley.\" Julina follows; to keep from losing him, she needs to get an 11 or lower. She rolls an 11, just barely making it. \"The alley is empty—you are about to rush through to the next street, but through a window you spot a flash of red, like the man's coat, and hear footsteps up a staircase in the building to your right.\""
    )
)

let embeddedProficiency2306: Proficiency = Proficiency(
    id: "trance",
    name: "Trance",
    wikiPageTitle: "Trance (Proficiency)",
    redirectAliases: ["SB Table 6"],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Constitution",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency may access the knowledge and memories of predecessors— tutors, the tutor's tutor, and so-on, back to the first shaman of their line or priest of the religion.",
        fullText: "A character with this proficiency may access the knowledge and memories of predecessors— tutors, the tutor's tutor, and so-on, back to the first shaman of their line or priest of the religion.\n\nThis means that a character can find the correct solution to any doctrinal or historical question, as if he or she had every proficiency on the shaman proficiency list. Each time that the trance proficiency is used, the answer to one question may be sought—anything from \"where was the boundary of the tribe's lands originally?\" to \"what are the weaknesses of the Jendahla Spirit?\" but only concerning matters known to past generations. A trance cannot be used to discover facts about the recent past, the present, or the future, or knowledge beyond the ken of previous shamans.\n\nTo delve back into the memories of past generations is not, however, without risks. There is a chance that the character will pick up prejudices, ideas, half-memories and idiosyncrasies from the predecessors whose memories he or she has accesses. In extreme cases, the shaman might develop dual personalities, or loose his or her own memory entirely.\n\nIf a player rolls a natural 20 while attempting to use this proficiency, the DM should roll 2d6 and consult the following table for effects to the character's mind. The resulting conditions cannot be removed by any magic less than a wish spell: the character is fundamentally altered, not just magically influenced. Encourage the player to roleplay the new character's quirks.\n\n{| class=\"article-table\"\n|+ Table 6: Failed Trance Results\n| 2-3: || No adverse effect.\n|-\n| 4: || The shaman develops a strong prejudice or hatred, consistent the attitude of ancient peoples: this may be an old-fashioned view of women (\"beat your wife if she disobeys you!\") or children (\"should be seen and not heard\"), or might involve a refusal to participate in \"new\" customs or practices (like trade with outsiders or listening to music).\n|-\n| 5: || trade with outsiders or listening to music). The shaman gains a firm belief that a certain historical person still lives. This figure be a legendary shaman, the current king's grandfather, a villain of folklore, or similar. If through proof or persuasion this conviction is disproved, the character receives a saving throw vs. paralyzation. If the save is failed, the character forgets the evidence, and is deluded again by the following morning. If the save is successful, the character's original knowledge is restored.\n|-\n| 6: || As above, but the character becomes convinced that a whole political structure, now extinct, still survives. This may be a now extinct clan, a royal family, an evil cult, an order of paladins, and so on.\n|-\n| 7: || The character becomes obsessed with achieving a certain goal, which was achieved or has been irrelevant for centuries, such as defeating a now-friendly \"enemy,\" recovering a lost relic, protecting an extinct family, and so on. No evidence can convince the character that this goal is futile.\n|-\n| 8: || The character gains an antiquated sense of the geography of his or her home region, functioning as though the character has the ancient geography nonweapon proficiency, but believing it's the way things are now. He or she remembers everything within one mile as it would have been generations ago—roads and buildings (or lack of them),: steams and ponds, and so on. The current geography of places that he or she knows can be relearned at the expenditure of a skill slot on the geography nonweapon pro-i ficiency, but until this is done, the character will always be lost and confused in such areas. (If the character already had skills lots devoted to geography, these are lost, and replaced with the ancient geography proficiency.)\n|-\n| 9: || As 4-5, but the character now believes that he or she is living under the rule of several centuries ago, believing that the royal family and shamans, warriors and administrators now living are those who ruled all those years ago. He or she cannot be dissuaded of this delusion for longer than one turn.\n|-\n| 10-12 || The character loses his or her memory entirely, and instead remembers the world as' it was several hundred years ago—the geography, politics, important people, everything. If changes are explained, the character will remember and try to understand them, but it will be some time before he or she can relate to the world again.\n|}"
    )
)

let embeddedProficiency2307: Proficiency = Proficiency(
    id: "tribal_lore",
    name: "Tribal Lore",
    wikiPageTitle: "Tribal Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Intelligence",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Tribal Lore is roughly equivalent to Ancient History but deals only with a specific tribal people. A character with this proficiency has knowledge of the specific tribe's genealogies, legends, and laws.",
        fullText: "## Dragon Magazine #247\n\nTribal Lore is roughly equivalent to Ancient History but deals only with a specific tribal people. A character with this proficiency has knowledge of the specific tribe's genealogies, legends, and laws. A successful proficiency check enables the character to recall obscure bits of tribal lore not considered “common knowledge.”"
    )
)

let embeddedProficiency2308: Proficiency = Proficiency(
    id: "trick",
    name: "Trick",
    wikiPageTitle: "Trick (Proficiency)",
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
        briefSummary: "Trick is the ability to create a diversion to confuse and fluster an opponent. A trick can be as simple a ploy as shouting, \"Look, over there!\" In the round when a dragon decides to attempt a trick, that is the only action it performs.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nTrick is the ability to create a diversion to confuse and fluster an opponent. A trick can be as simple a ploy as shouting, \"Look, over there!\" In the round when a dragon decides to attempt a trick, that is the only action it performs.\n\nIf a dragon wins initiative and makes a successful proficiency check, the trick works. Its opponent cannot act this combat round, and in the next round it acts after the tricking dragon. A failed check means the trick backfires, causing the tricking dragon to act after all other opponents in the next combat round. A natural 20 means the dragon loses all actions in the next combat round, and loses initiative in the round after that. The opponent's Intelligence score modifies the check.\n\n{| class=\"article-table\"\n! Opponent's\nIntelligence || Modifier\n|-\n| 3 or less || +5\n|-\n| 4-5 || +3\n|-\n| 6-8 || +l\n|-\n| 9-1 1 || 0\n|-\n| 12-13 || -1\n|-\n| 14-15 || -2\n|-\n| 16-17 || -3\n|-\n| 18 || -4\n|-\n| 19 || -5\n|-\n| 20+ || -7\n|}"
    )
)

let embeddedProficiency2309: Proficiency = Proficiency(
    id: "tumbling",
    name: "Tumbling",
    wikiPageTitle: "Tumbling (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue", "Barbarian"],
        slotsRequired: 1,
        rawSlots: "1 Slot (2 Slot Barbarian)",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Dexterity/Balance, Strength/Muscle",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character is practiced in all manner of acrobatics—dives, rolls, somersaults, handstands, flips, etc. Tumbling can only be performed while burdened with light encumbrance or less.",
        fullText: "## Player's Handbook\n\nThe character is practiced in all manner of acrobatics—dives, rolls, somersaults, handstands, flips, etc. Tumbling can only be performed while burdened with light encumbrance or less. Aside from entertaining, the character with tumbling proficiency can improve his Armor Class by 4 against attacks directed solely at him in any round of combat, provided he has the initiative and foregoes all attacks that round. When in unarmed combat he can improve his attack roll by 2.\n\nOn a successful proficiency check, he suffers only one-half the normal damage from falls of 60 feet or less and none from falls of 10 feet or less. Falls from greater heights result in normal damage.\n\n## Player's Option: Skills & Powers\n\nTumbling: Characters with this proficiency can roll, somersault, stand on their hands, flip forward and backward, and otherwise perform feats of acrobatics. They can only perform tumbling feats if unencumbered or lightly encumbered.\n\nTumbling characters can improve their AC by 4 on a given round if: they avoiding attacks directed against them, win initiative, and elect not to attack that round. A tumbling character can move up to 20 feet, or remain in one place, during the course of this evasion. In unarmed combat a character with tumbling ability improves attack rolls by +2.\n\nThe character can attempt to dodge through obstacles or escape through narrow apertures, but successful proficiency checks are required. If the character topples from a height of 60 feet or less, a successful proficiency check results in suffering only half damage from the fall.\n\n## The Complete Barbarian's Handbook Modifications\n\nIn most cases, a barbarian won't use the tumbling proficiency for entertainment purposes. Instead, he uses it to elude and confuse enemies. He gains the Armor Class improvements, attack roll bonuses, and damage reductions from falls described in the ''Player's Handbook''."
    )
)

let embeddedProficiency2310: Proficiency = Proficiency(
    id: "undead_knowledge",
    name: "Undead Knowledge",
    wikiPageTitle: "Undead Knowledge (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with Undead Knowledge is well versed in the lore of undead creatures, including ghosts, wraiths, zombies, and (in the land of Zakhara) ghuls.",
        fullText: "## The Complete Sha'ir's Handbook\n\nA character with Undead Knowledge is well versed in the lore of undead creatures, including ghosts, wraiths, zombies, and (in the land of Zakhara) ghuls. This proficiency may be used in determining probable lairs, dining habits, and history of such creatures. In the Land of Fate, this proficiency is used by necromancers and the secretive ghul lords. Open possessors of this proficiency are viewed with alarm."
    )
)

let embeddedProficiency2311: Proficiency = Proficiency(
    id: "undead_lore",
    name: "Undead Lore",
    wikiPageTitle: "Undead Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Undead Lore: A priest with this proficiency is trained in the identification, powers, and vulnerabilities of common undead monsters.",
        fullText: "Undead Lore: A priest with this proficiency is trained in the identification, powers, and vulnerabilities of common undead monsters. With a proficiency check, the character can recall specific tactics or weaknesses of a monster; for example, if confronted by a vampire, he may recall that a mirror, garlic, or holy symbol strongly presented can drive the monster away for a short time. How the character uses this information is up to the player."
    )
)

let embeddedProficiency2312: Proficiency = Proficiency(
    id: "underclass",
    name: "Underclass",
    wikiPageTitle: "Underclass (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Underclass: This proficiency imparts an understanding of the way the underclass—the combination of poorer classes and criminal elements—works in a society.",
        fullText: "Underclass: This proficiency imparts an understanding of the way the underclass—the combination of poorer classes and criminal elements—works in a society. The character with this proficiency can roll an Underclass check to learn things about the underworld of any community he visits. The DM should assign time and check penalties based on cultural differences and the sensitivity of the information the character seeks. Attempting to buy an illegal weapon would take about an hour and result in a check penalty of 0 or –1. Looking for the secret hideout of the local master of crime might take weeks and would impose a penalty of –8 or worse."
    )
)

let embeddedProficiency2313: Proficiency = Proficiency(
    id: "underground_navigation",
    name: "Underground Navigation",
    wikiPageTitle: "Underground Navigation (Proficiency)",
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
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency can determine direction underground and the shortest route to the surface. By careful analysis of air currents and contents, a character can even determine whether there are any pockets of poisonous gas in the air.",
        fullText: "## The Complete Book of Dwarves\n\nA character with this proficiency can determine direction underground and the shortest route to the surface. By careful analysis of air currents and contents, a character can even determine whether there are any pockets of poisonous gas in the air. A successful proficiency check is required to use the proficiency."
    )
)

let embeddedProficiency2314: Proficiency = Proficiency(
    id: "underwater_combat",
    name: "Underwater Combat",
    wikiPageTitle: "Underwater Combat (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior", "Rogue"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: nil,
            characterPointCost: 4,
            baseRating: "0"
        ),
    description: ProficiencyDescription(
        briefSummary: "Adventurers traveling through strange undersea environments need not go without defenses. Characters can become proficient in underwater combat and master practical fighting styles that prove effective in a marine environment.",
        fullText: "## Of Ships and the Sea\n\nAdventurers traveling through strange undersea environments need not go without defenses. Characters can become proficient in underwater combat and master practical fighting styles that prove effective in a marine environment. Through extensive training, proficient PCs learn to compensate for the inexorable pull of underwater currents and the resistance of water to the motion of weapons.\n\nCharacters with the Underwater Combat proficiency only add 2 to their initiative rolls and suffer only a -2 penalty to their attack rolls. The proficiency costs two proficiency slots and is available under the Rogue and Warrior proficiency groups. Its relevant ability is Dexterity. Adventurers who fill four proficiency slots with Underwater Combat may add their combat bonuses (attack, damage, and extra attacks) for a single level of weapon specialization (assuming the character is already specialized). However, under no circumstances can characters add the effects of double specialization or weapons mastery to their attack and damage rolls.\n\nFor those players using PLAYERS OPTION®: Skills & Powers characters, Underwater Combat costs four character points (or eight points to allow the use of one level of weapon specialization underwater). In addition, its relevant subabilities are Muscle and Balance. It has no initial rating.\n\n## Sea of Fallen Stars\n\nCharacters can become proficient in underwater combat and master practical fighting styles that prove effective in a marine environment. Through extensive training, proficient PCs leam to compensate for the inexorable pull of underwater currents and the resistance of water to the motion of weapons.\n\nSurface-born characters with the Underwater Combat proficiency only add a +2 penalty to initiative rolls and suffer -2 penalties to their attack rolls. The proficiency costs two slots and is available under the Rogue and Warrior proficiency groups. Its relevant ability is Dexterity. Aquatic characters do not need to leam this proficiency as their environment dictates this style of combat as natural. (In the same way, surface characters have no \"surface combat\" proficiency; it's simply the normal style for such an environment."
    )
)
