GoldenrodPPSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 7, GOLDENROD_CITY
	warp_def 7, 3, 7, GOLDENROD_CITY

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 1, 7, SIGNPOST_JUMPSTD, radio2

	db 2 ; person events
	person_event SPRITE_FISHER, 4, 1, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55659, -1
	person_event SPRITE_LASS, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 1, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x556ca, -1

UnknownText_0x55659:
	text "Once while I was"
	line "battling, my"

	para "#mon couldn't"
	line "make any moves."

	para "The Power Points,"
	line "or PP, of its"

	para "moves were all"
	line "gone."
	done

UnknownText_0x556ca:
	text "Sometimes, a"
	line "healthy #mon"

	para "may be unable to"
	line "use its moves."

	para "If that happens,"
	line "heal it at a #-"
	cont "mon Center or use"
	cont "an item."
	done
