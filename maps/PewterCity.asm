PewterCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, PewterCityFlyPoint

PewterCity_MapEventHeader:

.Warps: db 7
	warp_def 13, 29, 1, PEWTER_NIDORAN_SPEECH_HOUSE
	warp_def 17, 16, 1, PEWTER_GYM
	warp_def 17, 23, 2, PEWTER_MART
	warp_def 25, 13, 1, PEWTER_POKECENTER_1F
	warp_def 29, 7, 1, PEWTER_SNOOZE_SPEECH_HOUSE
	warp_def 7, 14, 1, PEWTER_MUSEUM_OF_SCIENCE_1F
	warp_def 5, 19, 3, PEWTER_MUSEUM_OF_SCIENCE_1F

.XYTriggers: db 0

.Signposts: db 5
	signpost 23, 25, SIGNPOST_JUMPTEXT, PewterCitySignText
	signpost 17, 11, SIGNPOST_JUMPTEXT, PewterGymSignText
	signpost 9, 15, SIGNPOST_JUMPTEXT, PewterMuseumOfScienceSignText
	signpost 19, 33, SIGNPOST_JUMPTEXT, PewterCityMtMoonGiftShopSignText
	signpost 29, 19, SIGNPOST_JUMPTEXT, PewterCityWelcomeSignText

.PersonEvents: db 7
	person_event SPRITE_COOLTRAINER_F, 11, 22, SPRITEMOVEDATA_STANDING_DOWN, 2, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18c042, -1
	person_event SPRITE_COOLTRAINER_M, 10, 19, SPRITEMOVEDATA_SPINRANDOM_SLOW, 2, 2, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, PewterCityCooltrainermText, -1
	person_event SPRITE_CHILD, 29, 14, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18c080, -1
	person_event SPRITE_GRAMPS, 17, 29, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GrampsScript_0x18c00f, -1
	person_event SPRITE_YOUNGSTER, 17, 7, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, PewterCityYoungsterScript, -1
	fruittree_event 3, 32, FRUITTREE_PEWTER_CITY_1, PETAYA_BERRY
	fruittree_event 3, 30, FRUITTREE_PEWTER_CITY_2, APICOT_BERRY

PewterCityFlyPoint:
	setflag ENGINE_FLYPOINT_PEWTER
	return

GrampsScript_0x18c00f:
	checkevent EVENT_GOT_OLD_AMBER
	iftrue_jumptextfaceplayer UnknownText_0x18c1aa
	faceplayer
	opentext
	writetext UnknownText_0x18c0c6
	buttonsound
	verbosegiveitem OLD_AMBER
	iffalse_endtext
	setevent EVENT_GOT_OLD_AMBER
	endtext

PewterCityYoungsterScript:
	faceplayer
	opentext
	writetext PewterCityYoungsterText1
	waitbutton
	checkflag ENGINE_BOULDERBADGE
	iffalse_endtext
	jumpopenedtext PewterCityYoungsterText2

UnknownText_0x18c042:
	text "#mon can only"
	line "be two types at"
	cont "once, but if it"
	cont "were possible for"

	para "a #mon to be"
	line "every type, it"
	cont "would only have"
	cont "one weakness."

	para "What weakness,"
	line "you ask?"

	para "Rock-type attacks,"
	line "of course!"
	done

PewterCityCooltrainermText:
	text "This gal thinks"
	line "Rock-type Pokemon"
	cont "are all that,"

	para "but it's tied for"
	line "the most weakness-"
	cont "es of any type."

	para "I don't have the"
	line "heart to tell her,"
	cont "though."
	done

UnknownText_0x18c080:
	text "At night, Clefairy"
	line "come out to play"
	cont "at Mt.Moon."

	para "But not every"
	line "night."
	done

UnknownText_0x18c0c6:
	text "Ah, you came all"
	line "the way out here"
	cont "from Johto?"

	para "That brings back"
	line "memories. When I"

	para "was young, I went"
	line "to Johto to train."

	para "You remind me so"
	line "much of what I was"

	para "like as a young"
	line "man."

	para "Here. I want you"
	line "to have this item"
	cont "I found in Johto."
	done

UnknownText_0x18c1aa:
	text "Going to new, un-"
	line "known places and"
	cont "seeing new people…"

	para "Those are the joys"
	line "of travel."
	done

PewterCityYoungsterText1:
	text "The Pewter Gym is"
	line "as rough and tough"
	cont "as rock itself."

	para "Be careful in"
	line "there."
	done

PewterCityYoungsterText2:
	text "You beat the Gym?"
	line "Then you're tough"
	cont "as rock too!"
	done

PewterCitySignText:
	text "Pewter City"
	line "A Stone Gray City"
	done

PewterGymSignText:
	text "Pewter City"
	line "#mon Gym"
	cont "Leader: Brock"

	para "The Rock Solid"
	line "#mon Trainer"
	done

PewterMuseumOfScienceSignText:
	text "Pewter Museum of"
	line "Science"
	done

PewterCityMtMoonGiftShopSignText:
	text "There's a notice"
	line "here…"

	para "Mt.Moon Gift Shop"
	line "Now open!"
	done

PewterCityWelcomeSignText:
	text "Welcome to"
	line "Pewter City!"
	done
