CeruleanTradeSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanTradeSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 3, CERULEAN_CITY
	warp_def 7, 3, 3, CERULEAN_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 4
	person_event SPRITE_GRANNY, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18814d, -1
	person_event SPRITE_GRAMPS, 2, 3, SPRITEMOVEDATA_WANDER, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18818a, -1
	person_event SPRITE_POLIWRATH, 2, 6, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_POKEMON, POLIWRATH, UnknownText_0x18819c, -1
	person_event SPRITE_CHANSEY, 6, 5, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEMON, CHANSEY, UnknownText_0x1881b5, -1

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
