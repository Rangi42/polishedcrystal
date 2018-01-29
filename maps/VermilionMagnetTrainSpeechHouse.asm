VermilionMagnetTrainSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

VermilionMagnetTrainSpeechHouse_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 4, VERMILION_CITY
	warp_def 7, 3, 4, VERMILION_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	person_event SPRITE_POKEFAN_F, 3, 2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x191ec0, -1
	person_event SPRITE_YOUNGSTER, 3, 0, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x191f16, -1

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
