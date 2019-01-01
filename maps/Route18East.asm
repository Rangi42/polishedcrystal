Route18East_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  4,  6, ROUTE_18_GATE, 3
	warp_event  4,  7, ROUTE_18_GATE, 4

	db 0 ; coord events

	db 1 ; bg events
	bg_event 11,  5, SIGNPOST_JUMPTEXT, Route18SignText

	db 2 ; object events
	object_event 11, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperBoris, -1
	object_event 15,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperBob, -1

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
