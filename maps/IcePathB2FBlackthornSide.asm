IcePathB2FBlackthornSide_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  3, 15, ICE_PATH_B1F, 8
	warp_event  3,  3, ICE_PATH_B3F, 2

	db 0 ; coord events

	db 1 ; bg events
	bg_event  2, 10, SIGNPOST_ITEM + ICE_HEAL, EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_HIDDEN_ICE_HEAL

	db 1 ; object events
	itemball_event  8, 16, NUGGET, 1, EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_NUGGET
