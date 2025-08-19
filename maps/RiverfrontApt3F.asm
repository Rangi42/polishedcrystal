RiverfrontApt3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 14,  0, RIVERFRONT_APT_2F, 2
	warp_event 16,  0, RIVERFRONT_APT_4F, 1
	warp_event  9,  0, RIVERFRONT_APT_ELEVATOR, 1
	warp_event 11,  0, RIVERFRONT_APT_3F_ROOM_1, 1
	warp_event  6,  0, RIVERFRONT_APT_3F_ROOM_2, 1

	def_coord_events

	def_bg_events
	bg_event 17,  0, BGEVENT_JUMPTEXT, RiverfrontApt3FText
	bg_event 12,  0, BGEVENT_JUMPTEXT, RiverfrontApt3FRoom1Text
	bg_event  7,  0, BGEVENT_JUMPTEXT, RiverfrontApt3FRoom2Text
	bg_event  3,  0, BGEVENT_JUMPTEXT, RiverfrontApt3FRoom3Text
	bg_event  2,  0, BGEVENT_JUMPTEXT, RiverfrontApt3FLockedText


	def_object_events

RiverfrontApt3FText:
	text "3rd Floor"
	done
RiverfrontApt3FRoom1Text:
	text "Apt. 301"
	line "James"
	done

RiverfrontApt3FRoom2Text:
	text "Apt. 302"
	line "Alex"
	done

RiverfrontApt3FRoom3Text:
	text "Apt. 303"
	line "VACANT"
	done

RiverfrontApt3FLockedText:
	text "The door is locked."
	done
