const_value set 2
	const QUIETCAVEB2F_POKE_BALL1
	const QUIETCAVEB2F_POKE_BALL2
	const QUIETCAVEB2F_POKE_BALL3

QuietCaveB2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

QuietCaveB2FDuskBall:
	itemball DUSK_BALL

QuietCaveB2FRazorClaw:
	itemball RAZOR_CLAW

QuietCaveB2FFocusSash:
	itemball FOCUS_SASH

QuietCaveB2FHiddenCalcium:
	dwb EVENT_QUIET_CAVE_B2F_HIDDEN_CALCIUM, CALCIUM

QuietCaveB2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $3, $15, 6, QUIET_CAVE_B1F
	warp_def $19, $11, 7, QUIET_CAVE_B1F
	warp_def $21, $17, 8, QUIET_CAVE_B1F
	warp_def $3, $1d, 9, QUIET_CAVE_B1F
	warp_def $1f, $a, 1, QUIET_CAVE_B3F
	warp_def $5, $21, 2, QUIET_CAVE_B3F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 11, 16, SIGNPOST_ITEM, QuietCaveB2FHiddenCalcium

.PersonEvents:
	db 3
	person_event SPRITE_BALL_CUT_FRUIT, 3, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, QuietCaveB2FDuskBall, EVENT_QUIET_CAVE_B2F_DUSK_BALL
	person_event SPRITE_BALL_CUT_FRUIT, 23, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, QuietCaveB2FRazorClaw, EVENT_QUIET_CAVE_B2F_RAZOR_CLAW
	person_event SPRITE_BALL_CUT_FRUIT, 11, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, QuietCaveB2FFocusSash, EVENT_QUIET_CAVE_B2F_FOCUS_SASH
