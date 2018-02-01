SafariZoneEast_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 5 ; warps
	warp_def 24, 2, 3, SAFARI_ZONE_HUB
	warp_def 25, 2, 4, SAFARI_ZONE_HUB
	warp_def 6, 2, 1, SAFARI_ZONE_NORTH
	warp_def 7, 2, 2, SAFARI_ZONE_NORTH
	warp_def 11, 27, 1, SAFARI_ZONE_EAST_REST_HOUSE

	db 0 ; xy triggers

	db 3 ; signposts
	signpost 24, 6, SIGNPOST_JUMPTEXT, SafariZoneEastAreaSignText
	signpost 12, 28, SIGNPOST_JUMPTEXT, SafariZoneEastRestHouseSignText
	signpost 6, 8, SIGNPOST_JUMPTEXT, SafariZoneEastTrainerTipsSignText

	db 4 ; person events
	person_event SPRITE_COWGIRL, 11, 9, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerCowgirlApril, -1
	itemball_event 15, 22, CARBOS, 1, EVENT_SAFARI_ZONE_EAST_CARBOS
	itemball_event 13, 7, SILVERPOWDER, 1, EVENT_SAFARI_ZONE_EAST_SILVERPOWDER
	itemball_event 3, 5, FULL_RESTORE, 1, EVENT_SAFARI_ZONE_EAST_FULL_RESTORE

TrainerCowgirlApril:
	trainer EVENT_BEAT_COWGIRL_APRIL, COWGIRL, APRIL, CowgirlAprilSeenText, CowgirlAprilBeatenText, 0, CowgirlAprilScript

CowgirlAprilScript:
	end_if_just_battled
	jumptextfaceplayer CowgirlAprilAfterText

CowgirlAprilSeenText:
	text "Yeehaw!"
	line "I just caught a"
	cont "whole herd of"
	cont "#mon!"
	done

CowgirlAprilBeatenText:
	text "Well, shoot!"
	done

CowgirlAprilAfterText:
	text "Sometimes you'll"
	line "see 10 of the same"

	para "#mon, all in a"
	line "row!"
	done

SafariZoneEastAreaSignText:
	text "Safari Zone"
	line "East Area"
	done

SafariZoneEastRestHouseSignText:
	text "Rest House"
	done

SafariZoneEastTrainerTipsSignText:
	text "Trainer Tips"

	para "Search for rare"
	line "#mon at night"
	cont "or in the morning!"
	done
