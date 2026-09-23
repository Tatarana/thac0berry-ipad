import Foundation

/// Parte 2 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency0200: Proficiency = Proficiency(
    id: "anti_mucous_bulwark",
    name: "Anti-Mucous Bulwark",
    wikiPageTitle: "Anti-Mucous Bulwark (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Caradhaker Only"],
        slotsRequired: 5,
        rawSlots: "5 slots",
        relevantAbility: "Wisdom",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "In non-psionic campaigns, the mental disciplines of the mindstalkers take the form of “evolved proficiencies.” Of course, these proficiencies are much more expensive than usual and thus not easily acquired.",
        fullText: "## Dragon Magazine #230\n\nIn non-psionic campaigns, the mental disciplines of the mindstalkers take the form of “evolved proficiencies.” Of course, these proficiencies are much more expensive than usual and thus not easily acquired. Furthermore, if a mindstalker in a non-psionic campaign takes even one of these evolved proficiencies, he or she immediately accrues the Constitution penalty described above under special hindrances in the mindstalker kit.\n\nMuch of a mind flayer's physical integrity is tied up in its hideous mauve skin and the thin layer of mucous that glistens thereon. Not only does the mucous serve to keep the illithid's skin moist but it also is tied in with their powers of mind and even their magic resistance, to some degree. (See The Illithid Monstrous Arcana tome for a full explanation of this intricate relationship.) Thus, this power has significant potential to harm an illithid.\n\nWhen this proficiency is triggered successfully, the Mindstalker consciously takes control of his own biochemistry to a limited degree through biofeedback techniques. Through effort of mind alone, the dwarf exudes an oily, alkaline sweat over his or her entire body for a period of one turn/level. A dwarf using this power looks as if it has just completed a mighty task and is drenched from head to foot in strange-smelling perspiration. Because the sweat can get in a dwarf's eyes and slick his palms, the caradhaker suffers a -1 penalty to attacks while coated, but that is a small price to pay for a barrier that acts like a powerful detergent against illithid mucous.\n\nWhen an illithid makes a successful physical attack (such as a tentacle strike) against a dwarf with an active anti-mucous bulwark, the illithid suffers 1d10 hp damage and lowers its magic resistance (MR) by 1d10 percent. (Note that an illithid's MR never drops below a base 18 percent.) Moreover, cumulative damage and MR drain occurs for every round an illithid remains in contact with a dwarf using this power, as might happen when an illithid attempts to attach its tentacles to a victim in preparation to draw out the brain). As might be expected, an illithid that runs across a caradhaker with this proficiency usually chooses to avoid pressing a physical attack. Of course, this doesn't stop a caradhaker from attempting to punch or make overbearing attacks against an illithid so as to bring its anti-mucous bulwark into play.\n\nUnless an illithid is killed through the use of this power, its MR score returns at a rate of 3 percent per hour; however, hit points return at their normal rate."
    )
)

let embeddedProficiency0201: Proficiency = Proficiency(
    id: "appraising",
    name: "Appraising",
    wikiPageTitle: "Appraising (Proficiency)",
    redirectAliases: ["Appraisal"],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Reason, Wisdom/Intuition",
            characterPointCost: 2,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency is highly useful for thieves, as it allows characters to estimate the value and authenticity of antiques, art objects, jewelry, cut gemstones, or other crafted items they find (although the DM can exclude those items too exotic or rare to be well known).",
        fullText: "## Player's Handbook\n\nThis proficiency is highly useful for thieves, as it allows characters to estimate the value and authenticity of antiques, art objects, jewelry, cut gemstones, or other crafted items they find (although the DM can exclude those items too exotic or rare to be well known). The character must have the item in hand to examine. A successful proficiency check (rolled by the DM) enables the character to estimate the value of the item to the nearest 100 or 1,000 gp and to identify fakes. On a failed check, the character cannot estimate a price at all. On a roll of 20, the character wildly misreads the value of the item, always to the detriment of the character.\n\n## Player's Option: Skills & Powers\n\nThis skill allows the character to make generally accurate (+ or –10%) assessments of common objects, including items made of precious metals and gemstones. The character can also assess, to + or –25%, the value of objects of art, tapestries, furniture, weapons, etc.—provided a variety of these items are present in the game world. These assessments require no proficiency checks, and the DM can roll (d20 or d100) to determine the accuracy of the appraisal.\n\nA character who passes a proficiency check will be able to identify a forgery of a valuable object, to make a very accurate assessment of the value of a common item (within 5%), or to make a general assessment of the worth of an uncommon item, including artifacts. The DM may wish to roll this check, and on a roll of 20 the character makes a wildly inaccurate assessment.\n\n## Campaign Option: Council of Wyrms Setting\n\nThis proficiency allows a dragon to accurately appraise the authenticity and value of antiques, art objects, jewellery, cut gem stones, or other crafted\n\nitems it can use for its treasure hoard. Success on the roll means the dragon determines the item's value. Failure means the dragon cannot establish the exact value. A roll of 20 means the item has no value to the dragon. Hatchlings can't select this proficiency."
    )
)

let embeddedProficiency0202: Proficiency = Proficiency(
    id: "arcanology",
    name: "Arcanology",
    wikiPageTitle: "Arcanology (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Arcanology: The study of the history and development of magic is termed arcanology. A wizard with expertise in this field is familiar with the works of past wizards.",
        fullText: "Arcanology: The study of the history and development of magic is termed arcanology. A wizard with expertise in this field is familiar with the works of past wizards. If there was a source of powerful magic in the campaign's past—for example, Netheril or Myth Drannor in the Forgotten Realms campaign setting—the arcanologist has a good idea of who the great mages were and what they were able to accomplish. Special magical items, spells, or forms of magic wielded by these ancient sorcerers are familiar to the arcanologist. With a successful proficiency check, the arcanologist can identify the general purpose and function of an ancient magical item; the DM may apply a penalty of –1 to –4 if the item comes from a region outside the arcanologist's normal studies, or is especially rare or obscure. Note that this ability doesn't help a wizard to identify items manufactured by the \"modern\" school or tradition of magic, whatever that may be."
    )
)

let embeddedProficiency0203: Proficiency = Proficiency(
    id: "arena_acting",
    name: "Arena Acting",
    wikiPageTitle: "Arena Acting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Gladiator (Warrior)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The Acting proficiency allows the gladiator to feign a weakness in the arena to trick his opponent. If the check is successful, he has shown a weakness he does not really possess.",
        fullText: "## The Complete Gladiator's Handbook\n\nThe Acting proficiency allows the gladiator to feign a weakness in the arena to trick his opponent. If the check is successful, he has shown a weakness he does not really possess. For example, he could convince an enemy that his left side is overexposed, or that his weapons are unfamiliar in his hands. More often than not, these tricks succeed. If the enemy attacks against the gladiator's assumed weakness, the PC attacks his foe with a +3 bonus to attack and damage rolls. These reflect the surprise the target feels upon realizing he has been duped.\n\nArena Acting can work only once against any given opponent. Thereafter, the enemy is far more cautious in his attacks."
    )
)

let embeddedProficiency0204: Proficiency = Proficiency(
    id: "armor_optimization",
    name: "Armor Optimization",
    wikiPageTitle: "Armor Optimization (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Dark Sun"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 slot",
        relevantAbility: "Dexterity",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency allows a character to use his armor to best advantage against a particular opponent (much like the gladiator special ability).",
        fullText: "## Dark Sun Campaign Setting Revised\n\nThis proficiency allows a character to use his armor to best advantage against a particular opponent (much like the gladiator special ability). A successful proficiency check in the first round of any combat situation gives a -1 bonus to the character's Armor Class until that combat comes to an end.\n\nA situation is a series of rounds in which a particular character engages in one bout of combat. Once the character allows two full rounds to pass without engaging in combat, the situation ends.\n\nA character must be wearing some type of armor or employing a shield in order to use the armor optimization proficiency. The bonus granted by the successful use of the armor optimization proficiency adds to the Armor Class provided by the armor or shield. The bonus for the proficiency also adds to that gained by a gladiator character's special ability."
    )
)

let embeddedProficiency0205: Proficiency = Proficiency(
    id: "armorer",
    name: "Armorer",
    wikiPageTitle: "Armorer (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge, Strength/Muscle",
            characterPointCost: 5,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "This character can make all of the types of armor listed in the Player's Handbook, given the proper materials and facilities. When making armor, the proficiency check is rolled at the end of the normal construction time.",
        fullText: "## Player's Handbook\n\nThis character can make all of the types of armor listed in the Player's Handbook, given the proper materials and facilities. When making armor, the proficiency check is rolled at the end of the normal construction time.\n\nThe time required to make armor is equal to two weeks per level of AC below 10. For example, a shield would require two weeks of work, whereas a suit of full plate armor would require 18 weeks of work.\n\nIf the proficiency check indicates failure but is within 4 of the amount needed for success, the armorer has created usable, but flawed, armor. Such armor functions as 1 AC worse than usual, although it looks like the armor it was intended to be. Only a character with armorer proficiency can detect the flaws, and this requires careful and detailed inspection.\n\nIf the flawed armor is struck in melee combat with a natural die roll of 19 or 20, it breaks. The character's AC immediately worsens by 4 additional classes (although never above 10), and the broken armor hampers the character's movement. Until the character can remove the broken armor (a process requiring 1d4 rounds), the character moves at 1/2 of his normal rate and suffers a -4 penalty to all of his attack rolls.\n\nIf an armorer is creating a suit of field plate or full plate armor, the character who will use the armor must be present at least once a week during the creation of the armor, since such types of armor require very exact fitting.\n\n## Player's Option: Skills & Powers\n\nA character with this proficiency can make the types of armor typically available in the campaign world. The armorer requires the proper raw materials (plate metal, tough leather, etc.) and enough time to do the job properly. Time ranges from about two weeks for a shield to 20 weeks for a suit of plate mail armor. No proficiency check is required generally, though if the armorer tries to rush the job or work with less than adequate materials a proficiency check should be rolled to determine if the character is successful.\n\nThe armorer can also make field repairs to armor that has been damaged through use. These repairs always require proficiency checks, and if the check fails the armor or shield is lost.\n\n## The Complete Book of Dwarves\n\nDwarves are more adept at making armor than other races. Their armorers are the finest in any world and their special skills are carefully hidden from outsiders. They are capable of producing high quality armor very quickly. Instead of 2 weeks per level of AC below 10, a dwarf armorer requires only 12 weeks per point of AC below 10. While a human armorer takes 10 weeks to make a suit of chain mail, a dwarf armorer labors only 72 weeks (5 H 12).\n\n''The Complete Fighter's Handbook'' contains extensive rules about the use of the armorer proficiency and is recommended to any character interested in utilizing this proficiency to the fullest.\n\n## Note from The Complete Paladin's Handbook\n\nThis proficiency also allows characters to construct barding for mounts, presuming the availability of materials and facilities. Table 24 gives the time required to make barding for war horses, and mounts of comparable size. For smaller or larger mounts, the DM should adjust the times accordingly. Elephant barding might require an extra week or two; barding for a small mule might take a week less. Subtract two weeks for all types of half barding.\n\n{| class=\"article-table\"\n|+ Table 24: Barding Construction Times\n! Barding Type || AC || Time (weeks)*\n|-\n| Leather, Padded || 6 || 4\n|-\n| Scale, Brigandine, || 5 || 8\n|-\n|  Ring, Studded Leather || || \n|-\n| Chain || 4 || 10\n|-\n| Banded, Splint || 3 || 14\n|-\n| Plate || 2 || 16\n|-\n| Field Plate || 1 || 18\n|-\n| Full Plate || 0 || 20\n|}\nAs with character armor, barding may be flawed. After creating the barding, the DM secretly makes a proficiency check. If the check fails but is within 4 of a successful result, the character believes the armor is normal, until in combat it functions as 1 AC worse (flawed chain barding has an effective AC of 5). Flawed armor breaks on a natural roll of 19 or 20 in melee combat; the animal's AC then worsens by 4, though it can't be reduced below AC 10 (if flawed leather barding breaks, it has an effective AC of 9). As long as a mount wears broken armor, its movement rate is halved, and it suffers a –4 penalty to its attack rolls. A character can remove broken armor from a mount in 2-8 (2d4) rounds.\n\nBecause barding must be fitted exactly, a set of barding styled for one mount won't work for any other animal, even of the same species."
    )
)

let embeddedProficiency0206: Proficiency = Proficiency(
    id: "armorer_crude",
    name: "Armorer, Crude",
    wikiPageTitle: "Armorer, Crude (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "With this proficiency, a character can make crude but effective armor from natural materials like hides, furs, and shells. He can't create armor better than AC 6.",
        fullText: "With this proficiency, a character can make crude but effective armor from natural materials like hides, furs, and shells. He can't create armor better than AC 6.\n\nIt takes one week per level of AC below 10 to make crude armor (assuming the availability of the necessary materials). A character can make hide armor in four weeks, a shield in one week.\n\nCrude armor tends to be more flawed and less durable than standard armor. After crude armor is created, make a proficiency check. If the check fails by more than 4, the armor is unusable. If a failed check is within 4 of the amount needed for success, the armor is flawed and functions at an AC 2 worse than normal (but never worse than AC 10). Flawed crude hide armor has AC 8; a flawed crude shield offers no protection whatsoever.\n\nIf flawed crude armor is struck in melee with a natural die-roll of 19 or 20, it falls apart. The wearer's AC immediately worsens by 4 (to a limit of AC 10). Removing the useless armor takes 1d4 rounds; during that time, the wearer moves at half his normal rate and suffers a -4 penalty to all attack rolls.\n\nCrossover Group: Warrior."
    )
)

let embeddedProficiency0207: Proficiency = Proficiency(
    id: "art_expression_dramatist",
    name: "Art Expression/Dramatist",
    wikiPageTitle: "Art Expression/Dramatist (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Art Expression/Dramatist: The character has a knowledge of comedy and tragic drama and the ability to write plays. This confers the ability to critique other plays as well.",
        fullText: "## Age of Heroes Campaign Sourcebook\n\nArt Expression/Dramatist: The character has a knowledge of comedy and tragic drama and the ability to write plays. This confers the ability to critique other plays as well. If the character rolls a 1 on a proficiency check when creating a new drama or comedy, the work is a masterpiece with lasting value."
    )
)

let embeddedProficiency0208: Proficiency = Proficiency(
    id: "artifice",
    name: "Artifice",
    wikiPageTitle: "Artifice (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Wisdom",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Artifice allows a Machine Mage to repair or cobble together working machines from pre-existing parts, “improve” the capabilities of extant machines (if the requisite material is on hand), and incorporate salvaged machine modules into unique items.",
        fullText: "## Dragon Magazine #258\n\nArtifice allows a Machine Mage to repair or cobble together working machines from pre-existing parts, “improve” the capabilities of extant machines (if the requisite material is on hand), and incorporate salvaged machine modules into unique items.\n\nAt the most elementary level, Artifice allows a Wizard with this proficiency to reactivate a “dead” sheen with a successful proficiency check. Using Salvage, the Mage rolls a dodecathlon chart for modifiers to the base check based on the method used to deactivate the sheen. Often, the parts of two or more sheens must be used to cobble together a single working unit. (The rule of thumb: If a sheen was brought to ~20&nbsp;hp or below, its remaining parts are not sufficient for repair; additional sheen parts from another machine must be provided.) On a successful check, the sheen regains basic functionality, although it still suffers a -2 penalty on all actions due to its previous incapacity. With the application of Digital Persuasion prior to bringing the machine back online, the Machine Mage might have made a new friend.\n\nAnother aspect of Artifice is the Machine Mage's ability to improve the capabilities of a functioning sheen or to create new ones.\n\nThe possibilities for the sheen include heightened intelligence, an ability to trigger preset spells, and heightened damage and defense capabilities.\n\nEvery time the Machine Mage increases a level, he must roll both requisite proficiency checks on a captured sheen. If successful in both, he can pick a category listed above or suggest a new one to the DM. With the DM's approval, the indicated capacity is gained or heightened. The DM must exercise extreme care to make sure that this benefit doesn't become over-balancing. The general guideline for a heightened capability score or damage potential is 1d4 points. New abilities that inflict damage should similarly start low and gain increased effectiveness only with successive levels and successful checks by the Machine Mage."
    )
)

let embeddedProficiency0209: Proficiency = Proficiency(
    id: "artillerist",
    name: "Artillerist",
    wikiPageTitle: "Artillerist (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma/Leadership",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency can direct the siting and operation of a bombardment engine.",
        fullText: "## Combat & Tactics\n\nA character with this proficiency can direct the siting and operation of a bombardment engine. The maximum number of engines the character can control is equal to 1/3 of the character's Charisma/Leadership score, provided that the engines are no farther apart than the character can sprint in a single round.\n\n## Castle Guide Text\n\nThose with this skill are trained in the use of various siege engines. In addition to preventing the drawbacks of nonproficient weapon use, if a character with this skill commands the crew of a bombardment engine (i.e., is within 1\" of the weapon when it fires), the chance of a shot scattering is halved. Warriors may specialize in this skill, but there is no change to the weapon's rate of fire for experience levels or specialization."
    )
)

let embeddedProficiency0210: Proficiency = Proficiency(
    id: "artistic_ability",
    name: "Artistic Ability",
    wikiPageTitle: "Artistic Ability (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Player characters with artistic ability are naturally accomplished in various forms of the arts. They have an inherent understanding of color, form, space, flow, tone, pitch, and rhythm.",
        fullText: "## Player's Handbook\n\nPlayer characters with artistic ability are naturally accomplished in various forms of the arts. They have an inherent understanding of color, form, space, flow, tone, pitch, and rhythm. Characters with artistic ability must select one art form (painting, sculpture, composition, etc.) to be proficient in. Thereafter they can attempt to create art works or musical compositions in their given field. Although it is not necessary to make a proficiency check, one can be made to determine the quality of the work. If a 1 is rolled on the check, the artist has created a work with some truly lasting value. If the check fails, the artist has created something aesthetically unpleasing or just plain bad.\n\nArtistic ability also confers a +1 bonus to all proficiency checks requiring artistic skill—music or dance—and to attempts to appraise objects of art.\n\n## The Complete Barbarian's Handbook Modifications\n\nA barbarian must select an art form common to his homeland. Acceptable choices include cave painting, plainsong (a style of singing based on approximate pitches instead of fixed intervals, performed without harmony or instrumental accompaniment), crude sculpting (in clay, wood, or bone), and primitive mosaics (colored pebbles or bits of bone arranged in appealing patterns).\n\nA barbarian with the artistic ability proficiency receives a +1 bonus to dancing and musical instrument proficiency checks.\n\n## Shaman\n\nShamans use this ability only to craft items for use in ceremonies. (If the character picks painting as the emphasis, then he can paint flawless images and symbols upon altars and ceremonial items, while sculpting will allow the character to create an exceedingly beautiful spirit mask.\n\nWhen performing shamanic rituals involving artistic efforts, the character receives a +1 bonus to the shamanic ritual check."
    )
)

let embeddedProficiency0211: Proficiency = Proficiency(
    id: "assimilation",
    name: "Assimilation",
    wikiPageTitle: "Assimilation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Charisma",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Assimilation: The character with this proficiency is able to study a different culture well enough to pretend to be a member of it.",
        fullText: "Assimilation: The character with this proficiency is able to study a different culture well enough to pretend to be a member of it. Assimilation allows the character to pick up cultural mannerisms (common rituals, expressions of speech, taboos, etc.). It is distinct from Acting but helpful to that proficiency. A character who has both Acting and Assimilation proficiency receives a +1 bonus to checks with either proficiency when portraying a member of another culture. (This is not cumulative with the Acting/Disguise bonus; if a character has all three proficiencies, she does not receive a +2 bonus.)"
    )
)

let embeddedProficiency0212: Proficiency = Proficiency(
    id: "astral_combat",
    name: "Astral Combat",
    wikiPageTitle: "Astral Combat (Proficiency)",
    redirectAliases: ["Astral Combat (GAP)"],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior", "General"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Reason",
            characterPointCost: 5,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "In the unique arena that is the Astral, combat takes on a new perspective. Attacks come from any of the three dimensions, weapons carry little mass, and blows are driven by the force of Intelligence rather than Strength.",
        fullText: "In the unique arena that is the Astral, combat takes on a new perspective. Attacks come from any of the three dimensions, weapons carry little mass, and blows are driven by the force of Intelligence rather than Strength. Those able to adapt to these conditions gain a considerable advantage over their foes.\n\nMuch like the blindfighting proficiency gives those who've mastered it an edge in the darkness, astral combat lets a body fight on the Astral without disability. Those who use this skill have no penalty for firing missile weapons. Foes of the character gain no benefit for higher position, but the trained astral combatant can make a successful proficiency check to gain such a position over his opponent just in time to strike with a +1 bonus. (See \"Mindwar: Astral Combat.\" )\n\n## From Sage Advice (Dragon #254)\n\nNote that Astral combat requires a roll only if the character tries to maneuver for advantage. Most of the time, the skill simply negates the normal penalties for Astral combat (-2 to missile attacks). Likewise, Astral running boosts the character's movement rate in the Astral Plane to six times his Intelligence score (maximum of 96)."
    )
)

let embeddedProficiency0213: Proficiency = Proficiency(
    id: "astral_navigation",
    name: "Astral Navigation",
    wikiPageTitle: "Astral Navigation (Proficiency)",
    redirectAliases: ["Astral Navigation (GAP)"],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior", "Wizard", "Priest"],
        slotsRequired: 2,
        rawSlots: "2 Slot",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Reason",
            characterPointCost: 4,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "ASTRAL NAVIGATION: By using the strange astral energies which permeate the Silver Void, a blood can find his way through the Astral.",
        fullText: "ASTRAL NAVIGATION: By using the strange astral energies which permeate the Silver Void, a blood can find his way through the Astral. While anyone can navigate the Astral Plane, a successful proficiency check using this skill allows a traveler to cut the normal travel time in half. A body accomplishes this by observing the flows of energy through the plane, noting familiar \"landmarks,\" and avoiding the mental quagmires. Essentially, learning this proficiency entails discovering how to perceive the astral energies and recognize them for what they are — which is something the untrained eye simply cannot do"
    )
)

let embeddedProficiency0214: Proficiency = Proficiency(
    id: "astral_running",
    name: "Astral Running",
    wikiPageTitle: "Astral Running (Proficiency)",
    redirectAliases: ["Astral Running (GAP)"],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "-",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Reason",
            characterPointCost: 2,
            baseRating: "-"
        ),
    description: ProficiencyDescription(
        briefSummary: "ASTRAL RUNNING: The ability to move on the Astral Plane comes naturally to any being with a thinking mind. Though speed depends upon Intelligence, even those of average wits can move fairly quickly.",
        fullText: "ASTRAL RUNNING: The ability to move on the Astral Plane comes naturally to any being with a thinking mind. Though speed depends upon Intelligence, even those of average wits can move fairly quickly. Those who wish to move very fast, as fast perhaps as the githyanki themselves, need training and skill. The ability to move at greater than normal speeds is called astral running, although it has little to do with the physical activity of the same name.\n\nAstral running entails a special method of focusing a body's thoughts, beyond just simply \"thinking really hard.\" Those who are taught the secret can travel at an astral movement rate equal to their Intelligence score multiplied by 6, to a maximum of 96. A cutter can sustain this movement for up to one round per point of Constitution. While using the astral running proficiency, it is not possible to perform any other actions.\n\nEven with the proficiency, a nongithyanki still cannot fully achieve a githyanki's skill in astral movement. While characters with this skill can probably keep up with githyanki (for a while), the near-natives can maintain these speeds while performing other actions."
    )
)
