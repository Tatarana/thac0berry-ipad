import Foundation

/// Parte 1 das regras do Complete Priest's Handbook (CPrH) embutidas —
/// mesmo padrão de EmbeddedRules_Part1..Part20.swift (PHB/DMG), literais
/// Swift direto, sem Bundle/JSONDecoder em runtime. Gerado a partir dos
/// JSONs enviados pelo usuário (cap. 1-6 + apêndices, pipeline de extração
/// separado, auditado antes de virar Swift) — não editar à mão, regenerar
/// a partir da fonte se os dados mudarem.

let embeddedRule0274: RuleEntry = RuleEntry(
    id: "cprh_ch00_introduction",
    book: "CPrH",
    chapterNumber: 0,
    chapterTitle: "Introduction and Appendices",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 0: Introduction and Appendices > Introduction",
    topic: "Introduction",
    ruleType: "dm_guideline",
    summary: "The Complete Priest's Handbook",
    content: "The Complete Priest's Handbook\n\n## Introduction\n\nSince the creation of the ADVANCED DUNGEONS & DRAGONS® game system, the cleric has been one of the most popular character classes. He has been a happy bridge between warriors and mages: Capable of armoring up and wielding heavy weapons, capable of casting useful magics, he was a very versatile adventurer and the favorite choice of countless players.\n\nWith the release of the AD&D® 2nd Edition game, none of that has changed. The cleric is the same magic-hurling, mace-wielding hero that he always was. And in *The Complete Priest's* *Handbook* , we're going to see to it that he's even more than that.\n\nIn this supplement, we're going to elaborate on what the priest (including the cleric) *is* to the campaign, to the setting's civilization, and to the adventuring party.\n\nWe'll be providing guidelines for the DM to work up the cleric's faith: The god or philosophy he serves, the rules and mores he follows, the duties he practices, the restrictions he suffers, the powers he possesses, and the relations he and the others of his faith have with the followers of other faiths.\n\nWe'll show you how to work up priests devoted to specific mythoi. The druid, from the AD&D® 2nd Edition *Player's Handbook*, is one example; this supplement describes many, many more, and provides rules for the DM to create new priesthoods of his own design.\n\nWe'll talk about priestly orders. Some priesthoods have soldierly orders, scholarly orders, missionary orders, oracular orders, and many other types. If your priest character belongs to a faith with several orders, he may choose one of them, which will give him special abilities and duties beyond those of ordinary priests.\n\nWe'll talk about role-playing the priest character. Certainly, priest characters don't have to have the same sort of identical personality (the kindly father-confessor with the bloody mace in his hand) which many players imagine them all to have.\n\nWe'll describe whole campaigns devoted to priests: How to run them, how to give them a purpose, how to determine what goals and interests are most appropriate.\n\nAnd we'll talk about the sort of equipment that priests use in their devotions and adventures, including weapons, armor, holy symbols, priestly vestments, and other items.\n\n*The Complete Priest's Handbook* is equally useful if you're a Dungeon Master or a player. It will add depth to the campaign world and the range of NPCs for Dungeon Masters, and add detail to the abilities, backgrounds, and responsibilities of player-character priests.\n\n: * * *\n\nIn the text, for reasons of simplicity, we normally use masculine nouns and pronouns inclusively. When we say \"god,\" \"priest,\" or \"man,\" we're normally also implying \"goddess,\" \"priestess,\" and \"woman.\"\n\nIn order to be able to use this supplement, you must use the Weapon and Nonweapon Proficiencies rules from the AD&D® 2nd Edition game. If you're not yet familiar with them, you ought to read them before continuing in this rulebook.\n\nA special note for those of you who are using this *Complete Priest's Handbook* with your original AD&D® game instead of the new edition: This supplement mentions a lot of page numbers from the *Player's Handbook* and the *DMG*. The page numbers cited are for the newest edition, not the original; they won't be correct for those of you using the old books.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["faith", "introduction", "priesthood", "role-playing"]
)

let embeddedRule0275: RuleEntry = RuleEntry(
    id: "cprh_ch01_characteristics_of_the_gods",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > Characteristics of the Gods",
    topic: "Characteristics of the Gods",
    ruleType: "dm_guideline",
    summary: "The DM can create as many gods for his pantheon as his imagination will allow him. He doesn't have to work up an extensive set of legends about every god; even in the real world, many gods of various mythologies were scarcely more than a...",
    content: "The DM can create as many gods for his pantheon as his imagination will allow him. He doesn't have to work up an extensive set of legends about every god; even in the real world, many gods of various mythologies were scarcely more than a name and an attribute. As his campaign continues, the DM can flesh out the descriptions of these gods to his heart's content.\n\nSome of the traits which characterize the gods, and can be defined by the DM for each god or pantheon, include:\n\n**Immortality:** Are the gods immortal? In most pantheons, the gods are certainly *ageless*; that is, they do not grow old. But in some, they are not just ageless, they also cannot be killed; regardless of how severely they might be wounded, with time they will always fully recover from injury. In others, the gods can be killed by sufficient force. For example, in the Greek myths, the gods are undying, while in the Norse myths the gods face eventual certain death at the battle of Ragnarok.\n\n**Indestructibility:** As a further level of what was just described, some gods which are immortal are also described as indestructible. No force on heaven or Earth can hurt them (except by hurting their feelings, by betraying them). This is sometimes the trait of the greatest god of a pantheon, and is usually the trait of the only god of a monotheistic religion (one which believes in only one god).\n\n**Influence on the World:** How much influence does the god have on the mortal world, the world of animals, the world of plants? With some gods, there is very little of such influence. A god whose attribute is the unchanging stars, for instance, might exert a little influence on the sailors who navigate by stars, but could have very little effect on anyone or anything else. On the other hand, gods relating to powerful human emotions or preoccupations (such as love, war, creativity, and so forth) might exert a great deal of influence on the world, especially if it is said that every application of his attribute requires the god's help or permission. For instance, if it requires the aid or permission of the god/goddess of childbirth for every human birth to take place, then that deity is exerting a profound effect on the world.\n\n**Interest in the World:** Additionally, some gods are very interested in what goes on in the mortal world, while others are entirely disinterested. Naturally, those who are interested are more prone to meddle in mortal affairs than those who aren't. In fact, gods who are disinterested in the world might punish characters who are bold enough to call upon them.\n\n**Intentions Toward the World:** Finally, there's the question of what the god's intentions are toward the world... especially toward the sentient races of the world. Some gods are content just to pursue their attributes and make sure they are properly worshipped and recognized. Others may have more far-reaching plans. This is especially true of evil gods, who wish to bring about the destruction of races, other gods, or the entire world; it is also true of ambitious gods, who wish to cast down the ruling gods, take their place, and reshape the world to their own liking.\n\n**Inhibitions:** Some gods and pantheons had limitations placed upon them. These might have been limitations placed by some greater power of the universe, or merely enforced by the greatest of the gods. Often, these inhibitions dictate how much aid or hindrance the gods can offer to mortals, whether or not they can help their favorite men and beasts directly or indirectly, etc.\n\n## Example\n\nAs an example of how a familiar god matches these characteristics, let's look at the Greek goddess Aphrodite.\n\nShe was immortal, as were most or all of the Greek gods. She certainly was *not* indestructible, and was in fact once wounded in battle by the Argive hero Diomedes.\n\nShe had a very profound influence on the world, for it was she who put all varieties of the emotion of love in the breasts of man and beast. Even the other gods, with the exception of Hestia, Athena, and Artemis, were regularly affected by her power.\n\nHer interest in the world was limited to a couple of areas: Making sure that all humankind respected her (which generally meant that all humans knew love at one time or another, and thus did not deny her); and making sure her special favorites, such as her mortal son Aeneas, survived and prospered. Other than that, she appeared to have no special intentions toward the world.\n\nAphrodite had a couple of inhibitions restricting her: First, she and all the Olympians were subject to a higher destiny, which not even Zeus could thwart. Second, physically, she and most other gods could be hurt or even defeated in battle by the mightiest Greek heroes. Third, the god-king Zeus obviously preferred for gods to help their favorites indirectly rather than by showing up in person. All these inhibitions affected the way Aphrodite and the other Olympians related to their favorite \"player-characters.\"",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["characteristics", "characteristics of the gods", "gods"]
)

let embeddedRule0276: RuleEntry = RuleEntry(
    id: "cprh_ch01_creation",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > Creation",
    topic: "Creation",
    ruleType: "core_rule",
    summary: "The first place to start is the **creation** of the universe and the world.",
    content: "The first place to start is the **creation** of the universe and the world.\n\nIn most creation stories, there was usually some disinteresting, stable condition in effect at the dawn of time. It might have been a formless void, or darkness, or unending ice and snow.\n\nThen, we have the first great being, the one who brings about creation of the world. Note that this great being doesn't have to be the god who is now dominant in the campaign world. The myths are packed with tales of gods who created their worlds, became oppressive, and were then cast down by other gods, even their own children, who now rule in their place.\n\nNor does the creation have to have been a deliberate event. It might have been an accident; the god could have been dreaming and his dreams became reality.\n\nThe creator could be a tremendous monster, one which began the process of creating the world, but was overthrown before it finished making the world to its own satisfaction...  and one which, legends say, will return some day to finish the job.\n\nIt could be a simple creature, one not necessarily deserving of worship, which shapes the world simply by acting as the animal it is. As one example, if the original state of the universe were a giant block of salt, this creature could be a giant cow which licks it into the shape of the world.\n\nIn some mythologies, the great being that shapes the world stays around after that task is done; he or she might be the principal deity of the world. More often, that great being perishes, or is cast down by descendants, or settles for a lesser role once creation is accomplished.\n\n## Basic Astronomy\n\nWhat is the shape of the world and the universe once they are created? What are suns, moons, planets and stars?\n\nThe entire universe could be a single huge world, with a dome overhead which holds the stars and confines the sun(s) and moon(s). The world could be a disk, a sphere, a bowl, or an unending surface continuing in all directions to infinity.\n\nThe sun and moon could be glowing chariots, or bright gods continually flying across the sky (perhaps as a service to the world, perhaps because they're being chased). They could be worlds unto themselves, and the player-characters might someday have the opportunity to visit and walk the bright surface of the sun in search of adventure. They could be the great, glowing eyes of the most powerful deity. They could be gigantic, fiercely-burning lamps created by the craftsman-god, lamps which circle the world on some giant mechanism. (Perhaps, instead of circling the world, they just shut off each day when the time is due; the sun just turns off, and the moons just turn on.) They could even be suns and moons as we understand them, though some of the charm of fantasy lies precisely in making such things *different* from our cold, modern explanations of them.\n\nThe planets and stars could be holes in the dome of the sky, suggesting that there is a great brightness beyond. They could be decorations placed in the sky by the gods. They could be worlds unto themselves. They could be glowing creatures forced to trace paths through the sky every night. They could be the suns of distant worlds.\n\nAnd, of course, the DM can choose for all these astronomic bodies to be one thing, but for the prevailing belief of the people to be different, an incorrect belief; nothing says that the world's deities want the humans and demihumans to know the truth.\n\n## Effects of Terrain on Creation\n\nIn the real world, the terrain of the human culture to which a mythology belonged often had a strong effect on the myths. Norse mythology started with a huge abyss filled with ice, for instance.\n\nIf one race's religion is dominant in the campaign world, the DM should decide whether or not their creation-story has a setting like the land where that race originated. \n\nIn a fantasy world, this situation could come about from one of two reasons:\n\nThe gods, having emerged from a particular type of terrain, would find similar terrain in the mortal world to be their favorite land for creating new races, exploring, and interacting with humans; or\n\nThe sentient races might have erroneously re-interpreted the story of the world's creation as a reflection of the terrain in which they live, and the legend is simply wrong.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["creation", "sphere"]
)

let embeddedRule0277: RuleEntry = RuleEntry(
    id: "cprh_ch01_events",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > Events",
    topic: "Events",
    ruleType: "dm_guideline",
    summary: "Once all the principal characters (i.e., gods) are in place, the DM can create the *events* of the faith.",
    content: "Once all the principal characters (i.e., gods) are in place, the DM can create the *events* of the faith.\n\nThe creation of the world was one such event; it described \"characters\" (gods) acting or interacting, and something happening. The fall from grace of the sentient races was another: How did that happen? But these shouldn't be the only events known to the believers. What else has happened?\n\nDo the gods mate with mortals to produce heroic characters who go on adventures? If so, then the conception of these heroes and their adventures in life are all events of the faith. (Note: If this process is still going on, some of the campaign's player-characters could be the mortal children of the world's gods.)\n\nHow do specific gods get along together? Having determined that, the DM can next determine why. If two gods hate each other, why? Did one steal from the other, or embarrass him? That's an event.\n\nHave the gods ever warred on one another? If so, that was certainly an event.\n\nThe DM can create as few or as many events as he wishes; the more there are, the richer his campaign setting will be for it.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["events", "faith"]
)

let embeddedRule0278: RuleEntry = RuleEntry(
    id: "cprh_ch01_fall_from_grace",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > Fall From Grace",
    topic: "Fall From Grace",
    ruleType: "core_rule",
    summary: "In some stories, humans or sentient races in general start out with an exalted relationship with their deities and then fall out of the deities' favor.",
    content: "In some stories, humans or sentient races in general start out with an exalted relationship with their deities and then fall out of the deities' favor. In Greek myth, for example, the humans were well-beloved of the gods until the god Prometheus gave them the secret of using fire, which they had lacked until then; this so offended Zeus that he afflicted mankind with all sorts of ills.\n\nThis sort of thing could be a characteristic of your campaign world's story; or, mankind might never have had a closer relationship with its gods.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["fall", "fall from grace", "from", "grace"]
)

let embeddedRule0279: RuleEntry = RuleEntry(
    id: "cprh_ch01_forces_and_philosophies",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > Forces and Philosophies",
    topic: "Forces and Philosophies",
    ruleType: "core_rule",
    summary: "The mystical history of the world is somewhat different if it is driven by a *force* or a *philosophy*.",
    content: "The mystical history of the world is somewhat different if it is driven by a *force* or a *philosophy*.\n\nAs we'll discuss in more detail next chapter, a *force* is a mystical power which strongly affects the world... but which probably is not a sentient being like gods are. It has drives, it has a goal, but it probably does not have a mind.\n\nOn the other hand, a *philosophy* is a compelling idea or set of ideas which can capture the imagination and influence the actions of communities or whole civilizations. It might exert enough popular appeal that it can support magical powers for priest-philosophers. But it is still not precisely a god, for it has no independent mind.\n\nIf your campaign world is driven by a force or philosophy, its mystical history is going to be somewhat different. It will mostly be a history of men or other sentient races and their relationships with the force or philosophy: How they came to recognize it or create it, how they came to believe in it, how they introduced it to others, and so forth.\n\nIn short, the DM won't have to create an entire separate history as he would have to do for distinct pantheons of gods. He will, however, have to decide for himself what effects these forces or philosophies have had on the human and humanoid histories of his world, and take these factors into account for every part of those histories.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["forces", "forces and philosophies", "philosophies"]
)

let embeddedRule0280: RuleEntry = RuleEntry(
    id: "cprh_ch01_humans_humanoids_animals_plants",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > Humans, Humanoids, Animals, Plants",
    topic: "Humans, Humanoids, Animals, Plants",
    ruleType: "core_rule",
    summary: "At some point in the history of the gods, they probably created all living things. (It's possible for the flora and fauna of the world to have been created by some other factor.",
    content: "At some point in the history of the gods, they probably created all living things. (It's possible for the flora and fauna of the world to have been created by some other factor. For example, they might have just *been* there when the great ice-cap melted. But it's a more common element of the story that the gods created them.)\n\nThis creation process might have involved an accident; for instance, the greatest god sneezed, and blew fully-formed living things all over the world.\n\nMore commonly, it's a deliberate process, and the gods or one particular god methodically created all the living things known to man.\n\nWhen working up this aspect of the story for his own campaign world, the DM can use this to help define the way the gods look upon specific forms of life. Was Man created so the gods would have something entertaining to watch? To fulfil a higher destiny? So that his brightest and best might one day add to the ranks of the lesser gods, or accompany the gods on one last, great battle? This kind of decision helps define man's view of the gods and their requirements of mankind.\n\nIt can also be used to define mankind's opinions on certain matters. If, for instance, animals in general were created to serve Man, then Man might have little regard for them, except as pets and beasts of burden. However, if each god created one or more animals to serve as totems for the god, then Man might have a lot more respect for certain animals.\n\nIf the story of creation says that one sex of the sentient races was created subordinate to the others, then there will be a crushing social pressure to keep that sex \"in its place.\" If the story of creation does no such thing, then any such attitudes will be have been created by mortals and may vary from place to place. Additionally, with the added complication of *several* sentient races around (humans, elves, dwarves, etc.), the DM can make this decision several times and choose a different approach each time. Perhaps, on his world, dwarves are strongly male-dominated, elves are female-dominated, and humans are more or less equal? Any such arrangement is possible.\n\nNote, however, that when one sex is oppressed, players are less likely to want to play members of that sex. Few players want their escapism to involve this sort of prejudice directed at them.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["animals,", "humanoids,", "humans,", "humans, humanoids, animals, plants", "plants"]
)

let embeddedRule0281: RuleEntry = RuleEntry(
    id: "cprh_ch01_mythic_history_creation_sheet",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > Mythic History Creation Sheet",
    topic: "Mythic History Creation Sheet",
    ruleType: "dm_guideline",
    summary: "The DM can photocopy and fill in the following sheet to give him a starting-place for the creation of his world's mythic history. The sheet follows the order of subjects from this chapter.",
    content: "The DM can photocopy and fill in the following sheet to give him a starting-place for the creation of his world's mythic history. The sheet follows the order of subjects from this chapter.\n\n: * * *\n\nIn this chapter, we discussed creation of the *history* of the campaign's gods. In the next chapter, we'll talk about individual faiths, how they're put together, and what effect they have on priest-characters.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["creation", "faith", "history", "mythic", "mythic history creation sheet", "sheet"]
)

let embeddedRule0282: RuleEntry = RuleEntry(
    id: "cprh_ch01_priests_gods_and_the_world",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > Priests, Gods, and the World",
    topic: "Priests, Gods, and the World",
    ruleType: "core_rule",
    summary: "This chapter is for DMs who want to design the mythic history of their campaign world(s). It's not prohibited for the campaign's players to read this... but not all of them will find it useful.",
    content: "This chapter is for DMs who want to design the mythic history of their campaign world(s). It's not prohibited for the campaign's players to read this... but not all of them will find it useful. Players may wish to skip on to the third chapter, \"Sample Priesthoods.\"\n\nOne of the first things the DM can do to add color and detail to his campaign world is to work up that world's *mythic history*. Such a history will help establish, in his mind and those of his players, the relationships between the gods, and between gods and men. It will help set the tone of the campaign and the attitude of the player-characters' culture. It will give the players some idea of what their characters expect from their gods and their future. And once it's done, the DM can then elaborate on it and decide how each individual god relates to other gods and to the sentient races of the world.\n\nIn this chapter, we'll discuss some of the common themes that run through myths; the DM can use these topics as a framework for his own mythic history.",
    tables: [],
    relatedRuleIds: ["cprh_ch03_sample_priesthoods"],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["gods,", "priesthood", "priests,", "priests, gods, and the world", "world"]
)

let embeddedRule0283: RuleEntry = RuleEntry(
    id: "cprh_ch01_propagation",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > Propagation",
    topic: "Propagation",
    ruleType: "dm_guideline",
    summary: "Once creation of the world and universe are established, the DM can move on to the **propagation** of the gods. In other words, once the setting is in place, the cast of gods gets larger and larger.",
    content: "Once creation of the world and universe are established, the DM can move on to the **propagation** of the gods. In other words, once the setting is in place, the cast of gods gets larger and larger.\n\nNaturally, the DM can always do this the other way around. Perhaps all the gods were in place before they decided to create the world. There's nothing wrong with this choice; it's simply backward from the way the best-known Earth mythologies operated.\n\nRegardless, unless the DM is creating a monotheistic faith (one dedicated to only one deity), he must now begin creating the other gods of the faith.\n\nThese gods could be children of the first great being. They could be that being's creations instead. They could be representations of natural forces brought to awareness and life by the catalyst of Creation. They could emerge from some less wholesome process (for example, they could be created by the decay of the body of the first great being, or could merely spring forth whole from its corpse: One god from the bones, one from the brain, one from the heart, etc.).\n\nEach god should have some special *attribute* , an area where he or she is dominant. Some can have several attributes. Such attributes include Thought, Strength, War, Love, Craftsmanship, Earth, Sea, Sky, Sailing, Farming, Hunting, and many, many others. Any activity that is important to humans (or demihumans) can be an attribute for a god.\n\nNot all these gods need to have been \"first-generation,\" or born to/created by that first great being. Obviously, some should be. But they, too, can create or become parents to other gods.\n\nIn some mythoi, the god of a particularly important attribute will have children who bear lesser forms of that attribute. For instance, the god of Love might have children who represent Passion, Marriage, Infatuation, and Unrequited Love. The god of Sleep might have children who represent Dreams and Nightmares. The god of Intellect might have children who represent Memory, Poetry, Song, and Riddles or Puzzles.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["faith", "propagation"]
)

let embeddedRule0284: RuleEntry = RuleEntry(
    id: "cprh_ch01_the_challenge",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > The Challenge",
    topic: "The Challenge",
    ruleType: "core_rule",
    summary: "In many faiths, the gods, deliberately or not, visit a challenge on the humans.",
    content: "In many faiths, the gods, deliberately or not, visit a challenge on the humans.\n\nOne of the commonest challenges involves the afterlife. In many faiths, the better one lives one's life, the better the afterlife to which he progresses. The usual sorts of afterlives tend to fall into one of the following categories; in some faiths, a character might face the possibility of reaching more than one of these choices, depending on his actions in life.\n\n**Oblivion:** No afterlife at all, this is when the human's spirit perishes and becomes nothingness.\n\n**Torture:** An afterlife where torture, either permanent or temporary (until the spirit repents, recants, or otherwise improves) is the order of the day.\n\n**Boredom:** An afterlife where there's nothing to do, nothing to see, nothing to entertain.\n\n**Rebirth:** An afterlife which involves rebirth in the physical world and the living of a new mortal life.\n\n**Pleasure**: An afterlife where the things man most loves in life are visited upon him in abundance.\n\n**Ascension:** An afterlife where the best of the best are granted great powers, making them heralds and messengers of the  gods...   or even gods themselves.\n\nIn such faiths, humans usually have a good idea of what it takes to get into these specific afterlives. To get into the \"good\" ones may require strict adherence to a certain life-style, or may require that the human somehow impress the gods with his deeds or personality, or may merely require that the gods like the character...which is not something the character can necessarily bring about deliberately.\n\nOther challenges are possible: Humankind as a whole might be challenged to achieve a certain level of civilization by a certain time, to achieve a certain level of artistic or philosophic ability, to defeat a certain spirit of evil, to evolve to a certain enlightened state, etc.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["challenge", "faith", "the challenge"]
)

let embeddedRule0285: RuleEntry = RuleEntry(
    id: "cprh_ch01_the_future",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > The Future",
    topic: "The Future",
    ruleType: "core_rule",
    summary: "Some, but not all, faiths make predictions for the future. Sometimes they're grim, such as the Norse belief in Ragnarok, the destruction of the gods and man. They could also be happy and cheerful...",
    content: "Some, but not all, faiths make predictions for the future. Sometimes they're grim, such as the Norse belief in Ragnarok, the destruction of the gods and man. They could also be happy and cheerful... though this isn't usually the case in a world involving great heroes.\n\nThe DM, when deciding whether or not to \"predict the future\" for his world, should try to figure out what this choice will do to the attitudes of his intelligent races.\n\nA future which is bleak and gloomy will sometimes make the campaign bleak and gloomy. The characters can hope for success and glory in the short-term, but certain death awaits them, and they can't count on the world being there \"when they get back.\" This sort of approach does make for the greatest of heroism, though. It's the greatest hero who strives on knowing that ultimately he must fail, yet fights for his goals anyway.\n\nA future which is happy and bright will sometimes make the campaign a little more goofy and irresponsible. Characters, believing that whatever their mistake, they'll be preserved or rewarded, may behave in a foolish manner. Acts of bravery are often nothing of the sort; they're just short-term sacrifices in anticipation of a long-term reward. This is not to say that such a campaign can't be rewarding... it's just harder for it to be serious.\n\nA future which is neither doomed nor excessively happy will tend to have less of an effect on the player-characters. For instance, if holy writings say that a thousand years in the future, the gods will \"start over\" and reshape the world, populating it with the survivors from the last world and the best spirits in the halls of the afterlife, that's all very interesting... but its effects on the current campaign are minimal. On the other hand, if this reshaping is supposed to take place in only ten years, or one, it becomes *very* interesting to the PCs. They'll work very hard to make sure that they're either among the survivors from this world, or among the brighter spirits of the afterlife, so they can experience the new world.\n\nOf course, the DM doesn't *have* to specify future events for his campaign. It's often better if he doesn't, because it makes for more uncertainty in the minds of the PCs.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["faith", "future", "the future"]
)

let embeddedRule0286: RuleEntry = RuleEntry(
    id: "cprh_ch01_the_pantheon",
    book: "CPrH",
    chapterNumber: 1,
    chapterTitle: "Priests, Gods, and the World",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 1: Priests, Gods, and the World > The Pantheon",
    topic: "The Pantheon",
    ruleType: "dm_guideline",
    summary: "Once the DM has created the individual gods, he ought to relate them to one another # that is, establish how they feel about one another.",
    content: "Once the DM has created the individual gods, he ought to relate them to one another # that is, establish how they feel about one another. This can affect how their mortal followers, especially priesthoods, feel about one another and work together.\n\nThese relationships don't have to be very detailed. It's quite sufficient to say that one god loves another, hates another, likes another, dislikes, respects, holds in contempt, whatever. Then, simply apply that sentiment to the priesthoods of the gods.\n\nAnd when that sentiment is applied to mortals, it can turn out to be greater or less than the emotion actually felt by the gods in question.\n\nFor instance, let us say that two gods dislike one another. Their respective priests may dislike one another with similar intensity. On the other hand, they *might not dislike one another at all*. They might, in fact, recognize that their gods have certain foibles (human-like failings of personality), and might look upon those foibles with amusement and affection but without following them themselves.\n\nHowever, these priesthoods instead *might loathe one another*. They could hate one another with an intensity which far surpasses that of the gods in question. They could, in fact, start wars on the earth because of their hatred for one another.\n\nSo, for many gods, the DM may wish to decide how the gods feel about one another, and then may choose a slightly different view of how their priests react to one another.",
    tables: [],
    relatedRuleIds: [],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["pantheon", "priesthood", "the pantheon"]
)

let embeddedRule0287: RuleEntry = RuleEntry(
    id: "cprh_ch02_designing_faiths",
    book: "CPrH",
    chapterNumber: 2,
    chapterTitle: "Designing Faiths",
    breadcrumbs: "The Complete Priest's Handbook > Chapter 2: Designing Faiths > Designing Faiths",
    topic: "Designing Faiths",
    ruleType: "core_rule",
    summary: "This chapter is for DMs who want to design detailed faiths and cults for their campaign worlds. It's not prohibited for the campaign's players to read this... but not all of them will find it useful.",
    content: "This chapter is for DMs who want to design detailed faiths and cults for their campaign worlds. It's not prohibited for the campaign's players to read this... but not all of them will find it useful. Players may wish to skip on to the next chapter, \"Sample Priesthoods.\" \n\nAs the *Player's Handbook* points out (page 34, first column), \"In the simplest version of the AD&D®game, clerics serve religions that can be generally described as 'good' or 'evil.' Nothing more needs to be said about it; the game will play perfectly well at this point.\" \n\nThat's true enough. But DMs who work to make their campaign settings into interesting, detailed backgrounds for the campaign, won't be satisfied with that simple approach. A big part of the color of any fiction setting, including campaign settings, is the relationship of the supernatural world to the \"real\" world... and gods, with priests as ambassadors to the human world, form a big part of that supernatural element.\n\nSo, eventually, most DMs will want to work up at least the basic details of who the gods are in his campaign world, how they relate to one another, and what their goals are (especially those pertaining to the mortal world). This, in turn, will let them enhance the role of cleric, druid and other priest player-characters in the campaign... and that's what this chapter is all about.\n\nIn this chapter, you'll learn how to create specific faiths (related to specific gods, natural forces, and philosophies); how to create the priests of these specific mythoi; and how to relate the gods together into a full-sized pantheon for your game world. In the next chapter, you'll find many examples of this priesthood creation process.",
    tables: [],
    relatedRuleIds: ["cprh_ch03_sample_priesthoods"],
    relatedSpells: [],
    relatedMagicItems: [],
    searchKeywords: ["designing", "designing faiths", "faith", "faiths", "priesthood"]
)
