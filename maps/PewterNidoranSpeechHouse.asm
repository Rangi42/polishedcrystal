PewterNidoranSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 1, PEWTER_CITY
	warp_def 7, 3, 1, PEWTER_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	person_event SPRITE_SUPER_NERD, 5, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a2814, -1
	person_event SPRITE_NIDORAN_M, 5, 4, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_POKEMON, NIDORAN_M, PewterNidoranText, -1

UnknownText_0x1a2814:
	text "Nidoran, shake!"
	done

PewterNidoranText:
	text "Nidoran: Gau gau!"
	done
