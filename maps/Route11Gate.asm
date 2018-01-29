Route11Gate_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Route11Gate_MapEventHeader:
	db 5 ; warps
	warp_def 5, 0, 1, ROUTE_11
	warp_def 6, 0, 2, ROUTE_11
	warp_def 5, 9, 2, ROUTE_12_SOUTH
	warp_def 6, 9, 3, ROUTE_12_SOUTH
	warp_def 8, 8, 1, ROUTE_11_GATE_2F

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
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
