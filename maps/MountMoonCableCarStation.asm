MountMoonCableCarStation_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 11, MOUNT_MOON_SQUARE, 1
	warp_event  5, 11, MOUNT_MOON_SQUARE, 1
	warp_event  5,  3, ROUTE_4_CABLE_CAR_STATION, 3

	def_coord_events
	coord_event  5,  4, SCENE_ALWAYS, MountMoonCableCarStationBoard

	def_bg_events

	def_object_events
	object_event  4,  5, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, MountMoonCableCarStationWelcomeText, -1

MountMoonCableCarStationBoard:
	opentext
	writetext MountMoonCableCarStationRideText
	yesorno
	iffalsefwd .Declined
	closetext
	applyonemovement PLAYER, step_up
	setval 1
	special Special_CableCar
	warpcheck
	newloadmap MAPSETUP_TRAIN
	applymovement PLAYER, MountMoonCableCarStationLeaveCar
	end

.Declined:
	closetext
	applyonemovement PLAYER, step_down
	end

MountMoonCableCarStationLeaveCar:
	step_down
	step_down
	turn_head_down
	step_end

MountMoonCableCarStationWelcomeText:
	text "Welcome! Step up"
	line "to the cable car"
	cont "to take a ride."
	done

MountMoonCableCarStationRideText:
	text "Ride the cable car"
	line "to Route 4?"
	done
