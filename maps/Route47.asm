Route47_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, Route47TileScript

	db 6 ; warp events
	warp_event 67, 21, CLIFF_EDGE_GATE, 2
	warp_event 53, 21, CLIFF_CAVE, 1
	warp_event 52, 17, CLIFF_CAVE, 2
	warp_event 53, 29, CLIFF_CAVE, 3
	warp_event 11, 23, QUIET_CAVE_1F, 1
	warp_event  8, 23, EMBEDDED_TOWER, 1

	db 32 ; coord events
	coord_event 42, 24, 1, Route47Bridge1OverheadTrigger
	coord_event 42, 25, 1, Route47Bridge1OverheadTrigger
	coord_event 51, 24, 1, Route47Bridge1OverheadTrigger
	coord_event 51, 25, 1, Route47Bridge1OverheadTrigger
	coord_event 43, 24, 0, Route47Bridge1UnderfootTrigger
	coord_event 43, 25, 0, Route47Bridge1UnderfootTrigger
	coord_event 50, 24, 0, Route47Bridge1UnderfootTrigger
	coord_event 50, 25, 0, Route47Bridge1UnderfootTrigger
	coord_event 42, 18, 1, Route47Bridge2OverheadTrigger
	coord_event 42, 19, 1, Route47Bridge2OverheadTrigger
	coord_event 51, 18, 1, Route47Bridge2OverheadTrigger
	coord_event 51, 19, 1, Route47Bridge2OverheadTrigger
	coord_event 43, 18, 0, Route47Bridge2UnderfootTrigger
	coord_event 43, 19, 0, Route47Bridge2UnderfootTrigger
	coord_event 50, 18, 0, Route47Bridge2UnderfootTrigger
	coord_event 50, 19, 0, Route47Bridge2UnderfootTrigger
	coord_event 18, 24, 1, Route47Bridge3OverheadTrigger
	coord_event 18, 25, 1, Route47Bridge3OverheadTrigger
	coord_event 27, 24, 1, Route47Bridge3OverheadTrigger
	coord_event 27, 25, 1, Route47Bridge3OverheadTrigger
	coord_event 19, 24, 0, Route47Bridge3UnderfootTrigger
	coord_event 19, 25, 0, Route47Bridge3UnderfootTrigger
	coord_event 26, 24, 0, Route47Bridge3UnderfootTrigger
	coord_event 26, 25, 0, Route47Bridge3UnderfootTrigger
	coord_event 18, 16, 1, Route47Bridge4OverheadTrigger
	coord_event 18, 17, 1, Route47Bridge4OverheadTrigger
	coord_event 27, 16, 1, Route47Bridge4OverheadTrigger
	coord_event 27, 17, 1, Route47Bridge4OverheadTrigger
	coord_event 19, 16, 0, Route47Bridge4UnderfootTrigger
	coord_event 19, 17, 0, Route47Bridge4UnderfootTrigger
	coord_event 26, 16, 0, Route47Bridge4UnderfootTrigger
	coord_event 26, 17, 0, Route47Bridge4UnderfootTrigger

	db 4 ; bg events
	bg_event  8, 23, SIGNPOST_IFNOTSET, Route47SealedCaveSign
	bg_event 36, 32, SIGNPOST_JUMPTEXT, Route47QuietCaveSignText
	bg_event 34, 33, SIGNPOST_ITEM + PEARL, EVENT_ROUTE_47_HIDDEN_PEARL
	bg_event  5, 32, SIGNPOST_ITEM + STARDUST, EVENT_ROUTE_47_HIDDEN_STARDUST

	db 15 ; object events
	object_event 59, 26, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerHikerDevin, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	object_event 40, 24, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerCamperGrant, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	object_event 38, 18, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoThomandkae1, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	object_event 39, 18, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoThomandkae2, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	object_event 27,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerCoupleDuffandeda1, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	object_event 28,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerCoupleDuffandeda2, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	object_event 51,  8, SPRITE_COWGIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerCowgirlDaniela, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	object_event 55, 27, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerGruntF6, EVENT_CLEARED_YELLOW_FOREST
	object_event 36, 20, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerGruntM23, EVENT_CLEARED_YELLOW_FOREST
	object_event 28, 12, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerGruntM26, EVENT_CLEARED_YELLOW_FOREST
	object_event 40, 25, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, Route47RocketGirlText, EVENT_CLEARED_YELLOW_FOREST
	itemball_event 39, 28, REVIVE, 1, EVENT_ROUTE_47_REVIVE
	itemball_event  7, 32, MYSTIC_WATER, 1, EVENT_ROUTE_47_MYSTIC_WATER
	itemball_event 31, 20, QUICK_CLAW, 1, EVENT_ROUTE_47_QUICK_CLAW
	itemball_event  7,  6, MAX_REPEL, 1, EVENT_ROUTE_47_MAX_REPEL

Route47TileScript:
	checkevent EVENT_DOOR_OPENED_IN_RUINS_OF_ALPH
	iffalse .locked
	changeblock 8, 22, $9b
.locked
	checkscene
	iftrue .underfoot
	callasm .overhead_asm
	return

.underfoot:
	callasm .underfoot_asm
	return

.overhead_asm:
	; bridge 1
	changebridgeblock 42, 24, $e9, ROUTE_47
	changebridgeblock 44, 24, $e7, ROUTE_47
	changebridgeblock 46, 24, $e7, ROUTE_47
	changebridgeblock 48, 24, $e7, ROUTE_47
	changebridgeblock 50, 24, $ea, ROUTE_47
	; bridge 2
	changebridgeblock 44, 18, $e8, ROUTE_47
	changebridgeblock 46, 18, $e8, ROUTE_47
	changebridgeblock 48, 18, $e8, ROUTE_47
	; bridge 3
	changebridgeblock 20, 24, $e8, ROUTE_47
	changebridgeblock 22, 24, $e8, ROUTE_47
	changebridgeblock 24, 24, $e8, ROUTE_47
	; bridge 4
	changebridgeblock 18, 16, $e9, ROUTE_47
	changebridgeblock 20, 16, $e7, ROUTE_47
	changebridgeblock 22, 16, $e7, ROUTE_47
	changebridgeblock 24, 16, $e7, ROUTE_47
	changebridgeblock 26, 16, $eb, ROUTE_47
	jp BufferScreen

.underfoot_asm:
	; bridge 1
	changebridgeblock 42, 24, $aa, ROUTE_47
	changebridgeblock 44, 24, $e6, ROUTE_47
	changebridgeblock 46, 24, $e6, ROUTE_47
	changebridgeblock 48, 24, $e6, ROUTE_47
	changebridgeblock 50, 24, $ab, ROUTE_47
	; bridge 2
	changebridgeblock 44, 18, $e6, ROUTE_47
	changebridgeblock 46, 18, $e6, ROUTE_47
	changebridgeblock 48, 18, $e6, ROUTE_47
	; bridge 3
	changebridgeblock 20, 24, $e6, ROUTE_47
	changebridgeblock 22, 24, $e6, ROUTE_47
	changebridgeblock 24, 24, $e6, ROUTE_47
	; bridge 4
	changebridgeblock 18, 16, $aa, ROUTE_47
	changebridgeblock 20, 16, $e6, ROUTE_47
	changebridgeblock 22, 16, $e6, ROUTE_47
	changebridgeblock 24, 16, $e6, ROUTE_47
	changebridgeblock 26, 16, $b7, ROUTE_47
	jp BufferScreen

Route47_FinishOverheadBridge:
	xor a
	jr Route47_FinishBridge

Route47_FinishUnderfootBridge:
	ld a, $1
Route47_FinishBridge:
	ld [wWalkingOnBridge], a
	ld [wRoute47Trigger], a ; setscene a
	jp RefreshScreen_BridgeUpdate ; refreshscreen (optimized)

Route47Bridge1OverheadTrigger:
	thisasm
	changebridgeblock 42, 24, $e9, ROUTE_47
	changebridgeblock 44, 24, $e7, ROUTE_47
	changebridgeblock 46, 24, $e7, ROUTE_47
	changebridgeblock 48, 24, $e7, ROUTE_47
	changebridgeblock 50, 24, $ea, ROUTE_47
	jp Route47_FinishOverheadBridge

Route47Bridge1UnderfootTrigger:
	thisasm
	changebridgeblock 42, 24, $aa, ROUTE_47
	changebridgeblock 44, 24, $e6, ROUTE_47
	changebridgeblock 46, 24, $e6, ROUTE_47
	changebridgeblock 48, 24, $e6, ROUTE_47
	changebridgeblock 50, 24, $ab, ROUTE_47
	jp Route47_FinishUnderfootBridge

Route47Bridge2OverheadTrigger:
	thisasm
	changebridgeblock 44, 18, $e8, ROUTE_47
	changebridgeblock 46, 18, $e8, ROUTE_47
	changebridgeblock 48, 18, $e8, ROUTE_47
	jp Route47_FinishOverheadBridge

Route47Bridge2UnderfootTrigger:
	thisasm
	changebridgeblock 44, 18, $e6, ROUTE_47
	changebridgeblock 46, 18, $e6, ROUTE_47
	changebridgeblock 48, 18, $e6, ROUTE_47
	jp Route47_FinishUnderfootBridge

Route47Bridge3OverheadTrigger:
	thisasm
	changebridgeblock 20, 24, $e8, ROUTE_47
	changebridgeblock 22, 24, $e8, ROUTE_47
	changebridgeblock 24, 24, $e8, ROUTE_47
	jp Route47_FinishOverheadBridge

Route47Bridge3UnderfootTrigger:
	thisasm
	changebridgeblock 20, 24, $e6, ROUTE_47
	changebridgeblock 22, 24, $e6, ROUTE_47
	changebridgeblock 24, 24, $e6, ROUTE_47
	jp Route47_FinishUnderfootBridge

Route47Bridge4OverheadTrigger:
	thisasm
	changebridgeblock 18, 16, $e9, ROUTE_47
	changebridgeblock 20, 16, $e7, ROUTE_47
	changebridgeblock 22, 16, $e7, ROUTE_47
	changebridgeblock 24, 16, $e7, ROUTE_47
	changebridgeblock 26, 16, $eb, ROUTE_47
	jp Route47_FinishOverheadBridge

Route47Bridge4UnderfootTrigger:
	thisasm
	changebridgeblock 18, 16, $aa, ROUTE_47
	changebridgeblock 20, 16, $e6, ROUTE_47
	changebridgeblock 22, 16, $e6, ROUTE_47
	changebridgeblock 24, 16, $e6, ROUTE_47
	changebridgeblock 26, 16, $b7, ROUTE_47
	jp Route47_FinishUnderfootBridge

GenericTrainerHikerDevin:
	generictrainer HIKER, DEVIN, EVENT_BEAT_HIKER_DEVIN, HikerDevinSeenText, HikerDevinBeatenText

	text "After a battle,"
	line "you should part"
	cont "with a laugh!"
	done

GenericTrainerCamperGrant:
	generictrainer CAMPER, GRANT, EVENT_BEAT_CAMPER_GRANT, CamperGrantSeenText, CamperGrantBeatenText

	text "See ya!"
	done

GenericTrainerAceDuoThomandkae1:
	generictrainer ACE_DUO, THOMANDKAE1, EVENT_BEAT_ACE_DUO_THOM_AND_KAE, AceDuoThomandkae1SeenText, AceDuoThomandkae1BeatenText

	text "Thom: Your power"
	line "is impossible to"
	cont "predict!"
	done

GenericTrainerAceDuoThomandkae2:
	generictrainer ACE_DUO, THOMANDKAE2, EVENT_BEAT_ACE_DUO_THOM_AND_KAE, AceDuoThomandkae2SeenText, AceDuoThomandkae2BeatenText

	text "Kae: I figured you"
	line "were an ordinary"

	para "lone trainer."
	line "Boy, was I wrong!"
	done

GenericTrainerCoupleDuffandeda1:
	generictrainer COUPLE, DUFFANDEDA1, EVENT_BEAT_COUPLE_DUFF_AND_EDA, CoupleDuffandeda1SeenText, CoupleDuffandeda1BeatenText

	text "Duff: Thank you"
	line "for the awe-"
	cont "inspiring battle!"
	done

GenericTrainerCoupleDuffandeda2:
	generictrainer COUPLE, DUFFANDEDA2, EVENT_BEAT_COUPLE_DUFF_AND_EDA, CoupleDuffandeda2SeenText, CoupleDuffandeda2BeatenText

	text "Eda: You should"
	line "find a wonderful"
	cont "partner, too."
	done

GenericTrainerCowgirlDaniela:
	generictrainer COWGIRL, DANIELA, EVENT_BEAT_COWGIRL_DANIELA, CowgirlDanielaSeenText, CowgirlDanielaBeatenText

	text "Have you ever"
	line "tried to ride a"
	cont "Tauros?"
	done

GenericTrainerGruntF6:
	generictrainer GRUNTF, 6, EVENT_BEAT_ROCKET_GRUNTF_6, GruntF6SeenText, GruntF6BeatenText

	text "If we treated"
	line "every single"
	cont "#mon well,"

	para "how would we"
	line "make money?"
	done

GenericTrainerGruntM23:
	generictrainer GRUNTM, 23, EVENT_BEAT_ROCKET_GRUNTM_23, GruntM23SeenText, GruntM23BeatenText

	text "It doesn't matter."
	line "You can't beat"
	cont "all of us!"
	done

GenericTrainerGruntM26:
	generictrainer GRUNTM, 26, EVENT_BEAT_ROCKET_GRUNTM_26, GruntM26SeenText, GruntM26BeatenText

	text "How we treat"
	line "#mon is none"
	cont "of your business!"
	done

HikerDevinSeenText:
	text "Battles are"
	line "battles, so"
	cont "let's go!"
	done

HikerDevinBeatenText:
	text "Wah ha ha!"
	done

CamperGrantSeenText:
	text "I'm not good with"
	line "crowds, so I'm"
	cont "camping out here"
	cont "with my #mon!"
	done

CamperGrantBeatenText:
	text "I should head"
	line "deeper into the"
	cont "mountain…"
	done

AceDuoThomandkae1SeenText:
	text "Thom: One plus one"
	line "is two. But the"

	para "two of us together"
	line "is much stronger!"
	done

AceDuoThomandkae1BeatenText:
	text "Thom: That wasn't"
	line "what I expected…"
	done

AceDuoThomandkae2SeenText:
	text "Kae: The two of us"
	line "aren't just some"
	cont "boring pair!"
	done

AceDuoThomandkae2BeatenText:
	text "Kae: You're"
	line "unusual, too!"
	done

CoupleDuffandeda1SeenText:
	text "Duff: Watching"
	line "over my girlfriend"

	para "makes my heart"
	line "soar!"
	done

CoupleDuffandeda1BeatenText:
	text "Duff: I was no"
	line "match for you…"
	done

CoupleDuffandeda2SeenText:
	text "Eda: My feelings"
	line "for my boyfriend"

	para "are as wide and"
	line "deep as the ocean."
	done

CoupleDuffandeda2BeatenText:
	text "Eda: You're really"
	line "something…"
	done

CowgirlDanielaSeenText:
	text "Hiya, cutie!"
	done

CowgirlDanielaBeatenText:
	text "Well aren't you a"
	line "feisty one?"
	done

GruntF6SeenText:
	text "Why should we"
	line "raise #mon like"
	cont "ordinary trainers?"

	para "We're Team Rocket!"
	done

GruntF6BeatenText:
	text "Who are you?!"
	done

GruntM23SeenText:
	text "Aww, are you here"
	line "to save the cute"
	cont "little #mon?"
	done

GruntM23BeatenText:
	text "Ack!"
	line "You're tough!"
	done

GruntM26SeenText:
	text "Stop meddling with"
	line "our plans!"
	done

GruntM26BeatenText:
	text "Just leave us"
	line "alone…"
	done

Route47RocketGirlText:
	text "What are you head-"
	line "ing this way for,"
	cont "you brat?"
	done

Route47SealedCaveSign:
	dw EVENT_DOOR_OPENED_IN_RUINS_OF_ALPH
	thistext

	text "There's a door-"
	line "shaped groove in"
	cont "the rock."
	done

Route47QuietCaveSignText:
	text "Route 47"

	para "West to"
	line "Quiet Cave"
	done
