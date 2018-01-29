Route16Northwest_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Route16Northwest_MapEventHeader:
	db 3 ; warps
	warp_def 1, 1, 1, ROUTE_16_FUCHSIA_SPEECH_HOUSE
	warp_def 4, 9, 1, ROUTE_16_GATE
	warp_def 5, 9, 2, ROUTE_16_GATE

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	cuttree_event 4, 17, EVENT_ROUTE_16_CUT_TREE
