const_value set 2
	const DIMCAVE5F_BOULDER

DimCave5F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_CMDQUEUE, .SetUpStoneTable

.SetUpStoneTable:
	writecmdqueue .CommandQueue
	return

.CommandQueue:
	dbw CMDQUEUE_STONETABLE, .StoneTable ; check if any stones are sitting on a warp
	dw 0 ; filler

.StoneTable:
	stonetable 4, DIMCAVE5F_BOULDER, .Boulder
	db -1

.Boulder:
	disappear DIMCAVE5F_BOULDER
	clearevent EVENT_BOULDER_FELL_IN_DIM_CAVE_4F
	pause 30
	playsound SFX_STRENGTH
	earthquake 80
	opentext
	writetext DimCave5FBoulderFellThroughText
	waitbutton
	closetext
	end

DimCave5FBoulder:
	jumpstd strengthboulder

DimCave5FBoulderFellThroughText:
	text "The boulder fell"
	line "through."
	done

DimCave5F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $1f, $d, 5, ROUTE_10_NORTH
	warp_def $10, $2, 1, DIM_CAVE_4F
	warp_def $1d, $1b, 2, DIM_CAVE_4F
	warp_def $19, $1c, 3, DIM_CAVE_4F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 5, 25, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave5FBoulder, EVENT_BOULDER_IN_DIM_CAVE_5F
