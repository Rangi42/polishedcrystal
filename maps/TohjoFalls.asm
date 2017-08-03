TohjoFalls_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TohjoFalls_MapEventHeader:

.Warps: db 3
	warp_def $f, $d, 2, ROUTE_27
	warp_def $f, $19, 3, ROUTE_27
	warp_def $7, $3, 1, GIOVANNIS_CAVE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_BALL_CUT_FRUIT, 8, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, TohjoFallsMoonStone, EVENT_TOHJO_FALLS_MOON_STONE

TohjoFallsMoonStone:
	itemball MOON_STONE
