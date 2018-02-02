Route3_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, Route3FlyPoint

	db 2 ; warp events
	warp_event 68,  1, MOUNT_MOON_1F, 1
	warp_event 61,  3, ROUTE_3_POKECENTER_1F, 1

	db 0 ; coord events

	db 8 ; bg events
	bg_event 63, 15, SIGNPOST_JUMPTEXT, UnknownText_0x1ae163
	bg_event 11, 17, SIGNPOST_ITEM + MOON_STONE, EVENT_ROUTE_3_HIDDEN_MOON_STONE
	bg_event  8, 15, SIGNPOST_JUMPTEXT, Route3MeteoriteText
	bg_event  8, 17, SIGNPOST_JUMPTEXT, Route3MeteoriteText
	bg_event  9, 17, SIGNPOST_JUMPTEXT, Route3MeteoriteText
	bg_event 14, 15, SIGNPOST_JUMPTEXT, Route3MeteoriteText
	bg_event 15, 16, SIGNPOST_JUMPTEXT, Route3MeteoriteText
	bg_event 15, 17, SIGNPOST_JUMPTEXT, Route3MeteoriteText

	db 12 ; object events
	object_event 12,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterRegis, -1
	object_event 17,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerYoungsterJimmy, -1
	object_event 25,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerYoungsterWarren, -1
	object_event 30, 12, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerFirebreatherOtis, -1
	object_event 60, 10, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerFirebreatherBurt, -1
	object_event 44,  8, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerBlackbeltManford, -1
	object_event 52, 18, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerBlackbeltAnder, -1
	object_event 38,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerHikerBruce, -1
	object_event 61, 19, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 5, TrainerHikerDwight, -1
	object_event 14, 12, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoZacandjen1, -1
	object_event 15, 12, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoZacandjen2, -1
	itemball_event 36, 14, BIG_ROOT, 1, EVENT_ROUTE_3_BIG_ROOT

Route3FlyPoint:
	setflag ENGINE_FLYPOINT_MT_MOON
	return

TrainerYoungsterRegis:
	trainer YOUNGSTER, REGIS, EVENT_BEAT_YOUNGSTER_REGIS, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Youngster? Good-"
	line "ness, how rude!"

	para "Call me Shorts"
	line "Boy!"
	done

.BeatenText:
	text "That is…"
	line "Fail Boy…"
	done

.AfterText:
	text "Looks like I need"
	line "more training!"
	done

TrainerYoungsterJimmy:
	trainer YOUNGSTER, JIMMY, EVENT_BEAT_YOUNGSTER_JIMMY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I can run like the"
	line "wind!"
	done

.BeatenText:
	text "Blown away!"
	done

.AfterText:
	text "I wear shorts the"
	line "whole year round."

	para "That's my fashion"
	line "policy."
	done

TrainerYoungsterWarren:
	trainer YOUNGSTER, WARREN, EVENT_BEAT_YOUNGSTER_WARREN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Hmmm… I don't know"
	line "what to do…"
	done

.BeatenText:
	text "I knew I'd lose…"
	done

.AfterText:
	text "You looked strong."

	para "I was afraid to"
	line "take you on…"
	done

TrainerFirebreatherOtis:
	trainer FIREBREATHER, OTIS, EVENT_BEAT_FIREBREATHER_OTIS, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Ah! The weather's"
	line "as fine as ever."
	done

.BeatenText:
	text "It's sunny, but"
	line "I'm all wet…"
	done

.AfterText:
	text "When it rains,"
	line "it's hard to get"
	cont "ignition…"
	done

TrainerFirebreatherBurt:
	trainer FIREBREATHER, BURT, EVENT_BEAT_FIREBREATHER_BURT, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Step right up and"
	line "take a look!"
	done

.BeatenText:
	text "Yow! That's hot!"
	done

.AfterText:
	text "The greatest fire-"
	line "breather in Kanto,"
	cont "that's me."

	para "But not the best"
	line "trainer…"
	done

TrainerBlackbeltManford:
	trainer BLACKBELT_T, MANFORD, EVENT_BEAT_BLACKBELT_MANFORD, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Slow down and give"
	line "me the chance to"
	cont "defeat you!"
	done

.BeatenText:
	text "I've been beaten"
	line "at my own game…"
	done

.AfterText:
	text "You must have"
	line "trained under a"
	cont "well-known master!"
	done

TrainerBlackbeltAnder:
	trainer BLACKBELT_T, ANDER, EVENT_BEAT_BLACKBELT_ANDER, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Wait a moment!"
	line "Come fight me!"
	done

.BeatenText:
	text "You did it…"
	done

.AfterText:
	text "You came all the"
	line "way from Johto?"

	para "You must be very"
	line "persistent!"
	done

TrainerHikerBruce:
	trainer HIKER, BRUCE, EVENT_BEAT_HIKER_BRUCE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "My Bag is digging"
	line "into my shoulders!"

	para "I'll take a break"
	line "and have a battle!"
	done

.BeatenText:
	text "Feh."
	done

.AfterText:
	text "All right, guess I"
	line "should carry my"
	cont "Bag again!"
	done

TrainerHikerDwight:
	trainer HIKER, DWIGHT, EVENT_BEAT_HIKER_DWIGHT, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Peace!"

	para "When you meet the"
	line "unknown on a moun-"
	cont "tain road, all you"

	para "want is peace,"
	line "right?"
	done

.BeatenText:
	text "Peace--even though"
	line "I lost!"
	done

.AfterText:
	text "Greeting someone"
	line "you don't know…"

	para "That's the best"
	line "thing about moun-"
	cont "tains!"
	done

TrainerAceDuoZacandjen1:
	trainer ACE_DUO, ZACANDJEN1, EVENT_BEAT_ACE_DUO_ZAC_AND_JEN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Zac: Really, you"
	line "want to battle us?"

	para "You've got a lot"
	line "of courage for"
	cont "someone so young."
	done

.BeatenText:
	text "Zac: You weren't"
	line "bluffing…"
	done

.AfterText:
	text "Zac: Your future"
	line "looks promising."
	done

TrainerAceDuoZacandjen2:
	trainer ACE_DUO, ZACANDJEN2, EVENT_BEAT_ACE_DUO_ZAC_AND_JEN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Jen: Huh? You'd"
	line "like to go up"
	cont "against us? Great!"
	done

.BeatenText:
	text "Jen: You're so"
	line "much stronger than"
	cont "I thought."
	done

.AfterText:
	text "Jen: I'm looking"
	line "forward to seeing"

	para "what kind of"
	line "trainer you'll"
	cont "become."
	done

Route3MeteoriteText:
	text "Never seen a stone"
	line "like this before!"

	para "Could it be…"
	line "a meteorite from"
	cont "space?"
	done

UnknownText_0x1ae163:
	text "Mt.Moon Tunnel"
	done
