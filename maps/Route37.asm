Route37_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, SunnyCallback

Route37_MapEventHeader:

.Warps: db 0

.XYTriggers: db 0

.Signposts: db 2
	signpost 3, 5, SIGNPOST_JUMPTEXT, Route37SignText
	signpost 2, 4, SIGNPOST_ITEM + ETHER, EVENT_ROUTE_37_HIDDEN_ETHER

.PersonEvents: db 9
	person_event SPRITE_BUG_CATCHER, 8, 16, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SunnyScript, EVENT_ROUTE_37_SUNNY_OF_SUNDAY
	person_event SPRITE_TWIN, 12, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsToriandtil1, -1
	person_event SPRITE_TWIN, 12, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsToriandtil2, -1
	person_event SPRITE_YOUNGSTER, 11, 14, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPsychicGreg, -1
	fruittree_event 5, 13, FRUITTREE_ROUTE_37_1, RED_APRICORN
	fruittree_event 5, 16, FRUITTREE_ROUTE_37_2, BLU_APRICORN
	fruittree_event 7, 15, FRUITTREE_ROUTE_37_3, BLK_APRICORN
	person_event SPRITE_BEAUTY, 6, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBeautyCallie, -1
	person_event SPRITE_BEAUTY, 6, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBeautyCassandra, -1

const_value set 1
	const ROUTE37_SUNNY

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
	jumptextfaceplayer UnknownText_0x1a8e62

TrainerTwinsToriandtil2:
	trainer EVENT_BEAT_TWINS_ANN_AND_ANNE, TWINS, ANNANDANNE2, TwinsToriandtil2SeenText, TwinsToriandtil2BeatenText, 0, TwinsToriandtil2Script

TwinsToriandtil2Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a8eec

TrainerPsychicGreg:
	trainer EVENT_BEAT_PSYCHIC_GREG, PSYCHIC_T, GREG, PsychicGregSeenText, PsychicGregBeatenText, 0, PsychicGregScript

PsychicGregScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a8f80

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
	jumpopenedtext SunnyGaveGiftText

SunnySundayScript:
	writetext SunnySundayText
	waitbutton
SunnyDoneScript:
	endtext

SunnyNotSundayScript:
	jumpopenedtext SunnyNotSundayText

TrainerBeautyCallie:
	trainer EVENT_BEAT_BEAUTY_CALLIE, BEAUTY, CALLIE, BeautyCallieSeenText, BeautyCallieBeatenText, 0, BeautyCallieScript

BeautyCallieScript:
	end_if_just_battled
	jumptextfaceplayer BeautyCallieAfterText

TrainerBeautyCassandra:
	trainer EVENT_BEAT_BEAUTY_CASSANDRA, BEAUTY, CASSANDRA, BeautyCassandraSeenText, BeautyCassandraBeatenText, 0, BeautyCassandraScript

BeautyCassandraScript:
	end_if_just_battled
	jumptextfaceplayer BeautyCassandraAfterText

TwinsToriandtil1SeenText:
	text "Til: Tori and I"
	line "are in this to-"
	cont "gether!"
	done

TwinsToriandtil1BeatenText:
TwinsToriandtil2BeatenText:
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
	line "you young trainer!"

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
