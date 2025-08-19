OlsteetonUniDormEast3FRoom3_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, OLSTEETON_UNI_DORM_EAST_3F, 3
	warp_event  4,  7, OLSTEETON_UNI_DORM_EAST_3F, 3

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPTEXT, OlsteetonUniDormEast3FRoom3TrashText


	def_object_events

OlsteetonUniDormEast3FRoom3TrashText:
	text "There's a bunch"
	line "of empty lemonade"
	cont "cans in here..."
	done
