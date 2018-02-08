BattleTower1F_MapScriptHeader:
	db 1 ; scene scripts
	scene_script BattleTower1FTrigger0

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 10, 13, BATTLE_TOWER_OUTSIDE, 3
	warp_event 11, 13, BATTLE_TOWER_OUTSIDE, 4
	warp_event 10,  0, BATTLE_TOWER_ELEVATOR, 1
	warp_event  0,  5, BATTLE_TOWER_2F, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 11,  7, SIGNPOST_READ, MapBattleTower1FSignpost0Script

	db 9 ; object events
	object_event 10,  7, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ReceptionistScript_0x9e3e2, -1
	pc_nurse_event  6, 6
	object_event 14,  6, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, pokemart, MARTTYPE_BP, MART_BT_1, -1
	object_event 16,  6, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, pokemart, MARTTYPE_BP, MART_BT_2, -1
	object_event 18,  6, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, pokemart, MARTTYPE_BP, MART_BT_3, -1
	object_event  6, 12, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, BattleTowerPharmacistScript, -1
	object_event 16, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, Text_BattleTowerCooltrainerF, -1
	object_event  2, 10, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Text_BattleTowerBugCatcher, -1
	object_event 20,  9, SPRITE_GRANNY, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, Text_BattleTowerGranny, -1

	const_def 1 ; object constants
	const BATTLETOWER1F_RECEPTIONIST

BattleTower1FTrigger0:
	special Special_BattleTower_CheckSaveFileExistsAndIsYours
	iffalse .Done
	special Special_BattleTower_GetChallengeState ; copybytetovar sBattleTowerChallengeState
	ifequal BATTLETOWER_CHALLENGE_IN_PROGESS, .ContinueChallenge
	ifequal BATTLETOWER_SAVED_AND_LEFT, .ResumeChallenge
	jump .Done

.ResumeChallenge
	showtext Text_WeveBeenWaitingForYou
	priorityjump Script_ResumeBattleTowerChallenge
	end

.ContinueChallenge
	priorityjump BattleTower_LeftWithoutSaving
	writebyte BATTLETOWER_NO_CHALLENGE
	special Special_BattleTower_SetChallengeState
.Done
	setscene $1
	end

MapBattleTower1FSignpost0Script:
	opentext
	writetext Text_ReadBattleTowerRules
	yesorno
	iffalse_endtext
	jumpopenedtext Text_BattleTowerRules

ReceptionistScript_0x9e3e2:
	special Special_BattleTower_GetChallengeState ; copybytetovar sBattleTowerChallengeState
	ifequal $3, Script_BeatenAllTrainers2 ; maps/BattleTowerBattleRoom.asm
	opentext
	writetext Text_BattleTowerWelcomesYou
	buttonsound
	special Special_BattleTower_CheckNewSaveFile ; if new save file: bit 1, [sBattleTowerNewSaveFile]
	ifnotequal $0, Script_Menu_ChallengeExplanationCancel
	jump Script_BattleTowerIntroductionYesNo

Script_Menu_ChallengeExplanationCancel:
	writetext Text_WantToGoIntoABattleRoom
	special Special_BattleTower_MainMenu
	ifequal $1, Script_ChoseChallenge
	ifequal $2, Script_BattleTowerExplanation
	jumpopenedtext Text_WeHopeToServeYouAgain

Script_ChoseChallenge:
	special Special_BattleTower_ResetTrainersSRAM
	special Special_BattleTower_CheckForRules
	ifnotequal $0, Script_WaitButton
	special Special_BattleTower_FindChallengeLevel
	writetext Text_ConfirmBattleRoomLevel
	yesorno
	iffalse Script_Menu_ChallengeExplanationCancel
	writetext Text_SaveBeforeEnteringBattleRoom
	yesorno
	iffalse Script_Menu_ChallengeExplanationCancel
	setscene $0
	special Special_TryQuickSave
	iffalse Script_Menu_ChallengeExplanationCancel
	setscene $1
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
	setmapscene BATTLE_TOWER_BATTLE_ROOM, $0
	setmapscene BATTLE_TOWER_ELEVATOR, $0
	setmapscene BATTLE_TOWER_HALLWAY, $0
	follow BATTLETOWER1F_RECEPTIONIST, PLAYER
	applymovement BATTLETOWER1F_RECEPTIONIST, MovementData_BattleTower1FWalkToElevator
	special Special_BattleTower_MaxVolume
	warpsound
	disappear BATTLETOWER1F_RECEPTIONIST
	stopfollow
	applyonemovement PLAYER, step_up
	warpcheck
	end

Script_GivePlayerHisPrize:
	writebyte BATTLETOWER_WON_CHALLENGE
	special Special_BattleTower_SetChallengeState
	checkcode VAR_BATTLEPOINTS
	ifgreater 252, .MaxPoints
	addvar 3
	writevarcode VAR_BATTLEPOINTS
.Finish:
	writetext Text_PlayerGotReward
	writebyte BATTLETOWER_RECEIVED_REWARD
	special Special_BattleTower_SetChallengeState
	endtext

.MaxPoints:
	loadvar BattlePoints, 255
	jump .Finish

Script_BattleTowerIntroductionYesNo:
	writetext Text_WouldYouLikeToHearAboutTheBattleTower
	yesorno
	iffalse Script_BattleTowerSkipExplanation
Script_BattleTowerExplanation:
	writetext Text_BattleTowerIntroduction
Script_BattleTowerSkipExplanation:
	special Special_BattleTower_MarkNewSaveFile
	jump Script_Menu_ChallengeExplanationCancel

Script_WaitButton:
	waitendtext

BattleTower_LeftWithoutSaving:
	opentext
	writetext Text_BattleTower_LeftWithoutSaving
	waitbutton
	jumpopenedtext Text_WeHopeToServeYouAgain

BattleTowerPharmacistScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_TRICK_INTRO
	iftrue BattleTowerTutorTrickScript
	writetext BattleTowerPharmacistText
	waitbutton
	setevent EVENT_LISTENED_TO_TRICK_INTRO
BattleTowerTutorTrickScript:
	writetext Text_BattleTowerTutorTrick
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_BattleTowerTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte TRICK
	writetext Text_BattleTowerTutorClear
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_BattleTowerTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_BattleTowerTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_BattleTowerTutorTaught

MovementData_BattleTower1FWalkToElevator:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

Text_BattleTowerWelcomesYou:
	text "Battle Tower"
	line "welcomes you!"

	para "I could show you"
	line "to a Battle Room."
	done

Text_WantToGoIntoABattleRoom:
	text "Want to go into a"
	line "Battle Room?"
	done

Text_RightThisWayToYourBattleRoom:
	text "Right this way to"
	line "your Battle Room."
	done

Text_BattleTowerIntroduction:
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

Text_CongratulationsYouveBeatenAllTheTrainers:
	text "Congratulations!"

	para "You've beaten all"
	line "the trainers!"

	para "For that, you get"
	line "this great prize!"
	prompt

Text_PlayerGotReward:
	text "<PLAYER> earned"
	line "3 Battle Points!@"
	sound_item
	text_waitbutton
	db "@"

Text_WeHopeToServeYouAgain:
	text "We hope to serve"
	line "you again."
	done

Text_WouldYouLikeToHearAboutTheBattleTower:
	text "Would you like to"
	line "hear about the"
	cont "Battle Tower?"
	done

Text_ReadBattleTowerRules:
	text "Battle Tower rules"
	line "are written here."

	para "Read the rules?"
	done

Text_BattleTowerRules:
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

Text_SaveBeforeEnteringBattleRoom:
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

Text_ConfirmBattleRoomLevel:
	text "Your #mon"
	line "qualify for a"

	para "Battle Room at"
	line "<LV>@"
	deciram ScriptVar, 1, 2
	text "0. Is that OK?"
	done

BattleTowerPharmacistText:
	text "The trainers here"
	line "strategically use"
	cont "held items."

	para "But I've got a"
	line "trick up my"
	cont "sleeve--I'll swap"

	para "their items for"
	line "mine with Trick!"
	done

Text_BattleTowerTutorTrick:
	text "I'll teach your"
	line "#mon how to"

	para "use Trick…"
	line "for a Silver Leaf."
	done

Text_BattleTowerTutorNoSilverLeaf:
	text "Tch. You don't have"
	line "a Silver Leaf…"
	done

Text_BattleTowerTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Trick?"
	done

Text_BattleTowerTutorRefused:
	text "Talk to me if you"
	line "change your mind."
	done

Text_BattleTowerTutorClear:
	text ""
	done

Text_BattleTowerTutorTaught:
	text "Now your #mon"
	line "can use Trick too!"
	cont "Isn't it devious?"
	done

Text_BattleTowerCooltrainerF:
	text "There are lots of"
	line "Battle Rooms, but"

	para "I'm going to win"
	line "them all!"
	done

Text_BattleTowerGranny:
	text "It's a grueling"
	line "task, not being"

	para "able to use items"
	line "in battle."

	para "Making your"
	line "#mon hold items"

	para "is the key to"
	line "winning battles."
	done

Text_BattleTowerBugCatcher:
	text "I'm trying to see"
	line "how far I can go"

	para "using just bug"
	line "#mon."

	para "Don't let there be"
	line "any fire #mon…"
	done
