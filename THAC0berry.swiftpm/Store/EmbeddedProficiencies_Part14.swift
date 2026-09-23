import Foundation

/// Parte 14 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency1400: Proficiency = Proficiency(
    id: "magecraft",
    name: "Magecraft",
    wikiPageTitle: "Magecraft (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "ntelligence/Reason",
            characterPointCost: 5,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency indicates a formal knowledge of basic magical theory, how spellcasting works, descriptions of common spells and magical items, and biographies of well-known wizards.",
        fullText: "This proficiency indicates a formal knowledge of basic magical theory, how spellcasting works, descriptions of common spells and magical items, and biographies of well-known wizards. On a successful proficiency check, the character also \"remembers\" obscure or lesser-known bits of information about magic and can identify a spell by observing its casting. The proficient character may also roll against half his proficiency (rounded down) to spot a magical construct or item. This last use of the Magecraft proficiency requires 2-12 rounds of careful examination."
    )
)

let embeddedProficiency1401: Proficiency = Proficiency(
    id: "massage",
    name: "Massage",
    wikiPageTitle: "Massage (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Gladiator (Warrior)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Massage: The Massage proficiency can allow a gladiator to help partners maintain their form longer during matches.",
        fullText: "## The Complete Gladiator's Handbook\n\nMassage: The Massage proficiency can allow a gladiator to help partners maintain their form longer during matches. By applying this therapy between matches, the gladiator ensures that the muscles of the subject remain loose and relaxed, essential for good combat. Any gladiator who receives a Massage in between bouts gains +2 to Endurance checks during the next bout. Massage can be practiced only on others; the proficient gladiator cannot massage herself and receive the bonus."
    )
)

let embeddedProficiency1402: Proficiency = Proficiency(
    id: "meditation",
    name: "Meditation",
    wikiPageTitle: "Meditation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Mystic (MotRD)"],
        slotsRequired: 1,
        rawSlots: "1 slots",
        relevantAbility: "Wisdom",
        checkModifier: 1,
        rawModifier: "1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Most religious professionals are trained in various practices of spiritual discipline and meditation. In addition to the effects that these practices have upon the soul of the meditator, they have more concrete physical and mental effects as well.",
        fullText: "## Dragon Magazine #236\n\nMost religious professionals are trained in various practices of spiritual discipline and meditation. In addition to the effects that these practices have upon the soul of the meditator, they have more concrete physical and mental effects as well. By spending time in meditation and prayer and making a successful proficiency check, the character can temporarily boost one mental ability score — Intelligence, Wisdom, or Charisma — by +2. The effect lasts one-third of the time spent in meditation, so if the character spent three uninterrupted hours in meditation, the ability score would remain heightened for one hour. Meditation requires freedom from disturbance, and does not eliminate the needs for food, drink, or sleep. Only one ability can be boosted at any given time. (Note: This proficiency is derived from the special ability of the mystic kit in the ''Player's Option™: Skills & Powers'' book.)"
    )
)

let embeddedProficiency1403: Proficiency = Proficiency(
    id: "meditative_focus",
    name: "Meditative Focus",
    wikiPageTitle: "Meditative Focus (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Psionicist",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 1,
        rawModifier: "+1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Meditative Focus: Through this proficiency, a psionicist can focus his mental energy on one particular discipline. As a result, his power scores in that discipline temporarily increase, while those in other disciplines decline.",
        fullText: "## Complete Psionics Handbook\n\nMeditative Focus: Through this proficiency, a psionicist can focus his mental energy on one particular discipline. As a result, his power scores in that discipline temporarily increase, while those in other disciplines decline.\n\nThe proficiency requires the character to meditate, uninterrupted, for 12 hours. The last four hours of this meditation are spent in a deep, sleeplike trance. The psionicist can recover PSPs normally during the entire period.\n\nWhen the meditation is complete, the player makes a proficiency check. If the character passes the check, he has successfully focused his mind on one particular discipline (which was chosen when the process began). All of the character's psionic power scores in that discipline are increased by two points for the next 24 hours - or until the character's PSPs have been reduced to zero, whichever comes first. All of his power scores in other disciplines are reduced by one for the same period.\n\n## Player's Option: Skills & Powers\n\nMeditative Focus: This proficiency allows a psionicist to focus his mental energy into one discipline, causing all powers within that discipline to receive MTHAC0 roll bonuses; powers related to other disciplines receive MTHAC0 roll penalties.\n\nThe psionicist must meditate for 12 consecutive hours. He recovers PSPs normally during this meditative state. When the period ends, the character makes a proficiency check. Success means he has focused his energy into the chosen discipline. All MTHAC0 rolls for powers within that discipline receive a +2 bonus for the next 24 hours or until his PSP total is reduced to 0, whichever comes first. All other disciplines get a –1 penalty for the same period.\n\n## Campaign Option: Council of Wyrms Setting\n\nOnly gem dragons may take the Meditative Focus proficiency. With it, a gem dragon can focus its mental energy on one particular psionic discipline. As a result, its power scores in that discipline temporarily increase, while those in other disciplines decline. The dragon must spend twelve uninterrupted hours meditating-the last four in a deep tranceto focus its energy. PSPs can be recovered normally during this period. When the meditation is completed, the dragon makes a proficiency check. A successful check means that the focus worked. All of the dragon's psionic power scores in the chosen discipline are increased by 2 points for the next 24 hours, or until its PSPs are reduced to 0. All power scores for the dragon's other disciplines are reduced by 1 point for the same period. Hatchlings can't select this proficiency."
    )
)

let embeddedProficiency1404: Proficiency = Proficiency(
    id: "medium",
    name: "Medium",
    wikiPageTitle: "Medium (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows characters to invite selected spirits to temporarily possess them. The usual reason for a character to seek possession is so that a certain spirit may be easily conversed with.",
        fullText: "This proficiency allows characters to invite selected spirits to temporarily possess them. The usual reason for a character to seek possession is so that a certain spirit may be easily conversed with. The spirits thus contacted are usually benign spirits, with whom the character's community has a steady relationship, as inviting an unknown spirit to take part in the possession could be very dangerous.\n\nMany tribal shamans routinely contact the ancestors and other key spirits this way, in order to establish why some hardship has befallen the tribe or to seek advice in a political matter. In some tribes, the spirits are routinely contacted whenever a person falls sick or suffers any minor misfortune. In these circumstances, the spiritual possession is regarded as something quite mundane, and other senior tribesmen, besides the shamans, might have this proficiency.\n\nIn order to use this proficiency, a character ?e must spend one round in quiet meditation on the target spirit. If the spirit wishes, it simply enters the shaman's body, causing it to move around and speak as the spirit desires. The character acting as the host for the spirit may not converse with it, and so another must put questions to and speak U with the spirit.\n\nSuccessful use of this proficiency depends not only on the proficiency check, but also the pres- Pence of at least one spirit within 150 feet of the medium, either in the spirit world or prime material world. Spirits are most easily found at their \"home\" or attending important festivals.\n\nThe advantage of this, over the shamans' usual method, is that it may be used to selectively contact only one spirit, whose words are publicly heard.\n\nAny spirit in the area, even one different from the one a shaman wishes to contact, may attempt to possess him or her. The shaman can sense that it is not the desired spirit and can resist the attempt if a successful saving throw vs. paralyzation is rolled. A malign spirit could easily use the shaman's body for murderous ends.\n\nFinally, if the characters are ever unwillingly possessed, the Medium proficiency allows them a greater chance of regaining control from the spirit. The character attempts a saving throw vs. paralyzation at the end of the first round after the possession takes place, and then at the end of the next turn, at the end of the day, the end of the week, and so on (month, year, decade, century, etc.). If any of these rolls succeed, the spirit is expelled, and may not attempt to possess the character again."
    )
)

let embeddedProficiency1405: Proficiency = Proficiency(
    id: "mental_armor",
    name: "Mental Armor",
    wikiPageTitle: "Mental Armor (Proficiency)",
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
        briefSummary: "Not a proficiency in the Psionics Handbook.",
        fullText: "## Complete Psionics Handbook\n\nNot a proficiency in the Psionics Handbook.\n\n## Player's Option: Skills & Powers\n\nMental Armor: This proficiency allows a character to improve his mental armor class (MAC). Each time this proficiency is placed in an available nonweapon slot, the character's MAC improves. Nonpsionicists improve by +1 for each slot; psionicists improve by +2. The proficiency may only be slotted once per level advancement.\n\n## Dark Sun Campaign Setting Revised\n\nThis proficiency allows a character to improve his Mental Armor Class (MAC). Each time this proficiency is placed in an available nonweapon slot, the character's MAC improves. Nonpsionicists improve by +1 for each slot; psionicists improve by +2. This proficiency may only be slotted once per level of advancement.\n\nBefore receiving the benefits of this proficiency, a successful check must be made. If the check fails, the character must wait 24 hours before trying to engage his mental armor. Once the check succeeds, however, the MAC improvement is permanent. For more information about Mental Armor Class, see The Way of the Psionicist."
    )
)

let embeddedProficiency1406: Proficiency = Proficiency(
    id: "mental_resistance",
    name: "Mental Resistance",
    wikiPageTitle: "Mental Resistance (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Mental Resistance: Through lengthy training and iron discipline, a character with this proficiency prepares himself to resist magical or psionic assaults on his mind.",
        fullText: "Mental Resistance: Through lengthy training and iron discipline, a character with this proficiency prepares himself to resist magical or psionic assaults on his mind. The character receives a +1 bonus to his saving throws against attacks of this nature, if the attack normally allows a saving throw. Generally, this includes any attack form that a character's magical attack adjustment bonus for his Wisdom score might affect, including mind-affecting spells, charm or fear powers of monsters, and telepathic sciences or devotions that allow the subject a saving throw."
    )
)

let embeddedProficiency1407: Proficiency = Proficiency(
    id: "metalworking",
    name: "Metalworking",
    wikiPageTitle: "Metalworking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters with this proficiency can work artistically in silver, copper, gold, tin, brass, and other soft metals. They produce the beautiful and useful metal items common to any bazaar—oil lamps, coffee pots, vases, trays, and the like.",
        fullText: "Characters with this proficiency can work artistically in silver, copper, gold, tin, brass, and other soft metals. They produce the beautiful and useful metal items common to any bazaar—oil lamps, coffee pots, vases, trays, and the like.\n\nA successful proficiency check results in a useful item of high quality. Failure may indicate that a craftsman has fashioned something ugly and unsuited for sale. More often (and for PCs), failure means that an item still looks pleasing, but is somehow flawed or fragile, and fails when put to the test. (For example, the pot leaks, a handle breaks, and so forth.)\n\nCharacters with an artistic ability proficiency that relates to metalworking gain a +1 bonus. While metalworking does allow characters to fashion iron or steel with some deftness, it does not grant them the ability to make effective weapons or armor. Metalworkers may attempt to repair nonmagical armor that's made of metal, but a failed proficiency check results in the destruction of the armor. (Characters seeking armor repair should visit a metalworker only as a last resort; armorers are far better suited to the task.)"
    )
)

let embeddedProficiency1408: Proficiency = Proficiency(
    id: "metaphysical_theory",
    name: "Metaphysical Theory",
    wikiPageTitle: "Metaphysical Theory (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Wisdom",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Reason, Wisdom/Intuition",
            characterPointCost: 5,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "Beyond a knowledge of the campaign world's magic, the character has studied the theory of how physical laws and magical laws interact and can predict how varying these laws will affect magic.",
        fullText: "Beyond a knowledge of the campaign world's magic, the character has studied the theory of how physical laws and magical laws interact and can predict how varying these laws will affect magic. On a successful proficiency check, the character can predict how magic will work on another world or plane, given some basic facts about the plane. (Spellcasters traveling to another world or plane often use this proficiency to decide what spells or items to bring with them.)\n\nWhile on another world or plane, the character may make a proficiency check against half his skill (rounded down) to compensate for the effects of varying physical laws for one round. This use of the proficiency requires 1-10 rounds of intense thought and concentration. During this time, the character cannot cast spells or perform strenuous actions. For the one round following the period of concentration, the character may cast spells and use items as if he were still on his home world or plane. This \"bending of the rules\" is quite tiring, and the mage must save vs. death magic or lose one point of Constitution (or Constitution/Health) for one full day."
    )
)

let embeddedProficiency1409: Proficiency = Proficiency(
    id: "military_science",
    name: "Military Science",
    wikiPageTitle: "Military Science (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General?"],
        slotsRequired: 1,
        rawSlots: "Unknown",
        relevantAbility: "Intelligence?",
        checkModifier: 0,
        rawModifier: "Unknown",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Military Science: Unlike the majority of medieval generals, the Romans favored a scientific approach to the art of war, and Roman commanders often wrote down their observations.",
        fullText: "## The Glory of Rome Campaign Sourcebook\n\nMilitary Science: Unlike the majority of medieval generals, the Romans favored a scientific approach to the art of war, and Roman commanders often wrote down their observations. This proficiency indicates the character has both theoretical and practical knowledge of tactics and strategy, as well as knowledge of how to train troops. The DM may allow a military commander who makes a successful skill check insights into the deployment and plans of his opponents. If using the BATTLESYSTEM® rules, any unit commander who has had time to work with his troops and drill a battle plan into them may roll a Military Science check prior to the battle. A successful check indicates his plan was good: add +2 to his Command Distance (CD) and +1 to his Charisma bonus for that battle only."
    )
)

let embeddedProficiency1410: Proficiency = Proficiency(
    id: "mining",
    name: "Mining",
    wikiPageTitle: "Mining (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Wisdom",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition, Strength/Stamina",
            characterPointCost: 5,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with mining proficiency is needed to site and supervise the operations of any mine. First, the character can attempt to determine what types of ores or gems can be found in a given area.",
        fullText: "## Player's Handbook\n\nA character with mining proficiency is needed to site and supervise the operations of any mine. First, the character can attempt to determine what types of ores or gems can be found in a given area. To do this, he must spend at least a week searching a four-square-mile area. The DM may rule that more area must be searched to find anything of value and may thus increase the amount of time required. At the end of the search, the character can say what is likely to be found in this area. After this, the character can site the mine. On a successful proficiency check (made secretly by the DM), the character has found a good site to begin mining for any minerals that may be in the area. The check does not guarantee a successful mine, only that a particular site is the best choice in a given area. The DM must determine what minerals, if any, are to be found in the region of the mine. On a failed check, the character only thinks he has found a good site. Much effort is spent before the character is proved wrong, of course.\n\nOnce the mine is in operation, a character with mining proficiency must remain on site to supervise all work. Although this is a steady job, most player characters will find it better to hire an NPC for this purpose.\n\n## Player's Option: Skills & Powers\n\nMining: A character with the mining proficiency can select the site of a mine and supervise its excavation and operation. Mining proficiency checks are best made for a player by the DM, since the character will not learn for some time whether his suppositions about a potential mine were accurate.\n\nThe ''Player's Handbook'' contains a more detailed description of how to role-play a miner's proficiency use.\n\n## The Complete Book of Dwarves\n\nThe Player's Handbook provides basic information on mining and this proficiency is described in detail in Chapter 8. Mining operations are usually at the heart of dwarf strongholds.\n\n## Campaign Option: Council of Wyrms Setting\n\nFor dragons, the Mining proficiency allows a dragon to determine the types of ores and gems that may be found in a given area, as well as the best mining sites. As described in the Player's Handbook, a week of examination typically covers a four-square-mile area, and a successful check finds the best site. Dragons will not use the proficiency to supervise a working mine (as they prefer to leave such work to their vassals). Hatchlings can't select this proficiency."
    )
)

let embeddedProficiency1411: Proficiency = Proficiency(
    id: "mountaineering",
    name: "Mountaineering",
    wikiPageTitle: "Mountaineering (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "N/A",
        checkModifier: 0,
        rawModifier: "N/A",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Strength/Stamina, Wisdom/Willpower",
            characterPointCost: 4,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency can make difficult and dangerous climbs up steep slopes and cliffs with the aid of spikes, ropes, etc.",
        fullText: "## Player's Handbook\n\nA character with this proficiency can make difficult and dangerous climbs up steep slopes and cliffs with the aid of spikes, ropes, etc. If a character with mountaineering proficiency leads a party, placing the pitons (spikes) and guiding the others, all in the party can gain the benefit of his knowledge. A mountaineer can guide a party up a cliff face it could not otherwise climb. A character with this proficiency gains a 10% bonus per proficiency slot spent to his chance to climb any surface. Note that mountaineering is not the same as the thief's climbing ability, since the latter does not require aids of any sort.\n\n## Player's Option: Skills & Powers\n\nMountaineering: A character with this proficiency is skilled in the use of hammer and pitons (spikes) to secure a route up a mountainside. He also knows how to use the rope and brackets that can link a party of climbers. A proficient character can make a route across a steep section of rocks, and by the use of ropes allow other, non-proficient characters to follow.\n\nNo proficiency check is required unless the DM declares that a route is very perilous- steeply pitched, with few hand- and foot-holds, and those that exist are tiny or loose. If a character connected to the mountaineer by rope falls, the mountaineering character can make a proficiency check; success means that the otherís fall has been arrested. Failure means that the other character continues to fall, and failure by a roll of 20 means that the mountaineer is pulled down, too.\n\nCharacters with the mountaineering proficiency can add their proficiency rating to their percentage chance of climbing any surface; this includes thieves using the climb walls special ability."
    )
)

let embeddedProficiency1412: Proficiency = Proficiency(
    id: "movement_meditation",
    name: "Movement Meditation",
    wikiPageTitle: "Movement Meditation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Mystic (MotRD)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Certain mystical traditions in Gothic Earth, particularly (but not exclusively) in the East, emphasize physical discipline and exercise as means of spiritual growth.",
        fullText: "## Dragon Magazine #236\n\nCertain mystical traditions in Gothic Earth, particularly (but not exclusively) in the East, emphasize physical discipline and exercise as means of spiritual growth. This proficiency is identical to the Meditation proficiency described above, except that one physical ability — Strength, Dexterity, or Constitution — can be improved by +1 for a period equal to half the time spent in meditation."
    )
)

let embeddedProficiency1413: Proficiency = Proficiency(
    id: "mudra_sign_language",
    name: "Mudra Sign Language",
    wikiPageTitle: "Mudra Sign Language (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue", "Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This stylised set of thousands of dancing hand signals and body movements forms a complex unspoken language. For example, there are 36 poses of the eyes and 22 of the neck and head.",
        fullText: "This stylised set of thousands of dancing hand signals and body movements forms a complex unspoken language. For example, there are 36 poses of the eyes and 22 of the neck and head. Thugs, thieves, dancers, and Brahmins often use this to communicate as they would with any other language."
    )
)

let embeddedProficiency1414: Proficiency = Proficiency(
    id: "musical_instrument",
    name: "Musical Instrument",
    wikiPageTitle: "Musical Instrument (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Rogue", "Psionicist"],
        slotsRequired: 1,
        rawSlots: "1 Slots",
        relevantAbility: "Dexterity",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Charisma/Leadership",
            characterPointCost: 2,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character can play a specific musical instrument. An additional instrument can be added for every extra slot devoted to this proficiency.",
        fullText: "## Player's Handbook\n\nThe character can play a specific musical instrument. An additional instrument can be added for every extra slot devoted to this proficiency. The character plays quite well, and no proficiency check is normally required. The DM may direct the character to make a proficiency check in what he feels are extraordinary circumstances.\n\n## Player's Option: Skills & Powers\n\nMusical Instrument: The character can play a specific type of musical instrument, adding an extra instrument for every character point expended on this proficiency after its initial purchase. The skill enables the character to play the instrument very well, though a proficiency check might be required when attempting a very difficult piece.\n\nA character with the music/instrumental trait knows how to play two instruments immediately (when this proficiency is selected). For each character point spent, two (not one) additional instruments can be learned.\n\n## The Complete Barbarian's Handbook Modifications\n\nA barbarian must choose an instrument from his homeland. Typical instruments include the\n\nbow and gourd (an animal sinew stretched taut on a curved stick with a hollow gourd attached; bending the stick when the string is plucked varies the pitch, which is amplified by the gourd);\n\nelephant horn (a hollowed tusk with openings at both ends, played like a trumpet);\n\nreed whistle (a hollowed branch or reed, perforated with holes that can be covered with the fingers and played like a flute);\n\nlog drum (a hollowed log with an animal skin stretched across the top, played with sticks or hands);\n\nand lamellaphone (a thumb piano, made from bamboo strips secured to a small box; the plucked strips produce tones that resonate inside the box).\n\nA barbarian's approach to rhythm and harmony may be unusual, but the complexity and emotional content of his performances are comparable to those of a trained outworld musician."
    )
)
