EcruteakCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, EcruteakCityFlyPoint

EcruteakCity_MapEventHeader:

.Warps: db 17
	warp_def 26, 35, 1, ROUTE_42_ECRUTEAK_GATE
	warp_def 27, 35, 2, ROUTE_42_ECRUTEAK_GATE
	warp_def 11, 23, 1, ECRUTEAK_HOUSE
	warp_def 11, 17, 3, ECRUTEAK_SHRINE_OUTSIDE
	warp_def 11, 18, 4, ECRUTEAK_SHRINE_OUTSIDE
	warp_def 27, 23, 1, ECRUTEAK_POKECENTER_1F
	warp_def 21, 5, 1, ECRUTEAK_LUGIA_SPEECH_HOUSE
	warp_def 21, 23, 1, DANCE_THEATRE
	warp_def 21, 29, 2, ECRUTEAK_MART
	warp_def 27, 6, 1, ECRUTEAK_GYM
	warp_def 27, 13, 1, ECRUTEAK_ITEMFINDER_HOUSE
	warp_def 17, 5, 1, VALERIES_HOUSE
	warp_def 5, 5, 1, BURNED_TOWER_1F
	warp_def 18, 0, 3, ROUTE_38_ECRUTEAK_GATE
	warp_def 19, 0, 4, ROUTE_38_ECRUTEAK_GATE
	warp_def 27, 29, 1, ECRUTEAK_CHERISH_BALL_HOUSE
	warp_def 17, 13, 1, ECRUTEAK_DESTINY_KNOT_HOUSE

.XYTriggers: db 0

.Signposts: db 6
	signpost 21, 15, SIGNPOST_JUMPTEXT, EcruteakCitySignText
	signpost 28, 8, SIGNPOST_JUMPTEXT, EcruteakGymSignText
	signpost 21, 21, SIGNPOST_JUMPTEXT, EcruteakDanceTheaterSignText
	signpost 10, 2, SIGNPOST_JUMPTEXT, BurnedTowerSignText
	signpost 14, 25, SIGNPOST_ITEM + HYPER_POTION, EVENT_ECRUTEAK_CITY_HIDDEN_HYPER_POTION
	signpost 11, 20, SIGNPOST_JUMPTEXT, EcruteakShrineSignText

.PersonEvents: db 10
	person_event SPRITE_GRAMPS, 15, 20, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a4105, -1
	person_event SPRITE_GRAMPS, 21, 20, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a4147, -1
	person_event SPRITE_LASS, 26, 19, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a41db, -1
	person_event SPRITE_LASS, 9, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LassScript_0x1a4015, -1
	person_event SPRITE_FISHER, 22, 9, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, FisherScript_0x1a4029, -1
	person_event SPRITE_YOUNGSTER, 16, 11, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a4386, -1
	person_event SPRITE_GRAMPS, 7, 3, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a43cb, EVENT_ECRUTEAK_CITY_GRAMPS
	person_event SPRITE_HEX_MANIAC, 11, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << NITE), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, EcruteakCityHexManiacText, -1
	person_event SPRITE_SIGHTSEER_M, 15, 25, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, EcruteakCitySightseerMText, -1
	person_event SPRITE_SMEARGLE, 15, 24, SPRITEMOVEDATA_POKEMON, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_POKEMON, SMEARGLE, EcruteakCitySmeargleText, -1

EcruteakCityFlyPoint:
	setflag ENGINE_FLYPOINT_ECRUTEAK
	return

LassScript_0x1a4015:
	checkevent EVENT_RELEASED_THE_BEASTS
	iftrue_jumptextfaceplayer UnknownText_0x1a4269
	jumptextfaceplayer UnknownText_0x1a421a

FisherScript_0x1a4029:
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue_jumptextfaceplayer UnknownText_0x1a4325
	jumptextfaceplayer UnknownText_0x1a42ac

UnknownText_0x1a4105:
	text "Ecruteak used to"
	line "have two towers:"

	para "one each in the"
	line "east and west."
	done

UnknownText_0x1a4147:
	text "Ah, child."
	line "Have you learned"

	para "to dance like the"
	line "Kimono Girls?"

	para "If you go to their"
	line "Dance Theater, an"

	para "odd old man will"
	line "give you something"
	cont "nice, I hear."
	done

UnknownText_0x1a41db:
	text "I'm going to get"
	line "my #mon blessed"

	para "at the shrine."
	line "Care to join me?"
	done

EcruteakCityHexManiacText:
	text "Spirits of #mon"
	line "haunt this place…"
	done

EcruteakCitySightseerMText:
	text "Ecruteak has such"
	line "an incredible"
	cont "history."

	para "Smeargle and I"
	line "traveled here to"
	cont "draw it."
	done

EcruteakCitySmeargleText:
	text "Smeargle: Smeer!"
	done

UnknownText_0x1a421a:
	text "The tower that"
	line "used to be here…"

	para "My grandma told me"
	line "it used to be much"
	cont "taller."
	done

UnknownText_0x1a4269:
	text "Three big #mon"
	line "ran off in differ-"
	cont "ent directions."
	cont "What were they?"
	done

UnknownText_0x1a42ac:
	text "I heard a rumor"
	line "about Olivine"
	cont "Lighthouse."

	para "The #mon that"
	line "serves as the"

	para "beacon fell ill."
	line "Sounds like they"
	cont "are in trouble."
	done

UnknownText_0x1a4325:
	text "The #mon at"
	line "Olivine Lighthouse"
	cont "has been cured."

	para "Boats can safely"
	line "sail out to sea at"
	cont "night again."
	done

UnknownText_0x1a4386:
	text "I hear #mon are"
	line "rampaging at the"

	para "Lake of Rage. I'd"
	line "like to see that."
	done

UnknownText_0x1a43cb:
	text "In the distant"
	line "past…"

	para "This tower burned"
	line "in a fire. Three"

	para "nameless #mon"
	line "perished in it."

	para "A rainbow-colored"
	line "#mon descended"

	para "from the sky and"
	line "resurrected them…"

	para "It's a legend that"
	line "has been passed"

	para "down by Ecruteak"
	line "Gym Leaders."

	para "Me?"

	para "I was a trainer"
	line "way back when."
	cont "Hohoho!"
	done

EcruteakCitySignText:
	text "Ecruteak City"
	line "A Historical City"

	para "Where the Past"
	line "Meets the Present"
	done

EcruteakGymSignText:
	text "Ecruteak City"
	line "#mon Gym"
	cont "Leader: Morty"

	para "The Mystic Seer of"
	line "the Future"
	done

EcruteakDanceTheaterSignText:
	text "Ecruteak Dance"
	line "Theater"
	done

BurnedTowerSignText:
	text "Burned Tower"

	para "It was destroyed"
	line "by a mysterious"
	cont "fire."

	para "Please stay away,"
	line "as it is unsafe."
	done

EcruteakShrineSignText:
	text "Ecruteak Shrine"
	done
