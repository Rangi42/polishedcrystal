BattleFactoryHallway_MapScriptHeader:
	def_scene_scripts
	scene_script BattleFactoryHallwayFollowReceptionist

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .SetScientistPosition

	def_warp_events
	warp_event  4, 13, BATTLE_FACTORY_1F, 3
	warp_event  5, 13, BATTLE_FACTORY_1F, 3
	warp_event  4,  4, BATTLE_FACTORY_BATTLE_ROOM, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  4, 12, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	object_const_def
	const BATTLEFACTORYHALLWAY_RECEPTIONIST
	const BATTLEFACTORYHALLWAY_LOBBY_RECEPTIONIST

.SetScientistPosition:
	disappear BATTLEFACTORYHALLWAY_RECEPTIONIST
	disappear BATTLEFACTORYHALLWAY_LOBBY_RECEPTIONIST
	readvar VAR_YCOORD
	ifequal 13, .lobby_arrival
	appear BATTLEFACTORYHALLWAY_RECEPTIONIST
	end
.lobby_arrival
	appear BATTLEFACTORYHALLWAY_LOBBY_RECEPTIONIST
	end

BattleFactoryHallwayFollowReceptionist:
	readvar VAR_YCOORD
	ifequal 13, .arrived_from_lobby
	sdefer .WonBattle
	end

.arrived_from_lobby
	sdefer .StepIntoRoom
	end

.WonBattle:
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
	special Special_BattleTower_GetBattleResult
	ifequal BTCHALLENGE_WON, Script_BeatenAllFactoryTrainers
	ifequal BTCHALLENGE_FACILITYBRAIN, .WarnAboutHead
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
	special Special_BattleTower_GenerateNextOpponent
	sjump .NextRentalBattle

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
	sjump Script_LostBattleFactory

.StepIntoRoom:
	; First, step into the room properly, don't just linger at the entrance.
	follow BATTLEFACTORYHALLWAY_LOBBY_RECEPTIONIST, PLAYER
	applymovement BATTLEFACTORYHALLWAY_LOBBY_RECEPTIONIST, .WalkIntoRoomMovement
	stopfollow
	special Special_BattleTower_GenerateNextOpponent
	turnobject PLAYER, RIGHT
	appear BATTLEFACTORYHALLWAY_RECEPTIONIST
	disappear BATTLEFACTORYHALLWAY_LOBBY_RECEPTIONIST
	; fallthrough
.NextRentalBattle:
	opentext
.NextRentalBattle_AfterOpenText:
	writethistext
		text "I've researched the"
		line "next opponent."
		prompt

	special Special_BattleTower_NextRentalBattle
	iftrue .Continue

	writethistext
		text "Cancel your run?"
		line "This counts as a"
		cont "streak loss."
		done
	yesorno
	iffalse .NextRentalBattle_AfterOpenText
	closetext

	; Player aborted the run.
	special FadeOutPalettes
	sjump Script_LostBattleFactory

.Continue:
	faceobject PLAYER, BATTLEFACTORYHALLWAY_RECEPTIONIST
	writetext .PleaseStepThisWayText
	closetext
	applymovement BATTLEFACTORYHALLWAY_RECEPTIONIST, .StepAbovePlayerMovement
	follow BATTLEFACTORYHALLWAY_RECEPTIONIST, PLAYER
	applymovement BATTLEFACTORYHALLWAY_RECEPTIONIST, .StepOntoFloorMovement
	stopfollow
	warpsound
	disappear BATTLEFACTORYHALLWAY_RECEPTIONIST
	applyonemovement PLAYER, step_up
	warpcheck
	end

.WalkIntoRoomMovement:
	step_up
	step_up
	step_up
	step_up
	step_right
	turn_head_left
	step_end

.PleaseStepThisWayText:
	text "Please step this"
	line "way."
	prompt

.StepAbovePlayerMovement:
	step_up
	step_left
	step_end

.StepOntoFloorMovement:
	step_up
	step_up
	step_up
	step_end
