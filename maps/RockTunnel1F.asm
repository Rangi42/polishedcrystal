const_value set 2
	const ROCKTUNNEL1F_HIKER
	const ROCKTUNNEL1F_POKE_BALL1
	const ROCKTUNNEL1F_POKE_BALL2

RockTunnel1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerHikerSeamus:
	trainer EVENT_BEAT_HIKER_SEAMUS, HIKER, SEAMUS, HikerSeamusSeenText, HikerSeamusBeatenText, 0, HikerSeamusScript

HikerSeamusScript:
	end_if_just_battled
	opentext
	writetext HikerSeamusAfterText
	waitbutton
	closetext
	end

RockTunnel1FElixer:
	itemball ELIXER

RockTunnel1FHPUp:
	itemball HP_UP

RockTunnel1FHiddenXAccuracy:
	dwb EVENT_ROCK_TUNNEL_1F_HIDDEN_X_ACCURACY, X_ACCURACY

RockTunnel1FHiddenXDefend:
	dwb EVENT_ROCK_TUNNEL_1F_HIDDEN_X_DEFEND, X_DEFEND

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

RockTunnel1F_MapEventHeader:
.Warps:
	db 8
	warp_def $3, $f, 4, ROUTE_10_NORTH
	warp_def $19, $b, 1, ROUTE_10_SOUTH
	warp_def $3, $5, 1, ROCK_TUNNEL_B1F
	warp_def $9, $f, 2, ROCK_TUNNEL_B1F
	warp_def $3, $19, 3, ROCK_TUNNEL_B1F
	warp_def $d, $1b, 4, ROCK_TUNNEL_B1F
	warp_def $d, $4, 5, ROCK_TUNNEL_B1F
	warp_def $f, $6, 2, ROCK_TUNNEL_2F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 4, 23, SIGNPOST_ITEM, RockTunnel1FHiddenXAccuracy
	signpost 18, 4, SIGNPOST_ITEM, RockTunnel1FHiddenXDefend

.PersonEvents:
	db 3
	person_event SPRITE_POKEFAN_M, 18, 23, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerHikerSeamus, -1
	person_event SPRITE_BALL_CUT_FRUIT, 15, 21, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RockTunnel1FElixer, EVENT_ROCK_TUNNEL_1F_ELIXER
	person_event SPRITE_BALL_CUT_FRUIT, 15, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RockTunnel1FHPUp, EVENT_ROCK_TUNNEL_1F_HP_UP
