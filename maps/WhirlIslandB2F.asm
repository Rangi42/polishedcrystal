WhirlIslandB2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 11,  5, WHIRL_ISLAND_B1F, 7
	warp_event  7, 11, WHIRL_ISLAND_B1F, 8
	warp_event  7, 25, WHIRL_ISLAND_LUGIA_CHAMBER, 1
	warp_event 13, 31, WHIRL_ISLAND_SW, 5

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	itemball_event 10, 11, FULL_RESTORE, 1, EVENT_WHIRL_ISLAND_B2F_FULL_RESTORE
	itemball_event  6,  4, MAX_REVIVE, 1, EVENT_WHIRL_ISLAND_B2F_MAX_REVIVE
	itemball_event  5, 12, MAX_ELIXER, 1, EVENT_WHIRL_ISLAND_B2F_MAX_ELIXER

