Route43Gate_MapScriptHeader:
	db 1 ; scene scripts
	scene_script Route43GateTrigger0

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  4,  0, ROUTE_43, 4
	warp_event  5,  0, ROUTE_43, 5
	warp_event  4,  7, ROUTE_43, 3
	warp_event  5,  7, ROUTE_43, 3

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	object_event  2,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19ad41, EVENT_ROUTE_43_GATE_ROCKETS
	object_event  7,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19ad41, EVENT_ROUTE_43_GATE_ROCKETS
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, OfficerScript_0x19ac85, EVENT_LAKE_OF_RAGE_CIVILIANS

	const_def 1 ; object constants
	const ROUTE43GATE_ROCKET1
	const ROUTE43GATE_ROCKET2

Route43GateTrigger0:
	priorityjump UnknownScript_0x19abda
	end

UnknownScript_0x19abda:
	playmusic MUSIC_ROCKET_ENCOUNTER
	checkcode VAR_FACING
	ifequal DOWN, UnknownScript_0x19abea
	ifequal UP, UnknownScript_0x19ac38
	setscene $1
	end

UnknownScript_0x19abea:
	applyonemovement PLAYER, step_down
	showemote EMOTE_SHOCK, ROUTE43GATE_ROCKET2, 15
	applymovement ROUTE43GATE_ROCKET2, MovementData_0x19acbb
	turnobject ROUTE43GATE_ROCKET1, UP
	showemote EMOTE_SHOCK, ROUTE43GATE_ROCKET1, 15
	applymovement ROUTE43GATE_ROCKET1, MovementData_0x19aca4
	opentext
	writetext UnknownText_0x19acd2
	buttonsound
	checkmoney $0, 999
	ifequal $0, UnknownScript_0x19ac12
	jump UnknownScript_0x19ac1d

UnknownScript_0x19ac12:
	takemoney $0, 1000
	writetext UnknownText_0x19ad0a
	jump UnknownScript_0x19ac28

UnknownScript_0x19ac1d:
	takemoney $0, 1000
	writetext UnknownText_0x19ad20
	jump UnknownScript_0x19ac28

UnknownScript_0x19ac28:
	buttonsound
	closetext
	applymovement ROUTE43GATE_ROCKET1, MovementData_0x19acaa
	applymovement ROUTE43GATE_ROCKET2, MovementData_0x19acc1
	setscene $1
	special RestartMapMusic
	end

UnknownScript_0x19ac38:
	showemote EMOTE_SHOCK, ROUTE43GATE_ROCKET1, 15
	applymovement ROUTE43GATE_ROCKET1, MovementData_0x19acaf
	turnobject ROUTE43GATE_ROCKET2, DOWN
	showemote EMOTE_SHOCK, ROUTE43GATE_ROCKET2, 15
	applymovement ROUTE43GATE_ROCKET2, MovementData_0x19acc7
	opentext
	writetext UnknownText_0x19acd2
	buttonsound
	checkmoney $0, 999
	ifequal $0, UnknownScript_0x19ac5c
	jump UnknownScript_0x19ac67

UnknownScript_0x19ac5c:
	takemoney $0, 1000
	writetext UnknownText_0x19ad0a
	jump UnknownScript_0x19ac72

UnknownScript_0x19ac67:
	takemoney $0, 1000
	writetext UnknownText_0x19ad20
	jump UnknownScript_0x19ac72

UnknownScript_0x19ac72:
	buttonsound
	closetext
	applymovement ROUTE43GATE_ROCKET2, MovementData_0x19accd
	applymovement ROUTE43GATE_ROCKET1, MovementData_0x19acb5
	setscene $1
	special RestartMapMusic
	end

OfficerScript_0x19ac85:
	checkevent EVENT_GOT_TM36_SLUDGE_BOMB
	iftrue_jumptextfaceplayer UnknownText_0x19ae2d
	faceplayer
	opentext
	writetext UnknownText_0x19ad9b
	buttonsound
	verbosegivetmhm TM_SLUDGE_BOMB
	setevent EVENT_GOT_TM36_SLUDGE_BOMB
	endtext

MovementData_0x19aca4:
	big_step_up
	big_step_up
	big_step_right
	big_step_right
	turn_head_up
	step_end

MovementData_0x19acaa:
	big_step_left
	big_step_left
	big_step_down
	big_step_down
	step_end

MovementData_0x19acaf:
	big_step_down
	big_step_down
	big_step_right
	big_step_right
	turn_head_down
	step_end

MovementData_0x19acb5:
	big_step_left
	big_step_left
	big_step_up
	big_step_up
	turn_head_down
	step_end

MovementData_0x19acbb:
	big_step_up
	big_step_up
	big_step_left
	big_step_left
	turn_head_up
	step_end

MovementData_0x19acc1:
	big_step_right
	big_step_right
	big_step_down
	big_step_down
	turn_head_up
	step_end

MovementData_0x19acc7:
	big_step_down
	big_step_down
	big_step_left
	big_step_left
	turn_head_down
	step_end

MovementData_0x19accd:
	big_step_right
	big_step_right
	big_step_up
	big_step_up
	step_end

UnknownText_0x19acd2:
	text "Hold it there,"
	line "kiddo!"

	para "The toll is ¥1000"
	line "to go through."
	done

UnknownText_0x19ad0a:
	text "Thank you very"
	line "much!"
	done

UnknownText_0x19ad20:
	text "Then pay what you"
	line "have, please."
	done

UnknownText_0x19ad41:
	text "He-he-he. We're"
	line "making a bundle."

	para "Everyone wants to"
	line "see what's going"

	para "on up at Lake of"
	line "Rage."
	done

UnknownText_0x19ad9b:
	text "I got chased from"
	line "my post by these"
	cont "thugs in black."

	para "They left this"
	line "behind."

	para "It makes me uncom-"
	line "fortable. Could"
	cont "you take it away?"
	done

UnknownText_0x19ae2d:
	text "Use this gate to"
	line "avoid walking in"
	cont "the grass."
	done
