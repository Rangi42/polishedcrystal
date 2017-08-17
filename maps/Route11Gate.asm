Route11Gate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route11Gate_MapEventHeader:

.Warps: db 5
	warp_def 5, 0, 1, ROUTE_11
	warp_def 6, 0, 2, ROUTE_11
	warp_def 5, 9, 2, ROUTE_12_SOUTH
	warp_def 6, 9, 3, ROUTE_12_SOUTH
	warp_def 8, 8, 1, ROUTE_11_GATE_2F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_OFFICER, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route11GateOfficerText, -1

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
