RuggedRoad_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, RuggedRoadTileScript

	def_warp_events
	warp_event 15, 51, ROUTE_39_RUGGED_ROAD_GATE, 1
	warp_event 16, 51, ROUTE_39_RUGGED_ROAD_GATE, 2
	warp_event 10,  5, SNOWTOP_MOUNTAIN, 1
	warp_event 18, 16, HIDDEN_CAVE_GROTTO, 1

	def_coord_events
	coord_event 27, 21, 1, RuggedRoadBridgeOverheadTrigger
	coord_event 27, 19, 0, RuggedRoadBridgeUnderfootTrigger

	def_bg_events
	bg_event 18, 15, BGEVENT_JUMPSTD, cavegrotto, HIDDENGROTTO_RUGGED_ROAD

	def_object_events

RuggedRoadTileScript:
	checkscene
	iftruefwd .underfoot
	callasm RuggedRoad_OverheadBridgeAsm
	endcallback

.underfoot:
	callasm RuggedRoad_UnderfootBridgeAsm
	endcallback

RuggedRoad_OverheadBridgeAsm:
	changebridgeblock 14, 18, $e9, RUGGED_ROAD
	changebridgeblock 16, 18, $95, RUGGED_ROAD
	changebridgeblock 18, 18, $95, RUGGED_ROAD
	changebridgeblock 20, 18, $95, RUGGED_ROAD
	changebridgeblock 22, 18, $ea, RUGGED_ROAD
	jmp BufferScreen

RuggedRoad_UnderfootBridgeAsm:
	changebridgeblock 14, 18, $aa, RUGGED_ROAD
	changebridgeblock 16, 18, $e6, RUGGED_ROAD
	changebridgeblock 18, 18, $e6, RUGGED_ROAD
	changebridgeblock 20, 18, $e6, RUGGED_ROAD
	changebridgeblock 22, 18, $ab, RUGGED_ROAD
	jmp BufferScreen

RuggedRoadBridgeOverheadTrigger:
	callasm RuggedRoad_OverheadBridgeAsm
	callthisasm
	xor a
	jr RuggedRoad_FinishBridge

RuggedRoadBridgeUnderfootTrigger:
	callasm RuggedRoad_UnderfootBridgeAsm
	callthisasm
	ld a, $1
RuggedRoad_FinishBridge:
	ld [wWalkingOnBridge], a
	ld [wRuggedRoadSceneID], a ; setscene a
	jmp GenericFinishBridge
