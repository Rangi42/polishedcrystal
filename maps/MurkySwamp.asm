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
	bg_event 22, 13, BGEVENT_ITEM + X_SP_DEF, EVENT_MURKY_SWAMP_HIDDEN_X_SP_DEF
	bg_event  5, 23, BGEVENT_ITEM + BIG_MUSHROOM, EVENT_MURKY_SWAMP_HIDDEN_BIG_MUSHROOM
	bg_event 40, 33, BGEVENT_ITEM + TINYMUSHROOM, EVENT_MURKY_SWAMP_HIDDEN_TINYMUSHROOM

	def_object_events
	object_event 40, 26, SPRITE_CHERYL, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MurkySwampCherylScript, EVENT_MURKY_SWAMP_CHERYL
	object_event 17, 31, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MurkySwampNurseBeatriceScript, -1
	object_event 22, 20, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerBug_catcherOscar, -1
	object_event 37, 17, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHex_maniacMatilda, -1
	object_event  6, 22, SPRITE_FIREBREATHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerFirebreatherOleg, -1
	object_event  4, 33, SPRITE_POKEMANIAC, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MurkySwampPokemaniacText, -1
	itemball_event 14,  9, FULL_HEAL, 1, EVENT_MURKY_SWAMP_FULL_HEAL
	itemball_event 10, 11, BIG_MUSHROOM, 1, EVENT_MURKY_SWAMP_BIG_MUSHROOM
	itemball_event 43, 23, TOXIC_ORB, 1, EVENT_MURKY_SWAMP_TOXIC_ORB
	itemball_event 14, 34, MULCH, 1, EVENT_MURKY_SWAMP_MULCH
	cuttree_event  2, 14, EVENT_MURKY_SWAMP_CUT_TREE_1
	cuttree_event  6, 19, EVENT_MURKY_SWAMP_CUT_TREE_2

	object_const_def
	const MURKYSWAMP_CHERYL
	const MURKYSWAMP_NURSE

MurkySwampCherylScript:
	faceplayer
	checkevent EVENT_BEAT_CHERYL
	iftruefwd .Beaten
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
	text "Hello, my name's"
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
	text "I should warn you,"
	line "my #mon can be"
	cont "quite rambunc-"
	cont "tious."
	done

.NoText:
	text "Oh, but my #mon"
	line "were itching for"
	cont "a battle…"
	done

.BeatenText:
	text "Striking the right"
	line "balance of offense"
	cont "and defense…"

	para "It's not easy"
	line "to do."
	done

.ItemText:
	text "Thank you,"
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
	text "I'm heading to the"
	line "Battle Tower near"
	cont "Olivine City."

	para "Have you heard of"
	line "it?"

	para "Perhaps we'll meet"
	line "again there!"

	para "Bye for now!"
	done

MurkySwampNurseBeatriceScript:
	faceplayer
	checkevent EVENT_BEAT_NURSE_BEATRICE
	iftruefwd .Beaten
	showtext .SeenText
	winlosstext .BeatenText, 0
	setlasttalked MURKYSWAMP_NURSE
	loadtrainer NURSE, BEATRICE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_NURSE_BEATRICE
.Beaten
	showtext .AfterText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special Special_FadeInQuickly
	special RestartMapMusic
	jumpthistext

	text "All better now!"
	done

.SeenText:
	text "I'm a Nurse!"

	line "Defeat me and I'll"
	cont "heal your #mon!"
	done

.BeatenText:
	text "But first I need"
	line "to heal my own"
	cont "#mon…"
	done

.AfterText:
	text "Making #mon"
	line "feel better--"

	para "that's why I"
	line "came here!"
	done

GenericTrainerBug_catcherOscar:
	generictrainer BUG_CATCHER, OSCAR, EVENT_BEAT_BUG_CATCHER_OSCAR, .SeenText, .BeatenText

	text "I came here to"
	line "find bugs!"

	para "Nobody warned me"
	line "about ghosts!"
	done

.SeenText:
	text "G-g-g-ghost!"
	done

.BeatenText:
	text "Get me outta here!"
	done

GenericTrainerHex_maniacMatilda:
	generictrainer HEX_MANIAC, MATILDA, EVENT_BEAT_HEX_MANIAC_MATILDA, .SeenText, .BeatenText

	text "So off into the"
	line "trees I stroll,"

	para "to lose my mind"
	line "and find my soul."
	done

.SeenText:
	text "Within the dark-"
	line "ness, vast and"
	cont "deep, I offer you"
	cont "eternal sleep."
	done

.BeatenText:
	text "Fufufufu…"
	done

GenericTrainerFirebreatherOleg:
	generictrainer FIREBREATHER, OLEG, EVENT_BEAT_FIREBREATHER_OLEG, .SeenText, .BeatenText

	text "It's cold and dark"
	line "without a fire…"
	done

.SeenText:
	text "I want to light a"
	line "fire… but would it"

	para "ignite the swamp"
	line "gas and blow up?"

	para "It's too risky!"
	done

.BeatenText:
	text "I risked and lost!"
	done

MurkySwampPokemaniacText:
	text "This close to the"
	line "coast, the land"

	para "becomes soaked"
	line "with water."

	para "But the rare #-"
	line "mon here make it"

	para "worth exploring"
	line "anyway!"
	done
