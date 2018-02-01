CeladonOldManSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 15, CELADON_CITY
	warp_def 7, 3, 15, CELADON_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	person_event SPRITE_GRAMPS, 3, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonOldManSpeechHouseGrampsText, -1
	person_event SPRITE_LADY, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonOldManSpeechHouseLadyText, -1

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
