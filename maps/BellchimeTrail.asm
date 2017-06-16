const_value set 2
	const BELLCHIMETRAIL_VALERIE

BellchimeTrail_MapScriptHeader:
.MapTriggers:
	db 1
	dw .Trigger0

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_OBJECTS, SetupValerieMorningWalkScript

.Trigger0:
	priorityjump BellchimeTrailStepDownScript
	end

SetupValerieMorningWalkScript:
	checkevent EVENT_FOUGHT_SUICUNE
	iffalse .Disappear
	checkevent EVENT_BEAT_VALERIE
	iffalse .Appear
	checkflag ENGINE_VALERIE_MORNING_WALK
	iftrue .Disappear
	checkmorn
	iffalse .Disappear
.Appear:
	appear BELLCHIMETRAIL_VALERIE
	return

.Disappear:
	disappear BELLCHIMETRAIL_VALERIE
	return

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
	special Special_FadeOutMusic
	special FadeOutPalettes
	pause 15
	dotrigger $0
	warpfacing UP, TIN_TOWER_1F, $7, $f
	end

BellchimeTrailValerieScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_VALERIE
	iftrue .Rematch
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
	verbosegivetmhm TM_DAZZLINGLEAM
	setevent EVENT_GOT_TM60_DAZZLINGLEAM_FROM_VALERIE
	writetext BellchimeTrailValerieFarewellText
.Depart
	waitbutton
	closetext
	checkcode VAR_FACING
	if_not_equal RIGHT, .SkipGoAround
	applymovement BELLCHIMETRAIL_VALERIE, MovementData_ValerieDeparts2
.SkipGoAround
	applymovement BELLCHIMETRAIL_VALERIE, MovementData_ValerieDeparts1
	disappear BELLCHIMETRAIL_VALERIE
	clearevent EVENT_VALERIE_ECRUTEAK_CITY
	setflag ENGINE_VALERIE_MORNING_WALK
	end

.Refused:
	writetext BellchimeTrailValerieRefusedText
	waitbutton
	closetext
	end

.Rematch:
	writetext BellchimeTrailValerieRematchText
	waitbutton
	closetext
	winlosstext BellchimeTrailValerieRematchBeatenText, 0
	setlasttalked BELLCHIMETRAIL_VALERIE
	checkcode VAR_BADGES
	if_equal 16, .Battle3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .Battle2
	loadtrainer VALERIE, 1
	startbattle
	reloadmapafterbattle
	jump .AfterRematch

.Battle2:
	loadtrainer VALERIE, 2
	startbattle
	reloadmapafterbattle
	jump .AfterRematch

.Battle3:
	loadtrainer VALERIE, 3
	startbattle
	reloadmapafterbattle
	jump .AfterRematch

.AfterRematch:
	opentext
	writetext BellchimeTrailValerieRematchFarewellText
	jump .Depart

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

BellchimeTrailValerieRematchText:
	text "Valerie: Oh, if it"
	line "isn't my young"
	cont "trainer…"

	para "It is lovely to"
	line "meet you again"
	cont "like this."

	para "Then I suppose you"
	line "have earned your-"

	para "self the right to"
	line "a battle."

	para "The elusive Fairy"
	line "may appear frail"

	para "as the breeze and"
	line "delicate as a"

	para "bloom, but it is"
	line "strong."
	done

BellchimeTrailValerieRematchBeatenText:
	text "I hope that you"
	line "will find things"

	para "worth smiling"
	line "about tomorrow…"
	done

BellchimeTrailValerieRematchFarewellText:
	text "That was truly a"
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
.Warps:
	db 3
	warp_def $4, $4, 1, WISE_TRIOS_ROOM
	warp_def $5, $4, 2, WISE_TRIOS_ROOM
	warp_def $9, $15, 1, TIN_TOWER_1F ; hole

.XYTriggers:
	db 1
	xy_trigger 1, $9, $15, BellchimeTrailPanUpScript

.Signposts:
	db 1
	signpost 12, 22, SIGNPOST_READ, TinTowerSign

.PersonEvents:
	db 1
	person_event SPRITE_VALERIE, 6, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BellchimeTrailValerieScript, EVENT_VALERIE_BELLCHIME_TRAIL
