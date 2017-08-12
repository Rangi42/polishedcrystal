CinnabarVolcanoB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 2
	dbw MAPCALLBACK_TILES, CinnabarVolcanoB1FBouldersLand
	dbw MAPCALLBACK_CMDQUEUE, CinnabarVolcanoB1FBouldersFall

CinnabarVolcanoB1F_MapEventHeader:

.Warps: db 12
	warp_def $11, $9, 2, CINNABAR_VOLCANO_1F
	warp_def $19, $13, 3, CINNABAR_VOLCANO_1F
	warp_def $19, $1d, 4, CINNABAR_VOLCANO_1F
	warp_def $d, $1b, 5, CINNABAR_VOLCANO_1F
	warp_def $3, $13, 1, CINNABAR_VOLCANO_B2F
	warp_def $15, $21, 2, CINNABAR_VOLCANO_B2F
	warp_def $9, $8, 3, CINNABAR_VOLCANO_B2F
	warp_def $18, $c, 6, CINNABAR_VOLCANO_1F ; hole
	warp_def $18, $18, 7, CINNABAR_VOLCANO_1F ; hole
	warp_def $d, $17, 8, CINNABAR_VOLCANO_1F ; hole
	warp_def $b, $f, 9, CINNABAR_VOLCANO_1F ; hole
	warp_def $8, $14, 10, CINNABAR_VOLCANO_1F

.XYTriggers: db 0

.Signposts: db 2
	signpost 5, 28, SIGNPOST_ITEM, CinnabarVolcanoB1FHiddenMaxRevive
	signpost 18, 28, SIGNPOST_ITEM, CinnabarVolcanoB1FHiddenDireHit

.PersonEvents: db 6
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 5, 6, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, strengthboulder, EVENT_BOULDER_IN_CINNABAR_VOLCANO_B1F
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 28, 8, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, smashrock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 17, 28, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, smashrock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 5, 27, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, smashrock, -1
	person_event SPRITE_BALL_CUT_FRUIT, 18, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, FIRE_STONE, 1, EVENT_CINNABAR_VOLCANO_B1F_NUGGET
	person_event SPRITE_BALL_CUT_FRUIT, 29, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, NUGGET, 1, EVENT_CINNABAR_VOLCANO_B1F_FIRE_STONE

const_value set 2
	const CINNABARVOLCANOB1F_BOULDER

CinnabarVolcanoB1FBouldersLand:
	checkevent EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_1
	iffalse .skip1
	changeblock $c, $18, $5f
.skip1
	checkevent EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_2
	iffalse .skip2
	changeblock $18, $16, $5f
.skip2
	checkevent EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_3
	iffalse .skip3
	changeblock $16, $c, $5d
.skip3
	checkevent EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_4
	iffalse .skip4
	changeblock $e, $a, $5d
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

CinnabarVolcanoB1FHiddenMaxRevive:
	dwb EVENT_CINNABAR_VOLCANO_B1F_HIDDEN_MAX_REVIVE, MAX_REVIVE

CinnabarVolcanoB1FHiddenDireHit:
	dwb EVENT_CINNABAR_VOLCANO_B1F_HIDDEN_DIRE_HIT, DIRE_HIT

CinnabarVolcanoB1FBoulderFellText:
	text "The boulder fell"
	line "through!"
	done
