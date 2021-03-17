Route15FuchsiaGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  5, FUCHSIA_CITY, 7
	warp_event  0,  6, FUCHSIA_CITY, 8
	warp_event  9,  5, ROUTE_15, 1
	warp_event  9,  6, ROUTE_15, 2
	warp_event  8,  8, ROUTE_15_FUCHSIA_GATE_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route15FuchsiaGateOfficerText, -1

Route15FuchsiaGateOfficerText:
	text "You're working on"
	line "a #dex? That's"

	para "really something."
	line "Don't give up!"
	done
