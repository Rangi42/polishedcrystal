Route31VioletGate_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Route31VioletGate_MapEventHeader:
	db 4 ; warps
	warp_def 4, 0, 8, VIOLET_CITY
	warp_def 5, 0, 9, VIOLET_CITY
	warp_def 4, 9, 1, ROUTE_31
	warp_def 5, 9, 2, ROUTE_31

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	person_event SPRITE_OFFICER, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19763a, -1
	person_event SPRITE_COOLTRAINER_F, 2, 1, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x197661, -1

UnknownText_0x19763a:
	text "Hi there!"
	line "Did you visit"
	cont "Sprout Tower?"
	done

UnknownText_0x197661:
	text "I came too far"
	line "out. I'd better"
	cont "phone home!"
	done
