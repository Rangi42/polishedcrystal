Route36VioletGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route36VioletGate_MapEventHeader:

.Warps: db 4
	warp_def 4, 0, 5, ROUTE_36
	warp_def 5, 0, 6, ROUTE_36
	warp_def 4, 9, 10, VIOLET_CITY
	warp_def 5, 9, 11, VIOLET_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_OFFICER, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route36VioletGateOfficerScript, -1
	person_event SPRITE_YOUNGSTER, 5, 5, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route36VioletGateYoungsterText, -1

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
