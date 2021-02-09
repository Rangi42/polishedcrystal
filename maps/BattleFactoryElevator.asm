BattleFactoryElevator_MapScriptHeader:
	def_scene_scripts
	scene_script BattleFactoryElevatorTrigger0

	def_callbacks

	def_warp_events
	warp_event  1,  3, BATTLE_FACTORY_HALLWAY, 1
	warp_event  2,  3, BATTLE_FACTORY_HALLWAY, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

	object_const_def
	const BATTLEFACTORYELEVATOR_RECEPTIONIST

BattleFactoryElevatorTrigger0:
	priorityjump .RideElevator
	end

.RideElevator:
	follow BATTLEFACTORYELEVATOR_RECEPTIONIST, PLAYER
	applymovement BATTLEFACTORYELEVATOR_RECEPTIONIST, MovementData_BattleFactoryElevatorReceptionistWalksIn
	applyonemovement PLAYER, turn_head_down
	special Special_BattleTower_MaxVolume
	playsound SFX_ELEVATOR
	earthquake 60
	waitsfx
	follow BATTLEFACTORYELEVATOR_RECEPTIONIST, PLAYER
	applyonemovement BATTLEFACTORYELEVATOR_RECEPTIONIST, step_down
	stopfollow
	warpsound
	disappear BATTLEFACTORYELEVATOR_RECEPTIONIST
	applyonemovement PLAYER, step_down
	warpcheck
	end

MovementData_BattleFactoryElevatorReceptionistWalksIn:
	step_right
	turn_head_down
	step_end
