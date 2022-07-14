Route35CoastNorth_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13, 24, ROUTE_35_NATIONAL_PARK_GATE, 5
	warp_event 13, 25, ROUTE_35_NATIONAL_PARK_GATE, 6

	def_coord_events

	def_bg_events
	bg_event  6, 21, BGEVENT_JUMPTEXT, Route35CoastNorthPokeathlonDomeSignText
	bg_event  3, 11, BGEVENT_ITEM + BIG_PEARL, EVENT_ROUTE_35_COAST_NORTH_HIDDEN_BIG_PEARL
	bg_event  5, 23, BGEVENT_ITEM + SOFT_SAND, EVENT_ROUTE_35_COAST_NORTH_HIDDEN_SOFT_SAND

	def_object_events
	smashrock_event  8, 17
	smashrock_event 11, 20

Route35CoastNorthPokeathlonDomeSignText:
	text "The #athlon"
	line "Project Has"
	cont "Started!"
	done
