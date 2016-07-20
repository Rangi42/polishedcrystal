const_value set 2
	const ROUTE11GATE_OFFICER

Route11Gate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route11GateOfficerScript:
	jumptextfaceplayer Route11GateOfficerText

Route11GateOfficerText:
	text "When you catch"
	line "lots of #mon,"
	cont "isn't it hard to"
	cont "think up names?"

	para "In Lavender Town,"
	line "there's a man who"
	cont "rates #mon"
	cont "nicknames."

	para "He'll help you"
	line "rename them too!"
	done

Route11Gate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $4, $0, 1, ROUTE_11
	warp_def $5, $0, 2, ROUTE_11
	warp_def $4, $9, 2, ROUTE_12
	warp_def $5, $9, 3, ROUTE_12

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_OFFICER, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route11GateOfficerScript, -1
