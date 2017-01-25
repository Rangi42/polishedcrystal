const_value set 2
	const ECRUTEAKCITY_GRAMPS1
	const ECRUTEAKCITY_GRAMPS2
	const ECRUTEAKCITY_LASS1
	const ECRUTEAKCITY_LASS2
	const ECRUTEAKCITY_FISHER
	const ECRUTEAKCITY_YOUNGSTER
	const ECRUTEAKCITY_GRAMPS3
	const ECRUTEAKCITY_HEX_MANIAC
	const ECRUTEAKCITY_SIGHTSEER
	const ECRUTEAKCITY_SMEARGLE

EcruteakCity_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks
	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_ECRUTEAK
	return

GrampsScript_0x1a4009:
	jumptextfaceplayer UnknownText_0x1a4105

GrampsScript_0x1a400c:
	jumptextfaceplayer UnknownText_0x1a4147

GrampsScript_0x1a400f:
	jumptextfaceplayer UnknownText_0x1a43cb

LassScript_0x1a4012:
	jumptextfaceplayer UnknownText_0x1a41db

EcruteakCityHexManiacScript:
	jumptextfaceplayer EcruteakCityHexManiacText

EcruteakCitySightseerScript:
	jumptextfaceplayer EcruteakCitySightseerText

EcruteakCitySmeargleScript:
	faceplayer
	opentext
	writetext EcruteakCitySmeargleText
	cry SMEARGLE
	waitbutton
	closetext
	end

LassScript_0x1a4015:
	faceplayer
	opentext
	checkevent EVENT_RELEASED_THE_BEASTS
	iftrue UnknownScript_0x1a4023
	writetext UnknownText_0x1a421a
	waitbutton
	closetext
	end

UnknownScript_0x1a4023:
	writetext UnknownText_0x1a4269
	waitbutton
	closetext
	end

FisherScript_0x1a4029:
	faceplayer
	opentext
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue UnknownScript_0x1a4037
	writetext UnknownText_0x1a42ac
	waitbutton
	closetext
	end

UnknownScript_0x1a4037:
	writetext UnknownText_0x1a4325
	waitbutton
	closetext
	end

YoungsterScript_0x1a403d:
	jumptextfaceplayer UnknownText_0x1a4386

EcruteakCitySign:
	jumptext EcruteakCitySignText

EcruteakGymSign:
	jumptext EcruteakGymSignText

EcruteakDanceTheaterSign:
	jumptext EcruteakDanceTheaterSignText

BurnedTowerSign:
	jumptext BurnedTowerSignText

EcruteakShrineSign:
	jumptext EcruteakShrineSignText

EcruteakCityPokeCenterSign:
	jumpstd pokecentersign

EcruteakCityMartSign:
	jumpstd martsign

EcruteakCityHiddenHyperPotion:
	dwb EVENT_ECRUTEAK_CITY_HIDDEN_HYPER_POTION, HYPER_POTION

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

EcruteakCitySightseerText:
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

EcruteakCity_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 17
	warp_def $1a, $23, 1, ROUTE_42_ECRUTEAK_GATE
	warp_def $1b, $23, 2, ROUTE_42_ECRUTEAK_GATE
	warp_def $b, $15, 1, ECRUTEAK_HOUSE
	warp_def $b, $f, 3, ECRUTEAK_SHRINE_OUTSIDE
	warp_def $b, $10, 4, ECRUTEAK_SHRINE_OUTSIDE
	warp_def $1b, $17, 1, ECRUTEAK_POKECENTER_1F
	warp_def $15, $5, 1, ECRUTEAK_LUGIA_SPEECH_HOUSE
	warp_def $15, $17, 1, DANCE_THEATRE
	warp_def $15, $1d, 2, ECRUTEAK_MART
	warp_def $1b, $6, 1, ECRUTEAK_GYM
	warp_def $1b, $d, 1, ECRUTEAK_ITEMFINDER_HOUSE
	warp_def $11, $5, 1, VALERIES_HOUSE
	warp_def $5, $5, 1, BURNED_TOWER_1F
	warp_def $12, $0, 3, ROUTE_38_ECRUTEAK_GATE
	warp_def $13, $0, 4, ROUTE_38_ECRUTEAK_GATE
	warp_def $1b, $1d, 1, ECRUTEAK_CHERISH_BALL_HOUSE
	warp_def $11, $d, 1, ECRUTEAK_DESTINY_KNOT_HOUSE

.XYTriggers:
	db 0

.Signposts:
	db 8
	signpost 21, 15, SIGNPOST_READ, EcruteakCitySign
	signpost 28, 8, SIGNPOST_READ, EcruteakGymSign
	signpost 21, 21, SIGNPOST_READ, EcruteakDanceTheaterSign
	signpost 10, 2, SIGNPOST_READ, BurnedTowerSign
	signpost 27, 24, SIGNPOST_READ, EcruteakCityPokeCenterSign
	signpost 21, 30, SIGNPOST_READ, EcruteakCityMartSign
	signpost 14, 25, SIGNPOST_ITEM, EcruteakCityHiddenHyperPotion
	signpost 11, 18, SIGNPOST_READ, EcruteakShrineSign

.PersonEvents:
	db 10
	person_event SPRITE_GRAMPS, 15, 18, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a4009, -1
	person_event SPRITE_GRAMPS, 21, 20, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a400c, -1
	person_event SPRITE_LASS, 26, 21, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, LassScript_0x1a4012, -1
	person_event SPRITE_LASS, 9, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LassScript_0x1a4015, -1
	person_event SPRITE_FISHER, 22, 9, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, FisherScript_0x1a4029, -1
	person_event SPRITE_YOUNGSTER, 14, 10, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x1a403d, -1
	person_event SPRITE_GRAMPS, 7, 3, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a400f, EVENT_ECRUTEAK_CITY_GRAMPS
	person_event SPRITE_HEX_MANIAC, 11, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << NITE), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, EcruteakCityHexManiacScript, -1
	person_event SPRITE_FISHING_GURU, 15, 24, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, EcruteakCitySightseerScript, -1
	person_event SPRITE_SMEARGLE, 15, 23, SPRITEMOVEDATA_POKEMON, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, EcruteakCitySmeargleScript, -1
