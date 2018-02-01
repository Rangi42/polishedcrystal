TinTower10F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 5, 9, 4, TIN_TOWER_9F
	warp_event 7, 15, 1, TIN_TOWER_ROOF

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events
