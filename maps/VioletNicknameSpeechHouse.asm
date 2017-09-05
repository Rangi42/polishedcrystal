VioletNicknameSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VioletNicknameSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 3, 4, VIOLET_CITY
	warp_def 7, 4, 4, VIOLET_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 4
	person_event SPRITE_TEACHER, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x693fa, -1
	person_event SPRITE_TWIN, 4, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x6945e, -1
	person_event SPRITE_EEVEE, 2, 5, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, EeveeScript_0x693ef, -1
	person_event SPRITE_GRAMPS, 2, 0, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << NITE), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, VioletNicknameSpeechHouseGrampsText, -1

EeveeScript_0x693ef:
	faceplayer
	showcrytext UnknownText_0x6947c, EEVEE
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
