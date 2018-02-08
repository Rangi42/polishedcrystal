EcruteakHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_OBJECTS, EcruteakHouseInitializeSages

	db 5 ; warp events
	warp_event  4, 17, ECRUTEAK_CITY, 3
	warp_event  5, 17, ECRUTEAK_CITY, 3
	warp_event  5,  3, ECRUTEAK_HOUSE, 4
	warp_event 17, 15, ECRUTEAK_HOUSE, 3
	warp_event 17,  3, WISE_TRIOS_ROOM, 3

	db 2 ; coord events
	coord_event  4,  7, 0, EcruteakHouse_XYTrigger1
	coord_event  5,  7, 0, EcruteakHouse_XYTrigger2

	db 0 ; bg events

	db 4 ; object events
	object_event  4,  6, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SageScript_0x98062, EVENT_RANG_CLEAR_BELL_1
	object_event  5,  6, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SageScript_0x98062, EVENT_RANG_CLEAR_BELL_2
	object_event  6,  9, SPRITE_SAGE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SageScript_0x980b0, EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE
	object_event  3, 11, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x984ab, EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE

	const_def 1 ; object constants
	const ECRUTEAKHOUSE_SAGE1
	const ECRUTEAKHOUSE_SAGE2

EcruteakHouseInitializeSages:
	checkevent EVENT_FOUGHT_SUICUNE
	iftrue .DontBlockTower
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftrue .DontBlockTower
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .BlockTower
	return

.BlockTower:
	clearevent EVENT_RANG_CLEAR_BELL_1
	setevent EVENT_RANG_CLEAR_BELL_2
	setevent EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE
	checkitem CLEAR_BELL
	iftrue .NoClearBell
	setscene $0
.NoClearBell:
	return

.DontBlockTower:
	clearevent EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE
	return

EcruteakHouse_XYTrigger1:
	checkevent EVENT_RANG_CLEAR_BELL_2
	iftrue EcruteakHouse_XYTrigger_DontMove
	applymovement ECRUTEAKHOUSE_SAGE2, MovementData_0x980c7
	moveobject ECRUTEAKHOUSE_SAGE1, 4, 6
	appear ECRUTEAKHOUSE_SAGE1
	pause 5
	disappear ECRUTEAKHOUSE_SAGE2
	end

EcruteakHouse_XYTrigger2:
	checkevent EVENT_RANG_CLEAR_BELL_1
	iftrue EcruteakHouse_XYTrigger_DontMove
	applymovement ECRUTEAKHOUSE_SAGE1, MovementData_0x980cc
	moveobject ECRUTEAKHOUSE_SAGE2, 5, 6
	appear ECRUTEAKHOUSE_SAGE2
	pause 5
	disappear ECRUTEAKHOUSE_SAGE1
	end

EcruteakHouse_XYTrigger_DontMove:
	end

SageScript_0x98062:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .CheckForClearBell
	checkflag ENGINE_FOGBADGE
	iftrue_jumpopenedtext UnknownText_0x98131
	jumpopenedtext UnknownText_0x980d1

.CheckForClearBell:
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftrue_jumpopenedtext UnknownText_0x9837e
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue_jumpopenedtext UnknownText_0x98391
	checkitem CLEAR_BELL
	iftrue .RingClearBell
	jumpopenedtext UnknownText_0x981a4

.RingClearBell:
	writetext UnknownText_0x98250
	waitbutton
	closetext
	setscene $1
	setevent EVENT_RANG_CLEAR_BELL_2
	clearevent EVENT_RANG_CLEAR_BELL_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	end

SageScript_0x980b0:
	checkevent EVENT_GOT_CLEAR_BELL
	iftrue_jumptextfaceplayer UnknownText_0x9846f
	jumptextfaceplayer UnknownText_0x9840b

MovementData_0x980c7:
	fix_facing
	big_step_left
	remove_fixed_facing
	turn_head_down
	step_end

MovementData_0x980cc:
	fix_facing
	big_step_right
	remove_fixed_facing
	turn_head_down
	step_end

UnknownText_0x980d1:
	text "Bell Tower is off"
	line "limits to anyone"

	para "without Ecruteak"
	line "Gym's Badge."

	para "Sorry, but you'll"
	line "have to leave."
	done

UnknownText_0x98131:
	text "Bell Tower is off"
	line "limits to anyone"

	para "without Ecruteak"
	line "Gym's Badge."

	para "Ah!"

	para "Ecruteak's Gym"
	line "Badge! Please, go"
	cont "right through."
	done

UnknownText_0x981a4:
	text "A momentous event"
	line "has occurred."

	para "I beg your pardon,"
	line "but I must ask you"
	cont "to leave."

	para "…What soothes the"
	line "soul…"

	para "The Wise Trio say"
	line "things that are so"

	para "very difficult to"
	line "understand…"
	done

UnknownText_0x98250:
	text "A momentous event"
	line "has occurred."

	para "I beg your pardon,"
	line "but I must ask you"
	cont "to leave."

	para "………………"

	para "Ah!"

	para "The sound of that"
	line "Clear Bell!"

	para "It… It's sublime!"

	para "I've never heard"
	line "so beautiful a"
	cont "sound before!"

	para "That bell's chime"
	line "is indicative of"
	cont "the bearer's soul."

	para "You…"

	para "You may be able to"
	line "make it through"
	cont "Bell Tower."

	para "Please, do go on."
	done

UnknownText_0x9837e:
	text "Please, do go on."
	done

UnknownText_0x98391:
	text "That bell's chime"
	line "is indicative of"
	cont "the bearer's soul."

	para "You…"

	para "You may be able to"
	line "make it through"
	cont "Bell Tower."

	para "Please, do go on."
	done

UnknownText_0x9840b:
	text "The Bell Tower"
	line "ahead is a nine-"

	para "tier tower of"
	line "divine beauty."

	para "It soothes the"
	line "soul of all who"
	cont "see it."
	done

UnknownText_0x9846f:
	text "The Bell Tower"
	line "shook! A #mon"

	para "must have returned"
	line "to the top!"
	done

UnknownText_0x984ab:
	text "Two towers…"
	line "Two #mon…"

	para "But when one"
	line "burned down, both"

	para "#mon flew away,"
	line "never to return."
	done
