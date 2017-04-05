const_value set 2
	const DIMCAVE4F_BOULDER
	const DIMCAVE4F_FALLEN_BOULDER

DimCave4F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 2

	; callbacks

	dbw MAPCALLBACK_TILES, .BouldersLand
	dbw MAPCALLBACK_CMDQUEUE, .SetUpStoneTable

.BouldersLand:
	checkevent EVENT_BOULDER_FELL_IN_DIM_CAVE_4F
	iftrue .skip
	changeblock $1a, $18, $c9
	changeblock $4, $18, $b9
.skip
	return

.SetUpStoneTable:
	writecmdqueue .CommandQueue
	return

.CommandQueue:
	dbw CMDQUEUE_STONETABLE, .StoneTable ; check if any stones are sitting on a warp
	dw 0 ; filler

.StoneTable:
	stonetable 6, DIMCAVE4F_BOULDER, .Boulder
	db -1

.Boulder:
	disappear DIMCAVE4F_BOULDER
	clearevent EVENT_BOULDER_FELL_IN_DIM_CAVE_3F
	pause 30
	playsound SFX_STRENGTH
	earthquake 80
	opentext
	writetext DimCave4FBoulderFellThroughText
	waitbutton
	closetext
	end

DimCave4FFallenBoulderScript:
	jumptext DimCave4FFallenBoulderText

DimCave4FBoulder:
	jumpstd strengthboulder

DimCave4FFallenBoulderText:
	text "It's stuck on the"
	line "button."
	done

DimCave4FBoulderFellThroughText:
	text "The boulder fell"
	line "through."
	done

DimCave4F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $10, $2, 2, DIM_CAVE_5F
	warp_def $1d, $1b, 3, DIM_CAVE_5F
	warp_def $18, $1b, 4, DIM_CAVE_5F ; hole
	warp_def $5, $5, 1, DIM_CAVE_3F
	warp_def $16, $1c, 2, DIM_CAVE_3F
	warp_def $7, $e, 3, DIM_CAVE_3F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_BOULDER, 15, 14, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave4FBoulder, EVENT_BOULDER_IN_DIM_CAVE_4F
	person_event SPRITE_BOULDER, 25, 27, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave4FFallenBoulderScript, EVENT_BOULDER_FELL_IN_DIM_CAVE_4F
