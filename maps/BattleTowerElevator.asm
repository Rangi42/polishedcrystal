BattleTowerElevator_MapScriptHeader:
	db 1 ; scene scripts
	scene_script BattleTowerElevatorTrigger0

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  1,  3, BATTLE_TOWER_HALLWAY, 1
	warp_event  2,  3, BATTLE_TOWER_HALLWAY, 1

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  1,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

	const_def 1 ; object constants
	const BATTLETOWERELEVATOR_RECEPTIONIST

BattleTowerElevatorTrigger0:
	priorityjump .RideElevator
	setscene $1
	end

.RideElevator:
	follow BATTLETOWERELEVATOR_RECEPTIONIST, PLAYER
	applymovement BATTLETOWERELEVATOR_RECEPTIONIST, MovementData_BattleTowerElevatorReceptionistWalksIn
	applyonemovement PLAYER, turn_head_down
	special Special_BattleTower_MaxVolume
	playsound SFX_ELEVATOR
	earthquake 60
	waitsfx
	follow BATTLETOWERELEVATOR_RECEPTIONIST, PLAYER
	applyonemovement BATTLETOWERELEVATOR_RECEPTIONIST, step_down
	stopfollow
	warpsound
	disappear BATTLETOWERELEVATOR_RECEPTIONIST
	applyonemovement PLAYER, step_down
	warpcheck
	end

MovementData_BattleTowerElevatorReceptionistWalksIn:
	step_right
	turn_head_down
	step_end
