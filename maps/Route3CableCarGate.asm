Route3CableCarGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6, 11, ROUTE_3, 2
	warp_event  7, 11, ROUTE_3, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  6,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, Route3CableCarGateReceptionistScript, -1
	object_event 11, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route3CableCarGatePokefanMText, -1
	object_event  1,  8, SPRITE_CAMPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route3CableCarGateYoungsterText, -1

	object_const_def
	const ROUTE3CABLECARGATE_RECEPTIONIST

Route3CableCarGateReceptionistScript:
	faceplayer
	opentext
	writetext .ReadyToGoUpText
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
	warpfacing DOWN, MOUNT_MOON_SQUARE_CABLE_CAR_GATE, 6, 7
	end

.ReadyToGoUpText:
	text "The cable car is"
	line "ready to go up."

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
	step_left
	turn_head_right
	step_end

Route3CableCarGatePokefanMText:
	text "A few years ago"
	line "I sold a weird-"

	para "colored Magikarp"
	line "to this boy…"

	para "I thought there"
	line "was something"
	cont "wrong with it."

	para "Turns out it was"
	line "a rare shiny"
	cont "#mon!"

	para "I could have made"
	line "a lot more money!"
	done

Route3CableCarGateYoungsterText:
	text "Many trainers are"
	line "on the mountain."

	para "Many wild #mon"
	line "too."

	para "You never know who"
	line "or what you'll en-"
	cont "counter."
	done
