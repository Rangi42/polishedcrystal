TohjoFalls_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

TohjoFalls_MapEventHeader:
	db 3 ; warps
	warp_def 15, 13, 2, ROUTE_27
	warp_def 15, 25, 3, ROUTE_27
	warp_def 7, 3, 1, GIOVANNIS_CAVE

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	itemball_event 8, 2, MOON_STONE, 1, EVENT_TOHJO_FALLS_MOON_STONE

