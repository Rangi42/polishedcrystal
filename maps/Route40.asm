Route40_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, MonicaCallback

Route40_MapEventHeader:

.Warps: db 1
	warp_def 5, 9, 1, ROUTE_40_BATTLE_TOWER_GATE

.XYTriggers: db 0

.Signposts: db 2
	signpost 10, 14, SIGNPOST_JUMPTEXT, Route40SignText
	signpost 8, 7, SIGNPOST_ITEM + HYPER_POTION, EVENT_ROUTE_40_HIDDEN_HYPER_POTION

.PersonEvents: db 13
	person_event SPRITE_BEAUTY, 10, 8, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MonicaScript, EVENT_ROUTE_40_MONICA_OF_MONDAY
	person_event SPRITE_SWIMMER_GUY, 16, 13, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermSimon, -1
	person_event SPRITE_SWIMMER_GUY, 33, 18, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 5, TrainerSwimmermRandall, -1
	person_event SPRITE_SWIMMER_GIRL, 19, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerSwimmerfElaine, -1
	person_event SPRITE_SWIMMER_GIRL, 25, 9, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfPaula, -1
	smashrock_event 11, 7
	smashrock_event 9, 6
	smashrock_event 8, 7
	person_event SPRITE_LASS, 13, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a6429, -1
	person_event SPRITE_POKEFAN_M, 6, 7, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x1a61c7, -1
	person_event SPRITE_LASS, 4, 13, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a64e6, -1
	person_event SPRITE_YOUNGSTER, 8, 14, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route40YoungsterScript, -1
	person_event SPRITE_FISHER, 27, 16, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, Route40FisherScript, -1

const_value set 1
	const ROUTE40_MONICA

MonicaCallback:
	checkcode VAR_WEEKDAY
	if_equal MONDAY, .MonicaAppears
	disappear ROUTE40_MONICA
	return

.MonicaAppears:
	appear ROUTE40_MONICA
	return

TrainerSwimmerfElaine:
	trainer EVENT_BEAT_SWIMMERF_ELAINE, SWIMMERF, ELAINE, SwimmerfElaineSeenText, SwimmerfElaineBeatenText, 0, SwimmerfElaineScript

SwimmerfElaineScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a637b

TrainerSwimmerfPaula:
	trainer EVENT_BEAT_SWIMMERF_PAULA, SWIMMERF, PAULA, SwimmerfPaulaSeenText, SwimmerfPaulaBeatenText, 0, SwimmerfPaulaScript

SwimmerfPaulaScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a63f5

TrainerSwimmermSimon:
	trainer EVENT_BEAT_SWIMMERM_SIMON, SWIMMERM, SIMON, SwimmermSimonSeenText, SwimmermSimonBeatenText, 0, SwimmermSimonScript

SwimmermSimonScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a6282

TrainerSwimmermRandall:
	trainer EVENT_BEAT_SWIMMERM_RANDALL, SWIMMERM, RANDALL, SwimmermRandallSeenText, SwimmermRandallBeatenText, 0, SwimmermRandallScript

SwimmermRandallScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a62fa

PokefanMScript_0x1a61c7:
	checkevent EVENT_BATTLE_TOWER_OPEN
	iftrue_jumptextfaceplayer UnknownText_0x1a649b
	jumptextfaceplayer UnknownText_0x1a646a

Route40YoungsterScript:
	checkevent EVENT_BATTLE_TOWER_OPEN
	iftrue_jumptextfaceplayer UnknownText_0x1a6564
	jumptextfaceplayer Route40YoungsterText

Route40FisherScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_KNOCK_OFF_INTRO
	iftrue .HeardIntro
	writetext .IntroText
	waitbutton
	setevent EVENT_LISTENED_TO_KNOCK_OFF_INTRO
.HeardIntro:
	writetext .QuestionText
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	yesorno
	iffalse .TutorRefused
	writebyte KNOCK_OFF
	writetext .ClearText
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	thisopenedtext

	text "I'll find something"
	line "else to do…"
	done

.IntroText:
	text "I was fishing when"
	line "some #mon leap-"
	cont "ed up and knocked"

	para "my Rod into the"
	line "water!"

	para "How will I catch"
	line "anything now?"

	para "…Well then, if I"
	line "can't fish, I'll"
	cont "just teach."
	done

.QuestionText:
	text "You give me a"
	line "Silver Leaf and"

	para "I'll teach your"
	line "#mon Knock Off."

	para "How about that?"
	done

.ClearText:
	text ""
	done

.NoSilverLeaf
	waitbutton
	thisopenedtext

	text "No Leaf, no move."
	line "My time isn't free."
	done

.TeachMove
	takeitem SILVER_LEAF
	thisopenedtext

	text "Knock Off knocks"
	line "a held item away"

	para "so it can't be used"
	line "in battle."

	para "It's so frustra-"
	line "ting!"
	done

MonicaScript:
	checkevent EVENT_GOT_SHARP_BEAK_FROM_MONICA
	iftrue_jumptextfaceplayer MonicaMondayText
	checkcode VAR_WEEKDAY
	if_not_equal MONDAY, MonicaNotMondayScript
	faceplayer
	opentext
	checkevent EVENT_MET_MONICA_OF_MONDAY
	iftrue .MetMonica
	writetext MeetMonicaText
	buttonsound
	setevent EVENT_MET_MONICA_OF_MONDAY
.MetMonica:
	writetext MonicaGivesGiftText
	buttonsound
	verbosegiveitem SHARP_BEAK
	iffalse MonicaDoneScript
	setevent EVENT_GOT_SHARP_BEAK_FROM_MONICA
	jumpopenedtext MonicaGaveGiftText

MonicaNotMondayScript:
	jumptextfaceplayer MonicaNotMondayText

MonicaDoneScript:
	end

SwimmermSimonSeenText:
	text "You have to warm"
	line "up before going"
	cont "into the water."

	para "That's basic."
	done

SwimmermSimonBeatenText:
	text "OK! Uncle! I give!"
	done

UnknownText_0x1a6282:
	text "Cianwood City is"
	line "a good distance"
	cont "away from here."
	done

SwimmermRandallSeenText:
	text "Hey, you're young"
	line "and fit!"

	para "Don't ride your"
	line "#mon! Swim!"
	done

SwimmermRandallBeatenText:
	text "Uh-oh. I lost…"
	done

UnknownText_0x1a62fa:
	text "Swimming exercises"
	line "your entire body."
	cont "It's healthy."
	done

SwimmerfElaineSeenText:
	text "Are you going to"
	line "Cianwood?"

	para "How about a quick"
	line "battle first?"
	done

SwimmerfElaineBeatenText:
	text "I lost that one!"
	done

UnknownText_0x1a637b:
	text "I'd say I'm a bet-"
	line "ter swimmer than"
	cont "you. Yeah!"
	done

SwimmerfPaulaSeenText:
	text "No inner tube for"
	line "me."

	para "I'm hanging on to"
	line "a sea #mon!"
	done

SwimmerfPaulaBeatenText:
	text "Ooh, I'm feeling"
	line "dizzy!"
	done

UnknownText_0x1a63f5:
	text "While I float like"
	line "this, the waves"
	cont "carry me along."
	done

UnknownText_0x1a6429:
	text "Although you can't"
	line "see it from here,"

	para "Cianwood is across"
	line "the sea."
	done

UnknownText_0x1a646a:
	text "Hm! There's a big"
	line "building up ahead!"

	para "What is it?"
	done

UnknownText_0x1a649b:
	text "Hm! Look at all"
	line "those serious-"
	cont "looking trainers"
	cont "streaming in."

	para "What? What?"
	done

UnknownText_0x1a64e6:
	text "I came to Olivine"
	line "by ship to see the"

	para "sights and soak up"
	line "the atmosphere."

	para "Being a port, it"
	line "feels so different"
	cont "from a big city."
	done

Route40YoungsterText:
	text "The Battle Tower"
	line "is almost ready!"

	para "Trainers are head-"
	line "ing to Olivine"

	para "from all over the"
	line "world to test"
	cont "their strength."
	done

UnknownText_0x1a6564:
	text "Have you gone to"
	line "the Battle Tower?"

	para "I think a lot of"
	line "tough trainers"

	para "have gathered"
	line "there already."

	para "But since you have"
	line "so many Badges,"

	para "you shouldn't do"
	line "badly at all."
	done

MeetMonicaText:
	text "Monica: Glad to"
	line "meet you. I'm"

	para "Monica of Monday."
	done

MonicaGivesGiftText:
	text "As a token of our"
	line "friendship, I have"
	cont "a gift for you!"
	done

MonicaGaveGiftText:
	text "Monica: It's an"
	line "item that raises"

	para "the power of Fly-"
	line "ing-type moves."

	para "You should equip a"
	line "bird #mon with"
	cont "that item."
	done

MonicaMondayText:
	text "Monica: My broth-"
	line "ers and sisters"

	para "are all over the"
	line "place."

	para "See if you could"
	line "find them all!"
	done

MonicaNotMondayText:
	text "Monica: I don't"
	line "think today is"
	cont "Monday. How sad…"
	done

Route40SignText:
	text "Route 40"

	para "Cianwood City -"
	line "Olivine City"
	done
