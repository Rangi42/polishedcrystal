const_value set 2
	const SCARYCAVESHIPWRECK_RARE_BONE

ScaryCaveShipwreck_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ScaryCaveShipwreckRareBone:
	itemball RARE_BONE

ScaryCaveShipwreck_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $9, $5, 5, SCARY_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
	person_event SPRITE_BALL_CUT_FRUIT, 8, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, ScaryCaveShipwreckRareBone, EVENT_SCARY_CAVE_SHIPWRECK_RARE_BONE
