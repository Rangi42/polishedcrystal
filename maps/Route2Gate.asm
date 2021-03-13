Route2Gate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  0, ROUTE_2_NORTH, 2
	warp_event  5,  0, ROUTE_2_NORTH, 3
	warp_event  4,  7, ROUTE_2_SOUTH, 1
	warp_event  5,  7, ROUTE_2_SOUTH, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  6,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route2GateScientistText, -1

Route2GateScientistText:
	text "Are you <PLAYER>?"

	para "I work as Prof."
	line "Oak's Aide."

	para "I had no idea that"
	line "you were out here."

	para "Prof.Oak's Lab is"
	line "nearby in Pallet"
	cont "Town."
	done
