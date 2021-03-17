Route2South_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 15,  3, ROUTE_2_GATE, 3
	warp_event  5,  7, VIRIDIAN_FOREST_VIRIDIAN_GATE, 3

	def_coord_events

	def_bg_events
	bg_event  5, 29, BGEVENT_JUMPTEXT, Route2SignText

	def_object_events
	object_event 10, 23, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerBug_maniacRob, -1
	object_event  0, 16, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBug_maniacDoug, -1
	itemball_event 14, 30, ELIXIR, 1, EVENT_ROUTE_2_ELIXIR
	cuttree_event 11, 16, EVENT_ROUTE_2_CUT_TREE_3
	cuttree_event 12, 24, EVENT_ROUTE_2_CUT_TREE_4
	cuttree_event 12, 30, EVENT_ROUTE_2_CUT_TREE_5
	object_event 23, 23, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_16_WEST_CUT_TREE_1

GenericTrainerBug_maniacRob:
	generictrainer BUG_MANIAC, ROB, EVENT_BEAT_BUG_MANIAC_ROB, Bug_maniacRobSeenText, Bug_maniacRobBeatenText

	text "I'm going to look"
	line "for stronger bug"
	cont "#mon."
	done

GenericTrainerBug_maniacDoug:
	generictrainer BUG_MANIAC, DOUG, EVENT_BEAT_BUG_MANIAC_DOUG, Bug_maniacDougSeenText, Bug_maniacDougBeatenText

	text "Bug #mon squish"
	line "like plush toys"

	para "when you squeeze"
	line "their bellies."

	para "I love how they"
	line "feel!"
	done

Bug_maniacRobSeenText:
	text "My bug #mon are"
	line "tough. Prepare to"
	cont "lose!"
	done

Bug_maniacRobBeatenText:
	text "I was whipped…"
	done

Bug_maniacDougSeenText:
	text "Why don't girls"
	line "like bug #mon?"
	done

Bug_maniacDougBeatenText:
	text "No good!"
	done

Route2SignText:
	text "Route 2"

	para "Viridian City -"
	line "Pewter City"
	done
