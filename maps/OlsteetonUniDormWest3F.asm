OlsteetonUniDormWest3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 15,  0, OLSTEETON_UNI_DORM_WEST_2F, 2
	; warp_event 17,  3, OLSTEETON_UNI_DORM_WEST_ROOF, 1
	warp_event  6,  0, OLSTEETON_UNI_DORM_WEST_3F_ROOM_1, 1
	warp_event  2,  0, OLSTEETON_UNI_DORM_WEST_3F_ROOM_3, 1
		; warp_event  9,  0, OLSTEETON_UNI_DORM_WEST_ELEVATOR, 1


	def_coord_events

	def_bg_events
	bg_event 17,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormWest3FText
	bg_event 12,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormWest3FRoom1Text
	bg_event  7,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormWest3FRoom2Text
	bg_event  2,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormWest3FRoom3Text

	def_object_events

OlsteetonUniDormWest3FText:
	text "3rd Floor"
	done
OlsteetonUniDormWest3FRoom1Text:
	text "Room 301"
	line "Resident Advisor"
	cont "James"
	done

OlsteetonUniDormWest3FRoom2Text:
	text "Room 302"
	line "Jason"
	done

OlsteetonUniDormWest3FRoom3Text:
	text "Room 303"
	line "Chris"
	done
