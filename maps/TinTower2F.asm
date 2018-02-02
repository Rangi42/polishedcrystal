TinTower2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  8, 14, TIN_TOWER_3F, 1
	warp_event  8,  2, TIN_TOWER_1F, 3

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
