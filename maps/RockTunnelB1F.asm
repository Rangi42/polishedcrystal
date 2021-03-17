RockTunnelB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  3, ROCK_TUNNEL_1F, 3
	warp_event 17,  9, ROCK_TUNNEL_1F, 4
	warp_event 23,  3, ROCK_TUNNEL_1F, 5
	warp_event 27, 19, ROCK_TUNNEL_1F, 6
	warp_event  3, 13, ROCK_TUNNEL_1F, 7

	def_coord_events

	def_bg_events
	bg_event  3, 18, BGEVENT_ITEM + MAX_POTION, EVENT_ROCK_TUNNEL_B1F_HIDDEN_MAX_POTION

	def_object_events
	object_event 27, 14, SPRITE_FIREBREATHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerFirebreatherDick, -1
	object_event 24, 24, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerHexManiacVivian, -1
	itemball_event  7, 17, IRON, 1, EVENT_ROCK_TUNNEL_B1F_IRON
	itemball_event  8,  4, PP_UP, 1, EVENT_ROCK_TUNNEL_B1F_PP_UP
	itemball_event 15,  2, REVIVE, 1, EVENT_ROCK_TUNNEL_B1F_REVIVE
	strengthboulder_event 10, 25

GenericTrainerFirebreatherDick:
	generictrainer FIREBREATHER, DICK, EVENT_BEAT_FIREBREATHER_DICK, FirebreatherDickSeenText, FirebreatherDickBeatenText

	text "A #mon that"
	line "knows Flash is"

	para "helpful in dark"
	line "caves like this."
	done

GenericTrainerHexManiacVivian:
	generictrainer HEX_MANIAC, VIVIAN, EVENT_BEAT_HEX_MANIAC_VIVIAN, HexManiacVivianSeenText, HexManiacVivianBeatenText

	text "This spooky hex"
	line "maniac persona"

	para "actually takes"
	line "effort."
	done

FirebreatherDickSeenText:
	text "I'm using fire to"
	line "to see my way out!"
	done

FirebreatherDickBeatenText:
	text "Help! The fire"
	line "went out!"
	done

HexManiacVivianSeenText:
	text "Do you hear the"
	line "voices calling?"
	done

HexManiacVivianBeatenText:
	text "It was only an"
	line "echo?!"
	done

