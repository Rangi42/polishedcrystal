WhirlIslandB2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

WhirlIslandB2F_MapEventHeader:

.Warps: db 4
	warp_def 5, 11, 7, WHIRL_ISLAND_B1F
	warp_def 11, 7, 8, WHIRL_ISLAND_B1F
	warp_def 25, 7, 1, WHIRL_ISLAND_LUGIA_CHAMBER
	warp_def 31, 13, 5, WHIRL_ISLAND_SW

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	itemball_event 11, 10, FULL_RESTORE, 1, EVENT_WHIRL_ISLAND_B2F_FULL_RESTORE
	itemball_event 4, 6, MAX_REVIVE, 1, EVENT_WHIRL_ISLAND_B2F_MAX_REVIVE
	itemball_event 12, 5, MAX_ELIXER, 1, EVENT_WHIRL_ISLAND_B2F_MAX_ELIXER

