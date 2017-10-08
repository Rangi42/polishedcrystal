BattleTowerBattleRoom_MapScriptHeader:

.MapTriggers: db 1
	dw BattleTowerBattleRoomEnterBattleRoom

.MapCallbacks: db 0

BattleTowerBattleRoom_MapEventHeader:

.Warps: db 2
	warp_def 7, 3, 4, BATTLE_TOWER_HALLWAY
	warp_def 7, 4, 4, BATTLE_TOWER_HALLWAY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_YOUNGSTER, 0, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_BATTLE_TOWER_BATTLE_ROOM_YOUNGSTER
	person_event SPRITE_RECEPTIONIST, 6, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

const_value set 1
	const BATTLETOWERBATTLEROOM_OPPONENT
	const BATTLETOWERBATTLEROOM_RECEPTIONIST

BattleTowerBattleRoomEnterBattleRoom:
	disappear BATTLETOWERBATTLEROOM_OPPONENT
	priorityjump Script_BattleRoom
	dotrigger $1
	end

Script_BattleRoom:
	applymovement PLAYER, MovementData_BattleTowerBattleRoomPlayerWalksIn
; beat all 7 opponents in a row
Script_BattleRoomLoop:
	writebyte BATTLETOWERBATTLEROOM_OPPONENT
	special Special_BattleTower_LoadOpponentTrainerAndPokemonsWithOTSprite
	appear BATTLETOWERBATTLEROOM_OPPONENT
	warpsound
	waitsfx
	applymovement BATTLETOWERBATTLEROOM_OPPONENT, MovementData_BattleTowerBattleRoomOpponentWalksIn
	opentext
	battletowertext 1
	buttonsound
	closetext
	special Special_BattleTower_Battle ; calls predef startbattle
	special FadeOutPalettes
	reloadmap
	if_not_equal $0, Script_FailedBattleTowerChallenge
	copybytetovar wNrOfBeatenBattleTowerTrainers ; wcf64
	if_equal BATTLETOWER_NROFTRAINERS, Script_BeatenAllTrainers
	applymovement BATTLETOWERBATTLEROOM_OPPONENT, MovementData_BattleTowerBattleRoomOpponentWalksOut
	warpsound
	disappear BATTLETOWERBATTLEROOM_OPPONENT
	applymovement BATTLETOWERBATTLEROOM_RECEPTIONIST, MovementData_BattleTowerBattleRoomReceptionistWalksToPlayer
	applyonemovement PLAYER, turn_head_down
	showtext Text_YourPokemonWillBeHealedToFullHealth
	special SaveMusic
	playmusic MUSIC_HEAL
	special FadeOutPalettes
	special LoadMapPalettes
	pause 60
	special FadeInPalettes
	special RestoreMusic
	opentext
	copybytetovar wNrOfBeatenBattleTowerTrainers
	if_equal BATTLETOWER_NROFTRAINERS - 1, .WarnAboutTycoon
	writetext Text_NextUpOpponentNo
	jump .ShownText
.WarnAboutTycoon
	writetext Text_NextUpTycoon
.ShownText
	yesorno
	iffalse Script_DontBattleNextOpponent
Script_ContinueAndBattleNextOpponent:
	closetext
	applyonemovement PLAYER, turn_head_right
	applymovement BATTLETOWERBATTLEROOM_RECEPTIONIST, MovementData_BattleTowerBattleRoomReceptionistWalksAway
	jump Script_BattleRoomLoop

Script_DontBattleNextOpponent:
	writetext Text_SaveAndEndTheSession
	yesorno
	iffalse Script_DontSaveAndEndTheSession
	special Special_BattleTower_SaveLevelGroup
	special SaveOptions
	writebyte BATTLETOWER_SAVED_AND_LEFT
	special Special_BattleTower_SetChallengeState
	playsound SFX_SAVE
	waitsfx
	special FadeOutPalettes
	special SoftReset
Script_DontSaveAndEndTheSession:
	writetext Text_CancelYourBattleRoomChallenge
	yesorno
	iffalse Script_ContinueAndBattleNextOpponent
	writebyte BATTLETOWER_NO_CHALLENGE
	special Special_BattleTower_SetChallengeState
	closetext
	special FadeOutPalettes
	warpfacing UP, BATTLE_TOWER_1F, 10, 8
	jumptext Text_WeHopeToServeYouAgain

Script_FailedBattleTowerChallenge:
	pause 60
	special Special_BattleTower_Fade
	warpfacing UP, BATTLE_TOWER_1F, 10, 8
	writebyte BATTLETOWER_NO_CHALLENGE
	special Special_BattleTower_SetChallengeState
	showtext Text_ThanksForVisiting
	end

Script_BeatenAllTrainers:
	pause 60
	setevent EVENT_BEAT_PALMER
	special Special_BattleTower_Fade
	warpfacing UP, BATTLE_TOWER_1F, 10, 8
Script_BeatenAllTrainers2:
	opentext
	writetext Text_CongratulationsYouveBeatenAllTheTrainers
	jump Script_GivePlayerHisPrize

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
	slow_step_up
	slow_step_up
	step_end

MovementData_BattleTowerBattleRoomReceptionistWalksAway:
	slow_step_down
	slow_step_down
	slow_step_left
	turn_head_right
	step_end

Text_YourPokemonWillBeHealedToFullHealth:
	text "Your #mon will"
	line "be healed to full"
	cont "health."
	done

Text_NextUpOpponentNo:
	text "Next up, opponent"
	line "no.@"
	text_from_ram StringBuffer3
	text ". Ready?"
	done

Text_NextUpTycoon:
	text "Congratulations"
	line "on your winning"
	cont "streak, trainer!"

	para "The Tower Tycoon"
	line "has sent word that"

	para "he is impressed"
	line "with your skill."

	para "Are you ready to"
	line "battle the Tower"
	cont "Tycoon?"
	done

Text_SaveAndEndTheSession:
	text "Save and end the"
	line "session?"
	done

Text_CancelYourBattleRoomChallenge:
	text "Cancel your Battle"
	line "Room challenge?"
	done

Text_ThanksForVisiting:
	text "Thanks for"
	line "visiting!"
	done
