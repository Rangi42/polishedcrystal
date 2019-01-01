TinTower6F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  1,  9, TIN_TOWER_7F, 1
	warp_event  9, 15, TIN_TOWER_5F, 1

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	itemball_event  6,  8, MAX_POTION, 1, EVENT_TIN_TOWER_6F_MAX_POTION

