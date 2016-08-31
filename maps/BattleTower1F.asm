const_value set 2
	const BATTLETOWER1F_RECEPTIONIST
	const BATTLETOWER1F_YOUNGSTER
	const BATTLETOWER1F_COOLTRAINER_F
	const BATTLETOWER1F_BUG_CATCHER
	const BATTLETOWER1F_GRANNY

BattleTower1F_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 0

.Trigger0:
	writebyte BATTLETOWERACTION_CHECKSAVEFILEISYOURS
	special BattleTowerAction
	iffalse .SkipEverything
	writebyte BATTLETOWERACTION_02 ; copybytetovar sBattleTowerChallengeState
	special BattleTowerAction
	if_equal $0, .SkipEverything
	if_equal $2, .priorityjump1
	if_equal $3, .SkipEverything
	if_equal $4, .SkipEverything
	opentext
	writetext Text_WeveBeenWaitingForYou
	waitbutton
	closetext
	priorityjump Script_ResumeBattleTowerChallenge
	end

.priorityjump1
	priorityjump BattleTower_LeftWithoutSaving
	writebyte BATTLETOWERACTION_CHALLENGECANCELED
	special BattleTowerAction
	writebyte BATTLETOWERACTION_06
	special BattleTowerAction
.SkipEverything:
	dotrigger $1
.Trigger1:
	end

MapBattleTower1FSignpost0Script:
	opentext
	writetext Text_ReadBattleTowerRules
	yesorno
	iffalse UnknownScript_0x9e3e0
	writetext Text_BattleTowerRules
	waitbutton
UnknownScript_0x9e3e0:
	closetext
	end

ReceptionistScript_0x9e3e2:
	writebyte BATTLETOWERACTION_02 ; copybytetovar sBattleTowerChallengeState
	special BattleTowerAction
	if_equal $3, Script_BeatenAllTrainers2 ; maps/BattleTowerBattleRoom.asm
	opentext
	writetext Text_BattleTowerWelcomesYou
	buttonsound
	writebyte BATTLETOWERACTION_00 ; if new save file: bit 1, [s1_be4f]
	special BattleTowerAction
	if_not_equal $0, Script_Menu_ChallengeExplanationCancel
	jump Script_BattleTowerIntroductionYesNo

Script_Menu_ChallengeExplanationCancel: ; 0x9e3fc
	writetext Text_WantToGoIntoABattleRoom
	writebyte $1
	special Special_Menu_ChallengeExplanationCancel
	if_equal $1, Script_ChoseChallenge
	if_equal $2, Script_BattleTowerExplanation
	jump Script_BattleTowerHopeToServeYouAgain

Script_ChoseChallenge: ; 0x9e40f
	writebyte BATTLETOWERACTION_RESETDATA ; ResetBattleTowerTrainerSRAM
	special BattleTowerAction
	special SpecialCheckForBattleTowerRules
	if_not_equal $0, Script_WaitButton
	writetext Text_SaveBeforeEnteringBattleRoom
	yesorno
	iffalse Script_Menu_ChallengeExplanationCancel
	dotrigger $0
	special Special_TryQuickSave
	iffalse Script_Menu_ChallengeExplanationCancel
	dotrigger $1
	writebyte BATTLETOWERACTION_01 ; set 1, [s1_be4f]
	special BattleTowerAction
	special Special_InitBattleTowerChallengeRAM
	if_equal $a, Script_Menu_ChallengeExplanationCancel
	writebyte BATTLETOWERACTION_11
	special BattleTowerAction
	writetext Text_RightThisWayToYourBattleRoom
	waitbutton
	closetext
	writebyte BATTLETOWERACTION_CHOOSEREWARD
	special BattleTowerAction
	jump Script_WalkToBattleTowerElevator

Script_ResumeBattleTowerChallenge:
	closetext
	writebyte BATTLETOWERACTION_LOADLEVELGROUP ; load choice of level group
	special BattleTowerAction
Script_WalkToBattleTowerElevator:
	musicfadeout MUSIC_NONE, 8
	domaptrigger BATTLE_TOWER_BATTLE_ROOM, $0
	domaptrigger BATTLE_TOWER_ELEVATOR, $0
	domaptrigger BATTLE_TOWER_HALLWAY, $0
	follow BATTLETOWER1F_RECEPTIONIST, PLAYER
	applymovement BATTLETOWER1F_RECEPTIONIST, MovementData_BattleTower1FWalkToElevator
	writebyte BATTLETOWERACTION_0A
	special BattleTowerAction
	warpsound
	disappear BATTLETOWER1F_RECEPTIONIST
	stopfollow
	applymovement PLAYER, MovementData_BattleTowerHallwayPlayerEntersBattleRoom
	warpcheck
	end

Script_GivePlayerHisPrize: ; 0x9e47a
	writebyte BATTLETOWERACTION_1C
	special BattleTowerAction
	writebyte BATTLETOWERACTION_GIVEREWARD
	special BattleTowerAction
	if_equal POTION, Script_YourPackIsStuffedFull
	itemtotext $0, $1
	giveitem ITEM_FROM_MEM, 5
	writetext Text_PlayerGotFive
	writebyte BATTLETOWERACTION_1D
	special BattleTowerAction
	closetext
	end

Script_YourPackIsStuffedFull: ; 0x9e498
	writetext Text_YourPackIsStuffedFull
	waitbutton
	closetext
	end

Script_BattleTowerIntroductionYesNo: ; 0x9e49e
	writetext Text_WouldYouLikeToHearAboutTheBattleTower
	yesorno
	iffalse Script_BattleTowerSkipExplanation
Script_BattleTowerExplanation: ; 0x9e4a5
	writetext Text_BattleTowerIntroduction
Script_BattleTowerSkipExplanation:
	writebyte BATTLETOWERACTION_01
	special BattleTowerAction
	jump Script_Menu_ChallengeExplanationCancel

Script_BattleTowerHopeToServeYouAgain:
	writetext Text_WeHopeToServeYouAgain
	waitbutton
	closetext
	end

Script_WaitButton: ; 0x9e4bb
	waitbutton
	closetext
	end

Script_APkmnLevelExceeds: ; 0x9e542
	writetext Text_APkmnLevelExceeds
	waitbutton
	jump Script_Menu_ChallengeExplanationCancel

Script_MayNotEnterABattleRoomUnderL70: ; 0x9e549
	writetext Text_MayNotEnterABattleRoomUnderL70
	waitbutton
	jump Script_Menu_ChallengeExplanationCancel

BattleTower_LeftWithoutSaving:
	opentext
	writetext Text_BattleTower_LeftWithoutSaving
	waitbutton
	jump Script_BattleTowerHopeToServeYouAgain

YoungsterScript_0x9e55d:
	faceplayer
	opentext
	writetext Text_BattleTowerYoungster
	waitbutton
	closetext
	spriteface BATTLETOWER1F_YOUNGSTER, RIGHT
	end

CooltrainerFScript_0x9e568:
	jumptextfaceplayer Text_BattleTowerCooltrainerF

BugCatcherScript_0x9e56b:
	jumptextfaceplayer Text_BattleTowerBugCatcher

GrannyScript_0x9e56e:
	jumptextfaceplayer Text_BattleTowerGranny

MovementData_BattleTower1FWalkToElevator:
	step_up
	step_up
	step_up
	step_up
	step_up
MovementData_BattleTowerHallwayPlayerEntersBattleRoom:
	step_up
	step_end

MovementData_BattleTowerHallwayWalkTo1020Room:
	step_right
	step_right
MovementData_BattleTowerHallwayWalkTo3040Room:
	step_right
	step_right
	step_up
	step_right
	turn_head_left
	step_end

MovementData_BattleTowerHallwayWalkTo90100Room:
	step_left
	step_left
MovementData_BattleTowerHallwayWalkTo7080Room:
	step_left
	step_left
MovementData_BattleTowerHallwayWalkTo5060Room:
	step_left
	step_left
	step_up
	step_left
	turn_head_right
	step_end

MovementData_BattleTowerBattleRoomPlayerWalksIn:
	step_up
	step_up
	step_up
	step_up
	turn_head_right
	step_end

MovementData_BattleTowerBattleRoomOpponentWalksIn:
	slow_step_down
	slow_step_down
	slow_step_down
	turn_head_left
	step_end

MovementData_BattleTowerBattleRoomOpponentWalksOut:
	turn_head_up
	slow_step_up
	slow_step_up
	slow_step_up
	step_end

MovementData_BattleTowerBattleRoomReceptionistWalksToPlayer:
	slow_step_right
	slow_step_right
	slow_step_up
	slow_step_up
	step_end

MovementData_BattleTowerBattleRoomReceptionistWalksAway:
	slow_step_down
	slow_step_down
	slow_step_left
	slow_step_left
	turn_head_right
	step_end

MovementData_BattleTowerBattleRoomPlayerTurnsToFaceReceptionist:
	turn_head_down
	step_end

MovementData_BattleTowerBattleRoomPlayerTurnsToFaceNextOpponent:
	turn_head_right
	step_end

Text_BattleTowerWelcomesYou: ; 0x9e5ab
	text "Battle Tower"
	line "welcomes you!"

	para "I could show you"
	line "to a Battle Room."
	done

Text_WantToGoIntoABattleRoom: ; 0x9e5ea
	text "Want to go into a"
	line "Battle Room?"
	done

Text_RightThisWayToYourBattleRoom: ; 0x9e60a
	text "Right this way to"
	line "your Battle Room."
	done

Text_BattleTowerIntroduction: ; 0x9e886
	text "Battle Tower is a"
	line "facility made for"
	cont "#mon battles."

	para "Countless #mon"
	line "trainers gather"

	para "from all over to"
	line "hold battles in"

	para "specially designed"
	line "Battle Rooms."

	para "There are many"
	line "Battle Rooms in"
	cont "the Battle Tower."

	para "Each Room holds"
	line "seven trainers."

	para "Beat them all, and"
	line "win a prize."

	para "To interrupt a"
	line "session, you must"

	para "save. If not, you"
	line "won't be able to"

	para "resume your Room"
	line "challenge."
	prompt

Text_CongratulationsYouveBeatenAllTheTrainers: ; 0x9eaef
	text "Congratulations!"

	para "You've beaten all"
	line "the trainers!"

	para "For that, you get"
	line "this great prize!"
	prompt

Text_PlayerGotFive: ; 0x9eb7e
	text "<PLAYER> got five"
	line "@"
	text_from_ram StringBuffer4
	text "!@"
	sound_item
	text_waitbutton
	db "@"

Text_YourPackIsStuffedFull: ; 0x9eb94
	text "Oops, your Bag is"
	line "stuffed full."

	para "Please make room"
	line "and come back."
	done

Text_WeHopeToServeYouAgain: ; 0x9ec09
	text "We hope to serve"
	line "you again."
	done

Text_WouldYouLikeToHearAboutTheBattleTower: ; 0x9ec3d
	text "Would you like to"
	line "hear about the"
	cont "Battle Tower?"
	done

Text_ReadBattleTowerRules: ; 0x9ed3c
	text "Battle Tower rules"
	line "are written here."

	para "Read the rules?"
	done

Text_BattleTowerRules: ; 0x9ed72
	text "Three #mon may"
	line "enter battles."

	para "All three must be"
	line "different."

	para "The items they"
	line "hold must also be"
	cont "different."

	para "Certain #mon"
	line "may also have"

	para "level restrictions"
	line "placed on them."
	done

Text_BattleTower_LeftWithoutSaving:
	text "Excuse me!"
	line "You didn't save"

	para "before exiting"
	line "the Battle Room."

	para "I'm awfully sorry,"
	line "but your challenge"

	para "will be declared"
	line "invalid."
	done

Text_SaveBeforeEnteringBattleRoom: ; 0x9ef1f
	text "Before entering"
	line "the Battle Room,"

	para "your progress will"
	line "be saved."
	done

Text_WeveBeenWaitingForYou:
	text "We've been waiting"
	line "for you. This way"

	para "to a Battle Room,"
	line "please."
	done

Text_APkmnLevelExceeds: ; 0x9f1e5
	text "One or more of"
	line "your #mon's"
	cont "levels exceeds @"
	deciram ScriptVar, 1, 3
	text "."
	done

Text_MayNotEnterABattleRoomUnderL70: ; 0x9f217
	text_from_ram wcd49
	text " may not"
	line "enter a Battle"
	cont "Room under <LV>70."

	para "This Battle Room"
	line "is for L@"
	deciram ScriptVar, 1, 3
	text "."
	done

Text_BattleTowerYoungster: ; 0x9f264
	text "Destroyed by the"
	line "first opponent in"

	para "no time at all…"
	line "I'm no good…"
	done

Text_BattleTowerCooltrainerF: ; 0x9f2a4
	text "There are lots of"
	line "Battle Rooms, but"

	para "I'm going to win"
	line "them all!"
	done

Text_BattleTowerGranny: ; 0x9f2e3
	text "It's a grueling"
	line "task, not being"

	para "able to use items"
	line "in battle."

	para "Making your"
	line "#mon hold items"

	para "is the key to"
	line "winning battles."
	done

Text_BattleTowerBugCatcher: ; 0x9f35b
	text "I'm trying to see"
	line "how far I can go"

	para "using just bug"
	line "#mon."

	para "Don't let there be"
	line "any fire #mon…"
	done

BattleTower1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $9, $7, 3, BATTLE_TOWER_OUTSIDE
	warp_def $9, $8, 4, BATTLE_TOWER_OUTSIDE
	warp_def $0, $7, 1, BATTLE_TOWER_ELEVATOR

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 6, 6, SIGNPOST_READ, MapBattleTower1FSignpost0Script

.PersonEvents:
	db 5
	person_event SPRITE_RECEPTIONIST, 6, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ReceptionistScript_0x9e3e2, -1
	person_event SPRITE_YOUNGSTER, 9, 14, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x9e55d, -1
	person_event SPRITE_COOLTRAINER_F, 9, 4, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x9e568, -1
	person_event SPRITE_BUG_CATCHER, 3, 1, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x9e56b, -1
	person_event SPRITE_GRANNY, 3, 14, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrannyScript_0x9e56e, -1
