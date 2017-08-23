HiddenCaveGrotto_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, HiddenCaveGrottoCallback

HiddenCaveGrotto_MapEventHeader:

.Warps: db 1
	warp_def 15, 5, -1, HIDDEN_CAVE_GROTTO

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 0

HiddenCaveGrottoCallback:
	return
