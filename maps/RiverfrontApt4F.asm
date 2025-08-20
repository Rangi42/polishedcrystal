RiverfrontApt4F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 14,  0, RIVERFRONT_APT_3F, 2
	warp_event 16,  0, RIVERFRONT_APT_5F, 1
	warp_event  9,  0, RIVERFRONT_APT_ELEVATOR, 1
	warp_event 11,  0, RIVERFRONT_APT_4F_ROOM_1, 1
	warp_event  2,  0, RIVERFRONT_APT_4F_ROOM_3, 1

	def_coord_events

	def_bg_events
	bg_event 17,  0, BGEVENT_JUMPTEXT, RiverfrontApt4FText
	bg_event 12,  0, BGEVENT_JUMPTEXT, RiverfrontApt4FRoom1Text
	bg_event  7,  0, BGEVENT_JUMPTEXT, RiverfrontApt4FRoom2Text
	bg_event  3,  0, BGEVENT_JUMPTEXT, RiverfrontApt4FRoom3Text
	bg_event  6,  0, BGEVENT_JUMPTEXT, RiverfrontApt4FLockedText


	def_object_events

RiverfrontApt4FText:
	text "4th Floor"
	done
RiverfrontApt4FRoom1Text:
	text "Apt. 401"
	line "Rebecca"
	done

RiverfrontApt4FRoom2Text:
	text "Apt. 402"
	line "PRIVATE"
	done

RiverfrontApt4FLockedText:
	text "The door"
	line "is locked."
	done

RiverfrontApt4FRoom3Text:
	text "Apt. 403"
	line "Amanda"
	done
