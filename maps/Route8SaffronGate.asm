Route8SaffronGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 0, 4, 14, SAFFRON_CITY
	warp_event 0, 5, 15, SAFFRON_CITY
	warp_event 9, 4, 1, ROUTE_8
	warp_event 9, 5, 2, ROUTE_8

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 5, 1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7f419, -1

UnknownText_0x7f419:
	text "Have you been to"
	line "Lavender Town?"

	para "There's a tall"
	line "Radio Tower there."
	done
