Route8SaffronGate_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 4 ; warps
	warp_def 4, 0, 14, SAFFRON_CITY
	warp_def 5, 0, 15, SAFFRON_CITY
	warp_def 4, 9, 1, ROUTE_8
	warp_def 5, 9, 2, ROUTE_8

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_OFFICER, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7f419, -1

UnknownText_0x7f419:
	text "Have you been to"
	line "Lavender Town?"

	para "There's a tall"
	line "Radio Tower there."
	done
