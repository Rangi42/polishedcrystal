const_value set 2
	const VIRIDIANCITY_GRAMPS1
	const VIRIDIANCITY_GRAMPS2
	const VIRIDIANCITY_GRAMPS3
	const VIRIDIANCITY_FISHER
	const VIRIDIANCITY_BUG_CATCHER
	const VIRIDIANCITY_YOUNGSTER
	const VIRIDIANCITY_CUT_TREE1
	const VIRIDIANCITY_CUT_TREE2

ViridianCity_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_VIRIDIAN
	return

GrampsScript_0x1a9a4c:
	faceplayer
	opentext
	writetext UnknownText_0x1a9aa5
	yesorno
	iffalse UnknownScript_0x1a9a5b
	writetext UnknownText_0x1a9b6f
	waitbutton
	closetext
	end

UnknownScript_0x1a9a5b:
	writetext UnknownText_0x1a9bb7
	waitbutton
	closetext
	end

GrampsScript_0x1a9a61:
	faceplayer
	opentext
	checkevent EVENT_BLUE_IN_CINNABAR
	iftrue .BlueReturned
	writetext UnknownText_0x1a9c11
	waitbutton
	closetext
	end

.BlueReturned:
	writetext UnknownText_0x1a9c7e
	waitbutton
	closetext
	end

FisherScript_0x1a9a75:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_DREAM_EATER_INTRO
	iftrue ViridianCityTutorDreamEaterScript
	writetext UnknownText_0x1a9cc4
	waitbutton
	setevent EVENT_LISTENED_TO_DREAM_EATER_INTRO
ViridianCityTutorDreamEaterScript:
	writetext Text_ViridianCityTutorDreamEater
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_ViridianCityTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte DREAM_EATER
	writetext Text_ViridianCityTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	writetext Text_ViridianCityTutorRefused
	waitbutton
	closetext
	end

.NoSilverLeaf
	writetext Text_ViridianCityTutorNoSilverLeaf
	waitbutton
	closetext
	end

.TeachMove
	takeitem SILVER_LEAF
	writetext Text_ViridianCityTutorTaught
	waitbutton
	closetext
	end

BugCatcherScript_0x1a9a90:
	jumptextfaceplayer UnknownText_0x1a9daa

ViridianCityYoungsterScript:
	jumptextfaceplayer ViridianCityYoungsterText

ViridianCityCutTree:
	jumpstd cuttree

ViridianCitySign:
	habitatlist ViridianCitySignText, VIRIDIAN_CITY

ViridianGymSign:
	jumptext ViridianGymSignText

ViridianCityWelcomeSign:
	jumptext ViridianCityWelcomeSignText

TrainerHouseSign:
	jumptext TrainerHouseSignText

UnknownText_0x1a9aa5:
	text "Hey, kid! I just"
	line "had a double shot"

	para "of espresso, and"
	line "I am wired!"

	para "I need to talk to"
	line "someone, so you'll"
	cont "have to do!"

	para "I might not look"
	line "like much now, but"

	para "I was an expert at"
	line "catching #mon."

	para "Do you believe me?"
	done

UnknownText_0x1a9b6f:
	text "Good, good. Yes, I"
	line "was something out"

	para "of the ordinary,"
	line "let me tell you!"
	done

UnknownText_0x1a9bb7:
	text "What? You little"
	line "whelp!"

	para "If I were just a"
	line "bit younger, I'd"

	para "show you a thing"
	line "or two. Humph!"
	done

UnknownText_0x1a9c11:
	text "This Gym didn't"
	line "have a Leader"
	cont "until recently."

	para "A young man from"
	line "Pallet became the"

	para "Leader, but he's"
	line "often away."
	done

UnknownText_0x1a9c7e:
	text "Are you going to"
	line "battle the Leader?"

	para "Good luck to you."
	line "You'll need it."
	done

UnknownText_0x1a9cc4:
	text "Yawn!"

	para "I must have dozed"
	line "off in the sun."

	para "…I had this dream"
	line "about a Drowzee"

	para "eating my dream."
	line "And…"

	para "I learned how to"
	line "eat dreams…"

	para "Ooh, this is too"
	line "spooky!"
	cont "But now…"
	done

Text_ViridianCityTutorDreamEater:
	text "I can teach your"
	line "#mon to eat"
	cont "dreams."

	para "I just want a"
	line "Silver Leaf in"
	cont "exchange."
	done

Text_ViridianCityTutorNoSilverLeaf:
	text "You don't have any"
	line "Silver Leaves…"
	done

Text_ViridianCityTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Dream Eater?"
	done

Text_ViridianCityTutorRefused:
	text "OK…"
	done

Text_ViridianCityTutorClear:
	text ""
	done

Text_ViridianCityTutorTaught:
	text "Now your #mon"
	line "knows how to use"
	cont "Dream Eater…"

	para "…Zzzzz…"
	done

UnknownText_0x1a9daa:
	text "I heard that there"
	line "are many items on"

	para "the ground in"
	line "Viridian Forest."
	done

ViridianCityYoungsterText:
	text "The leader of Team"
	line "Rocket was the Gym"

	para "Leader here for a"
	line "time, but one day"

	para "three years ago"
	line "he vanished."

	para "He wasn't usually"
	line "at the Gym anyway…"
	done

ViridianCitySignText:
	text "Viridian City"

	para "The Eternally"
	line "Green Paradise"
	done

ViridianGymSignText:
	text "Viridian City"
	line "#mon Gym"
	cont "Leader: …"

	para "The rest of the"
	line "text is illegible…"
	done

ViridianCityWelcomeSignText:
	text "Welcome to"
	line "Viridian City,"

	para "The Gateway to"
	line "Indigo Plateau"
	done

TrainerHouseSignText:
	text "Trainer House"

	para "The Club for Top"
	line "Trainer Battles"
	done

ViridianCity_MapEventHeader:
.Warps:
	db 8
	warp_def $7, $20, 1, VIRIDIAN_GYM
	warp_def $5, $15, 1, VIRIDIAN_NICKNAME_SPEECH_HOUSE
	warp_def $f, $17, 1, TRAINER_HOUSE_1F
	warp_def $13, $1d, 2, VIRIDIAN_MART
	warp_def $19, $17, 1, VIRIDIAN_POKECENTER_1F
	warp_def $21, $1c, 1, ROUTE_1_VIRIDIAN_GATE
	warp_def $21, $1d, 2, ROUTE_1_VIRIDIAN_GATE
	warp_def $9, $15, 1, VIRIDIAN_SCHOOL_HOUSE

.XYTriggers:
	db 0

.Signposts:
	db 4
	signpost 17, 17, SIGNPOST_READ, ViridianCitySign
	signpost 7, 27, SIGNPOST_READ, ViridianGymSign
	signpost 1, 19, SIGNPOST_READ, ViridianCityWelcomeSign
	signpost 15, 21, SIGNPOST_READ, TrainerHouseSign

.PersonEvents:
	db 8
	person_event SPRITE_GRAMPS, 5, 18, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a9a4c, -1
	person_event SPRITE_GRAMPS, 8, 32, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a9a61, EVENT_BLUE_IN_CINNABAR
	person_event SPRITE_GRAMPS, 8, 30, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a9a61, EVENT_VIRIDIAN_GYM_BLUE
	person_event SPRITE_FISHER, 23, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, FisherScript_0x1a9a75, -1
	person_event SPRITE_BUG_CATCHER, 21, 17, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x1a9a90, -1
	person_event SPRITE_YOUNGSTER, 23, 31, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ViridianCityYoungsterScript, -1
	person_event SPRITE_BALL_CUT_FRUIT, 4, 14, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ViridianCityCutTree, EVENT_VIRIDIAN_CITY_CUT_TREE_1
	person_event SPRITE_BALL_CUT_FRUIT, 22, 8, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ViridianCityCutTree, EVENT_VIRIDIAN_CITY_CUT_TREE_2
