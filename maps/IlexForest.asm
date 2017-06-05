const_value set 2
	const ILEXFOREST_CUT_TREE
	const ILEXFOREST_FARFETCHD
	const ILEXFOREST_YOUNGSTER
	const ILEXFOREST_BLACK_BELT
	const ILEXFOREST_ROCKER
	const ILEXFOREST_POKE_BALL1
	const ILEXFOREST_KURT
	const ILEXFOREST_LASS
	const ILEXFOREST_BUG_CATCHER
	const ILEXFOREST_POKE_BALL2
	const ILEXFOREST_POKE_BALL3
	const ILEXFOREST_POKE_BALL4
	const ILEXFOREST_CELEBI
	const ILEXFOREST_LYRA

IlexForest_MapScriptHeader:
.MapTriggers:
	db 2
	dw .Trigger0
	dw .Trigger1

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_OBJECTS, .FarfetchdCallback

.Trigger1:
	priorityjump IlexForestFinishCelebiEventScript
.Trigger0:
	end

.FarfetchdCallback:
	checkevent EVENT_GOT_HM01_CUT
	iftrue .Static
	copybytetovar FarfetchdPosition
	if_equal  1, .PositionOne
	if_equal  2, .PositionTwo
	if_equal  3, .PositionThree
	if_equal  4, .PositionFour
	if_equal  5, .PositionFive
	if_equal  6, .PositionSix
	if_equal  7, .PositionSeven
	if_equal  8, .PositionEight
	if_equal  9, .PositionNine
	if_equal 10, .PositionTen
.Static:
	return

.PositionOne:
	moveperson ILEXFOREST_FARFETCHD, $10, $21
	appear ILEXFOREST_FARFETCHD
	return

.PositionTwo:
	moveperson ILEXFOREST_FARFETCHD, $11, $1b
	appear ILEXFOREST_FARFETCHD
	return

.PositionThree:
	moveperson ILEXFOREST_FARFETCHD, $16, $1a
	appear ILEXFOREST_FARFETCHD
	return

.PositionFour:
	moveperson ILEXFOREST_FARFETCHD, $1f, $18
	appear ILEXFOREST_FARFETCHD
	return

.PositionFive:
	moveperson ILEXFOREST_FARFETCHD, $1e, $21
	appear ILEXFOREST_FARFETCHD
	return

.PositionSix:
	moveperson ILEXFOREST_FARFETCHD, $1a, $25
	appear ILEXFOREST_FARFETCHD
	return

.PositionSeven:
	moveperson ILEXFOREST_FARFETCHD, $18, $21
	appear ILEXFOREST_FARFETCHD
	return

.PositionEight:
	moveperson ILEXFOREST_FARFETCHD, $11, $1f
	appear ILEXFOREST_FARFETCHD
	return

.PositionNine:
	moveperson ILEXFOREST_FARFETCHD, $c, $25
	appear ILEXFOREST_FARFETCHD
	return

.PositionTen:
	moveperson ILEXFOREST_FARFETCHD, $8, $1e
	appear ILEXFOREST_FARFETCHD
	return

IlexForestCharcoalApprenticeScript:
	faceplayer
	opentext
	checkevent EVENT_HERDED_FARFETCHD
	iftrue .DoneFarfetchd
	writetext UnknownText_0x6ef5c
	waitbutton
	closetext
	end

.DoneFarfetchd:
	writetext UnknownText_0x6f019
	waitbutton
	closetext
	end

IlexForestFarfetchdScript:
	copybytetovar FarfetchdPosition
	if_equal  1, .Position1
	if_equal  2, .Position2
	if_equal  3, .Position3
	if_equal  4, .Position4
	if_equal  5, .Position5
	if_equal  6, .Position6
	if_equal  7, .Position7
	if_equal  8, .Position8
	if_equal  9, .Position9
	if_equal 10, .Position10

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
	moveperson ILEXFOREST_FARFETCHD, $11, $1b
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 2
	end

.Position2:
	scall .CryAndCheckFacing
	if_equal DOWN, .Position2_Down
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos2_Pos3
	moveperson ILEXFOREST_FARFETCHD, $16, $1a
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 3
	end

.Position2_Down:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos2_Pos8
	moveperson ILEXFOREST_FARFETCHD, $11, $1f
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 8
	end

.Position3:
	scall .CryAndCheckFacing
	if_equal LEFT, .Position3_Left
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos3_Pos4
	moveperson ILEXFOREST_FARFETCHD, $1f, $18
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 4
	end

.Position3_Left:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos3_Pos2
	moveperson ILEXFOREST_FARFETCHD, $11, $1b
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 2
	end

.Position4:
	scall .CryAndCheckFacing
	if_equal UP, .Position4_Up
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos4_Pos5
	moveperson ILEXFOREST_FARFETCHD, $1e, $21
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 5
	end

.Position4_Up:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos4_Pos3
	moveperson ILEXFOREST_FARFETCHD, $16, $1a
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 3
	end

.Position5:
	scall .CryAndCheckFacing
	if_equal UP, .Position5_Up
	if_equal LEFT, .Position5_Left
	if_equal RIGHT, .Position5_Right
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos5_Pos6
	moveperson ILEXFOREST_FARFETCHD, $1a, $25
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 6
	end

.Position5_Left:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetchd_Pos5_Pos7
	moveperson ILEXFOREST_FARFETCHD, $18, $21
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 7
	end

.Position5_Up:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos5_Pos4_Up
	moveperson ILEXFOREST_FARFETCHD, $1f, $18
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 4
	end

.Position5_Right:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos5_Pos4_Right
	moveperson ILEXFOREST_FARFETCHD, $1f, $18
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 4
	end

.Position6:
	scall .CryAndCheckFacing
	if_equal RIGHT, .Position6_Right
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos6_Pos7
	moveperson ILEXFOREST_FARFETCHD, $18, $21
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 7
	end

.Position6_Right:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos6_Pos5
	moveperson ILEXFOREST_FARFETCHD, $1e, $21
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 5
	end

.Position7:
	scall .CryAndCheckFacing
	if_equal DOWN, .Position7_Down
	if_equal LEFT, .Position7_Left
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos7_Pos8
	moveperson ILEXFOREST_FARFETCHD, $11, $1f
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 8
	end

.Position7_Left:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos7_Pos6
	moveperson ILEXFOREST_FARFETCHD, $1a, $25
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 6
	end

.Position7_Down:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos7_Pos5
	moveperson ILEXFOREST_FARFETCHD, $1e, $21
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 5
	end

.Position8:
	scall .CryAndCheckFacing
	if_equal UP, .Position8_Up
	if_equal LEFT, .Position8_Left
	if_equal RIGHT, .Position8_Right
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos8_Pos9
	moveperson ILEXFOREST_FARFETCHD, $c, $25
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 9
	end

.Position8_Right:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos8_Pos7
	moveperson ILEXFOREST_FARFETCHD, $18, $21
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 7
	end

.Position8_Up:
.Position8_Left:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos8_Pos2
	moveperson ILEXFOREST_FARFETCHD, $11, $1b
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 2
	end

.Position9:
	scall .CryAndCheckFacing
	if_equal DOWN, .Position9_Down
	if_equal RIGHT, .Position9_Right
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos9_Pos10
	moveperson ILEXFOREST_FARFETCHD, $8, $1e
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 10
	appear ILEXFOREST_BLACK_BELT
	setevent EVENT_CHARCOAL_KILN_BOSS
	setevent EVENT_HERDED_FARFETCHD
	end

.Position9_Right:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos9_Pos8_Right
	moveperson ILEXFOREST_FARFETCHD, $11, $1f
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 8
	end

.Position9_Down:
	applymovement ILEXFOREST_FARFETCHD, MovementData_Farfetched_Pos9_Pos8_Down
	moveperson ILEXFOREST_FARFETCHD, $11, $1f
	disappear ILEXFOREST_FARFETCHD
	appear ILEXFOREST_FARFETCHD
	loadvar FarfetchdPosition, 8
	end

.Position10:
	faceplayer
	opentext
	writetext Text_Kwaaaa
	cry FARFETCH_D
	waitbutton
	closetext
	end

.CryAndCheckFacing:
	faceplayer
	opentext
	writetext Text_Kwaaaa
	cry FARFETCH_D
	waitbutton
	closetext
	checkcode VAR_FACING
	end

IlexForestFinishCelebiEventScript:
	setevent EVENT_TIME_TRAVEL_FINISHED
	clearevent EVENT_TIME_TRAVELING
	dotrigger $0
	pause 30
	showemote EMOTE_SHOCK, ILEXFOREST_LYRA, 15
	applymovement ILEXFOREST_LYRA, MovementData_LyraStepDown
	spriteface ILEXFOREST_LYRA, RIGHT
	spriteface PLAYER, LEFT
	opentext
	writetext Text_IlexForestLyraWorried
	waitbutton
	writetext Text_IlexForestLyraArmorSuit
	waitbutton
	closetext
	follow ILEXFOREST_LYRA, PLAYER
	applymovement ILEXFOREST_LYRA, MovementData_LyraStepUp
	stopfollow
	spriteface PLAYER, UP
	spriteface ILEXFOREST_LYRA, DOWN
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
	iffalse .NoRoom
	setevent EVENT_GOT_ARMOR_SUIT
	writetext Text_IlexForestLyraGoodbye
	waitbutton
	closetext
	checkcode VAR_FACING
	if_equal LEFT, .NotBlockingPath
	applymovement PLAYER, MovementData_PlayerStepAside
.NotBlockingPath
	applymovement ILEXFOREST_LYRA, MovementData_IlexForestLyraLeaves
	disappear ILEXFOREST_LYRA
	end

.NoRoom:
	closetext
	end

IlexForestCharcoalMasterScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HM01_CUT
	iftrue .AlreadyGotCut
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

.AlreadyGotCut:
	writetext Text_CharcoalMasterTalkAfter
	waitbutton
	closetext
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
	if_equal $0, .TeachMove
.TutorRefused
	writetext Text_IlexForestTutorRefused
	waitbutton
	closetext
	end

.NoSilverLeaf
	writetext Text_IlexForestTutorNoSilverLeaf
	waitbutton
	closetext
	end

.TeachMove
	takeitem SILVER_LEAF
	writetext Text_IlexForestTutorTaught
	waitbutton
	closetext
	end

TrainerBug_catcherWayne:
	trainer EVENT_BEAT_BUG_CATCHER_WAYNE, BUG_CATCHER, WAYNE, Bug_catcherWayneSeenText, Bug_catcherWayneBeatenText, 0, Bug_catcherWayneScript

Bug_catcherWayneScript:
	end_if_just_battled
	opentext
	writetext Bug_catcherWayneAfterText
	waitbutton
	closetext
	end

IlexForestLassScript:
	jumptextfaceplayer Text_IlexForestLass

IlexForestRevive:
	itemball REVIVE

IlexForestXAttack:
	itemball X_ATTACK

IlexForestAntidote:
	itemball ANTIDOTE

IlexForestMulch:
	itemball MULCH

IlexForestHiddenEther:
	dwb EVENT_ILEX_FOREST_HIDDEN_ETHER, ETHER

IlexForestHiddenSuperPotion:
	dwb EVENT_ILEX_FOREST_HIDDEN_SUPER_POTION, SUPER_POTION

IlexForestHiddenFullHeal:
	dwb EVENT_ILEX_FOREST_HIDDEN_FULL_HEAL, FULL_HEAL

IlexForestHiddenSilverLeaf1:
	dwb EVENT_ILEX_FOREST_HIDDEN_SILVER_LEAF_1, SILVER_LEAF

IlexForestHiddenSilverLeaf2:
	dwb EVENT_ILEX_FOREST_HIDDEN_SILVER_LEAF_2, SILVER_LEAF

MapIlexForestMossRockScript:
	jumptext Text_IlexForestMossRock

MapIlexForestSignpost0Script:
	jumptext Text_IlexForestSignpost0

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
	closetext
	end

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
	spriteface PLAYER, DOWN
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
	opentext
	writetext Text_KurtCaughtCelebi
	waitbutton
	closetext
	applymovement ILEXFOREST_KURT, MovementData_0x6ef53
	disappear ILEXFOREST_KURT
.DidntCatchCelebi:
	end

.StartGiovanniEvent:
	opentext
	writetext Text_IlexForestShrine
	waitbutton
	closetext
	showemote EMOTE_SHOCK, PLAYER, 15
	appear ILEXFOREST_CELEBI
	playsound SFX_BALL_POOF
	spriteface PLAYER, DOWN
	waitsfx
	pause 15
	cry CELEBI
	waitsfx
	pause 15
	applymovement ILEXFOREST_CELEBI, MovementData_CelebiDance
	pause 15
	opentext
	writetext Text_CelebiDancedBeautifully
	waitbutton
	closetext
	playsound SFX_JUMP_OVER_LEDGE
	applymovement ILEXFOREST_CELEBI, MovementData_CelebiHop
	applymovement PLAYER, MovementData_PlayerFollowCelebi
	waitsfx
	special Special_FadeOutMusic
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	moveperson ILEXFOREST_LYRA, $5, $1a
	appear ILEXFOREST_LYRA
	applymovement ILEXFOREST_LYRA, MovementData_IlexForestLyraApproaches
	spriteface PLAYER, LEFT
	opentext
	writetext Text_IlexForestLyraHello
	waitbutton
	closetext
	special RestartMapMusic
	pause 30
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	spriteface ILEXFOREST_CELEBI, DOWN
	pause 30
	special FadeInPalettes
	waitsfx
	showemote EMOTE_SHOCK, PLAYER, 15
	spriteface PLAYER, UP
	pause 15
	spriteface ILEXFOREST_LYRA, UP
	spriteface PLAYER, DOWN
	pause 15
	spriteface ILEXFOREST_LYRA, RIGHT
	spriteface PLAYER, LEFT
	opentext
	writetext Text_IlexForestLyraWhatWasThat
	waitbutton
	closetext
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
	warp ROUTE_22_PAST, $6, $7
	end

IlexForestCutTree:
	jumpstd cuttree

MovementData_Farfetchd_Pos1_Pos2:
	big_step_up
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

MovementData_Farfetchd_Pos2_Pos8:
	big_step_down
	big_step_down
	big_step_down
	big_step_down
	big_step_down
	step_end

MovementData_Farfetchd_Pos3_Pos4:
	big_step_right
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

MovementData_Farfetchd_Pos4_Pos5:
	big_step_down
	big_step_down
	big_step_down
	big_step_down
	big_step_down
	big_step_down
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
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	step_end

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

MovementData_Farfetched_Pos7_Pos5:
	big_step_right
	big_step_right
	big_step_right
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

MovementData_Farfetched_Pos8_Pos7:
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	step_end

MovementData_Farfetched_Pos8_Pos2:
	big_step_up
	big_step_up
	big_step_up
	big_step_up
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
MovementData_LyraStepUp:
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

MovementData_PlayerFollowCelebi:
MovementData_LyraStepDown:
	slow_step_down
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

Bug_catcherWayneAfterText:
	text "A #mon I've"
	line "never seen before"

	para "fell out of the"
	line "tree when I used"
	cont "Headbutt."

	para "I ought to use"
	line "Headbutt in other"
	cont "places too."
	done

IlexForest_MapEventHeader:
.Warps:
	db 3
	warp_def $7, $3, 3, ROUTE_34_ILEX_FOREST_GATE
	warp_def $2c, $5, 1, ILEX_FOREST_AZALEA_GATE
	warp_def $2d, $5, 2, ILEX_FOREST_AZALEA_GATE

.XYTriggers:
	db 0

.Signposts:
	db 8
	signpost 19, 5, SIGNPOST_READ, MapIlexForestSignpost0Script
	signpost 9, 13, SIGNPOST_ITEM, IlexForestHiddenEther
	signpost 16, 24, SIGNPOST_ITEM, IlexForestHiddenSuperPotion
	signpost 19, 3, SIGNPOST_ITEM, IlexForestHiddenFullHeal
	signpost 9, 20, SIGNPOST_READ, MapIlexForestMossRockScript
	signpost 24, 10, SIGNPOST_UP, MapIlexForestSignpost4Script
	signpost 24, 25, SIGNPOST_ITEM, IlexForestHiddenSilverLeaf1
	signpost 8, 19, SIGNPOST_ITEM, IlexForestHiddenSilverLeaf2

.PersonEvents:
	db 14
	person_event SPRITE_BALL_CUT_FRUIT, 27, 10, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, IlexForestCutTree, EVENT_ILEX_FOREST_CUT_TREE
	person_event SPRITE_FARFETCH_D, 33, 16, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, IlexForestFarfetchdScript, EVENT_ILEX_FOREST_FARFETCHD
	person_event SPRITE_YOUNGSTER, 30, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, IlexForestCharcoalApprenticeScript, EVENT_ILEX_FOREST_APPRENTICE
	person_event SPRITE_BLACK_BELT, 30, 7, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, IlexForestCharcoalMasterScript, EVENT_ILEX_FOREST_CHARCOAL_MASTER
	person_event SPRITE_ROCKER, 16, 17, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, IlexForestHeadbuttGuyScript, -1
	person_event SPRITE_BALL_CUT_FRUIT, 34, 22, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, IlexForestRevive, EVENT_ILEX_FOREST_REVIVE
	person_event SPRITE_KURT, 31, 10, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ILEX_FOREST_KURT
	person_event SPRITE_LASS, 26, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, IlexForestLassScript, EVENT_ILEX_FOREST_LASS
	person_event SPRITE_BUG_CATCHER, 3, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 0, TrainerBug_catcherWayne, -1
	person_event SPRITE_BALL_CUT_FRUIT, 19, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, IlexForestXAttack, EVENT_ILEX_FOREST_X_ATTACK
	person_event SPRITE_BALL_CUT_FRUIT, 17, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, IlexForestAntidote, EVENT_ILEX_FOREST_ANTIDOTE
	person_event SPRITE_BALL_CUT_FRUIT, 3, 29, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, IlexForestMulch, EVENT_ILEX_FOREST_MULCH
	person_event SPRITE_CELEBI, 26, 10, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ILEX_FOREST_CELEBI
	person_event SPRITE_LYRA, 25, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, IlexForestLyraScript, EVENT_ILEX_FOREST_LYRA
