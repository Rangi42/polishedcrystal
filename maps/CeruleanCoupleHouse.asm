CeruleanCoupleHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 10, CERULEAN_CITY
	warp_def 7, 3, 10, CERULEAN_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	person_event SPRITE_POKEFAN_M, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeruleanCoupleHousePokefanMText, -1
	person_event SPRITE_POKEFAN_F, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeruleanCoupleHousePokefanFText, -1

CeruleanCoupleHousePokefanMText:
	text "I first met my"
	line "dear wife in this"
	cont "city."

	para "Her eyes were a"
	line "deep cerulean…"
	done

CeruleanCoupleHousePokefanFText:
	text "The language of"
	line "love needs no"
	cont "translation."

	para "You'll under-"
	line "stand some day."
	done
