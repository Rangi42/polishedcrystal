TinTower8F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 6 ; warp events
	warp_event  0,  5, TIN_TOWER_7F, 2
	warp_event  0, 11, TIN_TOWER_9F, 1
	warp_event 14,  7, TIN_TOWER_9F, 2
	warp_event  8,  3, TIN_TOWER_9F, 3
	warp_event 12, 15, TIN_TOWER_9F, 6
	warp_event  4,  9, TIN_TOWER_9F, 7

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	itemball_event  5, 13, BIG_NUGGET, 1, EVENT_TIN_TOWER_8F_BIG_NUGGET
	itemball_event  9,  6, MAX_ELIXER, 1, EVENT_TIN_TOWER_8F_MAX_ELIXER
	itemball_event  1,  1, FULL_RESTORE, 1, EVENT_TIN_TOWER_8F_FULL_RESTORE

