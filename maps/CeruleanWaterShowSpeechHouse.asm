CeruleanWaterShowSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CERULEAN_CITY, 11
	warp_event  3,  7, CERULEAN_CITY, 11

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  2,  4, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeruleanWaterShowSpeechHouseCooltrainerMText, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  6,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeruleanWaterShowSpeechHouseSuperNerdText, -1

CeruleanWaterShowSpeechHouseCooltrainerMText:
	text "Misty sometimes"
	line "performs in water"
	cont "shows at her Gym."

	para "They're a sight to"
	line "behold!"
	done

CeruleanWaterShowSpeechHouseSuperNerdText:
	text "I drew some graff-"
	line "iti on the roof of"
	cont "Celadon Mansion."

	para "Have you seen it?"
	line "It's a bit hidden,"
	cont "hehe…"
	done
