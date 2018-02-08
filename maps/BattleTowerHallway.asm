	const_def 1 ; object constants
	const BATTLETOWERHALLWAY_RECEPTIONIST

BattleTowerHallway_MapScriptHeader:
	db 1 ; scene scripts
	scene_script BattleTowerHallwayTrigger0

	db 0 ; callbacks

	db 6 ; warp events
	warp_event 11,  1, BATTLE_TOWER_ELEVATOR, 1
	warp_event  5,  0, BATTLE_TOWER_BATTLE_ROOM, 1
	warp_event  7,  0, BATTLE_TOWER_BATTLE_ROOM, 1
	warp_event  9,  0, BATTLE_TOWER_BATTLE_ROOM, 1
	warp_event 13,  0, BATTLE_TOWER_BATTLE_ROOM, 1
	warp_event 15,  0, BATTLE_TOWER_BATTLE_ROOM, 1

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 11,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

BattleTowerHallwayTrigger0:
	priorityjump .ChooseBattleRoom
	setscene $1
	end

.ChooseBattleRoom:
	follow BATTLETOWERHALLWAY_RECEPTIONIST, PLAYER
	callasm .asm_load_battle_room
	jump .WalkToChosenBattleRoom

.asm_load_battle_room
	ld a, [rSVBK]
	push af

	ld a, BANK(wBTChoiceOfLvlGroup)
	ld [rSVBK], a
	ld a, [wBTChoiceOfLvlGroup]
	ld [ScriptVar], a

	pop af
	ld [rSVBK], a
	ret

; enter different rooms for different levels to battle against
; at least it should look like that
; because all warps lead to the same room
.WalkToChosenBattleRoom: ; 0x9f5dc
	ifequal 3, .L30L40
	ifequal 4, .L30L40
	ifequal 5, .L50L60
	ifequal 6, .L50L60
	ifequal 7, .L70L80
	ifequal 8, .L70L80
	ifequal 9, .L90L100
	ifequal 10, .L90L100
	applymovement BATTLETOWERHALLWAY_RECEPTIONIST, MovementData_BattleTowerHallwayWalkTo1020Room
	jump .EnterBattleRoom

.L30L40: ; 0x9f603
	applymovement BATTLETOWERHALLWAY_RECEPTIONIST, MovementData_BattleTowerHallwayWalkTo3040Room
	jump .EnterBattleRoom

.L50L60: ; 0x9f60a
	applymovement BATTLETOWERHALLWAY_RECEPTIONIST, MovementData_BattleTowerHallwayWalkTo5060Room
	jump .EnterBattleRoom

.L70L80: ; 0x9f611
	applymovement BATTLETOWERHALLWAY_RECEPTIONIST, MovementData_BattleTowerHallwayWalkTo7080Room
	jump .EnterBattleRoom

.L90L100: ; 0x9f618
	applymovement BATTLETOWERHALLWAY_RECEPTIONIST, MovementData_BattleTowerHallwayWalkTo90100Room
	jump .EnterBattleRoom

.EnterBattleRoom: ; 0x9f61f
	faceobject PLAYER, BATTLETOWERHALLWAY_RECEPTIONIST
	showtext Text_PleaseStepThisWay
	stopfollow
	applyonemovement PLAYER, step_up
	warpcheck
	end

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

Text_PleaseStepThisWay: ; 0x9ec26
	text "Please step this"
	line "way."
	done
