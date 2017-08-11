SilverCaveOutside_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, SilverCaveOutsideFlyPoint

SilverCaveOutside_MapEventHeader:

.Warps: db 2
	warp_def $d, $17, 1, SILVER_CAVE_POKECENTER_1F
	warp_def $5, $12, 1, SILVER_CAVE_ROOM_1

.XYTriggers: db 0

.Signposts: db 2
	signpost 7, 17, SIGNPOST_JUMPTEXT, MtSilverSignText
	signpost 19, 9, SIGNPOST_ITEM, SilverCaveOutsideHiddenFullRestore

.PersonEvents: db 2
	person_event SPRITE_BALL_CUT_FRUIT, 18, 31, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, cuttree, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_1
	person_event SPRITE_BALL_CUT_FRUIT, 17, 34, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, cuttree, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_2

SilverCaveOutsideFlyPoint:
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	return

SilverCaveOutsideHiddenFullRestore:
	dwb EVENT_SILVER_CAVE_OUTSIDE_HIDDEN_FULL_RESTORE, FULL_RESTORE

MtSilverSignText:
	text "Mt.Silver"
	done
