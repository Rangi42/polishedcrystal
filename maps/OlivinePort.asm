OlivinePort_MapScriptHeader:

.MapTriggers: db 2
	dw OlivinePortTrigger0
	dw OlivinePortTrigger1

.MapCallbacks: db 0

OlivinePort_MapEventHeader:

.Warps: db 2
	warp_def 7, 11, 5, OLIVINE_PORT_PASSAGE
	warp_def 23, 7, 1, FAST_SHIP_1F

.XYTriggers: db 1
	xy_trigger 0, 15, 7, UnknownScript_0x7491f

.Signposts: db 1
	signpost 22, 1, SIGNPOST_ITEM + PROTEIN, EVENT_OLIVINE_PORT_HIDDEN_PROTEIN

.PersonEvents: db 7
	person_event SPRITE_SAILOR, 23, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x748c0, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	person_event SPRITE_SAILOR, 15, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x74cd7, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	person_event SPRITE_FISHING_GURU, 14, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x74a01, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	person_event SPRITE_FISHING_GURU, 14, 13, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x74a0c, EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	person_event SPRITE_SAILOR, 15, 6, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x7499c, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	person_event SPRITE_YOUNGSTER, 15, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x74a17, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	person_event SPRITE_COOLTRAINER_F, 15, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x74a22, EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME

const_value set 1
	const OLIVINEPORT_SAILOR1
	const OLIVINEPORT_SAILOR3

OlivinePortTrigger1:
	priorityjump UnknownScript_0x748b1
OlivinePortTrigger0:
	end

UnknownScript_0x748b1:
	applyonemovement PLAYER, step_up
	appear OLIVINEPORT_SAILOR1
	dotrigger $0
	setevent EVENT_GAVE_KURT_APRICORNS
	blackoutmod OLIVINE_CITY
	end

SailorScript_0x748c0:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KURT_APRICORNS
	iftrue UnknownScript_0x74919
	writetext UnknownText_0x74a55
	waitbutton
	closetext
	spriteface OLIVINEPORT_SAILOR1, DOWN
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
	domaptrigger FAST_SHIP_1F, $1
	warp FAST_SHIP_1F, 25, 1
	end

UnknownScript_0x74919:
	jumpopenedtext UnknownText_0x74a80

UnknownScript_0x7491f:
	spriteface OLIVINEPORT_SAILOR3, RIGHT
	checkevent EVENT_GAVE_KURT_APRICORNS
	iftrue UnknownScript_0x7498b
	checkevent EVENT_RECEIVED_BALLS_FROM_KURT
	iftrue UnknownScript_0x7498b
	spriteface PLAYER, LEFT
	opentext
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iffalse UnknownScript_0x7494e
	checkcode VAR_WEEKDAY
	if_equal SUNDAY, UnknownScript_0x74977
	if_equal SATURDAY, UnknownScript_0x74977
	if_equal TUESDAY, UnknownScript_0x74981
	if_equal WEDNESDAY, UnknownScript_0x74981
	if_equal THURSDAY, UnknownScript_0x74981
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
	setevent EVENT_RECEIVED_BALLS_FROM_KURT
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
	checkevent EVENT_GAVE_KURT_APRICORNS
	iftrue UnknownScript_0x74919
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iffalse UnknownScript_0x749c0
	checkcode VAR_WEEKDAY
	if_equal SUNDAY, UnknownScript_0x749f2
	if_equal SATURDAY, UnknownScript_0x749f2
	if_equal TUESDAY, UnknownScript_0x749f8
	if_equal WEDNESDAY, UnknownScript_0x749f8
	if_equal THURSDAY, UnknownScript_0x749f8
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
	setevent EVENT_RECEIVED_BALLS_FROM_KURT
	checkcode VAR_FACING
	if_equal RIGHT, UnknownScript_0x749e5
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
	spriteface LAST_TALKED, UP
	end

FishingGuruScript_0x74a0c:
	showtextfaceplayer UnknownText_0x74c35
	spriteface LAST_TALKED, UP
	end

YoungsterScript_0x74a17:
	showtextfaceplayer UnknownText_0x74c76
	spriteface LAST_TALKED, DOWN
	end

CooltrainerFScript_0x74a22:
	showtextfaceplayer UnknownText_0x74ca2
	spriteface LAST_TALKED, DOWN
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
