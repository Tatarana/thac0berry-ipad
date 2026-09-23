import Foundation

/// Parte 12 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency1200: Proficiency = Proficiency(
    id: "hypnosis",
    name: "Hypnosis",
    wikiPageTitle: "Hypnosis (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Psionicist",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Psionicist"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "N/A",
            characterPointCost: nil,
            baseRating: "N/A"
        ),
    description: ProficiencyDescription(
        briefSummary: ":For other uses, see Hypnotism (disambiguation)",
        fullText: ":For other uses, see Hypnotism (disambiguation)\n\n## Complete Psionics Handbook\n\nHypnosis: With this proficiency, a psionicist can hypnotize another character - placing the subject into a relaxed state in which he is very susceptible to suggestions. However, hypnosis is not possible unless the subject is willing and knows he is being hypnotized.\n\nPsionicists with this proficiency can hypnotize humans and demihumans with ease. Nonhumans can be hypnotized, too, but the DM should assign a penalty to the proficiency check. The size of the penalty depends on how inhuman the subject is. A half-orc, for example, could be hypnotized with a -2 modifier, while a lizard man could be hypnotized only with a -8 modifier to the psionicist's proficiency check.\n\nThe act of hypnotizing someone takes about five minutes. The subject is then very relaxed and willing to do almost anything that isn't very dangerous or against his alignment. Note, however, that a hypnotized subject can be easily fooled; the subject may be convinced that he's doing one thing, while he's actually doing another. Lawful or good psionicists who trick their subjects in this fashion should beware. Psionicists who use hypnotism to make people do chaotic or evil things may find themselves with alignment problems of their own.\n\nHypnotism can have the following (or similar) effects:\n* A character can be induced to remember things he has forgotten by reliving a frightening or distant event.\n* A character can be made calm and unafraid in the face of a specific situation that he has been prepared for.\n* A character can be cured of a bad habit or addiction (but not of curses or magical afflictions).\n* A character can be prepared to impersonate someone by thoroughly adopting that individual's personality\n\nHypnotism cannot be used to increase a character's attributes, give him powers or abilities he does not naturally possess, let him do things that are beyond his capabilities, or give him information that he couldn't possibly know.\n\n## Player's Option: Skills & Powers\n\nNo longer a proficiency in Skills & Powers.\n\n## Campaign Option: Council of Wyrms Setting\n\nOnly gem dragons may take Hypnosis. With this proficiency, a dragon can hypnotise another character (dragon or demihuman), placing the subject into a relaxed state in which he is very susceptible to suggestions. Hypnosis is not possible unless the subject is willing and knows what is occurring.\n\nHypnotism can induce a character to remember forgotten events, cure a bad habit, or be used to calm and relax someone. See The Complete Psionics Handbook [TSR #2117] for more details.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency1201: Proficiency = Proficiency(
    id: "hypnotism",
    name: "Hypnotism",
    wikiPageTitle: "Hypnotism (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: ":For other uses, see Hypnotism (disambiguation)",
        fullText: ":For other uses, see Hypnotism (disambiguation)\n\nHypnotism: With this proficiency, the wizard can hypnotize another character, placing him into a relaxed state in which he is susceptible to suggestions. The subject must be willing and must know he is being hypnotized. Only human, demihuman, and humanoid characters may be hypnotized, and the hypnotist and subject must be able to understand one another's language.\n\nIt takes about five minutes to hypnotize someone in a reasonably calm or peaceful environment. Once hypnotized, the subject is willing to do almost anything that isn't very dangerous or against his alignment. However, a hypnotized subject can be fooled into thinking he's doing one thing when he's actually doing something else. Hypnotism can have the following effects:\n\nA character can be induced to remember things he has forgotten by reliving a frightening or distant event.\n\nA character can be made calm and unafraid in the face of a specific situation that he has been prepared for, gaining a +2 bonus to saving throws versus fear effects or morale checks.\n\nA character can be cured of a bad habit or addiction (but not of curses, physical diseases, or magical afflictions.)\n\nHypnotism can't increase a character's attributes, give him skills he does not normally possess, let him do things that are beyond his capabilities, or give him information he couldn't possibly know. As a guideline for adjudicating effects, the hypnotism proficiency is substantially weaker than magical commands or directions, such as charm person, command, or hypnotism. Spells magically compel a person to obey the caster's will; a well-phrased hypnotic command is nothing more than a strong suggestion."
    )
)

let embeddedProficiency1202: Proficiency = Proficiency(
    id: "illithid_sense",
    name: "Illithid Sense",
    wikiPageTitle: "Illithid Sense (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Caradhaker Only"],
        slotsRequired: 1,
        rawSlots: "1 slkot",
        relevantAbility: "Wisdom",
        checkModifier: -4,
        rawModifier: "-4/-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Illithid sense gives the Mindstalker a chance to integrate subtle clues—spoor, \"tunnel vibrations,\" and even psychic emanations—that indicate the presence of illithids within 200 feet.",
        fullText: "## Dragon Magazine #230\n\nIllithid sense gives the Mindstalker a chance to integrate subtle clues—spoor, \"tunnel vibrations,\" and even psychic emanations—that indicate the presence of illithids within 200 feet.\n\nThis proficiency functions passively; whenever a caradhaker comes within 200 feet of an illithid in an underground setting, the DM secretly rolls a check at the -4 modifier. If successful, the character becomes aware of nearby illithid activity, but not the distance or the direction. Once a check is failed, the DM does not roll for another passive check for a minimum of 1 hour, or until the DM deems that some obvious clue of illithid presence has been overlooked by the character. A mindstalker can also choose to make an active check for signs of illithid activity (no more than 1/hour). The conscious check takes a full 3 rounds to accomplish but is made at only a -1 modifier to the character's Wisdom.\n\nFor example, the DM might tell the caradhaker's player (after secretly checking against the player's illithid sense proficiency), \"Something tickles the back of your mind—a stray, clammy draft from up the tunnel to the left smells of garlic. In other words, there be illithids here!\""
    )
)

let embeddedProficiency1203: Proficiency = Proficiency(
    id: "illithid_track",
    name: "Illithid Track",
    wikiPageTitle: "Illithid Track (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Caradhaker Only"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Wisdom",
        checkModifier: 2,
        rawModifier: "+2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Normally, non-rangers find it difficult to track creatures even with the tracking proficiency (since non-rangers suffer a -6 penalty to their proficiency check).",
        fullText: "## Dragon Magazine #230\n\nNormally, non-rangers find it difficult to track creatures even with the tracking proficiency (since non-rangers suffer a -6 penalty to their proficiency check). Thankfully, caradhaker developed their specialized version of tracking designed specifically to find illithids. This proficiency in no way confers the ability to track other types of creatures.\n\nMindstalkers with the illithid tracking proficiency can follow mind flayers across most types of terrain. Besides the Modifier listed above, all the modifiers listed on Table 39: Tracking Modifiers in the Player's Handbook also apply.\n\nTo track an illithid, a caradhaker must first find the trail. Illithid sense is ideal for discovering the track; however, if mind flayers have been through an area within the hour (or if an eyewitness report or other strong evidence is available), an illithid track proficiency check is rolled to discover the trail. A failed check means that no track is found.\n\nIf the trail is found, additional checks are made if the terrain significantly changes, a second track (of any creature type) crosses the first, or the caradhaker resumes tracking after a halt to rest, eat, fight, etc.\n\nOnce a tracker fails a proficiency check and loses a trail, another check can be rolled after spending at least one hour searching the area for new signs, or after a successful illithid sense proficiency check. If more than one mindstalker is following a trail, a +1 bonus modifier is added to the most adept tracker's check."
    )
)

let embeddedProficiency1204: Proficiency = Proficiency(
    id: "illusion_pierce",
    name: "Illusion Pierce",
    wikiPageTitle: "Illusion Pierce (Proficiency)",
    redirectAliases: ["Illusion Pierce (GEP)"],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 3,
        rawSlots: "3",
        relevantAbility: "N/A",
        checkModifier: 0,
        rawModifier: "N/A",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The swirling ethereal mists, so full of possibility, don't just enhance illusions, they also erode them-if a body knows how to use them that way.",
        fullText: "The swirling ethereal mists, so full of possibility, don't just enhance illusions, they also erode them-if a body knows how to use them that way. The bane of illusionists and illusory magic, this proficiency grants characters an automatic saving throw vs. illusions that manifest upon the Ethereal Plane, even when the spell doesn't normally indicate a saving throw. A body need not make a proficiency check to gain a save; the chance to save against an illusion on the Ethereal is automatic. Against illusions and phantasms that already grant a save, a body automatically gains a +2 bonus to her saving throw. Note that this proficiency doesn't affect illusions that have gained substance from the ethereal mists."
    )
)

let embeddedProficiency1205: Proficiency = Proficiency(
    id: "information_gathering",
    name: "Information Gathering",
    wikiPageTitle: "Information Gathering (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "Special",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: ":''Note: \"Information Gathering\" is called \"Gather Intelligence\" incorrectly in parts of The Complete Thief's Handbook''",
        fullText: "## The Complete Thief's Handbook\n\n:''Note: \"Information Gathering\" is called \"Gather Intelligence\" incorrectly in parts of The Complete Thief's Handbook''\n\nRequired: Beggar, Fence, Investigator, Spy.\n\nRecommended: Adventurer, Assassin, Bounty Hunter, Burglar, Cutpurse, Smuggler, Swindler, Troubleshooter.\n\nThis proficiency represents the ability to gather information from the underworld, most commonly about roguish \"jobs\" and characters. A character with this proficiency, in appropriate circumstances, will be aware of any major rumors circulating among the lowlife of an area; and with a successful proficiency check, specific information about a person or place can be gathered. (The DM must decide how specific the information is.)\n\nThe following modifiers may adjust the proficiency check:\n\nCharacters' reaction adjustments (based on Charisma) should benefit or penalize the roll, assuming contact with people is involved in the search.\n\nThieves' guild members receive a bonus of +2, because they are assumed to have more and better-informed contacts than freelancers. Also, their \"territory\" (below) is considered to be that of the guild, not just their own area of operation.\n\nSince this proficiency depends on a network of informants and contacts, the thief will be at a disadvantage trying to use it in an area other than his own territory. \"Territory\" refers to his regular base of operations—a town, one neighborhood of a city, or even a whole province or countryside. Outside this territory the thief does not hear rumors automatically (a normal proficiency roll is required), and gathering specific information suffers a penalty of at least -3. The DM may make it greater in truly foreign areas (e.g., a thief of Waterdeep trying to gather information in Calimshan), due to great differences in language, culture or race.\n\nFinally, any time a proficiency check is required for information gathering, a small investment of money for drinks, bribes, and so forth must be made, or an additional penalty of -3 is imposed. A total of 1d10 gp is typical, and it is lost whether or not the desired information is found. (If the information is still unknown, the character can continue his search the next day, spending more money and making another proficiency check.) The DM is free to increase the cost of using this proficiency if it suits the campaign.\n\nExamples:\n\n1. Urlar is hanging around the local tavern in his neighborhood when he hears rumors of a dragon to the north, recently slain as it raided a village. The dragon's cave and treasures are as yet undiscovered. But some bragging adventurers are said to have found a map to them. Urlar's contacts provide this information to him automatically, while another PC would need to approach people, talk with them, and probably buy them several drinks in order to learn of the map and treasure.\n\n2. His greed sparked, Urlar wants to know who these adventurers are, so that he can steal their map and find the dragon's hoard for himself. This requires a couple of drinks (a 2 gp investment); and the proficiency check has a -1 penalty because of Urlar's low Charisma (7). Urlar's Intelligence is 10, so he needs to roll a 9 or lower to find out who the adventurers are. If they are not very well known, he may need to make additional checks to track them down (find where they are staying, what temples they visit, or whatever).\n\n3. Julina the Silent is hired as a spy to infiltrate the emperor's palace. She needs to find an easy way in—a sewer, service exit, or the like. She has an expense account from her employers for bribes. Her Intelligence is 14 and her modifiers are: +1 (for Charisma 13 reaction adjustment), +2 (thieves' guild member), and -3 (for this not being her home territory); so she must roll 14 or lower on 1d20 to get the information she needs.\n\nIt's best to role-play information searches whenever possible.\n\n## The Complete Book of Humanoids\n\nThrough the use of this proficiency, a humanoid character can gain information about a specific person, place or thing. In appropriate circumstances, a character will be aware of major rumors circulating around a roguish or humanoid area. With a successful check, specific information can be gleaned.\n\nThe following modifiers adjust the check:\n\n''Characters' reaction adjustments'' (based on Charisma) will benefit or penalize the roll, assuming contact with intelligent beings is involved in the search.\n\n''Thieves' guild members'' receive a +2 bonus as they have the resources of the entire guild at their disposal. Similarly, outside of towns and cities, certain humanoid characters may receive the same bonus if they have similar contacts (satyrs and swanmays have woodland creatures, a goblin may be able to get information from a goblin tribe, etc.).\n\nWhen outside friendly territory, specific information suffers at least a -3 penalty.\n\nMoney or treasure is required. Any time a proficiency check is required to gather information, the character must make a small investment of money or treasure or suffer an additional penalty of - 3 . Humans prefer money, and a total of 1d1O gp is typical. Other races may want some other type of treasure (food, magical item, shiny trinket, etc). The investment is lost whether or not the desired information is found.\n\n## The Complete Ninja's Handbook\n\nInformation Gathering: This proficiency, introduced in ''The Complete Thief's Handbook'', represents the ability to gather information from the underworld, most commonly about roguish activities and personalities. A character with this proficiency, in appropriate circumstances, will be aware of any major rumors circulating among the lowlife of an area. With a successful proficiency check, he can gather specific information about a person or place. (The DM must decide how specific the information is.)\n\nThe following modifiers may adjust the proficiency check:\n\n* Other characters' reaction adjustments (based on Charisma) benefit or penalize the roll.\n* Thieves' guild members receive a bonus of +2; they have more contacts (and better-informed ones) than free-lancers.\n* A character outside his own territory—usually his home city—suffers a –3 penalty to his check. This penalty can be worsened in territories very different from the character's, due to differences in language, culture or race.\n\nWhenever a proficiency check is required for Information Gathering, the character must invest a small amount of money for bribes to avoid an additional –3 penalty. A total of 1d10 gp is typical for bribes, and is lost whether or not the desired information is learned. The character can continue his Information Gathering the next day, spending more money and making another proficiency check. The DM is free to increase the cost of using this proficiency as suits the situation or campaign.\n\n## Dark Sun Campaign Setting Revised\n\nThis proficiency allows a character to rapidly gather information from underworld sources and from the word on the streets of the cities and villages. A character who has this proficiency can spend a day becoming aware of all the major rumors circulating on the streets of a particular area. No check is needed for this use of the proficiency, but the time must be accounted for.\n\nA successful check is needed to gather specific information about a person or place. The roll is modified by the character's reaction adjustment (determined by his Charisma score). In addition, the character must spend 1d10 ceramic pieces to pay for small bribes, to buy drinks, and to otherwise loosen the lips of those in the know.\n\nIf the character uses this proficiency outside familiar territory, the check receives a -3 penalty. If the character doesn't spend the ceramic pieces, the check receives an additional -3 penalty.\n\n## The Will and the Way\n\nSome characters have the ability to rapidly gather information from the underworld and the city streets. A character with this proficiency will be aware of any major rumors circulating among the lowlife and commoners of an area. With a successful proficiency check, the character can gather specific information about a person or place.\n\nThe roll is modified by the character's reaction adjustment (his Charisma score). If the character uses this skill outside his own territory-in another neighborhood or city-state, for example—he suffers a -3 penalty to his check. In addition, the character must also spend 1d10 ceramic pieces for small bribes, buying drinks, and other such expenses when he uses this skill. If he does not spend the money, he suffers an additional -3 penalty to the proficiency check."
    )
)

let embeddedProficiency1206: Proficiency = Proficiency(
    id: "inquisitor",
    name: "Inquisitor",
    wikiPageTitle: "Inquisitor (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 2,
        rawSlots: "2 slot",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Inquisitors are experts in arguing the canon of their faith with others. They are well-versed in every doctrine of their faith, and know every rule and observance by heart.",
        fullText: "## Warriors & Priests of the Realms\n\nInquisitors are experts in arguing the canon of their faith with others. They are well-versed in every doctrine of their faith, and know every rule and observance by heart. A priest with this proficiency can cross-examine a subject who claims to follow the priest's religion, to see if it is truly so.\n\nWhereas the religion proficiency grants knowledge of other religions, the inquisitor proficiency focuses on one religion only, and all of its tenets, history, and legends. This includes an understanding, though not an acceptance, of any splinter faiths of that religion."
    )
)

let embeddedProficiency1207: Proficiency = Proficiency(
    id: "intimidation",
    name: "Intimidation",
    wikiPageTitle: "Intimidation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior (Rogue - Thief's Handbook)"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Strength/Charisma",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Required: Thug.",
        fullText: "## The Complete Thief's Handbook\n\nRequired: Thug.\n\nRecommended: Bandit, Bounty Hunter, Buccaneer.\n\nThis is a talent for bending people to your will by scaring the living daylights out of them. NPCs who are intimidated are quite likely to do what they're told, out of fear. On the negative side, they are also very likely to harbor much resentment against the character that intimidates them. The NPCs will keep their resentment hidden—until the first chance to avenge their pride arises.\n\nIntimidation may be attempted with one of two abilities: Strength or Charisma. If Strength is used, the thief is threatening immediate, personal bodily harm. If Charisma is used, the intimidation consists of more subtle threats, which need not be physical. If successful, the NPC is convinced that the thief is ready and capable of making his life miserable—if not immediately, then in the near future.\n\nPlayer characters are never forced to submit to intimidation, as this would detract from the players' freedom to role-play.\n\n## The Complete Book of Dwarves\n\nThis proficiency allows a character to intimidate others to do as he wishes. It involves an implicit threat of violence. Threatened NPCs will do as they are told, but will harbor resentments against him. If an opportunity arises for intimidated NPCs to revenge themselves they will do so.\n\nIntimidation may be attempted with one of two abilities, Strength or Charisma. If intimidating by Strength, the character is threatening immediate, personal, bodily harm. If by Charisma, the intimidation consists of subtle threats, which need not be physical. No matter which ability is used, the intimidation attempt is always modified by the difference between the experience level of the intimidating character and the experience level or Hit Dice of the victim(s). Creatures with less than one Hit Die are considered to have a level of 0.\n\nA 6th-level warrior attempting to intimidate an HD1-1 goblin would gain a +6 bonus to his intimidation ability. Against a 10th-level human warrior, our 6th-level dwarf's intimidation proficiency would be reduced by -4. Higher level characters are less likely to be intimidated.\n\nWhen a character is attempting to intimidate more than one character, and all are within 1-4 experience levels of each other, the level is the average of them. If one or more characters are over five experience levels above the others, the highest experience level is used, the other characters gaining confidence from the presence of a powerful individual.\n\nWhen attempting to intimidate more than one, the number of characters is used as a negative modifier. If a dwarf is attempting to intimidate five goblins, his intimidate proficiency is reduced by -5.\n\nIntimidation may only be used against intelligent creatures; slimes and shambling mounds are too stupid to notice that someone is trying to intimidate them.\n\nPlayer characters are never forced to submit to intimidation, and may choose how they are going to react to an attempt.\n\n## The Complete Book of Humanoids\n\nThis proficiency allows characters to bend others to their will through fear tactics. NPCs who are intimidated are quite likely to do as they are told. They are also very likely to harbor much resentment against the character that intimidates them. NPCs will keep their resentment hidden until the first opportunity to avenge their pride arises.\n\nIntimidation can be attempted with either Strength or Charisma. Strength indicates a threat of immediate bodily injury. Charisma uses more subtle threats which need not be physical in nature.\n\nPlayer characters are never required to submit to intimidation.\n\n## Campaign Option: Council of Wyrms Setting\n\nIntimidation allows a dragon to bend others to its will through the use of fear tactics. NPCs who are intimidated are likely to do as they are in-structed. They are also likely to harbor much resentment against the dragon that intimidates them. This resentment remains hidden until an opportunity for revenge presents itself (which may never happen).\n\nIntimidation can be attempted with either Strength or Charisma. Using Strength means a threat of immediate bodily harm. Charisma means the use of more subtle threats, which need not be physical in nature. Other PCs cannot be intimidated using this proficiency.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency1208: Proficiency = Proficiency(
    id: "intrigue",
    name: "Intrigue",
    wikiPageTitle: "Intrigue (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Charisma",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Charisma/Leadership",
            characterPointCost: 4,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "Intrigue: The proficiency is well-practiced in the haunts of the aristocracy (courts, temples, and universities).",
        fullText: "Intrigue: The proficiency is well-practiced in the haunts of the aristocracy (courts, temples, and universities). Through the use of this skill, a character can learn the current politics of the area and practice some subversion to gain his own political agenda. Whenever he has dealings with another person for purely political matters, he must attempt a proficiency check. A successful roll gives the character a hint from the DM on the result of his machinations. He might learn that he has succeeded in securing the loyalty of another's underling or barred another from rising in station. A failed roll often gives misinformation; the character might think he has achieved some success but in actuality has fallen from a superior's grace or insulted the wrong person and hindered his schemings. In all instances of a character using this proficiency, the roll should be made secretly by the DM."
    )
)

let embeddedProficiency1209: Proficiency = Proficiency(
    id: "investigation",
    name: "Investigation",
    wikiPageTitle: "Investigation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Investigation: This is the art of discovering the truth through careful examination of a problem or situation.",
        fullText: "Investigation: This is the art of discovering the truth through careful examination of a problem or situation. A character with this skill is familiar with the process of interviewing or interrogating witnesses, searching scenes for clues or information, and the general execution of a logical and thorough investigation. Priests who are associated with the local government may be called upon to solve common crimes against the state, while other priests may be inquisitors or theological investigators.\n\nThe DM may allow the PC to attempt a proficiency check when the player is missing an obvious line of inquiry or step of deductive reasoning, although this should be a rare use of this ability. An investigation proficiency check can also be used to discover clues at the scene of a crime or to extract information from a witness or suspect."
    )
)

let embeddedProficiency1210: Proficiency = Proficiency(
    id: "jousting",
    name: "Jousting",
    wikiPageTitle: "Jousting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 2,
        rawModifier: "+2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency includes the combat skills necessary for a successful joust, as well as the manners, behavior, and flair needed to impress an audience.",
        fullText: "## The Complete Paladin's Handbook\n\nThis proficiency includes the combat skills necessary for a successful joust, as well as the manners, behavior, and flair needed to impress an audience. To take this proficiency, a character must first have a weapon specialization in the jousting lance.\n\nA character with this proficiency modifies his attack rolls in a jousting match by +2 (see the \"Routine Activities\" section of Chapter 7 for jousting rules). The use of this proficiency presumes that the character has an adequate lance, shield, and mount.\n\nShould a character win a match, his stylish performance favorbly impresses the audience. Audience members with a special interest in the match (such as royalty, gamblers, or potential paramours) who later encounter the jouster modify their reaction rolls by +2. If he wins several matches in a tournament, the bonus doesn't rise above +2. If he later loses a match or two in the same tournament, he still earns the bonus. However, if the jouster has an especially disastrous day—say, if he follows a winning joust with a long string of losses—the audience may dismiss the win as a fluke, and the DM may cancel the bonus.\n\nCrossover Groups: Warrior."
    )
)

let embeddedProficiency1211: Proficiency = Proficiency(
    id: "juggling",
    name: "Juggling",
    wikiPageTitle: "Juggling (Proficiency)",
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
            subAbility: "Dexterity/Aim",
            characterPointCost: 3,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character can juggle, a talent useful for entertainments, diversions, and certain rare emergencies. When juggling normally (to entertain or distract), no proficiency check is required.",
        fullText: "## Player's Handbook\n\nThe character can juggle, a talent useful for entertainments, diversions, and certain rare emergencies. When juggling normally (to entertain or distract), no proficiency check is required. A check is made when trying spectacular tricks (\"Watch me eat this apple in mid-air!\"). However, juggling also enables the character to attempt desperate moves. On a successful attack roll vs. AC 0 (not a proficiency check), the character can catch small items thrown to harm him (as opposed to items thrown for him to catch). Thus, the character could catch a dagger or a dart before it hits. If this attack roll fails, however, the character automatically suffers damage (sticking your hand in the path of a dagger is likely to hurt).\n\n## Player's Option: Skills & Powers\n\nJuggling: A character with this proficiency can juggle up to three small objects without a proficiency check. Additional objects can be added, but a check is required; use a –1 modifier for each item beyond the fourth. Checks are also required for spectacular feats, such as juggling lighted torches or whirling scimitars, with failure meaning that 1d4 items are dropped. The potential for damage or disaster is left to the DM.\n\nThis skill is primarily useful for entertainment or diversions, though characters with the juggling proficiency have a chance to catch small objects—such as darts or daggers—that are thrown at them. They must be facing the source of the attack to make such an attempt, and they must make a proficiency check with a –2 modifier. Failure means they are automatically hit by the thrown objects."
    )
)

let embeddedProficiency1212: Proficiency = Proficiency(
    id: "jumping",
    name: "Jumping",
    wikiPageTitle: "Jumping (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue", "Barbarian"],
        slotsRequired: 1,
        rawSlots: "1 Slot (2 Slot for Barbarian)",
        relevantAbility: "Strength",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Strength/Muscle, Dexterity/Balance",
            characterPointCost: 2,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character can attempt exceptional leaps both vertically and horizontally. If the character has at least a 20-foot running start, he can leap (broad jump) 2d6+his level in feet.",
        fullText: "## Player's Handbook\n\nThe character can attempt exceptional leaps both vertically and horizontally. If the character has at least a 20-foot running start, he can leap (broad jump) 2d6+his level in feet. No character can broad jump more than six times his height, however. With the same start, he can leap vertically (high jump) 1d3 plus half his level in feet. No character can high jump more than 1-1/2 times his own height.\n\nFrom a standing start, a character with this proficiency can broad jump 1d6 plus half his level in feet and high jump only three feet.\n\nThe character can also attempt vaults using a pole. A vault requires at least a 30-foot running start. If a pole is used, it must be four to 10 feet longer than the character's height. The vault spans a distance equal to 1-1/2 times the length of the pole. The character can clear heights equal to the height of the pole. He can also choose to land on his feet if the vault carries him over an obstacle no higher than 1/2 the height of his pole. Thus, using a 12-foot pole, the character could either vault through a window 12 feet off the ground (tumbling into the room beyond), land on his feet in an opening six feet off the ground, or vault across a moat 18 feet wide. In all cases, the pole is dropped at the end of the vault.\n\n## Player's Option: Skills & Powers\n\nJumping: This skill means that a character has unusual abilities to jump across distances, leap incredible heights, and vault with a pole.\n\nA human or elven character with the jumping proficiency can perform a running broad jump of 20 feet without a proficiency check; a jump of more than 20 feet requires a check, with a –1 modifier for each foot above 20. The jumper can do a standing broad jump of 8 feet without a check; longer jumps require proficiency checks with the same penalties.\n\nThe character can high jump 4 feet without a check, higher obstacles require a check, with a –1 modifier for every 6\" of additional height. If jumping from a standing start, the beginning height is 3 feet, not 4 feet.\n\nDwarves, gnomes, and halflings are more limited in their jumping ability. For these characters, the basic distances in each category are reduced to 75% of the listed amount—e.g. 15 feet instead of 20 for the broad jump.\n\nA vaulting pole must be at least as tall as the character using it, but no more than twice as tall. The character can vault over obstacles up to the height of the pole. If the obstacles are within 2 feet of the pole's length, however, the character must make a proficiency check. The vaulter can also jump across a space no more than 11/2 the width of the pole's length. If the gap is greater than the length of the pole, a proficiency check is required.\n\n## The Complete Barbarian's Handbook Modifications\n\nAs discussed in Chapter 1, barbarians already have exceptional leaping and springing abilities. In most cases, spending slots on the jumping proficiency won't improve their natural skills. Barbarians usually won't attempt pole vaults, regardless of whether they have this proficiency."
    )
)

let embeddedProficiency1213: Proficiency = Proficiency(
    id: "kindredbond",
    name: "Kindredbond",
    wikiPageTitle: "Kindredbond (Proficiency)",
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
        briefSummary: "Both dragons and demihumans can take this proficiency. It allows a dragon to initiate the bonding process between itself and a selected demihuman vassal.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nBoth dragons and demihumans can take this proficiency. It allows a dragon to initiate the bonding process between itself and a selected demihuman vassal. All dragons of the Io's Blood isles must have this proficiency by juvenile age (4th level). The dragon can then bond with any one demihuman who also has this proficiency.\n\nThe bond establishes an empathic link between a dragon and its kindred. The pair can communicate through this link in a very limited way, with the dragon being able to receive much more than the kindred. If a dragon and its kindred are cooperating in a combat situation, the bond lets them coordinate their movements, giving both a +1 attack bonus and a +1 AC bonus. The bond is especially important for dragon riders (see kit details in Chapter Three). Hatchlings can't select this proficiency."
    )
)

let embeddedProficiency1214: Proficiency = Proficiency(
    id: "languages_ancient",
    name: "Languages, Ancient",
    wikiPageTitle: "Languages, Ancient (Proficiency)",
    redirectAliases: ["Ancient Languages", "Ancient Languages (Proficiency)"],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge",
            characterPointCost: 4,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character has mastered a difficult and obscure tongue, now primarily found in the writings of pedantic sages and sorcerers. The main use of the language is to read tomes of ancient secrets written by long-dead mystics.",
        fullText: "## Player's Handbook\n\nThe character has mastered a difficult and obscure tongue, now primarily found in the writings of pedantic sages and sorcerers. The main use of the language is to read tomes of ancient secrets written by long-dead mystics. This proficiency enables the character to either read and write or speak the language (his choice).\n\n## Player's Option: Skills & Powers\n\nAncient Languages: Adventurers with this proficiency are familiar with at least one ancient language—i.e. they have the reading/writing proficiency with the chosen languages. If confronted with an example of a historically-related language, they can decipher about a paragraph of that tongue with a successful proficiency check. For each character point spent on this proficiency (after initially acquiring it) add one additional ancient language to the list of languages a character knows fluently. The precise memory trait provides a +2 to this proficiency rating.\n\n## The Complete Barbarian's Handbook Modifications\n\nThe barbarian has mastered an obscure language associated with his homeland. Ancient barbaric languages don't necessarily involve words; they may consist of grunts, snorts, tongue clicks, or whistles. This proficiency enables the barbarian to vocally reproduce the language; he can't write or read it. The player should provide an explanation for the barbarian's fluency.\n\n## Campaign Option: Council of Wyrms Setting\n\nThis proficiency is described in the Player's Handbook: It allows a dragon to either speak or read and write a specific ancient language. Hatchlings can't select this proficiency."
    )
)
