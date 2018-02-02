Underground_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  3,  2, ROUTE_5_UNDERGROUND_ENTRANCE, 3
	warp_event  3, 32, ROUTE_6_UNDERGROUND_ENTRANCE, 3

	db 0 ; coord events

	db 2 ; bg events
	bg_event  3,  9, SIGNPOST_ITEM + FULL_RESTORE, EVENT_UNDERGROUND_HIDDEN_FULL_RESTORE
	bg_event  1, 21, SIGNPOST_ITEM + X_SPCL_ATK, EVENT_UNDERGROUND_HIDDEN_X_SPCL_ATK

	db 1 ; object events
	tmhmball_event  4, 15, TM_EXPLOSION, EVENT_UNDERGROUND_TM_EXPLOSION
