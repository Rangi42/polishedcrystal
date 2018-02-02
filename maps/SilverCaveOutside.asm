SilverCaveOutside_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, SilverCaveOutsideFlyPoint

	db 2 ; warp events
	warp_event 23, 13, SILVER_CAVE_POKECENTER_1F, 1
	warp_event 18,  5, SILVER_CAVE_ROOM_1, 1

	db 0 ; coord events

	db 2 ; bg events
	bg_event 17,  7, SIGNPOST_JUMPTEXT, MtSilverSignText
	bg_event  9, 19, SIGNPOST_ITEM + FULL_RESTORE, EVENT_SILVER_CAVE_OUTSIDE_HIDDEN_FULL_RESTORE

	db 2 ; object events
	cuttree_event 31, 18, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_1
	cuttree_event 34, 17, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_2

SilverCaveOutsideFlyPoint:
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	return

MtSilverSignText:
	text "Mt.Silver"
	done
