UndergroundPathSwitchRoomEntrances_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL_BATTLE
	scene_const SCENE_UNDERGROUNDPATHSWITCHROOMENTRANCES_NOOP

	def_callbacks
	callback MAPCALLBACK_TILES, UndergroundPathSwitchRoomEntrancesUpdateDoorPositions

	def_warp_events
	warp_event 23,  3, WAREHOUSE_ENTRANCE, 6
	warp_event 22, 10, UNDERGROUND_WAREHOUSE, 1
	warp_event 23, 10, UNDERGROUND_WAREHOUSE, 2
	warp_event  5, 23, WAREHOUSE_ENTRANCE, 2
	warp_event  4, 27, GOLDENROD_CITY, 14
	warp_event  5, 27, GOLDENROD_CITY, 14
	warp_event 21, 23, WAREHOUSE_ENTRANCE, 1
	warp_event 20, 27, GOLDENROD_CITY, 13
	warp_event 21, 27, GOLDENROD_CITY, 13
	warp_event  5, 37, WAREHOUSE_ENTRANCE, 7
	warp_event  4, 41, GOLDENROD_CITY, 22
	warp_event  5, 41, GOLDENROD_CITY, 22

	def_coord_events
	coord_event 19,  4, SCENE_UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL_BATTLE, UndergroundRivalTrigger1
	coord_event 19,  5, SCENE_UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL_BATTLE, UndergroundRivalTrigger2

	def_bg_events
	bg_event 16,  1, BGEVENT_READ, Switch1Script
	bg_event 10,  1, BGEVENT_READ, Switch2Script
	bg_event  2,  1, BGEVENT_READ, Switch3Script
	bg_event 20, 11, BGEVENT_READ, EmergencySwitchScript
	bg_event  8,  9, BGEVENT_ITEM + MAX_POTION, EVENT_UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES_HIDDEN_MAX_POTION
	bg_event  1,  8, BGEVENT_ITEM + REVIVE, EVENT_UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES_HIDDEN_REVIVE

	def_object_events
	object_event 23,  3, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_UNDERGROUND_PATH
	object_event  9, 12, SPRITE_BURGLAR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBurglarDuncan, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  4,  8, SPRITE_BURGLAR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBurglarOrson, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 17,  2, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM13, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 11,  2, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM11, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  3,  2, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM25, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 19, 12, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerGruntF3, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  3, 25, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, UndergroundPathSwitchRoomEntrances_TeacherText, -1
	object_event  8, 24, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, UndergroundPathSwitchRoomEntrances_SuperNerd1Text, -1
	object_event 19, 25, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, UndergroundPathSwitchRoomEntrances_SuperNerd2Text, -1
	object_event  1, 39, SPRITE_VETERAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GRAY, OBJECTTYPE_SCRIPT, 0, UndergroundPathSwitchRoomEntrancesVeteranMScript, -1
	object_event  8, 38, SPRITE_BEAUTY, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, UndergroundPathSwitchRoomEntrances_BeautyText, -1
	itemball_event  1, 12, SMOKE_BALL, 1, EVENT_UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES_SMOKE_BALL
	itemball_event 14,  9, FULL_HEAL, 1, EVENT_UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES_FULL_HEAL

	object_const_def
	const UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL

DEF UNDERGROUND_DOOR_CLOSED1 EQU $2a
DEF UNDERGROUND_DOOR_CLOSED2 EQU $3e
DEF UNDERGROUND_DOOR_CLOSED3 EQU $3f
DEF UNDERGROUND_DOOR_OPEN1   EQU $2d
DEF UNDERGROUND_DOOR_OPEN2   EQU $3d

MACRO ugdoor
	DEF \1_YCOORD EQU \2
	DEF \1_XCOORD EQU \3
ENDM

	ugdoor UGDOOR_1,  $10, $06
	ugdoor UGDOOR_2,  $0a, $06
	ugdoor UGDOOR_3,  $02, $06
	ugdoor UGDOOR_4,  $02, $0a
	ugdoor UGDOOR_5,  $0a, $0a
	ugdoor UGDOOR_6,  $10, $0a
	ugdoor UGDOOR_7,  $0c, $06
	ugdoor UGDOOR_8,  $0c, $08
	ugdoor UGDOOR_9,  $06, $06
	ugdoor UGDOOR_10, $06, $08
	ugdoor UGDOOR_11, $0c, $0a
	ugdoor UGDOOR_12, $0c, $0c
	ugdoor UGDOOR_13, $06, $0a
	ugdoor UGDOOR_14, $06, $0c
	ugdoor UGDOOR_15, $12, $0a
	ugdoor UGDOOR_16, $12, $0c

MACRO doorstate
	changeblock UGDOOR_\1_YCOORD, UGDOOR_\1_XCOORD, UNDERGROUND_DOOR_\2
ENDM

UndergroundPathSwitchRoomEntrancesUpdateDoorPositions:
	checkevent EVENT_SWITCH_4
	iffalsefwd .false4
	doorstate 1, OPEN1
.false4
	checkevent EVENT_SWITCH_5
	iffalsefwd .false5
	doorstate 2, OPEN1
.false5
	checkevent EVENT_SWITCH_6
	iffalsefwd .false6
	doorstate 3, OPEN1
.false6
	checkevent EVENT_SWITCH_7
	iffalsefwd .false7
	doorstate 4, OPEN1
.false7
	checkevent EVENT_SWITCH_8
	iffalsefwd .false8
	doorstate 5, OPEN1
.false8
	checkevent EVENT_SWITCH_9
	iffalsefwd .false9
	doorstate 6, OPEN1
.false9
	checkevent EVENT_SWITCH_10
	iffalsefwd .false10
	doorstate 7, CLOSED1
	doorstate 8, OPEN1
.false10
	checkevent EVENT_SWITCH_11
	iffalsefwd .false11
	doorstate 9, CLOSED1
	doorstate 10, OPEN1
.false11
	checkevent EVENT_SWITCH_12
	iffalsefwd .false12
	doorstate 11, CLOSED1
	doorstate 12, OPEN1
.false12
	checkevent EVENT_SWITCH_13
	iffalsefwd .false13
	doorstate 13, CLOSED1
	doorstate 14, OPEN1
.false13
	checkevent EVENT_SWITCH_14
	iffalsefwd .false14
	doorstate 15, CLOSED1
	doorstate 16, OPEN1
.false14
	endcallback

UndergroundRivalTrigger1:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	playsound SFX_EXIT_BUILDING
	appear UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL
	waitsfx
	applymovement UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL, UndergroundRivalApproachMovement1
	turnobject PLAYER, RIGHT
	scall UndergroundRivalBattleScript
	applymovement UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL, UndergroundRivalRetreatMovement1
	playsound SFX_EXIT_BUILDING
	disappear UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL
	setscene SCENE_UNDERGROUNDPATHSWITCHROOMENTRANCES_NOOP
	waitsfx
	playmapmusic
	end

UndergroundRivalTrigger2:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	playsound SFX_EXIT_BUILDING
	appear UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL
	waitsfx
	applymovement UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL, UndergroundRivalApproachMovement2
	turnobject PLAYER, RIGHT
	scall UndergroundRivalBattleScript
	applymovement UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL, UndergroundRivalRetreatMovement2
	playsound SFX_EXIT_BUILDING
	disappear UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL
	setscene SCENE_UNDERGROUNDPATHSWITCHROOMENTRANCES_NOOP
	waitsfx
	playmapmusic
	end

UndergroundRivalBattleScript:
	checkevent EVENT_RIVAL_BURNED_TOWER
	iftruefwd .Continue
	setevent EVENT_RIVAL_BURNED_TOWER
	setmapscene BURNED_TOWER_1F, SCENE_BURNEDTOWER1F_RIVAL_BATTLE
.Continue:
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext UndergroundRivalBeforeText
	setevent EVENT_RIVAL_UNDERGROUND_PATH
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftruefwd .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftruefwd .Chikorita
	winlosstext UndergroundRivalWinText, UndergroundRivalLossText
	setlasttalked UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL
	loadtrainer RIVAL1, RIVAL1_12
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjumpfwd .FinishRivalBattle

.Totodile:
	winlosstext UndergroundRivalWinText, UndergroundRivalLossText
	setlasttalked UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL
	loadtrainer RIVAL1, RIVAL1_10
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjumpfwd .FinishRivalBattle

.Chikorita:
	winlosstext UndergroundRivalWinText, UndergroundRivalLossText
	setlasttalked UNDERGROUNDPATHSWITCHROOMENTRANCES_RIVAL
	loadtrainer RIVAL1, RIVAL1_11
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	; fallthrough

.FinishRivalBattle:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	jumptext UndergroundRivalAfterText

GenericTrainerGruntM11:
	generictrainer GRUNTM, 11, EVENT_BEAT_ROCKET_GRUNTM_11, GruntM11SeenText, GruntM11BeatenText

	text "I'm confused too…"
	line "The switch on the"

	para "end is the one to"
	line "press first, but…"
	done

GenericTrainerGruntM25:
	generictrainer GRUNTM, 25, EVENT_BEAT_ROCKET_GRUNTM_25, GruntM25SeenText, GruntM25BeatenText

	text "All right. A hint!"

	para "Change the order"
	line "of switching."

	para "That'll change the"
	line "ways the shutters"
	cont "open and close."
	done

GenericTrainerBurglarDuncan:
	generictrainer BURGLAR, DUNCAN, EVENT_BEAT_BURGLAR_DUNCAN, BurglarDuncanSeenText, BurglarDuncanBeatenText

	text "Steal and sell!"
	line "That's basic in"
	cont "crime, kid!"
	done

GenericTrainerBurglarOrson:
	generictrainer BURGLAR, ORSON, EVENT_BEAT_BURGLAR_ORSON, BurglarOrsonSeenText, BurglarOrsonBeatenText

	text "Underground Ware-"
	line "house?"

	para "What do you want"
	line "to go there for?"

	para "There's nothing"
	line "down there."
	done

GenericTrainerGruntM13:
	generictrainer GRUNTM, 13, EVENT_BEAT_ROCKET_GRUNTM_13, GruntM13SeenText, GruntM13BeatenText

	text "You must have ice"
	line "in your veins to"
	cont "dis Team Rocket."
	done

GenericTrainerGruntF3:
	generictrainer GRUNTF, 3, EVENT_BEAT_ROCKET_GRUNTF_3, GruntF3SeenText, GruntF3BeatenText

	text "Go wherever you'd"
	line "like! Get lost!"
	cont "See if I care!"
	done

Switch1Script:
	opentext
	writetext SwitchRoomText_Switch1
	promptbutton
	checkevent EVENT_SWITCH_1
	iftruefwd .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalsefwd UndergroundPathSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval 1
	writemem wUndergroundSwitchPositions
	setevent EVENT_SWITCH_1
	sjumpfwd UndergroundPathSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalsefwd UndergroundPathSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval -1
	writemem wUndergroundSwitchPositions
	clearevent EVENT_SWITCH_1
	sjumpfwd UndergroundPathSwitchRoomEntrances_UpdateDoors

Switch2Script:
	opentext
	writetext SwitchRoomText_Switch2
	promptbutton
	checkevent EVENT_SWITCH_2
	iftruefwd .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalsefwd UndergroundPathSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval 2
	writemem wUndergroundSwitchPositions
	setevent EVENT_SWITCH_2
	sjumpfwd UndergroundPathSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalsefwd UndergroundPathSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval -2
	writemem wUndergroundSwitchPositions
	clearevent EVENT_SWITCH_2
	sjumpfwd UndergroundPathSwitchRoomEntrances_UpdateDoors

Switch3Script:
	opentext
	writetext SwitchRoomText_Switch3
	promptbutton
	checkevent EVENT_SWITCH_3
	iftruefwd .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalsefwd UndergroundPathSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval 3
	writemem wUndergroundSwitchPositions
	setevent EVENT_SWITCH_3
	sjumpfwd UndergroundPathSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalsefwd UndergroundPathSwitchRoomEntrances_DontToggle
	readmem wUndergroundSwitchPositions
	addval -3
	writemem wUndergroundSwitchPositions
	clearevent EVENT_SWITCH_3
	sjumpfwd UndergroundPathSwitchRoomEntrances_UpdateDoors

EmergencySwitchScript:
	opentext
	writetext SwitchRoomText_Emergency
	promptbutton
	checkevent EVENT_EMERGENCY_SWITCH
	iftruefwd .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalsefwd UndergroundPathSwitchRoomEntrances_DontToggle
	setval 7
	writemem wUndergroundSwitchPositions
	setevent EVENT_EMERGENCY_SWITCH
	setevent EVENT_SWITCH_1
	setevent EVENT_SWITCH_2
	setevent EVENT_SWITCH_3
	sjumpfwd UndergroundPathSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalsefwd UndergroundPathSwitchRoomEntrances_DontToggle
	setval 0
	writemem wUndergroundSwitchPositions
	clearevent EVENT_EMERGENCY_SWITCH
	clearevent EVENT_SWITCH_1
	clearevent EVENT_SWITCH_2
	clearevent EVENT_SWITCH_3
	sjumpfwd UndergroundPathSwitchRoomEntrances_UpdateDoors

UndergroundPathSwitchRoomEntrances_DontToggle:
	endtext

UndergroundPathSwitchRoomEntrances_UpdateDoors:
	readmem wUndergroundSwitchPositions
	ifequalfwd 0, .Position0
	ifequalfwd 1, .Position1
	ifequalfwd 2, .Position2
	ifequalfwd 3, .Position3
	ifequalfwd 4, .Position4
	ifequalfwd 5, .Position5
	ifequalfwd 6, .Position6
	ifequalfwd 7, .EmergencyPosition
.Position0:
	playsound SFX_ENTER_DOOR
	scall .Clear4
	scall .Clear5
	scall .Clear6
	scall .Clear7
	scall .Clear8
	scall .Clear9
	scall .Clear10
	scall .Clear11
	scall .Clear12
	scall .Clear13
	scall .Clear14
	refreshmap
	endtext

.Position1:
	playsound SFX_ENTER_DOOR
	scall .Set4
	scall .Set10
	scall .Set13
	scall .Clear9
	scall .Clear11
	scall .Clear12
	scall .Clear14
	refreshmap
	endtext

.Position2:
	playsound SFX_ENTER_DOOR
	scall .Set5
	scall .Set11
	scall .Set12
	scall .Clear8
	scall .Clear10
	scall .Clear13
	scall .Clear14
	refreshmap
	endtext

.Position3:
	playsound SFX_ENTER_DOOR
	scall .Set6
	scall .Set10
	scall .Set13
	scall .Clear7
	scall .Clear11
	scall .Clear12
	scall .Clear14
	refreshmap
	endtext

.Position4:
	playsound SFX_ENTER_DOOR
	scall .Set7
	scall .Set11
	scall .Set12
	scall .Clear6
	scall .Clear10
	scall .Clear13
	scall .Clear14
	refreshmap
	endtext

.Position5:
	playsound SFX_ENTER_DOOR
	scall .Set8
	scall .Set10
	scall .Set13
	scall .Clear5
	scall .Clear11
	scall .Clear12
	scall .Clear14
	refreshmap
	endtext

.Position6:
	playsound SFX_ENTER_DOOR
	scall .Set9
	scall .Set11
	scall .Set12
	scall .Set14
	scall .Clear4
	scall .Clear10
	scall .Clear13
	refreshmap
	endtext

.EmergencyPosition:
	playsound SFX_ENTER_DOOR
	scall .Clear4
	scall .Clear5
	scall .Set6
	scall .Clear7
	scall .Set8
	scall .Set9
	scall .Clear10
	scall .Set11
	scall .Set12
	scall .Clear13
	scall .Set14
	refreshmap
	closetext
	setval 6
	writemem wUndergroundSwitchPositions
	end

.Set4:
	doorstate 1, OPEN1
	setevent EVENT_SWITCH_4
	end

.Set5:
	doorstate 2, OPEN1
	setevent EVENT_SWITCH_5
	end

.Set6:
	doorstate 3, OPEN1
	setevent EVENT_SWITCH_6
	end

.Set7:
	doorstate 4, OPEN1
	setevent EVENT_SWITCH_7
	end

.Set8:
	doorstate 5, OPEN1
	setevent EVENT_SWITCH_8
	end

.Set9:
	doorstate 6, OPEN1
	setevent EVENT_SWITCH_9
	end

.Set10:
	doorstate 7, CLOSED1
	doorstate 8, OPEN1
	setevent EVENT_SWITCH_10
	end

.Set11:
	doorstate 9, CLOSED1
	doorstate 10, OPEN1
	setevent EVENT_SWITCH_11
	end

.Set12:
	doorstate 11, CLOSED1
	doorstate 12, OPEN1
	setevent EVENT_SWITCH_12
	end

.Set13:
	doorstate 13, CLOSED1
	doorstate 14, OPEN1
	setevent EVENT_SWITCH_13
	end

.Set14:
	doorstate 15, CLOSED1
	doorstate 16, OPEN1
	setevent EVENT_SWITCH_14
	end

.Clear4:
	doorstate 1, CLOSED2
	clearevent EVENT_SWITCH_4
	end

.Clear5:
	doorstate 2, CLOSED2
	clearevent EVENT_SWITCH_5
	end

.Clear6:
	doorstate 3, CLOSED2
	clearevent EVENT_SWITCH_6
	end

.Clear7:
	doorstate 4, CLOSED2
	clearevent EVENT_SWITCH_7
	end

.Clear8:
	doorstate 5, CLOSED2
	clearevent EVENT_SWITCH_8
	end

.Clear9:
	doorstate 6, CLOSED2
	clearevent EVENT_SWITCH_9
	end

.Clear10:
	doorstate 7, CLOSED3
	doorstate 8, OPEN2
	clearevent EVENT_SWITCH_10
	end

.Clear11:
	doorstate 9, CLOSED3
	doorstate 10, OPEN2
	clearevent EVENT_SWITCH_11
	end

.Clear12:
	doorstate 11, CLOSED3
	doorstate 12, OPEN2
	clearevent EVENT_SWITCH_12
	end

.Clear13:
	doorstate 13, CLOSED3
	doorstate 14, OPEN2
	clearevent EVENT_SWITCH_13
	end

.Clear14:
	doorstate 15, CLOSED3
	doorstate 16, OPEN2
	clearevent EVENT_SWITCH_14
	end

UndergroundRivalApproachMovement1:
	step_down
	step_left
	step_left
	step_left
	step_end

UndergroundRivalApproachMovement2:
	step_down
	step_down
	step_left
	step_left
	step_left
	step_end

UndergroundRivalRetreatMovement1:
	step_right
	step_right
	step_right
	step_up
	step_end

UndergroundRivalRetreatMovement2:
	step_right
	step_right
	step_right
	step_up
	step_up
	step_end

UndergroundPathSwitchRoomEntrancesVeteranMScript:
	checkevent EVENT_GOT_LOADED_DICE_FROM_GOLDENROD
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem LOADED_DICE
	iffalse_endtext
	setevent EVENT_GOT_LOADED_DICE_FROM_GOLDENROD
	jumpthisopenedtext

.Text2:
	text "In the long run,"
	line "the house always"
	cont "wins…"
	done

.Text1:
	text "I tried to use"
	line "this item in the"

	para "Game Corner, but"
	line "they caught me."

	para "You may as well"
	line "take it."
	done

UndergroundRivalBeforeText:
	text "Hold it!"

	para "I saw you, so I"
	line "tailed you."

	para "I don't need you"
	line "underfoot while I"

	para "take care of Team"
	line "Rocket."

	para "…Wait a second."
	line "You beat me be-"
	cont "fore, didn't you?"

	para "That was just a"
	line "fluke."

	para "But I repay my"
	line "debts!"
	done

UndergroundRivalWinText:
	text "…Why…"
	line "Why do I lose?"

	para "I've assembled the"
	line "toughest #mon."

	para "I didn't ease up"
	line "on the gas."

	para "So why do I lose?"
	done

UndergroundRivalAfterText:
	text "…I don't under-"
	line "stand…"

	para "Is what that Lance"
	line "guy said true?"

	para "That I don't treat"
	line "#mon properly?"

	para "Love…"

	para "Trust…"

	para "Are they really"
	line "what I lack?"

	para "Are they keeping"
	line "me from winning?"

	para "I… I just don't"
	line "understand."

	para "But it's not going"
	line "to end here."

	para "Not now. Not"
	line "because of this."

	para "I won't give up my"
	line "dream of becoming"

	para "the world's best"
	line "#mon trainer!"
	done

UndergroundRivalLossText:
	text "Humph. This is my"
	line "real power, wimp."

	para "I'll make Team"
	line "Rocket history."

	para "And I'm going to"
	line "grind that Lance"
	cont "under my heels."
	done

UndergroundPathSwitchRoomEntrances_TeacherText:
	text "There are some"
	line "shops downstairs…"

	para "But there are"
	line "also trainers."

	para "I'm scared to go"
	line "down there."
	done

UndergroundPathSwitchRoomEntrances_SuperNerd1Text:
	text "This tunnel was"
	line "originally made"
	cont "for deliveries to"

	para "the department"
	line "store."

	para "It's a nice short-"
	line "cut across the"
	cont "city too."
	done

UndergroundPathSwitchRoomEntrances_SuperNerd2Text:
	text "I was challenged"
	line "to a battle down-"
	cont "stairs."

	para "It's rough down"
	line "there. You'd"
	cont "better be careful."
	done

UndergroundPathSwitchRoomEntrances_BeautyText:
	text "I went on a tour"
	line "of the Radio"

	para "Tower. I saw all"
	line "three studios and"

	para "even ate in the"
	line "café."
	done

GruntM11SeenText:
	text "Open one shutter,"
	line "another closes."

	para "Bet you can't get"
	line "where you want!"
	done

GruntM11BeatenText:
	text "Drat! I was sunk"
	line "by indecision!"
	done

GruntM25SeenText:
	text "Kwahaha!"

	para "Confounded by the"
	line "shutters, are we?"

	para "I'll let you in on"
	line "a secret if you"
	cont "can beat me!"
	done

GruntM25BeatenText:
	text "Uwww…"
	line "I blew it."
	done

BurglarDuncanSeenText:
	text "Fork over your"
	line "goodies!"
	done

BurglarDuncanBeatenText:
	text "Mercy!"
	done

BurglarOrsonSeenText:
	text "They ditched this"
	line "project before"
	cont "they finished."

	para "I'm searching for"
	line "leftover loot."
	done

BurglarOrsonBeatenText:
	text "Over the top!"
	done

GruntM13SeenText:
	text "I don't care if"
	line "you're lost."

	para "You show up here,"
	line "you're nothing but"
	cont "a victim!"
	done

GruntM13BeatenText:
	text "Urk! Yeah, think"
	line "you're cool, huh?"
	done

SwitchRoomText_Switch1:
	text "It's labeled"
	line "Switch 1."
	done

GruntF3SeenText:
	text "Are you lost? No,"
	line "you can't be."

	para "You don't have"
	line "that scared look."

	para "I'll give you"
	line "something to be"
	cont "scared about!"
	done

GruntF3BeatenText:
	text "How could you?"
	done

SwitchRoomText_OffTurnOn:
	text "It's off."
	line "Turn it on?"
	done

SwitchRoomText_OnTurnOff:
	text "It's on."
	line "Turn it off?"
	done

SwitchRoomText_Switch2:
	text "It's labeled"
	line "Switch 2."
	done

SwitchRoomText_Switch3:
	text "It's labeled"
	line "Switch 3."
	done

SwitchRoomText_Emergency:
	text "It's labeled"
	line "Emergency."
	done
