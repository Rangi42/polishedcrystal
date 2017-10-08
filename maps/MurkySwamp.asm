MurkySwamp_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MurkySwamp_MapEventHeader:

.Warps: db 3
	warp_def 35, 7, 1, STORMY_BEACH
	warp_def 35, 8, 2, STORMY_BEACH
	warp_def 5, 36, 3, UNION_CAVE_B1F_SOUTH

.XYTriggers: db 0

.Signposts: db 4
	signpost 10, 20, SIGNPOST_ITEM + MULCH, EVENT_MURKY_SWAMP_HIDDEN_MULCH
	signpost 13, 22, SIGNPOST_ITEM + X_SPCL_DEF, EVENT_MURKY_SWAMP_HIDDEN_X_SPCL_DEF
	signpost 23, 5, SIGNPOST_ITEM + BIG_MUSHROOM, EVENT_MURKY_SWAMP_HIDDEN_BIG_MUSHROOM
	signpost 33, 40, SIGNPOST_ITEM + TINYMUSHROOM, EVENT_MURKY_SWAMP_HIDDEN_TINYMUSHROOM

.PersonEvents: db 15
	person_event SPRITE_CHERYL, 26, 40, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MurkySwampCherylScript, EVENT_MURKY_SWAMP_CHERYL
	person_event SPRITE_BUG_CATCHER, 20, 22, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 5, TrainerBug_catcherOscar, -1
	person_event SPRITE_BUG_CATCHER, 31, 17, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerBug_catcherCallum, -1
	person_event SPRITE_BUG_CATCHER, 7, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerBug_catcherDavid, -1
	person_event SPRITE_SUPER_NERD, 33, 27, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPokemaniacClive, -1
	person_event SPRITE_HEX_MANIAC, 17, 37, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerHex_maniacMatilda, -1
	person_event SPRITE_FISHER, 22, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerFirebreatherOleg, -1
	person_event SPRITE_FISHER, 8, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherDundee, -1
	person_event SPRITE_YOUNGSTER, 33, 4, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, MurkySwampYoungsterText, -1
	itemball_event 9, 14, FULL_HEAL, 1, EVENT_MURKY_SWAMP_FULL_HEAL
	itemball_event 11, 10, BIG_MUSHROOM, 1, EVENT_MURKY_SWAMP_BIG_MUSHROOM
	itemball_event 23, 43, TOXIC_ORB, 1, EVENT_MURKY_SWAMP_TOXIC_ORB
	itemball_event 34, 14, MULCH, 1, EVENT_MURKY_SWAMP_MULCH
	cuttree_event 14, 2, EVENT_MURKY_SWAMP_CUT_TREE_1
	cuttree_event 19, 6, EVENT_MURKY_SWAMP_CUT_TREE_2

const_value set 1
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
	buttonsound
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

TrainerBug_catcherOscar:
	trainer EVENT_BEAT_BUG_CATCHER_OSCAR, BUG_CATCHER, OSCAR, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "G-g-g-ghost!"
	done

.BeatenText:
	text "Get me outta here!"
	done

.AfterText:
	text "I came here to"
	line "find bugs!"

	para "Nobody warned me"
	line "about ghosts!"
	done

TrainerBug_catcherCallum:
	trainer EVENT_BEAT_BUG_CATCHER_CALLUM, BUG_CATCHER, CALLUM, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I'm from Azalea,"
	line "but I've never seen"

	para "this part of the"
	line "forest."
	done

.BeatenText:
	text "This is no forest."
	line "It's a swamp!"
	done

.AfterText:
	text "This close to the"
	line "coast, I guess the"

	para "land becomes soak-"
	line "ed with water."
	done

TrainerBug_catcherDavid:
	trainer EVENT_BEAT_BUG_CATCHER_DAVID, BUG_CATCHER, DAVID, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "It feels so cold"
	line "in this swamp…"
	done

.BeatenText:
	text "Brrr…"
	done

.AfterText:
	text "It must be the"
	line "trees blocking"
	cont "the sun."

	para "That's gotta be"
	line "why it's so cold,"
	cont "right?"
	done

TrainerPokemaniacClive:
	trainer EVENT_BEAT_POKEMANIAC_CLIVE, POKEMANIAC, CLIVE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Don't tell me,"
	line "you're here to"
	cont "explore the swamp"
	cont "too?"
	done

.BeatenText:
	text "I knew it!"
	done

.AfterText:
	text "I know a fellow"
	line "#maniac when I"
	cont "see one."

	para "Leave some rare"
	line "#mon for me,"
	cont "OK?"
	done

TrainerHex_maniacMatilda:
	trainer EVENT_BEAT_HEX_MANIAC_MATILDA, HEX_MANIAC, MATILDA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Within the dark-"
	line "ness, vast and"
	cont "deep, I offer you"
	cont "eternal sleep."
	done

.BeatenText:
	text "Fufufufu…"
	done

.AfterText:
	text "So off into the"
	line "trees I stroll,"

	para "to lose my mind"
	line "and find my soul."
	done

TrainerFirebreatherOleg:
	trainer EVENT_BEAT_FIREBREATHER_OLEG, FIREBREATHER, OLEG, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "It's cold and dark"
	line "without a fire…"
	done

TrainerFisherDundee:
	trainer EVENT_BEAT_FISHER_DUNDEE, FISHER, DUNDEE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "All the #mon I"
	line "fish up here are"
	cont "poisonous!"
	done

.BeatenText:
	text "This is no place"
	line "for fishing…"
	done

.AfterText:
	text "I would go fish in"
	line "the ocean, but I'm"
	cont "lost in here…"
	done

MurkySwampYoungsterText:
	text "Man! This place is"
	line "such a maze."

	para "I'm not sure I'll"
	line "ever find my way"
	cont "to the other side."
	done
