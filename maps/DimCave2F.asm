DimCave2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, DimCave2FBouldersLand

DimCave2F_MapEventHeader:

.Warps: db 8
	warp_def $1, $f, 2, CERULEAN_CAPE
	warp_def $5, $1d, 4, DIM_CAVE_3F
	warp_def $19, $1b, 5, DIM_CAVE_3F
	warp_def $14, $e, 6, DIM_CAVE_3F ; hole
	warp_def $2, $1e, 1, DIM_CAVE_1F
	warp_def $11, $5, 2, DIM_CAVE_1F
	warp_def $12, $1c, 3, DIM_CAVE_1F
	warp_def $20, $1a, 4, DIM_CAVE_1F

.XYTriggers: db 0

.Signposts: db 2
	signpost 4, 6, SIGNPOST_ITEM, DimCave2FHiddenStardust
	signpost 19, 2, SIGNPOST_ITEM, DimCave2FHiddenMoonStone

.PersonEvents: db 7
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 21, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave2FFallenBoulderScript, EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
	person_event SPRITE_ENGINEER, 12, 15, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerEngineerLang, -1
	person_event SPRITE_POKEFAN_M, 16, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerHikerDerrick, -1
	person_event SPRITE_FISHER, 21, 24, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, DimCave2FFisherScript, -1
	person_event SPRITE_BALL_CUT_FRUIT, 12, 28, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, MAX_REVIVE, 1, EVENT_DIM_CAVE_2F_MAX_REVIVE
	person_event SPRITE_BALL_CUT_FRUIT, 15, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, IRON, 1, EVENT_DIM_CAVE_2F_IRON
	person_event SPRITE_BALL_CUT_FRUIT, 33, 31, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TMHMBALL, 0, TM_FACADE, EVENT_DIM_CAVE_2F_TM_FACADE

DimCave2FBouldersLand:
	checkevent EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
	iftrue .skip
	changeblock $e, $14, $c5
	changeblock $1a, $14, $ba
.skip
	return

DimCave2FFisherScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_SUBSTITUTE_INTRO
	iftrue DimCave2FTutorSubstituteScript
	writetext DimCave2FFisherText
	waitbutton
	setevent EVENT_LISTENED_TO_SUBSTITUTE_INTRO
DimCave2FTutorSubstituteScript:
	writetext .QuestionText
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	yesorno
	iffalse .TutorRefused
	writebyte SUBSTITUTE
	writetext .ClearText
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	writetext .RefusedText
	waitbutton
	closetext
	end

.QuestionText:
	text "I can teach you my"
	line "Substitute tech-"
	cont "nique for a Silver"
	cont "Leaf."
	done

.RefusedText:
	text "No? It's very"
	line "useful…"
	done

.ClearText:
	text ""
	done

.NoSilverLeaf
	waitbutton
	writetext .NoSilverLeafText
	waitbutton
	closetext
	end

.NoSilverLeafText:
	text "Come find me again"
	line "if you get a Silver"
	cont "Leaf."
	done

.TeachMove
	takeitem SILVER_LEAF
	writetext .TaughtText
	waitbutton
	closetext
	end

.TaughtText:
	text "How's that? Your"
	line "#mon can make"
	cont "a Substitute too!"
	done

DimCave2FFisherText:
	text "Whoa! That cart"
	line "almost ran into"
	cont "me!"

	para "I had to Substi-"
	line "tute a rock in my"
	cont "place!"
	done

TrainerEngineerLang:
	trainer EVENT_BEAT_ENGINEER_LANG, ENGINEER, LANG, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "We mined ore from"
	line "this mountain to"

	para "refurbish the"
	line "Power Plant!"
	done

.BeatenText:
	text "A power failure!"
	done

.AfterText:
	text "Three years ago"
	line "the Power Plant"
	cont "was a wreck."

	para "We got it up and"
	line "running to power"

	para "the Magnet Train"
	line "to Johto."
	done

TrainerHikerDerrick:
	trainer EVENT_BEAT_HIKER_DERRICK, HIKER, DERRICK, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "♪ A-hiking we"
	line "will go, a-hiking"
	cont "we will go… ♪"
	done

.BeatenText:
	text "♪ Eee-iiii-ah-"
	line "dee-oh, a-hiking"
	cont "we will go! ♪"
	done

.AfterText:
	text "It goes without"
	line "saying, but I love"

	para "hiking with my"
	line "#mon."
	done

DimCave2FFallenBoulderScript:
	jumptext .Text

.Text:
	text "It's stuck on the"
	line "button."
	done

DimCave2FHiddenStardust:
	dwb EVENT_DIM_CAVE_2F_HIDDEN_STARDUST, STARDUST

DimCave2FHiddenMoonStone:
	dwb EVENT_DIM_CAVE_2F_HIDDEN_MOON_STONE, MOON_STONE
