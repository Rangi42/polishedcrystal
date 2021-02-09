	object_const_def
	const BATTLEFACTORYHALLWAY_RECEPTIONIST

BattleFactoryHallway_MapScriptHeader:
	def_scene_scripts
	scene_script BattleFactoryHallwayTrigger0

	def_callbacks

	def_warp_events
	warp_event 11,  1, BATTLE_FACTORY_ELEVATOR, 1
	warp_event  5,  0, BATTLE_FACTORY_BATTLE_ROOM, 1
	warp_event  7,  0, BATTLE_FACTORY_BATTLE_ROOM, 1
	warp_event  9,  0, BATTLE_FACTORY_BATTLE_ROOM, 1
	warp_event 13,  0, BATTLE_FACTORY_BATTLE_ROOM, 1
	warp_event 15,  0, BATTLE_FACTORY_BATTLE_ROOM, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 11,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

BattleFactoryHallwayTrigger0:
	priorityjump .ChooseBattleRoom
	end

.ChooseBattleRoom:
	; TODO: base this on winstreak instead since level group is gone
	follow BATTLEFACTORYHALLWAY_RECEPTIONIST, PLAYER
	callasm .asm_load_battle_room
	jump .WalkToChosenBattleRoom

.asm_load_battle_room
	ld a, 1
	ldh [hScriptVar], a
	ret

; enter different rooms for different levels to battle against
; at least it should look like that
; because all warps lead to the same room
.WalkToChosenBattleRoom: ; 0x9f5dc
	applymovement BATTLEFACTORYHALLWAY_RECEPTIONIST, MovementData_BattleFactoryHallwayWalkTo1020Room
	faceobject PLAYER, BATTLEFACTORYHALLWAY_RECEPTIONIST
	showtext Text_PleaseStepThisWay
	stopfollow
	applyonemovement PLAYER, step_up
	warpcheck
	end

MovementData_BattleFactoryHallwayWalkTo1020Room:
	step_right
	step_right
	step_right
	step_right
	step_up
	step_right
	turn_head_left
	step_end
