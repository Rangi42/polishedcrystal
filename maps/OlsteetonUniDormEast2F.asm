OlsteetonUniDormEast2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  1,  0, OLSTEETON_UNI_DORM_EAST_1F, 5
	warp_event  3,  0, OLSTEETON_UNI_DORM_EAST_3F, 1
	warp_event  6,  0, OLSTEETON_UNI_DORM_EAST_2F_ROOM_1, 1
	warp_event 14,  0, OLSTEETON_UNI_DORM_EAST_2F_ROOM_3, 1
	warp_event  9,  0, OLSTEETON_UNI_DORM_EAST_ELEVATOR, 1
	

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast2FText
	bg_event  7,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast2FRoom1Text
	bg_event 11,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast2FRoom2Text
	bg_event 15,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast2FRoom3Text

	def_object_events

OlsteetonUniDormEast2FText:
	text "2nd Floor"
	done
OlsteetonUniDormEast2FRoom1Text:
	text "Room 201"
	line "Resident Advisor"
	cont "Courtney"
	done

OlsteetonUniDormEast2FRoom2Text:
	text "Room 202"
	line "Krystal"
	done

OlsteetonUniDormEast2FRoom3Text:
	text "Room 203"
	line "Emmeline"
	done
