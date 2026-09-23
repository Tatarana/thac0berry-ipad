import Foundation

/// Parte 3 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency0300: Proficiency = Proficiency(
    id: "astral_tracking",
    name: "Astral Tracking",
    wikiPageTitle: "Astral Tracking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition",
            characterPointCost: 4,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "Similar to astral navigation in ways that normal tracking and navigational skills never are, this skill also utilizes the unnamed astral energies of the plane.",
        fullText: "Similar to astral navigation in ways that normal tracking and navigational skills never are, this skill also utilizes the unnamed astral energies of the plane. With astral tracking, the path of a creature can be found and followed through the strange environs of the plane. A body can determine only the race of the maker of the \"tracks\" using this proficiency, but no other special information"
    )
)

let embeddedProficiency0301: Proficiency = Proficiency(
    id: "astrology",
    name: "Astrology",
    wikiPageTitle: "Astrology (Proficiency)",
    redirectAliases: ["Astology (Proficiency)"],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition, Intelligence/Knowledge",
            characterPointCost: 3,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency gives the character some understanding of the supposed influences of the stars.",
        fullText: "## Player's Handbook\n\nThis proficiency gives the character some understanding of the supposed influences of the stars. Knowing the birth date and time of any person, the astrologer can study the stars and celestial events and then prepare a forecast of the future for that person. The astrologer's insight into the future is limited to the next 30 days, and his knowledge is vague at best. If a successful proficiency check is made, the astrologer can foresee some general event—a great battle, a friend lost, a new friendship made, etc. The DM decides the exact prediction (based on his intentions for the next few gaming sessions). Note that the prediction does not guarantee the result—it only indicates the potential result. If the proficiency check is failed, no information is gained unless a 20 is rolled, in which case the prediction is wildly inaccurate.\n\nClearly this proficiency requires preparation and advance knowledge on the part of the DM. Because of this, it is permissible for the DM to avoid the question, although this shouldn't be done all the time. Players who want to make their DM's life easier (always a good idea) should consider using this proficiency at the end of a gaming session, giving the DM until the next session to come up with an answer. The DM can use this proficiency as a catalyst and guide for his adventures—something that will prompt the player characters to go to certain places or to try new things.\n\nCharacters with the astrology proficiency gain a +1 bonus to all navigation proficiency checks, provided the stars can be seen.\n\n## Player's Option: Skills & Powers\n\nThis character has a general understanding of the movement of celestial bodies, and the influence of that movement upon the beings of the campaign world. The astrologer can identify numerous constellations, and knows many of the legends behind their naming. The character can make limited predictions for the future, always in vague terms—whether these are accurate is up to the DM. A character with this proficiency gains +2 on all checks made using the navigation proficiency, providing the stars can be seen. A character with the trait of empathy gains a +1 bonus to the astrology proficiency rating.\n\n## The Complete Book of Dwarves\n\nAstrology is only available to dwarves who live on or near the surface of the world. Deep dwarves and others who do not have easy access to the surface do not have the astrology proficiency. In order to use astrology, you have to see the stars.\n\n## Campaign Option: Council of Wyrms Setting\n\nThis proficiency is identical to the one described in the AD&D Player's Handbook: It allows preparation of a horoscope giving a 30-day forecast of general events. A failure means no information is gained, while a roll of 20 is a wildly inaccurate prediction. Dragons believe that the will of their gods, especially Io, can be seen in the activity of the stars. Dragon-priests often take this proficiency as part of their repertoires. The +1 bonus to Navigation checks (if the stars are visible) is especially useful when dragons head off on long flights. Hatchlings can't select this proficiency."
    )
)

let embeddedProficiency0302: Proficiency = Proficiency(
    id: "astronomy",
    name: "Astronomy",
    wikiPageTitle: "Astronomy (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "N/A",
        relevantAbility: "N/A",
        checkModifier: 0,
        rawModifier: "N/A",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge",
            characterPointCost: 2,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "Astronomy: A character proficient in this skill has a detailed knowledge of the relative movement of stars, moons, and planets.",
        fullText: "Astronomy: A character proficient in this skill has a detailed knowledge of the relative movement of stars, moons, and planets. The character can predict with complete accuracy the arrival of eclipses, comets, and other cosmic phenomena (evening and morning stars, full moons, etc.) The astronomer can identify numerous stars and constellations, and gains a +3 bonus to all checks made using the navigation proficiency, providing that the stars can be seen."
    )
)

let embeddedProficiency0303: Proficiency = Proficiency(
    id: "athletics",
    name: "Athletics",
    wikiPageTitle: "Athletics (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Athletics: Characters with athletics are naturally talented in one particular area of athletic endeavor used in the Olympic games.",
        fullText: "## Age of Heroes Campaign Sourcebook\n\nAthletics: Characters with athletics are naturally talented in one particular area of athletic endeavor used in the Olympic games. These include foot races, horse races, javelin, discus, chariots, standing high jump, broad jump, and pancratium (combined boxing and wrestling). Only the nonmilitary gaming aspect of these activities is emphasized.\n\nThis ability may be taken more than once to improve in a category or to acquire skill in a different area. For those areas which are covered under other proficiencies, such as charioteering, an athletics proficiency in the same area provides a +1 to that proficiency check."
    )
)

let embeddedProficiency0304: Proficiency = Proficiency(
    id: "awareness",
    name: "Awareness",
    wikiPageTitle: "Awareness (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior", "Rogue"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters with the awareness proficiency are light sleepers, always alert to danger and attuned to their immediate surroundings. They gain two key advantages:",
        fullText: "Characters with the awareness proficiency are light sleepers, always alert to danger and attuned to their immediate surroundings. They gain two key advantages:\n\nFirst, if they're roused from slumber (during an attack at night, for example), they can react immediately, as if they had been awake. Provided a weapon is close at hand (a jambiya placed beneath the pillow, for instance), they can even attack during the round in which they awaken. No proficiency check is required. This ability does not affect magical slumber, however, such as that created by a sleep spell or related magicks.\n\nSecond, characters with the awareness proficiency can detect and ward off the effects of a thief's backstabbing ability. If a thief is backstabbing a target with the awareness ability, and the target is otherwise uninvolved in combat, then the target is granted a proficiency check. If the check fails, the backstabbing occurs normally. If the check succeeds and the target does not have initiative, the backstabbing proceeds, but the thief suffers a -2 attack penalty (damage bonuses still apply). If the check succeeds and the target has initiative, the target can wheel and attack the backstabbing rogue immediately, causing the rogue to lose all backstabbing bonuses and damage multipliers."
    )
)

let embeddedProficiency0305: Proficiency = Proficiency(
    id: "ayuveda",
    name: "Ayuveda",
    wikiPageTitle: "Ayuveda (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Ayuveda  Intelligence-2",
        fullText: "Ayuveda  Intelligence-2\n\nPriest, Wizard.\n\n1 Slot\n\nAyuveda herbalism aids in the diagnosis and cure of biological infestations. Lice, tapeworms, and other parasitic organisms can be identified with a successful Ayuveda proficiency check, which garners a +1 bonus if the healer also knows the Astrology proficiency.\n\nAyuveda\n\nDeveloped in India five millennia ago, Ayuveda is a complex form of natural medicine. Ayuveda, meaning knowledge (ayur) of life (veda), uses the principle of three metabolic body types or doshas. An individual's constitution is the sum of the dosha types of Kapha, Pitta, and Vata.\n\nTreatment is designed based on the patient's constitutional make up and its imbalances in doshas to re-establish harmony. Treatments include diet, yoga exercises, massage, herbal tonics, and medicated inhalations."
    )
)

let embeddedProficiency0306: Proficiency = Proficiency(
    id: "bargain",
    name: "Bargain",
    wikiPageTitle: "Bargain (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character who has the bargain proficiency can haggle over monetary, service, and barter transactions to gain a better deal, as follows:\n* In a monetary transaction, a successful check allows the character to purchase an item for 10% less or sell one for 10% more than the going rate.",
        fullText: "## Dark Sun Campaign Setting Revised\n\nA character who has the bargain proficiency can haggle over monetary, service, and barter transactions to gain a better deal, as follows:\n* In a monetary transaction, a successful check allows the character to purchase an item for 10% less or sell one for 10% more than the going rate.\n* In a simple barter transaction, a successful check improves the perceived value of the bargainer's goods by 10%. In a protracted barter, a successful check allows the bargainer to roll 3d6 instead of 2d6 for that round of barter; a separate check initiates every round. (Simple and protracted barter are fully explained in Chapter 3: Money and Equipment.)\n* In a service transaction, a successful check provides the bargainer 10% more than the going rate for his services.\n\nThe DM should require players to role-play the bargaining session to gain the benefits of this proficiency"
    )
)

let embeddedProficiency0307: Proficiency = Proficiency(
    id: "bartering",
    name: "Bartering",
    wikiPageTitle: "Bartering (Proficiency)",
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
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency, which simulates an expertise in trading and appraising, has two applications:",
        fullText: "This proficiency, which simulates an expertise in trading and appraising, has two applications:\n\nValue Check. With a successful proficiency check, the character can access the approximate value of a common item (a spear, a chicken, a bag of rice). The proficiency only works on items with an actual value of 50 gp or less. It does not work on magical items. A character may make only one attempt per item.\n\nThe DM makes the proficiency check in secret. If the check fails, the character receives no special information. If the check succeeds, he has correctly determined the value of the item within 10%. (Tell the player the value of the item, plus or minus 10%, or gives him a range within these values. For instance, if the actual cost of a small canoe is 30 gp and the check succeeds, any of the following responses are appropriate: \"about 27 gp,\" \"somewhere between 28 and 30 gp,\" \"close to 33 gp.\") On a natural roll of 1, the character has assessed the exact price. On a roll of 20, the assessment is wildly inaccurate (the DM might tell the player that a 30 gp canoe is worth 50 gp, somewhere between 1-5 gp, or nothing at all). Note that value of an object may be different from the asking price; the seller is free to set prices as he sees fit.\n\nDiscount Check. This proficiency can also help the character purchase items at bargain prices through intimidation, stubbornness, and sheer force of personality. The character must indicate a particular item (worth 50 gp or less) and make a proficiency check. If the check succeeds, the character may buy the item at up to 20% less than the asking price. The DM determines the discount (between 10-20%); if he prefers, he may determine the discount randomly (roll 1d4 and multiply the result by 5%). If the check fails, the buyer receives no special benefit from the proficiency (he may still purchase the item at the asking price). On a natural roll of 1, the buyer receives a 30-50% discount (DM's discretion). On a roll of 20, the seller becomes offended by the buyer's attitude and refuses to sell anything at all to him.\n\nOnly one discount check may be made per item. However, both a value check and a discount check may be made on the same item (the discount check may be made regardless of the outcome of the value check).\n\nBarbarians: Whenever practical, values should be expressed in a medium of exchange used in the barbarian's homeland. If a barbarian commonly trades bobcat furs (worth 2 gp each) and correctly determines the value of a small canoe (worth 30 gp), the DM might tell him the canoe is worth \"about 15 bobcat furs\" or \"between 14 and 16 bobcat furs.\" If he makes a successful discount check, and the DM decides to give him a 20% discount, the canoe will cost him 12 furs. Fractional values should be resolved in favor of the seller; if the barbarian receives a 30% discount on a 30 gp canoe (for a final price of 21 gp), the canoe will cost him 11 furs (valued at 22 gp).\n\nCrossover Group: Rogue."
    )
)

let embeddedProficiency0308: Proficiency = Proficiency(
    id: "begging",
    name: "Begging",
    wikiPageTitle: "Begging (Proficiency)",
    redirectAliases: ["CTH Table 1", "CTH Table 2", "SB Table 5"],
    primaryGroup: "Rogue",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["General (Rogue - Thief's Handbook", "Shaman", "Arabian Adventures)"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "Special (+0 - Arabian Adventures)",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Required: Beggar.",
        fullText: "## The Complete Thief's Handbook\n\nRequired: Beggar.\n\nRecommended: Assassin, Bounty Hunter, Burglar, Cutpurse, Spy.\n\nThis proficiency serves two functions. First, it allows the character to pose convincingly as a beggar; success is automatic, so no proficiency check needs to be made. This function is used most by Assassins, Bounty Hunters and Spies in the pursuit of their assignments.\n\nA character can also use begging to procure a very minimal daily income. (Many Cutpurses are in fact beggars who aren't getting enough-and vice versa.) Success requires first that there be people to beg from-people with money to give. A character in an abandoned castle or a recently pillaged village are virtually assured of failure.\n\nThe following modifiers are suggested to the DM as guidelines. They do not consider the wealth of a locale, just the population density. Impoverished regions might have greater negative modifiers-but then, so might affluent areas with traditions of stinginess.\n\n{| class=\"article-table\"\n|+ Table 2: Suggested Begging Modifiers'''\n! Locale || Modifier\n|-\n| Uninhabited/\nWilderness || Automatic Failure\n|-\n| Countryside || -7\n|-\n| Hamlet, Village || -5\n|-\n| Town || -2\n|-\n| City || 0\n|}\nIf a proficiency check is successful, then a character is able to panhandle enough money, goods or services that day to meet his basic needs (a little food and drink, a place to sleep).\n\nThe DM may also use the proficiency check for specific single actions-e.g., a character in disguise as a beggar accosts a specific NPC.\n\nThe begging proficiency may not be used to force player characters to give money away; players are always free to decide if and how generous their characters are in response to supplications.\n\n## The Complete Book of Humanoids\n\nBegging serves two functions. First, it allows characters to pose convincingly as beggars (and many humanoids in civilized areas spend some time begging for a living). Success in this function is automatic and no checks must be made. Second, it allows the character to earn a minimal daily income. To use this proficiency to earn money, it must be used in an area where people are present.\n\nThe following modifiers are suggested to the DM as guidelines. They do not take into account the wealth of a particular locale, just the population density. Impoverished regions might have greater negative modifiers, as might certain affluent areas with long traditions or great reputations for stinginess.\n\n{| class=\"article-table\"\n|+ Begging Modifiers\n! Locale || Modifier\n|-\n| Uninhabited /Wilderness || Failure\n|-\n| Countryside || -7\n|-\n| Hamlet, Village || -5\n|-\n| Town || -2\n|-\n| City || 0\n|}\n\nA successful check enables a character to beg for enough money, goods or services to meet his basic needs (a little food and drink, a place to sleep). Begging cannot force PCs to give away money. Players are always free to decide how generous their characters are.\n\n## Arabian Adventures\n\nCharacters with this proficiency can pose as convincing beggars and procure food, spare change, and the like. While beggars never become rich, each successful use of this proficiency results in enough money to meet a character's basic needs at the squalid state for a single day (see Table 22 in Chapter 6 of the DMG). Nonplayer characters always fork over a little something to successful beggars. Player characters are never affected by this ploy; they respond to characters with the begging proficiency as they see fit.\n\nThis proficiency enables characters to pose as beggars automatically; their real status is disguised. A proficiency check determines whether a character actually receives any money or food. Characters who beg from the same NPC more than once suffer a -2 cumulative modifier for each attempt after the first. Location also modifies the proficiency check. In small towns, beggars incur a -2 penalty, and along trade routes the penalty becomes-5. Attempts to use the begging proficiency fail automatically in the wilderness, in the desert, and at sea. No penalty applies for begging in a city.\n\nBegging is not a good way to become rich or powerful. It can, however, prove useful as a masquerade. Characters who wish to be \"invisible\" know that beggars are often ignored in public. In a crowded square, a bum either blends in or becomes a faceless annoyance, much like a droning fly. However, even flies should pick their hangouts carefully. In the wrong spot, such as a palace court, such insects risk being cast out or bruskly swatted.\n\n## Shaman\n\nThis proficiency allows traveling or otherwise displaced shamans to procure a very minimal daily income. Success requires that there be people to beg from—people with money to give. A shaman attempting to beg in a recently pillaged village or an abandoned fortress is assured of failure, regardless of how well he rolls on the proficiency check.\n\nThe following modifiers are suggested to the DM as guidelines. They do not consider the wealth of the locale, just the population density. Impoverished regions might have greater negative modifiers—but then so might affluent areas with traditions of stinginess.\n\n{| class=\"article-table\"\n|+ Table 5. Suggested Begging Modifiers\n! Locale || Modifier\n|-\n| Uninhabited || Automatic Failure\n|-\n| Countryside || -7\n|-\n| Hamlet, Village || -5\n|-\n| Town || -2\n|-\n| City || 0\n|-\n| Believers /followers of spirits\nthat are served by shaman || +2\n|}\n\nIf a proficiency check is successful, the character is able to panhandle enough money, goods, or services that day to meet his basic needs. (A little food and drink, and a place to sleep.)\n\nThe begging proficiency should not be used to force player characters to give away money; players are always free to decide if and how generous their characters are in response to supplications.\n\n## A Mighty Fortress Campaign Sourcebook\n\nBegging: (1 slot, Charisma, rogue group)\n\nThis proficiency was introduced in The Complete Thief's Handbook. It enables a character to procure just enough food or money to get by for a day. It won't pay for his lodging or buy new clothes but it will put food in his stomach and occasionally get him a used tunic and some threadbare hose.\n\nModifiers apply to the proficiency check depending on where the character is begging.\n\nAreas with few people are bad choices for begging. Crowded cities are the best locales.\n\n{| class=\"article-table\"\n| City || no modifier\n|-\n| Town || -2 penalty\n|-\n| Hamlet, village || -5 penalty\n|-\n| Countryside || -7 penalty\n|-\n| Wilderness || automatic failure\n|}\n\nAny character with begging proficiency can also pose as a beggar. This requires no proficiency check.\n\nMany beggars during Elizabethan times carried some sort of testament to their ill fortune to prove that they were not just idlers. This could be a deed indicating that the beggar's ship was lost at sea, or military discharge papers, or a letter from a burgomeister testifying that the character's business burned down. Possessing such papers gives the character a +2 bonus on his begging proficiency check. Officers of the law will inspect such papers very carefully, however, looking for forgeries or any other reason to hustle the beggar out of the county."
    )
)

let embeddedProficiency0309: Proficiency = Proficiency(
    id: "blacksmithing",
    name: "Blacksmithing",
    wikiPageTitle: "Blacksmithing (Proficiency)",
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
            subAbility: "Strength/Muscle, Intelligence/Knowledge",
            characterPointCost: 4,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with blacksmithing proficiency is capable of making tools and implements from iron. Use of the proficiency requires a forge with a coal-fed fire and bellows, as well as a hammer and anvil.",
        fullText: "## Player's Handbook\n\nA character with blacksmithing proficiency is capable of making tools and implements from iron. Use of the proficiency requires a forge with a coal-fed fire and bellows, as well as a hammer and anvil. The character cannot make armor or most weapons, but can craft crowbars, grappling hooks, horseshoes, nails, hinges, plows, and most other iron objects.\n\n## Player's Option: Skills & Powers\n\nA character with the blacksmithing proficiency can handle a forge, bellows, hammer and tongs, to create tools and other objects out of iron. The character cannot make weapons or armor, but can make—without a proficiency check—simple items such as horseshoes, nails, brackets and buckles. By making a successful proficiency check, the character can create intricate objects such as wire cages and locks. A blacksmith can make an iron hoop for a wheel that has been made by a carpenter; this combination of proficiencies is required for a strong wheel."
    )
)

let embeddedProficiency0310: Proficiency = Proficiency(
    id: "blast_feedback",
    name: "Blast Feedback",
    wikiPageTitle: "Blast Feedback (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Caradhaker Only"],
        slotsRequired: 4,
        rawSlots: "4 slots",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "In non-psionic campaigns, the mental disciplines of the mindstalkers take the form of “evolved proficiencies.” Of course, these proficiencies are much more expensive than usual and thus not easily acquired.",
        fullText: "## Dragon Magazine #230\n\nIn non-psionic campaigns, the mental disciplines of the mindstalkers take the form of “evolved proficiencies.” Of course, these proficiencies are much more expensive than usual and thus not easily acquired. Furthermore, if a mindstalker in a non-psionic campaign takes even one of these evolved proficiencies, he or she immediately accrues the Constitution penalty described above under special hindrances in the mindstalker kit.\n\nThis evolved proficiency is useful only against an illithid's mind blast—it has no effect against other illithid special powers. When a Mindstalker with this proficiency falls victim to a mind blast, a successful proficiency check for Blast feedback triggers deeply ingrained neuronal pathways in the caradhaker that sets up a feedback loop with the individual illithid that first attacked. Blast feedback doesn't trigger unless the mind blast penetrates the victim's higher brain centers—a Mindstalker that successfully used the lucid buffer proficiency cannot use this power, but a failed lucid buffer proficiency check still allows blast feedback to be used. Basically, the illithid's own power is redirected back at it, catching the mind flayer in its own mind blast! All creatures normally affected by the blast, including the individual with this proficiency, are stunned for 3d4 rounds (as is standard); however, the attacking illithid suffers the same effect."
    )
)

let embeddedProficiency0311: Proficiency = Proficiency(
    id: "blind_fighting",
    name: "Blind-fighting",
    wikiPageTitle: "Blind-fighting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue", "Warrior"],
        slotsRequired: 2,
        rawSlots: "2 Slots 1 Slot for Dwarves",
        relevantAbility: "N/A",
        checkModifier: 0,
        rawModifier: "N/A",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition, Dexterity/Balance",
            characterPointCost: 4,
            baseRating: "NA/6"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with blind-fighting is skilled at fighting in conditions of poor or no light (but this proficiency does not allow spell use).",
        fullText: "## Player's Handbook\n\nA character with blind-fighting is skilled at fighting in conditions of poor or no light (but this proficiency does not allow spell use). In total darkness, the character suffers only a -2 penalty to his attack roll (as compared to a -4 penalty without this proficiency). Under starlight or moonlight, the character incurs only a -1 penalty. The character suffers no penalties to his AC because of darkness.\n\nFurthermore, the character retains special abilities that would normally be lost in darkness, although the effectiveness of these are reduced by one-half (proficiency checks are made at half the normal score, etc.). This proficiency is effective only against opponents or threats within melee distance of the character. Blind-fighting does not grant any special protection from missile fire or anything outside the immediate range of the character's melee weapon. Thus, AC penalties remain for missile fire. (By the time the character hears the whoosh of the arrow, for example, it is too late for him to react.)\n\nWhile moving in darkness, the character suffers only half the normal movement penalty of those without this proficiency.\n\nFurthermore, this skill aids the character when dealing with invisible creatures, reducing the attack penalty to -2. However, it does not enable the character to discover invisible creatures; he has only a general idea of their location and cannot target them exactly.\n\n## Player's Option: Skills & Powers\n\nThis allows characters to ignore many of the problems inherent in fighting without being able to see. In total darkness, the character suffers –2 (not –4) to attack rolls, and suffers no penalties to AC versus melee attacks. In starlight or moonlight, the character suffers only a –1 penalty to attack rolls.\n\nWhen moving in darkness, the character is allowed to make a proficiency check at the beginning of a round; success means no movement penalties are assessed because of the darkness, while failure means the normal penalty applies.\n\nWhen in combat with an invisible creature, the character with blind-fighting proficiency suffers only a –2 to attack rolls, but gains no benefit toward discovering the creature.\n\n## The Complete Book of Dwarves\n\nBlind-fighting is cheaper for dwarves; they only gain the benefit when fighting invisible opponents. Their inherent infravision allows them to fight effectively, even in total darkness.\n\n## The Complete Book of Humanoids\n\nSee the Player's Handbook for full details on this proficiency. In general terms, this proficiency reduces the penalty for fighting while blinded from -4 to -2. It similarly reduces the penalty for fighting invisible opponents. Because many humanoids have infravision, this proficiency is not usually as useful for humanoids as it is for humans."
    )
)

let embeddedProficiency0312: Proficiency = Proficiency(
    id: "boat_piloting",
    name: "Boat Piloting",
    wikiPageTitle: "Boat Piloting (Proficiency)",
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
            subAbility: "Strength/Muscle, Intelligence/Reason",
            characterPointCost: 2,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency is useful for negotiating challenging waters with a rowboat, canoe, or small dory.",
        fullText: "This proficiency is useful for negotiating challenging waters with a rowboat, canoe, or small dory. When shooting a rapids, trying to stay afloat in a storm, or trying to row upstream against a strong current, the character will succeed without a proficiency check—unless the water conditions are very extreme. In this case, the DM will require an appropriately modified roll; a successful roll means that the character negotiates the challenge and no further checks are necessary (until the next stretch of rapids, etc.). Failure does not necessarily mean that the boat sinks, but it gets swept away by the current, or turned about, or moderately swamped—with everything and everyone inside getting wet. If the rough water continues, the character must make additional proficiency checks (every 1–6 rounds). The character's proficiency rating suffers a –1 modifier for each failed check, indicating the difficulty of steering a boat that is slowly filling with water.\n\nThe character also knows the basics of sailing, and can effectively maneuver a single-masted sailboat. As above, challenges will require proficiency checks, with failed checks leading to increasingly dire straits."
    )
)

let embeddedProficiency0313: Proficiency = Proficiency(
    id: "boating",
    name: "Boating",
    wikiPageTitle: "Boating (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General (Rogue - Thief's Handbook)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Recommended: Adventurer, Bounty Hunter, Smuggler.",
        fullText: "## The Complete Thief's Handbook\n\nRecommended: Adventurer, Bounty Hunter, Smuggler.\n\nA character with boating proficiency is needed to guide a boat down a rapid stream or to reduce the dangers of capsizing a canoe or kayak. In addition, a character with boating proficiency can insure that a boat is propelled at its maximum speed.\n\nNote that this proficiency is distinct from Navigation and Seamanship, which apply to ships on oceans, seas, or at least large lakes, rather than small craft on smaller lakes and rivers.\n\n## The Complete Book of Dwarves\n\nA character with the boating proficiency is needed to guide a boat down a rapid stream and to reduce the danger of capsizing a canoe or kayak. He also assures the maximum speed of a boat.\n\nThis proficiency is distinct from Navigation and Seamanship, which apply to ships on oceans, seas, and large lakes.\n\n## The Complete Ranger's Handbook\n\nThis proficiency allows the character to pilot any small boat, such as a kayak or canoe, operating it at maximum speed. It also allows make minor repairs and improvements in these boats, such as waterproofing them and patching holes. A successful proficiency check enables the character to handle the craft in treacherous situations; for instance, maneuvering the boat though choppy water without capsizing it, or avoiding collisions when guiding it through a narrow channel choked with rocks or ice. Note that while the navigation and seamanship proficiencies deal with ships in oceans, seas, and other large bodies of water, the boating proficiency is confined to small craft on rivers, lakes, on oceans close to shore, and over similar terrain, usually on relatively calm waters.\n\nCrossover Groups: General.\n\n## The Complete Barbarian's Handbook\n\nThis proficiency lets the character pilot small boats, including canoes, rafts, and kayaks. A successful proficiency check is necessary to pilot them at maximum speed or to execute a difficult maneuver, such as steering around rocks in a rapid river or spearing a fish without capsizing.\n\nBarbarians: A barbarian may not take this proficiency unless water vessels are common in his homeland.\n\nCrossover Group: General.\n\n## Shaman\n\nThis proficiency lets characters pilot small boats, including canoes, rafts, and kayaks. A successful proficiency check is necessary to pilot the craft at maximum speed or to execute a difficult maneuver, such as steering around rocks in a rapid river."
    )
)

let embeddedProficiency0314: Proficiency = Proficiency(
    id: "boatwright",
    name: "Boatwright",
    wikiPageTitle: "Boatwright (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General (Special Background)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The boatwright proficiency allows a character to construct all kinds of watercraft up to a maximum length of 60 feet. Larger vessels cannot be built.",
        fullText: "## The Complete Book of Dwarves\n\nThe boatwright proficiency allows a character to construct all kinds of watercraft up to a maximum length of 60 feet. Larger vessels cannot be built.\n\nThe time required to build a boat depends on size. As a general guide, a boat requires one week of construction time per foot of length. Two characters with the boatwright proficiency cut this time by half; three reduce it to one-third. A maximum of one boatwright per 5 feet of length can work on the same vessel.\n\nThe basic boat includes hull, masts (if applicable), deck, and benches as required. Features such as a cabin or a sealed hold add about a week apiece to complete. Characters without the boatwright proficiency can aid the boatwright in construction, but two such characters equal the time savings that one additional skilled boatwright could provide."
    )
)
