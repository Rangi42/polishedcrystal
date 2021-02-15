PewterCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, PewterCityFlyPoint

	def_warp_events
	warp_event 29, 13, PEWTER_NIDORAN_SPEECH_HOUSE, 1
	warp_event 16, 17, PEWTER_GYM, 1
	warp_event 23, 17, PEWTER_MART, 2
	warp_event 13, 25, PEWTER_POKECENTER_1F, 1
	warp_event  7, 29, PEWTER_SNOOZE_SPEECH_HOUSE, 1
	warp_event 14,  7, PEWTER_MUSEUM_OF_SCIENCE_1F, 1
	warp_event 19,  5, PEWTER_MUSEUM_OF_SCIENCE_1F, 3

	def_coord_events

	def_bg_events
	bg_event 25, 23, BGEVENT_JUMPTEXT, PewterCitySignText
	bg_event 11, 17, BGEVENT_JUMPTEXT, PewterGymSignText
	bg_event 15,  9, BGEVENT_JUMPTEXT, PewterMuseumOfScienceSignText
	bg_event 33, 19, BGEVENT_JUMPTEXT, PewterCityMtMoonGiftShopSignText
	bg_event 19, 29, BGEVENT_JUMPTEXT, PewterCityTrainerTipsText

	def_object_events
	object_event 22, 11, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, PewterCityCooltrainerFText, -1
	object_event 19, 10, SPRITE_COOL_DUDE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 2, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, PewterCityCooltrainermText, -1
	object_event 14, 29, SPRITE_CHILD, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, PewterCityBugCatcherText, -1
	object_event 29, 17, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PewterCityGrampsScript, -1
	object_event  7, 17, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PewterCityYoungsterScript, -1
	fruittree_event 32,  3, FRUITTREE_PEWTER_CITY_1, PETAYA_BERRY, PAL_NPC_RED
	fruittree_event 30,  3, FRUITTREE_PEWTER_CITY_2, APICOT_BERRY, PAL_NPC_BLUE

PewterCityFlyPoint:
	setflag ENGINE_FLYPOINT_PEWTER
	return

PewterCityGrampsScript:
	checkevent EVENT_GOT_OLD_AMBER
	iftrue_jumptextfaceplayer PewterCityGrampsText_GotSilverWing
	faceplayer
	opentext
	writetext PewterCityGrampsText
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

PewterCityCooltrainerFText:
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
	line "Rock-type #mon"
	cont "are all that,"

	para "but it's tied for"
	line "the most weakness-"
	cont "es of any type."

	para "I don't have the"
	line "heart to tell her,"
	cont "though."
	done

PewterCityBugCatcherText:
	text "At night, Clefairy"
	line "come out to play"
	cont "at Mt.Moon."

	para "But not every"
	line "night."
	done

PewterCityGrampsText:
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

PewterCityGrampsText_GotSilverWing:
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

PewterCityTrainerTipsText:
	text "Trainer Tips"

	para "A #mon holding"
	line "an Ability Cap"
	cont "is more likely to"
	cont "have a baby with"
	cont "a rare ability."
	done
