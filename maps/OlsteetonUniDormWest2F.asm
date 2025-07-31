RiverfrontApt2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 15,  0, RIVERFRONT_APT_1F, 5
	warp_event 17,  3, RIVERFRONT_APT_3F, 1
	warp_event  9,  0, RIVERFRONT_APT_ELEVATOR, 1
	; warp_event 11,  0, RIVERFRONT_APT_2F_ROOM_1, 1
	; warp_event  6,  0, RIVERFRONT_APT_2F_ROOM_2, 1
	; warp_event  2,  0, RIVERFRONT_APT_2F_ROOM_3, 1

	def_coord_events

	def_bg_events
	bg_event 17,  0, BGEVENT_JUMPTEXT, RiverfrontApt2FText
	bg_event 12,  0, BGEVENT_JUMPTEXT, RiverfrontApt2FRoom1Text
	bg_event  7,  0, BGEVENT_JUMPTEXT, RiverfrontApt2FRoom2Text
	bg_event  2,  0, BGEVENT_JUMPTEXT, RiverfrontApt2FRoom3Text

	def_object_events

RiverfrontApt2FText:
	text "2nd Floor"
	done
RiverfrontApt2FRoom1Text:
	text "Apt. 201"
	line "Jacob"
	done

RiverfrontApt2FRoom2Text:
	text "Apt. 202"
	line "Zach"
	done

RiverfrontApt2FRoom3Text:
	text "Apt. 203"
	line "Isabelle"
	done
