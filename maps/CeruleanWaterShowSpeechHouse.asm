CeruleanWaterShowSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanWaterShowSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 11, CERULEAN_CITY
	warp_def 7, 3, 11, CERULEAN_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_COOLTRAINER_M, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeruleanWaterShowSpeechHouseCooltrainerMText, EVENT_TRAINERS_IN_CERULEAN_GYM
	person_event SPRITE_SUPER_NERD, 3, 6, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeruleanWaterShowSpeechHouseSuperNerdText, -1

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
