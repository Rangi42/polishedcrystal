OlsteetonUniDormEast3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 15,  0, OLSTEETON_UNI_DORM_EAST_2F, 5
	; warp_event 17,  3, OLSTEETON_UNI_DORM_EAST_ROOF, 1
	warp_event 11,  0, OLSTEETON_UNI_DORM_EAST_3F_ROOM_2, 1
	warp_event  2,  0, OLSTEETON_UNI_DORM_EAST_3F_ROOM_3, 1
	; warp_event  9,  0, OLSTEETON_UNI_DORM_EAST_ELEVATOR, 1


	def_coord_events

	def_bg_events
	bg_event 17,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast3FText
	bg_event 12,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast3FRoom1Text
	bg_event  7,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast3FRoom2Text
	bg_event  2,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast3FRoom3Text

	def_object_events

OlsteetonUniDormEast3FText:
	text "2nd Floor"
	done
OlsteetonUniDormEast3FRoom1Text:
	text "Room 201"
	line "Resident Advisor"
	cont "James"
	done

OlsteetonUniDormEast3FRoom2Text:
	text "Room 202"
	line "Jason"
	done

OlsteetonUniDormEast3FRoom3Text:
	text "Room 203"
	line "Chris"
	done
