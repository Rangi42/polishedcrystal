FuchsiaMart_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 1, FUCHSIA_CITY
	warp_def 7, 3, 1, FUCHSIA_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 3 ; person events
	mart_clerk_event 3, 1, MARTTYPE_STANDARD, MART_FUCHSIA
	person_event SPRITE_FISHER, 2, 3, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x195cf5, -1
	person_event SPRITE_COOLTRAINER_F, 6, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x195d36, -1

UnknownText_0x195cf5:
	text "I was hoping to"
	line "buy some Safari"

	para "Zone souvenirs,"
	line "but they're not"

	para "being sold any"
	line "more…"
	done

UnknownText_0x195d36:
	text "The Safari Zone"
	line "Warden's grand-"
	cont "daughter lives in"
	cont "town."
	done
