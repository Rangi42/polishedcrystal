Route1617Gate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event  0,  5, ROUTE_16_SOUTH, 1
	warp_event  0,  6, ROUTE_16_SOUTH, 2
	warp_event  9,  5, ROUTE_16_NORTHEAST, 1
	warp_event  9,  6, ROUTE_16_NORTHEAST, 2
	warp_event  8,  8, ROUTE_16_17_GATE_2F, 1

	db 5 ; coord events
	coord_event  5,  3, 0, UnknownScript_0x733ed
	coord_event  5,  4, 0, UnknownScript_0x733ed
	coord_event  5,  5, 0, Route1617GateStepUpOneTrigger
	coord_event  5,  6, 0, Route1617GateStepUpTwoTrigger
	coord_event  5,  7, 0, Route1617GateStepUpThreeTrigger

	db 0 ; bg events

	db 1 ; object events
	object_event  5,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x73408, -1

	const_def 1 ; object constants
	const ROUTE1617GATE_OFFICER

Route1617GateStepUpOneTrigger:
	checkitem BICYCLE
	iftrue Route1617GateDoNothingScript
	applyonemovement PLAYER, step_up
	jump UnknownScript_0x733f3

Route1617GateStepUpTwoTrigger:
	checkitem BICYCLE
	iftrue Route1617GateDoNothingScript
	applymovement PLAYER, Route1617GateStepUpTwoMovementData
	jump UnknownScript_0x733f3

Route1617GateStepUpThreeTrigger:
	checkitem BICYCLE
	iftrue Route1617GateDoNothingScript
	applymovement PLAYER, Route1617GateStepUpThreeMovementData
	jump UnknownScript_0x733f3

UnknownScript_0x733ed:
	checkitem BICYCLE
	iftrue Route1617GateDoNothingScript
UnknownScript_0x733f3:
	showemote EMOTE_SHOCK, ROUTE1617GATE_OFFICER, 15
	turnobject PLAYER, UP
	showtext UnknownText_0x73496
	applymovement PLAYER, MovementData_0x73405
Route1617GateDoNothingScript:
	end

Route1617GateStepUpThreeMovementData:
	step_up
Route1617GateStepUpTwoMovementData:
	step_up
	step_up
	step_end

MovementData_0x73405:
	step_right
	turn_head_left
	step_end

UnknownText_0x73408:
	text "Cycling Road"
	line "starts here."

	para "It's all downhill,"
	line "so it's totally"
	cont "exhilarating."

	para "It's a great sort"
	line "of feeling that"

	para "you can't get from"
	line "a ship or train."
	done

UnknownText_0x73496:
	text "Hey! Whoa! Stop!"

	para "You can't go out"
	line "on the Cycling"

	para "Road without a"
	line "Bicycle."
	done
