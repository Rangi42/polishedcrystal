RockTunnel1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 15,  3, ROUTE_10_NORTH, 4
	warp_event 11, 25, ROUTE_10_SOUTH, 1
	warp_event  5,  3, ROCK_TUNNEL_B1F, 1
	warp_event 15,  9, ROCK_TUNNEL_B1F, 2
	warp_event 25,  3, ROCK_TUNNEL_B1F, 3
	warp_event 27, 13, ROCK_TUNNEL_B1F, 4
	warp_event  4, 13, ROCK_TUNNEL_B1F, 5
	warp_event  6, 15, ROCK_TUNNEL_2F, 2

	def_coord_events

	def_bg_events
	bg_event 23,  4, BGEVENT_ITEM + X_ACCURACY, EVENT_ROCK_TUNNEL_1F_HIDDEN_X_ACCURACY
	bg_event  4, 18, BGEVENT_ITEM + X_DEFEND, EVENT_ROCK_TUNNEL_1F_HIDDEN_X_DEFEND

	def_object_events
	object_event 23, 18, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHikerSeamus, -1
	itemball_event 21, 15, ELIXIR, 1, EVENT_ROCK_TUNNEL_1F_ELIXIR
	itemball_event 10, 15, HP_UP, 1, EVENT_ROCK_TUNNEL_1F_HP_UP

GenericTrainerHikerSeamus:
	generictrainer HIKER, SEAMUS, EVENT_BEAT_HIKER_SEAMUS, HikerSeamusSeenText, HikerSeamusBeatenText

	text "Was Rock Tunnel"
	line "always this much"
	cont "of a trek?"
	done

HikerSeamusSeenText:
	text "Almost…"
	line "there…"
	done

HikerSeamusBeatenText:
	text "Where do you get"
	line "your energy?"
	done

