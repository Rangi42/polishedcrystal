const_value set 2
	const VIOLETNICKNAMESPEECHHOUSE_TEACHER
	const VIOLETNICKNAMESPEECHHOUSE_LASS
	const VIOLETNICKNAMESPEECHHOUSE_EEVEE
	const VIOLETNICKNAMESPEECHHOUSE_GRAMPS

VioletNicknameSpeechHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TeacherScript_0x693e9:
	jumptextfaceplayer UnknownText_0x693fa

LassScript_0x693ec:
	jumptextfaceplayer UnknownText_0x6945e

VioletNicknameSpeechHouseGrampsScript:
	jumptextfaceplayer VioletNicknameSpeechHouseGrampsText

EeveeScript_0x693ef:
	faceplayer
	opentext
	writetext UnknownText_0x6947c
	cry EEVEE
	waitbutton
	closetext
	end

UnknownText_0x693fa:
	text "She uses the names"
	line "of her favorite"
	cont "things to eat."

	para "For the nicknames"
	line "she gives to her"
	cont "#mon, I mean."
	done

UnknownText_0x6945e:
	text "I call my Eevee"
	line "Strawberry!"
	done

VioletNicknameSpeechHouseGrampsText:
	text "The Zephyr Badge"
	line "is named after an"

	para "ancient god of the"
	line "west wind."

	para "Very fitting for a"
	line "Flying-type Gym."
	done

UnknownText_0x6947c:
	text "Strawberry: Eevee!"
	done

VioletNicknameSpeechHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $3, 4, VIOLET_CITY
	warp_def $7, $4, 4, VIOLET_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 4
	person_event SPRITE_TEACHER, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, TeacherScript_0x693e9, -1
	person_event SPRITE_LASS, 4, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, LassScript_0x693ec, -1
	person_event SPRITE_EEVEE, 2, 5, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, EeveeScript_0x693ef, -1
	person_event SPRITE_GRAMPS, 2, 0, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << NITE), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, VioletNicknameSpeechHouseGrampsScript, -1
