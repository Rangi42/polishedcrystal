Route18East_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  6, ROUTE_18_GATE, 3
	warp_event  4,  7, ROUTE_18_GATE, 4

	def_coord_events

	def_bg_events
	bg_event 11,  5, BGEVENT_JUMPTEXT, Route18SignText

	def_object_events
	object_event 11, 12, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperBoris, -1
	object_event 15,  6, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperBob, -1

GenericTrainerBird_keeperBoris:
	generictrainer BIRD_KEEPER, BORIS, EVENT_BEAT_BIRD_KEEPER_BORIS, Bird_keeperBorisSeenText, Bird_keeperBorisBeatenText

	text "Since you're so"
	line "strong, it must be"
	cont "fun to battle."
	done

GenericTrainerBird_keeperBob:
	generictrainer BIRD_KEEPER, BOB, EVENT_BEAT_BIRD_KEEPER_BOB, Bird_keeperBobSeenText, Bird_keeperBobBeatenText

	text "If you don't have"
	line "a Bicycle, you're"

	para "not allowed to use"
	line "the shortcut."
	done

Bird_keeperBorisSeenText:
	text "If you're looking"
	line "for #mon, you"

	para "have to look in"
	line "the tall grass."
	done

Bird_keeperBorisBeatenText:
	text "Ayieee!"
	done

Bird_keeperBobSeenText:
	text "Cycling Road is a"
	line "quick shortcut to"
	cont "Celadon."
	done

Bird_keeperBobBeatenText:
	text "…Whew!"
	done

Route18SignText:
	text "Route 18"

	para "Celadon City -"
	line "Fuchsia City"
	done
