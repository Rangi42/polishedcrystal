Route5_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 4 ; warps
	warp_def 27, 17, 1, ROUTE_5_UNDERGROUND_ENTRANCE
	warp_def 31, 8, 1, ROUTE_5_SAFFRON_CITY_GATE
	warp_def 31, 9, 2, ROUTE_5_SAFFRON_CITY_GATE
	warp_def 21, 10, 1, ROUTE_5_CLEANSE_TAG_SPEECH_HOUSE

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 29, 17, SIGNPOST_JUMPTEXT, Route5UndergroundPathSignText

	db 1 ; person events
	person_event SPRITE_POKEFAN_M, 28, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, PokefanMScript_0x1adb19Text, EVENT_ROUTE_5_6_POKEFAN_M_BLOCKS_UNDERGROUND_PATH

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
