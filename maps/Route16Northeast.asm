Route16Northeast_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Route16Northeast_MapEventHeader:
	db 4 ; warps
	warp_def 10, 14, 3, ROUTE_16_17_GATE
	warp_def 11, 14, 4, ROUTE_16_17_GATE
	warp_def 4, 14, 3, ROUTE_16_GATE
	warp_def 5, 14, 4, ROUTE_16_GATE

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	cuttree_event 4, 17, EVENT_ROUTE_16_CUT_TREE
