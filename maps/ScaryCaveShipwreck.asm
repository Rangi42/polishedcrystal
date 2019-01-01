ScaryCaveShipwreck_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  5,  9, SCARY_CAVE_1F, 5

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	itemball_event  7,  8, RARE_BONE, 1, EVENT_SCARY_CAVE_SHIPWRECK_RARE_BONE

