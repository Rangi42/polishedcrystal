const_value set 1
	const BATTLETOWERHALLWAY_RECEPTIONIST

BattleTowerHallway_MapScriptHeader:

.MapTriggers: db 1
	dw BattleTowerHallwayTrigger0

.MapCallbacks: db 0

BattleTowerHallway_MapEventHeader:

.Warps: db 6
	warp_def 1, 11, 1, BATTLE_TOWER_ELEVATOR
	warp_def 0, 5, 1, BATTLE_TOWER_BATTLE_ROOM
	warp_def 0, 7, 1, BATTLE_TOWER_BATTLE_ROOM
	warp_def 0, 9, 1, BATTLE_TOWER_BATTLE_ROOM
	warp_def 0, 13, 1, BATTLE_TOWER_BATTLE_ROOM
	warp_def 0, 15, 1, BATTLE_TOWER_BATTLE_ROOM

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_RECEPTIONIST, 2, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

BattleTowerHallwayTrigger0:
	priorityjump .ChooseBattleRoom
	dotrigger $1
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
	if_equal 3, .L30L40
	if_equal 4, .L30L40
	if_equal 5, .L50L60
	if_equal 6, .L50L60
	if_equal 7, .L70L80
	if_equal 8, .L70L80
	if_equal 9, .L90L100
	if_equal 10, .L90L100
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
	faceperson PLAYER, BATTLETOWERHALLWAY_RECEPTIONIST
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
