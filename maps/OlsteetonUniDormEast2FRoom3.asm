OlsteetonUniDormEast2FRoom3_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, OLSTEETON_UNI_DORM_EAST_2F, 4
	warp_event  4,  7, OLSTEETON_UNI_DORM_EAST_2F, 4


	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPTEXT, OlsteetonUniDormEast2FRoom3TrashText



	def_object_events
	; script about student packing stuff to quit and roommate trying to talk them out of it. do an event flag to go ask a prof for another chance in their stead.

OlsteetonUniDormEast2FRoom3TrashText:
	text "The trash"
	line "can is filled"
	cont "with textbooks..."
	done
