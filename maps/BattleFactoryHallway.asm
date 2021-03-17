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
	prioritysjump .SwapPokemon
	end

.SwapPokemon:
	; TODO: swap a mon for your opponent's
	follow BATTLEFACTORYHALLWAY_RECEPTIONIST, PLAYER
	applymovement BATTLEFACTORYHALLWAY_RECEPTIONIST, .WalkIntoRoomMovement
	stopfollow
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
