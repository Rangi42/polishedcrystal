TohjoFalls_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

TohjoFalls_MapEventHeader:

.Warps: db 3
	warp_def 15, 13, 2, ROUTE_27
	warp_def 15, 25, 3, ROUTE_27
	warp_def 7, 3, 1, GIOVANNIS_CAVE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	itemball_event 8, 2, MOON_STONE, 1, EVENT_TOHJO_FALLS_MOON_STONE

