Route13West_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 17, 13, BGEVENT_JUMPTEXT, Route13DirectionsSignText

	def_object_events
	object_event  5,  5, SPRITE_CAMPER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCamperClark, -1
	object_event 16,  6, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPicnickerGinger, -1
	object_event 14, 10, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerKenny, -1
	object_event 25,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

GenericTrainerCamperClark:
	generictrainer CAMPER, CLARK, EVENT_BEAT_CAMPER_CLARK, .SeenText, .BeatenText

	ctxt "It doesn't matter"
	line "what kind of prep"
	cont "work you've done."

	para "If you lose, you"
	line "lose."
	done

.SeenText:
	ctxt "Collect water!"
	line "Don't let the fire"
	cont "go out!"

	para "Look out for wild"
	line "#mon!"

	para "Let's go,"
	line "Campfire!"
	done

.BeatenText:
	ctxt "Pfuuuuhh…"
	done

GenericTrainerPicnickerGinger:
	generictrainer PICNICKER, GINGER, EVENT_BEAT_PICNICKER_GINGER, .SeenText, .BeatenText

	ctxt "You can communi-"
	line "cate with #mon"

	para "through whistling"
	line "instead of words!"
	done

.SeenText:
	ctxt "Why do I always"
	line "get the urge to"
	cont "whistle outdoors?"
	done

.BeatenText:
	ctxt "Tweeee!"
	done

GenericTrainerHikerKenny:
	generictrainer HIKER, KENNY, EVENT_BEAT_HIKER_KENNY, HikerKennySeenText, HikerKennyBeatenText

	ctxt "Geological fea-"
	line "tures don't appear"
	cont "to change."

	para "But they actually"
	line "change, little by"
	cont "little."
	done

HikerKennySeenText:
	ctxt "I should go to"
	line "Rock Tunnel to get"
	cont "myself an Onix."
	done

HikerKennyBeatenText:
	ctxt "I lost…"
	done

Route13DirectionsSignText:
	ctxt "North to Lavender"
	line "Town"

	para "West to Fuchsia"
	line "City"
	done
