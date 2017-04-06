const_value set 2
	const CERULEANCAPE_MISTY
	const CERULEANCAPE_MISTY_BOYFRIEND
	const CERULEANCAPE_COOLTRAINER_M
	const CERULEANCAPE_POKE_BALL
	const CERULEANCAPE_CUT_TREE

CeruleanCape_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	dw UnknownScript_0x19ee9e, 0
	dw UnknownScript_0x19ee9f, 0

.MapCallbacks:
	db 0

UnknownScript_0x19ee9e:
	end

UnknownScript_0x19ee9f:
	end

UnknownScript_0x19eea0:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	showemote EMOTE_SHOCK, CERULEANCAPE_MISTY_BOYFRIEND, 10
	spriteface CERULEANCAPE_MISTY, DOWN
	applymovement CERULEANCAPE_MISTY_BOYFRIEND, MovementData_0x19efe8
	disappear CERULEANCAPE_MISTY_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	spriteface CERULEANCAPE_MISTY, UP
	pause 10
	applymovement CERULEANCAPE_MISTY, MovementData_0x19efed
	opentext
	writetext UnknownText_0x19f006
	waitbutton
	closetext
	spriteface PLAYER, DOWN
	applymovement CERULEANCAPE_MISTY, MovementData_0x19effa
	spriteface PLAYER, LEFT
	applymovement CERULEANCAPE_MISTY, MovementData_0x19f000
	disappear CERULEANCAPE_MISTY
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	dotrigger $0
	special RestartMapMusic
	end

UnknownScript_0x19eee0:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	showemote EMOTE_SHOCK, CERULEANCAPE_MISTY_BOYFRIEND, 10
	spriteface CERULEANCAPE_MISTY, DOWN
	applymovement CERULEANCAPE_MISTY_BOYFRIEND, MovementData_0x19efea
	disappear CERULEANCAPE_MISTY_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	spriteface CERULEANCAPE_MISTY, UP
	pause 10
	applymovement CERULEANCAPE_MISTY, MovementData_0x19eff4
	opentext
	writetext UnknownText_0x19f006
	waitbutton
	closetext
	spriteface PLAYER, UP
	applymovement CERULEANCAPE_MISTY, MovementData_0x19effd
	spriteface PLAYER, LEFT
	applymovement CERULEANCAPE_MISTY, MovementData_0x19f000
	disappear CERULEANCAPE_MISTY
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	dotrigger $0
	special RestartMapMusic
	end

CooltrainerMScript_0x19efac:
	faceplayer
	opentext
	checkevent EVENT_BEAT_COOLTRAINERM_KEVIN
	iftrue UnknownScript_0x19efda
	checkevent EVENT_CLEARED_NUGGET_BRIDGE
	iftrue UnknownScript_0x19efc7
	writetext UnknownText_0x19f43b
	buttonsound
	verbosegiveitem NUGGET
	iffalse UnknownScript_0x19efde
	setevent EVENT_CLEARED_NUGGET_BRIDGE
UnknownScript_0x19efc7:
	writetext UnknownText_0x19f49d
	waitbutton
	closetext
	winlosstext UnknownText_0x19f4fd, 0
	loadtrainer COOLTRAINERM, KEVIN
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_KEVIN
	opentext
UnknownScript_0x19efda:
	writetext UnknownText_0x19f520
	waitbutton
UnknownScript_0x19efde:
	closetext
	end

BillsHouseSign:
	jumptext BillsHouseSignText

MovementData_0x19efe8:
	big_step_down
	step_end

MovementData_0x19efea:
	big_step_down
	big_step_down
	step_end

MovementData_0x19efed:
	step_up
	step_up
	step_up
	step_left
	step_left
	step_left
	step_end

MovementData_0x19eff4:
	step_up
	step_up
	step_left
	step_left
	step_left
	step_end

MovementData_0x19effa:
	step_down
	step_left
	step_end

MovementData_0x19effd:
	step_up
	step_left
	step_end

MovementData_0x19f000:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

UnknownText_0x19f006:
	text "Misty: Aww! Why"
	line "did you have to"

	para "show up and bug us"
	line "now?"

	para "Do you know what"
	line "they call people"
	cont "like you?"

	para "Pests! You heard"
	line "me right, pest!"

	para "…"

	para "…Oh? Those Badges"
	line "you have… Are they"
	cont "Johto Gym Badges?"

	para "If you have eight,"
	line "you must be good."

	para "OK, then. Come to"
	line "Cerulean Gym."

	para "I'll be happy to"
	line "take you on."

	para "I'm Misty, the"
	line "Gym Leader in"
	cont "Cerulean."
	done

UnknownText_0x19f43b:
	text "You took on one"
	line "more battle than"

	para "you expected, but"
	line "you won anyway."

	para "As promised, you"
	line "win a prize."
	done

UnknownText_0x19f49d:
	text "But after seeing"
	line "how you battle, I"

	para "want to see how"
	line "I'll fare."

	para "How about it? Let"
	line "me take you on."
	done

UnknownText_0x19f4fd:
	text "I've never had a"
	line "battle this good!"
	done

UnknownText_0x19f520:
	text "That was a great"
	line "battle!"

	para "You and your #-"
	line "mon are truly out-"
	cont "standing!"
	done

BillsHouseSignText:
	text "Sea Cottage"
	line "Bill's House"
	done

CeruleanCape_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $5, $b, 1, BILLS_HOUSE
	warp_def $1d, $2a, 1, DIM_CAVE_2F
	warp_def $1d, $2b, 1, DIM_CAVE_2F

.XYTriggers:
	db 2
	xy_trigger 1, $6, $6, $0, UnknownScript_0x19eea0, $0, $0
	xy_trigger 1, $7, $6, $0, UnknownScript_0x19eee0, $0, $0

.Signposts:
	db 1
	signpost 5, 9, SIGNPOST_READ, BillsHouseSign

.PersonEvents:
	db 5
	person_event SPRITE_CERULEAN_CAPE_MISTY, 9, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_MISTY_BOYFRIEND
	person_event SPRITE_COOLTRAINER_M, 10, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_MISTY_BOYFRIEND
	person_event SPRITE_COOLTRAINER_M, 8, 1, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x19efac, -1
	person_event SPRITE_BALL_CUT_FRUIT, 4, -4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_PROTEIN
	person_event SPRITE_BALL_CUT_FRUIT, 6, -2, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_CUT_TREE