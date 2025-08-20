RiverfrontApt2FRoom2_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, RIVERFRONT_APT_2F, 5
	warp_event  3,  7, RIVERFRONT_APT_2F, 5


	def_coord_events

	def_bg_events
	bg_event  5,  1, BGEVENT_JUMPTEXT, RiverfrontApt2FRoom2FridgeText
	bg_event  7,  1, BGEVENT_JUMPTEXT, RiverfrontApt2FRoom2StoveText


	def_object_events

RiverfrontApt2FRoom2FridgeText:
	text "The fridge"
	line "really needs"
	cont "cleaned out..."
	done
RiverfrontApt2FRoom2StoveText:
	text "The burner was"
	line "left on..."

	para "Better turn it"
	line "off...click"
	done
