Route16Northeast_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 14, 10, ROUTE_16_17_GATE, 3
	warp_event 14, 11, ROUTE_16_17_GATE, 4
	warp_event 14,  4, ROUTE_16_GATE, 3
	warp_event 14,  5, ROUTE_16_GATE, 4

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	cuttree_event 17,  4, EVENT_ROUTE_16_CUT_TREE
