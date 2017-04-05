const_value set 2
	const DIMCAVE2F_FALLEN_BOULDER

DimCave2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks
	dbw MAPCALLBACK_TILES, .BouldersLand

.BouldersLand:
	checkevent EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
	iftrue .skip
	changeblock $e, $14, $c5
	changeblock $1a, $14, $ba
.skip
	return

DimCave2FFallenBoulderScript:
	jumptext DimCave2FFallenBoulderText

DimCave2FFallenBoulderText:
	text "It's stuck on the"
	line "button."
	done

DimCave2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 8
	warp_def $1, $f, 2, CERULEAN_CAPE
	warp_def $5, $1d, 4, DIM_CAVE_3F
	warp_def $19, $1b, 5, DIM_CAVE_3F
	warp_def $14, $e, 6, DIM_CAVE_3F ; hole
	warp_def $2, $1e, 1, DIM_CAVE_1F
	warp_def $11, $5, 2, DIM_CAVE_1F
	warp_def $12, $1c, 3, DIM_CAVE_1F
	warp_def $20, $18, 4, DIM_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_BOULDER, 21, 14, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave2FFallenBoulderScript, EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
