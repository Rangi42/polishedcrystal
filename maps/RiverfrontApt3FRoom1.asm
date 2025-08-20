RiverfrontApt3FRoom1_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, RIVERFRONT_APT_3F, 4
	warp_event  3,  7, RIVERFRONT_APT_3F, 4


	def_coord_events

	def_bg_events
	bg_event  5,  1, BGEVENT_JUMPTEXT, RiverfrontApt3FRoom1FridgeText
	bg_event  7,  1, BGEVENT_JUMPTEXT, RiverfrontApt3FRoom1StoveText


	def_object_events

RiverfrontApt3FRoom1FridgeText:
	text "The fridge"
	line "really needs"
	cont "cleaned out..."
	done
RiverfrontApt3FRoom1StoveText:
	text "The burner was"
	line "left on..."

	para "Better turn it"
	line "off...click"
	done
