CeladonCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CeladonCityFlyPoint

	def_warp_events
	warp_event  8,  9, CELADON_DEPT_STORE_1F, 1
	warp_event 20,  9, CELADON_MANSION_1F, 1
	warp_event 20,  3, CELADON_MANSION_1F, 3
	warp_event 21,  3, CELADON_MANSION_1F, 3
	warp_event 33,  9, CELADON_POKECENTER_1F, 1
	warp_event 22, 19, CELADON_GAME_CORNER, 1
	warp_event 27, 19, CELADON_GAME_CORNER_PRIZE_ROOM, 1
	warp_event 14, 29, CELADON_GYM, 1
	warp_event 25, 29, CELADON_CAFE, 1
	warp_event 33, 29, CELADON_CHIEF_HOUSE, 1
	warp_event 37, 29, CELADON_HOTEL_1F, 1
	warp_event 13,  9, CELADON_HOME_DECOR_STORE_1F, 1
	warp_event  4, 29, CELADON_UNIVERSITY_1F, 1
	warp_event 29,  9, EUSINES_HOUSE, 1
	warp_event 33, 19, CELADON_OLD_MAN_SPEECH_HOUSE, 1
	warp_event 37, 19, CELADON_DEVELOPMENT_SPEECH_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event  9, 18, BGEVENT_JUMPTEXT, CeladonCitySignText
	bg_event 15, 31, BGEVENT_JUMPTEXT, CeladonGymSignText
	bg_event  3, 31, BGEVENT_JUMPTEXT, CeladonUniversitySignText
	bg_event 10,  9, BGEVENT_JUMPTEXT, CeladonCityDeptStoreSignText
	bg_event 14,  9, BGEVENT_JUMPTEXT, CeladonCityHomeDecorStoreSignText
	bg_event 17,  9, BGEVENT_JUMPTEXT, CeladonCityMansionSignText
	bg_event 21, 21, BGEVENT_JUMPTEXT, CeladonCityGameCornerSignText
	bg_event 27, 21, BGEVENT_JUMPTEXT, CeladonCityPrizeExchangeSignText
	bg_event 33, 21, BGEVENT_JUMPTEXT, CeladonCityTrainerTips1Text
	bg_event 21, 15, BGEVENT_JUMPTEXT, CeladonCityTrainerTips2Text
	bg_event 41, 21, BGEVENT_ITEM + PP_UP, EVENT_CELADON_CITY_HIDDEN_PP_UP

	def_object_events
	object_event  4, 17, SPRITE_RICH_BOY, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCityScript, -1
	object_event 30, 11, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityFisherText, -1
	pokemon_event 31, 11, POLIWRATH, -1, -1, PAL_NPC_BLUE, CeladonCityPoliwrathText, -1
	object_event 24, 24, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityTeacher1Text, -1
	object_event 17, 16, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityGramps1Text, -1
	object_event 12, 31, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityGramps2Text, -1
	object_event 22, 13, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityYoungster1Text, -1
	object_event 27, 33, SPRITE_CAMPER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityYoungster2Text, -1
	object_event 12, 13, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityTeacher2Text, -1
	object_event 10, 22, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1aa25b, -1
	object_event 45, 10, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_SNORLAX, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_8_SNORLAX
	object_event 35, 23, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityLassText, -1
	itemball_event 39,  7, MAX_ETHER, 1, EVENT_CELADON_CITY_MAX_ETHER
	cuttree_event 32, 34, EVENT_CELADON_CITY_CUT_TREE

CeladonCityFlyPoint:
	setflag ENGINE_FLYPOINT_CELADON
	return

CeladonCityScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_SWAGGER_INTRO
	iftrue CeladonCityTutorSwaggerScript
	writetext CeladonCityRichBoyText
	waitbutton
	setevent EVENT_LISTENED_TO_SWAGGER_INTRO
CeladonCityTutorSwaggerScript:
	writetext Text_CeladonCityTutorSwagger
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_CeladonCityTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte SWAGGER
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_CeladonCityTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_CeladonCityTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_CeladonCityTutorTaught

CeladonCityRichBoyText:
	text "Is my suit not"
	line "bedazzling?"

	para "It turns heads"
	line "when I swagger"
	cont "down the street!"

	para "The people love"
	line "me!"

	para "I'm in a generous"
	line "mood today."
	done

Text_CeladonCityTutorSwagger:
	text "I shall teach"
	line "your #mon to"

	para "Swagger like me"
	line "for merely a"
	cont "Silver Leaf."
	done

Text_CeladonCityTutorNoSilverLeaf:
	text "…You have no"
	line "Silver Leaf?"
	cont "What a pity."
	done

Text_CeladonCityTutorQuestion:
	text "You wish me to"
	line "teach your #-"
	cont "mon Swagger?"
	done

Text_CeladonCityTutorRefused:
	text "Then goodbye!"
	done

Text_CeladonCityTutorTaught:
	text "Behold! Your #-"
	line "mon has learned"
	cont "to Swagger!"
	done

CeladonCityFisherText:
	text "This Poliwrath is"
	line "my partner."

	para "I wonder if it'll"
	line "ever evolve into a"
	cont "frog #mon."
	done

CeladonCityPoliwrathText:
	text "Poliwrath: Croak!"
	done

CeladonCityTeacher1Text:
	text "I lost at the slot"
	line "machines again…"

	para "We girls also play"
	line "the slots now."

	para "You should check"
	line "them out too."
	done

CeladonCityGramps1Text:
	text "Grimer have been"
	line "appearing lately."

	para "See that pond out"
	line "in front of the"

	para "house? Grimer live"
	line "there now."

	para "Where did they"
	line "come from? This is"
	cont "a serious problem…"
	done

CeladonCityGramps2Text:
	text "Nihihi! This Gym"
	line "is great! Only"

	para "girls are allowed"
	line "here!"
	done

CeladonCityYoungster1Text:
	text "Want to know a"
	line "secret?"

	para "Celadon Condo"
	line "has a hidden back"
	cont "door."
	done

CeladonCityYoungster2Text:
	text "The restaurant"
	line "there is having an"
	cont "eating contest."

	para "There's one con-"
	line "testant from the"

	para "Sinnoh region this"
	line "year."

	para "Just watching her"
	line "go at it makes me"
	cont "feel bloated…"
	done

CeladonCityTeacher2Text:
	text "Celadon Dept.Store"
	line "has the biggest"

	para "and best selection"
	line "of merchandise."

	para "If you can't get"
	line "it there, you"

	para "can't get it any-"
	line "where."

	para "Gee… I sound like"
	line "a sales clerk."
	done

UnknownText_0x1aa25b:
	text "I love being"
	line "surrounded by tall"
	cont "buildings!"

	para "Isn't it true that"
	line "Goldenrod #mon"

	para "Center was made"
	line "much, much bigger?"

	para "That is so neat!"
	line "I wish we had a"

	para "place like that in"
	line "Kanto…"
	done

CeladonCityLassText:
	text "#mon are offer-"
	line "ed as prizes at"
	cont "the Game Corner."

	para "The poor things…"
	done

CeladonCitySignText:
	text "Celadon City"

	para "The City of"
	line "Rainbow Dreams"
	done

CeladonGymSignText:
	text "Celadon City"
	line "#mon Gym"
	cont "Leader: Erika"

	para "The Nature-Loving"
	line "Princess"
	done

CeladonUniversitySignText:
	text "Celadon University"
	done

CeladonCityDeptStoreSignText:
	text "Find What You"
	line "Need at Celadon"
	cont "Dept.Store!"
	done

CeladonCityHomeDecorStoreSignText:
	text "Celadon Dept.Store"
	line "Home Decor Wing"
	done

CeladonCityMansionSignText:
	text "Celadon"
	line "Condominium"
	done

CeladonCityGameCornerSignText:
	text "The Playground for"
	line "Everybody--Celadon"
	cont "Game Corner"
	done

CeladonCityPrizeExchangeSignText:
	text "Coins exchanged"
	line "for prizes!"
	cont "Prize Exchange"
	done

CeladonCityTrainerTips1Text:
	text "Trainer Tips"

if DEF(FAITHFUL)
	para "Guard Spec."
else
	para "Guard Stats"
endc
	line "protects #mon"

	para "against stat"
	line "reductions."

	para "Get your items at"
	line "Celadon Dept."
	cont "Store!"
	done

CeladonCityTrainerTips2Text:
	text "Trainer Tips"

	para "Eevee is a #mon"
	line "full of potential."

	para "Try exposing it to"
	line "many different"
	cont "locations, times"
	cont "of day, and"
	cont "Evolution stones."
	done
