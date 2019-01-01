CeruleanCoupleHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CERULEAN_CITY, 10
	warp_event  3,  7, CERULEAN_CITY, 10

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  5,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeruleanCoupleHousePokefanMText, -1
	object_event  2,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeruleanCoupleHousePokefanFText, -1

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
