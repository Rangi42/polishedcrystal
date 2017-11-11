CeruleanCave1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, CeruleanCave1FTileScript

CeruleanCave1F_MapEventHeader:

.Warps: db 8
	warp_def 21, 27, 7, CERULEAN_CITY
	warp_def 5, 9, 1, CERULEAN_CAVE_2F
	warp_def 5, 29, 2, CERULEAN_CAVE_2F
	warp_def 7, 3, 3, CERULEAN_CAVE_2F
	warp_def 10, 2, 1, CERULEAN_CAVE_B1F
	warp_def 11, 25, 4, CERULEAN_CAVE_2F
	warp_def 13, 20, 5, CERULEAN_CAVE_2F
	warp_def 15, 5, 6, CERULEAN_CAVE_2F

.XYTriggers: db 4
	xy_trigger 1, 7, 21, CeruleanCave1FBridgeOverheadTrigger
	xy_trigger 1, 7, 22, CeruleanCave1FBridgeOverheadTrigger
	xy_trigger 0, 6, 21, CeruleanCave1FBridgeUnderfootTrigger
	xy_trigger 0, 6, 22, CeruleanCave1FBridgeUnderfootTrigger

.Signposts: db 4
	signpost 13, 10, SIGNPOST_ITEM + ULTRA_BALL, EVENT_CERULEAN_CAVE_1F_HIDDEN_ULTRA_BALL
	signpost 16, 5, SIGNPOST_ITEM + PP_UP, EVENT_CERULEAN_CAVE_1F_HIDDEN_PP_UP
	signpost 15, 16, SIGNPOST_ITEM + RARE_CANDY, EVENT_CERULEAN_CAVE_1F_HIDDEN_RARE_CANDY
	signpost 2, 25, SIGNPOST_ITEM + BERSERK_GENE, EVENT_CERULEAN_CAVE_1F_HIDDEN_BERSERK_GENE

.PersonEvents: db 3
	itemball_event 6, 7, BIG_NUGGET, 1, EVENT_CERULEAN_CAVE_1F_BIG_NUGGET
	itemball_event 17, 9, FULL_RESTORE, 1, EVENT_CERULEAN_CAVE_1F_FULL_RESTORE
	itemball_event 2, 14, MAX_REVIVE, 1, EVENT_CERULEAN_CAVE_1F_MAX_REVIVE

CeruleanCave1FTileScript:
	checktriggers
	iftrue .underfoot
	callasm CeruleanCave1F_OverheadBridgeAsm
	return

.underfoot:
	callasm CeruleanCave1F_UnderfootBridgeAsm
	return

CeruleanCave1F_OverheadBridgeAsm:
	changebridgeblock 20, 2, $ea, CERULEAN_CAVE_1F
	changebridgeblock 22, 2, $eb, CERULEAN_CAVE_1F
	changebridgeblock 20, 4, $ee, CERULEAN_CAVE_1F
	changebridgeblock 22, 4, $ef, CERULEAN_CAVE_1F
	changebridgeblock 20, 6, $59, CERULEAN_CAVE_1F
	changebridgeblock 22, 6, $5b, CERULEAN_CAVE_1F
	jp BufferScreen

CeruleanCave1F_UnderfootBridgeAsm:
	changebridgeblock 20, 2, $e8, CERULEAN_CAVE_1F
	changebridgeblock 22, 2, $e9, CERULEAN_CAVE_1F
	changebridgeblock 20, 4, $ec, CERULEAN_CAVE_1F
	changebridgeblock 22, 4, $ed, CERULEAN_CAVE_1F
	changebridgeblock 20, 6, $55, CERULEAN_CAVE_1F
	changebridgeblock 22, 6, $57, CERULEAN_CAVE_1F
	jp BufferScreen

CeruleanCave1FBridgeOverheadTrigger:
	callasm CeruleanCave1F_OverheadBridgeAsm
	thisasm
	xor a
	jr CeruleanCave1F_FinishBridge

CeruleanCave1FBridgeUnderfootTrigger:
	callasm CeruleanCave1F_UnderfootBridgeAsm
	thisasm
	ld a, $1
CeruleanCave1F_FinishBridge:
	ld [wWalkingOnBridge], a
	ld [wCeruleanCave1FTrigger], a ; dotrigger a
	jp RefreshScreen_BridgeUpdate ; refreshscreen (optimized)
