CinnabarVolcanoB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 2
	dbw MAPCALLBACK_TILES, CinnabarVolcanoB1FBouldersLand
	dbw MAPCALLBACK_CMDQUEUE, CinnabarVolcanoB1FBouldersFall

CinnabarVolcanoB1F_MapEventHeader:

.Warps: db 12
	warp_def 17, 9, 2, CINNABAR_VOLCANO_1F
	warp_def 25, 19, 3, CINNABAR_VOLCANO_1F
	warp_def 25, 29, 4, CINNABAR_VOLCANO_1F
	warp_def 13, 27, 5, CINNABAR_VOLCANO_1F
	warp_def 3, 19, 1, CINNABAR_VOLCANO_B2F
	warp_def 21, 33, 2, CINNABAR_VOLCANO_B2F
	warp_def 9, 8, 3, CINNABAR_VOLCANO_B2F
	warp_def 24, 12, 6, CINNABAR_VOLCANO_1F ; hole
	warp_def 24, 24, 7, CINNABAR_VOLCANO_1F ; hole
	warp_def 13, 23, 8, CINNABAR_VOLCANO_1F ; hole
	warp_def 11, 15, 9, CINNABAR_VOLCANO_1F ; hole
	warp_def 8, 20, 10, CINNABAR_VOLCANO_1F

.XYTriggers: db 0

.Signposts: db 2
	signpost 5, 28, SIGNPOST_ITEM + MAX_REVIVE, EVENT_CINNABAR_VOLCANO_B1F_HIDDEN_MAX_REVIVE
	signpost 18, 28, SIGNPOST_ITEM + DIRE_HIT, EVENT_CINNABAR_VOLCANO_B1F_HIDDEN_DIRE_HIT

.PersonEvents: db 6
	strengthboulder_event 5, 6, EVENT_BOULDER_IN_CINNABAR_VOLCANO_B1F
	smashrock_event 28, 8
	smashrock_event 17, 28
	smashrock_event 5, 27
	itemball_event 18, 2, FIRE_STONE, 1, EVENT_CINNABAR_VOLCANO_B1F_NUGGET
	itemball_event 29, 4, NUGGET, 1, EVENT_CINNABAR_VOLCANO_B1F_FIRE_STONE

const_value set 1
	const CINNABARVOLCANOB1F_BOULDER

CinnabarVolcanoB1FBouldersLand:
	checkevent EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_1
	iffalse .skip1
	changeblock 12, 24, $5f
.skip1
	checkevent EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_2
	iffalse .skip2
	changeblock 24, 22, $5f
.skip2
	checkevent EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_3
	iffalse .skip3
	changeblock 22, 12, $5d
.skip3
	checkevent EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_4
	iffalse .skip4
	changeblock 14, 10, $5d
.skip4
	return

CinnabarVolcanoB1FBouldersFall:
	writecmdqueue .BoulderCmdQueue
	return

.BoulderCmdQueue:
	dbw CMDQUEUE_STONETABLE, .BoulderTable ; check if any stones are sitting on a warp
	dw 0 ; filler

.BoulderTable:
	stonetable 7, CINNABARVOLCANOB1F_BOULDER, .Disappear
	db -1 ; end

.Disappear:
	disappear CINNABARVOLCANOB1F_BOULDER
	jump .Fall

.Fall:
	pause 30
	scall .FX
	jumptext CinnabarVolcanoB1FBoulderFellText

.FX:
	playsound SFX_STRENGTH
	earthquake 80
	end

CinnabarVolcanoB1FBoulderFellText:
	text "The boulder fell"
	line "through!"
	done
