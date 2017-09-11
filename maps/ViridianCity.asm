ViridianCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, ViridianCityFlyPoint

ViridianCity_MapEventHeader:

.Warps: db 8
	warp_def 7, 32, 1, VIRIDIAN_GYM
	warp_def 5, 21, 1, VIRIDIAN_NICKNAME_SPEECH_HOUSE
	warp_def 15, 23, 1, TRAINER_HOUSE_1F
	warp_def 19, 29, 2, VIRIDIAN_MART
	warp_def 25, 23, 1, VIRIDIAN_POKECENTER_1F
	warp_def 33, 28, 1, ROUTE_1_VIRIDIAN_GATE
	warp_def 33, 29, 2, ROUTE_1_VIRIDIAN_GATE
	warp_def 9, 21, 1, VIRIDIAN_SCHOOL_HOUSE

.XYTriggers: db 0

.Signposts: db 4
	signpost 17, 17, SIGNPOST_JUMPTEXT, ViridianCitySignText
	signpost 7, 27, SIGNPOST_JUMPTEXT, ViridianGymSignText
	signpost 1, 19, SIGNPOST_JUMPTEXT, ViridianCityWelcomeSignText
	signpost 15, 21, SIGNPOST_JUMPTEXT, TrainerHouseSignText

.PersonEvents: db 8
	person_event SPRITE_GRAMPS, 5, 18, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a9a4c, -1
	person_event SPRITE_GRAMPS, 8, 32, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a9a61, EVENT_BLUE_IN_CINNABAR
	person_event SPRITE_GRAMPS, 8, 30, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a9a61, EVENT_VIRIDIAN_GYM_BLUE
	person_event SPRITE_FISHER, 23, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, FisherScript_0x1a9a75, -1
	person_event SPRITE_BUG_CATCHER, 21, 17, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a9daa, -1
	person_event SPRITE_YOUNGSTER, 23, 31, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ViridianCityYoungsterText, -1
	cuttree_event 4, 14, EVENT_VIRIDIAN_CITY_CUT_TREE_1
	cuttree_event 22, 8, EVENT_VIRIDIAN_CITY_CUT_TREE_2

ViridianCityFlyPoint:
	setflag ENGINE_FLYPOINT_VIRIDIAN
	return

GrampsScript_0x1a9a4c:
	faceplayer
	opentext
	writetext UnknownText_0x1a9aa5
	yesorno
	iffalse_jumpopenedtext UnknownText_0x1a9bb7
	jumpopenedtext UnknownText_0x1a9b6f

GrampsScript_0x1a9a61:
	checkevent EVENT_BLUE_IN_CINNABAR
	iftrue_jumptextfaceplayer UnknownText_0x1a9c7e
	jumptextfaceplayer UnknownText_0x1a9c11

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
	jumpopenedtext Text_ViridianCityTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_ViridianCityTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_ViridianCityTutorTaught

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
