Route39RuggedRoadGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  0, RUGGED_ROAD_SOUTH, 1
	warp_event  5,  0, RUGGED_ROAD_SOUTH, 2
	warp_event  4,  7, ROUTE_39, 3
	warp_event  5,  7, ROUTE_39, 3

	def_coord_events
	coord_event  2,  4, 0, Route39RuggedRoadGateGoGogglesCheck
	coord_event  3,  4, 0, Route39RuggedRoadGateGoGogglesCheck
	coord_event  4,  4, 0, Route39RuggedRoadGateGoGogglesCheck
	coord_event  5,  4, 0, Route39RuggedRoadGateStepLeftOneTrigger
	coord_event  6,  4, 0, Route39RuggedRoadGateStepLeftTwoTrigger
	coord_event  7,  4, 0, Route39RuggedRoadGateStepLeftThreeTrigger

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route39RuggedRoadGateOfficerText, -1

	object_const_def
	const ROUTE39RUGGEDROADGATE_OFFICER

Route39RuggedRoadGateStepLeftThreeTrigger:
	checkkeyitem GO_GOGGLES
	iftrue DoNothingScript
	applymovement PLAYER, Route39RuggedRoadGateStepLeftThreeMovementData
	sjumpfwd Route39RuggedRoadGateCannotPassScript

Route39RuggedRoadGateStepLeftTwoTrigger:
	checkkeyitem GO_GOGGLES
	iftrue DoNothingScript
	applymovement PLAYER, Route39RuggedRoadGateStepLeftTwoMovementData
	sjumpfwd Route39RuggedRoadGateCannotPassScript

Route39RuggedRoadGateStepLeftOneTrigger:
	checkkeyitem GO_GOGGLES
	iftrue DoNothingScript
	applyonemovement PLAYER, step_left
	sjumpfwd Route39RuggedRoadGateCannotPassScript

Route39RuggedRoadGateGoGogglesCheck:
	checkkeyitem GO_GOGGLES
	iftrue DoNothingScript
Route39RuggedRoadGateCannotPassScript:
	showemote EMOTE_SHOCK, ROUTE39RUGGEDROADGATE_OFFICER, 15
	turnobject PLAYER, LEFT
	showtext Route39RuggedRoadGateOfficerCannotPassText
	applymovement PLAYER, Route39RuggedRoadGateCannotPassMovement
	end

Route39RuggedRoadGateStepLeftThreeMovementData:
	step_left
Route39RuggedRoadGateStepLeftTwoMovementData:
	step_left
	step_left
	step_end

Route39RuggedRoadGateCannotPassMovement:
	step_down
	turn_head_up
	step_end

Route39RuggedRoadGateOfficerCannotPassText:
	text "Whoa, where are"
	line "you going?"

	para "The Rugged Road to"
	line "Snowtop Mountain"
	cont "is really harsh!"

	para "I can't let you"
	line "risk it without"
	cont "any Go-Goggles."
	done

Route39RuggedRoadGateOfficerText:
	text "The trek to Snow-"
	line "top Mountain can"
	cont "be dangerous!"

	para "That's why a #-"
	line "mon Center was"
	cont "built there."
	done
