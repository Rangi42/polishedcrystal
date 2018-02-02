VioletNicknameSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  3,  7, VIOLET_CITY, 4
	warp_event  4,  7, VIOLET_CITY, 4

	db 0 ; coord events

	db 0 ; bg events

	db 4 ; object events
	object_event  2,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x693fa, -1
	object_event  6,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x6945e, -1
	object_event  5,  2, SPRITE_EEVEE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, EeveeScript_0x693ef, -1
	object_event  0,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << NITE), PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, VioletNicknameSpeechHouseGrampsText, -1

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
