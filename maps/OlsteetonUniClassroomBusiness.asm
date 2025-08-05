OlsteetonUniClassroomBusiness_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  9, OLSTEETON_UNI_CLASSROOM_BLDG, 5
	warp_event  5,  9, OLSTEETON_UNI_CLASSROOM_BLDG, 5

	def_coord_events

	def_bg_events
	bg_event  1,  1, BGEVENT_JUMPTEXT, OlsteetonUniClassroomBusinessDirectoryText

	def_object_events
	object_event  6,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_CELADON_5F_1, -1
	object_event  5,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_CELADON_5F_2, -1
	object_event  2,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 1, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClassroomBusinessGentlemanText, -1
	object_event  8,  6, SPRITE_SAILOR, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClassroomBusinessSailorText, -1
	object_event 10,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClassroomBusinessTeacherText, -1

OlsteetonUniClassroomBusinessGentlemanText:
	text "I want to buy some"
	line "items that raise"

	para "#mon stats, but"
	line "I don't have"
	cont "enough money…"
	done

OlsteetonUniClassroomBusinessSailorText:
	text "I want PP Up, so I"
	line "can raise the PP"

	para "of moves. But you"
	line "can't buy it…"
	done

OlsteetonUniClassroomBusinessTeacherText:
	text "Using items on"
	line "them makes #-"
	cont "mon happy."

	para "They hate certain"
	line "items, though…"
	done

OlsteetonUniClassroomBusinessDirectoryText:
	text "Bring Out"
	line "#mon Potential"

	para "5F: Drug Store"
	done
