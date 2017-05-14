const_value set 2
	const CELADONUNIVERSITY2F_COOLTRAINER_F
	const CELADONUNIVERSITY2F_COOLTRAINER_M
	const CELADONUNIVERSITY2F_YOUNGSTER1
	const CELADONUNIVERSITY2F_COWGIRL
	const CELADONUNIVERSITY2F_BUG_CATCHER
	const CELADONUNIVERSITY2F_LASS
	const CELADONUNIVERSITY2F_YOUNGSTER2

CeladonUniversity2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversity2FCooltrainerfScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_RARE_CANDY_IN_UNIVERSITY
	iftrue .GotItem
	writetext .Text1
	waitbutton
	writetext .Text2
	yesorno
	iffalse .NoFreshWater
	takeitem FRESH_WATER
	iffalse .NoFreshWater
	writetext .Text3
	waitbutton
	writetext .Text4
	waitbutton
	verbosegiveitem RARE_CANDY
	iffalse .NoRoomForRareCandy
	setevent EVENT_GOT_RARE_CANDY_IN_UNIVERSITY
.GotItem:
	writetext .Text5
	waitbutton
.Done:
	closetext
	end

.NoFreshWater:
	writetext .Text6
	waitbutton
	closetext
	end

.NoRoomForRareCandy:
	giveitem FRESH_WATER
	writetext .Text7
	waitbutton
	closetext
	end

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

.Text5:
	text "That Fresh Water"
	line "really is re-"
	cont "freshing!"
	done

.Text6:
	text "Oh… But I'm so"
	line "thirsty…"
	done

.Text7:
	text "Oh… Keep your"
	line "Fresh Water then…"
	done

CeladonUniversity2FCooltrainermScript:
	jumptextfaceplayer .Text

.Text:
	text "The cafeteria gets"
	line "pretty crowded,"

	para "so I prefer to eat"
	line "in the hall."
	done

CeladonUniversity2FYoungster1Script:
	jumptextfaceplayer .Text

.Text:
	text "I failed the"
	line "Hyper Test again…"

	para "But I won't"
	line "give up!"
	done

CeladonUniversity2FCowgirlScript:
	jumptextfaceplayer .Text

.Text:
	text "My class is going"
	line "on a field trip to"
	cont "the Safari Zone!"
	done

CeladonUniversity2FBug_catcherScript:
	jumptextfaceplayer .Text

.Text:
	text "Prof.Willow sends"
	line "his assistants to"

	para "wander all over"
	line "the city and study"

	para "the #mon that"
	line "live here."
	done

CeladonUniversity2FLassScript:
	jumptextfaceplayer .Text

.Text:
	text "In addition to"
	line "being the Celadon"
	cont "Gym Leader,"

	para "Erika was top of"
	line "her class here at"
	cont "the university."

	para "I wish I was as"
	line "cool as her."
	done

CeladonUniversity2FYoungster2Script:
	jumptextfaceplayer .Text

.Text:
	text "Prof.Westwood is a"
	line "little eccentric."

	para "Sometimes he apol-"
	line "ogizes to his"

	para "ancestors' por-"
	line "traits."
	done

CeladonUniversity2FCafeteriaSign:
	jumptext .Text

.Text:
	text "Cafeteria"
	done

CeladonUniversity2FHyperTestSign:
	jumptext .Text

.Text:
	text "Hyper Test Room"
	done

CeladonUniversity2FPoolSign:
	jumptext .Text

.Text:
	text "Swimming Pool"
	done

CeladonUniversity2FWillowsOfficeSign:
	jumptext .Text

.Text:
	text "Prof.Willow's"
	line "Office"
	done

CeladonUniversity2FWestwoodsOfficeSign:
	jumptext .Text

.Text:
	text "Prof.Westwood's"
	line "Office"
	done

CeladonUniversity2FMagikarpSign:
	refreshscreen $0
	pokepic MAGIKARP
	cry MAGIKARP
	waitbutton
	closepokepic
	jumptext .Text

.Text:
	text "A Magikarp is"
	line "swimming around."
	done

CeladonUniversity2FCuboneSign:
	refreshscreen $0
	trainerpic CUBONE_ARMOR
	waitbutton
	closepokepic
	jumptext .Text

.Text:
	text "It's the Thick Club"
	line "and skull helmet"
	cont "of a Cubone."
	done

CeladonUniversity2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $8, $17, 3, CELADON_UNIVERSITY_1F
	warp_def $0, $7, 1, CELADON_UNIVERSITY_CAFETERIA
	warp_def $8, $5, 1, CELADON_UNIVERSITY_WILLOWS_OFFICE
	warp_def $0, $d, 1, CELADON_UNIVERSITY_HYPER_TEST_ROOM
	warp_def $8, $13, 1, CELADON_UNIVERSITY_WESTWOODS_OFFICE
	warp_def $0, $15, 1, CELADON_UNIVERSITY_POOL

.XYTriggers:
	db 0

.Signposts:
	db 7
	signpost 0, 6, SIGNPOST_READ, CeladonUniversity2FCafeteriaSign
	signpost 0, 12, SIGNPOST_READ, CeladonUniversity2FHyperTestSign
	signpost 0, 20, SIGNPOST_READ, CeladonUniversity2FPoolSign
	signpost 8, 4, SIGNPOST_READ, CeladonUniversity2FWillowsOfficeSign
	signpost 8, 18, SIGNPOST_READ, CeladonUniversity2FWestwoodsOfficeSign
	signpost 1, 16, SIGNPOST_READ, CeladonUniversity2FMagikarpSign
	signpost 1, 24, SIGNPOST_READ, CeladonUniversity2FCuboneSign

.PersonEvents:
	db 7
	person_event SPRITE_COOLTRAINER_F, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CeladonUniversity2FCooltrainerfScript, -1
	person_event SPRITE_COOLTRAINER_M, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversity2FCooltrainermScript, -1
	person_event SPRITE_YOUNGSTER, 2, 17, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversity2FYoungster1Script, -1
	person_event SPRITE_COWGIRL, 7, 11, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CeladonUniversity2FCowgirlScript, -1
	person_event SPRITE_BUG_CATCHER, 9, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CeladonUniversity2FBug_catcherScript, -1
	person_event SPRITE_LASS, 13, 13, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversity2FLassScript, -1
	person_event SPRITE_YOUNGSTER, 11, 21, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonUniversity2FYoungster2Script, -1
