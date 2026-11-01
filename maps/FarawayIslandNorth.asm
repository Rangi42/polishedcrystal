FarawayIslandNorth_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 22,  8, FARAWAY_JUNGLE, 1
	warp_event 23,  8, FARAWAY_JUNGLE, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event 30, 26, SPRITE_PEARL, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, PAL_NPC_FARAWAY_ROCK, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 22, 34, SPRITE_PEARL, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, PAL_NPC_FARAWAY_ROCK, OBJECTTYPE_COMMAND, end, NULL, -1

	object_const_def
