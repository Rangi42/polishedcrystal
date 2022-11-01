RuggedRoadSouth_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, RuggedRoadSouthTileScript

	def_warp_events
	warp_event 15, 33, ROUTE_39_RUGGED_ROAD_GATE, 1
	warp_event 16, 33, ROUTE_39_RUGGED_ROAD_GATE, 2

	def_coord_events
	coord_event 27,  3, 1, RuggedRoadSouthBridgeOverheadTrigger
	coord_event 27,  1, 0, RuggedRoadSouthBridgeUnderfootTrigger

	def_bg_events
	bg_event 17, 25, BGEVENT_JUMPTEXT, RuggedRoadSouthAdvancedTipsSignText

	def_object_events

RuggedRoadSouthTileScript:
	checkscene
	iftruefwd .underfoot
	callasm RuggedRoadSouth_OverheadBridgeAsm
	endcallback

.underfoot:
	callasm RuggedRoadSouth_UnderfootBridgeAsm
	endcallback

RuggedRoadSouth_OverheadBridgeAsm:
	changebridgeblock 14, 0, $e9, RUGGED_ROAD_SOUTH
	changebridgeblock 16, 0, $95, RUGGED_ROAD_SOUTH
	changebridgeblock 18, 0, $95, RUGGED_ROAD_SOUTH
	changebridgeblock 20, 0, $95, RUGGED_ROAD_SOUTH
	changebridgeblock 22, 0, $ea, RUGGED_ROAD_SOUTH
	jmp BufferScreen

RuggedRoadSouth_UnderfootBridgeAsm:
	changebridgeblock 14, 0, $aa, RUGGED_ROAD_SOUTH
	changebridgeblock 16, 0, $e6, RUGGED_ROAD_SOUTH
	changebridgeblock 18, 0, $e6, RUGGED_ROAD_SOUTH
	changebridgeblock 20, 0, $e6, RUGGED_ROAD_SOUTH
	changebridgeblock 22, 0, $ab, RUGGED_ROAD_SOUTH
	jmp BufferScreen

RuggedRoadSouthBridgeOverheadTrigger:
	callasm RuggedRoadSouth_OverheadBridgeAsm
	callthisasm
	xor a
	jr RuggedRoadSouth_FinishBridge

RuggedRoadSouthBridgeUnderfootTrigger:
	callasm RuggedRoadSouth_UnderfootBridgeAsm
	callthisasm
	ld a, $1
RuggedRoadSouth_FinishBridge:
	ld [wWalkingOnBridge], a
	ld [wRuggedRoadSouthSceneID], a ; setscene a
	jmp GenericFinishBridge

RuggedRoadSouthAdvancedTipsSignText:
	text "Advanced Tips!"

	para "“Power” items that"
	line "raise effort gain"

	para "will apply to"
	line "every #mon that"

	para "participates in a"
	line "battle, as long as"

	para "the #mon which"
	line "actively KOs its"

	para "opponent is hold-"
	line "ing a Power item!"
	done
