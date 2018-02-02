CeruleanTradeSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CERULEAN_CITY, 3
	warp_event  3,  7, CERULEAN_CITY, 3

	db 0 ; coord events

	db 0 ; bg events

	db 4 ; object events
	object_event  2,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18814d, -1
	object_event  3,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18818a, -1
	object_event  6,  2, SPRITE_POLIWRATH, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_POKEMON, POLIWRATH, UnknownText_0x18819c, -1
	object_event  5,  6, SPRITE_CHANSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_POKEMON, CHANSEY, UnknownText_0x1881b5, -1

UnknownText_0x18814d:
	text "My husband lives"
	line "happily with #-"
	cont "mon he got through"
	cont "trades."
	done

UnknownText_0x18818a:
	text "Ah… I'm so happy…"
	done

UnknownText_0x18819c:
	text "Poliwrath: Ribbit!"
	done

UnknownText_0x1881b5:
	text "Chansey: Chaan"
	line "sey!"
	done
