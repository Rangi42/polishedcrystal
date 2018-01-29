SeafoamIslandsB1F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

SeafoamIslandsB1F_MapEventHeader:
	db 6 ; warps
	warp_def 15, 35, 3, SEAFOAM_ISLANDS_1F
	warp_def 3, 3, 5, SEAFOAM_ISLANDS_1F
	warp_def 15, 27, 1, SEAFOAM_ISLANDS_B2F
	warp_def 5, 18, 2, SEAFOAM_ISLANDS_B2F
	warp_def 11, 15, 3, SEAFOAM_ISLANDS_B2F
	warp_def 15, 7, 4, SEAFOAM_ISLANDS_B2F

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 11, 20, SIGNPOST_ITEM + ICE_HEAL, EVENT_SEAFOAM_ISLANDS_B1F_HIDDEN_ICE_HEAL

	db 8 ; person events
	itemball_event 3, 20, GRIP_CLAW, 1, EVENT_SEAFOAM_ISLANDS_B1F_GRIP_CLAW
	itemball_event 5, 24, ICE_HEAL, 1, EVENT_SEAFOAM_ISLANDS_B1F_ICE_HEAL
	strengthboulder_event 9, 30
	strengthboulder_event 9, 31
	strengthboulder_event 10, 32
	strengthboulder_event 8, 12
	strengthboulder_event 11, 7
	strengthboulder_event 15, 13
