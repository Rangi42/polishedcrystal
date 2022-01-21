Route1ViridianGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  0, VIRIDIAN_CITY, 6
	warp_event  5,  0, VIRIDIAN_CITY, 7
	warp_event  4,  7, ROUTE_1, 1
	warp_event  5,  7, ROUTE_1, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route1ViridianGateOfficerText, -1
	object_event  6,  4, SPRITE_ROCKER, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route1ViridianGateRockerText, -1

Route1ViridianGateOfficerText:
	text "To the south is"
	line "Pallet Town."

	para "That's where"
	line "Prof.Oak lives."
	done

Route1ViridianGateRockerText:
	text "If you really"
	line "think about it,"

	para "aren't we ALL on"
	line "the road to Vir-"
	cont "idian City?"
	done
