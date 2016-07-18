const_value set 2
	const BELLCHIMETRAIL_POKE_BALL

BellchimeTrail_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

BellchimeTrailTMDazzlingleam:
	itemball TM_DAZZLINGLEAM

TinTowerSign:
	jumptext TinTowerSignText

TinTowerSignText:
	text "Bell Tower"

	para "A legendary #-"
	line "mon is said to"
	cont "roost here."
	done

BellchimeTrail_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $2, $4, 1, WISE_TRIOS_ROOM
	warp_def $3, $4, 2, WISE_TRIOS_ROOM
	warp_def $7, $15, 1, TIN_TOWER_1F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 10, 22, SIGNPOST_READ, TinTowerSign

.PersonEvents:
	db 1
	person_event SPRITE_POKE_BALL, 4, 17, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, BellchimeTrailTMDazzlingleam, EVENT_BELLCHIME_TRAIL_TM_DAZZLINGLEAM
