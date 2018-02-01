SilverCaveOutside_MapScriptHeader:
	db 0 ; map triggers

	db 1 ; map callbacks
	dbw MAPCALLBACK_NEWMAP, SilverCaveOutsideFlyPoint

	db 2 ; warps
	warp_def 13, 23, 1, SILVER_CAVE_POKECENTER_1F
	warp_def 5, 18, 1, SILVER_CAVE_ROOM_1

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 7, 17, SIGNPOST_JUMPTEXT, MtSilverSignText
	signpost 19, 9, SIGNPOST_ITEM + FULL_RESTORE, EVENT_SILVER_CAVE_OUTSIDE_HIDDEN_FULL_RESTORE

	db 2 ; person events
	cuttree_event 18, 31, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_1
	cuttree_event 17, 34, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_2

SilverCaveOutsideFlyPoint:
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	return

MtSilverSignText:
	text "Mt.Silver"
	done
