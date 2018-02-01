CherrygroveEvolutionSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 5, CHERRYGROVE_CITY
	warp_def 7, 3, 5, CHERRYGROVE_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	person_event SPRITE_LASS, 5, 3, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, LassScript_0x196cb9, -1
	person_event SPRITE_YOUNGSTER, 5, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x196cb2, -1

YoungsterScript_0x196cb2:
	jumptext UnknownText_0x196cc3

LassScript_0x196cb9:
	jumptext UnknownText_0x196cfc

UnknownText_0x196cc3:
	text "#mon gain expe-"
	line "rience in battle"

	para "and change their"
	line "form."
	done

UnknownText_0x196cfc:
	text "#mon change?"

	para "I would be shocked"
	line "if one did that!"
	done
