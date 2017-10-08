BlackthornCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 2
	dbw MAPCALLBACK_NEWMAP, BlackthornCityFlypointCallback
	dbw MAPCALLBACK_OBJECTS, BlackthornCitySantosCallback

BlackthornCity_MapEventHeader:

.Warps: db 8
	warp_def 11, 18, 1, BLACKTHORN_GYM_1F
	warp_def 21, 13, 1, BLACKTHORN_DRAGON_SPEECH_HOUSE
	warp_def 23, 29, 1, BLACKTHORN_EMYS_HOUSE
	warp_def 29, 15, 2, BLACKTHORN_MART
	warp_def 29, 21, 1, BLACKTHORN_POKECENTER_1F
	warp_def 29, 9, 1, MOVE_DELETERS_HOUSE
	warp_def 9, 36, 2, ICE_PATH_1F
	warp_def 1, 20, 1, DRAGONS_DEN_1F

.XYTriggers: db 0

.Signposts: db 5
	signpost 24, 34, SIGNPOST_JUMPTEXT, BlackthornCitySignText
	signpost 13, 17, SIGNPOST_JUMPTEXT, BlackthornGymSignText
	signpost 29, 7, SIGNPOST_JUMPTEXT, MoveDeletersHouseSignText
	signpost 3, 21, SIGNPOST_JUMPTEXT, DragonDensSignText
	signpost 19, 9, SIGNPOST_JUMPTEXT, BlackthornCityTrainerTipsText

.PersonEvents: db 12
	person_event SPRITE_YOUNGSTER, 20, 22, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SantosScript, EVENT_BLACKTHORN_CITY_SANTOS_OF_SATURDAY
	person_event SPRITE_DRAGON_TAMER, 12, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, BlackthornDragonTamer1Script, EVENT_BLACKTHORN_CITY_DRAGON_TAMER_BLOCKS_GYM
	person_event SPRITE_DRAGON_TAMER, 12, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, BlackthornDragonTamer1Script, EVENT_BLACKTHORN_CITY_DRAGON_TAMER_DOES_NOT_BLOCK_GYM
	person_event SPRITE_BLACK_BELT, 31, 24, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BlackthornBlackbeltScript, -1
	person_event SPRITE_GRAMPS, 2, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornGramps1Text, EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	person_event SPRITE_GRAMPS, 2, 21, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornGramps2Text, EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	person_event SPRITE_LASS, 25, 9, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornLassText, -1
	person_event SPRITE_YOUNGSTER, 15, 13, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornYoungsterText, -1
	person_event SPRITE_COOLTRAINER_F, 19, 35, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornCooltrainerF1Text, -1
	person_event SPRITE_COOLTRAINER_F, 29, 3, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornCooltrainerF2Text, -1
	person_event SPRITE_DRAGON_TAMER, 27, 32, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornDragonTamer2Text, -1
	person_event SPRITE_DRAGON_TAMER, 24, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << NITE), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornDragonTamer3Text, -1

const_value set 1
	const BLACKTHORNCITY_SANTOS

BlackthornCityFlypointCallback:
	setflag ENGINE_FLYPOINT_BLACKTHORN
	return

BlackthornCitySantosCallback:
	checkcode VAR_WEEKDAY
	if_equal SATURDAY, .SantosAppears
	disappear BLACKTHORNCITY_SANTOS
	return

.SantosAppears:
	appear BLACKTHORNCITY_SANTOS
	return

BlackthornCitySignText:
	text "Blackthorn City"

	para "A Quiet Mountain"
	line "Retreat"
	done

BlackthornGymSignText:
	text "Blackthorn City"
	line "#mon Gym"
	cont "Leader: Clair"

	para "The Blessed User"
	line "of Dragon #mon"
	done

MoveDeletersHouseSignText:
	text "Move Deleter's"
	line "and Move Maniac's"
	cont "House"
	done

DragonDensSignText:
	text "Dragon's Den"
	line "Ahead"
	done

BlackthornCityTrainerTipsText:
	text "Trainer Tips"

	para "A #mon holding"
	line "a Lum Berry"

	para "will cure itself"
	line "of any status"
	cont "problem."
	done

SantosScript:
	checkevent EVENT_GOT_SPELL_TAG_FROM_SANTOS
	iftrue_jumptextfaceplayer .SaturdayText
	checkcode VAR_WEEKDAY
	if_not_equal SATURDAY, .NotSaturday
	faceplayer
	opentext
	checkevent EVENT_MET_SANTOS_OF_SATURDAY
	iftrue .MetSantos
	writetext .MeetText
	buttonsound
	setevent EVENT_MET_SANTOS_OF_SATURDAY
.MetSantos:
	writetext .GivesGiftText
	buttonsound
	verbosegiveitem SPELL_TAG
	iffalse_endtext
	setevent EVENT_GOT_SPELL_TAG_FROM_SANTOS
	thisopenedtext

	text "Santos: …"

	para "Spell Tag…"

	para "Ghost-type moves"
	line "get stronger…"

	para "It will frighten"
	line "you…"
	done

.NotSaturday:
	thistextfaceplayer

	text "Santos: Today's"
	line "not Saturday…"
	done

.MeetText:
	text "Santos: …"

	para "It's Saturday…"

	para "I'm Santos of"
	line "Saturday…"
	done

.GivesGiftText:
	text "You can have this…"
	done

.SaturdayText:
	text "Santos: …"

	para "See you again on"
	line "another Saturday…"

	para "I won't have any"
	line "more gifts…"
	done

BlackthornDragonTamer1Script:
	checkevent EVENT_BEAT_CLAIR
	iftrue_jumptextfaceplayer .ClairIsBeatenText
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue_jumptextfaceplayer .ClairIsInText
	thistextfaceplayer

	text "I am sorry."

	para "Clair, our Gym"
	line "Leader, entered"

	para "the Dragon's Den"
	line "behind the Gym."

	para "I have no idea"
	line "when our Leader"
	cont "will return."
	done

.ClairIsInText:
	text "Clair, our Gym"
	line "Leader, is waiting"
	cont "for you."

	para "However, it would"
	line "be impossible for"

	para "a run-of-the-mill"
	line "trainer to win."
	done

.ClairIsBeatenText:
	text "You defeated"
	line "Clair?"

	para "That's amazing!"

	para "I've never heard"
	line "of her losing to"

	para "anyone other than"
	line "her cousin Lance."
	done

BlackthornBlackbeltScript:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue_jumptextfaceplayer .Text2
	thistextfaceplayer

	text "My radio's busted?"
	line "Lately, I only get"
	cont "this weird signal."
	done

.Text2:
	text "Arooo! Voices in"
	line "my head!"

	para "Huh? I'm listening"
	line "to my radio!"
	done

BlackthornGramps1Text:
	text "No. Only chosen"
	line "trainers may train"
	cont "here."

	para "Please leave."
	done

BlackthornGramps2Text:
	text "If Clair allows"
	line "it, her grand-"
	cont "father--our Master"
	cont "--will also."

	para "You may enter."
	done

BlackthornLassText:
	text "Are you going to"
	line "make your #mon"
	cont "forget some moves?"
	done

BlackthornYoungsterText:
	text "Dragon masters all"
	line "come from the city"
	cont "of Blackthorn."
	done

BlackthornCooltrainerF1Text:
	text "Wow, you came"
	line "through the Ice"
	cont "Path?"

	para "You must be a real"
	line "hotshot trainer!"
	done

BlackthornCooltrainerF2Text:
	text "The Fairy type was"
	line "discovered only"
	cont "recently."

	para "It totally shuts"
	line "down Dragon types."
	done

BlackthornDragonTamer2Text:
	text "When our Gym Lead-"
	line "er was a young"

	para "girl, she used to"
	line "train in the"

	para "Dragon's Den non-"
	line "stop."
	done

BlackthornDragonTamer3Text:
	text "Blackthorn City is"
	line "the home of many"

	para "famous dragon"
	line "tamers, including"
	cont "Lance."

	para "He's our Gym Lead-"
	line "er's cousin, you"
	cont "know!"
	done
