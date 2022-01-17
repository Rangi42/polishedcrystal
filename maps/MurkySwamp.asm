MurkySwamp_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7, 35, STORMY_BEACH, 1
	warp_event  8, 35, STORMY_BEACH, 2
	warp_event 36,  5, UNION_CAVE_B1F_SOUTH, 3

	def_coord_events

	def_bg_events
	bg_event 20, 10, BGEVENT_ITEM + MULCH, EVENT_MURKY_SWAMP_HIDDEN_MULCH
	bg_event 22, 13, BGEVENT_ITEM + X_SPCL_DEF, EVENT_MURKY_SWAMP_HIDDEN_X_SPCL_DEF
	bg_event  5, 23, BGEVENT_ITEM + BIG_MUSHROOM, EVENT_MURKY_SWAMP_HIDDEN_BIG_MUSHROOM
	bg_event 40, 33, BGEVENT_ITEM + TINYMUSHROOM, EVENT_MURKY_SWAMP_HIDDEN_TINYMUSHROOM

	def_object_events
	object_event 40, 26, SPRITE_CHERYL, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MurkySwampCherylScript, EVENT_MURKY_SWAMP_CHERYL
	object_event 22, 20, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerBug_catcherOscar, -1
	object_event 17, 31, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBug_catcherCallum, -1
	object_event 25,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBug_catcherDavid, -1
	object_event 27, 33, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPokemaniacClive, -1
	object_event 37, 17, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHex_maniacMatilda, -1
	object_event  6, 22, SPRITE_FIREBREATHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerFirebreatherOleg, -1
	object_event  3,  8, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherDundee, -1
	object_event  4, 33, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, MurkySwampYoungsterText, -1
	itemball_event 14,  9, FULL_HEAL, 1, EVENT_MURKY_SWAMP_FULL_HEAL
	itemball_event 10, 11, BIG_MUSHROOM, 1, EVENT_MURKY_SWAMP_BIG_MUSHROOM
	itemball_event 43, 23, TOXIC_ORB, 1, EVENT_MURKY_SWAMP_TOXIC_ORB
	itemball_event 14, 34, MULCH, 1, EVENT_MURKY_SWAMP_MULCH
	cuttree_event  2, 14, EVENT_MURKY_SWAMP_CUT_TREE_1
	cuttree_event  6, 19, EVENT_MURKY_SWAMP_CUT_TREE_2

	object_const_def
	const MURKYSWAMP_CHERYL

MurkySwampCherylScript:
	faceplayer
	checkevent EVENT_BEAT_CHERYL
	iftrue .Beaten
	opentext
	writetext .ChallengeText
	yesorno
	iffalse_jumpopenedtext .NoText
	writetext .YesText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked MURKYSWAMP_CHERYL
	loadtrainer CHERYL, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CHERYL
.Beaten
	opentext
	writetext .ItemText
	promptbutton
	verbosegiveitem POWER_WEIGHT
	iffalse_endtext
	writetext .GoodbyeText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear MURKYSWAMP_CHERYL
	pause 15
	special Special_FadeInQuickly
	clearevent EVENT_BATTLE_TOWER_CHERYL
	end

.ChallengeText:
	ctxt "Hello, my name's"
	line "Cheryl."
	cont "And you are…?"

	para "OK, so your name"
	line "is <PLAYER>."

	para "I'm sincerely glad"
	line "to meet you."

	para "I'm afraid of the"
	line "ghosts in this"
	cont "swamp, so how"

	para "about a battle to"
	line "ward them off?"
	done

.YesText:
	ctxt "I should warn you,"
	line "my #mon can be"
	cont "quite rambunc-"
	cont "tious."
	done

.NoText:
	ctxt "Oh, but my #mon"
	line "were itching for"
	cont "a battle…"
	done

.BeatenText:
	ctxt "Striking the right"
	line "balance of offense"
	cont "and defense…"

	para "It's not easy"
	line "to do."
	done

.ItemText:
	ctxt "Thank you,"
	line "<PLAYER>!"

	para "Now I can confi-"
	line "dently get through"
	cont "this swamp."

	para "It reminds me of a"
	line "forest far away…"

	para "Oh, this is my"
	line "token of appreci-"
	cont "ation."

	para "Please accept it!"
	done

.GoodbyeText:
	ctxt "I'm heading to the"
	line "Battle Tower near"
	cont "Olivine City."

	para "Have you heard of"
	line "it?"

	para "Perhaps we'll meet"
	line "again there!"

	para "Bye for now!"
	done

GenericTrainerBug_catcherOscar:
	generictrainer BUG_CATCHER, OSCAR, EVENT_BEAT_BUG_CATCHER_OSCAR, .SeenText, .BeatenText

	ctxt "I came here to"
	line "find bugs!"

	para "Nobody warned me"
	line "about ghosts!"
	done

.SeenText:
	ctxt "G-g-g-ghost!"
	done

.BeatenText:
	ctxt "Get me outta here!"
	done

GenericTrainerBug_catcherCallum:
	generictrainer BUG_CATCHER, CALLUM, EVENT_BEAT_BUG_CATCHER_CALLUM, .SeenText, .BeatenText

	ctxt "This close to the"
	line "coast, I guess the"

	para "land becomes soak-"
	line "ed with water."
	done

.SeenText:
	ctxt "I'm from Azalea,"
	line "but I've never seen"

	para "this part of the"
	line "forest."
	done

.BeatenText:
	ctxt "This is no forest."
	line "It's a swamp!"
	done

GenericTrainerBug_catcherDavid:
	generictrainer BUG_CATCHER, DAVID, EVENT_BEAT_BUG_CATCHER_DAVID, .SeenText, .BeatenText

	ctxt "It must be the"
	line "trees blocking"
	cont "the sun."

	para "That's gotta be"
	line "why it's so cold,"
	cont "right?"
	done

.SeenText:
	ctxt "It feels so cold"
	line "in this swamp…"
	done

.BeatenText:
	ctxt "Brrr…"
	done

GenericTrainerPokemaniacClive:
	generictrainer POKEMANIAC, CLIVE, EVENT_BEAT_POKEMANIAC_CLIVE, .SeenText, .BeatenText

	ctxt "I know a fellow"
	line "#maniac when I"
	cont "see one."

	para "Leave some rare"
	line "#mon for me,"
	cont "OK?"
	done

.SeenText:
	ctxt "Don't tell me,"
	line "you're here to"
	cont "explore the swamp"
	cont "too?"
	done

.BeatenText:
	ctxt "I knew it!"
	done

GenericTrainerHex_maniacMatilda:
	generictrainer HEX_MANIAC, MATILDA, EVENT_BEAT_HEX_MANIAC_MATILDA, .SeenText, .BeatenText

	ctxt "So off into the"
	line "trees I stroll,"

	para "to lose my mind"
	line "and find my soul."
	done

.SeenText:
	ctxt "Within the dark-"
	line "ness, vast and"
	cont "deep, I offer you"
	cont "eternal sleep."
	done

.BeatenText:
	ctxt "Fufufufu…"
	done

GenericTrainerFirebreatherOleg:
	generictrainer FIREBREATHER, OLEG, EVENT_BEAT_FIREBREATHER_OLEG, .SeenText, .BeatenText

	ctxt "It's cold and dark"
	line "without a fire…"
	done

.SeenText:
	ctxt "I want to light a"
	line "fire… but would it"

	para "ignite the swamp"
	line "gas and blow up?"

	para "It's too risky!"
	done

.BeatenText:
	ctxt "I risked and lost!"
	done

GenericTrainerFisherDundee:
	generictrainer FISHER, DUNDEE, EVENT_BEAT_FISHER_DUNDEE, .SeenText, .BeatenText

	ctxt "I would go fish in"
	line "the ocean, but I'm"
	cont "lost in here…"
	done

.SeenText:
	ctxt "All the #mon I"
	line "fish up here are"
	cont "poisonous!"
	done

.BeatenText:
	ctxt "This is no place"
	line "for fishing…"
	done

MurkySwampYoungsterText:
	ctxt "Man! This place is"
	line "such a maze."

	para "I'm not sure I'll"
	line "ever find my way"
	cont "to the other side."
	done
