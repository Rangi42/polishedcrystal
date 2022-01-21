Route12Gate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  0, ROUTE_12_NORTH, 1
	warp_event  5,  0, ROUTE_12_NORTH, 2
	warp_event  4,  9, ROUTE_12_SOUTH, 4
	warp_event  5,  9, ROUTE_12_SOUTH, 4
	warp_event  8,  8, ROUTE_12_GATE_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  5, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route12GateOfficerText, -1

Route12GateOfficerText:
	text "Silence Bridge got"
	line "its name from all"

	para "the people quietly"
	line "fishing on it."
	done
