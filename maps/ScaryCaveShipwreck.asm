ScaryCaveShipwreck_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ScaryCaveShipwreck_MapEventHeader:

.Warps: db 1
	warp_def 9, 5, 5, SCARY_CAVE_1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	itemball_event 8, 7, RARE_BONE, 1, EVENT_SCARY_CAVE_SHIPWRECK_RARE_BONE

