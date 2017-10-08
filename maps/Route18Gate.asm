Route18Gate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route18Gate_MapEventHeader:

.Warps: db 5
	warp_def 5, 0, 1, ROUTE_18_WEST
	warp_def 6, 0, 2, ROUTE_18_WEST
	warp_def 5, 9, 1, ROUTE_18_EAST
	warp_def 6, 9, 2, ROUTE_18_EAST
	warp_def 8, 8, 1, ROUTE_18_GATE_2F

.XYTriggers: db 5
	xy_trigger 0, 3, 5, UnknownScript_0x73611
	xy_trigger 0, 4, 5, UnknownScript_0x73611
	xy_trigger 0, 5, 5, Route18GateStepUpOneTrigger
	xy_trigger 0, 6, 5, Route18GateStepUpTwoTrigger
	xy_trigger 0, 7, 5, Route18GateStepUpThreeTrigger

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_OFFICER, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7362c, -1

const_value set 1
	const ROUTE18GATE_OFFICER

Route18GateStepUpOneTrigger:
	checkitem BICYCLE
	iftrue Route18GateDoNothingScript
	applyonemovement PLAYER, step_up
	jump UnknownScript_0x73617

Route18GateStepUpTwoTrigger:
	checkitem BICYCLE
	iftrue Route18GateDoNothingScript
	applymovement PLAYER, Route18GateStepUpTwoMovementData
	jump UnknownScript_0x73617

Route18GateStepUpThreeTrigger:
	checkitem BICYCLE
	iftrue Route18GateDoNothingScript
	applymovement PLAYER, Route18GateStepUpThreeMovementData
	jump UnknownScript_0x73617

UnknownScript_0x73611:
	checkitem BICYCLE
	iftrue Route18GateDoNothingScript
UnknownScript_0x73617:
	showemote EMOTE_SHOCK, ROUTE18GATE_OFFICER, 15
	spriteface PLAYER, UP
	showtext UnknownText_0x7364d
	applymovement PLAYER, MovementData_0x73629
Route18GateDoNothingScript
	end

Route18GateStepUpThreeMovementData:
	step_up
Route18GateStepUpTwoMovementData:
	step_up
	step_up
	step_end

MovementData_0x73629:
	step_right
	turn_head_left
	step_end

UnknownText_0x7362c:
	text "Cycling Road"
	line "starts going"
	cont "uphill here."
	done

UnknownText_0x7364d:
	text "Hang on! Don't you"
	line "have a Bicycle?"

	para "The Cycling Road"
	line "is beyond here."

	para "You have to have a"
	line "Bicycle to go on."
	done
