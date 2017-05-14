const_value set 2
	const SAFARIZONEWEST_LASS
	const SAFARIZONEWEST_CAMPER
	const SAFARIZONEWEST_TAMER
	const SAFARIZONEWEST_POKE_BALL

SafariZoneWest_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerLassDuplica:
	trainer EVENT_BEAT_LASS_DUPLICA, LASS, DUPLICA, LassDuplicaSeenText, LassDuplicaBeatenText, 0, LassDuplicaScript

LassDuplicaScript:
	end_if_just_battled
	opentext
	writetext LassDuplicaAfterText
	waitbutton
	closetext
	end

TrainerCamperAmos:
	trainer EVENT_BEAT_CAMPER_AMOS, CAMPER, AMOS, CamperAmosSeenText, CamperAmosBeatenText, 0, CamperAmosScript

CamperAmosScript:
	end_if_just_battled
	opentext
	writetext CamperAmosAfterText
	waitbutton
	closetext
	end

TrainerTamerBrett:
	trainer EVENT_BEAT_TAMER_BRETT, TAMER, BRETT, TamerBrettSeenText, TamerBrettBeatenText, 0, TamerBrettScript

TamerBrettScript:
	end_if_just_battled
	opentext
	writetext TamerBrettAfterText
	waitbutton
	closetext
	end

SafariZoneWestMaxRevive:
	itemball MAX_REVIVE

SafariZoneWestAreaSign:
	jumptext SafariZoneWestAreaSignText

SafariZoneWestRestHouseSign:
	jumptext SafariZoneWestRestHouseSignText

SafariZoneWestTrainerTips1Sign:
	jumptext SafariZoneWestTrainerTips1SignText

SafariZoneWestTrainerTips2Sign:
	jumptext SafariZoneWestTrainerTips2SignText

SafariZoneWestHiddenNugget:
	dwb EVENT_SAFARI_ZONE_WEST_HIDDEN_NUGGET, NUGGET

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

SafariZoneWest_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 8
	warp_def $2, $16, 7, SAFARI_ZONE_NORTH
	warp_def $2, $17, 8, SAFARI_ZONE_NORTH
	warp_def $2, $1c, 3, SAFARI_ZONE_NORTH
	warp_def $2, $1d, 4, SAFARI_ZONE_NORTH
	warp_def $18, $1f, 5, SAFARI_ZONE_HUB
	warp_def $19, $1f, 6, SAFARI_ZONE_HUB
	warp_def $d, $d, 1, SAFARI_ZONE_WEST_REST_HOUSE_1
	warp_def $5, $5, 1, SAFARI_ZONE_WEST_REST_HOUSE_2

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 24, 26, SIGNPOST_READ, SafariZoneWestAreaSign
	signpost 14, 14, SIGNPOST_READ, SafariZoneWestRestHouseSign
	signpost 6, 28, SIGNPOST_READ, SafariZoneWestTrainerTips1Sign
	signpost 5, 19, SIGNPOST_READ, SafariZoneWestTrainerTips2Sign
	signpost 6, 13, SIGNPOST_ITEM, SafariZoneWestHiddenNugget

.PersonEvents:
	db 4
	person_event SPRITE_LASS, 23, 22, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerLassDuplica, -1
	person_event SPRITE_YOUNGSTER, 12, 23, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerCamperAmos, -1
	person_event SPRITE_COOLTRAINER_M, 19, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerTamerBrett, -1
	person_event SPRITE_BALL_CUT_FRUIT, 9, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SafariZoneWestMaxRevive, EVENT_SAFARI_ZONE_WEST_MAX_REVIVE
