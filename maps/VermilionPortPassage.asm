VermilionPortPassage_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3, 22, VERMILION_CITY, 8
	warp_event  4, 22, VERMILION_CITY, 9
	warp_event  3, 26, VERMILION_PORT_PASSAGE, 4
	warp_event  3,  2, VERMILION_PORT_PASSAGE, 3
	warp_event  3, 14, VERMILION_PORT, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5, 23, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionPortPassageTeacherText, -1

VermilionPortPassageTeacherText:
	text "The Fast Ship"
	line "sails on Wednes-"
	cont "days and Sundays"
	cont "every week."
	done
