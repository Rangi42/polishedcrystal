SeafoamIslandsB1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 6 ; warp events
	warp_event 35, 15, 3, SEAFOAM_ISLANDS_1F
	warp_event 3, 3, 5, SEAFOAM_ISLANDS_1F
	warp_event 27, 15, 1, SEAFOAM_ISLANDS_B2F
	warp_event 18, 5, 2, SEAFOAM_ISLANDS_B2F
	warp_event 15, 11, 3, SEAFOAM_ISLANDS_B2F
	warp_event 7, 15, 4, SEAFOAM_ISLANDS_B2F

	db 0 ; coord events

	db 1 ; bg events
	bg_event 20, 11, SIGNPOST_ITEM + ICE_HEAL, EVENT_SEAFOAM_ISLANDS_B1F_HIDDEN_ICE_HEAL

	db 8 ; object events
	itemball_event 20, 3, GRIP_CLAW, 1, EVENT_SEAFOAM_ISLANDS_B1F_GRIP_CLAW
	itemball_event 24, 5, ICE_HEAL, 1, EVENT_SEAFOAM_ISLANDS_B1F_ICE_HEAL
	strengthboulder_event 30, 9
	strengthboulder_event 31, 9
	strengthboulder_event 32, 10
	strengthboulder_event 12, 8
	strengthboulder_event 7, 11
	strengthboulder_event 13, 15
