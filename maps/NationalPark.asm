NationalPark_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 35, 18, ROUTE_36_NATIONAL_PARK_GATE, 1
	warp_event 35, 19, ROUTE_36_NATIONAL_PARK_GATE, 2
	warp_event 12, 47, ROUTE_35_NATIONAL_PARK_GATE, 1
	warp_event 13, 47, ROUTE_35_NATIONAL_PARK_GATE, 2

	db 0 ; coord events

	db 4 ; bg events
	bg_event 16, 44, SIGNPOST_JUMPTEXT, UnknownText_0x5c750
	bg_event 29, 31, SIGNPOST_JUMPTEXT, UnknownText_0x5c771
	bg_event 14,  4, SIGNPOST_JUMPTEXT, UnknownText_0x5c7c6
	bg_event  8, 47, SIGNPOST_ITEM + FULL_HEAL, EVENT_NATIONAL_PARK_HIDDEN_FULL_HEAL

	db 16 ; object events
	object_event 17, 24, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5c1d3, -1
	object_event 16,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5c22e, -1
	object_event 29, 40, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, TeacherScript_0x5c008, -1
	object_event 28,  6, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x5c037, -1
	object_event 13, 41, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_GENERICTRAINER, 0, GenericTrainerSchoolgirlEliza, -1
	object_event 12, 41, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 0, GenericTrainerSchoolboyJohnny, -1
	object_event 19, 41, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5c3bc, -1
	object_event 28, 40, SPRITE_PERSIAN, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_POKEMON, PERSIAN, NationalParkPersianText, -1
	object_event 29, 23, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_TRAINER, 3, TrainerSchoolboyJack1, -1
	object_event 20, 29, SPRITE_POKEFAN_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_TRAINER, 2, TrainerPokefanfBeverly1, -1
	object_event 18,  9, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerPokefanmWilliam, -1
	object_event 10, 14, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerLassKrise, -1
	object_event 28, 13, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerBugManiacLou, -1
	object_event  4, 19, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, OfficermKeithScript, -1
	itemball_event 37, 12, SHINY_STONE, 1, EVENT_NATIONAL_PARK_SHINY_STONE
	tmhmball_event  3, 43, TM_DIG, EVENT_NATIONAL_PARK_TM_DIG

TeacherScript_0x5c008:
	faceplayer
	opentext
	checkevent EVENT_GOT_QUICK_CLAW
	iftrue UnknownScript_0x5c01d
	writetext UnknownText_0x5c265
	buttonsound
	verbosegiveitem QUICK_CLAW
	iffalse UnknownScript_0x5c021
	setevent EVENT_GOT_QUICK_CLAW
UnknownScript_0x5c01d:
	writetext UnknownText_0x5c30d
	waitbutton
UnknownScript_0x5c021:
	endtext

OfficermKeithScript:
	checktime 1 << NITE
	iffalse_jumptextfaceplayer OfficermKeithDaytimeText
	checkevent EVENT_BEAT_OFFICERM_KEITH
	iftrue_jumptextfaceplayer OfficermKeithAfterText
	faceplayer
	opentext
	special SaveMusic
	playmusic MUSIC_OFFICER_ENCOUNTER
	writetext OfficermKeithSeenText
	waitbutton
	closetext
	winlosstext OfficermKeithWinText, 0
	loadtrainer OFFICERM, KEITH
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_OFFICERM_KEITH
	endtext

GenericTrainerBugManiacLou:
	generictrainer BUG_MANIAC, LOU, EVENT_BEAT_BUG_MANIAC_LOU, BugManiacLouSeenText, BugManiacLouBeatenText

	text "I used to be just"
	line "a Bug Catcher,"

	para "but I evolved into"
	line "a Bug Maniac!"
	done

GenericTrainerSchoolgirlEliza:
	generictrainer SCHOOLGIRL, ELIZA, EVENT_BEAT_SCHOOLGIRL_ELIZA, SchoolgirlElizaSeenText, SchoolgirlElizaBeatenText

	text "I don't care!"
	line "I still love"
	cont "Oddish."
	done

GenericTrainerSchoolboyJohnny:
	generictrainer SCHOOLBOY, JOHNNY, EVENT_BEAT_SCHOOLBOY_JOHNNY, SchoolboyJohnnySeenText, SchoolboyJohnnyBeatenText

	text "Yeah, well, I"
	line "still prefer"
	cont "Bellsprout."
	done

GameboyKidScript_0x5c037:
	showtextfaceplayer UnknownText_0x5c42a
	turnobject LAST_TALKED, DOWN
	end

TrainerSchoolboyJack1:
	trainer SCHOOLBOY, JACK1, EVENT_BEAT_SCHOOLBOY_JACK, SchoolboyJack1SeenText, SchoolboyJack1BeatenText, 0, SchoolboyJack1Script

SchoolboyJack1Script:
	writecode VAR_CALLERID, PHONE_SCHOOLBOY_JACK
	opentext
	checkflag ENGINE_JACK
	iftrue UnknownScript_0x5c088
	checkcellnum PHONE_SCHOOLBOY_JACK
	iftrue UnknownScript_0x5c108
	checkevent EVENT_JACK_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x5c071
	writetext UnknownText_0x5c4f3
	buttonsound
	setevent EVENT_JACK_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x5c0fc
	jump UnknownScript_0x5c074

UnknownScript_0x5c071:
	scall UnknownScript_0x5c100
UnknownScript_0x5c074:
	askforphonenumber PHONE_SCHOOLBOY_JACK
	ifequal $1, UnknownScript_0x5c110
	ifequal $2, UnknownScript_0x5c10c
	trainertotext SCHOOLBOY, JACK1, $0
	scall UnknownScript_0x5c104
	jump UnknownScript_0x5c108

UnknownScript_0x5c088:
	scall UnknownScript_0x5c114
	winlosstext SchoolboyJack1BeatenText, 0
	copybytetovar wJackFightCount
	ifequal 4, .Fight4
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight4:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
.Fight2:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer SCHOOLBOY, JACK1
	startbattle
	reloadmapafterbattle
	loadvar wJackFightCount, 1
	clearflag ENGINE_JACK
	end

.LoadFight1:
	loadtrainer SCHOOLBOY, JACK2
	startbattle
	reloadmapafterbattle
	loadvar wJackFightCount, 2
	clearflag ENGINE_JACK
	end

.LoadFight2:
	loadtrainer SCHOOLBOY, JACK3
	startbattle
	reloadmapafterbattle
	loadvar wJackFightCount, 3
	clearflag ENGINE_JACK
	end

.LoadFight3:
	loadtrainer SCHOOLBOY, JACK4
	startbattle
	reloadmapafterbattle
	loadvar wJackFightCount, 4
	clearflag ENGINE_JACK
	end

.LoadFight4:
	loadtrainer SCHOOLBOY, JACK5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_JACK
	end

UnknownScript_0x5c0fc:
	jumpstd asknumber1m

UnknownScript_0x5c100:
	jumpstd asknumber2m

UnknownScript_0x5c104:
	jumpstd registerednumberm

UnknownScript_0x5c108:
	jumpstd numberacceptedm

UnknownScript_0x5c10c:
	jumpstd numberdeclinedm

UnknownScript_0x5c110:
	jumpstd phonefullm

UnknownScript_0x5c114:
	jumpstd rematchm

GenericTrainerPokefanmWilliam:
	generictrainer POKEFANM, WILLIAM, EVENT_BEAT_POKEFANM_WILLIAM, PokefanmWilliamSeenText, PokefanmWilliamBeatenText

	text "I lost the battle,"
	line "but my #mon win"

	para "the prize for"
	line "being most lovely."
	done

TrainerPokefanfBeverly1:
	trainer POKEFANF, BEVERLY1, EVENT_BEAT_POKEFANF_BEVERLY, PokefanfBeverly1SeenText, PokefanfBeverly1BeatenText, 0, PokefanfBeverly1Script

PokefanfBeverly1Script:
	writecode VAR_CALLERID, PHONE_POKEFAN_BEVERLY
	opentext
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftrue UnknownScript_0x5c177
	checkcellnum PHONE_POKEFAN_BEVERLY
	iftrue UnknownScript_0x5c19b
	checkpoke MARILL
	iffalse UnknownScript_0x5c189
	checkevent EVENT_BEVERLY_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x5c160
	writetext UnknownText_0x5c5bd
	buttonsound
	setevent EVENT_BEVERLY_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x5c18f
	jump UnknownScript_0x5c163

UnknownScript_0x5c160:
	scall UnknownScript_0x5c193
UnknownScript_0x5c163:
	askforphonenumber PHONE_POKEFAN_BEVERLY
	ifequal $1, UnknownScript_0x5c1a3
	ifequal $2, UnknownScript_0x5c19f
	trainertotext POKEFANF, BEVERLY1, $0
	scall UnknownScript_0x5c197
	jump UnknownScript_0x5c19b

UnknownScript_0x5c177:
	scall UnknownScript_0x5c1a7
	verbosegiveitem NUGGET
	iffalse UnknownScript_0x5c186
	clearflag ENGINE_BEVERLY_HAS_NUGGET
	jump UnknownScript_0x5c19b

UnknownScript_0x5c186:
	jump UnknownScript_0x5c1ab

UnknownScript_0x5c189:
	jumpopenedtext UnknownText_0x5c68a

UnknownScript_0x5c18f:
	jumpstd asknumber1f

UnknownScript_0x5c193:
	jumpstd asknumber2f

UnknownScript_0x5c197:
	jumpstd registerednumberf

UnknownScript_0x5c19b:
	jumpstd numberacceptedf

UnknownScript_0x5c19f:
	jumpstd numberdeclinedf

UnknownScript_0x5c1a3:
	jumpstd phonefullf

UnknownScript_0x5c1a7:
	jumpstd giftf

UnknownScript_0x5c1ab:
	jumpstd packfullf

GenericTrainerLassKrise:
	generictrainer LASS, KRISE, EVENT_BEAT_LASS_KRISE, LassKriseSeenText, LassKriseBeatenText

	text "I thought you were"
	line "staring at me"
	cont "because I'm cute!"
	done

UnknownText_0x5c1d3:
	text "Look! Check out my"
	line "bag!"

	para "I pinned my badges"
	line "onto it."
	done

UnknownText_0x5c22e:
	text "This is Mail I got"
	line "from my daughter."
	cont "It cheers me up."
	done

UnknownText_0x5c265:
	text "Pay attention,"
	line "please!"

	para "…Oops, I have to"
	line "quit thinking like"

	para "a teacher all the"
	line "time."

	para "You must be a"
	line "#mon trainer."

	para "Since you're work-"
	line "ing so hard, I"

	para "want you to have"
	line "this."
	done

UnknownText_0x5c30d:
	text "Let a #mon hold"
	line "that Quick Claw."

	para "Sometimes it will"
	line "strike first"
	cont "during battle."
	done

SchoolgirlElizaSeenText:
	text "Oddish is just"
	line "the cutest!"

	para "Don't you agree?"
	done

SchoolgirlElizaBeatenText:
	text "My poor Oddish…"
	done

SchoolboyJohnnySeenText:
	text "Bellsprout is just"
	line "the coolest!"

	para "Aren't I right?"
	done

SchoolboyJohnnyBeatenText:
	text "Bellsprout, no…"
	done

UnknownText_0x5c3bc:
	text "Those kids should"
	line "battle inside the"
	cont "grass."

	para "They're disturbing"
	line "my quiet walk…"
	done

NationalParkPersianText:
	text "Persian: Fufushaa!"
	done

UnknownText_0x5c42a:
	text "I'm studying my"
	line "#dex."

	para "I want to collect"
	line "a living #-"

	para "dex with one of"
	line "each #mon."
	done

SchoolboyJack1SeenText:
	text "The world of"
	line "#mon is deep."

	para "There are still"
	line "lots of things we"
	cont "don't know."

	para "But I know more"
	line "than you do!"
	done

SchoolboyJack1BeatenText:
	text "Wha-wha-what?"
	done

UnknownText_0x5c4f3:
	text "There is a lot"
	line "to learn."

	para "For example…"

	para "There are 75 kinds" ; NUM_TMS
	line "of TMs."

	para "Traded #mon"
	line "level up faster."
	done

PokefanfBeverly1SeenText:
	text "My #mon are"
	line "simply darling."

	para "Let me tell you"
	line "how proud my"
	cont "darlings make me."
	done

PokefanfBeverly1BeatenText:
	text "I can beat you in"
	line "pride, but…"
	done

UnknownText_0x5c5bd:
	text "I must say, your"
	line "#mon are quite"
	cont "cute, too."
	done

PokefanmWilliamSeenText:
	text "We adore our #-"
	line "mon, even if they"
	cont "dislike us."

	para "That's what being"
	line "a fan is about."
	done

PokefanmWilliamBeatenText:
	text "M-my #mon!"
	done

UnknownText_0x5c68a:
	text "My friend keeps a"
	line "Marill!"

	para "I find them very"
	line "endearing."

	para "Oh, I wish for a"
	line "Marill of my own…"
	done

LassKriseSeenText:
	text "Hello? Why are you"
	line "staring at me?"

	para "Oh, a battle?"
	done

LassKriseBeatenText:
	text "…Hmmm…"
	done

BugManiacLouSeenText:
	text "Nobody can beat"
	line "my passion for"
	cont "bug #mon!"
	done

BugManiacLouBeatenText:
	text "How can this be?!"
	done

OfficermKeithSeenText:
	text "Halt! What are"
	line "you doing out"
	cont "this late?"
	done

OfficermKeithWinText:
	text "You know how to"
	line "defend yourself!"
	done

OfficermKeithAfterText:
	text "The park stays"
	line "open at night,"

	para "because Officers"
	line "like me keep it"
	cont "safe!"
	done

OfficermKeithDaytimeText:
	text "Enjoying the"
	line "park, are you?"

	para "Always take a"
	line "#mon with you"

	para "if you go in the"
	line "tall grass!"
	done

UnknownText_0x5c750:
	text "Relaxation Square"
	line "National Park"
	done

UnknownText_0x5c771:
	text "What is this"
	line "notice?"

	para "Please battle only"
	line "in the grass."

	para "National Park"
	line "Warden's Office"
	done

UnknownText_0x5c7c6:
	text "Trainer Tips"

	para "Pokemon become"
	line "happier from"

	para "haircuts, bless-"
	line "ings, photographs,"
	cont "and other treats."
	done
