CeladonUniversity2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonUniversity2F_MapEventHeader:

.Warps: db 6
	warp_def 8, 23, 3, CELADON_UNIVERSITY_1F
	warp_def 0, 7, 1, CELADON_UNIVERSITY_CAFETERIA
	warp_def 8, 5, 1, CELADON_UNIVERSITY_WILLOWS_OFFICE
	warp_def 0, 13, 1, CELADON_UNIVERSITY_HYPER_TEST_ROOM
	warp_def 8, 19, 1, CELADON_UNIVERSITY_WESTWOODS_OFFICE
	warp_def 0, 21, 1, CELADON_UNIVERSITY_POOL

.XYTriggers: db 0

.Signposts: db 7
	signpost 0, 6, SIGNPOST_JUMPTEXT, CeladonUniversity2FCafeteriaSignText
	signpost 0, 12, SIGNPOST_JUMPTEXT, CeladonUniversity2FHyperTestSignText
	signpost 0, 20, SIGNPOST_JUMPTEXT, CeladonUniversity2FPoolSignText
	signpost 8, 4, SIGNPOST_JUMPTEXT, CeladonUniversity2FWillowsOfficeSignText
	signpost 8, 18, SIGNPOST_JUMPTEXT, CeladonUniversity2FWestwoodsOfficeSignText
	signpost 1, 16, SIGNPOST_READ, CeladonUniversity2FMagikarpSign
	signpost 1, 24, SIGNPOST_READ, CeladonUniversity2FCuboneSign

.PersonEvents: db 7
	person_event SPRITE_COOLTRAINER_F, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CeladonUniversity2FCooltrainerfScript, -1
	person_event SPRITE_COOLTRAINER_M, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FCooltrainermText, -1
	person_event SPRITE_YOUNGSTER, 2, 17, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FYoungster1Text, -1
	person_event SPRITE_COWGIRL, 7, 11, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FCowgirlText, -1
	person_event SPRITE_BUG_CATCHER, 9, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FBug_catcherText, -1
	person_event SPRITE_LASS, 13, 13, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FLassText, -1
	person_event SPRITE_YOUNGSTER, 11, 21, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FYoungster2Text, -1

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
	thisopenedtext

.Text5:
	text "Antidotes cure"
	line "poison in #-"
	cont "mon, but a person"

	para "would get sick"
	line "by drinking one."
	done

.NoRoomForAntidote:
	giveitem FRESH_WATER
	thisopenedtext

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
	pokepic MAGIKARP
	cry MAGIKARP
	waitbutton
	closepokepic
	thistext

	text "A Magikarp is"
	line "swimming around."
	done

CeladonUniversity2FCuboneSign:
	refreshscreen
	trainerpic CUBONE_ARMOR
	waitbutton
	closepokepic
	thistext

	text "It's the Thick Club"
	line "and skull helmet"
	cont "of a Cubone."
	done
