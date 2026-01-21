HiddenCaveGrotto_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, HiddenGrottoCallback
	callback MAPCALLBACK_TILES, HiddenCaveGrottoTileCallback

	def_warp_events
	warp_event  3,  9, HIDDEN_CAVE_GROTTO, -1

	def_coord_events

	def_bg_events
	bg_event  3,  3, BGEVENT_GROTTOITEM, HiddenGrottoHiddenItemScript

	def_object_events
	object_event  3,  3, SPRITE_GROTTO_MON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, HiddenGrottoPokemonScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  3,  3, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_POKE_BALL, OBJECTTYPE_SCRIPT, 0, HiddenGrottoItemScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

HiddenCaveGrottoTileCallback:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftruefwd .end
	changeblock 2, 2, $25
.end
	endcallback
