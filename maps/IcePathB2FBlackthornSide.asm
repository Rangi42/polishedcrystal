const_value set 2
	const ICEPATHB2FBLACKTHORNSIDE_POKE_BALL

IcePathB2FBlackthornSide_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

IcePathB2FBlackthornSideNugget:
	itemball NUGGET

IcePathB2FBlackthornSideHiddenIceHeal:
	dwb EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_HIDDEN_ICE_HEAL, ICE_HEAL


IcePathB2FBlackthornSide_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $f, $3, 8, ICE_PATH_B1F
	warp_def $3, $3, 2, ICE_PATH_B3F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 10, 2, SIGNPOST_ITEM, IcePathB2FBlackthornSideHiddenIceHeal

.PersonEvents:
	db 1
	person_event SPRITE_BALL_CUT_FRUIT, 16, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, IcePathB2FBlackthornSideNugget, EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_NUGGET
