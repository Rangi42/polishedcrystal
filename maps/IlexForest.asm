IlexForest_MapScriptHeader:
	db 2 ; scene scripts
	scene_script IlexForestTrigger0
	scene_script IlexForestTrigger1

	db 1 ; callbacks
	callback MAPCALLBACK_OBJECTS, IlexForestFarfetchdCallback

	db 4 ; warp events
	warp_event  3,  7, ROUTE_34_ILEX_FOREST_GATE, 3
	warp_event  5, 44, ILEX_FOREST_AZALEA_GATE, 1
	warp_event  5, 45, ILEX_FOREST_AZALEA_GATE, 2
	warp_event 25, 24, HIDDEN_TREE_GROTTO, 1

	db 1 ; coord events
	coord_event  9, 31, 2, IlexForestApprenticeTrigger

	db 10 ; bg events
	bg_event  5, 19, SIGNPOST_JUMPTEXT, Text_IlexForestSignpost0
	bg_event 13,  9, SIGNPOST_ITEM + ETHER, EVENT_ILEX_FOREST_HIDDEN_ETHER
	bg_event 24, 16, SIGNPOST_ITEM + SUPER_POTION, EVENT_ILEX_FOREST_HIDDEN_SUPER_POTION
	bg_event  3, 19, SIGNPOST_ITEM + FULL_HEAL, EVENT_ILEX_FOREST_HIDDEN_FULL_HEAL
	bg_event 20,  9, SIGNPOST_JUMPTEXT, Text_IlexForestMossRock
	bg_event 10, 24, SIGNPOST_UP, MapIlexForestSignpost4Script
	bg_event 25, 24, SIGNPOST_ITEM + SILVER_LEAF, EVENT_ILEX_FOREST_HIDDEN_SILVER_LEAF_1
	bg_event 19,  8, SIGNPOST_ITEM + SILVER_LEAF, EVENT_ILEX_FOREST_HIDDEN_SILVER_LEAF_2
	bg_event 25, 23, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_ILEX_FOREST
	bg_event 26, 23, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_ILEX_FOREST

	db 14 ; object events
	object_event 16, 33, SPRITE_FARFETCH_D, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, IlexForestFarfetchdScript, EVENT_ILEX_FOREST_FARFETCHD
	object_event  7, 30, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, IlexForestCharcoalMasterScript, EVENT_ILEX_FOREST_CHARCOAL_MASTER
	object_event 10, 31, SPRITE_KURT, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ILEX_FOREST_KURT
	object_event  5, 26, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, Text_IlexForestLass, EVENT_ILEX_FOREST_LASS
	object_event 10, 26, SPRITE_CELEBI, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ILEX_FOREST_CELEBI
	object_event  9, 25, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, IlexForestLyraScript, EVENT_ILEX_FOREST_LYRA
	object_event  9, 30, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, IlexForestCharcoalApprenticeScript, EVENT_ILEX_FOREST_APPRENTICE
	object_event 17, 16, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, IlexForestHeadbuttGuyScript, -1
	object_event 14,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 0, GenericTrainerBug_catcherWayne, -1
	cuttree_event 10, 27, EVENT_ILEX_FOREST_CUT_TREE
	itemball_event 22, 34, REVIVE, 1, EVENT_ILEX_FOREST_REVIVE
	itemball_event 11, 19, X_ATTACK, 1, EVENT_ILEX_FOREST_X_ATTACK
	itemball_event 25, 17, ANTIDOTE, 1, EVENT_ILEX_FOREST_ANTIDOTE
	itemball_event 29,  3, MULCH, 1, EVENT_ILEX_FOREST_MULCH

	const_def 1 ; object constants
	const ILEXFOREST_FARFETCHD
	const ILEXFOREST_BLACK_BELT
	const ILEXFOREST_KURT
	const ILEXFOREST_LASS
	const ILEXFOREST_CELEBI
	const ILEXFOREST_LYRA
	const ILEXFOREST_YOUNGSTER

IlexForestTrigger1:
	priorityjump IlexForestFinishCelebiEventScript
IlexForestTrigger0:
	end

IlexForestFarfetchdCallback:
	checkevent EVENT_GOT_HM01_CUT
	iftrue .Static
	copybytetovar FarfetchdPosition
	ifequal  1, .PositionOne
	ifequal  2, .PositionTwo
	ifequal  3, .PositionThree
	ifequal  4, .PositionFour
	ifequal  5, .PositionFive
	ifequal  6, .PositionSix
	ifequal  7, .PositionSeven
	ifequal  8, .PositionEight
	ifequal  9, .PositionNine
	ifequal 10, .PositionTen
.Static:
	return

.PositionOne:
	moveobject ILEXFOREST_FARFETCHD, 16, 33
	appear ILEXFOREST_FARFETCHD
	return

.PositionTwo:
	moveobject ILEXFOREST_FARFETCHD, 17, 27
	appear ILEXFOREST_FARFETCHD
	return

.PositionThree:
	moveobject ILEXFOREST_FARFETCHD, 22, 26
	appear ILEXFOREST_FARFETCHD
	return

.PositionFour:
	moveobject ILEXFOREST_FARFETCHD, 31, 24
	appear ILEXFOREST_FARFETCHD
	return

.PositionFive:
	moveobject ILEXFOREST_FARFETCHD, 30, 33
	appear ILEXFOREST_FARFETCHD
	return

.PositionSix:
	moveobject ILEXFOREST_FARFETCHD, 26, 37
	appear ILEXFOREST_FARFETCHD
	return

.PositionSeven:
	moveobject ILEXFOREST_FARFETCHD, 24, 33
	appear ILEXFOREST_FARFETCHD
	return

.PositionEight:
	moveobject ILEXFOREST_FARFETCHD, 17, 31
	appear ILEXFOREST_FARFETCHD
	return

.PositionNine:
	moveobject ILEXFOREST_FARFETCHD, 12, 37
	appear ILEXFOREST_FARFETCHD
	return

.PositionTen:
	moveobject ILEXFOREST_FARFETCHD, 8, 30
	appear ILEXFOREST_FARFETCHD
	return

IlexForestCharcoalApprenticeScript:
	checkevent EVENT_HERDED_FARFETCHD
	iftrue_jumptextfaceplayer UnknownText_0x6f019
	setscene $0
	jumptextfaceplayer UnknownText_0x6ef5c

IlexForestFarfetchdScript:
	faceplayer
	copybytetovar FarfetchdPosition
	ifequal  0, .Position1
	showcrytext Text_Kwaaaa, FARFETCH_D
	copybytetovar FarfetchdPosition
	ifequal  2, .Position2
	ifequal  3, .Position3
	ifequal  4, .Position4
	ifequal  5, .Position5
	ifequal  6, .Position6
	ifequal  7, .Position7
	ifequal  8, .Position8
	ifequal  9, .Position9
	ifequal 10, .Position10

.Position1:
	faceplayer
	opentext
	writetext Text_ItsTheMissingPokemon
	buttonsound
	writetext Text_Kwaaaa
	cry FARFETCH_D
	waitbutton
	closetext
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos1_Pos2
.NewPosition2:
	moveobject ILEXFOREST_FARFETCHD, 17, 27
	writebyte 2
.NewPosition:
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	copyvartobyte FarfetchdPosition
.Position10:
	end

.Position2:
	checkcode VAR_FACING
	ifequal DOWN, .Position2_Down
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos2_Pos3
.NewPosition3:
	moveobject ILEXFOREST_FARFETCHD, 22, 26
	writebyte 3
	jump .NewPosition

.Position2_Down:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos2_Pos8
.NewPosition8:
	moveobject ILEXFOREST_FARFETCHD, 17, 31
	writebyte 8
	jump .NewPosition

.Position3:
	checkcode VAR_FACING
	ifequal LEFT, .Position3_Left
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos3_Pos4
.NewPosition4:
	moveobject ILEXFOREST_FARFETCHD, 31, 24
	writebyte 4
	jump .NewPosition

.Position3_Left:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos3_Pos2
	jump .NewPosition2

.Position4:
	checkcode VAR_FACING
	ifequal UP, .Position4_Up
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos4_Pos5
.NewPosition5:
	moveobject ILEXFOREST_FARFETCHD, 30, 33
	writebyte 5
	jump .NewPosition

.Position4_Up:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos4_Pos3
	jump .NewPosition3

.Position5:
	checkcode VAR_FACING
	ifequal UP, .Position5_Up
	ifequal LEFT, .Position5_Left
	ifequal RIGHT, .Position5_Right
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos5_Pos6
.NewPosition6:
	moveobject ILEXFOREST_FARFETCHD, 26, 37
	writebyte 6
	jump .NewPosition

.Position5_Left:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos5_Pos7
.NewPosition7:
	moveobject ILEXFOREST_FARFETCHD, 24, 33
	writebyte 7
	jump .NewPosition

.Position5_Up:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos5_Pos4_Up
	jump .NewPosition4

.Position5_Right:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos5_Pos4_Right
	jump .NewPosition4

.Position6:
	checkcode VAR_FACING
	ifequal RIGHT, .Position6_Right
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos6_Pos7
	jump .NewPosition7

.Position6_Right:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos6_Pos5
	jump .NewPosition5

.Position7:
	checkcode VAR_FACING
	ifequal DOWN, .Position7_Down
	ifequal LEFT, .Position7_Left
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos7_Pos8
	jump .NewPosition8

.Position7_Left:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos7_Pos6
	jump .NewPosition6

.Position7_Down:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos7_Pos5
	jump .NewPosition5

.Position8:
	checkcode VAR_FACING
	ifequal UP, .Position8_Up
	ifequal LEFT, .Position8_Left
	ifequal RIGHT, .Position8_Right
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos8_Pos9
	moveobject ILEXFOREST_FARFETCHD, 12, 37
	writebyte 9
	jump .NewPosition

.Position8_Right:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos8_Pos7
	jump .NewPosition7

.Position8_Up:
.Position8_Left:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos8_Pos2
	jump .NewPosition2

.Position9:
	checkcode VAR_FACING
	ifequal DOWN, .Position9_Down
	ifequal RIGHT, .Position9_Right
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos9_Pos10
	appear ILEXFOREST_BLACK_BELT
	setevent EVENT_CHARCOAL_KILN_BOSS
	setevent EVENT_HERDED_FARFETCHD
	moveobject ILEXFOREST_FARFETCHD, 8, 30
	writebyte 10
	jump .NewPosition

.Position9_Right:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos9_Pos8_Right
	jump .NewPosition8

.Position9_Down:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos9_Pos8_Down
	jump .NewPosition8

IlexForestFinishCelebiEventScript:
	setevent EVENT_TIME_TRAVEL_FINISHED
	clearevent EVENT_TIME_TRAVELING
	setscene $0
	pause 30
	showemote EMOTE_SHOCK, ILEXFOREST_LYRA, 15
	applyonemovement ILEXFOREST_LYRA, slow_step_down
	turnobject ILEXFOREST_LYRA, RIGHT
	turnobject PLAYER, LEFT
	opentext
	writetext Text_IlexForestLyraWorried
	waitbutton
	writetext Text_IlexForestLyraArmorSuit
	waitbutton
	closetext
	follow ILEXFOREST_LYRA, PLAYER
	applyonemovement ILEXFOREST_LYRA, slow_step_up
	stopfollow
	turnobject PLAYER, UP
	turnobject ILEXFOREST_LYRA, DOWN
	setlasttalked ILEXFOREST_LYRA
	opentext
	jump IlexForestLyraContinueScript

IlexForestLyraScript:
	faceplayer
	opentext
	writetext Text_IlexForestLyraArmorSuit
	buttonsound
IlexForestLyraContinueScript:
	verbosegiveitem ARMOR_SUIT
	iffalse_endtext
	setevent EVENT_GOT_ARMOR_SUIT
	writetext Text_IlexForestLyraGoodbye
	waitbutton
	closetext
	checkcode VAR_FACING
	ifequal LEFT, .NotBlockingPath
	applymovement PLAYER, MovementData_PlayerStepAside
.NotBlockingPath
	applymovement ILEXFOREST_LYRA, MovementData_IlexForestLyraLeaves
	disappear ILEXFOREST_LYRA
	end

IlexForestApprenticeTrigger:
	showemote EMOTE_SHOCK, ILEXFOREST_YOUNGSTER, 15
	turnobject PLAYER, UP
	jump IlexForestCharcoalApprenticeScript

IlexForestCharcoalMasterScript:
	checkevent EVENT_GOT_HM01_CUT
	iftrue_jumptextfaceplayer Text_CharcoalMasterTalkAfter
	faceplayer
	opentext
	writetext Text_CharcoalMasterIntro
	buttonsound
	verbosegivetmhm HM_CUT
	setevent EVENT_GOT_HM01_CUT
	writetext Text_CharcoalMasterOutro
	waitbutton
	closetext
	setevent EVENT_ILEX_FOREST_FARFETCHD
	setevent EVENT_ILEX_FOREST_APPRENTICE
	setevent EVENT_ILEX_FOREST_CHARCOAL_MASTER
	clearevent EVENT_CHARCOAL_KILN_FARFETCH_D
	clearevent EVENT_CHARCOAL_KILN_APPRENTICE
	clearevent EVENT_CHARCOAL_KILN_BOSS
	end

IlexForestHeadbuttGuyScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_HEADBUTT_INTRO
	iftrue IlexForestTutorHeadbuttScript
	writetext Text_HeadbuttIntro
	waitbutton
	setevent EVENT_LISTENED_TO_HEADBUTT_INTRO
IlexForestTutorHeadbuttScript:
	writetext Text_IlexForestTutorHeadbutt
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_IlexForestTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte HEADBUTT
	writetext Text_IlexForestTutorClear
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_IlexForestTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_IlexForestTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_IlexForestTutorTaught

GenericTrainerBug_catcherWayne:
	generictrainer BUG_CATCHER, WAYNE, EVENT_BEAT_BUG_CATCHER_WAYNE, Bug_catcherWayneSeenText, Bug_catcherWayneBeatenText

	text "A #mon I've"
	line "never seen before"

	para "fell out of the"
	line "tree when I used"
	cont "Headbutt."

	para "I ought to use"
	line "Headbutt in other"
	cont "places too."
	done

MapIlexForestSignpost4Script:
	checkevent EVENT_FOREST_IS_RESTLESS
	iffalse .DontDoCelebiEvent
	checkitem GS_BALL
	iftrue .AskCelebiEvent
.DontDoCelebiEvent:
	checkevent EVENT_TIME_TRAVEL_FINISHED
	iftrue .DontDoGiovanniEvent
	checkpoke CELEBI
	iftrue .StartGiovanniEvent
.DontDoGiovanniEvent
	jumptext Text_IlexForestShrine

.AskCelebiEvent:
	opentext
	writetext Text_ShrineCelebiEvent
	yesorno
	iftrue .CelebiEvent
	endtext

.CelebiEvent:
	takeitem GS_BALL
	clearevent EVENT_FOREST_IS_RESTLESS
	setevent EVENT_AZALEA_TOWN_KURT
	disappear ILEXFOREST_LASS
	clearevent EVENT_ROUTE_34_ILEX_FOREST_GATE_LASS
	writetext Text_InsertGSBall
	waitbutton
	closetext
	pause 20
	showemote EMOTE_SHOCK, PLAYER, 20
	special Special_FadeOutMusic
	applymovement PLAYER, MovementData_0x6ef58
	pause 30
	turnobject PLAYER, DOWN
	pause 20
	clearflag ENGINE_HAVE_EXAMINED_GS_BALL
	special Special_CelebiShrineEvent
	loadwildmon CELEBI, 30
	startbattle
	reloadmapafterbattle
	pause 20
	special CheckCaughtCelebi
	iffalse .DidntCatchCelebi
	appear ILEXFOREST_KURT
	applymovement ILEXFOREST_KURT, MovementData_0x6ef4e
	showtext Text_KurtCaughtCelebi
	applymovement ILEXFOREST_KURT, MovementData_0x6ef53
	disappear ILEXFOREST_KURT
.DidntCatchCelebi:
	end

.StartGiovanniEvent:
	showtext Text_IlexForestShrine
	showemote EMOTE_SHOCK, PLAYER, 15
	appear ILEXFOREST_CELEBI
	playsound SFX_BALL_POOF
	turnobject PLAYER, DOWN
	waitsfx
	pause 15
	cry CELEBI
	waitsfx
	pause 15
	applymovement ILEXFOREST_CELEBI, MovementData_CelebiDance
	pause 15
	showtext Text_CelebiDancedBeautifully
	playsound SFX_JUMP_OVER_LEDGE
	applymovement ILEXFOREST_CELEBI, MovementData_CelebiHop
	applyonemovement PLAYER, slow_step_down
	waitsfx
	special Special_FadeOutMusic
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	moveobject ILEXFOREST_LYRA, 5, 26
	appear ILEXFOREST_LYRA
	applymovement ILEXFOREST_LYRA, MovementData_IlexForestLyraApproaches
	turnobject PLAYER, LEFT
	showtext Text_IlexForestLyraHello
	special RestartMapMusic
	pause 30
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	turnobject ILEXFOREST_CELEBI, DOWN
	pause 30
	special FadeInPalettes
	waitsfx
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, UP
	pause 15
	turnobject ILEXFOREST_LYRA, UP
	turnobject PLAYER, DOWN
	pause 15
	turnobject ILEXFOREST_LYRA, RIGHT
	turnobject PLAYER, LEFT
	showtext Text_IlexForestLyraWhatWasThat
	cry CELEBI
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement PLAYER, MovementData_PlayerStepBack
	waitsfx
	playsound SFX_PROTECT
	applymovement ILEXFOREST_CELEBI, MovementData_CelebiFloat
	waitsfx
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	pause 30
	waitsfx
	disappear ILEXFOREST_CELEBI
	setevent EVENT_TIME_TRAVELING
	warp ROUTE_22_PAST, 6, 7
	end

MovementData_Farfetchd_Pos1_Pos2:
	big_step_up
MovementData_Farfetched_Pos8_Pos2:
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	step_end

MovementData_Farfetchd_Pos2_Pos3:
	big_step_up
	big_step_up
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_down
	step_end

MovementData_Farfetchd_Pos4_Pos5:
	big_step_down
MovementData_Farfetchd_Pos2_Pos8:
	big_step_down
	big_step_down
	big_step_down
	big_step_down
	big_step_down
	step_end

MovementData_Farfetchd_Pos3_Pos4:
MovementData_Farfetched_Pos7_Pos5:
	big_step_right
MovementData_Farfetched_Pos8_Pos7:
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	step_end

MovementData_Farfetchd_Pos3_Pos2:
	big_step_up
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	step_end

MovementData_Farfetchd_Pos4_Pos3:
	big_step_left
	jump_step_left
	big_step_left
	big_step_left
	step_end

MovementData_Farfetchd_Pos5_Pos6:
	big_step_down
	big_step_down
	big_step_down
	big_step_down
	big_step_down
MovementData_Farfetchd_Pos5_Pos7:
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	step_end

MovementData_Farfetched_Pos5_Pos4_Up:
	big_step_up
	big_step_up
	big_step_up
	big_step_right
	big_step_up
	step_end

MovementData_Farfetched_Pos5_Pos4_Right:
	big_step_right
	turn_head_up
	step_sleep_1
	turn_head_down
	step_sleep_1
	turn_head_up
	step_sleep_1
	big_step_down
	big_step_down
	fix_facing
	jump_step_up
	step_sleep_8
	step_sleep_8
	remove_fixed_facing
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	step_end

MovementData_Farfetched_Pos6_Pos7:
	big_step_left
	big_step_left
	big_step_left
	big_step_up
	big_step_up
	big_step_right
	big_step_up
	big_step_up
	step_end

MovementData_Farfetched_Pos6_Pos5:
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	step_end

MovementData_Farfetched_Pos7_Pos8:
	big_step_up
	big_step_up
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	step_end

MovementData_Farfetched_Pos7_Pos6:
	big_step_down
	big_step_down
	big_step_left
	big_step_down
	big_step_down
	big_step_right
	big_step_right
	big_step_right
	step_end

MovementData_Farfetched_Pos8_Pos9:
	big_step_down
	big_step_left
	big_step_down
	big_step_down
	big_step_down
	big_step_down
	big_step_down
	step_end

MovementData_Farfetched_Pos9_Pos10:
	big_step_left
	big_step_left
	fix_facing
	jump_step_right
	step_sleep_8
	step_sleep_8
	remove_fixed_facing
	big_step_left
	big_step_left
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	step_end

MovementData_Farfetched_Pos9_Pos8_Right:
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	step_end

MovementData_Farfetched_Pos9_Pos8_Down:
	big_step_left
	big_step_left
	fix_facing
	jump_step_right
	step_sleep_8
	step_sleep_8
	remove_fixed_facing
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	step_end

MovementData_0x6ef4e:
	step_up
	step_up
	step_up
	step_up
	step_end

MovementData_0x6ef53:
	step_down
	step_down
	step_down
	step_down
	step_end

MovementData_0x6ef58:
	fix_facing
	slow_step_down
	remove_fixed_facing
	step_end

MovementData_CelebiDance:
	slow_step_left
	slow_step_right
	slow_step_right
	slow_step_left
	step_sleep_4
	turn_head_up
	step_sleep_4
	turn_head_left
	step_sleep_4
	turn_head_down
	step_sleep_4
	turn_head_right
	step_sleep_4
	turn_head_up
	step_sleep_4
	turn_head_left
	step_sleep_4
	turn_head_down
	step_sleep_4
	turn_head_right
	step_sleep_4
	turn_head_up
	step_sleep_4
	step_end

MovementData_CelebiHop:
	jump_step_down
	slow_step_up
	step_end

MovementData_CelebiFloat:
	turn_head_down
	fix_facing
	slow_step_up
	slow_step_up
	slow_step_up
	remove_fixed_facing
	step_end

MovementData_PlayerStepBack:
	fix_facing
	slow_step_right
	remove_fixed_facing
	step_end

MovementData_IlexForestLyraApproaches:
	slow_step_right
	slow_step_right
	slow_step_right
	slow_step_right
	step_end

MovementData_PlayerStepAside:
	slow_step_right
	turn_head_left
	step_end

MovementData_IlexForestLyraLeaves:
	slow_step_down
	slow_step_left
	slow_step_left
	slow_step_left
	slow_step_left
	step_end

UnknownText_0x6ef5c:
	text "Oh, man… My boss"
	line "is going to be"
	cont "steaming…"

	para "The Farfetch'd"
	line "that Cuts trees"

	para "for charcoal took"
	line "off on me."

	para "I can't go looking"
	line "for it here in the"
	cont "Ilex Forest."

	para "It's too big, dark"
	line "and scary for me…"
	done

UnknownText_0x6f019:
	text "Wow! Thanks a"
	line "whole bunch!"

	para "My boss's #mon"
	line "won't obey me be-"
	cont "cause I don't have"
	cont "a Badge."
	done

Text_ItsTheMissingPokemon:
	text "It's the missing"
	line "#mon!"
	done

Text_Kwaaaa:
	text "Farfetch'd: Kwaa!"
	done

Text_CharcoalMasterIntro:
	text "Ah! My Farfetch'd!"

	para "You found it for"
	line "us, kid?"

	para "Without it, we"
	line "wouldn't be able"

	para "to Cut trees for"
	line "charcoal."

	para "Thanks, kid!"

	para "Now, how can I"
	line "thank you…"

	para "I know! Here, take"
	line "this."
	done

Text_CharcoalMasterOutro:
	text "That's the Cut HM."
	line "Teach that to a"

	para "#mon to clear"
	line "small trees."

	para "Of course, you"
	line "have to have the"

	para "Gym Badge from"
	line "Azalea to use it."
	done

Text_CharcoalMasterTalkAfter:
	text "Do you want to"
	line "apprentice as a"

	para "charcoal maker"
	line "with me?"

	para "You'll be first-"
	line "rate in ten years!"
	done

Text_HeadbuttIntro:
	text "What am I doing?"

	para "I'm shaking trees"
	line "using Headbutt."

	para "It's fun. Here,"
	line "you try it too!"
	done

Text_IlexForestTutorHeadbutt:
	text "I can teach your"
	line "#mon to use"

	para "Headbutt in ex-"
	line "change for a"
	cont "Silver Leaf."
	done

Text_IlexForestTutorNoSilverLeaf:
	text "Oh, but you don't"
	line "have any Silver"
	cont "Leaves."

	para "Sometimes you can"
	line "find them on wild"

	para "Oddish, or lying"
	line "on the ground."
	done

Text_IlexForestTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Headbutt?"
	done

Text_IlexForestTutorRefused:
	text "Alright then."
	done

Text_IlexForestTutorClear:
	text ""
	done

Text_IlexForestTutorTaught:
	text "Rattle trees with"
	line "Headbutt. Some-"
	cont "times, sleeping"
	cont "#mon fall out."
	done

Text_IlexForestLass:
	text "Did something"
	line "happen to the"
	cont "forest's guardian?"
	done

Text_IlexForestMossRock:
	text "The rock is cover-"
	line "ed in moss."

	para "It feels pleasant-"
	line "ly cool."
	done

Text_IlexForestSignpost0:
	text "Ilex Forest is"
	line "so overgrown with"

	para "trees that you"
	line "can't see the sky."

	para "Please watch out"
	line "for items that may"
	cont "have been dropped."
	done

Text_IlexForestShrine:
	text "Ilex Forest"
	line "Shrine…"

	para "It's in honor of"
	line "the forest's"
	cont "protector…"
	done

Text_ShrineCelebiEvent:
	text "Ilex Forest"
	line "Shrine…"

	para "It's in honor of"
	line "the forest's"
	cont "protector…"

	para "Oh? What is this?"

	para "It's a hole."
	line "It looks like the"

	para "GS Ball would fit"
	line "inside it."

	para "Want to put the GS"
	line "Ball here?"
	done

Text_InsertGSBall:
	text "<PLAYER> put in the"
	line "GS Ball."
	done

Text_KurtCaughtCelebi:
	text "Whew, wasn't that"
	line "something!"

	para "<PLAYER>, that was"
	line "fantastic. Thanks!"

	para "The legends about"
	line "that Shrine were"
	cont "real after all."

	para "Maybe the legend"
	line "that people who"
	cont "tamper with it"

	para "disappear is"
	line "true, too…"

	para "I feel inspired by"
	line "what I just saw."

	para "It motivates me to"
	line "make better Balls!"

	para "I'm going!"
	done

Text_CelebiDancedBeautifully:
	text "Celebi danced"
	line "beautifully!"
	done

Text_IlexForestLyraHello:
	text "Lyra: Hi, <PLAYER>."
	line "Have you heard of"

	para "the legend of the"
	line "shrine?"

	para "They say that"
	line "people disappear"

	para "when they tamper"
	line "with it."
	done

Text_IlexForestLyraWhatWasThat:
	text "Lyra: …"
	line "What was that?"
	done

Text_IlexForestLyraWorried:
	text "Lyra: …<PLAYER>?"
	line "You're really back?"

	para "I missed you so"
	line "much! Celebi sent"

	para "me here and you"
	line "were missing…"

	para "I thought you'd be"
	line "stuck in the past"
	cont "forever!"

	para "…"

	para "At least now we're"
	line "both safely back"
	cont "to our time."
	done

Text_IlexForestLyraArmorSuit:
	text "Lyra: What strange"
	line "adventure did you"
	cont "have by yourself?"

	para "You dropped this…"
	line "thing when Celebi"
	cont "brought you back…"
	done

Text_IlexForestLyraGoodbye:
	text "Lyra: This sure"
	line "was a bizarre day."

	para "I'm exhausted, I"
	line "had better get"
	cont "going."

	para "You should rest"
	line "too, <PLAYER>."

	para "See you!"
	done

Bug_catcherWayneSeenText:
	text "Don't sneak up on"
	line "me like that!"

	para "You frightened a"
	line "#mon away!"
	done

Bug_catcherWayneBeatenText:
	text "I hadn't seen that"
	line "#mon before…"
	done

