PewterNidoranSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, PEWTER_CITY, 1
	warp_event  3,  7, PEWTER_CITY, 1

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  3,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a2814, -1
	object_event  4,  5, SPRITE_NIDORAN_M, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_POKEMON, NIDORAN_M, PewterNidoranText, -1

UnknownText_0x1a2814:
	text "Nidoran, shake!"
	done

PewterNidoranText:
	text "Nidoran: Gau gau!"
	done
