EcruteakShrineOutside_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  5, ECRUTEAK_SHRINE_INSIDE, 1
	warp_event  4, 14, ECRUTEAK_CITY, 4
	warp_event  5, 14, ECRUTEAK_CITY, 4
	warp_event  6, 14, ECRUTEAK_CITY, 5
	warp_event  7, 14, ECRUTEAK_CITY, 5

	def_coord_events

	def_bg_events
	bg_event  3, 10, BGEVENT_JUMPTEXT, EcruteakShrineOutsideStatueText
	bg_event  8, 10, BGEVENT_JUMPTEXT, EcruteakShrineOutsideStatueText

	def_object_events
	object_event  8,  6, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakShrineOutsideTwinText, -1
	pokemon_event  9,  6, HOOTHOOT, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BROWN, EcruteakShrineOutsideHoothootText, -1
	object_event  2, 12, SPRITE_SAGE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakShrineOutsideSageText, -1
	object_event  4, 14, SPRITE_CAMPFIRE, SPRITEMOVEDATA_ARCH_TREE_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_GREEN, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  7, 14, SPRITE_CAMPFIRE, SPRITEMOVEDATA_ARCH_TREE_RIGHT, 0, 0, -1, PAL_NPC_COPY_BG_GREEN, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  4, 18, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_ARCH_TREE_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_GREEN, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  7, 18, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_ARCH_TREE_RIGHT, 0, 0, -1, PAL_NPC_COPY_BG_GREEN, OBJECTTYPE_COMMAND, end, NULL, -1

EcruteakShrineOutsideTwinText:
	text "My Hoothoot's"
	line "Foresight helps"
	cont "shoo away ghosts."
	done

EcruteakShrineOutsideHoothootText:
	text "Hoothoot: Hoot!"
	done

EcruteakShrineOutsideSageText:
	text "On New Year's Eve,"
	line "people visit this"

	para "shrine and make"
	line "wishes for their"
	cont "future."
	done

EcruteakShrineOutsideStatueText:
	text "A #mon statue…"

	para "It looks very"
	line "serene."
	done
