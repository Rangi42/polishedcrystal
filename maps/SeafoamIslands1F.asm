SeafoamIslands1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, SeafoamIslands1FClearRocks

	def_warp_events
	warp_event 15, 33, ROUTE_20, 1
	warp_event 15, 31, SEAFOAM_GYM, 1
	warp_event 12, 28, SEAFOAM_ISLANDS_B1F, 1
	warp_event  5,  5, ROUTE_20, 2
	warp_event  5,  3, SEAFOAM_ISLANDS_B1F, 2

	def_coord_events

	def_bg_events
	bg_event 17, 29, BGEVENT_ITEM + ESCAPE_ROPE, EVENT_SEAFOAM_ISLANDS_1F_HIDDEN_ESCAPE_ROPE

	def_object_events

SeafoamIslands1FClearRocks:
	setevent EVENT_CINNABAR_ROCKS_CLEARED
	endcallback
