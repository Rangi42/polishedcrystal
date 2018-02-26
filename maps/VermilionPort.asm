VermilionPort_MapScriptHeader:
	db 2 ; scene scripts
	scene_script VermilionPortTrigger0
	scene_script VermilionPortTrigger1

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  9,  5, VERMILION_PORT_PASSAGE, 5
	warp_event  7, 17, FAST_SHIP_1F, 1

	db 1 ; coord events
	coord_event  7, 11, 0, UnknownScript_0x74e20

	db 1 ; bg events
	bg_event 16, 13, SIGNPOST_ITEM + IRON, EVENT_VERMILION_PORT_HIDDEN_IRON

	db 3 ; object events
	object_event  7, 17, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x74dc4, EVENT_VERMILION_PORT_SAILOR_AT_GANGWAY
	object_event  6, 11, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x74e97, -1
	object_event 11, 11, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x74ee6, -1

	const_def 1 ; object constants
	const VERMILIONPORT_SAILOR1
	const VERMILIONPORT_SAILOR2

VermilionPortTrigger1:
	priorityjump UnknownScript_0x74da6
VermilionPortTrigger0:
	end

UnknownScript_0x74da6:
	applyonemovement PLAYER, step_up
	appear VERMILIONPORT_SAILOR1
	setscene $0
	setevent EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_1
	setevent EVENT_FAST_SHIP_CABINS_SE_SSE_GENTLEMAN
	setevent EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	clearevent EVENT_OLIVINE_PORT_PASSAGE_POKEFAN_M
	setevent EVENT_FAST_SHIP_FIRST_TIME
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	blackoutmod VERMILION_CITY
	end

SailorScript_0x74dc4:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue UnknownScript_0x74e1a
	writetext UnknownText_0x74f06
	waitbutton
	closetext
	turnobject VERMILIONPORT_SAILOR1, DOWN
	pause 10
	playsound SFX_EXIT_BUILDING
	disappear VERMILIONPORT_SAILOR1
	waitsfx
	applyonemovement PLAYER, step_down
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	setevent EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	clearevent EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	clearevent EVENT_BEAT_POKEMANIAC_ETHAN
	clearevent EVENT_BEAT_BURGLAR_COREY
	clearevent EVENT_BEAT_BUG_CATCHER_KEN
	clearevent EVENT_BEAT_GUITARISTM_CLYDE
	clearevent EVENT_BEAT_POKEFANM_JEREMY
	clearevent EVENT_BEAT_POKEFANF_GEORGIA
	clearevent EVENT_BEAT_SAILOR_KENNETH
	clearevent EVENT_BEAT_TEACHER_SHIRLEY
	clearevent EVENT_BEAT_SCHOOLBOY_NATE
	clearevent EVENT_BEAT_SCHOOLBOY_RICKY
	setevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	appear VERMILIONPORT_SAILOR1
	setmapscene FAST_SHIP_1F, $1
	warp FAST_SHIP_1F, 25, 1
	end

UnknownScript_0x74e1a:
	jumpopenedtext UnknownText_0x74f31

UnknownScript_0x74e20:
	turnobject VERMILIONPORT_SAILOR2, RIGHT
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue UnknownScript_0x74e86
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue UnknownScript_0x74e86
	turnobject PLAYER, LEFT
	opentext
	checkcode VAR_WEEKDAY
	ifequal MONDAY, UnknownScript_0x74e72
	ifequal TUESDAY, UnknownScript_0x74e72
	ifequal THURSDAY, UnknownScript_0x74e7c
	ifequal FRIDAY, UnknownScript_0x74e7c
	ifequal SATURDAY, UnknownScript_0x74e7c
	writetext UnknownText_0x74f4d
	yesorno
	iffalse UnknownScript_0x74e8d
	writetext UnknownText_0x74f8b
	buttonsound
	checkitem S_S_TICKET
	iffalse UnknownScript_0x74e68
	writetext UnknownText_0x74fc2
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	applymovement PLAYER, MovementData_0x74ef8
	jump SailorScript_0x74dc4

UnknownScript_0x74e68:
	writetext UnknownText_0x74ff2
	waitbutton
	closetext
	applymovement PLAYER, MovementData_0x74ef5
	end

UnknownScript_0x74e72:
	writetext UnknownText_0x75059
	waitbutton
	closetext
	applymovement PLAYER, MovementData_0x74ef5
	end

UnknownScript_0x74e7c:
	writetext UnknownText_0x75080
	waitbutton
	closetext
	applymovement PLAYER, MovementData_0x74ef5
	end

UnknownScript_0x74e86:
	end

UnknownScript_0x74e87:
	jumpopenedtext UnknownText_0x74fa7

UnknownScript_0x74e8d:
	writetext UnknownText_0x74fa7
	waitbutton
	closetext
	applymovement PLAYER, MovementData_0x74ef5
	end

SailorScript_0x74e97:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue UnknownScript_0x74e1a
	checkcode VAR_WEEKDAY
	ifequal MONDAY, UnknownScript_0x74eda
	ifequal TUESDAY, UnknownScript_0x74eda
	ifequal THURSDAY, UnknownScript_0x74ee0
	ifequal FRIDAY, UnknownScript_0x74ee0
	ifequal SATURDAY, UnknownScript_0x74ee0
	writetext UnknownText_0x74f4d
	yesorno
	iffalse UnknownScript_0x74e87
	writetext UnknownText_0x74f8b
	buttonsound
	checkitem S_S_TICKET
	iffalse UnknownScript_0x74ed4
	writetext UnknownText_0x74fc2
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	applymovement PLAYER, MovementData_0x74efe
	jump SailorScript_0x74dc4

UnknownScript_0x74ed4:
	jumpopenedtext UnknownText_0x74ff2

UnknownScript_0x74eda:
	jumpopenedtext UnknownText_0x75059

UnknownScript_0x74ee0:
	jumpopenedtext UnknownText_0x75080

SuperNerdScript_0x74ee6:
	faceplayer
	jumptext UnknownText_0x750a6

MovementData_0x74ef5:
	step_right
	turn_head_left
	step_end

MovementData_0x74ef8:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

MovementData_0x74efe:
	step_right
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

UnknownText_0x74f06:
	text "We're departing"
	line "soon. Please get"
	cont "on board."
	done

UnknownText_0x74f31:
	text "Sorry. You can't"
	line "board now."
	done

UnknownText_0x74f4d:
	text "Welcome to Fast"
	line "Ship S.S.Aqua."

	para "Will you be board-"
	line "ing today?"
	done

UnknownText_0x74f8b:
	text "May I see your"
	line "S.S.Ticket?"
	done

UnknownText_0x74fa7:
	text "We hope to see you"
	line "again!"
	done

UnknownText_0x74fc2:
	text "<PLAYER> flashed"
	line "the S.S.Ticket."

	para "That's it."
	line "Thank you!"
	done

UnknownText_0x74ff2:
	text "<PLAYER> tried to"
	line "show the S.S."
	cont "Ticket…"

	para "…But no Ticket!"

	para "Sorry!"
	line "You may board only"

	para "if you have an"
	line "S.S.Ticket."
	done

UnknownText_0x75059:
	text "The Fast Ship will"
	line "sail on Wednesday."
	done

UnknownText_0x75080:
	text "The Fast Ship will"
	line "sail next Sunday."
	done

UnknownText_0x750a6:
	text "You came from"
	line "Johto?"

	para "I hear many rare"
	line "#mon live over"
	cont "there."
	done
