Route2946Gate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route2946Gate_MapEventHeader:

.Warps: db 4
	warp_def 0, 4, 1, ROUTE_46
	warp_def 0, 5, 2, ROUTE_46
	warp_def 7, 4, 1, ROUTE_29
	warp_def 7, 5, 1, ROUTE_29

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7b5c1, -1
	person_event SPRITE_YOUNGSTER, 4, 6, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7b60d, -1

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
