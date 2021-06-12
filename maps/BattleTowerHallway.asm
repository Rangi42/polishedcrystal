BattleTowerHallway_MapScriptHeader:
	def_scene_scripts
	scene_script BattleTowerHallwayFollowReceptionist

	def_callbacks

	def_warp_events
	warp_event 11,  1, BATTLE_TOWER_ELEVATOR, 1
	warp_event  5,  0, BATTLE_TOWER_BATTLE_ROOM, 1
	warp_event  7,  0, BATTLE_TOWER_BATTLE_ROOM, 1
	warp_event  9,  0, BATTLE_TOWER_BATTLE_ROOM, 1
	warp_event 13,  0, BATTLE_TOWER_BATTLE_ROOM, 1
	warp_event 15,  0, BATTLE_TOWER_BATTLE_ROOM, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 11,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

	object_const_def
	const BATTLETOWERHALLWAY_RECEPTIONIST

BattleTowerHallwayFollowReceptionist:
	sdefer .ChooseBattleRoom
	end

.ChooseBattleRoom:
	follow BATTLETOWERHALLWAY_RECEPTIONIST, PLAYER
	scall .PickBattleRoom
	ifequal 0, .Room1
	ifequal 1, .Room2
	ifequal 2, .Room3
	ifequal 3, .Room4
	applymovement BATTLETOWERHALLWAY_RECEPTIONIST, MovementData_BattleTowerHallwayWalkTo1020Room
	sjump .EnterBattleRoom

.Room1:
	applymovement BATTLETOWERHALLWAY_RECEPTIONIST, MovementData_BattleTowerHallwayWalkTo3040Room
	sjump .EnterBattleRoom

.Room2:
	applymovement BATTLETOWERHALLWAY_RECEPTIONIST, MovementData_BattleTowerHallwayWalkTo5060Room
	sjump .EnterBattleRoom

.Room3:
	applymovement BATTLETOWERHALLWAY_RECEPTIONIST, MovementData_BattleTowerHallwayWalkTo7080Room
	sjump .EnterBattleRoom

.Room4:
	applymovement BATTLETOWERHALLWAY_RECEPTIONIST, MovementData_BattleTowerHallwayWalkTo90100Room
	sjump .EnterBattleRoom

.EnterBattleRoom:
	stopfollow
	faceobject PLAYER, BATTLETOWERHALLWAY_RECEPTIONIST
	showtext .PleaseStepThisWayText
	applyonemovement PLAYER, step_up
	warpcheck
	end

.PickBattleRoom:
	; TODO: base this on winstreak instead since level group is gone
	random 5
	end

.PleaseStepThisWayText:
	text "Please step this"
	line "way."
	done

MovementData_BattleTowerHallwayWalkTo1020Room:
	step_right
	step_right
MovementData_BattleTowerHallwayWalkTo3040Room:
	step_right
	step_right
	step_up
	step_right
	turn_head_left
	step_end

MovementData_BattleTowerHallwayWalkTo90100Room:
	step_left
	step_left
MovementData_BattleTowerHallwayWalkTo7080Room:
	step_left
	step_left
MovementData_BattleTowerHallwayWalkTo5060Room:
	step_left
	step_left
	step_up
	step_left
	turn_head_right
	step_end
