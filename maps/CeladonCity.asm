CeladonCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, CeladonCityFlyPoint

CeladonCity_MapEventHeader:

.Warps: db 16
	warp_def 9, 8, 1, CELADON_DEPT_STORE_1F
	warp_def 9, 20, 1, CELADON_MANSION_1F
	warp_def 3, 20, 3, CELADON_MANSION_1F
	warp_def 3, 21, 3, CELADON_MANSION_1F
	warp_def 9, 33, 1, CELADON_POKECENTER_1F
	warp_def 19, 22, 1, CELADON_GAME_CORNER
	warp_def 19, 27, 1, CELADON_GAME_CORNER_PRIZE_ROOM
	warp_def 29, 14, 1, CELADON_GYM
	warp_def 29, 25, 1, CELADON_CAFE
	warp_def 29, 33, 1, CELADON_CHIEF_HOUSE
	warp_def 29, 37, 1, CELADON_HOTEL_1F
	warp_def 9, 13, 1, CELADON_HOME_DECOR_STORE_1F
	warp_def 29, 4, 1, CELADON_UNIVERSITY_1F
	warp_def 9, 29, 1, EUSINES_HOUSE
	warp_def 19, 33, 1, CELADON_OLD_MAN_SPEECH_HOUSE
	warp_def 19, 37, 1, CELADON_DEVELOPMENT_SPEECH_HOUSE

.XYTriggers: db 0

.Signposts: db 9
	signpost 18, 9, SIGNPOST_JUMPTEXT, CeladonCitySignText
	signpost 31, 15, SIGNPOST_JUMPTEXT, CeladonGymSignText
	signpost 31, 3, SIGNPOST_JUMPTEXT, CeladonUniversitySignText
	signpost 9, 10, SIGNPOST_JUMPTEXT, CeladonCityDeptStoreSignText
	signpost 9, 14, SIGNPOST_JUMPTEXT, CeladonCityHomeDecorStoreSignText
	signpost 9, 17, SIGNPOST_JUMPTEXT, CeladonCityMansionSignText
	signpost 21, 21, SIGNPOST_JUMPTEXT, CeladonCityGameCornerSignText
	signpost 21, 33, SIGNPOST_JUMPTEXT, CeladonCityTrainerTipsText
	signpost 21, 41, SIGNPOST_ITEM + PP_UP, EVENT_CELADON_CITY_HIDDEN_PP_UP

.PersonEvents: db 14
	person_event SPRITE_RICH_BOY, 17, 4, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonCityScript, -1
	person_event SPRITE_FISHER, 11, 30, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a9f7d, -1
	person_event SPRITE_POLIWRATH, 11, 31, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_POKEMON, POLIWRATH, CeladonCityPoliwrathText, -1
	person_event SPRITE_TEACHER, 24, 24, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a9fde, -1
	person_event SPRITE_GRAMPS, 16, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1aa043, -1
	person_event SPRITE_GRAMPS, 31, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1aa0dc, -1
	person_event SPRITE_YOUNGSTER, 13, 22, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1aa115, -1
	person_event SPRITE_YOUNGSTER, 33, 27, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1aa155, -1
	person_event SPRITE_TEACHER, 13, 12, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1aa1bd, -1
	person_event SPRITE_LASS, 22, 10, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1aa25b, -1
	person_event SPRITE_BIG_SNORLAX, 10, 45, SPRITEMOVEDATA_SNORLAX, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_8_SNORLAX
	person_event SPRITE_LASS, 23, 35, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonCityLassText, -1
	itemball_event 7, 39, MAX_ETHER, 1, EVENT_CELADON_CITY_MAX_ETHER
	cuttree_event 34, 32, EVENT_CELADON_CITY_CUT_TREE

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
	writetext Text_CeladonCityTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
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

Text_CeladonCityTutorClear:
	text ""
	done

Text_CeladonCityTutorTaught:
	text "Behold! Your #-"
	line "mon has learned"
	cont "to Swagger!"
	done

UnknownText_0x1a9f7d:
	text "This Poliwrath is"
	line "my partner."

	para "I wonder if it'll"
	line "ever evolve into a"
	cont "frog #mon."
	done

CeladonCityPoliwrathText:
	text "Poliwrath: Croak!"
	done

UnknownText_0x1a9fde:
	text "I lost at the slot"
	line "machines again…"

	para "We girls also play"
	line "the slots now."

	para "You should check"
	line "them out too."
	done

UnknownText_0x1aa043:
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

UnknownText_0x1aa0dc:
	text "Nihihi! This Gym"
	line "is great! Only"

	para "girls are allowed"
	line "here!"
	done

UnknownText_0x1aa115:
	text "Want to know a"
	line "secret?"

	para "Celadon Mansion"
	line "has a hidden back"
	cont "door."
	done

UnknownText_0x1aa155:
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

UnknownText_0x1aa1bd:
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
	text "Celadon Mansion"
	done

CeladonCityGameCornerSignText:
	text "The Playground for"
	line "Everybody--Celadon"
	cont "Game Corner"
	done

CeladonCityTrainerTipsText:
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
