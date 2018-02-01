TinTower9F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 7 ; warp events
	warp_event 10, 3, 2, TIN_TOWER_8F
	warp_event 0, 5, 3, TIN_TOWER_8F
	warp_event 10, 7, 4, TIN_TOWER_8F
	warp_event 5, 9, 1, TIN_TOWER_10F
	warp_event 14, 7, 5, TIN_TOWER_7F
	warp_event 4, 13, 5, TIN_TOWER_8F
	warp_event 6, 13, 6, TIN_TOWER_8F

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	itemball_event 7, 1, HP_UP, 1, EVENT_TIN_TOWER_9F_HP_UP

