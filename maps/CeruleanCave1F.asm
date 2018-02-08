CeruleanCave1F_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, CeruleanCave1FTileScript

	db 8 ; warp events
	warp_event 27, 21, CERULEAN_CITY, 7
	warp_event  9,  5, CERULEAN_CAVE_2F, 1
	warp_event 29,  5, CERULEAN_CAVE_2F, 2
	warp_event  3,  7, CERULEAN_CAVE_2F, 3
	warp_event  2, 10, CERULEAN_CAVE_B1F, 1
	warp_event 25, 11, CERULEAN_CAVE_2F, 4
	warp_event 20, 13, CERULEAN_CAVE_2F, 5
	warp_event  5, 15, CERULEAN_CAVE_2F, 6

	db 4 ; coord events
	coord_event 21,  7, 1, CeruleanCave1FBridgeOverheadTrigger
	coord_event 22,  7, 1, CeruleanCave1FBridgeOverheadTrigger
	coord_event 21,  6, 0, CeruleanCave1FBridgeUnderfootTrigger
	coord_event 22,  6, 0, CeruleanCave1FBridgeUnderfootTrigger

	db 4 ; bg events
	bg_event 10, 13, SIGNPOST_ITEM + ULTRA_BALL, EVENT_CERULEAN_CAVE_1F_HIDDEN_ULTRA_BALL
	bg_event  5, 16, SIGNPOST_ITEM + PP_UP, EVENT_CERULEAN_CAVE_1F_HIDDEN_PP_UP
	bg_event 16, 15, SIGNPOST_ITEM + RARE_CANDY, EVENT_CERULEAN_CAVE_1F_HIDDEN_RARE_CANDY
	bg_event 25,  2, SIGNPOST_ITEM + BERSERK_GENE, EVENT_CERULEAN_CAVE_1F_HIDDEN_BERSERK_GENE

	db 3 ; object events
	itemball_event  7,  6, BIG_NUGGET, 1, EVENT_CERULEAN_CAVE_1F_BIG_NUGGET
	itemball_event  9, 17, FULL_RESTORE, 1, EVENT_CERULEAN_CAVE_1F_FULL_RESTORE
	itemball_event 14,  2, MAX_REVIVE, 1, EVENT_CERULEAN_CAVE_1F_MAX_REVIVE

CeruleanCave1FTileScript:
	checkscene
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
	ld [wCeruleanCave1FTrigger], a ; setscene a
	jp RefreshScreen_BridgeUpdate ; refreshscreen (optimized)
