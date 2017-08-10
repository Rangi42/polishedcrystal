Route16Northeast_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route16Northeast_MapEventHeader:

.Warps: db 4
	warp_def $a, $e, 3, ROUTE_16_17_GATE
	warp_def $b, $e, 4, ROUTE_16_17_GATE
	warp_def $4, $e, 3, ROUTE_16_GATE
	warp_def $5, $e, 4, ROUTE_16_GATE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_BALL_CUT_FRUIT, 4, 17, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, cuttree, EVENT_ROUTE_16_CUT_TREE
