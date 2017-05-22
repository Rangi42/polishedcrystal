const_value set 2
	const ICEISLAND_POKE_BALL

IceIsland_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

IceIslandIcyRock:
	itemball ICY_ROCK

IceIsland_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $1d, $6, 2, SHAMOUTI_COAST
	warp_def $1d, $14, 1, ICE_ISLAND_ROOF
	warp_def $5, $7, 4, ICE_ISLAND
	warp_def $5, $15, 3, ICE_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_BALL_CUT_FRUIT, 6, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, IceIslandIcyRock, EVENT_ICE_ISLAND_ICY_ROCK
