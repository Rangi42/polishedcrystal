CinnabarVolcanoB1F_MapScriptHeader:
	db 0 ; scene scripts

	db 2 ; callbacks
	callback MAPCALLBACK_TILES, CinnabarVolcanoB1FBouldersLand
	callback MAPCALLBACK_CMDQUEUE, CinnabarVolcanoB1FBouldersFall

	db 12 ; warp events
	warp_event  9, 17, CINNABAR_VOLCANO_1F, 2
	warp_event 19, 25, CINNABAR_VOLCANO_1F, 3
	warp_event 29, 25, CINNABAR_VOLCANO_1F, 4
	warp_event 27, 13, CINNABAR_VOLCANO_1F, 5
	warp_event 19,  3, CINNABAR_VOLCANO_B2F, 1
	warp_event 33, 21, CINNABAR_VOLCANO_B2F, 2
	warp_event  8,  9, CINNABAR_VOLCANO_B2F, 3
	warp_event 12, 24, CINNABAR_VOLCANO_1F, 6 ; hole
	warp_event 24, 24, CINNABAR_VOLCANO_1F, 7 ; hole
	warp_event 23, 13, CINNABAR_VOLCANO_1F, 8 ; hole
	warp_event 15, 11, CINNABAR_VOLCANO_1F, 9 ; hole
	warp_event 20,  8, CINNABAR_VOLCANO_1F, 10

	db 0 ; coord events

	db 2 ; bg events
	bg_event 28,  5, SIGNPOST_ITEM + MAX_REVIVE, EVENT_CINNABAR_VOLCANO_B1F_HIDDEN_MAX_REVIVE
	bg_event 28, 18, SIGNPOST_ITEM + DIRE_HIT, EVENT_CINNABAR_VOLCANO_B1F_HIDDEN_DIRE_HIT

	db 6 ; object events
	strengthboulder_event  6,  5, EVENT_BOULDER_IN_CINNABAR_VOLCANO_B1F
	smashrock_event  8, 28
	smashrock_event 28, 17
	smashrock_event 27, 5
	itemball_event  2, 18, FIRE_STONE, 1, EVENT_CINNABAR_VOLCANO_B1F_NUGGET
	itemball_event  4, 29, NUGGET, 1, EVENT_CINNABAR_VOLCANO_B1F_FIRE_STONE

	const_def 1 ; object constants
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
