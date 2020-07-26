BattleTowerBattleRoom_MapScriptHeader:
	def_scene_scripts
	scene_script BattleTowerBattleRoomEnterBattleRoom

	def_callbacks

	def_warp_events
	warp_event  3,  7, BATTLE_TOWER_HALLWAY, 4
	warp_event  4,  7, BATTLE_TOWER_HALLWAY, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  0, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_BATTLE_TOWER_BATTLE_ROOM_YOUNGSTER
	object_event  2,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

	object_const_def
	const BATTLETOWERBATTLEROOM_OPPONENT
	const BATTLETOWERBATTLEROOM_RECEPTIONIST

BattleTowerBattleRoomEnterBattleRoom:
	disappear BATTLETOWERBATTLEROOM_OPPONENT
	priorityjump Script_BattleRoom
	setscene $1
	end

Script_BattleRoom:
	applymovement PLAYER, MovementData_BattleTowerBattleRoomPlayerWalksIn
; beat all 7 opponents in a row
Script_BattleRoomLoop:
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
	ifnotequal $0, Script_FailedBattleTowerChallenge
	copybytetovar wNrOfBeatenBattleTowerTrainers ; wcf64
	ifequal BATTLETOWER_NROFTRAINERS, Script_BeatenAllTrainers
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
	ifequal BATTLETOWER_NROFTRAINERS - 1, .WarnAboutTycoon
	writethistext
		text "Next up, opponent"
		line "no."
		text_from_ram wStringBuffer3
		text ". Ready?"
		done
	jump .ShownText
.WarnAboutTycoon
	writethistext
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
.ShownText
	yesorno
	iffalse Script_DontBattleNextOpponent
Script_ContinueAndBattleNextOpponent:
	closetext
	applyonemovement PLAYER, turn_head_right
	applymovement BATTLETOWERBATTLEROOM_RECEPTIONIST, MovementData_BattleTowerBattleRoomReceptionistWalksAway
	jump Script_BattleRoomLoop

Script_DontBattleNextOpponent:
	writethistext
		text "Save and end the"
		line "session?"
		done
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
	writethistext
		text "Cancel your Battle"
		line "Room challenge?"
		done
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
	writethistext
		text "Congratulations!"

		para "You've beaten all"
		line "the trainers!"

		para "For that, you get"
		line "this great prize!"
		prompt
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

Text_ThanksForVisiting:
	text "Thanks for"
	line "visiting!"
	done
