TinTower5F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  9, 15, TIN_TOWER_6F, 2
	warp_event  0,  4, TIN_TOWER_4F, 1
	warp_event  0, 14, TIN_TOWER_4F, 3
	warp_event 15, 15, TIN_TOWER_4F, 4

	db 0 ; coord events

	db 2 ; bg events
	bg_event 14, 14, SIGNPOST_ITEM + FULL_RESTORE, EVENT_TIN_TOWER_5F_HIDDEN_FULL_RESTORE
	bg_event  1, 15, SIGNPOST_ITEM + CARBOS, EVENT_TIN_TOWER_5F_HIDDEN_CARBOS

	db 1 ; object events
	itemball_event  7,  9, RARE_CANDY, 1, EVENT_TIN_TOWER_5F_RARE_CANDY
