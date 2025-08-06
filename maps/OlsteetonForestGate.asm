OlsteetonForestGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  0, OLSTEETON, 21
	warp_event  5,  0, OLSTEETON, 22
	warp_event  4,  7, NATIONAL_FOREST_1, 1
	warp_event  5,  7, NATIONAL_FOREST_1, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonForestGuardText, -1


OlsteetonForestGuardText:
	para "Pfft I can't"
	line "believe they're"

	para "logging in the"
	line "regional park."
	done