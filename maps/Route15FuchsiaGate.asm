Route15FuchsiaGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event 0, 5, 7, FUCHSIA_CITY
	warp_event 0, 6, 8, FUCHSIA_CITY
	warp_event 9, 5, 1, ROUTE_15
	warp_event 9, 6, 2, ROUTE_15
	warp_event 8, 8, 1, ROUTE_15_FUCHSIA_GATE_2F

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 5, 1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1967a1, -1

UnknownText_0x1967a1:
	text "You're working on"
	line "a #dex? That's"

	para "really something."
	line "Don't give up!"
	done
