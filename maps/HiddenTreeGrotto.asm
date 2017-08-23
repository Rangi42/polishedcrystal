HiddenTreeGrotto_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, HiddenTreeGrottoCallback

HiddenTreeGrotto_MapEventHeader:

.Warps: db 2
	warp_def 15, 4, -1, HIDDEN_TREE_GROTTO
	warp_def 15, 5, -1, HIDDEN_TREE_GROTTO

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 0

HiddenTreeGrottoCallback:
	return
