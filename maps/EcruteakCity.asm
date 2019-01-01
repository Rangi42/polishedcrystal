EcruteakCity_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, EcruteakCityFlyPoint

	db 17 ; warp events
	warp_event 35, 26, ROUTE_42_ECRUTEAK_GATE, 1
	warp_event 35, 27, ROUTE_42_ECRUTEAK_GATE, 2
	warp_event 23, 11, ECRUTEAK_HOUSE, 1
	warp_event 17, 11, ECRUTEAK_SHRINE_OUTSIDE, 3
	warp_event 18, 11, ECRUTEAK_SHRINE_OUTSIDE, 4
	warp_event 23, 27, ECRUTEAK_POKECENTER_1F, 1
	warp_event  5, 21, ECRUTEAK_LUGIA_SPEECH_HOUSE, 1
	warp_event 23, 21, DANCE_THEATRE, 1
	warp_event 29, 21, ECRUTEAK_MART, 2
	warp_event  6, 27, ECRUTEAK_GYM, 1
	warp_event 13, 27, ECRUTEAK_ITEMFINDER_HOUSE, 1
	warp_event  5, 17, VALERIES_HOUSE, 1
	warp_event  5,  5, BURNED_TOWER_1F, 1
	warp_event  0, 18, ROUTE_38_ECRUTEAK_GATE, 3
	warp_event  0, 19, ROUTE_38_ECRUTEAK_GATE, 4
	warp_event 29, 27, ECRUTEAK_CHERISH_BALL_HOUSE, 1
	warp_event 13, 17, ECRUTEAK_DESTINY_KNOT_HOUSE, 1

	db 0 ; coord events

	db 7 ; bg events
	bg_event 15, 21, SIGNPOST_JUMPTEXT, EcruteakCitySignText
	bg_event  8, 28, SIGNPOST_JUMPTEXT, EcruteakGymSignText
	bg_event 21, 21, SIGNPOST_JUMPTEXT, EcruteakDanceTheaterSignText
	bg_event  2, 10, SIGNPOST_JUMPTEXT, BurnedTowerSignText
	bg_event 25, 14, SIGNPOST_ITEM + HYPER_POTION, EVENT_ECRUTEAK_CITY_HIDDEN_HYPER_POTION
	bg_event 15, 11, SIGNPOST_JUMPTEXT, EcruteakShrineSignText
	bg_event 21, 11, SIGNPOST_JUMPTEXT, EcruteakBarrierStationSignText

	db 14 ; object events
	object_event 20, 15, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a4105, -1
	object_event 20, 21, SPRITE_GRAMPS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a4147, -1
	object_event 19, 26, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a41db, -1
	object_event  3,  9, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LassScript_0x1a4015, -1
	object_event  9, 22, SPRITE_FISHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, FisherScript_0x1a4029, -1
	object_event 11, 16, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a4386, -1
	object_event  3,  7, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a43cb, EVENT_ECRUTEAK_CITY_GRAMPS
	object_event 11, 11, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << NITE), PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, EcruteakCityHexManiacText, -1
	object_event 11, 11, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, EcruteakCitySightseerMText, -1
	object_event 12, 11, SPRITE_SMEARGLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_BROWN, PERSONTYPE_POKEMON, SMEARGLE, EcruteakCitySmeargleText, -1
	object_event 15,  9, SPRITE_MISC_OVERHEAD, SPRITEMOVEDATA_ARCH_TREE_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 16,  9, SPRITE_MISC_OVERHEAD, SPRITEMOVEDATA_ARCH_TREE_DOWN, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 19,  9, SPRITE_MISC_OVERHEAD, SPRITEMOVEDATA_ARCH_TREE_UP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event 20,  9, SPRITE_MISC_OVERHEAD, SPRITEMOVEDATA_ARCH_TREE_RIGHT, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1

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

	para "“Life is a lamp-"
	line "flame before a"
	cont "wind.”"
	done

EcruteakBarrierStationSignText:
	text "Barrier Station"
	line "to Bell Tower"

	para "No Trespassing by"
	line "the Unworthy"
	done
