TinTower3F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  8, 14, TIN_TOWER_2F, 1
	warp_event 14,  2, TIN_TOWER_4F, 2

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	itemball_event  1, 14, FULL_HEAL, 1, EVENT_TIN_TOWER_3F_FULL_HEAL

