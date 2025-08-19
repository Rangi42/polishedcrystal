OlsteetonUniDormEast3FRoom2_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, OLSTEETON_UNI_DORM_EAST_3F, 2
	warp_event  4,  7, OLSTEETON_UNI_DORM_EAST_3F, 2


	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPTEXT, OlsteetonUniDormEast3FRoom2TrashText


	def_object_events

OlsteetonUniDormEast3FRoom2TrashText:
	text "There's several"
	line "berry pits"
	cont "in here."
	done
