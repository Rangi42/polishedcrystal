const_value set 2
	const SILVERCAVEOUTSIDE_CUT_TREE1
	const SILVERCAVEOUTSIDE_CUT_TREE2

SilverCaveOutside_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks
	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	return

SilverCaveOutsideCutTree:
	jumpstd cuttree

MtSilverPokeCenterSign:
	jumpstd pokecentersign

MtSilverSign:
	jumptext MtSilverSignText

SilverCaveOutsideHiddenFullRestore:
	dwb EVENT_SILVER_CAVE_OUTSIDE_HIDDEN_FULL_RESTORE, FULL_RESTORE

MtSilverSignText:
	text "Mt.Silver"
	done

SilverCaveOutside_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $13, $17, 1, SILVER_CAVE_POKECENTER_1F
	warp_def $b, $12, 1, SILVER_CAVE_ROOM_1

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 19, 24, SIGNPOST_READ, MtSilverPokeCenterSign
	signpost 13, 17, SIGNPOST_READ, MtSilverSign
	signpost 25, 9, SIGNPOST_ITEM, SilverCaveOutsideHiddenFullRestore

.PersonEvents:
	db 2
	person_event SPRITE_CUT_TREE, 24, 31, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SilverCaveOutsideCutTree, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_1
	person_event SPRITE_CUT_TREE, 23, 34, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SilverCaveOutsideCutTree, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_2
