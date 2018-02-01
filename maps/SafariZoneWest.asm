SafariZoneWest_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 8 ; warp events
	warp_event 22, 2, 8, SAFARI_ZONE_NORTH
	warp_event 23, 2, 9, SAFARI_ZONE_NORTH
	warp_event 28, 2, 3, SAFARI_ZONE_NORTH
	warp_event 29, 2, 4, SAFARI_ZONE_NORTH
	warp_event 31, 24, 5, SAFARI_ZONE_HUB
	warp_event 31, 25, 6, SAFARI_ZONE_HUB
	warp_event 13, 13, 1, SAFARI_ZONE_WEST_REST_HOUSE_1
	warp_event 5, 5, 1, SAFARI_ZONE_WEST_REST_HOUSE_2

	db 0 ; coord events

	db 5 ; bg events
	bg_event 26, 24, SIGNPOST_JUMPTEXT, SafariZoneWestAreaSignText
	bg_event 14, 14, SIGNPOST_JUMPTEXT, SafariZoneWestRestHouseSignText
	bg_event 28, 6, SIGNPOST_JUMPTEXT, SafariZoneWestTrainerTips1SignText
	bg_event 19, 5, SIGNPOST_JUMPTEXT, SafariZoneWestTrainerTips2SignText
	bg_event 13, 6, SIGNPOST_ITEM + NUGGET, EVENT_SAFARI_ZONE_WEST_HIDDEN_NUGGET

	db 4 ; object events
	object_event 22, 23, SPRITE_LASS, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerLassDuplica, -1
	object_event 23, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerCamperAmos, -1
	object_event 12, 19, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerTamerBrett, -1
	itemball_event 14, 9, MAX_REVIVE, 1, EVENT_SAFARI_ZONE_WEST_MAX_REVIVE

TrainerLassDuplica:
	trainer LASS, DUPLICA, EVENT_BEAT_LASS_DUPLICA, LassDuplicaSeenText, LassDuplicaBeatenText, 0, LassDuplicaScript

LassDuplicaScript:
	end_if_just_battled
	jumptextfaceplayer LassDuplicaAfterText

TrainerCamperAmos:
	trainer CAMPER, AMOS, EVENT_BEAT_CAMPER_AMOS, CamperAmosSeenText, CamperAmosBeatenText, 0, CamperAmosScript

CamperAmosScript:
	end_if_just_battled
	jumptextfaceplayer CamperAmosAfterText

TrainerTamerBrett:
	trainer TAMER, BRETT, EVENT_BEAT_TAMER_BRETT, TamerBrettSeenText, TamerBrettBeatenText, 0, TamerBrettScript

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
