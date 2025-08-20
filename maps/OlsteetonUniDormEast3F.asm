OlsteetonUniDormEast3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  1,  0, OLSTEETON_UNI_DORM_EAST_2F, 2
	warp_event 10,  0, OLSTEETON_UNI_DORM_EAST_3F_ROOM_2, 1
	warp_event 14,  0, OLSTEETON_UNI_DORM_EAST_3F_ROOM_3, 1
	warp_event  9,  0, OLSTEETON_UNI_DORM_EAST_ELEVATOR, 1
	; warp_event 17,  3, OLSTEETON_UNI_DORM_EAST_ROOF, 1



	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast3FText
	bg_event 7,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast3FRoom1Text
	bg_event  11,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast3FRoom2Text
	bg_event 15,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast3FRoom3Text

	def_object_events

OlsteetonUniDormEast3FText:
	text "3rd Floor"
	done
OlsteetonUniDormEast3FRoom1Text:
	text "Room 301"
	line "Resident Advisor"
	cont "David"
	done

OlsteetonUniDormEast3FRoom2Text:
	text "Room 302"
	line "Shane"
	done

OlsteetonUniDormEast3FRoom3Text:
	text "Room 303"
	line "Elijah"
	done
