Route28_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  3, ROUTE_28_FAMOUS_SPEECH_HOUSE, 1
	warp_event 33,  5, POKEMON_LEAGUE_GATE, 7

	def_coord_events

	def_bg_events
	bg_event 31,  5, BGEVENT_JUMPTEXT, Route28SignText
	bg_event 25,  3, BGEVENT_ITEM + RARE_CANDY, EVENT_ROUTE_28_HIDDEN_RARE_CANDY

	def_object_events

Route28SignText:
	text "Route 28"
	done
