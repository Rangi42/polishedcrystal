Route16Northwest_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  9,  1, ROUTE_16_FUCHSIA_SPEECH_HOUSE, 1
	warp_event 15,  4, ROUTE_16_GATE, 1
	warp_event 15,  5, ROUTE_16_GATE, 2

	def_coord_events

	def_bg_events
	bg_event  5,  2, BGEVENT_JUMPTEXT, Route16SignpostText

	def_object_events

Route16SignpostText:
	text "Route 16"
	done
