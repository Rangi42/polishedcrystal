Route2946Gate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 4, 0, 1, ROUTE_46
	warp_event 5, 0, 2, ROUTE_46
	warp_event 4, 7, 1, ROUTE_29
	warp_event 5, 7, 1, ROUTE_29

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event 0, 4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7b5c1, -1
	object_event 6, 4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7b60d, -1

UnknownText_0x7b5c1:
	text "You can't climb"
	line "ledges."

	para "But you can jump"
	line "down from them to"
	cont "take a shortcut."
	done

UnknownText_0x7b60d:
	text "Different kinds of"
	line "#mon appear"
	cont "past here."

	para "If you want to"
	line "catch them all,"

	para "you have to look"
	line "everywhere."
	done
