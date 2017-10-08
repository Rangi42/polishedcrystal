UndergroundPathSwitchRoomEntrances_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, UndergroundPathSwitchRoomEntrancesUpdateDoorPositions

UndergroundPathSwitchRoomEntrances_MapEventHeader:

.Warps: db 9
	warp_def 3, 23, 6, WAREHOUSE_ENTRANCE
	warp_def 10, 22, 1, UNDERGROUND_WAREHOUSE
	warp_def 10, 23, 2, UNDERGROUND_WAREHOUSE
	warp_def 23, 5, 2, WAREHOUSE_ENTRANCE
	warp_def 27, 4, 14, GOLDENROD_CITY
	warp_def 27, 5, 14, GOLDENROD_CITY
	warp_def 23, 21, 1, WAREHOUSE_ENTRANCE
	warp_def 27, 20, 13, GOLDENROD_CITY
	warp_def 27, 21, 13, GOLDENROD_CITY

.XYTriggers: db 2
	xy_trigger 0, 4, 19, UndergroundSilverTrigger1
	xy_trigger 0, 5, 19, UndergroundSilverTrigger2

.Signposts: db 6
	signpost 1, 16, SIGNPOST_READ, Switch1Script
	signpost 1, 10, SIGNPOST_READ, Switch2Script
	signpost 1, 2, SIGNPOST_READ, Switch3Script
	signpost 11, 20, SIGNPOST_READ, EmergencySwitchScript
	signpost 9, 8, SIGNPOST_ITEM + MAX_POTION, EVENT_UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES_HIDDEN_MAX_POTION
	signpost 8, 1, SIGNPOST_ITEM + REVIVE, EVENT_UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES_HIDDEN_REVIVE

.PersonEvents: db 12
	person_event SPRITE_SILVER, 3, 23, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_UNDERGROUND_PATH
	person_event SPRITE_PHARMACIST, 12, 9, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerBurglarDuncan, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_PHARMACIST, 8, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerBurglarOrson, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 2, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM13, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 2, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM11, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 2, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM25, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET_GIRL, 12, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerGruntF3, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_TEACHER, 25, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UndergroundPathSwitchRoomEntrances_TeacherText, -1
	person_event SPRITE_SUPER_NERD, 24, 8, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UndergroundPathSwitchRoomEntrances_SuperNerd1Text, -1
	person_event SPRITE_SUPER_NERD, 25, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UndergroundPathSwitchRoomEntrances_SuperNerd2Text, -1
	itemball_event 12, 1, SMOKE_BALL, 1, EVENT_UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES_SMOKE_BALL
	itemball_event 9, 14, FULL_HEAL, 1, EVENT_UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES_FULL_HEAL

const_value set 1
	const UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER

UNDERGROUND_DOOR_CLOSED1 EQU $2a
UNDERGROUND_DOOR_CLOSED2 EQU $3e
UNDERGROUND_DOOR_CLOSED3 EQU $3f
UNDERGROUND_DOOR_OPEN1   EQU $2d
UNDERGROUND_DOOR_OPEN2   EQU $3d

ugdoor: macro
\1_YCOORD EQU \2
\1_XCOORD EQU \3
endm

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

doorstate: macro
	changeblock UGDOOR_\1_YCOORD, UGDOOR_\1_XCOORD, UNDERGROUND_DOOR_\2
endm

UndergroundPathSwitchRoomEntrancesUpdateDoorPositions:
	checkevent EVENT_SWITCH_4
	iffalse .false4
	doorstate 1, OPEN1
.false4
	checkevent EVENT_SWITCH_5
	iffalse .false5
	doorstate 2, OPEN1
.false5
	checkevent EVENT_SWITCH_6
	iffalse .false6
	doorstate 3, OPEN1
.false6
	checkevent EVENT_SWITCH_7
	iffalse .false7
	doorstate 4, OPEN1
.false7
	checkevent EVENT_SWITCH_8
	iffalse .false8
	doorstate 5, OPEN1
.false8
	checkevent EVENT_SWITCH_9
	iffalse .false9
	doorstate 6, OPEN1
.false9
	checkevent EVENT_SWITCH_10
	iffalse .false10
	doorstate 7, CLOSED1
	doorstate 8, OPEN1
.false10
	checkevent EVENT_SWITCH_11
	iffalse .false11
	doorstate 9, CLOSED1
	doorstate 10, OPEN1
.false11
	checkevent EVENT_SWITCH_12
	iffalse .false12
	doorstate 11, CLOSED1
	doorstate 12, OPEN1
.false12
	checkevent EVENT_SWITCH_13
	iffalse .false13
	doorstate 13, CLOSED1
	doorstate 14, OPEN1
.false13
	checkevent EVENT_SWITCH_14
	iffalse .false14
	doorstate 15, CLOSED1
	doorstate 16, OPEN1
.false14
	return

UndergroundSilverTrigger1:
	spriteface PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	playsound SFX_EXIT_BUILDING
	appear UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER
	waitsfx
	applymovement UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER, UndergroundSilverApproachMovement1
	spriteface PLAYER, RIGHT
	scall UndergroundSilverBattleScript
	applymovement UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER, UndergroundSilverRetreatMovement1
	playsound SFX_EXIT_BUILDING
	disappear UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER
	dotrigger 1
	waitsfx
	playmapmusic
	end

UndergroundSilverTrigger2:
	spriteface PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	playsound SFX_EXIT_BUILDING
	appear UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER
	waitsfx
	applymovement UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER, UndergroundSilverApproachMovement2
	spriteface PLAYER, RIGHT
	scall UndergroundSilverBattleScript
	applymovement UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER, UndergroundSilverRetreatMovement2
	playsound SFX_EXIT_BUILDING
	disappear UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER
	dotrigger 1
	waitsfx
	playmapmusic
	end

UndergroundSilverBattleScript:
	checkevent EVENT_RIVAL_BURNED_TOWER
	iftrue .Continue
	setevent EVENT_RIVAL_BURNED_TOWER
	domaptrigger BURNED_TOWER_1F, 1
.Continue:
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext UndergroundSilverBeforeText
	setevent EVENT_RIVAL_UNDERGROUND_PATH
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	winlosstext UndergroundSilverWinText, UndergroundSilverLossText
	setlasttalked UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER
	loadtrainer RIVAL1, RIVAL1_12
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .FinishRivalBattle

.Totodile:
	winlosstext UndergroundSilverWinText, UndergroundSilverLossText
	setlasttalked UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER
	loadtrainer RIVAL1, RIVAL1_10
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .FinishRivalBattle

.Chikorita:
	winlosstext UndergroundSilverWinText, UndergroundSilverLossText
	setlasttalked UNDERGROUNDPATHSWITCHROOMENTRANCES_SILVER
	loadtrainer RIVAL1, RIVAL1_11
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .FinishRivalBattle

.FinishRivalBattle:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	jumptext UndergroundSilverAfterText

TrainerGruntM11:
	trainer EVENT_BEAT_ROCKET_GRUNTM_11, GRUNTM, 11, GruntM11SeenText, GruntM11BeatenText, 0, GruntM11Script

GruntM11Script:
	end_if_just_battled
	jumptextfaceplayer GruntM11AfterText

TrainerGruntM25:
	trainer EVENT_BEAT_ROCKET_GRUNTM_25, GRUNTM, 25, GruntM25SeenText, GruntM25BeatenText, 0, GruntM25Script

GruntM25Script:
	end_if_just_battled
	jumptextfaceplayer GruntM25AfterText

TrainerBurglarDuncan:
	trainer EVENT_BEAT_BURGLAR_DUNCAN, BURGLAR, DUNCAN, BurglarDuncanSeenText, BurglarDuncanBeatenText, 0, BurglarDuncanScript

BurglarDuncanScript:
	end_if_just_battled
	jumptextfaceplayer BurglarDuncanAfterText

TrainerBurglarOrson:
	trainer EVENT_BEAT_BURGLAR_ORSON, BURGLAR, ORSON, BurglarOrsonSeenText, BurglarOrsonBeatenText, 0, BurglarOrsonScript

BurglarOrsonScript:
	end_if_just_battled
	jumptextfaceplayer BurglarOrsonAfterText

TrainerGruntM13:
	trainer EVENT_BEAT_ROCKET_GRUNTM_13, GRUNTM, 13, GruntM13SeenText, GruntM13BeatenText, 0, GruntM13Script

GruntM13Script:
	end_if_just_battled
	jumptextfaceplayer GruntM13AfterText

TrainerGruntF3:
	trainer EVENT_BEAT_ROCKET_GRUNTF_3, GRUNTF, 3, GruntF3SeenText, GruntF3BeatenText, 0, GruntF3Script

GruntF3Script:
	end_if_just_battled
	jumptextfaceplayer GruntF3AfterText

Switch1Script:
	opentext
	writetext SwitchRoomText_Switch1
	buttonsound
	checkevent EVENT_SWITCH_1
	iftrue .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalse UndergroundPathSwitchRoomEntrances_DontToggle
	copybytetovar UndergroundSwitchPositions
	addvar 1
	copyvartobyte UndergroundSwitchPositions
	setevent EVENT_SWITCH_1
	jump UndergroundPathSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalse UndergroundPathSwitchRoomEntrances_DontToggle
	copybytetovar UndergroundSwitchPositions
	addvar -1
	copyvartobyte UndergroundSwitchPositions
	clearevent EVENT_SWITCH_1
	jump UndergroundPathSwitchRoomEntrances_UpdateDoors

Switch2Script:
	opentext
	writetext SwitchRoomText_Switch2
	buttonsound
	checkevent EVENT_SWITCH_2
	iftrue .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalse UndergroundPathSwitchRoomEntrances_DontToggle
	copybytetovar UndergroundSwitchPositions
	addvar 2
	copyvartobyte UndergroundSwitchPositions
	setevent EVENT_SWITCH_2
	jump UndergroundPathSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalse UndergroundPathSwitchRoomEntrances_DontToggle
	copybytetovar UndergroundSwitchPositions
	addvar -2
	copyvartobyte UndergroundSwitchPositions
	clearevent EVENT_SWITCH_2
	jump UndergroundPathSwitchRoomEntrances_UpdateDoors

Switch3Script:
	opentext
	writetext SwitchRoomText_Switch3
	buttonsound
	checkevent EVENT_SWITCH_3
	iftrue .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalse UndergroundPathSwitchRoomEntrances_DontToggle
	copybytetovar UndergroundSwitchPositions
	addvar 3
	copyvartobyte UndergroundSwitchPositions
	setevent EVENT_SWITCH_3
	jump UndergroundPathSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalse UndergroundPathSwitchRoomEntrances_DontToggle
	copybytetovar UndergroundSwitchPositions
	addvar -3
	copyvartobyte UndergroundSwitchPositions
	clearevent EVENT_SWITCH_3
	jump UndergroundPathSwitchRoomEntrances_UpdateDoors

EmergencySwitchScript:
	opentext
	writetext SwitchRoomText_Emergency
	buttonsound
	checkevent EVENT_EMERGENCY_SWITCH
	iftrue .On
	writetext SwitchRoomText_OffTurnOn
	yesorno
	iffalse UndergroundPathSwitchRoomEntrances_DontToggle
	writebyte 7
	copyvartobyte UndergroundSwitchPositions
	setevent EVENT_EMERGENCY_SWITCH
	setevent EVENT_SWITCH_1
	setevent EVENT_SWITCH_2
	setevent EVENT_SWITCH_3
	jump UndergroundPathSwitchRoomEntrances_UpdateDoors

.On:
	writetext SwitchRoomText_OnTurnOff
	yesorno
	iffalse UndergroundPathSwitchRoomEntrances_DontToggle
	writebyte 0
	copyvartobyte UndergroundSwitchPositions
	clearevent EVENT_EMERGENCY_SWITCH
	clearevent EVENT_SWITCH_1
	clearevent EVENT_SWITCH_2
	clearevent EVENT_SWITCH_3
	jump UndergroundPathSwitchRoomEntrances_UpdateDoors

UndergroundPathSwitchRoomEntrances_DontToggle:
	endtext

UndergroundPathSwitchRoomEntrances_UpdateDoors:
	copybytetovar UndergroundSwitchPositions
	if_equal 0, .Position0
	if_equal 1, .Position1
	if_equal 2, .Position2
	if_equal 3, .Position3
	if_equal 4, .Position4
	if_equal 5, .Position5
	if_equal 6, .Position6
	if_equal 7, .EmergencyPosition
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
	reloadmappart
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
	reloadmappart
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
	reloadmappart
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
	reloadmappart
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
	reloadmappart
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
	reloadmappart
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
	reloadmappart
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
	reloadmappart
	closetext
	writebyte 6
	copyvartobyte UndergroundSwitchPositions
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

UndergroundSilverApproachMovement1:
	step_down
	step_left
	step_left
	step_left
	step_end

UndergroundSilverApproachMovement2:
	step_down
	step_down
	step_left
	step_left
	step_left
	step_end

UndergroundSilverRetreatMovement1:
	step_right
	step_right
	step_right
	step_up
	step_end

UndergroundSilverRetreatMovement2:
	step_right
	step_right
	step_right
	step_up
	step_up
	step_end

UndergroundSilverBeforeText:
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

UndergroundSilverWinText:
	text "…Why…"
	line "Why do I lose?"

	para "I've assembled the"
	line "toughest #mon."

	para "I didn't ease up"
	line "on the gas."

	para "So why do I lose?"
	done

UndergroundSilverAfterText:
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

UndergroundSilverLossText:
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

GruntM11AfterText:
	text "I'm confused too…"
	line "The switch on the"

	para "end is the one to"
	line "press first, but…"
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

GruntM25AfterText:
	text "All right. A hint!"

	para "Change the order"
	line "of switching."

	para "That'll change the"
	line "ways the shutters"
	cont "open and close."
	done

BurglarDuncanSeenText:
	text "Fork over your"
	line "goodies!"
	done

BurglarDuncanBeatenText:
	text "Mercy!"
	done

BurglarDuncanAfterText:
	text "Steal and sell!"
	line "That's basic in"
	cont "crime, kid!"
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

BurglarOrsonAfterText:
	text "Underground Ware-"
	line "house?"

	para "What do you want"
	line "to go there for?"

	para "There's nothing"
	line "down there."
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

GruntM13AfterText:
	text "You must have ice"
	line "in your veins to"
	cont "dis Team Rocket."
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

GruntF3AfterText:
	text "Go wherever you'd"
	line "like! Get lost!"
	cont "See if I care!"
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
