SaffronCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, SaffronCityFlyPoint

SaffronCity_MapEventHeader:

.Warps: db 20
	warp_def 3, 26, 1, FIGHTING_DOJO
	warp_def 3, 34, 1, SAFFRON_GYM
	warp_def 11, 25, 2, SAFFRON_MART
	warp_def 29, 9, 1, SAFFRON_POKECENTER_1F
	warp_def 29, 27, 1, MR_PSYCHICS_HOUSE
	warp_def 3, 8, 2, SAFFRON_TRAIN_STATION
	warp_def 21, 18, 1, SILPH_CO_1F
	warp_def 11, 9, 1, COPYCATS_HOUSE_1F
	warp_def 1, 18, 3, ROUTE_5_SAFFRON_CITY_GATE
	warp_def 18, 0, 3, ROUTE_7_SAFFRON_GATE
	warp_def 19, 0, 4, ROUTE_7_SAFFRON_GATE
	warp_def 35, 16, 1, ROUTE_6_SAFFRON_GATE
	warp_def 35, 17, 2, ROUTE_6_SAFFRON_GATE
	warp_def 18, 39, 1, ROUTE_8_SAFFRON_GATE
	warp_def 19, 39, 2, ROUTE_8_SAFFRON_GATE
	warp_def 11, 34, 1, POKEMON_TRAINER_FAN_CLUB
	warp_def 29, 5, 1, SAFFRON_ORRE_SPEECH_HOUSE
	warp_def 29, 13, 1, SAFFRON_BOOK_SPEECH_HOUSE
	warp_def 29, 21, 1, SAFFRON_HITMONTOP_KID_HOUSE
	warp_def 11, 13, 1, SAFFRON_RICH_SPEECH_HOUSE

.XYTriggers: db 0

.Signposts: db 7
	signpost 5, 21, SIGNPOST_JUMPTEXT, SaffronCitySignText
	signpost 5, 33, SIGNPOST_JUMPTEXT, SaffronGymSignText
	signpost 5, 25, SIGNPOST_JUMPTEXT, FightingDojoSignText
	signpost 21, 15, SIGNPOST_JUMPTEXT, SilphCoSignText
	signpost 29, 25, SIGNPOST_JUMPTEXT, MrPsychicsHouseSignText
	signpost 5, 11, SIGNPOST_JUMPTEXT, SaffronCityMagnetTrainStationSignText
	signpost 12, 32, SIGNPOST_JUMPTEXT, PokemonTrainerFanClubSignText

.PersonEvents: db 13
	person_event SPRITE_LASS, 14, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LassScript_0x19932a, -1
	person_event SPRITE_POKEFAN_M, 30, 18, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x19933e, -1
	person_event SPRITE_COOLTRAINER_M, 7, 32, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1994fe, -1
	person_event SPRITE_COOLTRAINER_F, 24, 20, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19958e, -1
	person_event SPRITE_FISHER, 12, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, FisherScript_0x199358, -1
	person_event SPRITE_YOUNGSTER, 19, 15, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1996a5, -1
	person_event SPRITE_YOUNGSTER, 22, 35, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1996e5, -1
	person_event SPRITE_LASS, 6, 14, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x199745, -1
	person_event SPRITE_BLACK_BELT, 24, 3, SPRITEMOVEDATA_WALK_UP_DOWN, 4, 0, -1, (1 << MORN), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronCityBlackBelt1Text, -1
	person_event SPRITE_BLACK_BELT, 25, 4, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, (1 << DAY) | (1 << NITE), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronCityBlackBelt2Text, -1
	person_event SPRITE_SUPER_NERD, 8, 22, SPRITEMOVEDATA_SPINRANDOM_SLOW, 4, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronCitySuperNerdText, -1
	person_event SPRITE_SCIENTIST, 22, 23, SPRITEMOVEDATA_STANDING_DOWN, 4, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronCityScientistText, -1
	person_event SPRITE_SILPH_EMPLOYEE, 22, 11, SPRITEMOVEDATA_SPINRANDOM_SLOW, 4, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronCitySilphEmployeeText, -1

SaffronCityFlyPoint:
	setflag ENGINE_FLYPOINT_SAFFRON
	return

LassScript_0x19932a:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x19940d
	jumptextfaceplayer UnknownText_0x19938d

PokefanMScript_0x19933e:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x1994ae
	jumptextfaceplayer UnknownText_0x199460

FisherScript_0x199358:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x19964b
	jumptextfaceplayer UnknownText_0x1995fc

UnknownText_0x19938d:
	text "A little girl who"
	line "is an expert at"

	para "mimicking people"
	line "lives here."

	para "She even mimics"
	line "the people she's"

	para "conversing with."
	line "It's confusing."
	done

UnknownText_0x19940d:
	text "The Copycat girl"
	line "looked unhappy."

	para "She said she lost"
	line "her favorite #"
	cont "Doll--Clefairy."
	done

UnknownText_0x199460:
	text "You came out from"
	line "Johto?"

	para "You can zip back"
	line "home if the Magnet"
	cont "Train's running."
	done

UnknownText_0x1994ae:
	text "You came out from"
	line "Johto?"

	para "You can zip back"
	line "home by hopping on"
	cont "the Magnet Train."
	done

UnknownText_0x1994fe:
	text "I went to the Gym,"
	line "raring for battles"
	cont "against trainers…"

	para "It turns out, I"
	line "stumbled into the"

	para "Fighting Dojo"
	line "next door."

	para "Boy, I was pretty"
	line "embarrassed."
	done

UnknownText_0x19958e:
	text "This is Silph Co.,"
	line "famous for #mon"
	cont "merchandise."

	para "In the past, Team"
	line "Rocket wanted the"

	para "company because of"
	line "that."
	done

UnknownText_0x1995fc:
	text "Chew… Chew…"

	para "I hear there's big"
	line "trouble brewing at"
	cont "the Power Plant."

	para "Chew… Chew…"
	done

UnknownText_0x19964b:
	text "Chew… Chew…"

	para "I hear there was"
	line "big trouble at the"
	cont "Power Plant."

	para "Chew… Chew…"
	line "Haaah, I'm full!"
	done

UnknownText_0x1996a5:
	text "Going into an"
	line "alley for the"

	para "first time makes"
	line "me sorta anxious."
	done

UnknownText_0x1996e5:
	text "There's a place"
	line "called Trainer"

	para "House in Viridian"
	line "where trainers"

	para "gather from all"
	line "over the place."
	done

UnknownText_0x199745:
	text "Our city was"
	line "featured on a"
	cont "radio program."

	para "It's nice to hear"
	line "praise for your"

	para "city, but it's a"
	line "bit embarrassing"
	cont "too."
	done

SaffronCityBlackBelt1Text:
	text "Every morning when"
	line "I wake up I run"

	para "two laps around"
	line "the city."

	para "It's a great way"
	line "to start the day!"
	done

SaffronCityBlackBelt2Text:
	text "If I was an item,"
	line "I'd be X Attack."

	para "I'm just brimming"
	line "with power, and"

	para "the X makes it"
	line "sound cool."
	done

SaffronCitySuperNerdText:
	text "There was a time"
	line "when Psychic-type"

	para "#mon were be-"
	line "lieved to be the"

	para "strongest, and Bug"
	line "types the weakest."

	para "The irony is, Bug"
	line "is super-effective"
	cont "against Psychic!"
	done

SaffronCityScientistText:
	text "The original Silph"
	line "Scope had some"
	cont "bugs, so we've been"

	para "working tirelessly"
	line "on its successor--"
	cont "the SilphScope2!"
	done

SaffronCitySilphEmployeeText:
	text "Silph is named"
	line "after a mythical"
	cont "spirit of the air."

	para "What that has to"
	line "do with the com-"

	para "pany's business,"
	line "I have no idea."
	done

SaffronCitySignText:
	text "Saffron City"

	para "Shining, Golden"
	line "Land of Commerce"
	done

SaffronGymSignText:
	text "Saffron City"
	line "#mon Gym"
	cont "Leader: Sabrina"

	para "The Master of"
	line "Psychic #mon!"
	done

FightingDojoSignText:
	text "Everyone Welcome!"
	line "Fighting Dojo"
	done

SilphCoSignText:
	text "Silph Co."
	line "Office Building"
	done

MrPsychicsHouseSignText:
	text "Mr.Psychic's"
	line "House"
	done

SaffronCityMagnetTrainStationSignText:
	text "Saffron City"
	line "Magnet Train"
	cont "Station"
	done

PokemonTrainerFanClubSignText:
	text "#mon Trainer"
	line "Fan Club"

	para "Many trainers have"
	line "scribbled their"
	cont "names here…"
	done
