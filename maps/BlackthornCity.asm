const_value set 2
	const BLACKTHORNCITY_DRAGON_TAMER1
	const BLACKTHORNCITY_DRAGON_TAMER2
	const BLACKTHORNCITY_GRAMPS1
	const BLACKTHORNCITY_GRAMPS2
	const BLACKTHORNCITY_BLACK_BELT
	const BLACKTHORNCITY_LASS
	const BLACKTHORNCITY_YOUNGSTER1
	const BLACKTHORNCITY_SANTOS
	const BLACKTHORNCITY_COOLTRAINER_F1
	const BLACKTHORNCITY_COOLTRAINER_F2
	const BLACKTHORNCITY_DRAGON_TAMER3
	const BLACKTHORNCITY_DRAGON_TAMER4

BlackthornCity_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 2

	; callbacks
	dbw MAPCALLBACK_NEWMAP, .FlyPoint
	dbw MAPCALLBACK_OBJECTS, .Santos

.FlyPoint:
	setflag ENGINE_FLYPOINT_BLACKTHORN
	return

.Santos:
	checkcode VAR_WEEKDAY
	if_equal SATURDAY, .SantosAppears
	disappear BLACKTHORNCITY_SANTOS
	return

.SantosAppears:
	appear BLACKTHORNCITY_SANTOS
	return

BlackthornDragonTamer1Script:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CLAIR
	iftrue .BeatClair
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .ClearedRadioTower
	writetext Text_ClairIsOut
	waitbutton
	closetext
	end

.ClearedRadioTower:
	writetext Text_ClairIsIn
	waitbutton
	closetext
	end

.BeatClair:
	writetext Text_ClairIsBeaten
	waitbutton
	closetext
	end

BlackthornGramps1Script:
	jumptextfaceplayer BlackthornGrampsRefusesEntryText

BlackthornGramps2Script:
	jumptextfaceplayer BlackthornGrampsGrantsEntryText

BlackthornBlackBeltScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .ClearedRadioTower
	writetext BlackBeltText_WeirdRadio
	waitbutton
	closetext
	end

.ClearedRadioTower:
	writetext BlackBeltText_VoicesInMyHead
	waitbutton
	closetext
	end

BlackthornLassScript:
	jumptextfaceplayer BlackthornLassText

BlackthornYoungsterScript:
	jumptextfaceplayer BlackthornYoungsterText

BlackthornCooltrainerF1Script:
	jumptextfaceplayer BlackthornCooltrainerF1Text

BlackthornCooltrainerF2Script:
	jumptextfaceplayer BlackthornCooltrainerF2Text

BlackthornDragonTamer2Script:
	jumptextfaceplayer BlackthornDragonTamer2Text

BlackthornDragonTamer3Script:
	jumptextfaceplayer BlackthornDragonTamer3Text

SantosScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SPELL_TAG_FROM_SANTOS
	iftrue .Saturday
	checkcode VAR_WEEKDAY
	if_not_equal SATURDAY, .NotSaturday
	checkevent EVENT_MET_SANTOS_OF_SATURDAY
	iftrue .MetSantos
	writetext MeetSantosText
	buttonsound
	setevent EVENT_MET_SANTOS_OF_SATURDAY
.MetSantos:
	writetext SantosGivesGiftText
	buttonsound
	verbosegiveitem SPELL_TAG
	iffalse .Done
	setevent EVENT_GOT_SPELL_TAG_FROM_SANTOS
	writetext SantosGaveGiftText
	waitbutton
	closetext
	end

.Saturday:
	writetext SantosSaturdayText
	waitbutton
.Done:
	closetext
	end

.NotSaturday:
	writetext SantosNotSaturdayText
	waitbutton
	closetext
	end

BlackthornCitySign:
	jumptext BlackthornCitySignText

BlackthornGymSign:
	jumptext BlackthornGymSignText

MoveDeletersHouseSign:
	jumptext MoveDeletersHouseSignText

DragonDensSign:
	jumptext DragonDensSignText

BlackthornCityTrainerTips:
	jumptext BlackthornCityTrainerTipsText

Text_ClairIsOut:
	text "I am sorry."

	para "Clair, our Gym"
	line "Leader, entered"

	para "the Dragon's Den"
	line "behind the Gym."

	para "I have no idea"
	line "when our Leader"
	cont "will return."
	done

Text_ClairIsIn:
	text "Clair, our Gym"
	line "Leader, is waiting"
	cont "for you."

	para "However, it would"
	line "be impossible for"

	para "a run-of-the-mill"
	line "trainer to win."
	done

Text_ClairIsBeaten:
	text "You defeated"
	line "Clair?"

	para "That's amazing!"

	para "I've never heard"
	line "of her losing to"

	para "anyone other than"
	line "her cousin Lance."
	done

BlackthornGrampsRefusesEntryText:
	text "No. Only chosen"
	line "trainers may train"
	cont "here."

	para "Please leave."
	done

BlackthornGrampsGrantsEntryText:
	text "If Clair allows"
	line "it, her grand-"
	cont "father--our Master"
	cont "--will also."

	para "You may enter."
	done

BlackBeltText_WeirdRadio:
	text "My radio's busted?"
	line "Lately, I only get"
	cont "this weird signal."
	done

BlackBeltText_VoicesInMyHead:
	text "Arooo! Voices in"
	line "my head!"

	para "Huh? I'm listening"
	line "to my radio!"
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

MeetSantosText:
	text "Santos: …"

	para "It's Saturday…"

	para "I'm Santos of"
	line "Saturday…"
	done

SantosGivesGiftText:
	text "You can have this…"
	done

SantosGaveGiftText:
	text "Santos: …"

	para "Spell Tag…"

	para "Ghost-type moves"
	line "get stronger…"

	para "It will frighten"
	line "you…"
	done

SantosSaturdayText:
	text "Santos: …"

	para "See you again on"
	line "another Saturday…"

	para "I won't have any"
	line "more gifts…"
	done

SantosNotSaturdayText:
	text "Santos: Today's"
	line "not Saturday…"
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

BlackthornCity_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 8
	warp_def $b, $12, 1, BLACKTHORN_GYM_1F
	warp_def $15, $d, 1, BLACKTHORN_DRAGON_SPEECH_HOUSE
	warp_def $17, $1d, 1, BLACKTHORN_EMYS_HOUSE
	warp_def $1d, $f, 2, BLACKTHORN_MART
	warp_def $1d, $15, 1, BLACKTHORN_POKECENTER_1F
	warp_def $1d, $9, 1, MOVE_DELETERS_HOUSE
	warp_def $9, $24, 2, ICE_PATH_1F
	warp_def $1, $14, 1, DRAGONS_DEN_1F

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 24, 34, SIGNPOST_READ, BlackthornCitySign
	signpost 13, 17, SIGNPOST_READ, BlackthornGymSign
	signpost 29, 7, SIGNPOST_READ, MoveDeletersHouseSign
	signpost 3, 21, SIGNPOST_READ, DragonDensSign
	signpost 19, 9, SIGNPOST_READ, BlackthornCityTrainerTips

.PersonEvents:
	db 12
	person_event SPRITE_DRAGON_TAMER, 12, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, BlackthornDragonTamer1Script, EVENT_BLACKTHORN_CITY_DRAGON_TAMER_BLOCKS_GYM
	person_event SPRITE_DRAGON_TAMER, 12, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, BlackthornDragonTamer1Script, EVENT_BLACKTHORN_CITY_DRAGON_TAMER_DOES_NOT_BLOCK_GYM
	person_event SPRITE_GRAMPS, 2, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BlackthornGramps1Script, EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	person_event SPRITE_GRAMPS, 2, 21, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BlackthornGramps2Script, EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	person_event SPRITE_BLACK_BELT, 31, 24, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BlackthornBlackBeltScript, -1
	person_event SPRITE_LASS, 25, 9, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, BlackthornLassScript, -1
	person_event SPRITE_YOUNGSTER, 15, 13, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BlackthornYoungsterScript, -1
	person_event SPRITE_YOUNGSTER, 20, 22, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SantosScript, EVENT_BLACKTHORN_CITY_SANTOS_OF_SATURDAY
	person_event SPRITE_COOLTRAINER_F, 19, 35, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, BlackthornCooltrainerF1Script, -1
	person_event SPRITE_COOLTRAINER_F, 29, 3, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, BlackthornCooltrainerF2Script, -1
	person_event SPRITE_DRAGON_TAMER, 27, 32, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, BlackthornDragonTamer2Script, -1
	person_event SPRITE_DRAGON_TAMER, 24, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << NITE), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, BlackthornDragonTamer3Script, -1
