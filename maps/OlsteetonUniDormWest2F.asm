OlsteetonUniDormWest2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 15,  0, OLSTEETON_UNI_DORM_WEST_1F, 5
	warp_event 17,  0, OLSTEETON_UNI_DORM_WEST_3F, 1
	; warp_event  9,  0, OLSTEETON_UNI_DORM_WEST_ELEVATOR, 1
	warp_event 12,  0, OLSTEETON_UNI_DORM_WEST_2F_ROOM_2, 1
	warp_event  2,  0, OLSTEETON_UNI_DORM_WEST_2F_ROOM_3, 1

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormWest2FText
	bg_event 13,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormWest2FRoom1Text
	bg_event  7,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormWest2FRoom2Text
	bg_event  3,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormWest2FRoom3Text

	def_object_events

OlsteetonUniDormWest2FText:
	text "2nd Floor"
	done
OlsteetonUniDormWest2FRoom1Text:
	text "Room 201"
	line "Resident Advisor"
	cont "James"
	done

OlsteetonUniDormWest2FRoom2Text:
	text "Room 202"
	line "Jason"
	done

OlsteetonUniDormWest2FRoom3Text:
	text "Room 203"
	line "Chris"
	done
