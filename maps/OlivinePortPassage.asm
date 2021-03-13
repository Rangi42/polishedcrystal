OlivinePortPassage_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3, 22, OLIVINE_CITY, 9
	warp_event  4, 22, OLIVINE_CITY, 10
	warp_event  3, 26, OLIVINE_PORT_PASSAGE, 4
	warp_event  3,  2, OLIVINE_PORT_PASSAGE, 3
	warp_event  3, 14, OLIVINE_PORT, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5, 23, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivinePortPassagePokefanMText, EVENT_OLIVINE_PORT_PASSAGE_POKEFAN_M

OlivinePortPassagePokefanMText:
	text "Fast Ship S.S.Aqua"
	line "sails to Kanto on"

	para "Mondays and Fri-"
	line "days."
	done
