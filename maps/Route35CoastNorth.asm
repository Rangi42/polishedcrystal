Route35CoastNorth_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13, 22, ROUTE_35_NATIONAL_PARK_GATE, 5
	warp_event 13, 23, ROUTE_35_NATIONAL_PARK_GATE, 6
	warp_event  4, 10, HIDDEN_TREE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event  6, 21, BGEVENT_JUMPTEXT, Route35CoastNorthPokeathlonDomeSignText
	bg_event  6, 12, BGEVENT_JUMPTEXT, Route35CoastNorthAdvancedTipsSignText
	bg_event  3, 11, BGEVENT_ITEM + BIG_PEARL, EVENT_ROUTE_35_COAST_NORTH_HIDDEN_BIG_PEARL
	bg_event  5, 23, BGEVENT_ITEM + SOFT_SAND, EVENT_ROUTE_35_COAST_NORTH_HIDDEN_SOFT_SAND
	bg_event  4,  9, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_35_COAST
	bg_event  5,  9, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_35_COAST

	def_object_events
	smashrock_event  8, 17
	smashrock_event 11, 20

Route35CoastNorthPokeathlonDomeSignText:
	text "The #athlon"
	line "Project Has"
	cont "Started!"
	done

Route35CoastNorthAdvancedTipsSignText:
	text "Advanced Tips!"

	para "You can cast a"
	line "fishing line even"

	para "from a Surfing"
	line "#mon's back!"
	done
