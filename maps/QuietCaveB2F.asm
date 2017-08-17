QuietCaveB2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

QuietCaveB2F_MapEventHeader:

.Warps: db 6
	warp_def 3, 21, 6, QUIET_CAVE_B1F
	warp_def 25, 17, 7, QUIET_CAVE_B1F
	warp_def 33, 23, 8, QUIET_CAVE_B1F
	warp_def 3, 29, 9, QUIET_CAVE_B1F
	warp_def 31, 10, 1, QUIET_CAVE_B3F
	warp_def 5, 33, 2, QUIET_CAVE_B3F

.XYTriggers: db 0

.Signposts: db 1
	signpost 11, 16, SIGNPOST_ITEM + CALCIUM, EVENT_QUIET_CAVE_B2F_HIDDEN_CALCIUM

.PersonEvents: db 3
	itemball_event 3, 10, DUSK_BALL, 1, EVENT_QUIET_CAVE_B2F_DUSK_BALL
	itemball_event 23, 9, RAZOR_CLAW, 1, EVENT_QUIET_CAVE_B2F_RAZOR_CLAW
	itemball_event 11, 19, SAFE_GOGGLES, 1, EVENT_QUIET_CAVE_B2F_SAFE_GOGGLES
