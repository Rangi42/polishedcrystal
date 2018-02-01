TohjoFalls_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 13, 15, 2, ROUTE_27
	warp_event 25, 15, 3, ROUTE_27
	warp_event 3, 7, 1, GIOVANNIS_CAVE

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	itemball_event 2, 8, MOON_STONE, 1, EVENT_TOHJO_FALLS_MOON_STONE

