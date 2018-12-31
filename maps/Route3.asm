Route3_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, Route3FlyPoint

Route3_MapEventHeader:

.Warps: db 2
	warp_def 1, 68, 1, MOUNT_MOON_1F
	warp_def 3, 61, 1, ROUTE_3_POKECENTER_1F

.XYTriggers: db 0

.Signposts: db 8
	signpost 15, 63, SIGNPOST_JUMPTEXT, UnknownText_0x1ae163
	signpost 17, 11, SIGNPOST_ITEM + MOON_STONE, EVENT_ROUTE_3_HIDDEN_MOON_STONE
	signpost 15, 8, SIGNPOST_JUMPTEXT, Route3MeteoriteText
	signpost 17, 8, SIGNPOST_JUMPTEXT, Route3MeteoriteText
	signpost 17, 9, SIGNPOST_JUMPTEXT, Route3MeteoriteText
	signpost 15, 14, SIGNPOST_JUMPTEXT, Route3MeteoriteText
	signpost 16, 15, SIGNPOST_JUMPTEXT, Route3MeteoriteText
	signpost 17, 15, SIGNPOST_JUMPTEXT, Route3MeteoriteText

.PersonEvents: db 12
	person_event SPRITE_YOUNGSTER, 7, 12, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterRegis, -1
	person_event SPRITE_YOUNGSTER, 3, 17, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerYoungsterJimmy, -1
	person_event SPRITE_YOUNGSTER, 3, 25, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerYoungsterWarren, -1
	person_event SPRITE_FISHER, 12, 30, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerFirebreatherOtis, -1
	person_event SPRITE_FISHER, 10, 60, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerFirebreatherBurt, -1
	person_event SPRITE_BLACK_BELT, 8, 44, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerBlackbeltManford, -1
	person_event SPRITE_BLACK_BELT, 18, 52, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerBlackbeltAnder, -1
	person_event SPRITE_POKEFAN_M, 6, 38, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerHikerBruce, -1
	person_event SPRITE_POKEFAN_M, 19, 61, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 5, TrainerHikerDwight, -1
	person_event SPRITE_COOLTRAINER_M, 12, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoZacandjen1, -1
	person_event SPRITE_COOLTRAINER_F, 12, 15, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoZacandjen2, -1
	itemball_event 14, 36, BIG_ROOT, 1, EVENT_ROUTE_3_BIG_ROOT

Route3FlyPoint:
	setflag ENGINE_FLYPOINT_MT_MOON
	return

TrainerYoungsterRegis:
	trainer EVENT_BEAT_YOUNGSTER_REGIS, YOUNGSTER, REGIS, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_YOUNGSTER_JIMMY, YOUNGSTER, JIMMY, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_YOUNGSTER_WARREN, YOUNGSTER, WARREN, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_FIREBREATHER_OTIS, FIREBREATHER, OTIS, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_FIREBREATHER_BURT, FIREBREATHER, BURT, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_BLACKBELT_MANFORD, BLACKBELT_T, MANFORD, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_BLACKBELT_ANDER, BLACKBELT_T, ANDER, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_HIKER_BRUCE, HIKER, BRUCE, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_HIKER_DWIGHT, HIKER, DWIGHT, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_ACE_DUO_ZAC_AND_JEN, ACE_DUO, ZACANDJEN1, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_ACE_DUO_ZAC_AND_JEN, ACE_DUO, ZACANDJEN2, .SeenText, .BeatenText, 0, .Script

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
