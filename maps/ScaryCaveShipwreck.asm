ScaryCaveShipwreck_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

ScaryCaveShipwreck_MapEventHeader:
	db 1 ; warps
	warp_def 9, 5, 5, SCARY_CAVE_1F

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	itemball_event 8, 7, RARE_BONE, 1, EVENT_SCARY_CAVE_SHIPWRECK_RARE_BONE

