CeladonUniversity2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 23,  8, CELADON_UNIVERSITY_1F, 3
	warp_event  7,  0, CELADON_UNIVERSITY_CAFETERIA, 1
	warp_event  5,  8, CELADON_UNIVERSITY_WILLOWS_OFFICE, 1
	warp_event 13,  0, CELADON_UNIVERSITY_HYPER_TEST_ROOM, 1
	warp_event 19,  8, CELADON_UNIVERSITY_WESTWOODS_OFFICE, 1
	warp_event 21,  0, CELADON_UNIVERSITY_POOL, 1

	def_coord_events

	def_bg_events
	bg_event  6,  0, BGEVENT_JUMPTEXT, CeladonUniversity2FCafeteriaSignText
	bg_event 12,  0, BGEVENT_JUMPTEXT, CeladonUniversity2FHyperTestSignText
	bg_event 20,  0, BGEVENT_JUMPTEXT, CeladonUniversity2FPoolSignText
	bg_event  4,  8, BGEVENT_JUMPTEXT, CeladonUniversity2FWillowsOfficeSignText
	bg_event 18,  8, BGEVENT_JUMPTEXT, CeladonUniversity2FWestwoodsOfficeSignText
	bg_event 16,  1, BGEVENT_READ, CeladonUniversity2FMagikarpSign
	bg_event 24,  1, BGEVENT_READ, CeladonUniversity2FCuboneSign

	def_object_events
	object_event  2,  3, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, CeladonUniversity2FCooltrainerfScript, -1
	object_event  5,  3, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FCooltrainermText, -1
	object_event 17,  2, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FYoungster1Text, -1
	object_event 11,  7, SPRITE_COWGIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FCowgirlText, -1
	object_event  3,  9, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FBug_catcherText, -1
	object_event 13, 13, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FLassText, -1
	object_event 21, 11, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FYoungster2Text, -1

CeladonUniversity2FCooltrainerfScript:
	checkevent EVENT_GOT_ANTIDOTE_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text5
	faceplayer
	opentext
	writetext .Text1
	waitbutton
	writetext .Text2
	yesorno
	iffalse_jumpopenedtext .Text6
	takeitem FRESH_WATER
	iffalse_jumpopenedtext .Text6
	writetext .Text3
	waitbutton
	writetext .Text4
	waitbutton
	verbosegiveitem ANTIDOTE
	iffalse .NoRoomForAntidote
	setevent EVENT_GOT_ANTIDOTE_IN_UNIVERSITY
	jumpthisopenedtext

.Text5:
	text "Antidotes cure"
	line "poison in #-"
	cont "mon, but a person"

	para "would get sick"
	line "by drinking one."
	done

.NoRoomForAntidote:
	giveitem FRESH_WATER
	jumpthisopenedtext

	text "Oh… Keep your"
	line "Fresh Water then…"
	done

.Text1:
	text "Wow, I'm thirsty!"

	para "But I don't have"
	line "change for the"
	cont "vending machines…"

	para "Do you have any"
	line "Fresh Water?"
	done

.Text2:
	text "Give away a"
	line "Fresh Water?"
	done

.Text3:
	text "<PLAYER> gave away"
	line "the Fresh Water."
	done

.Text4:
	text "Thank you so much!"
	line "Here, take this!"
	done

.Text6:
	text "Oh… But I'm so"
	line "thirsty…"
	done

CeladonUniversity2FCooltrainermText:
	text "The cafeteria gets"
	line "pretty crowded,"

	para "so I prefer to eat"
	line "in the hall."
	done

CeladonUniversity2FYoungster1Text:
	text "I failed the"
	line "Hyper Test again…"

	para "But I won't"
	line "give up!"
	done

CeladonUniversity2FCowgirlText:
	text "My class is going"
	line "on a field trip to"
	cont "the Safari Zone!"
	done

CeladonUniversity2FBug_catcherText:
	text "Prof.Willow sends"
	line "his assistants to"

	para "wander all over"
	line "the city and study"

	para "the #mon that"
	line "live here."
	done

CeladonUniversity2FLassText:
	text "In addition to"
	line "being the Celadon"
	cont "Gym Leader,"

	para "Erika was top of"
	line "her class here at"
	cont "the university."

	para "I wish I was as"
	line "cool as her."
	done

CeladonUniversity2FYoungster2Text:
	text "Prof.Westwood is a"
	line "little eccentric."

	para "Sometimes he apol-"
	line "ogizes to his"

	para "ancestors' por-"
	line "traits."
	done

CeladonUniversity2FCafeteriaSignText:
	text "Cafeteria"
	done

CeladonUniversity2FHyperTestSignText:
	text "Hyper Test Room"
	done

CeladonUniversity2FPoolSignText:
	text "Swimming Pool"
	done

CeladonUniversity2FWillowsOfficeSignText:
	text "Prof.Willow's"
	line "Office"
	done

CeladonUniversity2FWestwoodsOfficeSignText:
	text "Prof.Westwood's"
	line "Office"
	done

CeladonUniversity2FMagikarpSign:
	refreshscreen
	pokepic MAGIKARP, MAGIKARP_ORCA_FORM
	cry MAGIKARP
	waitbutton
	closepokepic
	jumpthistext

	text "A Magikarp is"
	line "swimming around."
	done

CeladonUniversity2FCuboneSign:
	refreshscreen
	trainerpic CUBONE_ARMOR
	waitbutton
	closepokepic
	jumpthistext

	text "It's the Thick Club"
	line "and skull helmet"
	cont "of a Cubone."
	done
