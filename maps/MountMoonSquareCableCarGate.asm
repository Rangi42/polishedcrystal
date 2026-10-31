MountMoonSquareCableCarGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

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
	warpfacing DOWN, ROUTE_3_CABLE_CAR_GATE, 6, 7
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
