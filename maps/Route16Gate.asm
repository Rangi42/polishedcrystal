Route16Gate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  4, ROUTE_16_NORTH, 2
	warp_event  0,  5, ROUTE_16_NORTH, 3
	warp_event  9,  4, ROUTE_16_EAST, 3
	warp_event  9,  5, ROUTE_16_EAST, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route16GateOfficerText, -1

	end

Route16GateOfficerText:
	text "Route 16 is a bit"
	line "untamed."

	para "You'll need HM"
	line "moves to get"
	cont "through."
	done
