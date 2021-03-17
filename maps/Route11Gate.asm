Route11Gate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  5, ROUTE_11, 1
	warp_event  0,  6, ROUTE_11, 2
	warp_event  9,  5, ROUTE_12_SOUTH, 2
	warp_event  9,  6, ROUTE_12_SOUTH, 3
	warp_event  8,  8, ROUTE_11_GATE_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route11GateOfficerText, -1

Route11GateOfficerText:
	text "When you catch"
	line "lots of #mon,"
	cont "isn't it hard to"
	cont "think up names?"

	para "In Lavender Town,"
	line "there's a man who"
	cont "rates #mon"
	cont "nicknames."

	para "He'll help you"
	line "rename them too!"
	done
