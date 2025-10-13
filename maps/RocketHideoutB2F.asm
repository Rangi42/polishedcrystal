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
	object_event 20,  6, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, RocketHideoutB2FHexManiacCoryn, -1
	itemball_event 16,  2, ULTRA_BALL,  1, EVENT_ROCKET_HIDEOUT_B2F_ULTRA_BALL
	itemball_event  1,  5, SUPER_REPEL, 1, EVENT_ROCKET_HIDEOUT_B2F_SUPER_REPEL
	itemball_event  6,  6, NUGGET,      1, EVENT_ROCKET_HIDEOUT_B2F_NUGGET
	itemball_event  3, 15, RARE_CANDY,  1, EVENT_ROCKET_HIDEOUT_B2F_RARE_CANDY

RocketHideoutB2FHexManiacCoryn:
	generictrainer HEX_MANIAC, CORYN, EVENT_BEAT_HEX_MANIAC_CORYN, .SeenText, .BeatenText

	text "Team Mystic could"
	line "use more talents"
	cont "like yours."
	done

.SeenText:
	text "You might have"
	line "potential for"
	cont "Team Mystic."

	para "Let me test your"
	line "limits."
	done

.BeatenText:
	text "Squared away…"
	done
