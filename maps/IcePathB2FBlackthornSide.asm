IcePathB2FBlackthornSide_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

IcePathB2FBlackthornSide_MapEventHeader:
	db 2 ; warps
	warp_def 15, 3, 8, ICE_PATH_B1F
	warp_def 3, 3, 2, ICE_PATH_B3F

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 10, 2, SIGNPOST_ITEM + ICE_HEAL, EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_HIDDEN_ICE_HEAL

	db 1 ; person events
	itemball_event 16, 8, NUGGET, 1, EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_NUGGET
