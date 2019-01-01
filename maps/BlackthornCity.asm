BlackthornCity_MapScriptHeader:
	db 0 ; scene scripts

	db 2 ; callbacks
	callback MAPCALLBACK_NEWMAP, BlackthornCityFlypointCallback
	callback MAPCALLBACK_OBJECTS, BlackthornCitySantosCallback

	db 8 ; warp events
	warp_event 18, 11, BLACKTHORN_GYM_1F, 1
	warp_event 13, 21, BLACKTHORN_DRAGON_SPEECH_HOUSE, 1
	warp_event 29, 23, BLACKTHORN_EMYS_HOUSE, 1
	warp_event 15, 29, BLACKTHORN_MART, 2
	warp_event 21, 29, BLACKTHORN_POKECENTER_1F, 1
	warp_event  9, 29, MOVE_DELETERS_HOUSE, 1
	warp_event 36,  9, ICE_PATH_1F, 2
	warp_event 20,  1, DRAGONS_DEN_1F, 1

	db 0 ; coord events

	db 5 ; bg events
	bg_event 34, 24, SIGNPOST_JUMPTEXT, BlackthornCitySignText
	bg_event 17, 13, SIGNPOST_JUMPTEXT, BlackthornGymSignText
	bg_event  7, 29, SIGNPOST_JUMPTEXT, MoveDeletersHouseSignText
	bg_event 21,  3, SIGNPOST_JUMPTEXT, DragonDensSignText
	bg_event  9, 19, SIGNPOST_JUMPTEXT, BlackthornCityTrainerTipsText

	db 12 ; object events
	object_event 22, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SantosScript, EVENT_BLACKTHORN_CITY_SANTOS_OF_SATURDAY
	object_event 18, 12, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, BlackthornDragonTamer1Script, EVENT_BLACKTHORN_CITY_DRAGON_TAMER_BLOCKS_GYM
	object_event 19, 12, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, BlackthornDragonTamer1Script, EVENT_BLACKTHORN_CITY_DRAGON_TAMER_DOES_NOT_BLOCK_GYM
	object_event 24, 31, SPRITE_BLACK_BELT, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, BlackthornBlackbeltScript, -1
	object_event 20,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornGramps1Text, EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	object_event 21,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornGramps2Text, EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	object_event  9, 25, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornLassText, -1
	object_event 13, 15, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornYoungsterText, -1
	object_event 35, 19, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornCooltrainerF1Text, -1
	object_event  3, 29, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornCooltrainerF2Text, -1
	object_event 32, 27, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornDragonTamer2Text, -1
	object_event 27, 24, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << NITE), PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornDragonTamer3Text, -1

	const_def 1 ; object constants
	const BLACKTHORNCITY_SANTOS

BlackthornCityFlypointCallback:
	setflag ENGINE_FLYPOINT_BLACKTHORN
	return

BlackthornCitySantosCallback:
	checkcode VAR_WEEKDAY
	ifequal SATURDAY, .SantosAppears
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
	ifnotequal SATURDAY, .NotSaturday
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
