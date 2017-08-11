Route13West_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route13West_MapEventHeader:

.Warps: db 0

.XYTriggers: db 0

.Signposts: db 1
	signpost 13, 17, SIGNPOST_JUMPTEXT, Route13DirectionsSignText

.PersonEvents: db 4
	person_event SPRITE_YOUNGSTER, 5, 5, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerCamperClark, -1
	person_event SPRITE_LASS, 6, 16, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerPicnickerGinger, -1
	person_event SPRITE_POKEFAN_M, 10, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerHikerKenny, -1
	person_event SPRITE_POKEFAN_M, 6, 25, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

TrainerCamperClark:
	trainer EVENT_BEAT_CAMPER_CLARK, CAMPER, CLARK, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Collect water!"
	line "Don't let the fire"
	cont "go out!"

	para "Look out for wild"
	line "#mon!"

	para "Let's go,"
	line "Campfire!"
	done

.BeatenText:
	text "Pfuuuuhh…"
	done

.AfterText:
	text "It doesn't matter"
	line "what kind of prep"
	cont "work you've done."

	para "If you lose, you"
	line "lose."
	done

TrainerPicnickerGinger:
	trainer EVENT_BEAT_PICNICKER_GINGER, PICNICKER, GINGER, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Why do I always"
	line "get the urge to"
	cont "whistle outdoors?"
	done

.BeatenText:
	text "Tweeee!"
	done

.AfterText:
	text "You can communi-"
	line "cate with #mon"

	para "through whistling"
	line "instead of words!"
	done

TrainerHikerKenny:
	trainer EVENT_BEAT_HIKER_KENNY, HIKER, KENNY, HikerKennySeenText, HikerKennyBeatenText, 0, HikerKennyScript

HikerKennyScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a26c2

HikerKennySeenText:
	text "I should go to"
	line "Rock Tunnel to get"
	cont "myself an Onix."
	done

HikerKennyBeatenText:
	text "I lost…"
	done

UnknownText_0x1a26c2:
	text "Geological fea-"
	line "tures don't appear"
	cont "to change."

	para "But they actually"
	line "change, little by"
	cont "little."
	done

Route13DirectionsSignText:
	text "North to Lavender"
	line "Town"

	para "West to Fuchsia"
	line "City"
	done
