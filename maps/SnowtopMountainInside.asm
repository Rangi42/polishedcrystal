SnowtopMountainInside_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  9, 29, RUGGED_ROAD_NORTH, 1
	warp_event 27, 29, SNOWTOP_MOUNTAIN_OUTSIDE, 1
	warp_event 26,  4, HIDDEN_CAVE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event 26,  3, BGEVENT_JUMPSTD, cavegrotto, HIDDENGROTTO_SNOWTOP_MOUNTAIN_INSIDE

	def_object_events
