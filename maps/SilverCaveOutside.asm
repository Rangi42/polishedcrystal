SilverCaveOutside_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, SilverCaveOutsideFlyPoint

SilverCaveOutside_MapEventHeader:

.Warps: db 2
	warp_def 13, 23, 1, SILVER_CAVE_POKECENTER_1F
	warp_def 5, 18, 1, SILVER_CAVE_ROOM_1

.XYTriggers: db 0

.Signposts: db 2
	signpost 7, 17, SIGNPOST_JUMPTEXT, MtSilverSignText
	signpost 19, 9, SIGNPOST_ITEM + FULL_RESTORE, EVENT_SILVER_CAVE_OUTSIDE_HIDDEN_FULL_RESTORE

.PersonEvents: db 2
	cuttree_event 18, 31, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_1
	cuttree_event 17, 34, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_2

SilverCaveOutsideFlyPoint:
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	return

MtSilverSignText:
	text "Mt.Silver"
	done
