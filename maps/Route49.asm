const_value set 2

Route49_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route49FruitTree:
	fruittree FRUITTREE_ROUTE_49

Route49CutTree:
	jumpstd cuttree

Route49Sign:
	jumptext .Text

.Text:
	text "Route 49"
	line "Valencia Island"
	done

Route49_MapEventHeader:
.Warps:
	db 1
	warp_def $5, $7, 1, VALENCIA_PORT

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 11, 31, SIGNPOST_READ, Route49Sign

.PersonEvents:
	db 3
	person_event SPRITE_BALL_CUT_FRUIT, 14, 29, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route49FruitTree, -1
	person_event SPRITE_BALL_CUT_FRUIT, 12, 26, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route49CutTree, EVENT_ROUTE_49_CUT_TREE_1
	person_event SPRITE_BALL_CUT_FRUIT, 15, 20, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route49CutTree, EVENT_ROUTE_49_CUT_TREE_2
