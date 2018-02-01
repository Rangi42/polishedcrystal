TinTower6F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 1, 9, 1, TIN_TOWER_7F
	warp_event 9, 15, 1, TIN_TOWER_5F

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	itemball_event 6, 8, MAX_POTION, 1, EVENT_TIN_TOWER_6F_MAX_POTION

