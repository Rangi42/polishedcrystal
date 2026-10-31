Route3CableCarGate_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_ROUTE3CABLECARGATE_CABLE_CAR

	def_callbacks

	def_warp_events
	warp_event  6, 11, ROUTE_3, 2
	warp_event  7, 11, ROUTE_3, 2

	def_coord_events
	coord_event  6,  4, SCENE_ROUTE3CABLECARGATE_CABLE_CAR, Route3CableCarGateCableCarScript

	def_bg_events

	def_object_events
	object_event  3, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route3CableCarGatePokefanMText, -1
	object_event  1,  8, SPRITE_CAMPER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route3CableCarGateYoungsterText, -1

Route3CableCarGateCableCarScript:
	playsound SFX_EXIT_BUILDING
	applyonemovement PLAYER, hide_object
	waitsfx
	disappear PLAYER
	pause 10
	special Special_FadeOutMusic
	special FadeOutPalettes
	pause 15
	special Special_CableCar
	warpfacing DOWN, MOUNT_MOON_SQUARE_CABLE_CAR_GATE, 6, 7
	end

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
