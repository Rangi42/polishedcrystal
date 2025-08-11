OlsteetonGymHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, OLSTEETON, 20
	warp_event  3,  7, OLSTEETON, 20

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonGymHouseEngineerText, -1
	object_event  8,  2, SPRITE_ENGINEER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonGymRoughneckText, -1
	object_event  5,  5, SPRITE_VETERAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonGymVeteranText, -1
	pokemon_event  4,  5, MAGNETON, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_GRAY, OlsteetonMagnetonText, -1


OlsteetonGymHouseEngineerText:
	text "I once chall-"
	line "enged Rusty to"

	para "a battle after"
	line "work. My poor"
	cont "Maggie didn't"
	cont "stand a chance."
	done

OlsteetonGymRoughneckText:
	text "When the mill,"
	line "shut down"
	cont "I didn't know"
	cont "what to do."

	para "But Rusty rallied"
	line "the crew into"

	para "fixing up the"
	line "old town gym!"
	done

OlsteetonGymVeteranText:
	text "Rusty may be"
	line "harder headed"
	cont "than a Steelix,"

	para "But he's a good"
	line "leader and a"
	cont "loyal friend."
	done

OlsteetonMagnetonText:
	text "Maggie: Bzzrt"
	done
