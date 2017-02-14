const_value set 2
	const ROUTE16NORTH_CUT_TREE

Route16North_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route16CutTree:
	jumpstd cuttree

Route16North_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $1, $5, 1, ROUTE_16_FUCHSIA_SPEECH_HOUSE
	warp_def $a, $e, 3, ROUTE_16_GATE
	warp_def $b, $e, 4, ROUTE_16_GATE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_CUT_TREE, 2, 17, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route16CutTree, EVENT_ROUTE_16_CUT_TREE
