import Foundation

/// Parte 22 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency2200: Proficiency = Proficiency(
    id: "survival",
    name: "Survival",
    wikiPageTitle: "Survival (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior (Rogue - Thief's Handbook)"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge, Wisdom/Willpower",
            characterPointCost: 3,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency must be applied to a specific environment—i.e., a specific type of terrain and weather factors. Typical environments include arctic, woodland, desert, steppe, mountain, or tropical.",
        fullText: "## Player's Handbook\n\nThis proficiency must be applied to a specific environment—i.e., a specific type of terrain and weather factors. Typical environments include arctic, woodland, desert, steppe, mountain, or tropical. The character has basic survival knowledge for that terrain type. Additional proficiency slots can be used to add more types of terrain.\n\nA character skilled in survival has a basic knowledge of the hazards he might face in that land. He understands the effects of the weather and knows the proper steps to lessen the risk of exposure. He knows the methods to locate or gather drinkable water. He knows how to find basic, not necessarily appetizing, food where none is apparent, thus staving off starvation. Furthermore, a character with survival skill can instruct and aid others in the same situation. When using the proficiency to find food or water, the character must roll a proficiency check. If the check is failed, no more attempts can be made that day.\n\nThe survival skill in no way releases the player characters from the hardships and horrors of being lost in the wilderness. At best it alleviates a small portion of the suffering. The food found is barely adequate, and water is discovered in minuscule amounts. It is still quite possible for a character with survival knowledge to die in the wilderness. Indeed, the little knowledge the character has may lead to overconfidence and doom!\n\n## Player's Option: Skills & Powers\n\nSurvival: A character with this proficiency has a basic knowledge of the dangers and challenges in certain wilderness terrain: arctic, woodland, desert, plains, or tropical. Mountains are not usually a separate terrain type-a mountain range may be tropical, wooded, snow-covered, etc.\n\nSurvival skill means the character has a good chance of finding food or water in that environment- if there is any to be found. The character can roll a proficiency check once a day for each category. Success means food, water, or shelter is found. Typically it will take 1d6 hours to find water, and 2d6 turns to forage enough food for one person.\n\nA character with this skill also understands the perils inherent in sudden storms and dangerous topical features- avalanches, quicksand, sandstorms, and landslides, for example. The DM might allow a player to roll a proficiency check when one of these dangers appears on the horizon- success means the character has noticed the menace.\n\n## The Complete Thief's Handbook\n\nRequired: Bandit.\n\nRecommended: Bounty Hunter.\n\nThis proficiency is normally restricted to warriors. Its description is on p.&nbsp;63 of the ''Player's Handbook.''\n\n## Note from The Complete Ranger's Handbook\n\nAll rangers have basic survival skills in their primary terrain. Additional proficiency slots may be spent to add more terrain types. Thus, if a ranger spends slots to acquire this proficiency, he must choose a terrain type other than his primary terrain, giving him the survival proficiency in two types of terrain.\n\n## The Complete Barbarian's Handbook Modifications\n\nEvery barbarian has basic survival skills in his homeland terrain; the survival proficiency isn't necessary. If a barbarian spends slots to acquire this proficiency, he chooses a terrain type other than his homeland terrain, thus giving him the survival proficiency in two terrains. More slots give survival skills in additional terrains. During character creation the player should justify how the barbarian has these proficiencies.\n\n## Campaign Option: Council of Wyrms Setting\n\nThis proficiency is described in the Player's Handbook. It gives a basic understanding of the natural hazards of the chosen environment. A successful check allows a dragon to find the location of whatever food or water might be available (failure means nothing was found and no more checks can be made that day).\n\nHatchlings can take this proficiency only for their natural terrain. For example, a hatchling bronze from the shores of the southern islands could take Survival (Jungle), but would have to wait until it advanced in level and gained additional noncombat proficiency slots before taking Survival (Arctic)."
    )
)

let embeddedProficiency2201: Proficiency = Proficiency(
    id: "survival_underground",
    name: "Survival, Underground",
    wikiPageTitle: "Survival, Underground (Proficiency)",
    redirectAliases: ["Underground Survival"],
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
        briefSummary: "Underground survival provides knowledge of the underground. It helps the character distinguish between edible and poisonous insects and to be able to determine the safety and stability of tunnels, cavern ceilings, and the like.",
        fullText: "## The Complete Book of Dwarves\n\nUnderground survival provides knowledge of the underground. It helps the character distinguish between edible and poisonous insects and to be able to determine the safety and stability of tunnels, cavern ceilings, and the like."
    )
)

let embeddedProficiency2202: Proficiency = Proficiency(
    id: "swimming",
    name: "Swimming",
    wikiPageTitle: "Swimming (Proficiency)",
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
            subAbility: "Strength/Stamina",
            characterPointCost: 2,
            baseRating: "9"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with swimming proficiency knows how to swim and can move according to the rules given in the Swimming section (Chapter 14: Time and Movement). Those without this proficiency cannot swim.",
        fullText: "## Player's Handbook\n\nA character with swimming proficiency knows how to swim and can move according to the rules given in the Swimming section (Chapter 14: Time and Movement). Those without this proficiency cannot swim. They can hold their breath and float, but they cannot move themselves about in the water.\n\n## Player's Option: Skills & Powers\n\nSwimming: This useful proficiency allows characters to swim according to the AD&D game rules for water movement (see the ''Player's Handbook'' for more information). Characters without this proficiency are considered untrained swimmers, and they can do little more than hold their breath and float. Proficient characters can perform most swimming tasks without any checks.\n\nFor each character point added to this proficiency after its initial purchase, swimmers can add 1 to their movement rates in water.\n\n## Campaign Option: Council of Wyrms Setting\n\nThis proficiency allows a dragon to swim. Those without the proficiency can do no more than hold their breath and float. Dragons with a swim (Sw) movement rate must take this proficiency before they can use this form of travel. Even dragons without the (Sw) rate can take this proficiency, though they are never as comfortable in the water as those who are naturally drawn to it.\n\nHatchlings can take this proficiency."
    )
)

let embeddedProficiency2203: Proficiency = Proficiency(
    id: "swoop",
    name: "Swoop",
    wikiPageTitle: "Swoop (Proficiency)",
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
        briefSummary: "This proficiency represents special training in the swoop maneuver; it provides the attacker a bonus +1 to hit and to damage.",
        fullText: "This proficiency represents special training in the swoop maneuver; it provides the attacker a bonus +1 to hit and to damage."
    )
)

let embeddedProficiency2204: Proficiency = Proficiency(
    id: "sword_swallowing",
    name: "Sword Swallowing",
    wikiPageTitle: "Sword Swallowing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows the player character to manipulate his mouth and throat to accept long and pointed objects like swords. The sword swallower also can swallow fire and do other muscle-related tricks with his throat.",
        fullText: "This proficiency allows the player character to manipulate his mouth and throat to accept long and pointed objects like swords. The sword swallower also can swallow fire and do other muscle-related tricks with his throat. The character gains +2 on saving throws against ingested poison because his throat reflexes are improved."
    )
)

let embeddedProficiency2205: Proficiency = Proficiency(
    id: "tactics",
    name: "Tactics",
    wikiPageTitle: "Tactics (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency gives a character who makes a successful check a +1 bonus on all attack or initiative rolls (player's choice) for the duration of a specific combat situation.",
        fullText: "## Dark Sun Campaign Setting Revised\n\nThis proficiency gives a character who makes a successful check a +1 bonus on all attack or initiative rolls (player's choice) for the duration of a specific combat situation. It requires that the character spend one round studying his opponent's movements before making the check. A successful check made after that round indicates that the character has some idea of what his opponent is planning to do in the combat and can act accordingly (hence the bonus). If the combat situation changes in any way (an opponent is eliminated or a new opponent enters the field), the character must take another round to analyze the situation and make another check to maintain the bonus.\n\nDuring the round when the character is studying his opponents, he may not make any attacks of his own. This includes using a psionic power of any type.\n\nIf a character devotes a second slot to this proficiency, he specializes in the study of one particular race in order to better understand its tendencies in combat. When using this proficiency against an opponent of that race, the character receives a +2 bonus on all attack or initiative rolls. This bonus can also be split, adding +1 to both types of rolls. A character can specialize in as many races as he wants, but the maximum bonus gained for any one of them is +2.\n\nThis proficiency doesn't give any bonuses against groups of four or more opponents unless they are all of a race in which a character has specialized. Even then, it can never be used against more than five opponents of that racial type. Furthermore, the bonus never applies to a character's companions—just to the character himself.\n\n## The Complete Gladiator's Handbook\n\nThe gladiator who takes the Tactics proficiency gains a +1 bonus on attack or initiative rolls (player s choice) in any given combat by taking a round to study his opponent's movements. A successful proficiency roll indicates that the gladiator has some idea of what his opponent plans in combat. When one of the combatants is eliminated, the gladiator must again step back a round to analyze the situation and make a new proficiency check if he is to keep the bonus he has gained. He may parry attacks in this round, but may not initiate any himself. This includes uses of his psionic wild talent, no matter what it may be. Nearly all his attention is focused on divining the intent of his enemies.\n\nFurthermore, if the gladiator wishes to devote another slot to this proficiency, he may choose to study one particular race in order to better understand its tendencies. In this case, the gladiator gains a +2 bonus to attack or initiative rolls when using this proficiency. Alternatively, the gladiator may choose to split the bonus, and take +1 on attacks and +1 to initiative. The gladiator may specialize in as many races as he likes, but can gain only a maximum bonus of +2 to any particular races' tendencies.\n\nThis proficiency does not apply to groups of four or more opponents, unless the opponents' race is one the gladiator has studied extensively. In this case, the proficiency can apply to as many as five opponents, but never more than that. This proficiency does not apply to the gladiator's partners. The gladiator specializes in tactics, not in strategy.\n\n## Age of Heroes Campaign Sourcebook\n\nTactics: The character knows about successful tactics used in past military operations and has a grounding in current tactics and formations. This applies to both land and sea military operations and includes knowledge of famous battles and passages from *The Iliad*. This skill is less comprehensive than the military science NWP in HR5 *The Glory of Rome*.\n\nA successful tactics check gives some insight into planning a strategy, highlights problems in a strategy being planned, or shows some weakness in the enemy lines. A successful roll at a -5 penalty allows characters to make a plan (with DM help, of course) which may help their group. It will not guarantee victory, just give them a fighting chance."
    )
)

let embeddedProficiency2206: Proficiency = Proficiency(
    id: "tactics_of_magic",
    name: "Tactics of Magic",
    wikiPageTitle: "Tactics of Magic (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Tactics of Magic: For many wizards, the principal use of their art is on the battlefield. Knowing which spell to employ at any given time and creating the greatest effect for one's effort is a skill that can be learned with practice and experience.",
        fullText: "Tactics of Magic: For many wizards, the principal use of their art is on the battlefield. Knowing which spell to employ at any given time and creating the greatest effect for one's effort is a skill that can be learned with practice and experience. A wizard with the tactics of magic proficiency can attempt a proficiency check to gauge the range to a target, estimate how many enemies will be caught in a given area of effect, or determine whether or not he may be in danger of a rebounding lightning bolt or a fireball cast in too small a space.\n\nIn addition, a character with this skill may recall subtle effects or interactions that are not immediately apparent. For example, if the wizard is about to cast magic missile at an enemy wizard protected by a shield spell, the DM may allow the player a proficiency check to see if he suddenly recalls that the magic missile will fail—especially if the wizard also knows shield, but the player has just forgotten about the special effects of the spell. However, if there's no way the character could know of a special immunity or property of a monster, spell, or magical item, this proficiency will not be of any help."
    )
)

let embeddedProficiency2207: Proficiency = Proficiency(
    id: "tattooing",
    name: "Tattooing",
    wikiPageTitle: "Tattooing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This is the art of injecting dyes beneath the surface of the skin in order to create lasting art upon the human body. The process is painful for the subject and difficult for the tattoo artist because skin isn't the best medium with which to work.",
        fullText: "## The Complete Sha'ir's Handbook\n\nThis is the art of injecting dyes beneath the surface of the skin in order to create lasting art upon the human body. The process is painful for the subject and difficult for the tattoo artist because skin isn't the best medium with which to work.\n\nThis proficiency is necessary to cast the tattoo of power spell, though it isn't necessary to make a successful proficiency check when using this proficiency to cast that spell. The magic is able to guide an experienced hand in the correct patterns and designs to make with the dye."
    )
)

let embeddedProficiency2208: Proficiency = Proficiency(
    id: "taunting",
    name: "Taunting",
    wikiPageTitle: "Taunting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Gladiator (Warrior)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Taunting: This proficiency enables the gladiator to taunt, goad, and in all ways be annoying and offensive to the enemy. If the gladiator makes the proficiency check and the opponent fails a saving throw vs.",
        fullText: "## The Complete Gladiator's Handbook\n\nTaunting: This proficiency enables the gladiator to taunt, goad, and in all ways be annoying and offensive to the enemy. If the gladiator makes the proficiency check and the opponent fails a saving throw vs. paralyzation, the foe becomes enraged. An enraged foe receives a —2 attack penalty, but +1 to damage. In addition, enemies are generally so blinded by rage that they fail to notice the small details essential to good combat, and therefore suffer a —1 to AC\n\nNPCs with Wisdom of 14 or greater are immune to this effect, as are those 5 or more levels higher than the gladiator. They recognize the taunt for what it is, and may choose to disregard its effects if they wish. PCs are also immune, though they should play out their natural reactions to such acts. The DM should always take the personality of the taunted character, whether PC or NPC, into account."
    )
)

let embeddedProficiency2209: Proficiency = Proficiency(
    id: "tease",
    name: "Tease",
    wikiPageTitle: "Tease (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Council of Wyrms"],
    mechanics: ProficiencyMechanics(
        groups: ["Dragons"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Tease allows a dragon to jape and jeer an opponent into acting rashly. The teasing dragon must have initiative.",
        fullText: "## Campaign Option: Council of Wyrms Setting\n\nTease allows a dragon to jape and jeer an opponent into acting rashly. The teasing dragon must have initiative. Teasing affects a single opponent with an Intelligence score of 4 or better. Although teasing includes gestures and body language, the opponent must be able to understand the teasing in order to be affected. Success means the teasing works, failure means it doesn't. A natural 20 means the opponent will unleash its most devastating attack form against the teaser.\n\nA successfully teased opponent rushes to attack the teasing dragon with physical force, ignoring any innate abilities, spells, ranged attacks, magic, or breath weapons of its own. Teasing effects last for one round, during which the teasing dragon is limited to physical attacks.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency2210: Proficiency = Proficiency(
    id: "thaumaturgy",
    name: "Thaumaturgy",
    wikiPageTitle: "Thaumaturgy (Proficiency)",
    redirectAliases: [],
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
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Thaumaturgy: This is the art of the casting of magic, the study of the interaction of verbal, somatic, and material components in order to produce a desired effect.",
        fullText: "Thaumaturgy: This is the art of the casting of magic, the study of the interaction of verbal, somatic, and material components in order to produce a desired effect. While all wizards have some degree of familiarity with this field of knowledge, a character who becomes proficient in thaumaturgy has spent time studying the forms and practices of magic. This depth of knowledge gives the wizard a +5% bonus on his learn spell rolls after a successful nonweapon proficiency check has been made."
    )
)

let embeddedProficiency2211: Proficiency = Proficiency(
    id: "theory",
    name: "(School) Theory",
    wikiPageTitle: "(School) Theory (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: ["Magecraft"]
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge",
            characterPointCost: 5,
            baseRating: "7"
        ),
    description: ProficiencyDescription(
        briefSummary: "Over and above the basic familiarity that any mage or any character with the Magecraft NWP possesses, each of the following NWPs represents an intensive study of a particular type of magic.",
        fullText: "Over and above the basic familiarity that any mage or any character with the Magecraft NWP possesses, each of the following NWPs represents an intensive study of a particular type of magic. The character has formal knowledge of all common, uncommon, and rare spells or items from a particular school of magic and can make educated guesses about new spells (including \"name\" and unique spells) and items from that school.\n\nPrerequisite: Magecraft.\n\nSpecialists may identify and study spells and magical items from their oppositional school(s) but suffer a -6 penalty to their proficiency checks; on the other hand, specialists enjoy a +3 bonus when studying or identifying spells and items from their own schools. Benefits common to all school NWPs:\n\n* Mages with a particular school proficiency gain a +5% bonus to learn or research a new spell from that school (in addition to the specialist's existing bonus) and a +5% bonus to create a scroll, potion, or other magical item that harnesses magic from that school.\n\n* Mages may make one proficiency check at the beginning of any research or construction attempt. Success means that the required time has been reduced by one week or that the mage has deduced the exact nature of any one exotic or unusual material required.\n\n* The character no longer needs to observe a spellcasting to identify the spell. Traces of energy, second-hand reports, or characteristic odors are often all that is needed. The character may make a proficiency check with a -4 penalty to identify the most recently cast spell in a particular area. Of course, the spell must be from the appropriate school and must have been cast less than one day earlier.\n\n* Non-spellcasters who have come this far in their studies gain an understanding of magic approaching that of a beginning mage. They have the ability to read (but not use) spellbooks and scrolls, provided the spells are of the appropriate school; a successful proficiency check is required. In addition, the non-spellcaster gains a +1 bonus to any saving throws against that particular school of magic.\n\n## Unique Benefits of Each School Theory\n\nAbjuration Theory. Understanding of magical avoidance, repelling, and warding. On a successful proficiency check, the character can spot an existing protection or glyph spell and attempt a second check to determine the exact type.\n\nAlteration Theory. Knowledge of how magic can change an existing object, creature, or condition. On a successful proficiency check, the character can spot a shape-changed, polymorphed, or magically-altered creature, although he cannot determine the creature's true form. This proficiency check is rolled by the DM (secretly) when the character first encounters the creature or when the player declares that his character is concentrating on a specific creature or individual. Lycanthropes and \"natural\" shapeshifters (like doppelgangers) are not revealed.\n\nConjuration Theory. Knowledge of the calling of matter or creatures from another place. The character has a familiarity with the structure of the Outer and Inner Planes and can recognize a particular planar creature or artifact on a successful proficiency check. In addition, the character may make a proficiency check after 1-10 rounds of careful observation to tell if an animal is currently under the control of a summoner.\n\nDivination Theory. Advanced study of magical detection techniques and knowledge-gathering. The character is always allowed a proficiency check against half his skill (rounded down) when targeted with any form of divination magic. Success means the character feels that \"someone is watching him.\" The character is also familiar with common forms of divination in the game world (astrology, cards, and so on). If these work in the campaign world, the character may perform one divination each week (treat as an augury spell).\n\nEnchantment/Charm Theory. Knowledge of enchantments placed upon objects and creatures. On a successful proficiency check, the character gains information equal to the result of a bard's Legend Lore skill about a given magical item. In addition, the character may spot a magical charm, geas, or similar spell after carefully observing the affected creature for 1-10 rounds and making a successful proficiency check.\n\nIllusion Theory. Study of illusions, phantasms, and shadow magic. The keen insights and knowledge of psychology required to understand illusion magic make the character very sensitive to subtle nuances of behavior. On a successful check, the character can tell if he is being deliberately lied to (although the truth is not revealed).\n\nInvocation/Evocation Theory. Study of the flashy and dramatic invocation/evocation spells. On a successful proficiency check, the character may perform a single evocation cantrip, such as a single puff of smoke, a spark hot enough to light dry paper, a light equal to that of a small candle, or other minor magical effect. Like any other cantrip, this spell cannot harm any but the smallest of creatures and cannot disrupt anyone's concentration. On a natural \"20,\" the cantrip is miscast (e.g., gives a hotfoot to the king, sets fire to the drapes, etc.—DM's choice).\n\nNecromantic Theory. The darkest of the studies, the study of life and death and how very thin the barrier between them can be. The student of necromantic lore may conduct research (as per magical item construction) into golem construction, is an expert embalmer, and gains a +1 bonus to all Healing checks. However, the character's knowledge of life and death brings an increasing detachment from society that can be sensed by others. The character suffers a -1 Reaction penalty for every four experience levels (rounded down)."
    )
)

let embeddedProficiency2212: Proficiency = Proficiency(
    id: "thespian",
    name: "Thespian",
    wikiPageTitle: "Thespian (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Tradesman (MotRD)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters with this proficiency are skilled performers with experience on the stage. Whether this represents a past in the so-called legitimate theater or experience in the far less respected venues of vaudeville or burlesque.",
        fullText: "## Dragon Magazine #215\n\nCharacters with this proficiency are skilled performers with experience on the stage. Whether this represents a past in the so-called legitimate theater or experience in the far less respected venues of vaudeville or burlesque. A skilled thespian is able to adopt the mannerisms and speech patterns of those he's impersonating with great efficacy. A character who successfully combines this skill with the Disguise talent can withstand even the closest scrutiny by critics or audiences.\n\nMany players will want to combine this skill with others such as Singing or Dancing, to reflect backgrounds in specific types of theater such as opera or ballet."
    )
)

let embeddedProficiency2213: Proficiency = Proficiency(
    id: "throwing",
    name: "Throwing",
    wikiPageTitle: "Throwing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "N/A",
        relevantAbility: "N/A",
        checkModifier: 0,
        rawModifier: "N/A",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Dexterity/Aim, Strength/Muscle",
            characterPointCost: 2,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "Throwing: Characters with this proficiency add 10' to each range category of thrown weapons, and increases the damage or the attack roll by +1 each time they throw a weapon.",
        fullText: "Throwing: Characters with this proficiency add 10' to each range category of thrown weapons, and increases the damage or the attack roll by +1 each time they throw a weapon. The player can elect to improve either the damage or attack roll, but the choice must be announced before the attack is made.\n\nFor each character point spent on this proficiency (after its initial purchase) a character adds another 5' to thrown weapon ranges. For every 4 additional character points spent, another +1 on the damage or attack rolls is gained—this can be used as a +2 on one or the other, or split as a +1 to attack and +1 to damage."
    )
)

let embeddedProficiency2214: Proficiency = Proficiency(
    id: "tightrope_walking",
    name: "Tightrope Walking",
    wikiPageTitle: "Tightrope Walking (Proficiency)",
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
            subAbility: "Dexterity/Balance",
            characterPointCost: 3,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character can attempt to walk narrow ropes or beams with greater than normal chances of success. He can negotiate any narrow surface not angled up or down greater than 45 degrees.",
        fullText: "## Player's Handbook\n\nThe character can attempt to walk narrow ropes or beams with greater than normal chances of success. He can negotiate any narrow surface not angled up or down greater than 45 degrees. Each round the character can walk 60 feet. One proficiency check is made every 60 feet (or part thereof), with failure indicating a fall. The check is made with a -10 penalty to the ability score if the surface is one inch or less in width (a rope), a -5 penalty if two inches to six inches wide, and unmodified if seven inches to 12 inches wide. Wider than one foot requires no check for proficient characters under normal circumstances. Every additional proficiency spent on tightrope walking reduces these penalties by 1. Use of a balancing rod reduces the penalties by 2. Winds or vibrations in the line increases the penalties by 2 to 6.\n\nThe character can attempt to fight while on a tightrope, but he suffers a -5 penalty to his attack roll and must roll a successful proficiency check at the beginning of each round to avoid falling off. Since the character cannot maneuver, he gains no adjustments to his Armor Class for Dexterity. If he is struck while on the rope, he must roll an immediate proficiency check to retain his balance.\n\n## Player's Option: Skills & Powers\n\nTightrope Walking: The character with this proficiency can balance on ropes, wires, slender beams, and other narrow, perilous surfaces. A typical movement rate is 60 feet a round, though an upward angle will slow this. Ascents and descents of 45 degrees or more are not possible.\n\nThe character does not require a proficiency check if the surface is at least 4\" wide. Narrower surfaces require checks, with failure indicating a fall. If walking on a flat surface more than an inch wide, the character receives a +3 modifier to the check. A balance pole adds another +2 modifier, though high winds or a moving surface can contribute significant negatives.\n\nIf the character makes an attack or suffers damage while balanced on a rope, a proficiency check is required. Failure signals a fall. Subtract the number of points of damage the character suffered from the proficiency rating when this check is made. Attacks made while on the rope suffer –5 penalties on attack rolls. Also, a character walking on a tightrope has limited maneuverability and therefore does not gain an AC bonus for Dexterity.\n\n## The Complete Barbarian's Handbook Modifications\n\nA barbarian with this proficiency has an unusually developed sense of balance. In his homeland, a barbarian might use this skill to negotiate a narrow mountain ledge or scamper across a vine strung between two trees. The same bonuses and penalties apply as described in the ''Player's Handbook''; however, a barbarian rarely uses a balancing rod."
    )
)
