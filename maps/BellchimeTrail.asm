const_value set 2
	; no sprites

BellchimeTrail_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

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
	db 8
	signpost 10, 22, SIGNPOST_READ, TinTowerSign

.PersonEvents:
	db 0
