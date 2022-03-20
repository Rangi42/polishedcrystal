Route39RuggedRoadGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route39RuggedRoadGateCallback

	def_warp_events
	warp_event  4,  0, RUGGED_ROAD, 1
	warp_event  5,  0, RUGGED_ROAD, 2
	warp_event  4,  7, ROUTE_39, 3
	warp_event  5,  7, ROUTE_39, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route39RuggedRoadGateOfficerText, -1

Route39RuggedRoadGateCallback:
	setevent EVENT_ROUTE_39_BOULDER
	endcallback

Route39RuggedRoadGateOfficerText:
	text "The trek to Snow-"
	line "top Mountain can"
	cont "be dangerous!"

	para "That's why a #-"
	line "mon Center was"
	cont "built there."
	done
