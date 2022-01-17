Route3_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route3FlyPoint

	def_warp_events
	warp_event 68,  1, MOUNT_MOON_1F, 1
	warp_event 61,  3, ROUTE_3_POKECENTER_1F, 1

	def_coord_events

	def_bg_events
	bg_event 63, 15, BGEVENT_JUMPTEXT, Route3MtMoonSquareSignText
	bg_event 11, 17, BGEVENT_ITEM + MOON_STONE, EVENT_ROUTE_3_HIDDEN_MOON_STONE
	bg_event  8, 15, BGEVENT_JUMPTEXT, Route3MeteoriteText
	bg_event  8, 17, BGEVENT_JUMPTEXT, Route3MeteoriteText
	bg_event  9, 17, BGEVENT_JUMPTEXT, Route3MeteoriteText
	bg_event 12, 15, BGEVENT_JUMPTEXT, Route3MeteoriteText
	bg_event 14, 17, BGEVENT_JUMPTEXT, Route3MeteoriteText
	bg_event 15, 17, BGEVENT_JUMPTEXT, Route3MeteoriteText

	def_object_events
	object_event 12,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterRegis, -1
	object_event 17,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerYoungsterJimmy, -1
	object_event 25,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerYoungsterWarren, -1
	object_event 30, 12, SPRITE_FIREBREATHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerFirebreatherOtis, -1
	object_event 60, 10, SPRITE_FIREBREATHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerFirebreatherBurt, -1
	object_event 44,  8, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBlackbeltManford, -1
	object_event 52, 18, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBlackbeltAnder, -1
	object_event 38,  6, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerHikerBruce, -1
	object_event 61, 19, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerHikerDwight, -1
	object_event 14, 12, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoZacandjen1, -1
	object_event 15, 12, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoZacandjen2, -1
	itemball_event 36, 14, BIG_ROOT, 1, EVENT_ROUTE_3_BIG_ROOT

Route3FlyPoint:
	setflag ENGINE_FLYPOINT_MT_MOON
	endcallback

GenericTrainerYoungsterRegis:
	generictrainer YOUNGSTER, REGIS, EVENT_BEAT_YOUNGSTER_REGIS, .SeenText, .BeatenText

	ctxt "Looks like I need"
	line "more training!"
	done

.SeenText:
	ctxt "Youngster? Good-"
	line "ness, how rude!"

	para "Call me Shorts"
	line "Boy!"
	done

.BeatenText:
	ctxt "That is…"
	line "Fail Boy…"
	done

GenericTrainerYoungsterJimmy:
	generictrainer YOUNGSTER, JIMMY, EVENT_BEAT_YOUNGSTER_JIMMY, .SeenText, .BeatenText

	ctxt "I wear shorts the"
	line "whole year round."

	para "That's my fashion"
	line "policy."
	done

.SeenText:
	ctxt "I can run like the"
	line "wind!"
	done

.BeatenText:
	ctxt "Blown away!"
	done

GenericTrainerYoungsterWarren:
	generictrainer YOUNGSTER, WARREN, EVENT_BEAT_YOUNGSTER_WARREN, .SeenText, .BeatenText

	ctxt "You looked strong."

	para "I was afraid to"
	line "take you on…"
	done

.SeenText:
	ctxt "Hmmm… I don't know"
	line "what to do…"
	done

.BeatenText:
	ctxt "I knew I'd lose…"
	done

GenericTrainerFirebreatherOtis:
	generictrainer FIREBREATHER, OTIS, EVENT_BEAT_FIREBREATHER_OTIS, .SeenText, .BeatenText

	ctxt "When it rains,"
	line "it's hard to get"
	cont "ignition…"
	done

.SeenText:
	ctxt "Ah! The weather's"
	line "as fine as ever."
	done

.BeatenText:
	ctxt "It's sunny, but"
	line "I'm all wet…"
	done

GenericTrainerFirebreatherBurt:
	generictrainer FIREBREATHER, BURT, EVENT_BEAT_FIREBREATHER_BURT, .SeenText, .BeatenText

	ctxt "The greatest fire-"
	line "breather in Kanto,"
	cont "that's me."

	para "But not the best"
	line "trainer…"
	done

.SeenText:
	ctxt "Step right up and"
	line "take a look!"
	done

.BeatenText:
	ctxt "Yow! That's hot!"
	done

GenericTrainerBlackbeltManford:
	generictrainer BLACKBELT_T, MANFORD, EVENT_BEAT_BLACKBELT_MANFORD, .SeenText, .BeatenText

	ctxt "You must have"
	line "trained under a"
	cont "well-known master!"
	done

.SeenText:
	ctxt "Slow down and give"
	line "me the chance to"
	cont "defeat you!"
	done

.BeatenText:
	ctxt "I've been beaten"
	line "at my own game…"
	done

GenericTrainerBlackbeltAnder:
	generictrainer BLACKBELT_T, ANDER, EVENT_BEAT_BLACKBELT_ANDER, .SeenText, .BeatenText

	ctxt "You came all the"
	line "way from Johto?"

	para "You must be very"
	line "persistent!"
	done

.SeenText:
	ctxt "Wait a moment!"
	line "Come fight me!"
	done

.BeatenText:
	ctxt "You did it…"
	done

GenericTrainerHikerBruce:
	generictrainer HIKER, BRUCE, EVENT_BEAT_HIKER_BRUCE, .SeenText, .BeatenText

	ctxt "All right, guess I"
	line "should carry my"
	cont "Bag again!"
	done

.SeenText:
	ctxt "My Bag is digging"
	line "into my shoulders!"

	para "I'll take a break"
	line "and have a battle!"
	done

.BeatenText:
	ctxt "Feh."
	done

GenericTrainerHikerDwight:
	generictrainer HIKER, DWIGHT, EVENT_BEAT_HIKER_DWIGHT, .SeenText, .BeatenText

	ctxt "Greeting someone"
	line "you don't know…"

	para "That's the best"
	line "thing about moun-"
	cont "tains!"
	done

.SeenText:
	ctxt "Peace!"

	para "When you meet the"
	line "unknown on a moun-"
	cont "tain road, all you"

	para "want is peace,"
	line "right?"
	done

.BeatenText:
	ctxt "Peace--even though"
	line "I lost!"
	done

GenericTrainerAceDuoZacandjen1:
	generictrainer ACE_DUO, ZACANDJEN1, EVENT_BEAT_ACE_DUO_ZAC_AND_JEN, .SeenText, .BeatenText

	ctxt "Zac: Your future"
	line "looks promising."
	done

.SeenText:
	ctxt "Zac: Really, you"
	line "want to battle us?"

	para "You've got a lot"
	line "of courage for"
	cont "someone so young."
	done

.BeatenText:
	ctxt "Zac: You weren't"
	line "bluffing…"
	done

GenericTrainerAceDuoZacandjen2:
	generictrainer ACE_DUO, ZACANDJEN2, EVENT_BEAT_ACE_DUO_ZAC_AND_JEN, .SeenText, .BeatenText

	ctxt "Jen: I'm looking"
	line "forward to seeing"

	para "what kind of"
	line "trainer you'll"
	cont "become."
	done

.SeenText:
	ctxt "Jen: Huh? You'd"
	line "like to go up"
	cont "against us? Great!"
	done

.BeatenText:
	ctxt "Jen: You're so"
	line "much stronger than"
	cont "I thought."
	done

Route3MeteoriteText:
	ctxt "Never seen a stone"
	line "like this before!"

	para "Could it be…"
	line "a meteorite from"
	cont "space?"
	done

Route3MtMoonSquareSignText:
	ctxt "Mt.Moon Tunnel"
	done
