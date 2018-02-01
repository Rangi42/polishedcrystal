BattleTowerElevator_MapScriptHeader:
	db 1 ; map triggers
	dw BattleTowerElevatorTrigger0

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 3, 1, 1, BATTLE_TOWER_HALLWAY
	warp_def 3, 2, 1, BATTLE_TOWER_HALLWAY

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_RECEPTIONIST, 2, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

	const_def 1 ; person constants
	const BATTLETOWERELEVATOR_RECEPTIONIST

BattleTowerElevatorTrigger0:
	priorityjump .RideElevator
	dotrigger $1
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
