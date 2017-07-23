const_value set 2
	const ROUTE1617GATE_OFFICER

Route1617Gate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

OfficerScript_0x733ea:
	jumptextfaceplayer UnknownText_0x73408

StepUpOneTrigger:
	checkitem BICYCLE
	iftrue DoNothingScript
	applymovement PLAYER, StepUpOneMovementData
	jump UnknownScript_0x733f3

StepUpTwoTrigger:
	checkitem BICYCLE
	iftrue DoNothingScript
	applymovement PLAYER, StepUpTwoMovementData
	jump UnknownScript_0x733f3

StepUpThreeTrigger:
	checkitem BICYCLE
	iftrue DoNothingScript
	applymovement PLAYER, StepUpThreeMovementData
	jump UnknownScript_0x733f3

UnknownScript_0x733ed:
	checkitem BICYCLE
	iftrue DoNothingScript
UnknownScript_0x733f3:
	showemote EMOTE_SHOCK, ROUTE1617GATE_OFFICER, 15
	spriteface PLAYER, UP
	opentext
	writetext UnknownText_0x73496
	waitbutton
	closetext
	applymovement PLAYER, MovementData_0x73405
DoNothingScript:
	end

MovementData_0x73405:
	step_right
	turn_head_left
	step_end

StepUpThreeMovementData:
	step_up
StepUpTwoMovementData:
	step_up
StepUpOneMovementData:
	step_up
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

Route1617Gate_MapEventHeader:
.Warps:
	db 5
	warp_def $5, $0, 1, ROUTE_16_SOUTH
	warp_def $6, $0, 2, ROUTE_16_SOUTH
	warp_def $5, $9, 1, ROUTE_16_NORTHEAST
	warp_def $6, $9, 2, ROUTE_16_NORTHEAST
	warp_def $8, $8, 1, ROUTE_16_17_GATE_2F

.XYTriggers:
	db 5
	xy_trigger 0, $3, $5, UnknownScript_0x733ed
	xy_trigger 0, $4, $5, UnknownScript_0x733ed
	xy_trigger 0, $5, $5, StepUpOneTrigger
	xy_trigger 0, $6, $5, StepUpTwoTrigger
	xy_trigger 0, $7, $5, StepUpThreeTrigger

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_OFFICER, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OfficerScript_0x733ea, -1
