Route31VioletGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 0, 4, 8, VIOLET_CITY
	warp_event 0, 5, 9, VIOLET_CITY
	warp_event 9, 4, 1, ROUTE_31
	warp_event 9, 5, 2, ROUTE_31

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event 5, 2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19763a, -1
	object_event 1, 2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x197661, -1

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
