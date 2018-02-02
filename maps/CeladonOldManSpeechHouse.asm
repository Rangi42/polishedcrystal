CeladonOldManSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CELADON_CITY, 15
	warp_event  3,  7, CELADON_CITY, 15

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonOldManSpeechHouseGrampsText, -1
	object_event  5,  4, SPRITE_LADY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonOldManSpeechHouseLadyText, -1

CeladonOldManSpeechHouseGrampsText:
	text "Whashat?"
	line "#-mon?"
	cont "Never heard of it."
	done

CeladonOldManSpeechHouseLadyText:
	text "I'm sorry about"
	line "my grandpa."

	para "Age hasn't been"
	line "kind to him."
	done
