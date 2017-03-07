const_value set 2
	const CERULEANCOUPLEHOUSE_POKEFAN_M
	const CERULEANCOUPLEHOUSE_POKEFAN_F

CeruleanCoupleHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeruleanCoupleHousePokefanMScript:
	jumptextfaceplayer CeruleanCoupleHousePokefanMText

CeruleanCoupleHousePokefanFScript:
	jumptextfaceplayer CeruleanCoupleHousePokefanFText

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

CeruleanCoupleHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 10, CERULEAN_CITY
	warp_def $7, $3, 10, CERULEAN_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_POKEFAN_M, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CeruleanCoupleHousePokefanMScript, -1
	person_event SPRITE_POKEFAN_F, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeruleanCoupleHousePokefanFScript, -1
