OlsteetonUniDormWest2FRoom3_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, OLSTEETON_UNI_DORM_EAST_2F, 4
	warp_event  4,  7, OLSTEETON_UNI_DORM_EAST_2F, 4

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPTEXT, OlsteetonUniDormWest2FRoom3TrashText


	def_object_events

OlsteetonUniDormWest2FRoom3TrashText:
	text "The trash"
	line "hasn't been"
	cont "taken out..."

	para "It's starting"
	line "to smell..."
	done
