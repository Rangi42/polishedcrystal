ViridianForestPewterGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  7, VIRIDIAN_FOREST, 1
	warp_event  5,  7, VIRIDIAN_FOREST, 1
	warp_event  4,  0, ROUTE_2_NORTH, 5
	warp_event  5,  0, ROUTE_2_NORTH, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, ViridianForestPewterGateOfficerText, -1

ViridianForestPewterGateOfficerText:
	text "Are you headed"
	line "to Pewter City?"

	para "Be sure to check"
	line "out the Museum!"
	done
