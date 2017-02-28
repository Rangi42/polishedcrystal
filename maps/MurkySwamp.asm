const_value set 2
	const MURKYSWAMP_CUT_TREE1
	const MURKYSWAMP_CUT_TREE2

MurkySwamp_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

MurkySwampCutTree:
	jumpstd cuttree

MurkySwamp_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $21, $7, 1, STORMY_BEACH
	warp_def $21, $8, 2, STORMY_BEACH

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_CUT_TREE, 12, 2, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MurkySwampCutTree, EVENT_MURKY_SWAMP_CUT_TREE_1
	person_event SPRITE_CUT_TREE, 17, 6, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MurkySwampCutTree, EVENT_MURKY_SWAMP_CUT_TREE_2
