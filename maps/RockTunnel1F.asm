RockTunnel1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

RockTunnel1F_MapEventHeader:

.Warps: db 8
	warp_def 3, 15, 4, ROUTE_10_NORTH
	warp_def 25, 11, 1, ROUTE_10_SOUTH
	warp_def 3, 5, 1, ROCK_TUNNEL_B1F
	warp_def 9, 15, 2, ROCK_TUNNEL_B1F
	warp_def 3, 25, 3, ROCK_TUNNEL_B1F
	warp_def 13, 27, 4, ROCK_TUNNEL_B1F
	warp_def 13, 4, 5, ROCK_TUNNEL_B1F
	warp_def 15, 6, 2, ROCK_TUNNEL_2F

.XYTriggers: db 0

.Signposts: db 2
	signpost 4, 23, SIGNPOST_ITEM + X_ACCURACY, EVENT_ROCK_TUNNEL_1F_HIDDEN_X_ACCURACY
	signpost 18, 4, SIGNPOST_ITEM + X_DEFEND, EVENT_ROCK_TUNNEL_1F_HIDDEN_X_DEFEND

.PersonEvents: db 3
	person_event SPRITE_POKEFAN_M, 18, 23, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerHikerSeamus, -1
	itemball_event 15, 21, ELIXER, 1, EVENT_ROCK_TUNNEL_1F_ELIXER
	itemball_event 15, 10, HP_UP, 1, EVENT_ROCK_TUNNEL_1F_HP_UP

TrainerHikerSeamus:
	trainer EVENT_BEAT_HIKER_SEAMUS, HIKER, SEAMUS, HikerSeamusSeenText, HikerSeamusBeatenText, 0, HikerSeamusScript

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
