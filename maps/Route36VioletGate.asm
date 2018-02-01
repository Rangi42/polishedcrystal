Route36VioletGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 0, 4, 5, ROUTE_36
	warp_event 0, 5, 6, ROUTE_36
	warp_event 9, 4, 10, VIOLET_CITY
	warp_event 9, 5, 11, VIOLET_CITY

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event 5, 2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route36VioletGateOfficerScript, -1
	object_event 5, 5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route36VioletGateYoungsterText, -1

Route36VioletGateOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .ClearedSudowoodo
	jumpopenedtext Route36VioletGateOfficerText1

.ClearedSudowoodo
	jumpopenedtext Route36VioletGateOfficerText2

Route36VioletGateOfficerText1:
	text "Lately, I don't"
	line "see people coming"

	para "from Goldenrod"
	line "City."
	done

Route36VioletGateOfficerText2:
	text "Things are busy"
	line "lately, because"

	para "many people are"
	line "coming from"

	para "Goldenrod and"
	line "Ecruteak!"
	done

Route36VioletGateYoungsterText:
	text "Plants are living"
	line "things too!"

	para "They would want to"
	line "move around from"
	cont "time to time!"
	done
