GoldenrodPPSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, GOLDENROD_CITY, 7
	warp_event  3,  7, GOLDENROD_CITY, 7

	db 0 ; coord events

	db 1 ; bg events
	bg_event  7,  1, SIGNPOST_JUMPSTD, radio2

	db 2 ; object events
	object_event  1,  4, SPRITE_FISHER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55659, -1
	object_event  5,  3, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 1, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x556ca, -1

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
