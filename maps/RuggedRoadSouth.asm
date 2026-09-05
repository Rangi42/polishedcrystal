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
	object_event  7,  7, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_DARK_BLUE, OBJECTTYPE_TRAINER, 4, TrainerBird_keeperSalim, -1
	object_event 24,  8, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerMaynard, -1
	object_event 12, 18, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherCarlos, -1
	object_event 22, 24, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerElijah, -1
	object_event 13, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_SCRIPT, 0, RuggedRoadSouthBlackBeltScript, -1
	object_event 11, 24, SPRITE_CAMPER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RuggedRoadSouthCamperText, -1
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

TrainerBird_keeperSalim:
	trainer BIRD_KEEPER, SALIM, EVENT_BEAT_BIRD_KEEPER_SALIM, .SeenText, .BeatenText, 0, .Script, TRAINERPAL_DARK_BIRD_KEEPER

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Weather conditions"
	line "can change the"

	para "entire course of"
	line "a battle."
	done

.SeenText:
	text "My birds flew us"
	line "here…"

	para "…but in this sand-"
	line "storm, we're stuck!"
	done

.BeatenText:
	text "I'll stick to clear"
	line "skies from now on."
	done

GenericTrainerHikerMaynard:
	generictrainer HIKER, MAYNARD, EVENT_BEAT_HIKER_MAYNARD, .SeenText, .BeatenText

	text "Every neatly num-"
	line "bered route got"

	para "its start as un-"
	line "tamed wilderness."
	done

.SeenText:
	text "I'm taking the road"
	line "less traveled by!"
	done

.BeatenText:
	text "Defeat is a well-"
	line "trodden path."
	done

GenericTrainerFisherCarlos:
	generictrainer FISHER, CARLOS, EVENT_BEAT_FISHER_CARLOS, .SeenText, .BeatenText

	text "I'm sure my catch"
	line "will be powerful"
	cont "once it's trained."

	para "It might even"
	line "evolve!"
	done

.SeenText:
	text "I trekked up here"
	line "searching for a"
	cont "new catch…"

	para "And it paid off!"
	done

.BeatenText:
	text "My new catch was"
	line "inexperienced…"
	done

GenericTrainerHikerElijah:
	generictrainer HIKER, ELIJAH, EVENT_BEAT_HIKER_ELIJAH, .SeenText, .BeatenText

	text "I didn't choose to"
	line "be a Hiker."

	para "Being a Hiker"
	line "chose me."
	done

.SeenText:
	text "The mountains are"
	line "calling, and I"
	cont "must go!"
	done

.BeatenText:
	text "I won't bail just"
	line "from this!"
	done

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
	verbosegiveitem PUNCHINGLOVE, iffalsefwd .NoRoomForPunchinGlove
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

	para "Here--this padded"
	line "Glove will help"
	cont "them out!"
	done

.NoRoomForPunchinGlove:
	; Refund the Brick Piece just removed from the Bag.
	giveitem BRICK_PIECE, 0
	jumpthisopenedtext

	text "Humph! You don't"
	line "have room for it!"
	done

RuggedRoadSouthCamperText:
	text "Why did I think"
	line "this would be a"

	para "fun new place to"
	line "camp out?"

	para "I can barely see"
	line "the path!"
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
