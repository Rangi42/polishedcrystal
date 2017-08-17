VioletOnixTradeHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VioletOnixTradeHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 3, 6, VIOLET_CITY
	warp_def 7, 4, 6, VIOLET_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_POKEFAN_M, 3, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x69997, -1
	person_event SPRITE_YOUNGSTER, 5, 6, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, trade, TRADE_WITH_KYLE_FOR_VOLTORB, -1

UnknownText_0x69997:
	text "A #mon you get"
	line "in a trade grows"
	cont "quickly."

	para "But if you don't"
	line "have the right Gym"

	para "Badge, they may"
	line "disobey you."
	done
