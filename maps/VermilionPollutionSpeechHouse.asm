VermilionPollutionSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, VERMILION_CITY, 13
	warp_event  3,  7, VERMILION_CITY, 13

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  1,  4, SPRITE_BREEDER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionPollutionSpeechHouseBreederText, -1
	object_event  5,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 1, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionPollutionSpeechHouseCooltrainerMText, -1

VermilionPollutionSpeechHouseBreederText:
	text "Vermilion is a"
	line "wonderful place,"

	para "but in a port like"
	line "this we have to be"
	cont "wary of pollution!"
	done

VermilionPollutionSpeechHouseCooltrainerMText:
	text "Thanks to the all"
	line "the cruise ships"
	cont "that come and go,"

	para "we get visitors"
	line "from all over!"
	done
