ScaryCaveB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5, 19, SCARY_CAVE_1F, 3
	warp_event 19,  3, SCARY_CAVE_1F, 4

	def_coord_events

	def_bg_events

	def_object_events
	itemball_event  2, 15, BIG_NUGGET, 1, EVENT_SCARY_CAVE_B1F_BIG_NUGGET
	itemball_event 21, 19, BLACK_SLUDGE, 1, EVENT_SCARY_CAVE_B1F_BLACK_SLUDGE

