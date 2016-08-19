const_value set 2
	const BELLCHIMETRAIL_VALERIE

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

BellchimeTrailValerieScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_VALERIE
	iftrue .Listened
	writetext BellchimeTrailValerieIntroText
	waitbutton
	setevent EVENT_LISTENED_TO_VALERIE
.Listened:
	writetext BellchimeTrailValerieBattleText
	yesorno
	iffalse .Refused
	writetext BellchimeTrailValerieAcceptedText
	waitbutton
	closetext
	winlosstext BellchimeTrailValerieBeatenText, 0
	setlasttalked BELLCHIMETRAIL_VALERIE
	loadtrainer VALERIE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_VALERIE
	opentext
	writetext BellchimeTrailValerieRewardText
	buttonsound
	verbosegiveitem TM_DAZZLINGLEAM
	setevent EVENT_GOT_TM60_DAZZLINGLEAM_FROM_VALERIE
	writetext BellchimeTrailValerieFarewellText
	waitbutton
	closetext
	checkcode VAR_FACING
	if_not_equal RIGHT, .SkipGoAround
	applymovement BELLCHIMETRAIL_VALERIE, MovementData_ValerieDeparts2
.SkipGoAround
	applymovement BELLCHIMETRAIL_VALERIE, MovementData_ValerieDeparts1
	disappear BELLCHIMETRAIL_VALERIE
	clearevent EVENT_VALERIE_ECRUTEAK_CITY
	end

.Refused:
	writetext BellchimeTrailValerieRefusedText
	waitbutton
	closetext
	end

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

MovementData_ValerieDeparts1:
	step_left
	step_left
	step_left
	step_up
	step_up
	step_left
	step_left
	step_end

MovementData_ValerieDeparts2:
	step_down
	step_left
	step_end

BellchimeTrailValerieIntroText:
	text "If it isn't the"
	line "trainer who faced"
	cont "Suicune…"

	para "I am Valerie."
	line "I come to this"

	para "trail to be"
	line "captivated by its"
	cont "beauty."

	para "Today I was for-"
	line "tunate enough to"

	para "witness your"
	line "battle with a"
	cont "legend…"

	para "I would love to"
	line "contend with one"

	para "who caught the eye"
	line "of a legendary"
	cont "#mon."
	done

BellchimeTrailValerieBattleText:
	text "Valerie: I train"
	line "the elusive Fairy"
	cont "type."

	para "They appear frail"
	line "and delicate, but"
	cont "they are strong."

	para "Will you battle"
	line "with me?"
	done

BellchimeTrailValerieRefusedText:
	text "Valerie: Alas…"
	done

BellchimeTrailValerieAcceptedText:
	text "Valerie: I hope"
	line "our battle will"

	para "prove entertaining"
	line "to you."
	done

BellchimeTrailValerieBeatenText:
	text "I hope the sun is"
	line "shining tomorrow…"

	para "That would be"
	line "reason enough to"
	cont "smile."
	done

BellchimeTrailValerieRewardText:
	text "Valerie: Yes… that"
	line "was a fine battle."

	para "I shall reward you"
	line "for this great"
	cont "victory."

	para "Please consider"
	line "this as a personal"
	cont "gift from me."
	done

BellchimeTrailValerieFarewellText:
	text "Valerie: Oh? My,"
	line "what a curious"
	cont "feeling…"

	para "I can't seem to"
	line "recall which move"

	para "is contained in"
	line "that TM."

	para "I hope you might"
	line "forgive me."

	para "That was truly a"
	line "captivating"
	cont "battle."

	para "I might just be"
	line "captivated by you."

	para "Until we meet"
	line "again, farewell."
	done

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
	person_event SPRITE_VALERIE, 6, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BellchimeTrailValerieScript, EVENT_BEAT_VALERIE
