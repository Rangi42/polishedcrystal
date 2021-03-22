Route1617Gate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  5, ROUTE_16_SOUTH, 1
	warp_event  0,  6, ROUTE_16_SOUTH, 2
	warp_event  9,  5, ROUTE_16_NORTHEAST, 1
	warp_event  9,  6, ROUTE_16_NORTHEAST, 2
	warp_event  8,  8, ROUTE_16_17_GATE_2F, 1

	def_coord_events
	coord_event  5,  3, 0, Route16GateBicycleCheck
	coord_event  5,  4, 0, Route16GateBicycleCheck
	coord_event  5,  5, 0, Route1617GateStepUpOneTrigger
	coord_event  5,  6, 0, Route1617GateStepUpTwoTrigger
	coord_event  5,  7, 0, Route1617GateStepUpThreeTrigger

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route1617GateOfficerText, -1

	object_const_def
	const ROUTE1617GATE_OFFICER

Route1617GateStepUpOneTrigger:
	checkkeyitem BICYCLE
	iftrue DoNothingScript
	applyonemovement PLAYER, step_up
	sjump UnknownScript_0x733f3

Route1617GateStepUpTwoTrigger:
	checkkeyitem BICYCLE
	iftrue DoNothingScript
	applymovement PLAYER, Route1617GateStepUpTwoMovementData
	sjump UnknownScript_0x733f3

Route1617GateStepUpThreeTrigger:
	checkkeyitem BICYCLE
	iftrue DoNothingScript
	applymovement PLAYER, Route1617GateStepUpThreeMovementData
	sjump UnknownScript_0x733f3

Route16GateBicycleCheck:
	checkkeyitem BICYCLE
	iftrue DoNothingScript
UnknownScript_0x733f3:
	showemote EMOTE_SHOCK, ROUTE1617GATE_OFFICER, 15
	turnobject PLAYER, UP
	showtext Route16GateCannotPassText
	applymovement PLAYER, Route16GateCannotPassMovement
	end

Route1617GateStepUpThreeMovementData:
	step_up
Route1617GateStepUpTwoMovementData:
	step_up
	step_up
	step_end

Route16GateCannotPassMovement:
	step_right
	turn_head_left
	step_end

Route1617GateOfficerText:
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

Route16GateCannotPassText:
	text "Hey! Whoa! Stop!"

	para "You can't go out"
	line "on the Cycling"

	para "Road without a"
	line "Bicycle."
	done
