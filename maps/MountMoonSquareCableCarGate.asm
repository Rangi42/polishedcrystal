MountMoonSquareCableCarGate_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_MOUNTMOONSQUARECABLECARGATE_CABLE_CAR

	def_callbacks

	def_warp_events
	warp_event  6, 11, MOUNT_MOON_SQUARE, 2
	warp_event  7, 11, MOUNT_MOON_SQUARE, 2

	def_coord_events
	coord_event  6,  4, SCENE_MOUNTMOONSQUARECABLECARGATE_CABLE_CAR, MountMoonSquareCableCarGateCableCarScript

	def_bg_events

	def_object_events
	object_event 10,  9, SPRITE_HIKER, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MountMoonSquareCableCarGatePokefanMText, -1

MountMoonSquareCableCarGateCableCarScript:
	playsound SFX_EXIT_BUILDING
	applyonemovement PLAYER, hide_object
	waitsfx
	disappear PLAYER
	pause 10
	special Special_FadeOutMusic
	special FadeOutPalettes
	pause 15
	special Special_CableCar
	warpfacing DOWN, ROUTE_3_CABLE_CAR_GATE, 6, 7
	end

MountMoonSquareCableCarGatePokefanMText:
	text "I remember there"
	line "was nothing built"

	para "here when I climb-"
	line "ed the mountain."

	para "Things are more"
	line "convenient now."
	done
