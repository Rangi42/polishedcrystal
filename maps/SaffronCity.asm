SaffronCity_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, SaffronCityFlyPoint

	db 20 ; warp events
	warp_event 26,  3, FIGHTING_DOJO, 1
	warp_event 34,  3, SAFFRON_GYM, 1
	warp_event 25, 11, SAFFRON_MART, 2
	warp_event  9, 29, SAFFRON_POKECENTER_1F, 1
	warp_event 27, 29, MR_PSYCHICS_HOUSE, 1
	warp_event  8,  3, SAFFRON_TRAIN_STATION, 2
	warp_event 18, 21, SILPH_CO_1F, 1
	warp_event  9, 11, COPYCATS_HOUSE_1F, 1
	warp_event 18,  1, ROUTE_5_SAFFRON_CITY_GATE, 3
	warp_event  0, 18, ROUTE_7_SAFFRON_GATE, 3
	warp_event  0, 19, ROUTE_7_SAFFRON_GATE, 4
	warp_event 16, 35, ROUTE_6_SAFFRON_GATE, 1
	warp_event 17, 35, ROUTE_6_SAFFRON_GATE, 2
	warp_event 39, 18, ROUTE_8_SAFFRON_GATE, 1
	warp_event 39, 19, ROUTE_8_SAFFRON_GATE, 2
	warp_event 34, 11, POKEMON_TRAINER_FAN_CLUB, 1
	warp_event  5, 29, SAFFRON_ORRE_SPEECH_HOUSE, 1
	warp_event 13, 29, SAFFRON_BOOK_SPEECH_HOUSE, 1
	warp_event 21, 29, SAFFRON_HITMONTOP_KID_HOUSE, 1
	warp_event 13, 11, SAFFRON_RICH_SPEECH_HOUSE, 1

	db 0 ; coord events

	db 9 ; bg events
	bg_event 21,  5, SIGNPOST_JUMPTEXT, SaffronCitySignText
	bg_event 33,  5, SIGNPOST_JUMPTEXT, SaffronGymSignText
	bg_event 25,  5, SIGNPOST_JUMPTEXT, FightingDojoSignText
	bg_event 15, 21, SIGNPOST_JUMPTEXT, SilphCoSignText
	bg_event 25, 29, SIGNPOST_JUMPTEXT, MrPsychicsHouseSignText
	bg_event 11,  5, SIGNPOST_JUMPTEXT, SaffronCityMagnetTrainStationSignText
	bg_event 32, 12, SIGNPOST_JUMPTEXT, PokemonTrainerFanClubSignText
	bg_event  5, 21, SIGNPOST_JUMPTEXT, SaffronTrainerTips1Text
	bg_event 35, 21, SIGNPOST_JUMPTEXT, SaffronTrainerTips2Text

	db 13 ; object events
	object_event  7, 14, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, LassScript_0x19932a, -1
	object_event 18, 30, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x19933e, -1
	object_event 32,  7, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1994fe, -1
	object_event 20, 24, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x19958e, -1
	object_event 27, 12, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, FisherScript_0x199358, -1
	object_event 15, 19, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1996a5, -1
	object_event 35, 22, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1996e5, -1
	object_event 14,  6, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x199745, -1
	object_event  3, 24, SPRITE_BLACK_BELT, SPRITEMOVEDATA_WALK_UP_DOWN, 4, 0, -1, (1 << MORN), PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronCityBlackBelt1Text, -1
	object_event  4, 25, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, (1 << DAY) | (1 << NITE), PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronCityBlackBelt2Text, -1
	object_event 22,  8, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_SLOW, 4, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronCitySuperNerdText, -1
	object_event 23, 22, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 4, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronCityScientistText, -1
	object_event 11, 22, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 4, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronCitySilphEmployeeText, -1

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

SaffronTrainerTips1Text:
	text "Trainer Tips"

	para "New SilphScope2"
	line "identifies even"

	para "the most well-"
	line "disguised #mon!"
	done

SaffronTrainerTips2Text:
	text "Trainer Tips"

	para "Use Quick Balls"
	line "early during a"
	cont "battle. Later,"
	cont "use Timer Balls."

	para "They cost more"
	line "than # Balls,"

	para "but they're more"
	line "convenient."
	done
