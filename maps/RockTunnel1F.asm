RockTunnel1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 8 ; warp events
	warp_event 15, 3, 4, ROUTE_10_NORTH
	warp_event 11, 25, 1, ROUTE_10_SOUTH
	warp_event 5, 3, 1, ROCK_TUNNEL_B1F
	warp_event 15, 9, 2, ROCK_TUNNEL_B1F
	warp_event 25, 3, 3, ROCK_TUNNEL_B1F
	warp_event 27, 13, 4, ROCK_TUNNEL_B1F
	warp_event 4, 13, 5, ROCK_TUNNEL_B1F
	warp_event 6, 15, 2, ROCK_TUNNEL_2F

	db 0 ; coord events

	db 2 ; bg events
	bg_event 23, 4, SIGNPOST_ITEM + X_ACCURACY, EVENT_ROCK_TUNNEL_1F_HIDDEN_X_ACCURACY
	bg_event 4, 18, SIGNPOST_ITEM + X_DEFEND, EVENT_ROCK_TUNNEL_1F_HIDDEN_X_DEFEND

	db 3 ; object events
	object_event 23, 18, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerHikerSeamus, -1
	itemball_event 21, 15, ELIXER, 1, EVENT_ROCK_TUNNEL_1F_ELIXER
	itemball_event 10, 15, HP_UP, 1, EVENT_ROCK_TUNNEL_1F_HP_UP

TrainerHikerSeamus:
	trainer HIKER, SEAMUS, EVENT_BEAT_HIKER_SEAMUS, HikerSeamusSeenText, HikerSeamusBeatenText, 0, HikerSeamusScript

HikerSeamusScript:
	end_if_just_battled
	jumptextfaceplayer HikerSeamusAfterText

HikerSeamusSeenText:
	text "Almost…"
	line "there…"
	done

HikerSeamusBeatenText:
	text "Where do you get"
	line "your energy?"
	done

HikerSeamusAfterText:
	text "Was Rock Tunnel"
	line "always this much"
	cont "of a trek?"
	done
