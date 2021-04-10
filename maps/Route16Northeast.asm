Route16Northeast_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 16, 10, ROUTE_16_17_GATE, 3
	warp_event 16, 11, ROUTE_16_17_GATE, 4
	warp_event 14,  4, ROUTE_16_GATE, 3
	warp_event 14,  5, ROUTE_16_GATE, 4

	def_coord_events

	def_bg_events

	def_object_events
	cuttree_event 17,  4, EVENT_ROUTE_16_CUT_TREE
