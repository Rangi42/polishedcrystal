const_value set 2
	const ROUTE37_WEIRD_TREE1
	const ROUTE37_WEIRD_TREE2
	const ROUTE37_YOUNGSTER
	const ROUTE37_FRUIT_TREE1
	const ROUTE37_SUNNY
	const ROUTE37_FRUIT_TREE2
	const ROUTE37_FRUIT_TREE3
	const ROUTE37_BEAUTY1
	const ROUTE37_BEAUTY2

Route37_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_OBJECTS, SunnyCallback

SunnyCallback:
	checkcode VAR_WEEKDAY
	if_equal SUNDAY, .SunnyAppears
	disappear ROUTE37_SUNNY
	return

.SunnyAppears:
	appear ROUTE37_SUNNY
	return

TrainerTwinsToriandtil1:
	trainer EVENT_BEAT_TWINS_ANN_AND_ANNE, TWINS, ANNANDANNE1, TwinsToriandtil1SeenText, TwinsToriandtil1BeatenText, 0, TwinsToriandtil1Script

TwinsToriandtil1Script:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a8e62
	waitbutton
	closetext
	end

TrainerTwinsToriandtil2:
	trainer EVENT_BEAT_TWINS_ANN_AND_ANNE, TWINS, ANNANDANNE2, TwinsToriandtil2SeenText, TwinsToriandtil2BeatenText, 0, TwinsToriandtil2Script

TwinsToriandtil2Script:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a8eec
	waitbutton
	closetext
	end

TrainerPsychicGreg:
	trainer EVENT_BEAT_PSYCHIC_GREG, PSYCHIC_T, GREG, PsychicGregSeenText, PsychicGregBeatenText, 0, PsychicGregScript

PsychicGregScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a8f80
	waitbutton
	closetext
	end

SunnyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_MAGNET_FROM_SUNNY
	iftrue SunnySundayScript
	checkcode VAR_WEEKDAY
	if_not_equal SUNDAY, SunnyNotSundayScript
	checkevent EVENT_MET_SUNNY_OF_SUNDAY
	iftrue .MetSunny
	writetext MeetSunnyText
	buttonsound
	setevent EVENT_MET_SUNNY_OF_SUNDAY
.MetSunny:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Kris
	writetext SunnyGivesGiftText1
	buttonsound
	jump .next
.Kris:
	writetext SunnyGivesGiftText2
	buttonsound
.next
	verbosegiveitem MAGNET
	iffalse SunnyDoneScript
	setevent EVENT_GOT_MAGNET_FROM_SUNNY
	writetext SunnyGaveGiftText
	waitbutton
	closetext
	end

SunnySundayScript:
	writetext SunnySundayText
	waitbutton
SunnyDoneScript:
	closetext
	end

SunnyNotSundayScript:
	writetext SunnyNotSundayText
	waitbutton
	closetext
	end

TrainerBeautyCallie:
	trainer EVENT_BEAT_BEAUTY_CALLIE, BEAUTY, CALLIE, BeautyCallieSeenText, BeautyCallieBeatenText, 0, BeautyCallieScript

BeautyCallieScript:
	end_if_just_battled
	opentext
	writetext BeautyCallieAfterText
	waitbutton
	closetext
	end

TrainerBeautyCassandra:
	trainer EVENT_BEAT_BEAUTY_CASSANDRA, BEAUTY, CASSANDRA, BeautyCassandraSeenText, BeautyCassandraBeatenText, 0, BeautyCassandraScript

BeautyCassandraScript:
	end_if_just_battled
	opentext
	writetext BeautyCassandraAfterText
	waitbutton
	closetext
	end

Route37Sign:
	jumptext Route37SignText

FruitTreeScript_0x1a8e09:
	fruittree FRUITTREE_ROUTE_37_1

FruitTreeScript_0x1a8e0b:
	fruittree FRUITTREE_ROUTE_37_2

FruitTreeScript_0x1a8e0d:
	fruittree FRUITTREE_ROUTE_37_3

Route37HiddenEther:
	dwb EVENT_ROUTE_37_HIDDEN_ETHER, ETHER


TwinsToriandtil1SeenText:
	text "Til: Tori and I"
	line "are in this to-"
	cont "gether!"
	done

TwinsToriandtil1BeatenText:
	text "Til & Tori: Nnn… A"
	line "little too strong."
	done

UnknownText_0x1a8e62:
	text "Til: I can tell"
	line "what my sister and"

	para "my #mon are"
	line "thinking."
	done

TwinsToriandtil2SeenText:
	text "Tori: Til and I"
	line "are in this to-"
	cont "gether!"
	done

TwinsToriandtil2BeatenText:
	text "Til & Tori: Nnn… A"
	line "little too strong."
	done

UnknownText_0x1a8eec:
	text "Tori: We share the"
	line "same feelings as"
	cont "our #mon."
	done

PsychicGregSeenText:
	text "#mon can't do a"
	line "thing if they are"
	cont "asleep."

	para "I'll show you how"
	line "scary that is!"
	done

PsychicGregBeatenText:
	text "I lost. That's"
	line "pretty sad…"
	done

UnknownText_0x1a8f80:
	text "Putting #mon to"
	line "sleep or paralyz-"
	cont "ing them are good"
	cont "battle techniques."
	done

MeetSunnyText:
	text "Sunny: Hi!"

	para "I'm Sunny of Sun-"
	line "day, meaning it's"
	cont "Sunday today!"
	done

SunnyGivesGiftText1:
	text "I was told to give"
	line "you this if I saw"
	cont "you!"
	done

SunnyGivesGiftText2:
	text "I was told to give"
	line "you this if I saw"
	cont "you!"
	done

SunnyGaveGiftText:
	text "Sunny: That thing…"

	para "Um…"

	para "…What was it now…"

	para "…"

	para "Oh! I remember"
	line "now!"

	para "A #mon that"
	line "knows Electric"

	para "moves should hold"
	line "it."

	para "My sis Monica said"
	line "it powers up"
	cont "Electric moves!"
	done

SunnySundayText:
	text "Sunny: My sisters"
	line "and brothers are"
	cont "Monica, Tuscany,"
	cont "Wesley, Arthur,"
	cont "Frieda and Santos."

	para "They're all older"
	line "than me!"
	done

SunnyNotSundayText:
	text "Sunny: Isn't today"
	line "Sunday?"
	cont "Um… I forgot!"
	done

BeautyCallieSeenText:
	text "Oh, you're a cute"
	line "little trainer!"

	para "Why don't you"
	line "battle me?"
	done

BeautyCallieBeatenText:
	text "You're good…"
	done

BeautyCallieAfterText:
	text "Wow, you're cute"
	line "and skilled too!"
	done

BeautyCassandraSeenText:
	text "Hey hey there,"
	line "you young Trainer!"

	para "Won't you battle"
	line "with me?"
	done

BeautyCassandraBeatenText:
	text "Wow, you're strong…"
	done

BeautyCassandraAfterText:
	text "People like you"
	line "are skilled even"

	para "though they're"
	line "young…"
	done

Route37SignText:
	text "Route 37"
	done

Route37_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 3, 5, SIGNPOST_READ, Route37Sign
	signpost 2, 4, SIGNPOST_ITEM, Route37HiddenEther

.PersonEvents:
	db 9
	person_event SPRITE_TWIN, 12, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsToriandtil1, -1
	person_event SPRITE_TWIN, 12, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsToriandtil2, -1
	person_event SPRITE_YOUNGSTER, 11, 14, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPsychicGreg, -1
	person_event SPRITE_BALL_CUT_FRUIT, 5, 13, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FruitTreeScript_0x1a8e09, -1
	person_event SPRITE_BUG_CATCHER, 8, 16, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SunnyScript, EVENT_ROUTE_37_SUNNY_OF_SUNDAY
	person_event SPRITE_BALL_CUT_FRUIT, 5, 16, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FruitTreeScript_0x1a8e0b, -1
	person_event SPRITE_BALL_CUT_FRUIT, 7, 15, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FruitTreeScript_0x1a8e0d, -1
	person_event SPRITE_BEAUTY, 6, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBeautyCallie, -1
	person_event SPRITE_BEAUTY, 6, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBeautyCassandra, -1
