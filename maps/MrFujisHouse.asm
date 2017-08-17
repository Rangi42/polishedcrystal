MrFujisHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MrFujisHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 2, LAVENDER_TOWN
	warp_def 7, 3, 2, LAVENDER_TOWN

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 5
	person_event SPRITE_SUPER_NERD, 1, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7e8f1, -1
	person_event SPRITE_LASS, 4, 3, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7e940, -1
	person_event SPRITE_PSYDUCK, 4, 8, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_POKEMON, PSYDUCK, MrFujisPsyduckText, -1
	person_event SPRITE_NIDORINO, 5, 5, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_POKEMON, NIDORINO, MrFujisNidorinoText, -1
	person_event SPRITE_PIDGEY, 3, 1, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_POKEMON, PIDGEY, MrFujisPidgeyText, -1

UnknownText_0x7e8f1:
	text "Mr.Fuji does live"
	line "here, but he's not"
	cont "home now."

	para "He should be at"
	line "the House of"
	cont "Memories."
	done

UnknownText_0x7e940:
	text "Some cold-hearted"
	line "people stop caring"
	cont "for their #mon."

	para "Grandpa takes in"
	line "the poor homeless"

	para "#mon and takes"
	line "care of them."
	done

MrFujisPsyduckText:
	text "Psyduck: Gu-guwa?"
	done

MrFujisNidorinoText:
	text "Nidorino: Gyun!"
	done

MrFujisPidgeyText:
	text "Pidgey: Pijji!"
	done
