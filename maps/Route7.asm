const_value set 2
	const ROUTE7_BREEDER
	const ROUTE7_BIG_SNORLAX
	const ROUTE7_POKE_BALL

Route7_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_OBJECTS, .RebattleBreeder

.RebattleBreeder:
	clearevent EVENT_BEAT_BREEDER_CARLENE
	return

TrainerBreederCarlene:
	trainer EVENT_BEAT_BREEDER_CARLENE, BREEDER, CARLENE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "My team is bred"
	line "to handle any"
	cont "situation!"
	done

.BeatenText:
	text "We couldn't"
	line "handle you!"
	done

.AfterText:
	text "I make my Smeargle"
	line "Sketch a move,"

	para "then breed it"
	line "to pass the move"
	cont "down!"

	para "Isn't that smart?"
	done

Route7Snorlax:
	opentext
	special SpecialSnorlaxAwake
	iftrue .Awake
	writetext .AsleepText
	waitbutton
	closetext
	end

.Awake:
	writetext .AwakeText
	pause 15
	cry SNORLAX
	closetext
	writecode VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	loadwildmon SNORLAX, 60
	startbattle
	disappear ROUTE7_BIG_SNORLAX
	setevent EVENT_FOUGHT_SNORLAX
	reloadmapafterbattle
	end

.AsleepText:
	text "Snorlax is snoring"
	line "peacefully…"
	done

.AwakeText:
	text "The #gear was"
	line "placed near the"
	cont "sleeping Snorlax…"

	para "…"

	para "Snorlax woke up!"
	done

Route7MentalHerb:
	itemball MENTAL_HERB

Route7UndergroundPathSign:
	jumptext .Text

.Text:
	text "What's this flyer?"

	para "“Uncouth trainers"
	line "have been holding"

	para "battles in the"
	line "Underground Path."

	para "Because of rising"
	line "complaints by lo-"
	cont "cal residents, the"
	cont "Underground Path"
	cont "has been sealed"
	cont "indefinitely.”"

	para "-- Celadon Police"
	done

Route7LockedDoor:
	jumptext .Text

.Text:
	text "It's locked…"
	done

Route7_MapEventHeader:
.Warps:
	db 2
	warp_def $6, $f, 1, ROUTE_7_SAFFRON_GATE
	warp_def $7, $f, 2, ROUTE_7_SAFFRON_GATE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 13, 5, SIGNPOST_READ, Route7UndergroundPathSign
	signpost 11, 6, SIGNPOST_READ, Route7LockedDoor

.PersonEvents:
	db 3
	person_event SPRITE_BREEDER, 11, 15, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerBreederCarlene, -1
	person_event SPRITE_BIG_SNORLAX, 0, 1, SPRITEMOVEDATA_SNORLAX, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route7Snorlax, EVENT_ROUTE_8_SNORLAX
	person_event SPRITE_BALL_CUT_FRUIT, 1, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, Route7MentalHerb, EVENT_ROUTE_7_MENTAL_HERB
