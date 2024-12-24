RocketHideoutB2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 27,  2, ROCKET_HIDEOUT_B1F, 1
	warp_event 21,  2, ROCKET_HIDEOUT_B3F, 1
	warp_event 24, 13, ROCKET_HIDEOUT_ELEVATOR, 1
	warp_event 21, 16, ROCKET_HIDEOUT_B1F, 4
	warp_event 25, 13, ROCKET_HIDEOUT_ELEVATOR, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 20,  6, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, RocketHideoutB2FHexManiacCorinne, -1
	itemball_event 16,  2, RARE_CANDY, 1, EVENT_PICKED_UP_RARE_CANDY_1_FROM_ROCKET_HIDEOUT_B2F ; TODO: pick a better item
	itemball_event  1,  5, RARE_CANDY, 1, EVENT_PICKED_UP_RARE_CANDY_2_FROM_ROCKET_HIDEOUT_B2F ; TODO: pick a better item
	itemball_event  6,  6, RARE_CANDY, 1, EVENT_PICKED_UP_RARE_CANDY_3_FROM_ROCKET_HIDEOUT_B2F ; TODO: pick a better item
	itemball_event  3, 15, RARE_CANDY, 1, EVENT_PICKED_UP_RARE_CANDY_4_FROM_ROCKET_HIDEOUT_B2F ; TODO: pick a better item

RocketHideoutB2FHexManiacCorinne:
	generictrainer HEX_MANIAC, CORINNE, EVENT_BEAT_HEX_MANIAC_CORINNE, .SeenText, .BeatenText

	text "Blanche might see"
	line "potential in you."

	para "But they'll test"
	line "your limits for"
	cont "sure."
	done

.SeenText:
	text "Mystic sees beyond"
	line "the obvious-logic"
	cont "wins every time."

	para "Can you outsmart"
	line "me? Prove it."
	done

.BeatenText:
	text "Impressive. You've"
	line "got a mind Mystic"
	cont "values."
	done
