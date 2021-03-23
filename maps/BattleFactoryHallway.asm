BattleFactoryHallway_MapScriptHeader:
	def_scene_scripts
	scene_script BattleFactoryHallwayFollowReceptionist

	def_callbacks

	def_warp_events
	warp_event  4, 13, BATTLE_FACTORY_1F, 3
	warp_event  5, 13, BATTLE_FACTORY_1F, 3
	warp_event  4,  4, BATTLE_FACTORY_BATTLE_ROOM, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4, 12, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

	object_const_def
	const BATTLEFACTORYHALLWAY_RECEPTIONIST

BattleFactoryHallwayFollowReceptionist:
	readvar VAR_YCOORD
	ifnotequal 13, .arrived_after_battle
	prioritysjump .StepIntoRoom
	end

.arrived_after_battle
	prioritysjump .WonBattle
	end

.WonBattle:
	end

.StepIntoRoom:
	; First, step into the room properly, don't just linger at the entrance.
	follow BATTLEFACTORYHALLWAY_RECEPTIONIST, PLAYER
	applymovement BATTLEFACTORYHALLWAY_RECEPTIONIST, .WalkIntoRoomMovement
	stopfollow
	special Special_BattleTower_GenerateNextOpponent
	turnobject PLAYER, RIGHT
	; fallthrough
.NextRentalBattle:
	opentext
	writethistext
		text "I've researched the"
		line "next opponent."
		prompt

	special Special_BattleTower_NextRentalBattle
	iftrue .Continue

	opentext
	writethistext
		text "Cancel your run?"
		line "This counts as a"
		cont "streak loss."
		done
	yesorno
	closetext
	iffalse .NextRentalBattle

	; Player aborted the run.
	special FadeOutPalettes
	sjump Script_LostBattleFactory

.Continue:
	faceobject PLAYER, BATTLEFACTORYHALLWAY_RECEPTIONIST
	showtext .PleaseStepThisWayText
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
	done

.StepAbovePlayerMovement:
	step_up
	step_left
	step_end

.StepOntoFloorMovement:
	step_up
	step_up
	step_up
	step_end
