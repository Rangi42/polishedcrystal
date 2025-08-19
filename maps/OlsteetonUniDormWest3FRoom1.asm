OlsteetonUniDormWest3FRoom1_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, OLSTEETON_UNI_DORM_WEST_3F, 2
	warp_event  4,  7, OLSTEETON_UNI_DORM_WEST_3F, 2


	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPTEXT, OlsteetonUniDormWest3FRoom1TrashText


	def_object_events

OlsteetonUniDormWest3FRoom1TrashText:
	text "There's a note"
	line "on a crumpled"

	para "sheet of paper"
	line "......."

	para "It's a strategy"
	line "for the Clock"
	cont "Tower challenge."

	para "It says: 'BRING"
	line "A DARK TYPE"
	cont "NEXT TIME!'"
	done
