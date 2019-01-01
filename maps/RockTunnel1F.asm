RockTunnel1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 8 ; warp events
	warp_event 15,  3, ROUTE_10_NORTH, 4
	warp_event 11, 25, ROUTE_10_SOUTH, 1
	warp_event  5,  3, ROCK_TUNNEL_B1F, 1
	warp_event 15,  9, ROCK_TUNNEL_B1F, 2
	warp_event 25,  3, ROCK_TUNNEL_B1F, 3
	warp_event 27, 13, ROCK_TUNNEL_B1F, 4
	warp_event  4, 13, ROCK_TUNNEL_B1F, 5
	warp_event  6, 15, ROCK_TUNNEL_2F, 2

	db 0 ; coord events

	db 2 ; bg events
	bg_event 23,  4, SIGNPOST_ITEM + X_ACCURACY, EVENT_ROCK_TUNNEL_1F_HIDDEN_X_ACCURACY
	bg_event  4, 18, SIGNPOST_ITEM + X_DEFEND, EVENT_ROCK_TUNNEL_1F_HIDDEN_X_DEFEND

	db 3 ; object events
	object_event 23, 18, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerHikerSeamus, -1
	itemball_event 21, 15, ELIXER, 1, EVENT_ROCK_TUNNEL_1F_ELIXER
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

