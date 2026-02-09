Route39RuggedRoadGate_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_ROUTE39RUGGEDROADGATE_BICYCLE_CHECK

	def_callbacks

	def_warp_events
	warp_event  4,  0, RUGGED_ROAD_SOUTH, 1
	warp_event  5,  0, RUGGED_ROAD_SOUTH, 2
	warp_event  4,  7, ROUTE_39, 3
	warp_event  5,  7, ROUTE_39, 3

	def_coord_events
	coord_event  2,  4, SCENE_ROUTE39RUGGEDROADGATE_BICYCLE_CHECK, Route39RuggedRoadGateGoGogglesCheck
	coord_event  3,  4, SCENE_ROUTE39RUGGEDROADGATE_BICYCLE_CHECK, Route39RuggedRoadGateGoGogglesCheck
	coord_event  4,  4, SCENE_ROUTE39RUGGEDROADGATE_BICYCLE_CHECK, Route39RuggedRoadGateGoGogglesCheck
	coord_event  5,  4, SCENE_ROUTE39RUGGEDROADGATE_BICYCLE_CHECK, Route39RuggedRoadGateStepLeftOneTrigger
	coord_event  6,  4, SCENE_ROUTE39RUGGEDROADGATE_BICYCLE_CHECK, Route39RuggedRoadGateStepLeftTwoTrigger
	coord_event  7,  4, SCENE_ROUTE39RUGGEDROADGATE_BICYCLE_CHECK, Route39RuggedRoadGateStepLeftThreeTrigger

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route39RuggedRoadGateOfficerText, -1
	object_event  7,  5, SPRITE_BEACH_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route39RuggedRoadGateSwimmerScript, -1

	object_const_def
	const ROUTE39RUGGEDROADGATE_OFFICER

Route39RuggedRoadGateSwimmerScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_RARE_CANDY_FROM_RUGGED_ROAD_GATE
	iftrue_jumpopenedtext .LovelyDay
	writetext .BadDay
	checkkeyitem GO_GOGGLES
	iffalse_endtext
	writetext .FoundGoggles
	verbosegiveitem RARE_CANDY
	iffalse_jumpopenedtext .NoRoom
	setevent EVENT_GOT_RARE_CANDY_FROM_RUGGED_ROAD_GATE
	jumpopenedtext .ThanksAgain

.LovelyDay:
	text "Lovely day today,"
	line "isn't it?"

	para "I heard that the"
	line "mountaintop view"
	cont "is great!"
	done

.BadDay:
	text "Argh! A boat guard"
	line "chased me off the"

	para "harbor when I swam"
	line "near the boat."

	para "And I lost my Go-"
	line "Goggles too…"

	para "Man, this is not"
	line "my day!"
	prompt

.FoundGoggles:
	text "Oh, you found"
	line "them!"

	para "I already bought"
	line "new ones, though…"

	para "Here, take this as"
	line "thanks!"
	prompt

.NoRoom:
	text "Uh-oh, your Bag"
	line "looks rather full…"
	done

.ThanksAgain:
	text "Keep the goggles."
	line "Thanks again!"
	done

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
