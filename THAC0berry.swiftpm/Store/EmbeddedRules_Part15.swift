import Foundation

let embeddedRule0196: RuleEntry = RuleEntry(
    id: "phb_ch03_warrior_tables",
    book: "PHB",
    chapterNumber: 3,
    chapterTitle: "Player Character Classes",
    breadcrumbs: "Player's Handbook > Chapter 3: Player Character Classes > Warrior Tables",
    topic: "Warrior Tables",
    ruleType: "core_rule",
    summary: "* Optional character class. Specialist includes illusionist.",
    content: "## Table 13: Class Ability Minimums\n\n[TABLE_REF: Table 13: Class Ability Minimums]\n\n* Optional character class. Specialist includes illusionist.\n\n## Table 14: Warrior Experience Levels\n\n[TABLE_REF: Table 14: Warrior Experience Levels]\n\n## Table 15: Warrior Melee Attacks per Round\n\n[TABLE_REF: Table 15: Warrior Melee Attacks per Round]\n\n## Table 16: Fighter's Followers\n\n[TABLE_REF: Leader]\n\n[TABLE_REF: Troops/Followers]\n\n*Player selects type.\n\n[TABLE_REF: Elite Units]\n\n## Table 17: Paladin Spell Progression\n\n[TABLE_REF: Table 17: Paladin Spell Progression]\n\n* Maximum spell ability\n\n## Table 18: Ranger Abilities\n\n[TABLE_REF: Table 17: Ranger Spell Progression]\n\n: * Maximum percentile score\n: ** Maximum spell ability\n\n## Table 19: Ranger's Followers\n\n[TABLE_REF: Table 19: Ranger's Followers]\n\n* If the ranger already has a follower of this type, ignore this result and roll again.",
    tables: [
        RuleTable(
                tableNumber: "Table 13",
                title: "Table 13: Class Ability Minimums",
                headers: ["Character Class", "Str", "Dex", "Con", "Int", "Wis", "Cha"],
                rows: [
                    ["Fighter", "9", "—", "—", "—", "—", "—"],
                    ["Paladin*", "12", "—", "9", "—", "13", "17"],
                    ["Ranger*", "13", "13", "14", "—", "14", "—"],
                    ["Mage", "—", "—", "—", "9", "—", "—"],
                    ["Specialist*", "Var", "Var", "Var", "Var", "Var", "Var"],
                    ["Cleric", "—", "—", "—", "—", "9", "—"],
                    ["Druid*", "—", "—", "—", "—", "12", "15"],
                    ["Thief", "—", "9", "—", "—", "—", "—"],
                    ["Bard*", "—", "12", "—", "13", "—", "15"]
                ]
            ),
        RuleTable(
                tableNumber: "Table 14",
                title: "Table 14: Warrior Experience Levels",
                headers: ["Level", "Fighter", "Paladin/ Ranger", "Hit Dice (d10)"],
                rows: [
                    ["1", "0", "0", "1"],
                    ["2", "2,000", "2,250", "2"],
                    ["3", "4,000", "4,500", "3"],
                    ["4", "8,000", "9,000", "4"],
                    ["5", "16,000", "18,000", "5"],
                    ["6", "32,000", "36,000", "6"],
                    ["7", "64,000", "75,000", "7"],
                    ["8", "125,000", "150,000", "8"],
                    ["9", "250,000", "300,000", "9"],
                    ["10", "500,000", "600,000", "9+3"],
                    ["11", "750,000", "900,000", "9+6"],
                    ["12", "1,000,000", "1,200,000", "9+9"],
                    ["13", "1,250,000", "1,500,000", "9+12"],
                    ["14", "1,500,000", "1,800,000", "9+15"],
                    ["15", "1,750,000", "2,100,000", "9+18"],
                    ["16", "2,000,000", "2,400,000", "9+21"],
                    ["17", "2,250,000", "2,700,000", "9+24"],
                    ["18", "2,500,000", "3,000,000", "9+27"],
                    ["19", "2,750,000", "3,300,000", "9+30"],
                    ["20", "3,000,000", "3,600,000", "9+33"]
                ]
            ),
        RuleTable(
                tableNumber: "Table 15",
                title: "Table 15: Warrior Melee Attacks per Round",
                headers: ["Warrior Level", "Attacks/Round"],
                rows: [
                    ["1-6", "1/round"],
                    ["7-12", "3/2 rounds"],
                    ["13 & up", "2/round"]
                ]
            ),
        RuleTable(
                tableNumber: "",
                title: "Leader",
                headers: ["Die Roll", "Leader (and suggested magical items)"],
                rows: [
                    ["01-40", "5th-level fighter, plate mail, shield, battle axe +2"],
                    ["41-75", "6th-level fighter, plate mail, shield +1, spear +1, dagger +1"],
                    ["76-95", "6th-level fighter, plate mail +1, shield, spear +1, dagger +1, plus 3rd-level fighter, splint mail, shield, crossbow of distance"],
                    ["96-99", "7th-level fighter, plate mail +1, shield +1, broad sword +2, heavy war horse with horseshoes of speed"],
                    ["0", "DM's Option"]
                ]
            ),
        RuleTable(
                tableNumber: "",
                title: "Troops/Followers",
                headers: ["Die Roll", "Troops/Followers (all 0th-level)"],
                rows: [
                    ["01-50", "20 cavalry with ring mail, shield, 3 javelins, long sword, hand axe; 100 infantry with scale mail, polearm*, club"],
                    ["51-75", "20 infantry with splint mail, morning star, hand axe; 60 infantry with leather armor, pike, short sword."],
                    ["76-90", "40 infantry with chain mail, heavy crossbow, short sword; 20 infantry with chain mail, light crossbow, military fork"],
                    ["91-99", "10 cavalry with banded mail, shield, lance, bastard sword, mace; 20 cavalry with scale mail, shield, lance, long sword, mace; 30 cavalry with studded leather armor, shield, lance, long sword"],
                    ["0", "DM's Option (Barbarians, headhunters, armed peasants, extra-heavy cavalry, etc.)"]
                ]
            ),
        RuleTable(
                tableNumber: "",
                title: "Elite Units",
                headers: ["Die Roll", "Elite Units"],
                rows: [
                    ["01-10", "10 mounted knights; 1st-level fighters with field plate, large shield, lance, broad sword, morning star, and heavy war horse with full barding"],
                    ["11-20", "10 1st-level elven fighter/mages with chain mail, long sword, long bow, dagger"],
                    ["21-30", "15 wardens: 1st-level rangers with scale mail, shield, long sword, spear, long bow"],
                    ["31-40", "20 berserkers: 2nd-level fighters with leather armor, shield, battle axe, broad sword, dagger (berserkers receive +1 bonus to attack and damage rolls)"],
                    ["41-65", "20 expert archers: 1st-level fighters with studded leather armor, long bows or crossbows (+2 to hit, or bow specialization, if using that optional rule)"],
                    ["66-99", "30 infantry: 1st-level fighters with plate mail, body shield, spear, short sword"],
                    ["0", "DM's Option (pegasi cavalry, eagle riders, demihumans, siege train, etc.)"]
                ]
            ),
        RuleTable(
                tableNumber: "Table 17",
                title: "Table 17: Paladin Spell Progression",
                headers: ["Paladin Level", "Casting Level", "1", "2", "3", "4"],
                rows: [
                    ["9", "1", "1", "—", "—", "—"],
                    ["10", "2", "2", "—", "—", "—"],
                    ["11", "3", "2", "1", "—", "—"],
                    ["12", "4", "2", "2", "—", "—"],
                    ["13", "5", "2", "2", "1", "—"],
                    ["14", "6", "3", "2", "1", "—"],
                    ["15", "7", "3", "2", "1", "1"],
                    ["16", "8", "3", "3", "2", "1"],
                    ["17", "9*", "3", "3", "3", "1"],
                    ["18", "9*", "3", "3", "3", "1"],
                    ["19", "9*", "3", "3", "3", "2"],
                    ["20*", "9*", "3", "3", "3", "3"]
                ]
            ),
        RuleTable(
                tableNumber: "Table 17",
                title: "Table 17: Ranger Spell Progression",
                headers: ["Ranger Level", "Hide in Shadows", "Move Silently", "Casting Level", "1", "2", "3"],
                rows: [
                    ["1", "10%", "15%", "—", "—", "—", "—"],
                    ["2", "15%", "21%", "—", "—", "—", "—"],
                    ["3", "20%", "27%", "—", "—", "—", "—"],
                    ["4", "25%", "33%", "—", "—", "—", "—"],
                    ["5", "31%", "40%", "—", "—", "—", "—"],
                    ["6", "37%", "47%", "—", "—", "—", "—"],
                    ["7", "43%", "55%", "—", "—", "—", "—"],
                    ["8", "49%", "62%", "1", "1", "—", "—"],
                    ["9", "56%", "70%", "2", "2", "—", "—"],
                    ["10", "63%", "78%", "3", "2", "1", "—"],
                    ["11", "70%", "86%", "4", "2", "2", "—"],
                    ["12", "77%", "94%", "5", "2", "2", "1"],
                    ["13", "85%", "99%*", "6", "3", "2", "1"],
                    ["14", "93%", "99%", "7", "3", "2", "2"],
                    ["15", "99%*", "99%", "8", "3", "3", "2"],
                    ["16", "99%", "99%", "9", "3", "3**", "3"]
                ]
            ),
        RuleTable(
                tableNumber: "Table 19",
                title: "Table 19: Ranger's Followers",
                headers: ["Die Roll", "Follower"],
                rows: [
                    ["01-10", "Bear, black"],
                    ["11-20", "Bear, brown"],
                    ["21", "Brownie*"],
                    ["22-26", "Cleric (human)"],
                    ["27-38", "Dog/wolf"],
                    ["39-40", "Druid"],
                    ["41-50", "Falcon"],
                    ["51-53", "Fighter (elf)"],
                    ["54-55", "Fighter (gnome)"],
                    ["56-57", "Fighter (halfling)"],
                    ["58-65", "Fighter (human)"],
                    ["66", "Fighter/mage (elf)*"],
                    ["67-72", "Great cat (tiger, lion, etc.)*"],
                    ["73", "Hippogriff"],
                    ["74", "Pegasus*"],
                    ["75", "Pixie*"],
                    ["76-80", "Ranger (half-elf)"],
                    ["81-90", "Ranger (human)"],
                    ["91-94", "Raven"],
                    ["95", "Satyr*"],
                    ["96", "Thief (halfling)"],
                    ["97", "Thief (human)"],
                    ["98", "Treant*"],
                    ["99", "Werebear/weretiger*"],
                    ["0", "Other wilderness creature (chosen by the DM)"]
                ]
            )
    ],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["tables", "warrior", "warrior tables"]
)

let embeddedRule0197: RuleEntry = RuleEntry(
    id: "phb_ch03_wizard",
    book: "PHB",
    chapterNumber: 3,
    chapterTitle: "Player Character Classes",
    breadcrumbs: "Player's Handbook > Chapter 3: Player Character Classes > Wizard",
    topic: "Wizard",
    ruleType: "core_rule",
    summary: "The wizard group encompasses all spellcasters working in the various fields of magic—both those who specialize in specific schools of magic and those who study a broad range of magical theories.",
    content: "[TABLE_REF: Table 20: Wizard Experience Levels]\n\nThe wizard group encompasses all spellcasters working in the various fields of magic—both those who specialize in specific schools of magic and those who study a broad range of magical theories. Spending their lives in pursuit of arcane wisdom, wizards have little time for physical endeavors. They tend to be poor fighters with little knowledge of weaponry. However, they command powerful and dangerous energies with a few simple gestures, rare components, and mystical words.\n\nSpells are the tools, weapons, and armor of the wizard. He is weak in a toe-to-toe fight, but when prepared he can strike down his foes at a distance, vanish in an instant, become a wholly different creature, or even invade the mind of an enemy and take control of his thoughts and actions. No secrets are safe from a wizard and no fortress is secure. His quest for knowledge and power often leads him into realms where mortals were never meant to go.\n\nWizards cannot wear any armor, for several reasons. Firstly, most spells require complicated gestures and odd posturings by the caster and armor restricts the wearer's ability to do these properly. Secondly, the wizard spent his youth (and will spend most of his life) learning arcane languages, poring through old books, and practicing his spells. This leaves no time for learning other things (like how to wear armor properly and use it effectively). If the wizard had spent his time learning about armor, he would not have even the meager skills and powers he begins with. There are even unfounded theories that claim the materials in most armors disrupt the delicate fabric of a spell as it gathers energy; the two cannot exist side by side in harmony. While this idea is popular with the common people, true wizards know this is simply not true. If it were, how would they ever be able to cast spells requiring iron braziers or metal bowls?\n\nFor similar reasons, wizards are severely restricted in the weapons they can use. They are limited to those that are easy to learn or are sometimes useful in their own research. Hence, a wizard can use a dagger or a staff, items that are traditionally useful in magical studies. Other weapons allowed are darts, knives, and slings (weapons that require little skill, little strength, or both).\n\nWizards can use more magical items than any other characters. These include potions, rings, wands, rods, scrolls, and most miscellaneous magical items. A wizard can use a magical version of any weapon allowed to his class but cannot use magical armor, because no armor is allowed. Between their spells and magical items, however, wizards wield great power.\n\nFinally, all wizards (whether mages or specialists) can create new magical items, ranging from simple scrolls and potions to powerful staves and magical swords. Once he reaches 9th level, a wizard can pen magical scrolls and brew potions. He can construct more powerful magical items only after he has learned the appropriate spells (or works with someone who knows them). Your DM should consult the Spell Research and Magical Items sections of the DMG for more information.\n\nNo matter what school of magic the wizard is involved in, Intelligence is his prime requisite (or one of several prime requisites). Characters must have an Intelligence score of at least 9 to qualify to be a wizard.\n\nAll wizards use Table 20 to determine their advancement in level as they earn experience points. They also use Table 21 to determine the levels and numbers of spells they can cast at each experience level.\n\nAll wizards gain one four-sided Hit Die (1d4) per level from 1st through 10th levels. After 10th level, wizards earn 1 hit point per level and they no longer gain additional hit point bonuses for high Constitution scores.\n\nLearning and casting spells require long study, patience, and research. Once his adventuring life begins, a wizard is largely responsible for his own education; he no longer has a teacher looking over his shoulder and telling him which spell to learn next. This freedom is not without its price, however. It means that the wizard must find his own source for magical knowledge: libraries, guilds, or captured books and scrolls.\n\nWhenever a wizard discovers instructions for a spell he doesn't know, he can try to read and understand the instructions. The player must roll percentile dice. If the result is equal to or less than the percentage chance to learn a new spell (listed on Table 4), the character understands the spell and how to cast it. He can enter the spell in his spell book (unless he has already learned the maximum number of spells allowed for that level). If this die roll is higher than the character's chance to learn the spell, he doesn't understand the spell. Once a spell is learned, it cannot be unlearned. It remains part of that character's repertoire forever. Thus, a character cannot choose to \"forget\" a spell so as to replace it with another.\n\nA wizard's spell book can be a single book, a set of books, a bundle of scrolls, or anything else your DM allows. The spell book is the wizard's diary, laboratory journal, and encyclopedia, containing a record of everything he knows. Naturally, it is his most treasured possession; without it he is almost helpless.\n\nA spell book contains the complicated instructions for casting the spell—the spell's recipe, so to speak. Merely reading these instructions aloud or trying to mimic the instructions does not enable one to cast the spell. Spells gather and shape mystical energies; the procedures involved are very demanding, bizarre, and intricate. Before a wizard can actually cast a spell, he must memorize its arcane formula. This locks an energy pattern for that particular spell into his mind. Once he has the spell memorized, it remains in his memory until he uses the exact combination of gestures, words, and materials that triggers the release of this energy pattern. Upon casting, the energy of the spell is spent, wiped clean from the wizard's mind. The wizard cannot cast that spell again until he returns to his spell book and memorizes it again.\n\nInitially the wizard is able to retain only a few of these magical energies in his mind at one time. Furthermore, some spells are more demanding and complex than others; these are impossible for the inexperienced wizard to memorize. With experience, the wizard's talent expands. He can memorize more spells and more complex spells. Still, he never escapes his need to study; the wizard must always return to his spell books to refresh his powers.\n\nAnother important power of the wizard is his ability to research new spells and construct magical items. Both endeavors are difficult, time-consuming, costly, occasionally even perilous. Through research, a wizard can create an entirely new spell, subject to the DM's approval. Likewise, by consulting with your DM, your character can build magical items, either similar to those already given in the rules or of your own design. Your DM has information concerning spell research and magical item creation.\n\nUnlike many other characters, wizards gain no special benefits from building a fortress or stronghold. They can own property and receive the normal benefits, such as monthly income and mercenaries for protection. However, the reputations of wizards tend to discourage people from flocking to their doors. At best, a wizard may acquire a few henchmen and apprentices to help in his work.",
    tables: [
        RuleTable(
                tableNumber: "Table 20",
                title: "Table 20: Wizard Experience Levels",
                headers: ["Level", "Mage/Specialist", "Hit Dice (d4)"],
                rows: [
                    ["1", "0", "1"],
                    ["2", "2,500", "2"],
                    ["3", "5,000", "3"],
                    ["4", "10,000", "4"],
                    ["5", "20,000", "5"],
                    ["6", "40,000", "6"],
                    ["7", "60,000", "7"],
                    ["8", "90,000", "8"],
                    ["9", "135,000", "9"],
                    ["10", "250,000", "10"],
                    ["11", "375,000", "10+1"],
                    ["12", "750,000", "10+2"],
                    ["13", "1,125,000", "10+3"],
                    ["14", "1,500,000", "10+4"],
                    ["15", "1,875,000", "10+5"],
                    ["16", "2,250,000", "10+6"],
                    ["17", "2,625,000", "10+7"],
                    ["18", "3,000,000", "10+8"],
                    ["19", "3,375,000", "10+9"],
                    ["20", "3,750,000", "10+10"]
                ]
            )
    ],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["armor", "constitution", "intelligence", "strength", "weapons", "wisdom", "wizard"]
)

let embeddedRule0198: RuleEntry = RuleEntry(
    id: "phb_ch03_wizard_tables",
    book: "PHB",
    chapterNumber: 3,
    chapterTitle: "Player Character Classes",
    breadcrumbs: "Player's Handbook > Chapter 3: Player Character Classes > Wizard Tables",
    topic: "Wizard Tables",
    ruleType: "core_rule",
    summary: "",
    content: "## Table 20: Wizard Experience Levels\n\n[TABLE_REF: Table 20: Wizard Experience Levels]\n\n## Table 21 Wizard Spell Progression\n\n[TABLE_REF: Table 21: Wizard Spell Progression]\n\n## Table 22: Wizard Specialist Requirements\n\n[TABLE_REF: Table 22: Wizard Specialist Requirements]",
    tables: [
        RuleTable(
                tableNumber: "Table 20",
                title: "Table 20: Wizard Experience Levels",
                headers: ["Level", "Mage/Specialist", "Hit Dice (d4)"],
                rows: [
                    ["1", "0", "1"],
                    ["2", "2,500", "2"],
                    ["3", "5,000", "3"],
                    ["4", "10,000", "4"],
                    ["5", "20,000", "5"],
                    ["6", "40,000", "6"],
                    ["7", "60,000", "7"],
                    ["8", "90,000", "8"],
                    ["9", "135,000", "9"],
                    ["10", "250,000", "10"],
                    ["11", "375,000", "10+1"],
                    ["12", "750,000", "10+2"],
                    ["13", "1,125,000", "10+3"],
                    ["14", "1,500,000", "10+4"],
                    ["15", "1,875,000", "10+5"],
                    ["16", "2,250,000", "10+6"],
                    ["17", "2,625,000", "10+7"],
                    ["18", "3,000,000", "10+8"],
                    ["19", "3,375,000", "10+9"],
                    ["20", "3,750,000", "10+10"]
                ]
            ),
        RuleTable(
                tableNumber: "Table 21",
                title: "Table 21: Wizard Spell Progression",
                headers: ["Wizard Level", "1", "2", "3", "4", "5", "6", "7", "8", "9"],
                rows: [
                    ["1", "1", "—", "—", "—", "—", "—", "—", "—", "—"],
                    ["2", "2", "—", "—", "—", "—", "—", "—", "—", "—"],
                    ["3", "2", "1", "—", "—", "—", "—", "—", "—", "—"],
                    ["4", "3", "2", "—", "—", "—", "—", "—", "—", "—"],
                    ["5", "4", "2", "1", "—", "—", "—", "—", "—", "—"],
                    ["6", "4", "2", "2", "—", "—", "—", "—", "—", "—"],
                    ["7", "4", "3", "2", "1", "—", "—", "—", "—", "—"],
                    ["8", "4", "3", "3", "2", "—", "—", "—", "—", "—"],
                    ["9", "4", "3", "3", "2", "1", "—", "—", "—", "—"],
                    ["10", "4", "4", "3", "2", "2", "—", "—", "—", "—"],
                    ["11", "4", "4", "4", "3", "3", "—", "—", "—", "—"],
                    ["12", "4", "4", "4", "4", "4", "1", "—", "—", "—"],
                    ["13", "5", "5", "5", "4", "4", "2", "—", "—", "—"],
                    ["14", "5", "5", "5", "4", "4", "2", "1", "—", "—"],
                    ["15", "5", "5", "5", "5", "5", "2", "1", "—", "—"],
                    ["16", "5", "5", "5", "5", "5", "3", "2", "1", "—"],
                    ["17", "5", "5", "5", "5", "5", "3", "3", "2", "—"],
                    ["18", "5", "5", "5", "5", "5", "3", "3", "2", "1"],
                    ["19", "5", "5", "5", "5", "5", "3", "3", "3", "1"],
                    ["20", "5", "5", "5", "5", "5", "4", "3", "3", "2"]
                ]
            ),
        RuleTable(
                tableNumber: "Table 22",
                title: "Table 22: Wizard Specialist Requirements",
                headers: ["Specialist", "School", "Race", "Score", "Opposition School(s)"],
                rows: [
                    ["Abjurer", "Abjuration", "H", "15 Wis", "Alteration & Illusion"],
                    ["Conjurer", "Conj./Summ.", "H, 1/2 E", "15 Con", "Gr. Divin. & Invocation"],
                    ["Diviner", "Gr. Divin.", "H, 1/2 E, E", "16 Wis", "Conj./Summ."],
                    ["Enchanter", "Ench./Charm", "H, 1/2 E, E", "16 Cha", "Invoc./Evoc. & Necromancy"],
                    ["Illusionist", "Illusion", "H, G", "16 Dex", "Necro., Invoc./Evoc., Abjur."],
                    ["Invoker", "Invoc./Evoc.", "H", "16 Con", "Ench./Charm Conj./Summ."],
                    ["Necromancer", "Necromancy", "H", "16 Wis", "Illusion & Ench./Charm"],
                    ["Transmuter", "Alteration", "H, 1/2 E", "15 Dex", "Abjuration & Necromancy"]
                ]
            )
    ],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["tables", "wizard", "wizard tables"]
)

let embeddedRule0199: RuleEntry = RuleEntry(
    id: "phb_ch04_alignment",
    book: "PHB",
    chapterNumber: 4,
    chapterTitle: "Alignment",
    breadcrumbs: "Player's Handbook > Chapter 4: Alignment > Alignment",
    topic: "Alignment",
    ruleType: "core_rule",
    summary: "After all other steps toward creating a character have been completed, the player must choose an **alignment** for the character. In some cases (especially the paladin), the choice of alignment may be limited.",
    content: "After all other steps toward creating a character have been completed, the player must choose an **alignment** for the character. In some cases (especially the paladin), the choice of alignment may be limited.\n\nThe character's alignment is a guide to his basic moral and ethical attitudes toward others, society, good, evil, and the forces of the universe in general. Use the chosen alignment as a guide to provide a clearer idea of how the character will handle moral dilemmas. Always consider alignment as a tool, not a straitjacket that restricts the character. Although alignment defines general attitudes, it certainly doesn't prevent a character from changing his beliefs, acting irrationally, or behaving out of character.\n\nAlignment is divided into two sets of attitudes: order and chaos, and good and evil. By combining the different variations within the two sets, nine distinct alignments are created. These nine alignments serve well to define the attitudes of most of the people in the world.\n\n## Law, Neutrality, and Chaos\nAttitudes toward order and chaos are divided into three opposing beliefs. Picture these beliefs as the points of a triangle, all pulling away from each other. The three beliefs are law, chaos, and neutrality. One of these represents each character's ethos—his understanding of society and relationships.\n\nCharacters who believe in law maintain that order, organization, and society are important, indeed vital, forces of the universe. The relationships between people and governments exist naturally. Lawful philosophers maintain that this order is not created by man but is a natural law of the universe. Although man does not create orderly structures, it is his obligation to function within them, lest the fabric of everything crumble. For less philosophical types, lawfulness manifests itself in the belief that laws should be made and followed, if only to have understandable rules for society. People should not pursue personal vendettas, for example, but should present their claims to the proper authorities. Strength comes through unity of action, as can be seen in guilds, empires, and powerful churches.\n\nThose espousing neutrality tend to take a more balanced view of things. They hold that for every force in the universe, there is an opposite force somewhere. Where there is lawfulness, there is also chaos; where there is neutrality, there is also partisanship. The same is true of good and evil, life and death. What is important is that all these forces remain in balance with each other. If one factor becomes ascendant over its opposite, the universe becomes unbalanced. If enough of these polarities go out of balance, the fabric of reality could pull itself apart. For example, if death became ascendant over life, the universe would become a barren wasteland.\n\nPhilosophers of neutrality not only presuppose the existence of opposites, but they also theorize that the universe would vanish should one opposite completely destroy the other (since nothing can exist without its opposite). Fortunately for these philosophers (and all sentient life), the universe seems to be efficient at regulating itself. Only when a powerful, unbalancing force appears (which almost never happens) need the defenders of neutrality become seriously concerned.\n\nThe believers in chaos hold that there is no preordained order or careful balance of forces in the universe. Instead they see the universe as a collection of things and events, some related to each other and others completely independent. They tend to hold that individual actions account for the differences in things and that events in one area do not alter the fabric of the universe halfway across the galaxy. Chaotic philosophers believe in the power of the individual over his own destiny and are fond of anarchistic nations. Being more pragmatic, non-philosophers recognize the function of society in protecting their individual rights. Chaotics can be hard to govern as a group, since they place their own needs and desires above those of society.\n\n## Good, Neutrality, and Evil\nLike law and order, the second set of attitudes is also divided into three parts. These parts describe, more or less, a character's moral outlook; they are his internal guideposts to what is right or wrong.\n\nGood characters are just that. They try to be honest, charitable, and forthright. People are not perfect, however, so few are good all the time. There are always occasional failings and weaknesses. A good person, however, worries about his errors and normally tries to correct any damage done.\n\nRemember, however, that goodness has no absolute values. Although many things are commonly accepted as good (helping those in need, protecting the weak), different cultures impose their own interpretations on what is good and what is evil.\n\nThose with a neutral moral stance often refrain from passing judgment on anything. They do not classify people, things, or events as good or evil; what is, is. In some cases, this is because the creature lacks the capacity to make a moral judgment (animals fall into this category). Few normal creatures do anything for good or evil reasons. They kill because they are hungry or threatened. They sleep where they find shelter. They do not worry about the moral consequences of their actions—their actions are instinctive.\n\nEvil is the antithesis of good and appears in many ways, some overt and others quite subtle. Only a few people of evil nature actively seek to cause harm or destruction. Most simply do not recognize that what they do is destructive or disruptive. People and things that obstruct the evil character's plans are mere hindrances that must be overcome. If someone is harmed in the process... well, that's too bad. Remember that evil, like good, is interpreted differently in different societies.\n\n## Alignment Combinations\nNine different alignments result from combining these two sets. Each alignment varies from all others, sometimes in broad, obvious ways, and sometimes in subtle ways. Each alignment is described in the following paragraphs.\n\n**Lawful Good:** Characters of this alignment believe that an orderly, strong society with a well-organized government can work to make life better for the majority of the people. To ensure the quality of life, laws must be created and obeyed. When people respect the laws and try to help one another, society as a whole prospers. Therefore, lawful good characters strive for those things that will bring the greatest benefit to the most people and cause the least harm. An honest and hard-working serf, a kindly and wise king, or a stern but forthright minister of justice are all examples of lawful good people.\n\n**Lawful Neutral:** Order and organization are of paramount importance to characters of this alignment. They believe in a strong, well-ordered government, whether that government is a tyranny or benevolent democracy. The benefits of organization and regimentation outweigh any moral questions raised by their actions. An inquisitor determined to ferret out traitors at any cost or a soldier who never questions his orders are good examples of lawful neutral behavior.\n\n**Lawful Evil:** These characters believe in using society and its laws to benefit themselves. Structure and organization elevate those who deserve to rule as well as provide a clearly defined hierarchy between master and servant. To this end, lawful evil characters support laws and societies that protect their own concerns. If someone is hurt or suffers because of a law that benefits lawful evil characters, too bad. Lawful evil characters obey laws out of fear of punishment. Because they may be forced to honor an unfavorable contract or oath they have made, lawful evil characters are usually very careful about giving their word. Once given, they break their word only if they can find a way to do it legally, within the laws of the society. An iron-fisted tyrant and a devious, greedy merchant are examples of lawful evil beings.\n\n**Neutral Good:** These characters believe that a balance of forces is important, but that the concerns of law and chaos do not moderate the need for good. Since the universe is vast and contains many creatures striving for different goals, a determined pursuit of good will not upset the balance; it may even maintain it. If fostering good means supporting organized society, then that is what must be done. If good can only come about through the overthrow of existing social order, so be it. Social structure itself has no innate value to them. A baron who violates the orders of his king to destroy something he sees as evil is an example of a neutral good character.\n\n**True Neutral:** True neutral characters believe in the ultimate balance of forces, and they refuse to see actions as either good or evil. Since the majority of people in the world make judgments, true neutral characters are extremely rare. True neutrals do their best to avoid siding with the forces of either good or evil, law or chaos. It is their duty to see that all of these forces remain in balanced contention.\n\nTrue neutral characters sometimes find themselves forced into rather peculiar alliances. To a great extent, they are compelled to side with the underdog in any given situation, sometimes even changing sides as the previous loser becomes the winner. A true neutral druid might join the local barony to put down a tribe of evil gnolls, only to drop out or switch sides when the gnolls were brought to the brink of destruction. He would seek to prevent either side from becoming too powerful. Clearly, there are very few true neutral characters in the world.\n\n**Neutral Evil:** Neutral evil characters are primarily concerned with themselves and their own advancement. They have no particular objection to working with others or, for that matter, going it on their own. Their only interest is in getting ahead. If there is a quick and easy way to gain a profit, whether it be legal, questionable, or obviously illegal, they take advantage of it. Although neutral evil characters do not have the every-man-for-himself attitude of chaotic characters, they have no qualms about betraying their friends and companions for personal gain. They typically base their allegiance on power and money, which makes them quite receptive to bribes. An unscrupulous mercenary, a common thief, and a double-crossing informer who betrays people to the authorities to protect and advance himself are typical examples of neutral evil characters.\n\n**Chaotic Good:** Chaotic good characters are strong individualists marked by a streak of kindness and benevolence. They believe in all the virtues of goodness and right, but they have little use for laws and regulations. They have no use for people who \"try to push folk around and tell them what to do.\" Their actions are guided by their own moral compass which, although good, may not always be in perfect agreement with the rest of society. A brave frontiersman forever moving on as settlers follow in his wake is an example of a chaotic good character.\n\n**Chaotic Neutral:** Chaotic neutral characters believe that there is no order to anything, including their own actions. With this as a guiding principle, they tend to follow whatever whim strikes them at the moment. Good and evil are irrelevant when making a decision. Chaotic neutral characters are extremely difficult to deal with. Such characters have been known to cheerfully and for no apparent purpose gamble away everything they have on the roll of a single die. They are almost totally unreliable. In fact, the only reliable thing about them is that they cannot be relied upon! This alignment is perhaps the most difficult to play. Lunatics and madmen tend toward chaotic neutral behavior.\n\n**Chaotic Evil:** These characters are the bane of all that is good and organized. Chaotic evil characters are motivated by the desire for personal gain and pleasure. They see absolutely nothing wrong with taking whatever they want by whatever means possible. Laws and governments are the tools of weaklings unable to fend for themselves. The strong have the right to take what they want, and the weak are there to be exploited. When chaotic evil characters band together, they are not motivated by a desire to cooperate, but rather to oppose powerful enemies. Such a group can be held together only by a strong leader capable of bullying his underlings into obedience. Since leadership is based on raw power, a leader is likely to be replaced at the first sign of weakness by anyone who can take his position away from him by any method. Bloodthirsty buccaneers and monsters of low Intelligence are fine examples of chaotic evil personalities.\n\n## Non-Aligned Creatures\nIn addition to the alignments above, some things—particularly unintelligent monsters (killer plants, etc.) and animals—never bother with moral and ethical concerns. For these creatures, alignment is simply not applicable. A dog, even a well-trained one, is neither good nor evil, lawful nor chaotic. It is simply a dog. For these creatures, alignment is always detected as neutral.\n\n## Playing the Character's Alignment\nAside from a few minimal restrictions required for some character classes, a player is free to choose whatever alignment he wants for his character. However, before rushing off and selecting an alignment, there are a few things to consider.\n\nFirst, alignment is an aid to role-playing and should be used that way. Don't choose an alignment that will be hard to role play or that won't be fun. A player who chooses an unappealing alignment probably will wind up playing a different alignment anyway. In that case, he might as well have chosen the second alignment to begin with. A player who thinks that lawful good characters are boring goody-two-shoes who don't get to have any fun should play a chaotic good character instead. On the other hand, a player who thinks that properly role-playing a heroic, lawful good fighter would be an interesting challenge is encouraged to try it. No one should be afraid to stretch his imagination. Remember, selecting an alignment is a way of saying, \"My character is going to act like a person who believes this.\"\n\nSecond, the game revolves around cooperation among everyone in the group. The character who tries to go it alone or gets everyone angry at him is likely to have a short career. Always consider the alignments of other characters in the group. Certain combinations, particularly lawful good and any sort of evil, are explosive. Sooner or later the group will find itself spending more time arguing than adventuring. Some of this is unavoidable (and occasionally amusing), but too much is ultimately destructive. As the players argue, they get angry. As they get angry, their characters begin fighting among themselves. As the characters fight, the players continue to get more angry. Once anger and hostility take over a game, no one has fun. And what's the point of playing a game if the players don't have fun?\n\nThird, some people choose to play evil alignments. Although there is no specific prohibition against this, there are several reasons why it is not a good idea. First, the AD&D game is a game of heroic fantasy. What is heroic about being a villain? If an evilly aligned group plays its alignment correctly, it is as much a battle for the characters to work together as it is to take on the outside world. Neutral evil individuals would be paranoid (with some justification) that the others would betray them for profit or self-aggrandizement. Chaotic evil characters would try to get someone else to take all the risks so that they could become (or remain) strong and take over. Although lawful evil characters might have some code of conduct that governed their party, each member would look for ways to twist the rules to his own favor. A group of players who play a harmonious party of evil characters simply are not playing their alignments correctly. By its nature, evil alignments call for disharmony and squabbling, which destroys the fun.\n\nImagine how groups of different alignments might seek to divide a treasure trove. Suppose the adventuring party contains one character of each alignment (a virtually impossible situation, but useful for illustration). Each is then allowed to present his argument:\n\nThe lawful good character says, \"Before we went on this adventure, we agreed to split the treasure equally, and that's what we're going to do. First, we'll deduct the costs of the adventure and pay for the resurrection of those who have fallen, since we're sharing all this equally. If someone can't be raised, then his share goes to his family.\"\n\n\"Since we agreed to split equally, that's fine,\" replies the lawful evil character thoughtfully.\" But there was nothing in this deal about paying for anyone else's expenses. It's not my fault if you spent a lot on equipment! Furthermore, this deal applies only to the surviving partners; I don't remember anything about dead partners. I'm not setting aside any money to raise that klutz. He's someone else's problem.\"\n\nFlourishing a sheet of paper, the lawful neutral character breaks in. \"It's a good thing for you two that I've got things together, nice and organized. I had the foresight to write down the exact terms of our agreement, and we're all going to follow them.\"\n\nThe neutral good character balances the issues and decides, \"I'm in favor of equal shares—that keeps everybody happy. I feel that expenses are each adventurer's own business: If someone spent too much, then he should be more careful next time. But raising fallen comrades seems like a good idea, so I say we set aside money to do that.\"\n\nAfter listening to the above arguments, the true neutral character decides not to say anything yet. He's not particularly concerned with any choice. If the issue can be solved without his becoming involved, great. But if it looks like one person is going to get everything, that's when he'll step in and cast his vote for a more balanced distribution.\n\nThe neutral evil character died during the adventure, so he doesn't have anything to say. However, if he could make his opinion known, he would gladly argue that the group ought to pay for raising him and set aside a share for him. The neutral evil character would also hope that the group doesn't discover the big gem he secretly pocketed during one of the encounters.\n\nThe chaotic good character objects to the whole business. \"Look, it's obvious that the original agreement is messed up. I say we scrap it and reward people for what they did. I saw some of you hiding in the background when the rest of us were doing all the real fighting. I don't see why anyone should be rewarded for being a coward! As far as raising dead partners, I say that's a matter of personal choice. I don't mind chipping in for some of them, but I don't think I want everyone back in the group.\"\n\nOutraged at the totally true but tactless accusation of cowardice, the chaotic evil character snaps back, \"Look, I was doing an important job, guarding the rear! Can I help it if nothing tried to sneak up behind us? Now, it seems to me that all of you are pretty beat up—and I'm not. So, I don't think there's going to be too much objection if I take all the jewelry and that wand. And I'll take anything interesting those two dead guys have. Now, you can either work with me and do what I say or get lost—permanently!\"\n\nThe chaotic neutral character is also dead (after he tried to charge a gorgon), so he doesn't contribute to the argument. However, if he were alive, he would join forces with whichever side appealed to him the most at the moment. If he couldn't decide he'd flip a coin.\n\nClearly, widely diverse alignments in a group can make even the simplest task impossible. It is almost certain that the group in the example would come to blows before they could reach a decision. But dividing cash is not the only instance in which this group would have problems. Consider the battle in which they gained the treasure in the first place.\n\nUpon penetrating the heart of the ruined castle, the party met its foe, a powerful gorgon commanded by a mad warrior. There, chained behind the two, was a helpless peasant kidnapped from a nearby village.\n\nThe lawful good character unhesitatingly (but not foolishly) entered the battle; it was the right thing to do. He considered it his duty to protect the villagers. Besides, he could not abandon an innocent hostage to such fiends. He was willing to fight until he won or was dragged off by his friends. He had no intention of fighting to his own death, but he would not give up until he had tried his utmost to defeat the evil creatures.\n\nThe lawful evil character also entered the battle willingly. Although he cared nothing for the peasant, he could not allow the two fiends to mock him. Still, there was no reason for him to risk all for one peasant. If forced to retreat, he could return with a stronger force, capture the criminals, and execute them publicly. If the peasant died in the meantime, their punishment would be that much more horrible.\n\nThe lawful neutral character was willing to fight, because the villains threatened public order. However, he was not willing to risk his own life. He would have preferred to come back later with reinforcements. If the peasant could be saved, that is good, because he is part of the community. If not, it would be unfortunate but unavoidable.\n\nThe neutral good character did not fight the gorgon or the warrior, but he tried to rescue the peasant. Saving the peasant was worthwhile, but there was no need to risk injury and death along the way. Thus, while the enemy was distracted in combat, he tried to slip past and free the peasant.\n\nThe true neutral character weighed the situation carefully. Although it looked like the forces working for order would have the upper hand in the battle, he knew there had been a general trend toward chaos and destruction in the region that must be combatted. He tried to help, but if the group failed, he could work to restore the balance of law and chaos elsewhere in the kingdom.\n\nThe neutral evil character cared nothing about law, order, or the poor peasant. He figured that there had to be some treasure around somewhere. After all, the villain's lair had once been a powerful temple. He could poke around for cash while the others did the real work. If the group got into real trouble and it looked like the villains would attack him, then he would fight. Unfortunately, a stray magical arrow killed him just after he found a large gem.\n\nThe chaotic good character joined the fight for several reasons. Several people in the group were his friends, and he wanted to fight at their sides. Furthermore, the poor, kidnapped peasant deserved to be rescued. Thus, the chaotic good character fought to aid his companions and save the peasant. He didn't care if the villains were killed, captured, or just driven away. Their attacks against the village didn't concern him.\n\nThe chaotic neutral character decided to charge, screaming bloodthirsty cries, straight for the gorgon. Who knows? He might have broken its nerve and thrown it off guard. He discovered that his plan was a bad one when the gorgon's breath killed him.\n\nThe chaotic evil character saw no point in risking his hide for the villagers, the peasant, or the rest of the party. In fact, he thought of several good reasons not to. If the party was weakened, he might be able to take over. If the villains won, he could probably make a deal with them and join their side. If everyone was killed, he could take everything he wanted and leave. All these sounded a lot better than getting hurt for little or no gain. So he stayed near the back of the battle, watching. If anyone asked, he could say he was watching the rear, making sure no one came to aid the enemy.\n\nThe two preceding examples of alignment are extreme situations. It's not very likely that a player will ever play in a group of alignments as varied as those given here. If such a group ever does form, players should seriously reconsider the alignments of the different members of the party! More often, the adventuring party will consist of characters with relatively compatible alignments. Even then, players who role-play their characters' alignment will discover small issues of disagreement.\n\n## Changing Alignment\nAlignment is a tool, not a straitjacket. It is possible for a player to change his character's alignment after the character is created, either by action or choice. However, changing alignment is not without its penalties.\n\nMost often the character's alignment will change because his actions are more in line with a different alignment. This can happen if the player is not paying attention to the character and his actions. The character gradually assumes a different alignment. For example, a lawful good fighter ignores the village council's plea for help because he wants to go fight evil elsewhere. This action is much closer to chaotic good, since the character is placing his desire over the need of the community. The fighter would find himself beginning to drift toward chaotic good alignment.\n\nAll people have minor failings, however, so the character does not instantly become chaotic good. Several occasions of lax behavior are required before the character's alignment changes officially. During that time, extremely lawful good activities can swing the balance back. Although the player may have a good idea of where the character's alignment lies, only the DM knows for sure.\n\nLikewise, the character cannot wake up one morning and say, \"I think I'll become lawful good today.\" (Well, he can say it, but it won't have any effect.) A player can choose to change his character's alignment, but this change is accomplished by deeds, not words. Tell the DM of the intention and then try to play according to the new choice.\n\nFinally, there are many magical effects that can change a character's alignment. Rare and cursed magical items can instantly alter a character's alignment. Powerful artifacts may slowly erode a character's determination and willpower, causing subtle shifts in behavior. Spells can compel a character to perform actions against his will. Although all of these have an effect, none are as permanent or damaging as those choices the character makes of his own free will.\n\nChanging the way a character behaves and thinks will cost him experience points and slow his advancement. Part of a character's experience comes from learning how his own behavior affects him and the world around him. In real life, for example, a person learns that he doesn't like horror movies only by going to see a few of them. Based on that experience, he learns to avoid certain types of movies. Changing behavior means discarding things the character learned previously. Relearning things takes time. This costs the character experience.\n\nThere are other, more immediate effects of changing alignment. Certain character classes require specific alignments. A paladin who is no longer lawful good is no longer a paladin. A character may have magical items usable only to specific alignments (intelligent swords, etc.). Such items don't function (and may even prove dangerous) in the hands of a differently aligned character.\n\nNews of a character's change in behavior will certainly get around to friends and acquaintances. Although some people he never considered friendly may now warm to him, others may take exception to his new attitudes. A few may even try to help him \"see the error of his ways.\" The local clergy, on whom he relies for healing, may look askance on his recent behavior, denying him their special services (while at the same time sermonizing on his plight). The character who changes alignment often finds himself unpopular, depending on the attitudes of the surrounding people. People do not understand him. If the character drifts into chaotic neutral behavior in a highly lawful city, the townspeople might decide that the character is afflicted and needs close supervision, even confinement, for his own good!\n\nUltimately, the player is advised to pick an alignment he can play comfortably, one that fits in with those of the rest of the group, and he should stay with that alignment for the course of the character's career. There will be times when the DM, especially if he is clever, creates situations to test the character's resolve and ethics. But finding the right course of action within the character's alignment is part of the fun and challenge of role-playing.\n\n(See also, Helm of Opposite Alignment, in the Dungeon Master Guide)",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["alignment", "damage", "intelligence", "strength"]
)

let embeddedRule0200: RuleEntry = RuleEntry(
    id: "phb_ch05_nonweapon_proficiencies_i",
    book: "PHB",
    chapterNumber: 5,
    chapterTitle: "Proficiencies",
    breadcrumbs: "Player's Handbook > Chapter 5: Proficiencies > Nonweapon Proficiencies I",
    topic: "Nonweapon Proficiencies I",
    ruleType: "core_rule",
    summary: "A player character is more than a collection of combat modifiers. Most people have a variety of skills learned over the years.",
    content: "A player character is more than a collection of combat modifiers. Most people have a variety of skills learned over the years. Consider yourself as an example—how many skills do you possess? If you have gone through 12 years of school, were moderately active in after-school programs, and did fairly well on your grades, the following might be a partial list of your skills:\n\n:English reading and writing\n:Geometry, algebra, and trigonometry\n:Basic chemistry\n:Basic physics\n:Music (playing an instrument, singing, or both)\n:Spanish reading and writing (or French, German, etc.)\n:Basic Shop or Home Economics\n:Typing\n:Driving\n:History\n:Basic biology\n\nIn addition to the things learned in school, you have also learned things from your parents, friends, scouts, or other groups. You might be able to add any of the following to your list:\n\n:Swimming\n:Fishing\n:Sailing\n:First aid\n:Cooking\n:Embroidery\n\n:Hunting\n:Canoeing\n:Horseback riding\n:Animal training\n:Sewing\n:Dancing\n\nIf you consider all your hobbies and all the things you have done, you probably know many more skills. In fact, if you make a list, you probably will be surprised by the large number of basic skills you have. And, at this point, you are (or were) still young!\n\nNow, having graduated from school, you get a job. Are you just a carpenter, mechanic, electrician, salesman, or secretary? Of course not; you are a lot more than just your job. All those things you learned in school and elsewhere are part of what you are. Shouldn't it be the same for your player character?\n\nFor a really complete role-playing character, you should know what your character can do. There are three different ways to do this: using what you know, using secondary skills, and using nonweapon proficiencies. Each of these is optional, but each increases the amount of detail that rounds out your character.\n\n## Using What You Know\nIf your DM decides not to use secondary skills or nonweapon proficiencies, situations will arise in which you'll have to determine whether your character has certain skills. For example, Delsenora the wizard slips at the edge of a steep riverbank and tumbles into the water. The current sweeps her into the middle of the river. To escape, she must swim to safety. But does Delsenora know how to swim?\n\nOne way to answer this is to pretend that your character knows most of the things that you know. Do you know how to swim? If you do, then your character can swim. If you know a little about mountain climbing, horseback riding, carpentry, or sewing, your character knows these things, too. This also applies to things your character might want to build. Perhaps your character decides he wants to build a catapult. If you can show your DM how to make such a device, then the DM may allow your character the same knowledge. Indeed, you might visit the local library just to gain this information.\n\nThere are real advantages to this method. You can learn something at the library or school and bring it into your game. Also, there are fewer rules to get in the way of your fun. Since there are fewer rules, your DM has a lot of flexibility and can play out all the drama inherent in a scene.\n\nThere are also problems with this method. First, you probably know a lot of things your character should not—basic electronics, the components of gunpowder, or calculus, for instance. You have a lot of knowledge that is just not available to someone in a medieval world (even a fantasy medieval world). Likewise, there are things that a typical person in a medieval world would know that you, as a modern person, have never needed to learn. Do you know how to make armor? Skin a deer? Salt meat away for the winter? Turn flax into linen? Thatch a roof? Read heraldry? You might, but there is no way you can consider these common skills any more. But in a medieval world they would be common.\n\nAlso, knowing something about a skill or trade doesn't mean you know a lot, and there is a big difference between the two. When Delsenora fell into the raging river, she had to swim out. But was she a strong enough swimmer to pull free of the current? The DM must make up a rule on the spot to handle the situation. Perhaps you can swim, but can you swim well enough to escape a raging torrent?\n\nThe biggest drawback to this method is that there are no rules to resolve tricky situations. The DM must make it up during play. Some players and DMs enjoy doing this. They think up good answers quickly. Many consider this to be a large part of the fun. This method is perfect for them, and they should use it.\n\nOther players and DMs like to have clear rules to prevent arguments. If this is the case in your group, it is better to use secondary skills or nonweapon proficiencies.\n\n## Secondary Skills\nThe second method for determining what your character knows is to assign secondary skills. Secondary skills are broad areas of expertise. Most correspond to occupations that your character may have been apprenticed in or otherwise picked up before beginning his adventuring life. Secondary skills are much more general than nonweapon proficiencies. They should not be used in combination with nonweapon proficiencies, which are explained later.\n\nEvery player character has a chance at a secondary skill. Either choose one from Table 36 or take a chance and roll randomly. A random roll may result in one, two, or no secondary skills.\n\nOnce a character has a secondary skill, it is up to the player and the DM to determine just what the character can do with it. The items in parentheses after each skill describe some of the things the character knows. Other knowledge may be added with the DM's approval. Thus, a hunter might know the basics of finding food in the wilderness, how to read animal signs to identify the types of creatures in the area, the habits of dangerous animals, and how to stalk wild animals.\n\nLike the previous method (\"Using What You Know\"), this method has strengths and weaknesses. Secondary skills do not provide any rules for determining whether a character succeeds when he uses a skill to do something difficult. It is safe to assume that simple jobs succeed automatically. (A hunter could find food for himself without any difficulty.) For more complicated tasks, the DM must assign a chance for success. He can assign a percentage chance, have the character make a saving throw, or require an Ability check (see Glossary). The DM still has a lot of flexibility.\n\nThis flexibility means the DM must sometimes make up the rule to cover the situation, however. As mentioned earlier, some DMs enjoy this; others do not, their strengths being elsewhere. While secondary skills define and limit the player's options, they do not greatly simplify the DM's job.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["armor", "nonweapon", "nonweapon proficiencies i", "proficiencies", "saving throw", "strength", "surprise"]
)

let embeddedRule0201: RuleEntry = RuleEntry(
    id: "phb_ch05_nonweapon_proficiencies_ii",
    book: "PHB",
    chapterNumber: 5,
    chapterTitle: "Proficiencies",
    breadcrumbs: "Player's Handbook > Chapter 5: Proficiencies > Nonweapon Proficiencies II",
    topic: "Nonweapon Proficiencies II",
    ruleType: "core_rule",
    summary: "The most detailed method for handling character skills is that of nonweapon proficiencies. These are much like weapon proficiencies.",
    content: "The most detailed method for handling character skills is that of nonweapon proficiencies. These are much like weapon proficiencies. Each character starts with a specific number of nonweapon proficiency slots and then earns additional slots as he advances. Initial slots must be assigned immediately; they cannot be saved or held in reserve.\n\nNonweapon proficiencies are the most detailed way to handle the question of what the player character knows. They allow the player to choose from a broad selection and define the effects of each choice. Like the other methods, however, this system is not without drawbacks. First, nonweapon proficiencies are rigid. Being so defined, they limit the options of both the player and DM. At the same time, there will still be questions unanswered by these proficiencies. Whereas before such questions were broad, they will now tend to be more precise and detailed. Secondly, using this system increases the amount of time needed to create a character. While the end result is a more complete, well-rounded person, setup time can take up to two or three hours. Novice players especially may be overwhelmed by the number of choices and rules.\n\nUnlike weapon proficiencies, in which some weapons are not available to certain character classes, all nonweapon proficiencies are available to all characters. Some nonweapon proficiencies are easier for certain character classes to learn, however.\n\nTable 37 lists all nonweapon proficiencies. They are divided into categories that correspond to character groups. The proficiencies listed under each group can be learned easily by characters of that group. A fifth category—\"General\"—contains proficiencies that can be learned easily by any character.\n\nRefer to Table 38. When a player selects a nonweapon proficiency from those categories listed under \"Proficiency Groups\" for his character's group, it requires the number of proficiency slots listed in Table 37. When a player selects a proficiency from any other category, it requires one additional proficiency slot beyond the number listed.\n\n## Using Nonweapon Proficiencies\nWhen a character uses a proficiency, either the attempt is automatically successful, or the character must roll a proficiency check. If the task is simple or the proficiency has only limited game use (such as cobbling or carpentry), a proficiency check is generally not required. If the task the character is trying to perform is difficult or subject to failure, a proficiency check is required. Read the descriptions of the proficiencies for details about how and when each can be used.\n\nIf a proficiency check is required, Table 37 lists which ability is used with each proficiency. Add the modifier (either positive or negative) listed in Table 37 to the appropriate ability score. Then the player rolls 1d20. If the roll is equal to or less than the character's adjusted ability score, the character accomplished what he was trying to do. If the roll is greater than the character's ability score, the character fails at the task. (A roll of 20 always fails.) The DM determines what effects, if any, accompany failure.\n\nOf course, to use a proficiency, the character must have any tools and materials needed to do the job. A carpenter can do very little without his tools, and a smith is virtually helpless without a good forge. The character must also have enough time to do the job. Certainly, carpentry proficiency enables your character to build a house, but not in a single day! Some proficiency descriptions state how much time is required for certain jobs. Most, however, are left to the DM's judgment.\n\nThe DM can raise or lower a character's chance of success if the situation calls for it. Factors that can affect a proficiency check include availability and quality of tools, quality of raw material used, time spent doing the job, difficulty of the job, and how familiar the character is with the task. A positive modifier is added to the ability score used for the check. A negative modifier is subtracted from the ability score.\n\nRath, skilled as a blacksmith, has been making horseshoes for years. Because he is so familiar with the task and has every tool he needs, the DM lets him make horseshoes automatically, without risk of failure. However, Delsenora has persuaded Rath to make an elaborate wrought-iron cage (she needs it to create a magical item). Rath has never done this before and the work is very intricate, so the DM imposes a penalty of -3 on Rath's ability check.\n\nWhen two proficient characters work together on the same task, the highest ability score is used (the one with the greatest chance of success). Furthermore, a +1 bonus is added for the other character's assistance. The bonus can never be more than +1, as having too many assistants is sometimes worse than having none.\n\nNonweapon proficiencies can also be improved beyond the ability score the character starts with. For every additional proficiency slot a character spends on a nonweapon proficiency, he gains a +1 bonus to those proficiency checks. Thus, Rath (were he not an adventurer) might spend his additional proficiency slots on blacksmithing, to become a very good blacksmith, gaining a +1, +2, +3, or greater bonus to his ability checks.\n\nMany nonplayer craftsmen are more accomplished in their fields than player characters, having devoted all their energies to improving a single proficiency. Likewise, old masters normally have more talent than young apprentices—unless the youth has an exceptional ability score! However, age is no assurance of talent. Remember that knowing a skill and being good at it are two different things. There are bad potters, mediocre potters, and true craftsmen. All this has much less to do with age than with dedication and talent.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["nonweapon", "nonweapon proficiencies ii", "proficiencies", "proficiency", "weapons"]
)

let embeddedRule0202: RuleEntry = RuleEntry(
    id: "phb_ch05_nonweapon_proficiencies_tables",
    book: "PHB",
    chapterNumber: 5,
    chapterTitle: "Proficiencies",
    breadcrumbs: "Player's Handbook > Chapter 5: Proficiencies > Nonweapon Proficiencies Tables",
    topic: "Nonweapon Proficiencies Tables",
    ruleType: "core_rule",
    summary: "",
    content: "## Table 36: Secondary Skills\n\n[TABLE_REF: Table 36: Secondary Skills]\n\n## Table 37: Nonweapon Proficiency Groups\n\n[TABLE_REF: General]\n\n[TABLE_REF: Priest]\n\n[TABLE_REF: Rogue]\n\n[TABLE_REF: Warrior]\n\n[TABLE_REF: Wizard]\n\n## Table 38: Nonweapon Proficiency Group Crossovers\n\n[TABLE_REF: Table 38: Nonweapon Proficiency Group Crossovers]",
    tables: [
        RuleTable(
                tableNumber: "Table 36",
                title: "Table 36: Secondary Skills",
                headers: ["D100 Roll", "Secondary Skill"],
                rows: [
                    ["01-02", "Armorer (make, repair & evaluate armor and weapons)"],
                    ["03-04", "Bowyer/Fletcher (make, repair, & evaluate bows and arrows)"],
                    ["05-10", "Farmer (basic agriculture)"],
                    ["11-14", "Fisher (swimming, nets, and small boat handling)"],
                    ["15-20", "Forester (basic wood lore, lumbering)"],
                    ["21-23", "Gambler (knowledge of gambling games)"],
                    ["24-27", "Groom (animal handling)"],
                    ["28-32", "Hunter (basic wood lore, butchering, basic tracking)"],
                    ["33-34", "Jeweler (appraisal of gems and jewelry)"],
                    ["35-37", "Leather worker (skinning, tanning)"],
                    ["38-39", "Limner/Painter (map making, appraisal of art objects)"],
                    ["40-42", "Mason (stone-cutting)"],
                    ["43-44", "Miner (stone-cutting, assaying)"],
                    ["45-46", "Navigator (astronomy, sailing, swimming, navigation)"],
                    ["47-49", "Sailor (sailing, swimming)"],
                    ["50-51", "Scribe (reading, writing, basic math)"],
                    ["52-53", "Shipwright (sailing, carpentry)"],
                    ["54-56", "Tailor/Weaver (weaving, sewing, embroidery)"],
                    ["57-59", "Teamster/Freighter (animal handling, wagon-repair)"],
                    ["60-62", "Trader/Barterer (appraisal of common goods)"],
                    ["63-66", "Trapper/Furrier (basic wood lore, skinning)"],
                    ["67-68", "Weaponsmith (make, repair, & evaluate weapons)"],
                    ["69-71", "Woodworker/Carpenter (carpentry, carving)"],
                    ["72-85", "No skill of measurable worth"],
                    ["86-00", "Roll twice (reroll any result of 86-00)"]
                ]
            ),
        RuleTable(
                tableNumber: "",
                title: "General",
                headers: ["Proficiency", "# of Slots Required", "Relevant Ability", "Check Modifier"],
                rows: [
                    ["Agriculture", "1", "Intelligence", "0"],
                    ["Animal Handling", "1", "Wisdom", "-1"],
                    ["Animal Training", "1", "Wisdom", "0"],
                    ["Artistic Ability", "1", "Wisdom", "0"],
                    ["Blacksmithing", "1", "Strength", "0"],
                    ["Brewing", "1", "Intelligence", "0"],
                    ["Carpentry", "1", "Strength", "0"],
                    ["Cobbling", "1", "Dexterity", "0"],
                    ["Cooking", "1", "Intelligence", "0"],
                    ["Dancing", "1", "Dexterity", "0"],
                    ["Direction Sense", "1", "Wisdom", "1"],
                    ["Etiquette", "1", "Charisma", "0"],
                    ["Fire-building", "1", "Wisdom", "-1"],
                    ["Fishing", "1", "Wisdom", "-1"],
                    ["Heraldry", "1", "Intelligence", "0"],
                    ["Languages, Modern", "1", "Intelligence", "0"],
                    ["Leatherworking", "1", "Intelligence", "0"],
                    ["Mining", "2", "Wisdom", "-3"],
                    ["Pottery", "1", "Dexterity", "-2"],
                    ["Riding, Airborne", "2", "Wisdom", "-2"],
                    ["Riding, Land-Based", "1", "Wisdom", "3"],
                    ["Rope Use", "1", "Dexterity", "0"],
                    ["Seamanship", "1", "Dexterity", "1"],
                    ["Seamstress/Tailor", "1", "Dexterity", "-1"],
                    ["Singing", "1", "Charisma", "0"],
                    ["Stonemasonry", "1", "Strength", "-2"],
                    ["Swimming", "1", "Strength", "0"],
                    ["Weather Sense", "1", "Wisdom", "-1"],
                    ["Weaving", "1", "Intelligence", "-1"]
                ]
            ),
        RuleTable(
                tableNumber: "",
                title: "Priest",
                headers: ["Proficiency", "# of Slots Required", "Relevant Ability", "Check Modifier"],
                rows: [
                    ["Ancient History", "1", "Intelligence", "-1"],
                    ["Astrology", "2", "Intelligence", "0"],
                    ["Engineering", "2", "Intelligence", "-3"],
                    ["Healing", "2", "Wisdom", "-2"],
                    ["Herbalism", "2", "Intelligence", "-2"],
                    ["Languages, Ancient", "1", "Intelligence", "0"],
                    ["Local History", "1", "Charisma", "0"],
                    ["Musical Instrument", "1", "Dexterity", "-1"],
                    ["Navigation", "1", "Intelligence", "-2"],
                    ["Reading/Writing", "1", "Intelligence", "1"],
                    ["Religion", "1", "Wisdom", "0"],
                    ["Spellcraft", "1", "Intelligence", "-2"]
                ]
            ),
        RuleTable(
                tableNumber: "",
                title: "Rogue",
                headers: ["Proficiency", "# of Slots Required", "Relevant Ability", "Check Modifier"],
                rows: [
                    ["Ancient History", "1", "Intelligence", "-1"],
                    ["Appraising", "1", "Intelligence", "0"],
                    ["Blind-fighting", "2", "NA", "NA"],
                    ["Disguise", "1", "Charisma", "-1"],
                    ["Forgery", "1", "Dexterity", "-1"],
                    ["Gaming", "1", "Charisma", "0"],
                    ["Gem Cutting", "2", "Dexterity", "-2"],
                    ["Juggling", "1", "Dexterity", "-1"],
                    ["Jumping", "1", "Strength", "0"],
                    ["Local History", "1", "Charisma", "0"],
                    ["Musical Instrument", "1", "Dexterity", "-1"],
                    ["Reading Lips", "2", "Intelligence", "-2"],
                    ["Set Snares", "1", "Dexterity", "-1"],
                    ["Tightrope Walking", "1", "Dexterity", "0"],
                    ["Tumbling", "1", "Dexterity", "0"],
                    ["Ventriloquism", "1", "Intelligence", "-2"]
                ]
            ),
        RuleTable(
                tableNumber: "",
                title: "Warrior",
                headers: ["Proficiency", "# of Slots Required", "Relevant Ability", "Check Modifier"],
                rows: [
                    ["Animal Lore", "1", "Intelligence", "0"],
                    ["Armorer", "2", "Intelligence", "-2"],
                    ["Blind-fighting", "2", "NA", "NA"],
                    ["Bowyer/Fletcher", "1", "Dexterity", "-1"],
                    ["Charioteering", "1", "Dexterity", "2"],
                    ["Endurance", "2", "Constitution", "0"],
                    ["Gaming", "1", "Charisma", "0"],
                    ["Hunting", "1", "Wisdom", "-1"],
                    ["Mountaineering", "1", "NA", "NA"],
                    ["Navigation", "1", "Intelligence", "-2"],
                    ["Running", "1", "Constitution", "-6"],
                    ["Set Snares", "1", "Dexterity", "-1"],
                    ["Survival", "2", "Intelligence", "0"],
                    ["Tracking", "2", "Wisdom", "0"],
                    ["Weaponsmithing", "3", "Intelligence", "-3"]
                ]
            ),
        RuleTable(
                tableNumber: "",
                title: "Wizard",
                headers: ["Proficiency", "# of Slots Required", "Relevant Ability", "Check Modifier"],
                rows: [
                    ["Ancient History", "1", "Intelligence", "-1"],
                    ["Astrology", "2", "Intelligence", "0"],
                    ["Engineering", "2", "Intelligence", "-3"],
                    ["Gem Cutting", "2", "Dexterity", "-2"],
                    ["Herbalism", "2", "Intelligence", "-2"],
                    ["Languages, Ancient", "1", "Intelligence", "0"],
                    ["Navigation", "1", "Intelligence", "-2"],
                    ["Reading/Writing", "1", "Intelligence", "1"],
                    ["Religion", "1", "Wisdom", "0"],
                    ["Spellcraft", "1", "Intelligence", "-2"]
                ]
            ),
        RuleTable(
                tableNumber: "Table 38",
                title: "Table 38: Nonweapon Proficiency Group Crossovers",
                headers: ["Class", "Proficiency Groups"],
                rows: [
                    ["Fighter", "Warrior, General"],
                    ["Paladin", "Warrior, Priest, General"],
                    ["Ranger", "Warrior, Wizard, General"],
                    ["Cleric", "Priest, General"],
                    ["Druid", "Priest, Warrior, General"],
                    ["Mage", "Wizard, General"],
                    ["Illusionist", "Wizard, General"],
                    ["Thief", "Rogue, General"],
                    ["Bard", "Rogue, Warrior, Wizard, General"]
                ]
            )
    ],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["nonweapon", "nonweapon proficiencies tables", "proficiencies", "proficiency", "tables"]
)

let embeddedRule0203: RuleEntry = RuleEntry(
    id: "phb_ch05_proficiencies",
    book: "PHB",
    chapterNumber: 5,
    chapterTitle: "Proficiencies",
    breadcrumbs: "Player's Handbook > Chapter 5: Proficiencies > Proficiencies",
    topic: "Proficiencies",
    ruleType: "core_rule",
    summary: "Most of what a player character can do is defined by his race, class, and ability scores. These three characteristics don't cover everything, however.",
    content: "## Chapter 5: Proficiencies (Optional)\nMost of what a player character can do is defined by his race, class, and ability scores. These three characteristics don't cover everything, however. Characters can have a wide range of talents, from the potent (and intricate) arts of magic to the simple and mundane knowledge of how to build a good fire. The character's magical ability (or lack thereof) is defined by his class. Lesser abilities, such as fire building, are defined by proficiencies.\n\nA proficiency is a learned skill that isn't essential to the character's class. A ranger, for example, may find it useful to know something about navigation, especially if he lives near an ocean or sea coast. On the other hand, he isn't likely to suffer if he doesn't know how to navigate; he is a ranger, not a sailor.\n\nProficiencies are divided into two groups: weapon proficiencies (those related to weapons and combat) and nonweapon proficiencies (those related to everything else).\n\nAll proficiency rules are additions to the game. Weapon proficiencies are tournament-level rules, optional in regular play, and nonweapon proficiencies are completely optional. Proficiencies are not necessary for a balanced game. They add an additional dimension to characters, however, and anything that enriches characterization is a bonus. If weapon proficiencies are used in your game, expect them to apply to all characters, including NPCs. Nonweapon proficiencies may be used by players who enjoy them and ignored by those who don't without giving unfair advantages to anyone (provided your DM allows this; he's the one who must deal with any problems).\n\nOnce a proficiency slot is filled, it can never be changed or reassigned.\n\n### Acquiring Proficiencies\nEven newly created, 1st-level characters have proficiencies. The number of proficiency slots that a character starts with is determined by his group, as shown in Table 34. Each proficiency slot is empty until the player \"fills\" it by selecting a proficiency. If your DM allows nonweapon proficiencies, the character's Intelligence score can modify the number of slots he has, granting him more proficiencies (see Table 4). In both cases, new proficiencies are learned the same way.\n\nConsider the case of Rath, a dwarf fighter. Table 34 gives him four weapon proficiency slots (he is a warrior). If nonweapon proficiencies are used, he has three slots and his Intelligence of 11 gives him two additional proficiency slots (according to Table 4) for a total of five nonweapon proficiency slots. The player must assign weapon or nonweapon proficiencies to all of these slots before the character goes on his first adventure. These represent what the character has learned before beginning his adventuring career.\n\nThereafter, as the character advances in experience levels, he gains additional proficiency slots. The rate at which he gains them depends on the group he belongs to. Table 34 lists how many weapon and nonweapon proficiency slots the character starts with, and how many levels the character must gain before he earns another slot.\n\n[TABLE_REF: Table 34: Proficiency Slots]\n\n**Initial Weapon Proficiencies** is the number of weapon proficiency slots received by characters of that group at 1st level.\n\n**# Levels** (for both weapon and nonweapon proficiencies) tells how quickly a character gains additional proficiency slots. A new proficiency slot is gained at every experience level that is evenly divisible by the number listed. Rath (a warrior), for example, gains one weapon proficiency slot at every level evenly divisible by 3. He gets one new slot at 3rd level, another at 6th, another at 9th, and so on. (Note that Rath also gains one nonweapon proficiency at 3rd, 6th, 9th, etc.)\n\n**Penalty** is the modifier to the character's attack rolls when he fights using a weapon he is not proficient with. Rath, a dwarf, chose to be proficient with the warhammer. Finding himself in a desperate situation, he snatches up a flail, even though he knows little about it (he is not proficient with it). Using with weapon awkwardly, he has a -2 penalty to his chance to hit.\n\n**Initial Nonweapon Proficiencies** is the number of nonweapon proficiency slots that character has at 1st level. Even if you are playing with weapon proficiencies, nonweapon proficiencies are optional.\n\n### Training\nLike all skills and abilities, proficiencies do not leap unbidden and fully realized into a character's mind. Instead, a character must train, study, and practice to learn a new proficiency. However, role-playing the training time needed to learn a new skill is not much fun. Thus, there are no training times or study periods associated with any proficiency. When a character chooses a proficiency, it is assumed that he had been studying it in his spare time.\n\nConsider just how much spare time the character has. The player is not role-playing every second of his character's life. The player may decide to have his character spend a night in town before setting out on the long journey the next day. Perhaps the character must wait around for several days while his companions heal from the last adventure. Or he might spend weeks on an uneventful ocean voyage. What is he doing during that time?\n\nAmong other things, he is studying whatever new proficiencies he will eventually learn. Using this \"down time\" to handle the unexciting aspects of a role-playing campaign lets players concentrate on more important (or more interesting) matters.\n\nAnother part of training is finding a teacher. Most skills are easier to learn if someone teaches the character. The DM can handle this in several ways. For those who like simplicity, ignore the need for teachers—there are self-taught people everywhere in the world. For those who want more complexity, make the player characters find someone to teach them any new proficiency they want to learn. This can be another player character or an NPC. Although this adds realism, it tends to limit the PC's adventuring options, especially if he is required to stay in regular contact with his instructor. Furthermore, most teachers want payment. While a barter arrangement might be reached, the normal payment is cash. The actual cost of the service depends on the nature of the skill, the amount of training desired, the availability of tutors, the greed of the instructor, and the desire of the DM to remove excess cash from his campaign.",
    tables: [
        RuleTable(
                tableNumber: "Table 34",
                title: "Table 34: Proficiency Slots",
                headers: ["Group", "Initial (Weapon)", "#Levels (Weapon)", "Penalty", "Initial (Nonweapon)", "#Levels (Nonweapon)"],
                rows: [
                    ["Cleric", "2", "4", "-3", "4", "3"],
                    ["Thief", "2", "4", "-3", "3", "4"],
                    ["Fighter", "4", "3", "-2", "3", "3"],
                    ["Wizard", "1", "6", "-5", "4", "3"]
                ]
            )
    ],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["intelligence", "proficiencies", "proficiency", "weapons"]
)

let embeddedRule0204: RuleEntry = RuleEntry(
    id: "phb_ch05_weapon_proficiencies",
    book: "PHB",
    chapterNumber: 5,
    chapterTitle: "Proficiencies",
    breadcrumbs: "Player's Handbook > Chapter 5: Proficiencies > Weapon Proficiencies",
    topic: "Weapon Proficiencies",
    ruleType: "core_rule",
    summary: "A weapon proficiency measures a character's knowledge and training with a specific weapon. When a character is created, the player checks Table 34 to see how many weapon proficiency slots the character has.",
    content: "## Weapon Proficiencies\nA weapon proficiency measures a character's knowledge and training with a specific weapon. When a character is created, the player checks Table 34 to see how many weapon proficiency slots the character has. These initial slots must be filled immediately, before the character embarks on his first adventure. Any slots that aren't filled by then are lost.\n\nEach weapon proficiency slot must be assigned to a particular weapon, not just a class of weapons. Each weapon listed in Table 44 (Weapons) requires its own proficiency; each has its own special tricks and quirks that must be mastered before the weapon can be handled properly and effectively. A fencer who is master of the epee, for example, is not necessarily skilled with a saber; the two weapons look similar, but the fighting styles they are designed for are entirely different. A player character could become proficient with a long bow or a short bow, but not with all bows in general (unless he devotes a proficiency slot to each individually). Furthermore, a character can assign weapon proficiency slots only to those weapons allowed to his character class.\n\nAs a character reaches higher experience levels, he also earns additional weapon proficiencies. The rate at which proficiencies are gained depends on the character's class. Warriors, who concentrate on their martial skills, learn to handle a great number of weapons. They gain weapon proficiencies quickly. Wizards, who spend their time studying forgotten magical arts, have little time to practice with weapons. They gain additional weapon proficiencies very slowly. Multi-class characters can use the most beneficial line on Table 34 to determine their initial proficiencies and when they gain new proficiencies.\n\n## Effects of Weapon Proficiencies\nA character who has a specific weapon proficiency is skilled with that weapon and familiar with its use. A character does not gain any bonuses for using a weapon he is proficient with; the combat rules and attack chances assume that everyone uses a weapon he is proficient with. This eliminates the need to add a modifier to every die roll during battle.\n\nWhen a character uses a weapon that he is not proficient with, however, he suffers a penalty on his chance to hit. The size of this penalty depends on the character's class. Warriors have the smallest penalty because they are assumed to have passing familiarity with all weapons. Wizards, by comparison, are heavily penalized because of their limited study of weapons. The modifiers for each class (which are taken as penalties to the attack die roll) are listed on Table 34.\n\n## Related Weapons Bonus\nWhen a character gains a weapon proficiency, he is learning to use a particular weapon effectively. However, many weapons have similar characteristics. A long sword, bastard sword, and broad sword, while all different, are all heavy, slashing swords. A character who is trained with one can apply some of his skill to the others. He is not fully proficient with the weapon, but he knows more about it than someone who picks it up without any skill in similar weapons.\n\nWhen a character uses a weapon that is similar to a weapon he is proficient with, his attack penalty is only one-half the normal amount (rounded up). A warrior, for example, would have a -1 penalty with a related weapon instead of -2. A wizard would have a -3 penalty instead of -5.\nSpecific decisions about which weapons are related are left to the DM. Some likely categories are:\n\n:hand axe, battle axe;\n:short bow, long bow, composite bow;\n:heavy and light crossbows;\n:dagger, knife;\n:glaive, halberd, bardiche, voulge, guisarme, glaive-guisarme, guisarme-voulge;\n:harpoon, spear, trident, javelin;\n:footman's mace, horseman's mace, morning star, flail, hammer, club;\n:military fork, ranseur, spetum, partisan;\n:scimitar, bastard sword, long sword, broad sword;\n:sling, staff sling",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["proficiencies", "proficiency", "weapon", "weapon proficiencies", "weapons"]
)

let embeddedRule0205: RuleEntry = RuleEntry(
    id: "phb_ch05_weapon_specialization",
    book: "PHB",
    chapterNumber: 5,
    chapterTitle: "Proficiencies",
    breadcrumbs: "Player's Handbook > Chapter 5: Proficiencies > Weapon Specialization",
    topic: "Weapon Specialization",
    ruleType: "optional_rule",
    summary: "Knowing how to use a weapon without embarrassing yourself is very different from being a master of that weapon. There are warriors, and then there are martial artists.",
    content: "Knowing how to use a weapon without embarrassing yourself is very different from being a master of that weapon. There are warriors, and then there are martial artists. An Olympic fencer is more than just an athlete; he can do things with his weapon that astound most fencers.\n\nIn the AD&D game, part of your character's skill is reflected in the bonuses he earns as he reaches higher levels. As your character advances, he becomes a wiser, more dangerous fighter. Experience has taught him to anticipate his opponents and to pounce on any advantage that presents itself. But this is a general, overall improvement, brought about by the warrior's sharpening senses and timing. It applies equally to all types of fighting.\n\nWeapon specialization is an optional rule that enables a Fighter (only) to choose a single weapon and specialize in its use. Any weapon may be chosen. Specialization is normally announced (and paid for with weapon proficiency slots) when the character is created. But even after a player character earns experience, he can still choose to specialize in a weapon, provided he has the weapon proficiency slots available.\n\nIn one way, a weapon specialist is like a wizard specialist. The specialization requires a single-minded dedication and training. Thus, multi-class characters cannot use weapon specialization; it is available only to single-class fighters.\n\n## Cost of Specialization\nWeapon specialization is obtained by devoting extra weapon proficiency slots to the chosen weapon. To specialize in any sort of melee weapon or crossbow, the character must devote two slots—one slot to become proficient with it, and then a second slot to specialize in it. Any bow (other than a crossbow) requires a total of three proficiency slots: one for proficiency and two to specialize. Assume, for the moment, that Rath the dwarf decided to specialize with the warhammer. Two of his four proficiency slots are thus devoted to the warhammer. With the two remaining, he can become proficient with the short sword and short bow (for example).\n\n## Effects of Specialization\nWhen a character specializes with a melee weapon, he gains a +1 bonus to all his attack rolls with that weapon and a +2 bonus to all damage rolls (in addition to bonuses for Strength and magic). The attack bonuses are not magical and do not enable the character to affect a creature that can be injured only by magical weapons.\n\n*Bow and crossbow* specialists gain an additional range category: point blank. Point-blank range for bows is from six feet to 30 feet. Point-blank range for crossbows is from six feet to 60 feet. At point-blank range, the character gains a +2 modifier on attack rolls. No additional damage is caused, but Strength (for bows) and magical bonuses apply. Furthermore, if the character has an arrow nocked and drawn, or a bolt loaded and cocked, and has his target in sight, he can fire at the beginning of the round before any initiative rolls are made.\n\nFighters who specialize also gain extra attacks earlier than those who don't specialize. Bonus attacks for specialists are listed on Table 35. The use of this table is explained in Chapter 9: Combat. Bow specialists do not gain any additional attacks per round.\n\n[TABLE_REF: Table 35: Specialist Attacks Per Round]",
    tables: [
        RuleTable(
                tableNumber: "Table 35",
                title: "Table 35: Specialist Attacks Per Round",
                headers: ["Fighter Level", "Melee Weapon", "Light X-bow", "Heavy X-bow", "Thrown Dagger", "Thrown Dart", "Other (Non-bow) Missiles"],
                rows: [
                    ["1-6", "3 attacks in 2 rounds", "1 attack in 1 round", "1 attack in 2 rounds", "3 attacks in 1 round", "4 attacks in 1 round", "3 attacks in 2 rounds"],
                    ["7-12", "2 attacks in 1 round", "3 attacks in 2 rounds", "1 attack in 1 round", "4 attacks in 1 round", "5 attacks in 1 round", "2 attacks in 1 round"],
                    ["13+", "5 attacks in 2 rounds", "2 attacks in 1 round", "3 attacks in 2 rounds", "5 attacks in 1 round", "6 attacks in 1 round", "5 attacks in 2 rounds"]
                ]
            )
    ],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["damage", "initiative", "proficiency", "specialization", "strength", "weapon", "weapon specialization", "weapons"]
)

let embeddedRule0206: RuleEntry = RuleEntry(
    id: "phb_ch06_animals",
    book: "PHB",
    chapterNumber: 6,
    chapterTitle: "Money and Equipment",
    breadcrumbs: "Player's Handbook > Chapter 6: Money and Equipment > Animals",
    topic: "Animals",
    ruleType: "core_rule",
    summary: "",
    content: "[TABLE_REF: Animals]",
    tables: [
        RuleTable(
                tableNumber: "",
                title: "Animals",
                headers: ["Animal", "Cost"],
                rows: [
                    ["Boar", "10 gp"],
                    ["Bull", "20 gp"],
                    ["Calf", "5 gp"],
                    ["Camel", "50 gp"],
                    ["Capon", "3 cp"],
                    ["Cat", "1 sp"],
                    ["Chicken", "2 cp"],
                    ["Cow", "10 gp"],
                    ["Dog", "—"],
                    ["Guard", "25 gp"],
                    ["Hunting", "17 gp"],
                    ["War", "20 gp"],
                    ["Donkey, mule, or ass", "8 gp"],
                    ["Elephant", "—"],
                    ["Labor", "200 gp"],
                    ["War", "500 gp"],
                    ["Falcon (trained)", "1,000 gp"],
                    ["Goat", "1 gp"],
                    ["Goose", "5 cp"],
                    ["Guinea hen", "2 cp"],
                    ["Horse", "—"],
                    ["Draft", "200 gp"],
                    ["Heavy war", "400 gp"],
                    ["Light war", "150 gp"],
                    ["Medium war", "225 gp"],
                    ["Riding", "75 gp"],
                    ["Hunting cat (jaguar, etc.)", "5,000 gp"],
                    ["Ox", "15 gp"],
                    ["Partridge", "5 cp"],
                    ["Peacock", "5 sp"],
                    ["Pig", "3 gp"],
                    ["Pigeon", "1 cp"],
                    ["Pigeon, homing", "100 gp"],
                    ["Pony", "30 gp"],
                    ["Ram", "4 gp"],
                    ["Sheep", "2 gp"],
                    ["Songbird", "10 sp"],
                    ["Swan", "5 sp"]
                ]
            )
    ],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["animals"]
)

let embeddedRule0207: RuleEntry = RuleEntry(
    id: "phb_ch06_armor",
    book: "PHB",
    chapterNumber: 6,
    chapterTitle: "Money and Equipment",
    breadcrumbs: "Player's Handbook > Chapter 6: Money and Equipment > Armor",
    topic: "Armor",
    ruleType: "core_rule",
    summary: "You are going to want your player character to buy armor, if he is allowed to use any. Armor is the easiest and cheapest way to improve your character's chance of surviving the more violent dangers of the adventuring life.",
    content: "## Armor\nYou are going to want your player character to buy armor, if he is allowed to use any. Armor is the easiest and cheapest way to improve your character's chance of surviving the more violent dangers of the adventuring life. Clearly, the better the armor the character possesses, the less likely he is to be hurt. **Armor protection is measured by Armor Class (AC), a number rating; the lower the Armor Class number, the better the protection.** Table 46 lists the values for all the types of armor found in the equipment lists.\n\n[TABLE_REF: Table 46: Armor Class Ratings]\n\nAlthough there is some controversy historically over the different types of armor, all known or suspected types are included here. However, not all armor may be available if your DM has chosen to set his campaign in a particular historical era or locale. For example, full plate armor is not available to characters adventuring in an ancient Greek setting.\n\n**Banded:** This armor is made of overlapping strips of metal sewn to a backing of leather and chain mail. Generally the strips cover only the more vulnerable areas, while the chain and leather protect the joints where freedom of movement must be ensured. Through straps and buckles, the weight is more or less evenly distributed.\n\n**Brigandine:** This armor is made from small metal plates sewn or riveted to a layer of canvas or leather and protected by an outer layer of cloth. It is rather stiff and does not provide adequate protection to the joints where the metal plates must be spaced widely or left off.\n\n**Bronze plate mail:** This is a plate mail armor—a combination of metal plates, chain mail or brigandine, leather and padding—made of softer bronze. It is easier and cheaper to make than steel armor, but it does not protect as well. A large breastplate and other metal plates cover areas of the body, but the other materials must protect the joints and movable parts of the body. It is not the full plate armor of the heavy knight of the Late Middle Ages and the Renaissance.\n\n**Chain mail:** This armor is made of interlocking metal rings. It is always worn with a layer of quilted fabric padding underneath to prevent painful chafing and to cushion the impact of blows. Several layers of mail are normally hung over vital areas. The links yield easily to blows, absorbing some of the shock. Most of the weight of this armor is carried on the shoulders and it is uncomfortable to wear for long periods of time.\n\n**Field plate armor:** This is the most common version of full plate armor, consisting of shaped and fitted metal plates riveted and interlocked to cover the entire body. It includes gauntlets, boots, and a visored helmet. A thick layer of padding must be worn underneath. However, the weight of the suit is well-distributed over the whole body. Such armor hampers movement only slightly. Aside from its expense, the main disadvantages are the lack of ventilation and the time required to put it on and take it off (see the \"Getting Into and Out of Armor\" section). Each suit of field plate must be individually fitted to its owner by a master armorer, although captured pieces can be resized to fit the new owner (unless such is patently absurd, such as a human trying to resize a halfling's armor).\n\n**Full Plate:** This is the impressive, high Gothic-style armor of the Late Middle Ages and Renaissance. It is perfectly forged and fitted. All the plates are interlocking and carefully angled to deflect blows. The surfaces are normally highly ornamented with etching and inlaid metals. Each suit must be carefully custom-fitted to the owner and there is only a 20% chance that a captured suit can be refitted to a new owner of approximately the same size. The metal plates are backed by padding and chain mail. The weight is well-distributed. The armor is hot, slow to don, and extremely expensive. Due to these factors, it tends to be used more for parades and triumphs than actual combat.\n\n**Hide:** This is armor prepared from the extremely thick hide of a creature (such as an elephant) or from multiple layers of regular leather. It is stiff and hard to move in.\n\n**Leather:** This armor is made of leather hardened in boiling oil and then shaped into breastplate and shoulder protectors. The remainder of the suit is fashioned from more flexible, somewhat softer materials.\n\n**Padded:** This is the simplest type of armor, fashioned from quilted layers of cloth and batting. It tends to get hot and after a time becomes foul with sweat, grime, lice, and fleas.\n\n**Plate mail:** This armor is a combination of chain or brigandine with metal plates (cuirass, epaulettes, elbow guards, gauntlets, tasets, and greaves) covering vital areas. The weight is distributed over the whole body and the whole thing is held together by buckles and straps. This is the most common form of heavy armor.\n\n**Ring mail:** This armor is an early (and less effective) form of chain mail in which metal rings are sewn directly to a leather backing instead of being interlaced. (Historians still debate whether this armor ever existed.)\n\n**Scale mail:** This is a coat and leggings (and perhaps a separate skirt) of leather covered with overlapping pieces of metal, much like the scales of a fish.\n\n**Shields:** All shields improve a character's Armor Class by 1 or more against a specified number of attacks. A shield is useful only to protect the front and flanks of the user. Attacks from the rear or rear flanks cannot be blocked by a shield (exception: a shield slung across the back does help defend against rear attacks). The reference to the size of the shield is relative to the size of the character. Thus, a human's small shield would have all the effects of a medium shield when used by a gnome.\n\nA *buckler* (or target) is a very small shield that fastens on the forearm. It can be worn by crossbowmen and archers with no hindrance. Its small size enables it to protect against only one attack per melee round (of the user's choice), improving the character's Armor Class by 1 against that attack.\n\nA *small shield* is carried on the forearm and gripped with the hand. Its light weight permits the user to carry other items in that hand (although he cannot use weapons). It can be used to protect against two frontal attacks of the user's choice.\n\nThe *medium shield* is carried in the same manner as the small shield. Its weight prevents the character from using his shield hand for other purposes. With a medium shield, a character can protect against any frontal or flank attacks.\n\nThe *body shield* is a massive shield reaching nearly from chin to toe. It must be firmly fastened to the forearm and the shield hand must grip it at all times. It provides a great deal of protection, improving the Armor Class of the character by 1 against melee attacks and by 2 against missile attacks, for attacks from the front or front flank sides. It is very heavy; the DM may wish to use the optional encumbrance system if he allows this shield.\n\n**Splint Mail:** The existence of this armor has been questioned. It is claimed that the armor is made of narrow vertical strips riveted to a backing of leather and cloth padding. Since this is not flexible, the joints are protected by chain mail.\n\n**Studded leather:** This armor is made from leather (not hardened as with normal leather armor) reinforced with close-set metal rivets. In some ways it is very similar to brigandine, although the spacing between each metal piece is greater.\n\nIn addition to the types of armor listed above, your DM may have special armors prepared from rare or exotic materials. Since it is highly unlikely that your character can afford these at the start, the DM will tell you when you need to know about such items.\n\n### Armor Sizes\nThe equipment list reflects the price of a suit of armor (including an appropriate helmet) made for any normal player character race. Although a halfling is much smaller than a human and needs a smaller suit, there are fewer armorers available to meet such specialized needs. Thus, the armor for a halfling is as expensive as that for a human. Armor for nonstandard sizes and shapes is going to cost significantly more and must be custom-made. This is not the kind of thing one can pick up at the local store!\n\nWhen armor is found during the course of an adventure, the players should note the creature who wore the armor previously. While a human-sized character might be able to wear the armor of a gnoll, it will do little good for a halfling. Likewise, the armor of a giant is of little use to anyone.\n\nArmor size also affects the weight of the armor, if the optional encumbrance system is used. The weights listed on the table are for human-sized (Medium) armors. Small armor weighs half the amount listed, while large armor weighs 50% more.\n\n### Getting Into and Out of Armor\nThere are times when it is important to know how quickly a character can get into or out of his armor. Accidents and unforeseen events happen all the time. The party is attacked at night. Those sleeping around the campfire may want to don their armor before rushing into battle. A character slips and falls into the river where his heavy armor pulls him down like a stone. He greatly desires to get it off before he drowns. Just how long does it take him?\n\nThe time required to don armor depends on its make. Those armors that are a single piece—leather tunics, robes, chain mail—take one round (two for metal items) to don with slight assistance. Without aid, the time is doubled. Armor that is made of separate pieces require 1d6 + 4 rounds, again with assistance. Without help, the time required is tripled. In all cases, the times given assume that the proper undergarments and padding are also worn.\n\nSometimes characters need to get into armor in a hurry and thus, they dress hastily. This assumes that some buckles aren't fastened, seatings adjusted, etc. Single suits can be hastily donned in one round at the cost of 1 worse AC (though never worse than 8). Thus, a fighter could hastily pull on his brigandine jack (AC 6) and charge into a fray with an AC of 7. Hastily donning piece armor (plate mail for example) improves the character's AC by 1 (from a base of 10) for every round spent dressing. A fighter could choose to spend three rounds fitting on parts of his plate mail, giving him an AC of 7, before going into battle.\n\nRemoving armor is a much quicker matter. Most can be shed in a single round. Piece armor (particularly full plate) requires 1d4 + 1 rounds. However, if the character is willing to cut straps and bend pins, such armors can be removed in half the time (roll 1d4 + 1, divide by 2, then round fractions up).\n\n### Creatures with Natural Armor Classes\nSome creatures possess a natural Armor Class already superior to some of the armor types (for example, the horse is AC 7). However, these creatures can still benefit from wearing armor of a quality worse than their natural Armor Class. If the AC of armor is equal to or worse than the AC of the creature, the AC of the creature improves by 1.\nFor example, a horse has a natural AC of 7. The AC of leather armor is 8, worse than the horse's natural AC. However, if a horse is fitted with leather barding, its AC drops to 6 since it gains the benefit of the additional protection.",
    tables: [
        RuleTable(
                tableNumber: "Table 46",
                title: "Table 46: Armor Class Ratings",
                headers: ["Type of Armor", "AC Rating"],
                rows: [
                    ["None", "10"],
                    ["Shield only", "9"],
                    ["Leather or padded armor", "8"],
                    ["Leather or padded armor + shield, studded leather, or ring mail armor", "7"],
                    ["Studded leather or ring mail + shield, brigandine, scale mail, or hide armor", "6"],
                    ["Scale mail or hide + shield, chain mail", "5"],
                    ["Chain mail + shield, splint mail, banded mail, bronze plate mail", "4"],
                    ["Splint mail, banded mail, or bronze plate mail + shield, plate mail", "3"],
                    ["Plate mail + shield, field plate", "2"],
                    ["Field plate armor + shield, full plate", "1"],
                    ["Full plate armor + shield", "0"]
                ]
            )
    ],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["armor", "armor class", "encumbrance", "movement", "weapons"]
)

let embeddedRule0208: RuleEntry = RuleEntry(
    id: "phb_ch06_armor_list",
    book: "PHB",
    chapterNumber: 6,
    chapterTitle: "Money and Equipment",
    breadcrumbs: "Player's Handbook > Chapter 6: Money and Equipment > Armor List",
    topic: "Armor List",
    ruleType: "table_reference",
    summary: ":* See table 46 for the Armor Class ratings of various armor types.",
    content: "[TABLE_REF: Armor]\n\n:* See table 46 for the Armor Class ratings of various armor types.",
    tables: [
        RuleTable(
                tableNumber: "",
                title: "Armor",
                headers: ["Item", "Cost", "Weight"],
                rows: [
                    ["Banded mail", "200 gp", "35 lbs."],
                    ["Brigandine", "120 gp", "35 lbs."],
                    ["Bronze plate mail", "400 gp", "45 lbs."],
                    ["Chain mail", "75 gp", "40 lbs."],
                    ["Field plate", "2000 gp", "60 lbs."],
                    ["Full plate", "4,000-10,000 gp", "70 lbs."],
                    ["Helmet", "—", "—"],
                    ["Great helm", "30 gp", "10 lbs."],
                    ["Basinet", "8 gp", "5 lbs."],
                    ["Hide", "15 gp", "30 lbs."],
                    ["Leather", "5 gp", "15 lbs."],
                    ["Padded", "4 gp", "10 lbs."],
                    ["Plate mail", "600 gp", "50 lbs."],
                    ["Ring mail", "100 gp", "30 lbs."],
                    ["Scale mail", "120 gp", "40 lbs."],
                    ["Shield", "—", "—"],
                    ["Body", "10 gp", "15 lbs."],
                    ["Buckler", "1 gp", "3 lbs."],
                    ["Medium", "7 gp", "10 lbs."],
                    ["Small", "3 gp", "5 lbs."],
                    ["Splint mail", "80 gp", "40 lbs."],
                    ["Studded leather", "20 gp", "25 lbs."]
                ]
            )
    ],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["armor", "armor class", "armor list", "list"]
)

let embeddedRule0209: RuleEntry = RuleEntry(
    id: "phb_ch06_clothing",
    book: "PHB",
    chapterNumber: 6,
    chapterTitle: "Money and Equipment",
    breadcrumbs: "Player's Handbook > Chapter 6: Money and Equipment > Clothing",
    topic: "Clothing",
    ruleType: "core_rule",
    summary: "",
    content: "[TABLE_REF: Clothing]",
    tables: [
        RuleTable(
                tableNumber: "",
                title: "Clothing",
                headers: ["Item", "Cost"],
                rows: [
                    ["Belt", "3 sp"],
                    ["Boots", "—"],
                    ["Riding", "3 gp"],
                    ["Soft", "1 gp"],
                    ["Breeches", "2 gp"],
                    ["Cap, hat", "1 sp"],
                    ["Cloak", "—"],
                    ["Good cloth", "8 sp"],
                    ["Fine fur", "50 gp"],
                    ["Girdle", "3 gp"],
                    ["Gloves", "1 gp"],
                    ["Gown, common", "12 sp"],
                    ["Hose", "2 gp"],
                    ["Knife sheath", "3 cp"],
                    ["Mittens", "3 sp"],
                    ["Pin", "6 gp"],
                    ["Plain brooch", "10 gp"],
                    ["Robe", "—"],
                    ["Common", "9 sp"],
                    ["Embroidered", "20 gp"],
                    ["Sandals", "5 cp"],
                    ["Sash", "2 sp"],
                    ["Shoes", "1 gp"],
                    ["Silk jacket", "80 gp"],
                    ["Surcoat", "6 sp"],
                    ["Sword scabbard, hanger, baldric", "4 gp"],
                    ["Tabard", "6 sp"],
                    ["Toga, coarse", "8 cp"],
                    ["Tunic", "8 sp"],
                    ["Vest", "6 sp"]
                ]
            )
    ],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["clothing"]
)
