VermilionMagnetTrainSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, VERMILION_CITY, 4
	warp_event  3,  7, VERMILION_CITY, 4

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  2,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x191ec0, -1
	object_event  0,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x191f16, -1

UnknownText_0x191ec0:
	text "Do you know about"
	line "the Magnet Train?"

	para "It's a railway"
	line "that goes to Gol-"
	cont "denrod in Johto."
	done

UnknownText_0x191f16:
	text "I want to go to"
	line "Saffron to see"
	cont "the Magnet Train."
	done
