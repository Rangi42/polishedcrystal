Route16Northeast_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 14, 10, 3, ROUTE_16_17_GATE
	warp_event 14, 11, 4, ROUTE_16_17_GATE
	warp_event 14, 4, 3, ROUTE_16_GATE
	warp_event 14, 5, 4, ROUTE_16_GATE

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	cuttree_event 17, 4, EVENT_ROUTE_16_CUT_TREE
