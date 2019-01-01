MrFujisHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, LAVENDER_TOWN, 2
	warp_event  3,  7, LAVENDER_TOWN, 2

	db 0 ; coord events

	db 0 ; bg events

	db 5 ; object events
	object_event  4,  1, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7e8f1, -1
	object_event  3,  4, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7e940, -1
	object_event  8,  4, SPRITE_PSYDUCK, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_POKEMON, PSYDUCK, MrFujisPsyduckText, -1
	object_event  5,  5, SPRITE_NIDORINO, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_POKEMON, NIDORINO, MrFujisNidorinoText, -1
	object_event  1,  3, SPRITE_PIDGEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_POKEMON, PIDGEY, MrFujisPidgeyText, -1

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
