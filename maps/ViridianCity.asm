ViridianCity_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, ViridianCityFlyPoint

	db 8 ; warp events
	warp_event 32,  7, VIRIDIAN_GYM, 1
	warp_event 21,  5, VIRIDIAN_NICKNAME_SPEECH_HOUSE, 1
	warp_event 23, 15, TRAINER_HOUSE_1F, 1
	warp_event 29, 19, VIRIDIAN_MART, 2
	warp_event 23, 25, VIRIDIAN_POKECENTER_1F, 1
	warp_event 28, 33, ROUTE_1_VIRIDIAN_GATE, 1
	warp_event 29, 33, ROUTE_1_VIRIDIAN_GATE, 2
	warp_event 21,  9, VIRIDIAN_SCHOOL_HOUSE, 1

	db 0 ; coord events

	db 5 ; bg events
	bg_event 17, 17, SIGNPOST_JUMPTEXT, ViridianCitySignText
	bg_event 27,  7, SIGNPOST_JUMPTEXT, ViridianGymSignText
	bg_event 19,  1, SIGNPOST_JUMPTEXT, ViridianCityTrainerTips1Text
	bg_event 29, 29, SIGNPOST_JUMPTEXT, ViridianCityTrainerTips2Text
	bg_event 21, 15, SIGNPOST_JUMPTEXT, TrainerHouseSignText

	db 8 ; object events
	object_event 18,  5, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a9a4c, -1
	object_event 32,  8, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a9a61, EVENT_BLUE_IN_CINNABAR
	object_event 30,  8, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, GrampsScript_0x1a9a61, EVENT_VIRIDIAN_GYM_BLUE
	object_event  6, 23, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, FisherScript_0x1a9a75, -1
	object_event 17, 21, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a9daa, -1
	object_event 31, 23, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ViridianCityYoungsterText, -1
	cuttree_event 14,  4, EVENT_VIRIDIAN_CITY_CUT_TREE_1
	cuttree_event  8, 22, EVENT_VIRIDIAN_CITY_CUT_TREE_2

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
	ifequal $0, .TeachMove
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

ViridianCityTrainerTips1Text:
	text "Trainer Tips"

	para "Catch #mon"
	line "and expand your"
	cont "collection!"

	para "The more you have,"
	line "the easier it is"
	cont "to fight!"
	done

ViridianCityTrainerTips2Text:
	text "Trainer Tips"

	para "The world is a"
	line "big place!"

	para "Don't just run or"
	line "Fly everywhere--"
	cont "look around you!"

	para "You'll find new and"
	line "exciting things!"
	done

TrainerHouseSignText:
	text "Trainer House"

	para "The Club for Top"
	line "Trainer Battles"
	done
