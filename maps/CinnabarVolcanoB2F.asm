const_value set 2
	const CINNABARVOLCANOB2F_MOLTRES
	const CINNABARVOLCANOB2F_ROCK

CinnabarVolcanoB2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks
	dbw MAPCALLBACK_TILES, .BouldersLand

.BouldersLand:
	checkevent EVENT_BOULDER_IN_CINNABAR_VOLCANO_B1F
	iffalse .skip1
	changeblock $6, $6, $5f
.skip1
	return

CinnabarVolcanoMoltres:
	faceplayer
	cry MOLTRES
	loadwildmon MOLTRES, 60
	startbattle
	disappear CINNABARVOLCANOB2F_MOLTRES
	setevent EVENT_CINNABAR_VOLCANO_MOLTRES
	reloadmapafterbattle
	end

CinnabarVolcanoB2FRock:
	jumpstd smashrock

CinnabarVolcanoB2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $3, $d, 5, CINNABAR_VOLCANO_B1F
	warp_def $13, $19, 6, CINNABAR_VOLCANO_B1F
	warp_def $6, $6, 7, CINNABAR_VOLCANO_B1F ; hole

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_BIRD, 22, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CinnabarVolcanoMoltres, EVENT_CINNABAR_VOLCANO_MOLTRES
	person_event SPRITE_ROCK, 19, 21, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcanoB2FRock, -1
