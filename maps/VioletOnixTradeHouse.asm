VioletOnixTradeHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  3,  7, VIOLET_CITY, 6
	warp_event  4,  7, VIOLET_CITY, 6

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x69997, -1
	object_event  6,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, trade, TRADE_WITH_KYLE_FOR_VOLTORB, -1

UnknownText_0x69997:
	text "A #mon you get"
	line "in a trade grows"
	cont "quickly."

	para "But if you don't"
	line "have the right Gym"

	para "Badge, they may"
	line "disobey you."
	done
