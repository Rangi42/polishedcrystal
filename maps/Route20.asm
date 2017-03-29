const_value set 2
	const ROUTE20_SWIMMER_GIRL1
	const ROUTE20_SWIMMER_GIRL2
	const ROUTE20_SWIMMER_GUY

Route20_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_NEWMAP, .ClearRocks

.ClearRocks:
	setevent EVENT_CINNABAR_ROCKS_CLEARED
	return

TrainerSwimmerfNicole:
	trainer EVENT_BEAT_SWIMMERF_NICOLE, SWIMMERF, NICOLE, SwimmerfNicoleSeenText, SwimmerfNicoleBeatenText, 0, SwimmerfNicoleScript

SwimmerfNicoleScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1acd93
	waitbutton
	closetext
	end

TrainerSwimmerfLori:
	trainer EVENT_BEAT_SWIMMERF_LORI, SWIMMERF, LORI, SwimmerfLoriSeenText, SwimmerfLoriBeatenText, 0, SwimmerfLoriScript

SwimmerfLoriScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ace15
	waitbutton
	closetext
	end

TrainerSwimmermCameron:
	trainer EVENT_BEAT_SWIMMERM_CAMERON, SWIMMERM, CAMERON, SwimmermCameronSeenText, SwimmermCameronBeatenText, 0, SwimmermCameronScript

SwimmermCameronScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ace8b
	waitbutton
	closetext
	end

CinnabarGymSign:
	jumptext CinnabarGymSignText

SeafoamIslandsSign:
	jumptext SeafoamIslandsSignText

SwimmerfNicoleSeenText:
	text "I feel so much"
	line "lighter in water."
	done

SwimmerfNicoleBeatenText:
	text "Oh, no!"
	done

UnknownText_0x1acd93:
	text "Swimming exercises"
	line "your full body."

	para "It's really good"
	line "for you."
	done

SwimmerfLoriSeenText:
	text "What an impressive"
	line "collection of Gym"

	para "Badges. We should"
	line "battle!"
	done

SwimmerfLoriBeatenText:
	text "No!"
	done

UnknownText_0x1ace15:
	text "Surf is no longer"
	line "the only HM move"
	cont "you use in water."
	done

SwimmermCameronSeenText:
	text "I guess it's im-"
	line "possible to swim"

	para "all the way to"
	line "Johto."
	done

SwimmermCameronBeatenText:
	text "Aiyah!"
	done

UnknownText_0x1ace8b:
	text "Besides the sea, I"
	line "can also swim in"
	cont "ponds and rivers."
	done

CinnabarGymSignText:
	text "Seafoam Islands"

	para "…What does this"
	line "notice say?"

	para "Cinnabar Gym"
	line "Leader: Blaine"
	done

SeafoamIslandsSignText:
	text "Seafoam Islands"
	done

Route20_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $9, $3e, 1, SEAFOAM_ISLANDS_1F
	warp_def $5, $36, 4, SEAFOAM_ISLANDS_1F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 11, 61, SIGNPOST_READ, CinnabarGymSign
	signpost 7, 57, SIGNPOST_READ, SeafoamIslandsSign

.PersonEvents:
	db 3
	person_event SPRITE_SWIMMER_GIRL, 8, 78, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfNicole, -1
	person_event SPRITE_SWIMMER_GIRL, 13, 70, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfLori, -1
	person_event SPRITE_SWIMMER_GUY, 7, 11, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermCameron, -1
