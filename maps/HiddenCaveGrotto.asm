HiddenCaveGrotto_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, HiddenGrottoCallback

	def_warp_events
	warp_event 35, 85, HIDDEN_CAVE_GROTTO, -1

	def_coord_events

	def_bg_events
	bg_event 34, 74, BGEVENT_GROTTOITEM, HiddenGrottoHiddenItemScript

	def_object_events
	object_event 34, 74, SPRITE_GROTTO_MON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, HiddenGrottoPokemonScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 34, 74, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, HiddenGrottoItemScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
