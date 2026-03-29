Route16East_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 22, 12, ROUTE_16_17_GATE, 3
	warp_event 22, 13, ROUTE_16_17_GATE, 4
	warp_event 20,  4, ROUTE_16_GATE, 3
	warp_event 20,  5, ROUTE_16_GATE, 4

	def_coord_events

	def_bg_events
	bg_event 23,  3, BGEVENT_JUMPTEXT, Route16SignpostText

	def_object_events

Route16SignpostText:
	text "Route 16"
	done
