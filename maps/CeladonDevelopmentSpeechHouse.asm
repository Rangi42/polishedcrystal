const_value set 2
	const CELADONDEVELOPMENTSPEECHHOUSE_COOLTRAINER_M
	const CELADONDEVELOPMENTSPEECHHOUSE_BEAUTY

CeladonDevelopmentSpeechHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonDevelopmentSpeechHouseCooltrainermScript:
	jumptextfaceplayer CeladonDevelopmentSpeechHouseCooltrainermText

CeladonDevelopmentSpeechHouseBeautyScript:
	jumptextfaceplayer CeladonDevelopmentSpeechHouseBeautyText

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

CeladonDevelopmentSpeechHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 16, CELADON_CITY
	warp_def $7, $3, 16, CELADON_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_COOLTRAINER_M, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CeladonDevelopmentSpeechHouseCooltrainermScript, -1
	person_event SPRITE_BEAUTY, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonDevelopmentSpeechHouseBeautyScript, -1
