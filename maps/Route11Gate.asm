Route11Gate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event  0,  5, ROUTE_11, 1
	warp_event  0,  6, ROUTE_11, 2
	warp_event  9,  5, ROUTE_12_SOUTH, 2
	warp_event  9,  6, ROUTE_12_SOUTH, 3
	warp_event  8,  8, ROUTE_11_GATE_2F, 1

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  5,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route11GateOfficerText, -1

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
