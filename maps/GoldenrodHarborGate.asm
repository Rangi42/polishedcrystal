GoldenrodHarborGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  4, GOLDENROD_HARBOR, 1
	warp_event  0,  5, GOLDENROD_HARBOR, 2
	warp_event  9,  4, GOLDENROD_CITY, 16
	warp_event  9,  5, GOLDENROD_CITY, 17

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodHarborGateOfficerText, -1

GoldenrodHarborGateOfficerText:
	text "If your #mon"
	line "knows how to Surf,"

	para "you can head north"
	line "to Olivine City."
	done
