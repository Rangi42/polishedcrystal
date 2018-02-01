CeladonDevelopmentSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 16, CELADON_CITY
	warp_def 7, 3, 16, CELADON_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	person_event SPRITE_COOLTRAINER_M, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonDevelopmentSpeechHouseCooltrainermText, -1
	person_event SPRITE_BEAUTY, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonDevelopmentSpeechHouseBeautyText, -1

CeladonDevelopmentSpeechHouseCooltrainermText:
	text "Celadon has become"
	line "quite the tourist"
	cont "spot."

	para "The hotel's always"
	line "fully booked!"
	done

CeladonDevelopmentSpeechHouseBeautyText:
	text "This city used to"
	line "be a haven for"
	cont "Team Rocket."

	para "I was scared to"
	line "leave the house"
	cont "while they were"
	cont "lurking about!"
	done
