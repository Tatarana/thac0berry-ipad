import Foundation

/// Parte 10 de 25 das proficiências embutidas — ver
/// `EmbeddedProficiencies.swift` pro porquê disso existir (nunca volte a
/// ler isso de JSON/bundle) e pro porquê de estar dividido em vários
/// arquivos/constantes em vez de um array literal único gigante (mesmo
/// motivo de `EmbeddedKits_PartN.swift`/`EmbeddedRules_PartN.swift`: um
/// array com centenas de literais aninhados trava o type-checker do
/// Swift Playgrounds). Cada proficiência aqui é uma constante com tipo
/// explícito (`: Proficiency`), pro compilador checar cada uma isolada e
/// rápido, em vez de inferir o array inteiro de uma vez.

let embeddedProficiency1000: Proficiency = Proficiency(
    id: "future_history",
    name: "Future History",
    wikiPageTitle: "Future History (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Racial / Special",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["Chronomancer"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency gives the character a general historical knowledge of the specific legends and lore applicable to a future time and place. The time and area must be specified and cover an appropriate span.",
        fullText: "This proficiency gives the character a general historical knowledge of the specific legends and lore applicable to a future time and place. The time and area must be specified and cover an appropriate span. The correct coverage of a period would be something like studying the rule of Emperor Cassitor and all lands touched by his military program, or studying the general history of the Tegran Empire up to the wars of domination by said Emperor Cassitor.\n\nThe character has a familiarity with the events, legends, important individuals, customs, locations, crafts, and other such information pertinent to the specified period. A proficiency check is required whenever the character wants to know something specific. If the character is actually in the time in question, a working knowledge of basic social customs and political issues is assumed.\n\nFuture history can be learned in any three ways. The first is through the teachings of someone else, like another chronomancer. Traveling to this future land and studying it first hand also grants the required proficiency. And finally, the character might be able to obtain a history book covering this era from further in the locale's future."
    )
)

let embeddedProficiency1001: Proficiency = Proficiency(
    id: "gaming",
    name: "Gaming",
    wikiPageTitle: "Gaming (Proficiency)",
    redirectAliases: ["Gambling (Proficiency)"],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue", "Warrior"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Charisma",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Wisdom/Intuition, Intelligence/Knowledge",
            characterPointCost: 2,
            baseRating: "5"
        ),
    description: ProficiencyDescription(
        briefSummary: "The character knows most common games of chance and skill, including cards, dice, bones, draughts, and chess.",
        fullText: "## Player's Handbook\n\nThe character knows most common games of chance and skill, including cards, dice, bones, draughts, and chess. When playing a game, the character may either play out the actual game (which may take too much time for some) or make a proficiency check, with success indicating victory. If two proficient characters play each other, the one with the highest successful die roll wins. A character with gaming proficiency can also attempt to cheat, thus gaining a +1 bonus to his ability score. If the proficiency check for the game is 17 to 20, however, the character has been caught cheating (even if he won the game).\n\n## Player's Option: Skills & Powers\n\nA character with this proficiency is familiar with all manner of gambling games. A successful proficiency check means the character will win a given game being played with NPCs—although cumulative negative modifiers should be assigned for each NPC with the gaming proficiency. Subtract 1 for each proficient NPC, with –2 for those with higher than basic gaming expertise.\n\nThe character might try to cheat, which confers a +3 to the gaming proficiency score and requires a check. If the proficiency check rolled is a 20, the character gets caught cheating, even if no NPCs have the gaming proficiency. Add one to this spread for each NPC with gaming proficiency—i.e., if two others have this skill, the cheater will be caught on a roll of 18–20.\n\n## Note from The Complete Paladin's Handbook\n\nA paladin whose ethos includes moral objections to gambling will not engage in games of chance. Using this proficiency to cheat is a serious ethos violation.\n\n## Campaign Option: Council of Wyrms Setting\n\nGaming is described in the Player's Handbook, and covers most common games of chance and skill, including cards, dice, bones, draughts, and chess. Dragons prefer riddles, jokes, and puzzles to games of chance. If the game is not actually played, a successful check means a win. If both players are proficient, the highest successful roll wins. Cheating adds a +1 bonus to the ability score, though a roll of 17+ means the cheater is caught.\n\nHatchlings can't select this proficiency."
    )
)

let embeddedProficiency1002: Proficiency = Proficiency(
    id: "gem_cutting",
    name: "Gem Cutting",
    wikiPageTitle: "Gem Cutting (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue", "Wizard", "Psionicist"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Dexterity",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: ProficiencySkillsAndPowers(
            subAbility: "Dexterity/Aim",
            characterPointCost: 3,
            baseRating: "6"
        ),
    description: ProficiencyDescription(
        briefSummary: "A character with this proficiency can finish the rough gems that are discovered through mining at a rate of 1d10 stones per day. A gem cutter derives no benefit from the assistance of nonproficient characters.",
        fullText: "## Player's Handbook\n\nA character with this proficiency can finish the rough gems that are discovered through mining at a rate of 1d10 stones per day. A gem cutter derives no benefit from the assistance of nonproficient characters. A gem cutter must work with a good light source and must have an assortment of chisels, small hammers, and specially hardened blades.\n\nUncut gems, while still of value, are not nearly as valuable as the finished product. If the cutting is successful (as determined by a proficiency check), the gem cutter increases the value of a given stone to the range appropriate for its type. If a 1 is rolled, the work is exceptionally brilliant and the value of the gem falls into the range for the next most valuable gem (the DM has the relevant tables).\n\n## Player's Option: Skills & Powers\n\nA character with this proficiency each day can work 1d10 uncut stones into finished gems. The worker needs good light and an assortment of chisels, hammers, and hard cutting blades.\n\nThe gem cutter can do decent work without a proficiency check; the stones cut will be valued in the typical range for that type of gem. However, if the cutter seeks to do a unique and very high-quality job, a proficiency check is called for. Failure means the stone is destroyed, but success results in a gem of double the usual value.\n\n## The Complete Book of Dwarves\n\nA dwarf with this proficiency may cut 2d8 gems per day instead of 1d10. He also has a greater chance of increasing the value of a gem. If a dwarf rolls a 1 or a 2 during cutting, he increases the value of the gem to that of the next most valuable class (see page 134 of the ''Dungeon Master's Guide''). For example, Duram is cutting a fancy stone with a finished value of 100 gp. He does an exquisite job and actually increases its value to that of a precious gem with a value of 500 gp.\n\nAny character who fails a gem cutting roll cuts the gem, but does so poorly and reduces its value to the next lower category. Duram, flushed with success, tries his hand at a precious stone with a finished value of 500 gp but he slips with his chisel and reduces its value to that of fancy gem (value 100 gp).\n\nA character who rolls a 20 when cutting a gem splits it in half and ends up with two uncut gems with a combined value one class lower than that of the original gem. Duram starts one more gem. It has a value of 50 gp. He places his cutting clamp, over tightens the jaws, and splits the gem in half (he rolls a 20!). He now has two uncut gems with a value of 5 gp each."
    )
)

let embeddedProficiency1003: Proficiency = Proficiency(
    id: "genie_lore",
    name: "Genie Lore",
    wikiPageTitle: "Genie Lore (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Priest", "Wizard"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Characters with this proficiency are versed in the nature and background of all geniekind, from the smallest elemental gen to the grandest noble pasha or caliph.",
        fullText: "Characters with this proficiency are versed in the nature and background of all geniekind, from the smallest elemental gen to the grandest noble pasha or caliph. They know the proper manner for greeting and conversing with a genie—in other words, the manner least likely to offend the creature. In contrast, other characters must rely on successful Charisma checks both initially and every time they commit a potential faux pas (in the DM's opinion).\n\nCharacters who have genie lore also know the hierarchy and organization of geniekind. At a glance, they can tell whether a creature is a marid, djinni, dao, or efreeti. They can also say whether a creature they're conversing with is noble or base.\n\nIf a genie is masquerading as a common human, a successful proficiency check reveals the ruse. If this check fails, perception is completely reversed from the truth. In other words, the genie seems definitely to be a common person, and a common person seems definitely to be a genie. A character with genie lore can perform only one check per \"suspect.\" The DM rolls this check separately and secretly (not revealing the true results). If an individual with genie lore has no reason to be suspicious, the check is made with half the usual proficiency score, rounded down.\n\nGenie lore also enables a character to detect the work of genies—that is, the physical manifestation of genie spells, as well as items created by a genie's spell-like abilities. The chance of success is limited. The character makes the proficiency check using half the usual score, rounded down. If successful, the individual may discern, for example, whether a wall has been constructed by genie-magic, whether a meal was summoned into being by a djinni, or whether a princess is enamored magically by the effects of a dao- granted limited wish.\n\nGenie lore does not enable a character to detect genies moving invisibly through the immediate area. Nor does it help the character see through an extraordinary disguise unless the genie is working some wonder of magic at the time."
    )
)

let embeddedProficiency1004: Proficiency = Proficiency(
    id: "geography",
    name: "Geography",
    wikiPageTitle: "Geography (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 or 2",
        relevantAbility: "Intelligence",
        checkModifier: -1,
        rawModifier: "-1",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "As the nonweapon proficiency \"ancient geography,\" but focused on the present-day state of the region. The one exception is that this proficiency does not provide a modifier to the Spirit Lore proficiency.",
        fullText: "As the nonweapon proficiency \"ancient geography,\" but focused on the present-day state of the region. The one exception is that this proficiency does not provide a modifier to the Spirit Lore proficiency."
    )
)

let embeddedProficiency1005: Proficiency = Proficiency(
    id: "geonosy",
    name: "Geonosy",
    wikiPageTitle: "Geonosy (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Priest",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Druid"],
        slotsRequired: 1,
        rawSlots: "1 to 4 Slot(s)",
        relevantAbility: "N/A",
        checkModifier: 0,
        rawModifier: "N/A",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This proficiency gives the earthstoker a better chance to recognize signs of volcanic activity and to survive its effects. PCs with this proficiency gain a +1 bonus per proficiency slot (up to +4 maximum) to saving throws vs.",
        fullText: "This proficiency gives the earthstoker a better chance to recognize signs of volcanic activity and to survive its effects. PCs with this proficiency gain a +1 bonus per proficiency slot (up to +4 maximum) to saving throws vs. earth- and fire-based magic and suffer -1 point of damage per slot (up to -6 maximum) from any source of volcanic activity. Proficient geonists learn ways of coping with dangerous volcanic conditions, such as tying wet scarves around their faces. Characters with Geonosy can predict the number of SFPs (seismic force points) in an area with an error margin of 1d100 SFPs and can distinguish volcanic rocks from sedimentary ones."
    )
)

let embeddedProficiency1006: Proficiency = Proficiency(
    id: "giant_kite_flying",
    name: "Giant Kite Flying",
    wikiPageTitle: "Giant Kite Flying (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Dexterity",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Giant Kite Flying: This proficiency is of use only to characters who intend to fly the unusual items called hito washi (human eagle) and yami doko (man-sized kite).",
        fullText: "Giant Kite Flying: This proficiency is of use only to characters who intend to fly the unusual items called hito washi (human eagle) and yami doko (man-sized kite). It is an expensive skill and difficult to master, so there are very few practitioners. Without this proficiency, a character trying to use a giant kite is certain to crash and do himself great harm, if not kill himself. Even with this proficiency, the character is very likely to do so."
    )
)

let embeddedProficiency1007: Proficiency = Proficiency(
    id: "glassblowing",
    name: "Glassblowing",
    wikiPageTitle: "Glassblowing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Wizard",
    campaignSettings: ["Core"],
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
        briefSummary: "Glassblowing: A character skilled at this trade can manufacture all kinds of glass containers, jars, or bottles.",
        fullText: "Glassblowing: A character skilled at this trade can manufacture all kinds of glass containers, jars, or bottles. Creating symmetrical or precise pieces requires a proficiency check, but if a character is making items for usefulness instead of decoration, he can produce about 10 small containers, 5 medium containers, or 2 large ones in a day's work. The character must have access to a specialized glazier's workshop and furnace in order to make use of this skill."
    )
)

let embeddedProficiency1008: Proficiency = Proficiency(
    id: "glassworking",
    name: "Glassworking",
    wikiPageTitle: "Glassworking (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 1,
        rawSlots: "1 or 3 Slot",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This skill allows for the creation of glass items from as simple and utilitarian or beautiful and decorative. The use of this skill requires a furnace.",
        fullText: "This skill allows for the creation of glass items from as simple and utilitarian or beautiful and decorative. The use of this skill requires a furnace. The more complete version of this skill (3 slots) is necessary to construct glass weapons."
    )
)

let embeddedProficiency1009: Proficiency = Proficiency(
    id: "grab_and_drop",
    name: "Grab-and-Drop",
    wikiPageTitle: "Grab-and-Drop (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior (Avariel)"],
        slotsRequired: 1,
        rawSlots: "1 Slot",
        relevantAbility: "Strength",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This maneuver gives a +2 to the attacking avariel's attack roll.",
        fullText: "This maneuver gives a +2 to the attacking avariel's attack roll."
    )
)

let embeddedProficiency1010: Proficiency = Proficiency(
    id: "grooming",
    name: "Grooming",
    wikiPageTitle: "Grooming (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Rogue",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Rogue"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Grooming is the ability to make another look his or her best—with clean skin, well-trimmed hair, and a virtually unmarred complexion. This skill is usually the province of barbers (see Chapter 3).",
        fullText: "Grooming is the ability to make another look his or her best—with clean skin, well-trimmed hair, and a virtually unmarred complexion. This skill is usually the province of barbers (see Chapter 3).\n\nGrooming takes about an hour, and after that the patron gains a +2 bonus to encounter reactions when dealing with individuals of his or her own race. The same bonus applies when the patron interacts with geniekind (genies always appreciate a well-groomed supplicant). The effect lasts for two days after the grooming. (Only one reaction roll is required for a given individual encountered during that time, however.)\n\nWhen combined with the disguise proficiency, grooming enables characters to disguise others just as well as they can disguise themselves. All modifications for disguise still apply, as listed in Table 37 of the ''Player's Handbook''."
    )
)

let embeddedProficiency1011: Proficiency = Proficiency(
    id: "ground_combat",
    name: "Ground Combat",
    wikiPageTitle: "Ground Combat (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Core"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior (Avariel)"],
        slotsRequired: 2,
        rawSlots: "2 Slots",
        relevantAbility: "Dexterity",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This skill concentrates on groundbased fighting, teaching the warrior to overcome natural limitations caused by wings. Knowledge of this proficiency cancels the standard disadvantages for ground fighting for avariel.",
        fullText: "This skill concentrates on groundbased fighting, teaching the warrior to overcome natural limitations caused by wings. Knowledge of this proficiency cancels the standard disadvantages for ground fighting for avariel."
    )
)

let embeddedProficiency1012: Proficiency = Proficiency(
    id: "gunnery",
    name: "Gunnery",
    wikiPageTitle: "Gunnery (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 1,
        rawSlots: "1",
        relevantAbility: "Intelligence",
        checkModifier: -2,
        rawModifier: "-2",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Gunnery: (1 slot, Intelligence -2, warrior group) This proficiency teaches a character what he needs to know to function as an artillerist's or gunner's mate. He knows the basic procedures and safety precautions involved in firing a cannon.",
        fullText: "## A Mighty Fortress Campaign Sourcebook\n\nGunnery: (1 slot, Intelligence -2, warrior group) This proficiency teaches a character what he needs to know to function as an artillerist's or gunner's mate. He knows the basic procedures and safety precautions involved in firing a cannon. Devoting a second slot to gunnery qualifies the character to be a master gunner. He can now aim the piece and command the mates who serve it. Note that this is considered a nonweapon proficiency, even though it applies to a (very large!) weapon."
    )
)

let embeddedProficiency1013: Proficiency = Proficiency(
    id: "gunsmithing",
    name: "Gunsmithing",
    wikiPageTitle: "Gunsmithing (Proficiency)",
    redirectAliases: [],
    primaryGroup: "Warrior",
    campaignSettings: ["Forgotten Realms"],
    mechanics: ProficiencyMechanics(
        groups: ["Warrior"],
        slotsRequired: 2,
        rawSlots: "2 slot",
        relevantAbility: "Intelligence",
        checkModifier: -3,
        rawModifier: "-3",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "This specialized proficiency allows the user to manufacture and repair firearms that use smoke powder.",
        fullText: "This specialized proficiency allows the user to manufacture and repair firearms that use smoke powder. (Smoke powder itself cannot be created with this proficiency.) It takes about 60 days to make a pistol and 90 days to make a rifle; the total cost is one-fifth the sale price (see PLAYER'S OPTION: Combat & Tactics, page 126, firearms' costs table). Bullets can be made 100 per day for only 1 sp. Repair times and prices should fit within these limits."
    )
)

let embeddedProficiency1014: Proficiency = Proficiency(
    id: "haggling",
    name: "Haggling",
    wikiPageTitle: "Haggling (Proficiency)",
    redirectAliases: [],
    primaryGroup: "General",
    campaignSettings: ["Al-Qadim"],
    mechanics: ProficiencyMechanics(
        groups: ["General"],
        slotsRequired: 2,
        rawSlots: "2",
        relevantAbility: "Wisdom",
        checkModifier: 0,
        rawModifier: "+0",
        prerequisites: []
    ),
    skillsAndPowers: nil,
    description: ProficiencyDescription(
        briefSummary: "Check with the DM before taking this proficiency While it enhances the flavor of the AL-QADIMTM campaign, haggling may result in PCs spending too much time at the bazaar and too little time on the battlefield (or in other realms of high adventure).",
        fullText: "Check with the DM before taking this proficiency While it enhances the flavor of the AL-QADIMTM campaign, haggling may result in PCs spending too much time at the bazaar and too little time on the battlefield (or in other realms of high adventure).\n\nThe bazaar is a place of give and take, where steep prices are demanded and modest amounts are paid. The price list for equipment in Chapter 6 shows three amounts for each item. The first is the \"asking price,\" the second the \"normal price,\" and the third the \"bargain price.\" If the DM chooses to avoid all haggling, only the normal price applies. But if haggling is allowed, then all three prices come into play in the AL-QADIM campaign.\n\nThe asking price is just that—what a merchant typically asks for a given item when a buyer points it out. A poor haggler usually ends up paying that price. The bargain price reflects the most successful result of a haggling character, while the normal price reflects a middle ground-a sort of standoff or compromise between buyer and seller.\n\nHere's how the proficiency works in play. A buyer with the haggling proficiency—usually a PC—points to an item for sale and asks the price. (Prices are rarely posted.) Variations exist, but as a general rule, merchants are assumed to have the haggling proficiency too, with a Wisdom of 14 to back it up. (In other words, their haggling score is 14.) The PC makes a haggling check. The DM does the same for the merchant. Results are as follows:\n* If the buyer makes a successful check but the merchant doesn't, the item will sell for the bargain price—usually with some complaint by the merchant. (\"You are stealing from me! You remember that it was I who was so good to you when next you need supplies. Now, what else may I show you?\")\n* If both the buyer and the seller make successful checks, the merchant will not settle for less than the normal price, regardless of bickering.\n* If both the buyer and the seller fail their checks, the merchant won't settle for less than the normal price (the \"fine price,\" the \"excellent price,\" the \"price that barely feeds my wife and my ten sick children—a virtual killing!\").\n* If the buyer fails the check but the seller succeeds, the merchant will hold firm to the asking price, and no amount of haggling will change it. (\"Hah! You insult me with your swine-headed ways! If you think you can get a better price, then go somewhere else! Now, what else may I show you?\")\n\nLacking the haggling proficiency is the same as failing the proficiency check. For example, if the buyer lacks the proficiency, and the seller's proficiency check fails, then the normal price applies.\n\nIf the PCs are together, only one of them can haggle for a particular item; a merchant won't begin anew with another player character. Further, the price of an item determined by haggling applies throughout the business day. Return attempts are useless until the next morning. If the character wishes to buy another item of the same type, the previous price automatically applies. A character can haggle for another kind of item right away, but could not, for example, attempt to buy a second waterskin that day from the same merchant for a better price.\n\nAt the DM's option, merchants may decide not to haggle with a PC who appears not to have the asking price in hand. (Why should merchants waste effort on a pauper who has no intention of buying?) \"Let me see your silver\" is a common response to a questionable buyer's attempt to haggle.\n\nBazaars are packed with all manner of goods, some rare and strange, such as armor imported from northern realms or an occasional coffee-pouring automaton. If an item is not listed in Chapter 6, the DM should set a normal price, add 50 percent to determine the asking price, and subtract 25 percent from the normal price to find the bargain price. For example, a set of fine crystalline cups might have a normal price of 100 gp. The asking price would be 150 gp, and the bargain price would be 75 gp.\n\nHaggling should enhance the flavor of adventures in the Land of Fate, with appropriate role-playing to supplement the proficiency checks. The DM should not allow it to dominate or otherwise slow the\ncampaign."
    )
)
