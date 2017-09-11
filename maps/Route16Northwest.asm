Route16Northwest_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route16Northwest_MapEventHeader:

.Warps: db 3
	warp_def 1, 1, 1, ROUTE_16_FUCHSIA_SPEECH_HOUSE
	warp_def 4, 9, 1, ROUTE_16_GATE
	warp_def 5, 9, 2, ROUTE_16_GATE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	cuttree_event 4, 17, EVENT_ROUTE_16_CUT_TREE
