const_value set 2
	const ROCKTUNNEL2F_POKE_BALL1
	const ROCKTUNNEL2F_POKE_BALL2
	const ROCKTUNNEL2F_ROCK
	const ROCKTUNNEL2F_BOULDER1
	const ROCKTUNNEL2F_BOULDER2
	const ROCKTUNNEL2F_BOULDER3

RockTunnel2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

RockTunnel2FThunderStone:
	itemball THUNDERSTONE

RockTunnel2FTMThunderWave:
	itemball TM_THUNDER_WAVE

RockTunnel2FHiddenMaxEther:
	dwb EVENT_ROCK_TUNNEL_2F_HIDDEN_MAX_ETHER, MAX_ETHER

RockTunnel2FRock:
	jumpstd smashrock

RockTunnel2FBoulder:
	jumpstd strengthboulder

RockTunnel2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $13, $19, 3, ROUTE_10_NORTH
	warp_def $f, $7, 8, ROCK_TUNNEL_1F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 18, 16, SIGNPOST_ITEM, RockTunnel2FHiddenMaxEther

.PersonEvents:
	db 6
	person_event SPRITE_POKE_BALL, 23, 2, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, RockTunnel2FThunderStone, EVENT_ROCK_TUNNEL_2F_THUNDERSTONE
	person_event SPRITE_POKE_BALL, 9, 25, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, RockTunnel2FTMThunderWave, EVENT_ROCK_TUNNEL_2F_TM_THUNDER_WAVE
	person_event SPRITE_ROCK, 12, 9, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, RockTunnel2FRock, -1
	person_event SPRITE_BOULDER, 2, 12, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, RockTunnel2FBoulder, -1
	person_event SPRITE_BOULDER, 3, 12, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, RockTunnel2FBoulder, -1
	person_event SPRITE_BOULDER, 3, 13, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, RockTunnel2FBoulder, -1
