const_value set 2
	const BATTLETOWERBATTLEROOM_YOUNGSTER
	const BATTLETOWERBATTLEROOM_RECEPTIONIST

BattleTowerBattleRoom_MapScriptHeader:
.MapTriggers:
	db 2
	dw .EnterBattleRoom
	dw .DummyTrigger

.MapCallbacks:
	db 0

.EnterBattleRoom: ; 0x9f419
	disappear BATTLETOWERBATTLEROOM_YOUNGSTER
	priorityjump Script_BattleRoom
	dotrigger $1
.DummyTrigger:
	end

Script_BattleRoom: ; 0x9f421
	applymovement PLAYER, MovementData_BattleTowerBattleRoomPlayerWalksIn
; beat all 7 opponents in a row
Script_BattleRoomLoop: ; 0x9f425
	writebyte BATTLETOWERBATTLEROOM_YOUNGSTER
	special Special_BattleTower_LoadOpponentTrainerAndPokemonsWithOTSprite
	appear BATTLETOWERBATTLEROOM_YOUNGSTER
	warpsound
	waitsfx
	applymovement BATTLETOWERBATTLEROOM_YOUNGSTER, MovementData_BattleTowerBattleRoomOpponentWalksIn
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
	applymovement BATTLETOWERBATTLEROOM_YOUNGSTER, MovementData_BattleTowerBattleRoomOpponentWalksOut
	warpsound
	disappear BATTLETOWERBATTLEROOM_YOUNGSTER
	applymovement BATTLETOWERBATTLEROOM_RECEPTIONIST, MovementData_BattleTowerBattleRoomReceptionistWalksToPlayer
	applymovement PLAYER, MovementData_BattleTowerBattleRoomPlayerTurnsToFaceReceptionist
	opentext
	writetext Text_YourPokemonWillBeHealedToFullHealth
	waitbutton
	closetext
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
Script_ContinueAndBattleNextOpponent: ; 0x9f477
	closetext
	applymovement PLAYER, MovementData_BattleTowerBattleRoomPlayerTurnsToFaceNextOpponent
	applymovement BATTLETOWERBATTLEROOM_RECEPTIONIST, MovementData_BattleTowerBattleRoomReceptionistWalksAway
	jump Script_BattleRoomLoop

Script_DontBattleNextOpponent: ; 0x9f483
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
Script_DontSaveAndEndTheSession: ; 0x9f4a3
	writetext Text_CancelYourBattleRoomChallenge
	yesorno
	iffalse Script_ContinueAndBattleNextOpponent
	writebyte BATTLETOWER_NO_CHALLENGE
	special Special_BattleTower_SetChallengeState
	closetext
	special FadeOutPalettes
	warpfacing UP, BATTLE_TOWER_1F, $7, $7
	opentext
	jump Script_BattleTowerHopeToServeYouAgain

Script_FailedBattleTowerChallenge:
	pause 60
	special Special_BattleTower_Fade
	warpfacing UP, BATTLE_TOWER_1F, $7, $7
	writebyte BATTLETOWER_NO_CHALLENGE
	special Special_BattleTower_SetChallengeState
	opentext
	writetext Text_ThanksForVisiting
	waitbutton
	closetext
	end

Script_BeatenAllTrainers: ; 0x9f4d9
	pause 60
	setevent EVENT_BEAT_PALMER
	special Special_BattleTower_Fade
	warpfacing UP, BATTLE_TOWER_1F, $7, $7
Script_BeatenAllTrainers2:
	opentext
	writetext Text_CongratulationsYouveBeatenAllTheTrainers
	jump Script_GivePlayerHisPrize

Text_YourPokemonWillBeHealedToFullHealth: ; 0x9ee92
	text "Your #mon will"
	line "be healed to full"
	cont "health."
	done

Text_NextUpOpponentNo: ; 0x9eebc
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

Text_SaveAndEndTheSession: ; 0x9ef5e
	text "Save and end the"
	line "session?"
	done

Text_CancelYourBattleRoomChallenge: ; 0x9efbf
	text "Cancel your Battle"
	line "Room challenge?"
	done

Text_ThanksForVisiting: ; 0x9ea49
	text "Thanks for"
	line "visiting!"
	done

BattleTowerBattleRoom_MapEventHeader:
.Warps:
	db 2
	warp_def $7, $3, 4, BATTLE_TOWER_HALLWAY
	warp_def $7, $4, 4, BATTLE_TOWER_HALLWAY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_YOUNGSTER, 0, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_BATTLE_TOWER_BATTLE_ROOM_YOUNGSTER
	person_event SPRITE_RECEPTIONIST, 6, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
