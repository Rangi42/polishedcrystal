const_value set 2
	const ROUTE7_BIG_SNORLAX

Route7_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route7Snorlax:
	opentext
	special SpecialSnorlaxAwake
	iftrue Route7SnorlaxAwake
	writetext Route7SnorlaxAsleepText
	waitbutton
	closetext
	end

Route7SnorlaxAwake:
	writetext Route7SnorlaxAwakeText
	pause 15
	cry SNORLAX
	closetext
	writecode VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	loadwildmon SNORLAX, 60
	startbattle
	disappear ROUTE7_BIG_SNORLAX
	reloadmapafterbattle
	end

Route7UndergroundPathSign:
	jumptext Route7UndergroundPathSignText

Route7LockedDoor:
	jumptext Route7LockedDoorText

Route7SnorlaxAsleepText:
	text "Snorlax is snoring"
	line "peacefully…"
	done

Route7SnorlaxAwakeText:
	text "The #gear was"
	line "placed near the"
	cont "sleeping Snorlax…"

	para "…"

	para "Snorlax woke up!"
	done

Route7UndergroundPathSignText:
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

Route7LockedDoorText:
	text "It's locked…"
	done

Route7_MapEventHeader:
	; filler
	db 0, 0

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
	db 1
	person_event SPRITE_BIG_SNORLAX, 0, 1, SPRITEMOVEDATA_SNORLAX, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route7Snorlax, EVENT_ROUTE_8_SNORLAX
