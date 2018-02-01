Route12Gate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event 4, 0, 1, ROUTE_12_NORTH
	warp_event 5, 0, 2, ROUTE_12_NORTH
	warp_event 4, 9, 4, ROUTE_12_SOUTH
	warp_event 5, 9, 4, ROUTE_12_SOUTH
	warp_event 8, 8, 1, ROUTE_12_GATE_2F

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 0, 5, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route12GateOfficerText, -1

Route12GateOfficerText:
	text "Silence Bridge got"
	line "its name from all"

	para "the people quietly"
	line "fishing on it."
	done
