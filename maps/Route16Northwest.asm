Route16Northwest_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  1,  1, ROUTE_16_FUCHSIA_SPEECH_HOUSE, 1
	warp_event  9,  4, ROUTE_16_GATE, 1
	warp_event  9,  5, ROUTE_16_GATE, 2

	def_coord_events

	def_bg_events

	def_object_events
	cuttree_event 17,  4, EVENT_ROUTE_16_CUT_TREE
