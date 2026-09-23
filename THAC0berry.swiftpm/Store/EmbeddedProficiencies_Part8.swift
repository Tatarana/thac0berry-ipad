import Foundation

/// Parte 8 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency0800: Proficiency = Proficiency(
    id: "drake_lore",
    name: "Drake Lore",
    wikiPageTitle: "Drake Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Knowledge",
            characterPointCost: 4,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "Drake Lore: This is a rare skill, as few humanoids have managed to amass much information on dragonkind. Still, some have cobbled together enough stories and myths and even truths to be useful.",
        fullText: "Drake Lore: This is a rare skill, as few humanoids have managed to amass much information on dragonkind. Still, some have cobbled together enough stories and myths and even truths to be useful. With this proficiency, a character can immediately determine the age of any dragon from a sighting of at least one round. He can also determine the type of beast from its spoor. In any diplomatic dealings with drakes, a successful dragon lore roll adds a -2 bonus to reaction modifiers. The DM may even allow this skill to be used to understand a smattering of dragon tongue, allowing a language proficiency check at a -6 penalty."
    )
)

let embeddedProficiency0801: Proficiency = Proficiency(
    id: "dream_interpretation",
    name: "Dream Interpretation",
    wikiPageTitle: "Dream Interpretation (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "A successful check in this proficiency allows characters to understand that a dream, which either they have had, or that some other character relates having had, is prophetic.",
        fullText: "A successful check in this proficiency allows characters to understand that a dream, which either they have had, or that some other character relates having had, is prophetic. The characters can then attempt to interpret the dream, and the players must try to make sense of these details, much as a riddle that must be solved.\n\nMost dreams are of no real significance, but on occasion a dream might hold important clues about the present or future, perhaps suggesting a way to deal with a present dilemma or warning of a future hardship.\n\nFor example, a royal advisor might come to Mriela seeking an interpretation of the following dream: A tame bear dances to the tune of a pallid foreigner's pipes, while jugglers hurl documents into the air and tumblers spin somersaults; the crowd are all blinded, with silver scarves across their eyes, and joyfully toss their money to the bear. Mariella (making a successful proficiency check) determines that the important images are the dancing bear, the piper, and the blinded crowd; she also understands (and is thus informed by the DM) that the bear symbolizes a member of the royal court, obeying the commands of an outsider or foreigner, and that the crowd are the people, appreciating the courtier's actions and therefore supporting him or her. The details of the dream may not immediately be clear, but in time the advisor or shaman may come to better understand them.\n\nThe Dream Interpretation proficiency is a vehicle through which DM's can provide players with clues, as well as launch exciting investigative adventures.\n\n{| class=\"article-table\"\n|\nHere are some sample dream images, provided for players with the proficiency, and for DM's who want to use dreams in the adventures.\n\nAcrobat: The defiance of natural forces; a precarious situation.\n\nAnimals: Each has its own meaning, which is tied to what is considered their defining traits; a lion represents courage and nobility, the cat cunning, the owl wisdom, the mouse timidness, the serpent treachery, the bear strength, the beaver industriousness, and so on.\n\nAshes: A passing away, never to return; the destruction of material things and mortal life.\n\nBathing: Washing away or cleansing; ritual purification.\n\nBalance scales: An important judgment; the , need for an accurate assessment of a situation; a balance of opposites.\n\nCraftwork: The act of creation, turning raw materials into fine artifacts; building a state, business, etc.\n\nFruit: Fertility, plenty; the result of previous actions.\n\nGrave: Death, disaster or bereavement. An '• open grave might symbolize the danger of death (perhaps a deliberate plot), a closed grave one that has already happened.\n\nCrossroads: Key decisions must be made; a parting of the ways, where old friends separate; the crossing of two peoples' destinies.\n\nKnots: Binding and losing; holding captive, constraining or controlling.\n\nLantern: A light in the darkness, leading the way; the last hope of success.\n\nMountain: A great obstacle or enormous struggle; firmness and constancy; a massive force resisting change.\n\nRoad: The course of one's life; a journey; passing beyond death; progression.\n\nScythe: A cutting down or gathering in.\n\nSeeds: Potential and promise; a small beginning from which something great will come.\n\nThread: The line of time or fate; a tenuous or fragile link.\n\nWheel: Progress, a forward movement or powerful force; fate. A turning wheel might indicate the passing of time or the revolutions of the seasons.\n|}"
    )
)

let embeddedProficiency0802: Proficiency = Proficiency(
    id: "drinking",
    name: "Drinking",
    wikiPageTitle: "Drinking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency, and its companion proficiency, Eating, is important to many humanoids, including centaurs, satyrs, and wemics. A successful check indicates that the humanoid can consume up to twice as much as normal at one sitting.",
        fullText: "This proficiency, and its companion proficiency, Eating, is important to many humanoids, including centaurs, satyrs, and wemics. A successful check indicates that the humanoid can consume up to twice as much as normal at one sitting. This will allow the humanoid to go twice as long without drink before beginning to suffer adverse effects. If alcoholic beverages are involved, a successful check allows the humanoid to consume twice as much before adverse effects begin to bother him."
    )
)

let embeddedProficiency0803: Proficiency = Proficiency(
    id: "dwarf_runes",
    name: "Dwarf Runes",
    wikiPageTitle: "Dwarf Runes (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Intelligence",
        checkModifier: 2,
        rawModifier: "+2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Dwarf runes are the basic dwarven alphabet and are taught to all young dwarves as a part of their basic education.",
        fullText: "## The Complete Book of Dwarves\n\nDwarf runes are the basic dwarven alphabet and are taught to all young dwarves as a part of their basic education. Depending on the campaign background, runes may have been a gift from the gods, a creation of the dwarves themselves, or an altered form of some other written language. Dwarves will still claim runes to be an intrinsic part of their cultural heritage, and they may take offence if accused of having copied runes!\n\nDwarven runes are found engraved in stone and only rarely written on such transitory materials as parchment, cloth or paper. They are used to denote ownership, give warnings of nearby dangers and to record history. The tombs of dwarves who have been properly interred, as opposed to hasty burial during battle, are engraved with runes that tell the occupant's clan, his parentage, children, and the deeds of his life. In the absence of proper interment, dwarves erect stone monoliths or engrave entire cavern walls depicting the deeds of their dead. These list the clans, the names of those who died and the nature of their deaths. The numbers of slain enemies are greatly detailed.\n\nDwarven runes are not a phonetic form of writing, but a conceptual one, with each rune delineating an idea or implying a range of ideas depending on placement. A single rune might convey pages of human or elf writing or be as simple as a sign saying \"stairs.\" It's a matter of knowing what the rune means and how it is to be interpreted in context. Dwarven runes do not contain conjunctions or pronouns, but proper names are represented by altering an existing rune. This makes runes difficult for other races to understand, and dwarves consider themselves superior to races who cannot read even the most simple of them. All dwarves know them at no cost."
    )
)

let embeddedProficiency0804: Proficiency = Proficiency(
    id: "eating",
    name: "Eating",
    wikiPageTitle: "Eating (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Constitution",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Much like the drinking proficiency, this proficiency allows the humanoid to store up food. A successful check indicates that the humanoid can consume up to twice as much as normal.",
        fullText: "Much like the drinking proficiency, this proficiency allows the humanoid to store up food. A successful check indicates that the humanoid can consume up to twice as much as normal. This allows the humanoid to go twice as long without food without suffering any adverse effects from hunger."
    )
)

let embeddedProficiency0805: Proficiency = Proficiency(
    id: "elephant_care",
    name: "Elephant Care",
    wikiPageTitle: "Elephant Care (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The science of prolonging elephant life (hastyayurveda) is a necessity when deal with these expensive beasts who don't take well to captivity. This proficiency combines animal handling, animal lore, and herbalism, as they pertain to pachyderms.",
        fullText: "The science of prolonging elephant life (hastyayurveda) is a necessity when deal with these expensive beasts who don't take well to captivity. This proficiency combines animal handling, animal lore, and herbalism, as they pertain to pachyderms. Unless someone with this proficiency makes a sucessful proficiency check, the elephant has 10% chance every year of contracting a fatal disease.\n\nOne with this proficiency can tend many elephants and related animals like hippopotami and rhinoceros."
    )
)

let embeddedProficiency0806: Proficiency = Proficiency(
    id: "enamor",
    name: "Enamor",
    wikiPageTitle: "Enamor (Proficiency)",
    redirectAliases: ["CNH Table 14"],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Charisma",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Enamor: This proficiency allows a ninja to trick an NPC into falling in love with him or her. It is more than the skill of knowing which flowers to send or garments to wear.",
        fullText: "Enamor: This proficiency allows a ninja to trick an NPC into falling in love with him or her. It is more than the skill of knowing which flowers to send or garments to wear. Enamor proficiency allows the ninja to study his target like a thief studies a vault, looking for weak points to exploit.\n\nStandard use of the Enamor proficiency takes a week of constant contact for a susceptible victim, a month or more for a more difficult target. The DM can allow bonuses to the proficiency roll for a PC who is thorough and clever in his research into the victim's psyche and who takes extra time, and can assign penalties to one who spends too little time or makes wrong assumptions.\n\nAt the end of the contact period, the DM rolls the Enamor proficiency for the ninja and compares the results with those listed in Table 14.\n\n{| class=\"article-table\"\n|+ Table 14: Enamor Proficiency Results\n|-\n! Ninja Lost by 4+\n|-\n| The victim has been (accidentally) insulted during the romantic pursuit. The victim may attack the ninja, may arrange to have the ninja assaulted, may pretend to be seduced in order to cause the ninja some great harm later, etc.\n|-\n! Ninja Lost by 2–3\n|-\n| The victim is not interested in the ninja and may become irritated with continued pursuit.\n|-\n! Ninja Lost by 1\n|-\n| The victim is flattered but not convinced. The ninja can start over with a –2 penalty to his Enamor check, or can abandon pursuit, perhaps leaving behind some hard feelings.\n|-\n! Even Roll\n|-\n| The victim is flattered but not convinced. The ninja can start over or can abandon pursuit with no hard feelings.\n|-\n! Ninja Won by 1\n|-\n| The victim is flattered but not convinced. The ninja can start over with a +1 bonus to his Enamor check, or can abandon pursuit with no hard feelings.\n|-\n! Ninja Won by 2–3\n|-\n| The victim is infatuated by the ninja but will not change ethics, goals, or loyalties.\n|-\n! Ninja Won by 4–6\n|-\n| The victim is in love with ninja and will help ninja in any way that does not violate important ethics and loyalties.\n|-\n! Ninja Won by 7+\n|-\n| The victim is madly in love with the ninja and will abandon all ethics, goals, and loyalties.\n|}\n\nThe DM, at his discretion, can additionally make a Wisdom check for the victim. If the victim makes the Wisdom check by more than the ninja made his Enamor proficiency check, the results are as for an Even Roll.\n\nIronically, the more complete the ninja's success, the more dangerous the situation becomes. A victim who is madly in love may do everything the ninja wishes, including betraying state secrets and turning traitor, but expects the character with Enamor proficiency to be just as much in love. The victim becomes dangerously jealous of potential rivals (seeing anyone remotely suitable as a potential rival) and could become murderous if he realizes he has been duped.\n\nThe relationship built by use of the Enamor proficiency need not be a romantic one. Depending on the situation, the relationship might be a friendship or the winning of someone's loyalty away from an enemy.\n\nAlthough nothing prevents good-aligned characters from learning the Enamor proficiency, the first time they ruin a life with it may be the last time they use it."
    )
)

let embeddedProficiency0807: Proficiency = Proficiency(
    id: "endurance",
    name: "Endurance",
    wikiPageTitle: "Endurance (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior (Rogue - Thief's Handbook) (General - Book of Dwarf)"],
        slotsRequired: 2,
        rawSlots: "2 Slots 0 Slots - Dwarf",
        relevantAbility: "Constitution",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Constitution/Fitness",
            characterPointCost: 2,
            baseRating: "3"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with endurance proficiency is able to perform continual strenuous physical activity for twice as long as a normal character before becoming subject to the effects of fatigue and exhaustion.",
        fullText: "## Player's Handbook\n\nA character with endurance proficiency is able to perform continual strenuous physical activity for twice as long as a normal character before becoming subject to the effects of fatigue and exhaustion. In those cases where extreme endurance is required, a successful proficiency check must be made. Note that this proficiency does not enable a character to extend the length of time that he can remain unaffected by a lack of food or water.\n\n## Player's Option: Skills & Powers\n\nEndurance: A character with this proficiency can perform continual strenuous physical activity for twice as long as a normal character before becoming exhausted. If the character is ever required to make a Strength/Stamina check or a Constitution/Fitness check, the character can add his endurance score to his success number. If the fatigue rules from the ''Player's Option: Combat & Tactics book are in play, the endurance proficiency is treated differently (see Combat & Tactics'', Chapter One).\n\n## The Complete Thief's Handbook\n\nRecommended: Thug.\n\nThis proficiency is normally restricted to warriors. Its description is on p.&nbsp;58 of the ''Player's Handbook''.\n\n## The Complete Book of Dwarves\n\nA hardy and resilient race, dwarves automatically gain the Endurance proficiency (see the ''Player's Handbook'', page 58) at no cost.\n\n## Campaign Option: Council of Wyrms Setting\n\nEndurance allows strenuous activity to be maintained for twice as long as normal. Tasks requiring extreme endurance require a proficiency check. The proficiency does not counter the effects of starvation or thirst, but it does increase flying distances.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency0808: Proficiency = Proficiency(
    id: "energy",
    name: "Energy",
    wikiPageTitle: "Energy (Proficiency)",
    redirectAliases: ["Energy (NWP)"],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Psionicist"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -4,
        rawModifier: "-4",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Energy Wisdom-4",
        fullText: "Energy Wisdom-4\n\nPriest, Psionicist\n\n1 Slot\n\nThis ability allows the character to use her own life force to augment or heal a patient. The character can give up 2 of her own hit points to grant one hit point to the patient. An additional +1 bonus is applied to an Energy healing roll if the character also has the Contact proficiency, which allows the healer to transfer PSPs instead of hit points at a rated of 5 PSPs per 1 hit point. (This requires a successful MTHACO roll against the subject's MAC.)\n\nEnergy\n\nPsychometabolism. (See The Complete Psionics Handbook.) In addition to Psychometabolism, the following psionic powers prove useful to an energy healer:\n\nSciences Clairsentience\n\nMetapsionics\n\nThis system of healing utilizes the life force that not only flows through the patient but around him or her as well. Telepathy Practitioners diagnose illness by assessing the disruption of a person's life force or energy field. Faith healing, prayer, and spiritual ritual are examples of this practice, as is the psionic discipline of\n\nDevotions poison sense psychic surgery, cannibalize, intensify, psionic residue\", psionic vampirism\", psychic drain,\n\nstasis field\n\nacceptance, empathy,\n\nsuppress fear\n\n*These psionic powers are found in Dragon Kings.\n\n**These psionic powers are listed in The Will and The Way."
    )
)

let embeddedProficiency0809: Proficiency = Proficiency(
    id: "engineering",
    name: "Engineering",
    wikiPageTitle: "Engineering (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Intelligence/Reason, Wisdom/Intuition",
            characterPointCost: 4,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character is trained as a builder of both great and small things. Engineers can prepare plans for everything from simple machines (catapults, river locks, grist mills) to large buildings (fortresses, dams).",
        fullText: "## Player's Handbook\n\nThe character is trained as a builder of both great and small things. Engineers can prepare plans for everything from simple machines (catapults, river locks, grist mills) to large buildings (fortresses, dams). A proficiency check is required only when designing something particularly complicated or unusual. An engineer must still find talented workmen to carry out his plan, but he is trained to supervise and manage their work.\n\nAn engineer is also familiar with the principles of siegecraft and can detect flaws in the defenses of a castle or similar construction. He knows how to construct and use siege weapons and machines, such as catapults, rams, and screws.\n\n## Player's Option: Skills & Powers\n\nEngineering: This proficiency is required for the design and construction of objects and installations of all sizes. Note that carpentry, stonemasonry, blacksmithing, or other proficiencies also might be necessary for the actual building. Characters can design and supervise the building of houses, boats, small bridges, palisades, and towers—of up to about 30 feet high without proficiency checks.\n\nCharacters with this skill can try to design large bridges, fortresses, ships, war machines, locks and dams, and other more complicated projects. Plans for these types of objects generally require at least a week—more if an exceptionally large project is being attempted. Complicated tasks require successful proficiency checks before a workable design can be made. If a check fails on a roll of less than 20, however, the engineer will be aware of the failure and can seek to create a new design—go back to the drawing board, so to speak. On a roll of 20, the design is flawed but the danger will not be discovered until after the object is built."
    )
)

let embeddedProficiency0810: Proficiency = Proficiency(
    id: "escape",
    name: "Escape",
    wikiPageTitle: "Escape (Proficiency)",
    redirectAliases: ["CNH Table 15"],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Escape: This nonweapon proficiency allows a character to slip out of ropes and other types of bindings.",
        fullText: "Escape: This nonweapon proficiency allows a character to slip out of ropes and other types of bindings.\n\nWhen a character is bound or tied, the DM assigns a penalty based on the type and circumstance of the binding. Table 15 shows standard penalties for a variety of situations. The character with Escape proficiency can try to use his skill in order to free himself. He rolls his proficiency and applies the appropriate penalties. If the roll is successful, he can untie himself.\n\n{| class=\"article-table\"\n|+ Table 15: Escape Proficiency Penalties\n! Binding Type|| Penalty\n(Cumulative)'''\n|-\n| Standard rope || 0\n|-\n| Rawhide, dry || –2\n|-\n| Rawhide, soaked and shrunken || –4\n|-\n| Wire || –3\n|-\n| Fingers individually tied/taped || –4\n|-\n! Circumstance || Penalty\n(Cumulative)\n|-\n| Binding character takes extra time/attention || –2\n|-\n| Binding character takes little time/attention || +2\n|-\n| Binding character is a thief or ninja || –3\n|-\n| Binding character makes find/remove traps roll || –2*\n|-\n| Character with this proficiency tries to untie another character || +4\n|-\n| Bound character with this proficiency tries to untie another character || –4\n|}\n\n: * The DM may assign a penalty equal to the number by which the binding character makes his find/remove traps roll divided by five. (For example, if the character has a 50% chance but rolls a 30, he has made the roll by 20. The penalty is a –4.)\n\n'' Example: Ichiro the ninja is bound back-to-back with his fighter friend Olaf. Ichiro has been bound with standard rope, but the character tying him spent extra time on the task and individually tied the ninja's fingers. Ichiro receives a penalty of –6 against his Dexterity –1 roll of 16. The ninja rolls an 11 and fails.''\n\nIchiro then tries to free Olaf. The penalty is the same, but he's trying to untie another person while he himself is bound, resulting in an additional –4 penalty for a total of –10. The ninja manages to roll a 6 and successfully frees his ally.\n\nEscape proficiency does not allow the character to undo locks or escape other sorts of traps.\n\nThose tasks require the open locks and find/remove traps skills."
    )
)

let embeddedProficiency0811: Proficiency = Proficiency(
    id: "ethereal_sight",
    name: "Ethereal Sight",
    wikiPageTitle: "Ethereal Sight (Proficiency)",
    redirectAliases: ["Ethereal Sight (GEP)"],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Wisdom",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Normally, the thick fogs of the Ethereal limit a body's visual distance to 100 yards (300 feet). A basher with this proficiency is capable of tuning her eyesight to the chaotic swirl of the Waveless Sea, extending her vision much further.",
        fullText: "Normally, the thick fogs of the Ethereal limit a body's visual distance to 100 yards (300 feet). A basher with this proficiency is capable of tuning her eyesight to the chaotic swirl of the Waveless Sea, extending her vision much further. A successful proficiency check allows a character normal visual range (as if she were on her plane of origin under a cloudy sky; see the \"Vision and Light\" chapter in the ''Player's Handbook'' for more information) on the Ethereal Plane for 10 rounds. Once a body's successfully used this proficiency, she is unable to use it again for 1 additional tum while her eyes recover from the visual strain. This proficiency is ideal for cutters on guard duty near an Ethereal cache (such as a horde of treasure hidden away on an island of stable ether) and is particularly useful in the hands of those skilled with long-distance melee weapons."
    )
)

let embeddedProficiency0812: Proficiency = Proficiency(
    id: "ethereal_tracking",
    name: "Ethereal Tracking",
    wikiPageTitle: "Ethereal Tracking (Proficiency)",
    redirectAliases: ["Ethereal Tracking (GEP)"],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Wisdom",
        checkModifier: -2,
        rawModifier: "-2/-4",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The confused boil of ethereal mists normally makes it impossible to track anything across the plane's infinite expanses once the target moves beyond a body's sight.",
        fullText: "The confused boil of ethereal mists normally makes it impossible to track anything across the plane's infinite expanses once the target moves beyond a body's sight. However, an observant cutter can follow the trail of ephemeral ether produced by a body in motion on the Ethereal. Anyone with this proficiency can track an object or person on a successful proficiency check. Note that nonrangers suffer a -4 penalty to their check, while rangers suffer a -2 penalty.\n\nTo track a target across the Ethereal, a body must've either seen the target in the last 3 turns, possess eyewitness reports of its recent passage, or have obvious evidence that the target has passed through recently. In all the above cases, a body can't track if more than 3 turns has elapsed; the wake has faded. If these conditions are met, a body makes a proficiency check. Success means that the tracker identifies the ethereal wake of the target, while failure indicates that the mists appear undifferentiated to the tracker. A body can't make another ethereal tracking attempt on the same wake; she must wait until the target moves again, or she hears from a basher who's seen the target.\n\nOnce a body finds the ethereal wake, she may follow the creature to its destination, overtake it if moving faster than the target, or lose the trail altogether if she falls more than 3 turns behind the target. If a tracker is forced to stop and rest, eat, or deal with aggressors, she must make another ethereal tracking check in order to relocate the wake-provided the target is still within the 3-tum distance."
    )
)

let embeddedProficiency0813: Proficiency = Proficiency(
    id: "etiquette",
    name: "Etiquette",
    wikiPageTitle: "Etiquette (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Charisma/Appearance, Wisdom/Intuition",
            characterPointCost: 2,
            baseRating: "8"
        ),
    description: ProficiencyDescription(
        briefSummary: "This proficiency gives the character a basic understanding of the proper forms of behavior and address required in many different situations, especially those involving nobility and persons of rank.",
        fullText: "## Player's Handbook\n\nThis proficiency gives the character a basic understanding of the proper forms of behavior and address required in many different situations, especially those involving nobility and persons of rank. Thus, the character will know the correct title to use when addressing a duke, the proper steps of ceremony to greet visiting diplomats, gestures to avoid in the presence of dwarves, etc. For extremely unusual occurrences, a proficiency check must be made for the character to know the proper etiquette for the situation (an imperial visit, for example, is a sufficiently rare event).\n\nHowever, having the character know what is correct and actually do what is correct are two different matters. The encounters must still be role-played by the character. Knowledge of etiquette does not give the character protection from a gaffe or faux pas; many people who know the correct thing still manage to do the exact opposite.\n\n## Player's Option: Skills & Powers\n\nCharacters with this skill are familiar with the typical manners of formal interaction- at least as they relate to the culture in the campaign world. They know what fanfares are required to greet royal visitors, how to seat the lords and ladies at a table, how to organize the reception line, and how everyone is to be addressed. None of these tasks require a proficiency check.\n\nWhen dealing with a foreign or completely unknown culture, the characters must pass proficiency checks to correctly gauge the required etiquette. The check should be modified- +2 if the foreigners are the same race as the character, +1 or more if the character has had some time to observe the foreigners.\n\nCharacters with the empathy trait gain a +2 bonus to their rating with this proficiency.\n\n## Campaign Option: Council of Wyrms Setting\n\nEtiquette is described in the AD&D Player's Handbook: It provides knowledge of proper behavior and forms of address. It does not replace roleplaying. For dragons, it applies to the customs and protocols of dragonkind and the Council of Wyrms. Hatchlings can't select this proficiency."
    )
)

let embeddedProficiency0814: Proficiency = Proficiency(
    id: "excavation",
    name: "Excavation",
    wikiPageTitle: "Excavation (Proficiency)",
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
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "The character with this proficiency has learned the techniques for the careful unearthing of a site or ruin. This process involves shoring up crumbling foundations, choosing the proper tools, and protecting exposed finds.",
        fullText: "## Dragon Magazine #241\n\nThe character with this proficiency has learned the techniques for the careful unearthing of a site or ruin. This process involves shoring up crumbling foundations, choosing the proper tools, and protecting exposed finds. Without the proper use of this proficiency, delicate finds may be destroyed by crude and reckless digging. Characters with the excavation proficiency can ensure that the structural details of a dig are left intact so that further visits to the excavation site can still yield useful knowledge."
    )
)
