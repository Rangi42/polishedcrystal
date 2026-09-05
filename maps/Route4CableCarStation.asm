Route4CableCarStation_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 11, ROUTE_4, 2
	warp_event  5, 11, ROUTE_4, 2
	warp_event  5,  3, MOUNT_MOON_CABLE_CAR_STATION, 3

	def_coord_events
	coord_event  5,  4, SCENE_ALWAYS, Route4CableCarStationBoard

	def_bg_events

	def_object_events
	object_event  4,  5, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route4CableCarStationWelcomeText, -1

Route4CableCarStationBoard:
	opentext
	writetext Route4CableCarStationRideText
	yesorno
	iffalsefwd .Declined
	closetext
	applyonemovement PLAYER, step_up
	setval 0
	special Special_CableCar
	warpcheck
	newloadmap MAPSETUP_TRAIN
	applymovement PLAYER, Route4CableCarStationLeaveCar
	end

.Declined:
	closetext
	applyonemovement PLAYER, step_down
	end

Route4CableCarStationLeaveCar:
	step_down
	step_down
	turn_head_down
	step_end

Route4CableCarStationWelcomeText:
	text "Welcome! Step up"
	line "to the cable car"
	cont "to take a ride."
	done

Route4CableCarStationRideText:
	text "Ride the cable car"
	line "to Mt.Moon Square?"
	done
