CeruleanPoliceStation_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanPoliceStation_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 2, CERULEAN_CITY
	warp_def 7, 3, 2, CERULEAN_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_FISHING_GURU, 1, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18805a, -1
	person_event SPRITE_POKEFAN_F, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1880c3, -1
	person_event SPRITE_DIGLETT, 5, 3, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_POKEMON, DIGLETT, CeruleanDiglettText, -1

UnknownText_0x18805a:
	text "I heard that some"
	line "shady character is"
	cont "skulking about."

	para "I won't stand for"
	line "it if he turns out"
	cont "to be a thief."
	done

UnknownText_0x1880c3:
	text "We were held up by"
	line "robbers before."
	done

CeruleanDiglettText:
	text "Diglett: Dug dug."
	done
