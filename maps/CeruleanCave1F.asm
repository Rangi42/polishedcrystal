CeruleanCave1F_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_CERULEANCAVE1F_BRIDGE_UNDERFOOT
	scene_const SCENE_CERULEANCAVE1F_BRIDGE_OVERHEAD

	def_callbacks
	callback MAPCALLBACK_TILES, CeruleanCave1FTileScript

	def_warp_events
	warp_event 27, 21, CERULEAN_CITY, 7
	warp_event  9,  5, CERULEAN_CAVE_2F, 1
	warp_event 29,  5, CERULEAN_CAVE_2F, 2
	warp_event  3,  7, CERULEAN_CAVE_2F, 3
	warp_event  2, 10, CERULEAN_CAVE_B1F, 1
	warp_event 25, 11, CERULEAN_CAVE_2F, 4
	warp_event 20, 13, CERULEAN_CAVE_2F, 5
	warp_event  5, 15, CERULEAN_CAVE_2F, 6

	def_coord_events
	coord_event 20,  4, SCENE_CERULEANCAVE1F_BRIDGE_OVERHEAD, CeruleanCave1FBridgeOverheadTrigger
	coord_event 20,  5, SCENE_CERULEANCAVE1F_BRIDGE_OVERHEAD, CeruleanCave1FBridgeOverheadTrigger
	coord_event 23,  4, SCENE_CERULEANCAVE1F_BRIDGE_OVERHEAD, CeruleanCave1FBridgeOverheadTrigger
	coord_event 23,  5, SCENE_CERULEANCAVE1F_BRIDGE_OVERHEAD, CeruleanCave1FBridgeOverheadTrigger
	coord_event 21,  7, SCENE_CERULEANCAVE1F_BRIDGE_UNDERFOOT, CeruleanCave1FBridgeUnderfootTrigger
	coord_event 22,  7, SCENE_CERULEANCAVE1F_BRIDGE_UNDERFOOT, CeruleanCave1FBridgeUnderfootTrigger

	def_bg_events
	bg_event 10, 13, BGEVENT_ITEM + ULTRA_BALL, EVENT_CERULEAN_CAVE_1F_HIDDEN_ULTRA_BALL
	bg_event  5, 16, BGEVENT_ITEM + PP_UP, EVENT_CERULEAN_CAVE_1F_HIDDEN_PP_UP
	bg_event 16, 15, BGEVENT_ITEM + RARE_CANDY, EVENT_CERULEAN_CAVE_1F_HIDDEN_RARE_CANDY
	bg_event 25,  2, BGEVENT_ITEM + BERSERK_GENE, EVENT_CERULEAN_CAVE_1F_HIDDEN_BERSERK_GENE

	def_object_events
	itemball_event  7,  6, BIG_NUGGET, 1, EVENT_CERULEAN_CAVE_1F_BIG_NUGGET
	itemball_event  9, 17, FULL_RESTORE, 1, EVENT_CERULEAN_CAVE_1F_FULL_RESTORE
	itemball_event 14,  2, MAX_REVIVE, 1, EVENT_CERULEAN_CAVE_1F_MAX_REVIVE

CeruleanCave1FTileScript:
	checkscene
	iftruefwd .underfoot
	callasm CeruleanCave1F_OverheadBridgeAsm
	endcallback

.underfoot:
	callasm CeruleanCave1F_UnderfootBridgeAsm
	endcallback

CeruleanCave1F_OverheadBridgeAsm:
	changebridgeblock 20, 2, $76, CERULEAN_CAVE_1F
	changebridgeblock 22, 2, $77, CERULEAN_CAVE_1F
	changebridgeblock 20, 4, $7a, CERULEAN_CAVE_1F
	changebridgeblock 22, 4, $7b, CERULEAN_CAVE_1F
	changebridgeblock 20, 6, $59, CERULEAN_CAVE_1F
	changebridgeblock 22, 6, $5b, CERULEAN_CAVE_1F
	jmp BufferScreen

CeruleanCave1F_UnderfootBridgeAsm:
	changebridgeblock 20, 2, $74, CERULEAN_CAVE_1F
	changebridgeblock 22, 2, $75, CERULEAN_CAVE_1F
	changebridgeblock 20, 4, $78, CERULEAN_CAVE_1F
	changebridgeblock 22, 4, $79, CERULEAN_CAVE_1F
	changebridgeblock 20, 6, $55, CERULEAN_CAVE_1F
	changebridgeblock 22, 6, $57, CERULEAN_CAVE_1F
	jmp BufferScreen

CeruleanCave1FBridgeOverheadTrigger:
	callasm CeruleanCave1F_OverheadBridgeAsm
	callthisasm
	xor a
	jr CeruleanCave1F_FinishBridge

CeruleanCave1FBridgeUnderfootTrigger:
	callasm CeruleanCave1F_UnderfootBridgeAsm
	callthisasm
	ld a, $1
CeruleanCave1F_FinishBridge:
	ld [wWalkingOnBridge], a
	ld [wCeruleanCave1FSceneID], a ; setscene a
	jmp GenericFinishBridge
