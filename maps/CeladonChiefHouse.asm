CeladonChiefHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CELADON_CITY, 10
	warp_event  3,  7, CELADON_CITY, 10

	db 0 ; coord events

	db 1 ; bg events
	bg_event  7,  1, SIGNPOST_ITEM + DUBIOUS_DISC, EVENT_CELADON_CHIEF_HOUSE_HIDDEN_DUBIOUS_DISC

	db 1 ; object events
	object_event  1,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonChiefHouseCooltrainerMText, -1

CeladonChiefHouseCooltrainerMText:
	text "The Game Corner is"
	line "making us a lot"
	cont "of money!"

	para "It's all legal,"
	line "too. Honestly!"
	done
