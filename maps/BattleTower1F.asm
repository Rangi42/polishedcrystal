const_value set 2
	const BATTLETOWER1F_RECEPTIONIST
	const BATTLETOWER1F_NURSE
	const BATTLETOWER1F_CLERK1
	const BATTLETOWER1F_CLERK2
	const BATTLETOWER1F_CLERK3
	const BATTLETOWER1F_DRAGON_TAMER
	const BATTLETOWER1F_COOLTRAINER_F
	const BATTLETOWER1F_BUG_CATCHER
	const BATTLETOWER1F_GRANNY

BattleTower1F_MapScriptHeader:
.MapTriggers:
	db 2
	dw .Trigger0
	dw .Trigger1

.MapCallbacks:
	db 0

.Trigger0:
	special Special_BattleTower_CheckSaveFileExistsAndIsYours
	iffalse .Done
	special Special_BattleTower_GetChallengeState ; copybytetovar sBattleTowerChallengeState
	if_equal BATTLETOWER_CHALLENGE_IN_PROGESS, .ContinueChallenge
	if_equal BATTLETOWER_SAVED_AND_LEFT, .ResumeChallenge
	jump .Done

.ResumeChallenge
	opentext
	writetext Text_WeveBeenWaitingForYou
	waitbutton
	closetext
	priorityjump Script_ResumeBattleTowerChallenge
	end

.ContinueChallenge
	priorityjump BattleTower_LeftWithoutSaving
	writebyte BATTLETOWER_NO_CHALLENGE
	special Special_BattleTower_SetChallengeState
.Done
	dotrigger $1
	end

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
	special Special_BattleTower_GetChallengeState ; copybytetovar sBattleTowerChallengeState
	if_equal $3, Script_BeatenAllTrainers2 ; maps/BattleTowerBattleRoom.asm
	opentext
	writetext Text_BattleTowerWelcomesYou
	buttonsound
	special Special_BattleTower_CheckNewSaveFile ; if new save file: bit 1, [sBattleTowerNewSaveFile]
	if_not_equal $0, Script_Menu_ChallengeExplanationCancel
	jump Script_BattleTowerIntroductionYesNo

Script_Menu_ChallengeExplanationCancel: ; 0x9e3fc
	writetext Text_WantToGoIntoABattleRoom
	special Special_BattleTower_MainMenu
	if_equal $1, Script_ChoseChallenge
	if_equal $2, Script_BattleTowerExplanation
	jump Script_BattleTowerHopeToServeYouAgain

Script_ChoseChallenge: ; 0x9e40f
	special Special_BattleTower_ResetTrainersSRAM
	special Special_BattleTower_CheckForRules
	if_not_equal $0, Script_WaitButton
	special Special_BattleTower_FindChallengeLevel
	writetext Text_ConfirmBattleRoomLevel
	yesorno
	iffalse Script_Menu_ChallengeExplanationCancel
	writetext Text_SaveBeforeEnteringBattleRoom
	yesorno
	iffalse Script_Menu_ChallengeExplanationCancel
	dotrigger $0
	special Special_TryQuickSave
	iffalse Script_Menu_ChallengeExplanationCancel
	dotrigger $1
	special Special_BattleTower_MarkNewSaveFile ; set 1, [sBattleTowerNewSaveFile]
	special Special_BattleTower_BeginChallenge
	writetext Text_RightThisWayToYourBattleRoom
	waitbutton
	closetext
	jump Script_WalkToBattleTowerElevator

Script_ResumeBattleTowerChallenge:
	closetext
	special Special_BattleTower_LoadLevelGroup
Script_WalkToBattleTowerElevator:
	musicfadeout MUSIC_NONE, 8
	domaptrigger BATTLE_TOWER_BATTLE_ROOM, $0
	domaptrigger BATTLE_TOWER_ELEVATOR, $0
	domaptrigger BATTLE_TOWER_HALLWAY, $0
	follow BATTLETOWER1F_RECEPTIONIST, PLAYER
	applymovement BATTLETOWER1F_RECEPTIONIST, MovementData_BattleTower1FWalkToElevator
	special Special_BattleTower_MaxVolume
	warpsound
	disappear BATTLETOWER1F_RECEPTIONIST
	stopfollow
	applymovement PLAYER, MovementData_BattleTowerHallwayPlayerEntersElevator
	warpcheck
	end

Script_GivePlayerHisPrize: ; 0x9e47a
	writebyte BATTLETOWER_WON_CHALLENGE
	special Special_BattleTower_SetChallengeState
	checkcode VAR_BATTLEPOINTS
	if_greater_than 252, .MaxPoints
	addvar 3
	writevarcode VAR_BATTLEPOINTS
.Finish:
	writetext Text_PlayerGotReward
	writebyte BATTLETOWER_RECEIVED_REWARD
	special Special_BattleTower_SetChallengeState
	closetext
	end

.MaxPoints:
	loadvar BattlePoints, 255
	jump .Finish

Script_BattleTowerIntroductionYesNo: ; 0x9e49e
	writetext Text_WouldYouLikeToHearAboutTheBattleTower
	yesorno
	iffalse Script_BattleTowerSkipExplanation
Script_BattleTowerExplanation: ; 0x9e4a5
	writetext Text_BattleTowerIntroduction
Script_BattleTowerSkipExplanation:
	special Special_BattleTower_MarkNewSaveFile
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

BattleTower_LeftWithoutSaving:
	opentext
	writetext Text_BattleTower_LeftWithoutSaving
	waitbutton
	jump Script_BattleTowerHopeToServeYouAgain

BattleTowerDragonTamerScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_WATER_PULSE_INTRO
	iftrue BattleTowerTutorWaterPulseScript
	writetext BattleTowerDragonTamerText
	waitbutton
	setevent EVENT_LISTENED_TO_WATER_PULSE_INTRO
BattleTowerTutorWaterPulseScript:
	writetext Text_BattleTowerTutorWaterPulse
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_BattleTowerTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte WATER_PULSE
	writetext Text_BattleTowerTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	writetext Text_BattleTowerTutorRefused
	waitbutton
	closetext
	end

.NoSilverLeaf
	writetext Text_BattleTowerTutorNoSilverLeaf
	waitbutton
	closetext
	end

.TeachMove
	takeitem SILVER_LEAF
	writetext Text_BattleTowerTutorTaught
	waitbutton
	closetext
	end

BattleTowerNurse:
	jumpstd pokecenternurse

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
	step_up
MovementData_BattleTowerHallwayPlayerEntersElevator:
	step_up
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

	para "Beat them all to"
	line "get Battle Points."

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

Text_PlayerGotReward: ; 0x9eb7e
	text "<PLAYER> earned"
	line "3 Battle Points!@"
	sound_item
	text_waitbutton
	db "@"

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

Text_ConfirmBattleRoomLevel: ; 0x9f1e5
	text "Your #mon"
	line "qualify for a"

	para "Battle Room at"
	line "<LV>@"
	deciram ScriptVar, 1, 2
	text "0. Is that OK?"
	done

BattleTowerDragonTamerText:
	text "I'm going to beat"
	line "the Tower Tycoon"

	para "with my Seadra's"
	line "awesome Water"
	cont "Pulse attack!"
	done

Text_BattleTowerTutorWaterPulse:
	text "I'll teach your"
	line "#mon how to"

	para "use Water Pulse"
	line "for a Silver Leaf."
	done

Text_BattleTowerTutorNoSilverLeaf:
	text "You don't have a"
	line "Silver Leaf…"
	done

Text_BattleTowerTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Water Pulse?"
	done

Text_BattleTowerTutorRefused:
	text "Talk to me if you"
	line "change your mind!"
	done

Text_BattleTowerTutorClear:
	text ""
	done

Text_BattleTowerTutorTaught:
	text "Now your #mon"
	line "can use Water"
	cont "Pulse too!"
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
.Warps:
	db 4
	warp_def $d, $a, 3, BATTLE_TOWER_OUTSIDE
	warp_def $d, $b, 4, BATTLE_TOWER_OUTSIDE
	warp_def $0, $a, 1, BATTLE_TOWER_ELEVATOR
	warp_def $5, $0, 1, BATTLE_TOWER_2F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 7, 11, SIGNPOST_READ, MapBattleTower1FSignpost0Script

.PersonEvents:
	db 9
	person_event SPRITE_RECEPTIONIST, 7, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ReceptionistScript_0x9e3e2, -1
	person_event SPRITE_NURSE, 6, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BattleTowerNurse, -1
	person_event SPRITE_CLERK, 6, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_CLERK, 6, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_CLERK, 6, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_DRAGON_TAMER, 12, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, BattleTowerDragonTamerScript, -1
	person_event SPRITE_COOLTRAINER_F, 11, 16, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x9e568, -1
	person_event SPRITE_BUG_CATCHER, 10, 2, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x9e56b, -1
	person_event SPRITE_GRANNY, 9, 20, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrannyScript_0x9e56e, -1
