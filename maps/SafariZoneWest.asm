SafariZoneWest_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SafariZoneWest_MapEventHeader:

.Warps: db 8
	warp_def 2, 22, 8, SAFARI_ZONE_NORTH
	warp_def 2, 23, 9, SAFARI_ZONE_NORTH
	warp_def 2, 28, 3, SAFARI_ZONE_NORTH
	warp_def 2, 29, 4, SAFARI_ZONE_NORTH
	warp_def 24, 31, 5, SAFARI_ZONE_HUB
	warp_def 25, 31, 6, SAFARI_ZONE_HUB
	warp_def 13, 13, 1, SAFARI_ZONE_WEST_REST_HOUSE_1
	warp_def 5, 5, 1, SAFARI_ZONE_WEST_REST_HOUSE_2

.XYTriggers: db 0

.Signposts: db 5
	signpost 24, 26, SIGNPOST_JUMPTEXT, SafariZoneWestAreaSignText
	signpost 14, 14, SIGNPOST_JUMPTEXT, SafariZoneWestRestHouseSignText
	signpost 6, 28, SIGNPOST_JUMPTEXT, SafariZoneWestTrainerTips1SignText
	signpost 5, 19, SIGNPOST_JUMPTEXT, SafariZoneWestTrainerTips2SignText
	signpost 6, 13, SIGNPOST_ITEM + NUGGET, EVENT_SAFARI_ZONE_WEST_HIDDEN_NUGGET

.PersonEvents: db 4
	person_event SPRITE_LASS, 23, 22, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerLassDuplica, -1
	person_event SPRITE_YOUNGSTER, 12, 23, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerCamperAmos, -1
	person_event SPRITE_COOLTRAINER_M, 19, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerTamerBrett, -1
	itemball_event 9, 14, MAX_REVIVE, 1, EVENT_SAFARI_ZONE_WEST_MAX_REVIVE

TrainerLassDuplica:
	trainer EVENT_BEAT_LASS_DUPLICA, LASS, DUPLICA, LassDuplicaSeenText, LassDuplicaBeatenText, 0, LassDuplicaScript

LassDuplicaScript:
	end_if_just_battled
	jumptextfaceplayer LassDuplicaAfterText

TrainerCamperAmos:
	trainer EVENT_BEAT_CAMPER_AMOS, CAMPER, AMOS, CamperAmosSeenText, CamperAmosBeatenText, 0, CamperAmosScript

CamperAmosScript:
	end_if_just_battled
	jumptextfaceplayer CamperAmosAfterText

TrainerTamerBrett:
	trainer EVENT_BEAT_TAMER_BRETT, TAMER, BRETT, TamerBrettSeenText, TamerBrettBeatenText, 0, TamerBrettScript

TamerBrettScript:
	end_if_just_battled
	jumptextfaceplayer TamerBrettAfterText

LassDuplicaSeenText:
	text "To truly use"
	line "Ditto, you must"
	cont "know all #mon!"
	done

LassDuplicaBeatenText:
	text "I've got a lot"
	line "to learn."
	done

LassDuplicaAfterText:
	text "I'm really good at"
	line "impressions!"

	para "Someday I'll become"
	line "a Fuschia Gym"

	para "Trainer and mimic"
	line "Janine."
	done

CamperAmosSeenText:
	text "Plenty of #mon"
	line "live in the Safari"
	cont "Zone."

	para "I'm here to catch"
	line "'em all!"
	done

CamperAmosBeatenText:
	text "I lost 'cause I"
	line "have to train"
	cont "them!"
	done

CamperAmosAfterText:
	text "I'll search far"
	line "and wide for new"
	cont "#mon."
	done

TamerBrettSeenText:
	text "Do you know how to"
	line "handle aggressive"
	cont "#mon?"
	done

TamerBrettBeatenText:
	text "Yeah, you do!"
	done

TamerBrettAfterText:
	text "You have to com-"
	line "mand #mon with"
	cont "confidence."

	para "Earning Badges can"
	line "help with that."
	done

SafariZoneWestAreaSignText:
	text "Safari Zone"
	line "West Area"
	done

SafariZoneWestRestHouseSignText:
	text "Rest House"
	done

SafariZoneWestTrainerTips1SignText:
	text "Trainer Tips"

	para "Fire-type Pokemon"
	line "cannot be burnt,"

	para "Electric types"
	line "can't be paralyzed,"

	para "and Ice types can't"
	line "be frozen solid."
	done

SafariZoneWestTrainerTips2SignText:
	text "Trainer Tips"

	para "In a sandstorm,"
	line "Rock-type #mon"

	para "get a boost to"
	line "their Spcl.Def."
	done
