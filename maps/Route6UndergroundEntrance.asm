Route6UndergroundEntrance_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  3,  7, ROUTE_6, 1
	warp_event  4,  7, ROUTE_6, 1
	warp_event  4,  4, UNDERGROUND, 2

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
