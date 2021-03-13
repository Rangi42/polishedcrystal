MrFujisHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, LAVENDER_TOWN, 2
	warp_event  3,  7, LAVENDER_TOWN, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  1, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, MrFujisHouseSuperNerdText, -1
	object_event  3,  4, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, MrFujisHouseLassText, -1
	pokemon_event  8,  4, PSYDUCK, -1, -1, PAL_NPC_BROWN, MrFujisPsyduckText, -1
	pokemon_event  5,  5, NIDORINO, -1, -1, PAL_NPC_PURPLE, MrFujisNidorinoText, -1
	pokemon_event  1,  3, PIDGEY, -1, -1, PAL_NPC_BROWN, MrFujisPidgeyText, -1

MrFujisHouseSuperNerdText:
	text "Mr.Fuji does live"
	line "here, but he's not"
	cont "home now."

	para "He might be at the"
	line "House of Souls."
	done

MrFujisHouseLassText:
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
