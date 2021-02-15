Route8SaffronGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  4, SAFFRON_CITY, 14
	warp_event  0,  5, SAFFRON_CITY, 15
	warp_event  9,  4, ROUTE_8, 1
	warp_event  9,  5, ROUTE_8, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route8SaffronGateOfficerText, -1

Route8SaffronGateOfficerText:
	text "Have you been to"
	line "Lavender Town?"

	para "There's a tall"
	line "Radio Tower there."
	done
