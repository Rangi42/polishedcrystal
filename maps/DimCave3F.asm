const_value set 2
	const DIMCAVE3F_BOULDER
	const DIMCAVE3F_FALLEN_BOULDER

DimCave3F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 2

	; callbacks

	dbw MAPCALLBACK_TILES, .BouldersLand
	dbw MAPCALLBACK_CMDQUEUE, .SetUpStoneTable

.BouldersLand:
	checkevent EVENT_BOULDER_FELL_IN_DIM_CAVE_3F
	iftrue .skip
	changeblock $e, $8, $c7
	changeblock $e, $1a, $cf
.skip
	return

.SetUpStoneTable:
	writecmdqueue .CommandQueue
	return

.CommandQueue:
	dbw CMDQUEUE_STONETABLE, .StoneTable ; check if any stones are sitting on a warp
	dw 0 ; filler

.StoneTable:
	stonetable 6, DIMCAVE3F_BOULDER, .Boulder
	db -1

.Boulder:
	disappear DIMCAVE3F_BOULDER
	clearevent EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
	pause 30
	playsound SFX_STRENGTH
	earthquake 80
	opentext
	writetext DimCave3FBoulderFellThroughText
	waitbutton
	closetext
	end

DimCave3FFallenBoulderScript:
	jumptext DimCave3FFallenBoulderText

DimCave3FBoulder:
	jumpstd strengthboulder

DimCave3FFallenBoulderText:
	text "It's stuck on the"
	line "button."
	done

DimCave3FBoulderFellThroughText:
	text "The boulder fell"
	line "through."
	done

DimCave3F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $5, $5, 4, DIM_CAVE_4F
	warp_def $16, $1c, 5, DIM_CAVE_4F
	warp_def $a, $f, 6, DIM_CAVE_4F ; hole
	warp_def $5, $1d, 2, DIM_CAVE_2F
	warp_def $19, $1b, 3, DIM_CAVE_2F
	warp_def $15, $e, 4, DIM_CAVE_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 17, 3, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave3FBoulder, EVENT_BOULDER_IN_DIM_CAVE_3F
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 8, 15, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave3FFallenBoulderScript, EVENT_BOULDER_FELL_IN_DIM_CAVE_3F
