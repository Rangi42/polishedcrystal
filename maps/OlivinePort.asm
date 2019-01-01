OlivinePort_MapScriptHeader:
	db 2 ; scene scripts
	scene_script OlivinePortTrigger0
	scene_script OlivinePortTrigger1

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 11,  7, OLIVINE_PORT_PASSAGE, 5
	warp_event  7, 23, FAST_SHIP_1F, 1

	db 1 ; coord events
	coord_event  7, 15, 0, UnknownScript_0x7491f

	db 1 ; bg events
	bg_event  1, 22, SIGNPOST_ITEM + PROTEIN, EVENT_OLIVINE_PORT_HIDDEN_PROTEIN

	db 7 ; object events
	object_event  7, 23, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x748c0, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	object_event  7, 15, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x74cd7, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event  4, 14, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x74a01, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event 13, 14, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x74a0c, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	object_event  6, 15, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x7499c, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	object_event  4, 15, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x74a17, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	object_event 11, 15, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x74a22, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME

	const_def 1 ; object constants
	const OLIVINEPORT_SAILOR1
	const OLIVINEPORT_SAILOR3

OlivinePortTrigger1:
	priorityjump UnknownScript_0x748b1
OlivinePortTrigger0:
	end

UnknownScript_0x748b1:
	applyonemovement PLAYER, step_up
	appear OLIVINEPORT_SAILOR1
	setscene $0
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	blackoutmod OLIVINE_CITY
	end

SailorScript_0x748c0:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue UnknownScript_0x74919
	writetext UnknownText_0x74a55
	waitbutton
	closetext
	turnobject OLIVINEPORT_SAILOR1, DOWN
	pause 10
	playsound SFX_EXIT_BUILDING
	disappear OLIVINEPORT_SAILOR1
	waitsfx
	applyonemovement PLAYER, step_down
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iffalse UnknownScript_0x7490a
	clearevent EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	setevent EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	clearevent EVENT_BEAT_COOLTRAINERM_SEAN
	clearevent EVENT_BEAT_COOLTRAINERF_CAROL
	clearevent EVENT_BEAT_GENTLEMAN_EDWARD
	clearevent EVENT_BEAT_BEAUTY_CASSIE
	clearevent EVENT_BEAT_PSYCHIC_RODNEY
	clearevent EVENT_BEAT_SUPER_NERD_SHAWN
	clearevent EVENT_BEAT_SAILOR_GARRETT
	clearevent EVENT_BEAT_FISHER_JONAH
	clearevent EVENT_BEAT_BLACKBELT_WAI
	clearevent EVENT_BEAT_RICH_BOY_WINSTON
UnknownScript_0x7490a:
	clearevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	appear OLIVINEPORT_SAILOR1
	setmapscene FAST_SHIP_1F, $1
	warp FAST_SHIP_1F, 25, 1
	end

UnknownScript_0x74919:
	jumpopenedtext UnknownText_0x74a80

UnknownScript_0x7491f:
	turnobject OLIVINEPORT_SAILOR3, RIGHT
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue UnknownScript_0x7498b
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue UnknownScript_0x7498b
	turnobject PLAYER, LEFT
	opentext
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iffalse UnknownScript_0x7494e
	checkcode VAR_WEEKDAY
	ifequal SUNDAY, UnknownScript_0x74977
	ifequal SATURDAY, UnknownScript_0x74977
	ifequal TUESDAY, UnknownScript_0x74981
	ifequal WEDNESDAY, UnknownScript_0x74981
	ifequal THURSDAY, UnknownScript_0x74981
UnknownScript_0x7494e:
	writetext UnknownText_0x74a9c
	yesorno
	iffalse UnknownScript_0x74992
	writetext UnknownText_0x74ada
	buttonsound
	checkitem S_S_TICKET
	iffalse UnknownScript_0x7496d
	writetext UnknownText_0x74b11
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	applymovement PLAYER, MovementData_0x74a37
	jump SailorScript_0x748c0

UnknownScript_0x7496d:
	writetext UnknownText_0x74b41
	waitbutton
	closetext
	applymovement PLAYER, MovementData_0x74a34
	end

UnknownScript_0x74977:
	writetext UnknownText_0x74ba8
	waitbutton
	closetext
	applymovement PLAYER, MovementData_0x74a34
	end

UnknownScript_0x74981:
	writetext UnknownText_0x74bce
	waitbutton
	closetext
	applymovement PLAYER, MovementData_0x74a34
	end

UnknownScript_0x7498b:
	end

UnknownScript_0x7498c:
	jumpopenedtext UnknownText_0x74af6

UnknownScript_0x74992:
	writetext UnknownText_0x74af6
	waitbutton
	closetext
	applymovement PLAYER, MovementData_0x74a34
	end

SailorScript_0x7499c:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue UnknownScript_0x74919
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iffalse UnknownScript_0x749c0
	checkcode VAR_WEEKDAY
	ifequal SUNDAY, UnknownScript_0x749f2
	ifequal SATURDAY, UnknownScript_0x749f2
	ifequal TUESDAY, UnknownScript_0x749f8
	ifequal WEDNESDAY, UnknownScript_0x749f8
	ifequal THURSDAY, UnknownScript_0x749f8
UnknownScript_0x749c0:
	writetext UnknownText_0x74a9c
	yesorno
	iffalse UnknownScript_0x7498c
	writetext UnknownText_0x74ada
	buttonsound
	checkitem S_S_TICKET
	iffalse UnknownScript_0x749ec
	writetext UnknownText_0x74b11
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	checkcode VAR_FACING
	ifequal RIGHT, UnknownScript_0x749e5
	applymovement PLAYER, MovementData_0x74a3f
	jump SailorScript_0x748c0

UnknownScript_0x749e5:
	applymovement PLAYER, MovementData_0x74a49
	jump SailorScript_0x748c0

UnknownScript_0x749ec:
	jumpopenedtext UnknownText_0x74b41

UnknownScript_0x749f2:
	jumpopenedtext UnknownText_0x74ba8

UnknownScript_0x749f8:
	jumpopenedtext UnknownText_0x74bce

FishingGuruScript_0x74a01:
	showtextfaceplayer UnknownText_0x74bf4
	turnobject LAST_TALKED, UP
	end

FishingGuruScript_0x74a0c:
	showtextfaceplayer UnknownText_0x74c35
	turnobject LAST_TALKED, UP
	end

YoungsterScript_0x74a17:
	showtextfaceplayer UnknownText_0x74c76
	turnobject LAST_TALKED, DOWN
	end

CooltrainerFScript_0x74a22:
	showtextfaceplayer UnknownText_0x74ca2
	turnobject LAST_TALKED, DOWN
	end

MovementData_0x74a34:
	step_right
	turn_head_left
	step_end

MovementData_0x74a37:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

MovementData_0x74a3f:
	step_right
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

MovementData_0x74a49:
	step_up
	step_right
	step_right
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

UnknownText_0x74a55:
	text "We're departing"
	line "soon. Please get"
	cont "on board."
	done

UnknownText_0x74a80:
	text "Sorry. You can't"
	line "board now."
	done

UnknownText_0x74a9c:
	text "Welcome to Fast"
	line "Ship S.S.Aqua."

	para "Will you be board-"
	line "ing today?"
	done

UnknownText_0x74ada:
	text "May I see your"
	line "S.S.Ticket?"
	done

UnknownText_0x74af6:
	text "We hope to see you"
	line "again!"
	done

UnknownText_0x74b11:
	text "<PLAYER> flashed"
	line "the S.S.Ticket."

	para "That's it."
	line "Thank you!"
	done

UnknownText_0x74b41:
	text "<PLAYER> tried to"
	line "show the S.S."
	cont "Ticket…"

	para "…But no Ticket!"

	para "Sorry!"
	line "You may board only"

	para "if you have an"
	line "S.S.Ticket."
	done

UnknownText_0x74ba8:
	text "The Fast Ship will"
	line "sail next Monday."
	done

UnknownText_0x74bce:
	text "The Fast Ship will"
	line "sail next Friday."
	done

UnknownText_0x74bf4:
	text "Shellder are easy"
	line "to catch here."

	para "They're kind of"
	line "rare elsewhere."
	done

UnknownText_0x74c35:
	text "How many Rods do"
	line "you have?"

	para "Different Rods"
	line "catch different"
	cont "#mon."
	done

UnknownText_0x74c76:
	text "S.S.Aqua uses jets"
	line "to skim over the"
	cont "waves!"
	done

UnknownText_0x74ca2:
	text "There are lots of"
	line "#mon in Kanto."

	para "I wish I could go…"
	done

UnknownText_0x74cd7:
	text "We don't want you"
	line "to fall into the"

	para "sea, so you're not"
	line "allowed in."
	done
