BattleFactoryBattleRoom_MapScriptHeader:
	def_scene_scripts
	scene_script BattleFactoryBattleRoomEnterBattleRoom

	def_callbacks

	def_warp_events
	warp_event  3,  7, BATTLE_FACTORY_HALLWAY, 4
	warp_event  4,  7, BATTLE_FACTORY_HALLWAY, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BATTLE_TOWER_BATTLE_ROOM_YOUNGSTER
	object_event  1,  6, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

	object_const_def
	const BATTLEFACTORYBATTLEROOM_OPPONENT
	const BATTLEFACTORYBATTLEROOM_RECEPTIONIST

BattleFactoryBattleRoomEnterBattleRoom:
	disappear BATTLEFACTORYBATTLEROOM_OPPONENT
	prioritysjump Script_BattleFloor
	end

Script_BattleFloor:
	applymovement PLAYER, MovementData_BattleFactoryBattleRoomPlayerWalksIn
; beat all 7 opponents in a row
Script_BattleFloorLoop:
	special Special_BattleTower_LoadOpponentTrainerAndPokemonsWithOTSprite
	appear BATTLEFACTORYBATTLEROOM_OPPONENT
	warpsound
	waitsfx
	applymovement BATTLEFACTORYBATTLEROOM_OPPONENT, MovementData_BattleFactoryBattleRoomOpponentWalksIn
	opentext
	battletowertext 1
	promptbutton
	closetext
	special Special_BattleTower_Battle ; calls predef startbattle
	special FadeOutPalettes
	ifequal BTCHALLENGE_LOST, Script_LostBattleFactory
	reloadmap
	applymovement BATTLEFACTORYBATTLEROOM_OPPONENT, MovementData_BattleFactoryBattleRoomOpponentWalksOut
	warpsound
	disappear BATTLEFACTORYBATTLEROOM_OPPONENT
	applymovement BATTLEFACTORYBATTLEROOM_RECEPTIONIST, MovementData_BattleFactoryBattleRoomReceptionistWalksToPlayer
	applyonemovement PLAYER, turn_head_left
	opentext
	writethistext
		text "<PLAYER> received"
		line ""
		text_ram wStringBuffer1
		text " BP!"
		done
	waitsfx
	specialsound
	waitbutton
	ifequal BTCHALLENGE_WON, Script_BeatenAllFactoryTrainers
	ifequal BTCHALLENGE_TYCOON, .WarnAboutHead
.AskNextBattle:
	writethistext
		text "Next up, opponent"
		line "No. "
		text_decimal wStringBuffer3, 2, 5
		text ". Ready?"
		done
	sjump .ShownText
.WarnAboutHead:
	writethistext
		text "Congratulations"
		line "on your winning"
		cont "streak, trainer!"

		para "The Factory Head"
		line "has sent word that"

		para "he is impressed"
		line "with your skill."

		para "Are you ready to"
		line "battle the"
		cont "Factory Head?"
		done
.ShownText
	yesorno
	iffalse .DontBattleNextOpponent
	closetext
	applyonemovement PLAYER, turn_head_right
	applymovement BATTLEFACTORYBATTLEROOM_RECEPTIONIST, MovementData_BattleFactoryBattleRoomReceptionistWalksAway
	sjump Script_BattleFloorLoop

.DontBattleNextOpponent:
	writethistext
		text "Save and end the"
		line "session?"
		done
	yesorno
	iffalse .DontSaveAndEndTheSession
	special SaveOptions
	setval BATTLETOWER_SAVED_AND_LEFT
	special Special_BattleTower_SetChallengeState
	playsound SFX_SAVE
	waitsfx
	special FadeOutPalettes
	special SoftReset
.DontSaveAndEndTheSession:
	writethistext
		text "Cancel your Battle"
		line "Floor challenge?"

		para "Beware, it counts"
		line "as a loss."
		done
	yesorno
	iffalse .AskNextBattle
	special FadeOutPalettes

Script_LostBattleFactory:
	setval BATTLETOWER_LOST_CHALLENGE
	special Special_BattleTower_SetChallengeState
	sjump Script_ReturnToBattleFactoryLobby

Script_BeatenAllFactoryTrainers:
	setval BATTLETOWER_WON_CHALLENGE
	special Special_BattleTower_SetChallengeState
	; fallthrough
Script_ReturnToBattleFactoryLobby:
	warpfacing UP, BATTLE_FACTORY_1F, 12, 6
	end

MovementData_BattleFactoryBattleRoomPlayerWalksIn:
	step_up
	step_up
	step_up
	step_up
	turn_head_right
	step_end

MovementData_BattleFactoryBattleRoomOpponentWalksIn:
	slow_step_down
	slow_step_down
	slow_step_down
	turn_head_left
	step_end

MovementData_BattleFactoryBattleRoomOpponentWalksOut:
	turn_head_up
	slow_step_up
	slow_step_up
	slow_step_up
	step_end

MovementData_BattleFactoryBattleRoomReceptionistWalksToPlayer:
	slow_step_right
	slow_step_right
	step_end

MovementData_BattleFactoryBattleRoomReceptionistWalksAway:
	slow_step_left
	slow_step_left
	turn_head_right
	step_end
