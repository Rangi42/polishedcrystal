MountMoonSquareCableCarGate_MapScriptHeader:
	def_scene_scripts
	scene_script MountMoonSquareCableCarGateAskEnterScene, SCENE_MOUNTMOONSQUARECABLECARGATE_ASK_ENTER
	scene_script MountMoonSquareCableCarGateLeaveScene, SCENE_MOUNTMOONSQUARECABLECARGATE_LEAVE

	def_callbacks
	callback MAPCALLBACK_OBJECTS, MountMoonSquareCableCarGateMoveReceptionistCallback

	def_warp_events
	warp_event  6, 11, MOUNT_MOON_SQUARE, 2
	warp_event  7, 11, MOUNT_MOON_SQUARE, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  6,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, MountMoonSquareCableCarGateReceptionistScript, -1
	object_event 10,  9, SPRITE_HIKER, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MountMoonSquareCableCarGatePokefanMText, -1

	object_const_def
	const MOUNTMOONSQUARECABLECARGATE_RECEPTIONIST

MountMoonSquareCableCarGateMoveReceptionistCallback:
	readmem wCableCarGatesSceneID
	iffalsefwd .Nothing
	moveobject MOUNTMOONSQUARECABLECARGATE_RECEPTIONIST, 7, 4
	turnobject MOUNTMOONSQUARECABLECARGATE_RECEPTIONIST, LEFT
.Nothing
	endcallback

MountMoonSquareCableCarGateLeaveScene:
	sdefer MountMoonSquareCableCarGate_PlayerArrives
MountMoonSquareCableCarGateAskEnterScene:
	end

MountMoonSquareCableCarGate_PlayerArrives:
	follow PLAYER, MOUNTMOONSQUARECABLECARGATE_RECEPTIONIST
	applymovement PLAYER, .LeaveCableCarMovement
	stopfollow
	setscene SCENE_MOUNTMOONSQUARECABLECARGATE_ASK_ENTER
	end

.LeaveCableCarMovement:
	step_down
	step_down
	step_down
	step_end

MountMoonSquareCableCarGateReceptionistScript:
	faceplayer
	opentext
	writetext .ReadyToGoDownText
	yesorno
	iffalse_jumpopenedtext .AnotherTimeText
	writetext .StepThisWayText
	waitbutton
	closetext
	follow ROUTE3CABLECARGATE_RECEPTIONIST, PLAYER
	applymovement ROUTE3CABLECARGATE_RECEPTIONIST, .ApproachCableCarMovement
	stopfollow
	pause 15
	playsound SFX_EXIT_BUILDING
	applyonemovement PLAYER, hide_object
	waitsfx
	disappear PLAYER
	special Special_FadeOutMusic
	special FadeOutPalettes
	pause 15
	special Special_CableCar
	setmapscene ROUTE_3_CABLE_CAR_GATE, SCENE_ROUTE3CABLECARGATE_LEAVE
	warpfacing DOWN, ROUTE_3_CABLE_CAR_GATE, 6, 4
	end

.ReadyToGoDownText:
	text "The cable car is"
	line "ready to go down."

	para "Would you like"
	line "to be on it?"
	done

.AnotherTimeText:
	text "Please ride with"
	line "us another time."
	done

.StepThisWayText:
	text "Please step this"
	line "way."
	done

.ApproachCableCarMovement:
	step_up
	step_up
	step_right
	turn_head_left
	step_end

MountMoonSquareCableCarGatePokefanMText:
	text "I remember there"
	line "was nothing built"

	para "here when I climb-"
	line "ed the mountain."

	para "Things are more"
	line "convenient now."
	done
