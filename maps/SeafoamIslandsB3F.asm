SeafoamIslandsB3F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 10 ; warp events
	warp_event 37, 7, 5, SEAFOAM_ISLANDS_B2F
	warp_event 25, 9, 6, SEAFOAM_ISLANDS_B2F
	warp_event 35, 13, 7, SEAFOAM_ISLANDS_B2F
	warp_event 3, 13, 8, SEAFOAM_ISLANDS_B2F
	warp_event 3, 3, 1, SEAFOAM_ISLANDS_B4F
	warp_event 7, 13, 2, SEAFOAM_ISLANDS_B4F
	warp_event 21, 9, 3, SEAFOAM_ISLANDS_B4F
	warp_event 29, 3, 4, SEAFOAM_ISLANDS_B4F
	warp_event 31, 15, 5, SEAFOAM_ISLANDS_B4F
	warp_event 37, 15, 6, SEAFOAM_ISLANDS_B4F

	db 0 ; coord events

	db 2 ; bg events
	bg_event 27, 17, SIGNPOST_ITEM + MAX_REVIVE, EVENT_SEAFOAM_ISLANDS_B3F_HIDDEN_MAX_REVIVE
	bg_event 7, 5, SIGNPOST_ITEM + RARE_CANDY, EVENT_SEAFOAM_ISLANDS_B3F_HIDDEN_RARE_CANDY

	db 3 ; object events
	itemball_event 15, 15, REVIVE, 1, EVENT_SEAFOAM_ISLANDS_B3F_REVIVE
	itemball_event 17, 6, BIG_PEARL, 1, EVENT_SEAFOAM_ISLANDS_B3F_BIG_PEARL
	strengthboulder_event 28, 7
