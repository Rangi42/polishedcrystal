IcePathB2FBlackthornSide_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

IcePathB2FBlackthornSide_MapEventHeader:

.Warps: db 2
	warp_def 15, 3, 8, ICE_PATH_B1F
	warp_def 3, 3, 2, ICE_PATH_B3F

.XYTriggers: db 0

.Signposts: db 1
	signpost 10, 2, SIGNPOST_ITEM + ICE_HEAL, EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_HIDDEN_ICE_HEAL

.PersonEvents: db 1
	itemball_event 16, 8, NUGGET, 1, EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_NUGGET
