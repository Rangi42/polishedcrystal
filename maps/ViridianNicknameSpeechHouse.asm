ViridianNicknameSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ViridianNicknameSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 2, VIRIDIAN_CITY
	warp_def 7, 3, 2, VIRIDIAN_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 4
	person_event SPRITE_POKEFAN_M, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9ae54, -1
	person_event SPRITE_TWIN, 4, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9aecb, -1
	person_event SPRITE_HOOTHOOT, 2, 5, SPRITEMOVEDATA_POKEMON, 0, 2, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_POKEMON, HOOTHOOT, HootyText, -1
	person_event SPRITE_RATTATA, 3, 6, SPRITEMOVEDATA_POKEMON, 0, 2, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_POKEMON, RATTATA, RatteyText, -1

UnknownText_0x9ae54:
	text "Do you put a lot"
	line "of thought into"

	para "naming your"
	line "#mon?"

	para "Giving them good"
	line "nicknames adds to"

	para "the fun of trading"
	line "with others."
	done

UnknownText_0x9aecb:
	text "They're Hooty--"
	line "a Hoothoot--and"
	cont "Rattey--a Rattata."
	done

HootyText:
	text "Hooty: Hoot!"
	done

RatteyText:
	text "Rattey: Kikiii!"
	done
