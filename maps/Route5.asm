Route5_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 17, 27, 1, ROUTE_5_UNDERGROUND_ENTRANCE
	warp_event 8, 31, 1, ROUTE_5_SAFFRON_CITY_GATE
	warp_event 9, 31, 2, ROUTE_5_SAFFRON_CITY_GATE
	warp_event 10, 21, 1, ROUTE_5_CLEANSE_TAG_SPEECH_HOUSE

	db 0 ; coord events

	db 1 ; bg events
	bg_event 17, 29, SIGNPOST_JUMPTEXT, Route5UndergroundPathSignText

	db 1 ; object events
	object_event 17, 28, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, PokefanMScript_0x1adb19Text, EVENT_ROUTE_5_6_POKEFAN_M_BLOCKS_UNDERGROUND_PATH

PokefanMScript_0x1adb19Text:
	text "The road is closed"
	line "until the problem"

	para "at the Power Plant"
	line "is solved."
	done

Route5UndergroundPathSignText:
	text "Underground Path"

	para "Cerulean City -"
	line "Vermilion City"
	done
