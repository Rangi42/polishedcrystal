RuggedRoadSouth_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_RUGGEDROADSOUTH_BRIDGE_UNDERFOOT
	scene_const SCENE_RUGGEDROADSOUTH_BRIDGE_OVERHEAD

	def_callbacks
	callback MAPCALLBACK_TILES, RuggedRoadSouthTileScript
	callback MAPCALLBACK_CMDQUEUE, RuggedRoadSouthSetUpPaletteSwap

	def_warp_events
	warp_event 15, 33, ROUTE_39_RUGGED_ROAD_GATE, 1
	warp_event 16, 33, ROUTE_39_RUGGED_ROAD_GATE, 2

	def_coord_events
	coord_event 27,  3, SCENE_RUGGEDROADSOUTH_BRIDGE_OVERHEAD, RuggedRoadSouthBridgeOverheadTrigger
	coord_event 27,  1, SCENE_RUGGEDROADSOUTH_BRIDGE_UNDERFOOT, RuggedRoadSouthBridgeUnderfootTrigger
	coord_event 25, 23, SCENE_RUGGEDROADSOUTH_BRIDGE_OVERHEAD, RuggedRoadSouthBridgeOverheadTrigger

	def_bg_events
	bg_event 17, 25, BGEVENT_JUMPTEXT, RuggedRoadSouthAdvancedTipsSignText
	bg_event  7, 21, BGEVENT_ITEM + IRON, EVENT_RUGGED_ROAD_SOUTH_HIDDEN_IRON

	def_object_events
	object_event 13, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_SCRIPT, 0, RuggedRoadSouthBlackBeltScript, -1
	itemball_event  4,  9, REVIVE, 1, EVENT_RUGGED_ROAD_SOUTH_REVIVE
	itemball_event 27, 13, IRON_BALL, 1, EVENT_RUGGED_ROAD_SOUTH_IRON_BALL
	smashrock_event 26,  9
	smashrock_event 13, 10
	smashrock_event  8, 25
	smashrock_event 12, 30

RuggedRoadSouthTileScript:
	checkscene
	iftruefwd .underfoot
	callasm RuggedRoadSouth_OverheadBridgeAsm
	endcallback

.underfoot:
	callasm RuggedRoadSouth_UnderfootBridgeAsm
	endcallback

RuggedRoadSouth_OverheadBridgeAsm:
	changebridgeblock 14, 0, $d8, RUGGED_ROAD_SOUTH
	changebridgeblock 16, 0, $95, RUGGED_ROAD_SOUTH
	changebridgeblock 18, 0, $95, RUGGED_ROAD_SOUTH
	changebridgeblock 20, 0, $95, RUGGED_ROAD_SOUTH
	changebridgeblock 22, 0, $d9, RUGGED_ROAD_SOUTH
	jmp BufferScreen

RuggedRoadSouth_UnderfootBridgeAsm:
	changebridgeblock 14, 0, $aa, RUGGED_ROAD_SOUTH
	changebridgeblock 16, 0, $e4, RUGGED_ROAD_SOUTH
	changebridgeblock 18, 0, $e4, RUGGED_ROAD_SOUTH
	changebridgeblock 20, 0, $e4, RUGGED_ROAD_SOUTH
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

RuggedRoadSouthSetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 0, 255, 0, 22, PAL_BG_YELLOW, OverworldYellowPalettes, RuggedRoadSouthFlowerPalettes
	db -1 ; end

RuggedRoadSouthBlackBeltScript:
	checkevent EVENT_GOT_PUNCHINGLOVE_FROM_RUGGED_ROAD
	iftrue_jumptextfaceplayer .GotPunchinGloveText
	faceplayer
	opentext
	writetext .IntroText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	checkitem BRICK_PIECE
	iffalse_jumpopenedtext .NoBrickPieceText
	takeitem BRICK_PIECE
	writetext .GaveBrickPieceText
	waitbutton
	verbosegiveitem PUNCHINGLOVE
	iffalsefwd .NoRoomForPunchinGlove
	setevent EVENT_GOT_PUNCHINGLOVE_FROM_RUGGED_ROAD
	jumpthisopenedtext

.GotPunchinGloveText
	text "With that Glove,"
	line "your #mon will"
	cont "punch even harder!"
	done

.IntroText:
	text "Hi-YAH!"

	para "With my powerful"
	line "punches, I can"
	cont "smash these rocks!"

	para "Huh? Your #mon"
	line "can too?"

	para "Prove it! Bring me"
	line "a Brick Piece from"
	cont "a broken rock!"
	done

.RefusedText:
	text "Hah! I knew it!"
	done

.NoBrickPieceText:
	text "Hah! You don't"
	line "have any!"
	done

.GaveBrickPieceText:
	text "Huh! That's a real"
	line "Brick Piece!"

	para "Your Pokemon must"
	line "be seriously"
	cont "tough. Like me!"

	para "Here--this Punchin"
	line "Glove will help"
	cont "them out!"
	done

.NoRoomForPunchinGlove:
	giveitem BRICK_PIECE
	jumpthisopenedtext

	text "Humph! You don't"
	line "have room for it!"
	done

RuggedRoadSouthAdvancedTipsSignText:
	text "Advanced Tips!"

	para "If your #mon"
	line "KOs its opponent,"

	para "and it's holding a"
	line "Power item that"
	cont "ups effort gain,"

	para "every #mon that"
	line "participated in"

	para "the battle or"
	line "that's holding an"

	para "Exp.Share will"
	line "gain from it!"
	done
