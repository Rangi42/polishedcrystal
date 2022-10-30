RuggedRoadNorth_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, RuggedRoadNorthBridgeCallback

	def_warp_events
	warp_event 10,  5, SNOWTOP_MOUNTAIN_INSIDE, 1
	warp_event 18, 16, HIDDEN_CAVE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event 18, 15, BGEVENT_JUMPSTD, cavegrotto, HIDDENGROTTO_RUGGED_ROAD_NORTH

	def_object_events

RuggedRoadNorthBridgeCallback:
	callasm .RuggedRoadSouthBridgeUnderfoot
	endcallback

.RuggedRoadSouthBridgeUnderfoot:
	ld a, $1
	ld [wWalkingOnBridge], a
	ld [wRuggedRoadSouthSceneID], a ; setscene a
	ret
