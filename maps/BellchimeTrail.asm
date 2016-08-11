const_value set 2
	const BELLCHIMETRAIL_POKE_BALL

BellchimeTrail_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 0

.Trigger0:
	priorityjump BellchimeTrailStepDownScript
	end

.Trigger1:
	end

BellchimeTrailStepDownScript:
	checkcode VAR_YCOORD
	if_not_equal $9, .Done
	checkcode VAR_XCOORD
	if_not_equal $15, .Done
	applymovement PLAYER, BellchimeTrailStepDownMovementData
.Done
	dotrigger $1
	end

BellchimeTrailPanUpScript:
	playsound SFX_EXIT_BUILDING
	applymovement PLAYER, BellchimeTrailHidePlayerMovementData
	waitsfx
	applymovement PLAYER, BellchimeTrailPanUpMovementData
	disappear PLAYER
	pause 10
	special FadeOutPalettes
	pause 15
	dotrigger $0
	warpfacing UP, TIN_TOWER_1F, $9, $f
	end

BellchimeTrailTMDazzlingleam:
	itemball TM_DAZZLINGLEAM

TinTowerSign:
	jumptext TinTowerSignText

BellchimeTrailStepDownMovementData:
	step_down
	step_end

BellchimeTrailHidePlayerMovementData:
	hide_person
	step_end

BellchimeTrailPanUpMovementData:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

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
	warp_def $4, $4, 1, WISE_TRIOS_ROOM
	warp_def $5, $4, 2, WISE_TRIOS_ROOM
	warp_def $9, $15, 1, TIN_TOWER_1F ; hole

.XYTriggers:
	db 1
	xy_trigger 1, $9, $15, $0, BellchimeTrailPanUpScript, $0, $0

.Signposts:
	db 1
	signpost 12, 22, SIGNPOST_READ, TinTowerSign

.PersonEvents:
	db 1
	person_event SPRITE_POKE_BALL, 6, 17, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, BellchimeTrailTMDazzlingleam, EVENT_BELLCHIME_TRAIL_TM_DAZZLINGLEAM
