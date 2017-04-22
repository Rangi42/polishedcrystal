const_value set 2
	const UNIONCAVEB1FNORTH_POKEFAN_M1
	const UNIONCAVEB1FNORTH_POKEFAN_M2
	const UNIONCAVEB1FNORTH_POKE_BALL1
	const UNIONCAVEB1FNORTH_POKE_BALL2
	const UNIONCAVEB1FNORTH_BOULDER

UnionCaveB1FNorth_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerHikerPhillip:
	trainer EVENT_BEAT_HIKER_PHILLIP, HIKER, PHILLIP, HikerPhillipSeenText, HikerPhillipBeatenText, 0, HikerPhillipScript

HikerPhillipScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x5a073
	waitbutton
	closetext
	end

TrainerHikerLeonard:
	trainer EVENT_BEAT_HIKER_LEONARD, HIKER, LEONARD, HikerLeonardSeenText, HikerLeonardBeatenText, 0, HikerLeonardScript

HikerLeonardScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x5a0fb
	waitbutton
	closetext
	end

UnionCaveB1FNorthTMSwift:
	tmhmball TM_SWIFT

UnionCaveB1FNorthXDefend:
	itemball X_DEFEND

UnionCaveB1FNorthBoulder:
	jumpstd strengthboulder

UnionCaveB1FNorthHiddenXSpeed:
	dwb EVENT_UNION_CAVE_B1F_NORTH_HIDDEN_X_SPEED, X_SPEED

UnionCaveB1FNorthHiddenRevive:
	dwb EVENT_UNION_CAVE_B1F_NORTH_HIDDEN_REVIVE, REVIVE

HikerPhillipSeenText:
	text "It's been a while"
	line "since I last saw"
	cont "another person."

	para "Don't be shy."
	line "Let's battle!"
	done

HikerPhillipBeatenText:
	text "Uurggh…"
	done

UnknownText_0x5a073:
	text "I've been lost for"
	line "a long time…"

	para "I don't mind it"
	line "here, but I am"
	cont "soooo hungry!"
	done

HikerLeonardSeenText:
	text "What do you know!"
	line "A visitor!"
	done

HikerLeonardBeatenText:
	text "Wahahah! You're a"
	line "feisty one!"
	done

UnknownText_0x5a0fb:
	text "I live down here."

	para "You can, too, if"
	line "you'd like."

	para "There's plenty of"
	line "room, you see."
	done

UnionCaveB1FNorth_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $3, $3, 7, RUINS_OF_ALPH_OUTSIDE
	warp_def $b, $3, 8, RUINS_OF_ALPH_OUTSIDE
	warp_def $17, $f, 1, UNION_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 23, 11, SIGNPOST_ITEM, UnionCaveB1FNorthHiddenXSpeed
	signpost 4, 13, SIGNPOST_ITEM, UnionCaveB1FNorthHiddenRevive

.PersonEvents:
	db 5
	person_event SPRITE_POKEFAN_M, 4, 9, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerHikerPhillip, -1
	person_event SPRITE_POKEFAN_M, 10, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerHikerLeonard, -1
	person_event SPRITE_BALL_CUT_FRUIT, 22, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TMHMBALL, 0, UnionCaveB1FNorthTMSwift, EVENT_UNION_CAVE_B1F_NORTH_TM_SWIFT
	person_event SPRITE_BALL_CUT_FRUIT, 21, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, UnionCaveB1FNorthXDefend, EVENT_UNION_CAVE_B1F_NORTH_X_DEFEND
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 10, 7, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, UnionCaveB1FNorthBoulder, -1
