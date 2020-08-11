RockTunnel2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 25, 19, ROUTE_10_NORTH, 3
	warp_event  7, 15, ROCK_TUNNEL_1F, 8

	def_coord_events

	def_bg_events
	bg_event 15, 19, BGEVENT_ITEM + MAX_ETHER, EVENT_ROCK_TUNNEL_2F_HIDDEN_MAX_ETHER

	def_object_events
	object_event  8, 12, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RockTunnel2FElectrode, EVENT_ROCK_TUNNEL_2F_ELECTRODE
	itemball_event  2, 23, THUNDERSTONE, 1, EVENT_ROCK_TUNNEL_2F_THUNDERSTONE
	tmhmball_event 25,  9, TM_THUNDER_WAVE, EVENT_ROCK_TUNNEL_2F_TM_THUNDER_WAVE
	itemball_event 21,  3, ELECTIRIZER, 1, EVENT_ROCK_TUNNEL_2F_ELECTIRIZER
	strengthboulder_event 12, 2
	strengthboulder_event 12, 3
	strengthboulder_event 13, 3
	object_event  1,  5, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, DoNothingScript, -1
	object_event  1, 19, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, DoNothingScript, -1
	object_event 13,  9, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, DoNothingScript, -1
	object_event 13, 18, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, DoNothingScript, -1
	object_event 16,  6, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, DoNothingScript, -1
	object_event 18, 13, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, DoNothingScript, -1
	object_event 28, 15, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, DoNothingScript, -1
	object_event 22, 22, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, DoNothingScript, -1

RockTunnel2FElectrode:
	cry ELECTRODE
	loadwildmon ELECTRODE, 50
	startbattle
	disappear LAST_TALKED
	reloadmapafterbattle
	end
