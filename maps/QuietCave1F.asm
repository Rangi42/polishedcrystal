const_value set 2
	const QUIETCAVE1F_HEX_MANIAC
	const QUIETCAVE1F_COOLTRAINER_M
	const QUIETCAVE1F_POKE_BALL1
	const QUIETCAVE1F_POKE_BALL2
	const QUIETCAVE1F_POKE_BALL3
	const QUIETCAVE1F_POKE_BALL4

QuietCave1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerHexManiacAshley:
	trainer EVENT_BEAT_HEX_MANIAC_ASHLEY, HEX_MANIAC, ASHLEY, HexManiacAshleySeenText, HexManiacAshleyBeatenText, 0, HexManiacAshleyScript

HexManiacAshleyScript:
	end_if_just_battled
	opentext
	writetext HexManiacAshleyAfterText
	waitbutton
	closetext
	end

TrainerCooltrainermHenri:
	trainer EVENT_BEAT_COOLTRAINERM_HENRI, COOLTRAINERM, HENRI, CooltrainermHenriSeenText, CooltrainermHenriBeatenText, 0, CooltrainermHenriScript

CooltrainermHenriScript:
	end_if_just_battled
	opentext
	writetext CooltrainermHenriAfterText
	waitbutton
	closetext
	end

QuietCave1FNugget:
	itemball NUGGET

QuietCave1FTwistedSpoon:
	itemball TWISTEDSPOON

QuietCave1FDuskStone:
	itemball DUSK_STONE

QuietCave1FDuskBall:
	itemball DUSK_BALL

HexManiacAshleySeenText:
	text "The spirits have"
	line "shown me your"
	cont "defeat!"
	done

HexManiacAshleyBeatenText:
	text "No! The spirits"
	line "can't be wrong!"
	done

HexManiacAshleyAfterText:
	text "I see things that"
	line "others can't see…"
	done

CooltrainermHenriSeenText:
	text "Can you handle my"
	line "balanced team of"
	cont "#mon?"
	done

CooltrainermHenriBeatenText:
	text "I guess you can!"
	done

CooltrainermHenriAfterText:
	text "Having a diverse"
	line "team to support"

	para "each others' weak-"
	line "nesses is key."
	done

QuietCave1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $21, $13, 5, ROUTE_47
	warp_def $19, $5, 1, QUIET_CAVE_B1F
	warp_def $17, $1b, 2, QUIET_CAVE_B1F
	warp_def $9, $15, 3, QUIET_CAVE_B1F
	warp_def $11, $3, 4, QUIET_CAVE_B1F
	warp_def $d, $1f, 5, QUIET_CAVE_B1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 5
	person_event SPRITE_HEX_MANIAC, 8, 6, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerHexManiacAshley, -1
	person_event SPRITE_COOLTRAINER_M, 17, 13, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerCooltrainermHenri, -1
	person_event SPRITE_BALL_CUT_FRUIT, 23, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, QuietCave1FNugget, EVENT_QUIET_CAVE_1F_NUGGET
	person_event SPRITE_BALL_CUT_FRUIT, 4, 26, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, QuietCave1FTwistedSpoon, EVENT_QUIET_CAVE_1F_TWISTEDSPOON
	person_event SPRITE_BALL_CUT_FRUIT, 2, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, QuietCave1FDuskStone, EVENT_QUIET_CAVE_1F_DUSK_STONE
	person_event SPRITE_BALL_CUT_FRUIT, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, QuietCave1FDuskBall, EVENT_QUIET_CAVE_1F_DUSK_BALL
