DEF FIGHTINGDOJO_REMATCH_VARSPRITE_1 EQU SPRITE_BIG_DOLL
DEF FIGHTINGDOJO_REMATCH_VARSPRITE_2 EQU SPRITE_COPYCAT
DEF FIGHTINGDOJO_REMATCH_VARSPRITE_3 EQU SPRITE_CONSOLE

FightingDojo_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, FightingDojoSetupRematchesCallback

	def_warp_events
	warp_event  4, 11, SAFFRON_CITY, 1
	warp_event  5, 11, SAFFRON_CITY, 1

	def_coord_events

	def_bg_events
	bg_event  4,  0, BGEVENT_JUMPTEXT, FightingDojoSign1Text
	bg_event  5,  0, BGEVENT_JUMPTEXT, FightingDojoSign2Text
	bg_event  9,  0, BGEVENT_READ, MapFightingDojoSignpost2Script

	def_object_events
	object_event  0,  1, FIGHTINGDOJO_REMATCH_VARSPRITE_1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FightingDojoRematch1Script, EVENT_REMATCH_GYM_LEADER_1
	object_event  0,  2, FIGHTINGDOJO_REMATCH_VARSPRITE_2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FightingDojoRematch2Script, EVENT_REMATCH_GYM_LEADER_2
	object_event  0,  3, FIGHTINGDOJO_REMATCH_VARSPRITE_3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FightingDojoRematch3Script, EVENT_REMATCH_GYM_LEADER_3
	object_event  4,  3, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FightingDojoBlackBelt, -1

	object_const_def
	const FIGHTINGDOJO_REMATCH_1
	const FIGHTINGDOJO_REMATCH_2
	const FIGHTINGDOJO_REMATCH_3

FightingDojoSetupRematchesCallback:
	disappear FIGHTINGDOJO_REMATCH_1
	disappear FIGHTINGDOJO_REMATCH_2
	disappear FIGHTINGDOJO_REMATCH_3
	checkevent EVENT_BEAT_BLUE
	iftruefwd .SetupDailyRematches
	endcallback

MACRO rematch ; person, sprite, x, y, face, palette
	moveobject FIGHTINGDOJO_REMATCH_\1, \3, \4
	turnobject FIGHTINGDOJO_REMATCH_\1, \5
	setmapobjectpal FIGHTINGDOJO_REMATCH_\1, PAL_NPC_\6
	appear FIGHTINGDOJO_REMATCH_\1
	variablesprite FIGHTINGDOJO_REMATCH_VARSPRITE_\1, SPRITE_\2
ENDM

.SetupDailyRematches:
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .Monday
	ifequalfwd TUESDAY, .Tuesday
	ifequalfwd WEDNESDAY, .Wednesday
	ifequal THURSDAY, .Thursday
	ifequal FRIDAY, .Friday
	ifequal SATURDAY, .Saturday

.Sunday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .SundayNight
.SundayMorningAndDay
	rematch 1, JASMINE, 3, 6, RIGHT, RED
	rematch 2, ERIKA, 6, 6, LEFT, GREEN
	endcallback
.SundayNight
	rematch 3, SABRINA, 6, 4, DOWN, RED
	endcallback

.Monday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .MondayNight
.MondayMorningAndDay
	rematch 1, FALKNER, 3, 5, RIGHT, BLUE
	rematch 2, JANINE, 6, 5, LEFT, PURPLE
	endcallback
.MondayNight
	checkevent EVENT_BEAT_WALKER
	iffalsefwd .NoWalker
	rematch 3, WALKER, 8, 4, DOWN, BLUE
.NoWalker
	endcallback

.Tuesday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .TuesdayNight
.TuesdayMorningAndDay
	rematch 1, PRYCE, 3, 6, RIGHT, BROWN
	rematch 2, BLAINE, 6, 6, LEFT, BROWN
	endcallback
.TuesdayNight
	checkevent EVENT_BEAT_LORELEI_AGAIN
	iffalsefwd .NoLorelei
	rematch 3, LORELEI, 6, 4, DOWN, RED
.NoLorelei
	endcallback

.Wednesday
	checktime 1 << MORN
	iftruefwd .WednesdayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .WednesdayNight
.WednesdayDay
	rematch 1, BROCK, 3, 7, RIGHT, BROWN
	rematch 2, MISTY, 3, 5, RIGHT, ORANGE
	rematch 3, BLUE, 6, 6, LEFT, BLUE
	endcallback
.WednesdayMorning
	rematch 1, BROCK, 3, 5, RIGHT, BROWN
	rematch 2, MISTY, 6, 5, LEFT, ORANGE
	endcallback
.WednesdayNight
	rematch 3, BLUE, 8, 4, DOWN, BLUE
	endcallback

.Thursday
	checktime 1 << MORN
	iftruefwd .ThursdayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .ThursdayNight
.ThursdayDay
	checkevent EVENT_BEAT_PALMER
	iffalsefwd .NoPalmer
	rematch 3, PALMER, 3, 6, DOWN, GREEN
.NoPalmer
	endcallback
.ThursdayMorning
	rematch 1, BUGSY, 1, 6, DOWN, GREEN
	endcallback
.ThursdayNight
	rematch 2, MORTY, 2, 4, DOWN, BROWN
	endcallback

.Friday
	checktime 1 << MORN
	iftruefwd .FridayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .FridayNight
.FridayDay
	checkevent EVENT_BEAT_YELLOW
	iffalsefwd .NoYellow
	rematch 3, YELLOW, 6, 6, DOWN, ORANGE
.NoYellow
	endcallback
.FridayMorning
	rematch 1, SURGE, 6, 7, DOWN, BROWN
	endcallback
.FridayNight
	rematch 2, CLAIR, 2, 6, RIGHT, BLUE
	endcallback

.Saturday
	checktime 1 << MORN
	iftruefwd .SaturdayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .SaturdayNight
.SaturdayDay
	rematch 1, WHITNEY, 3, 6, RIGHT, RED
	rematch 2, CHUCK, 6, 6, LEFT, BROWN
	endcallback
.SaturdayMorning
	rematch 1, WHITNEY, 3, 6, RIGHT, RED
	endcallback
.SaturdayNight
	checkevent EVENT_BEAT_AGATHA
	iffalsefwd .NoAgatha
	rematch 3, AGATHA, 2, 4, DOWN, BROWN
.NoAgatha
	endcallback

FightingDojoBlackBelt:
	checkevent EVENT_BEAT_BLUE
	iftrue_jumptextfaceplayer BlackBeltText_ExplainsRematches
	jumpthistextfaceplayer

	text "Hello!"

	para "Karate King, the"
	line "Fighting Dojo's"

	para "master, is in a"
	line "cave in Johto for"
	cont "training."
	done

MapFightingDojoSignpost2Script:
	opentext
	writetext FightingDojoScheduleQuestionText
	yesorno
	iffalse_endtext
.sunday
	writetext FightingDojoScheduleSundayText
	waitbutton
.monday
	checkevent EVENT_BEAT_WALKER
	iftruefwd .monday_walker
	writetext FightingDojoScheduleMondayText
	waitbutton
	sjumpfwd .tuesday
.monday_walker
	writetext FightingDojoScheduleMondayWalkerText
	waitbutton
.tuesday
	checkevent EVENT_BEAT_LORELEI_AGAIN
	iftruefwd .tuesday_lorelei
	writetext FightingDojoScheduleTuesdayText
	waitbutton
	sjumpfwd .wednesday
.tuesday_lorelei
	writetext FightingDojoScheduleTuesdayLoreleiText
	waitbutton
.wednesday
	writetext FightingDojoScheduleWednesdayText
	waitbutton
.thursday
	checkevent EVENT_BEAT_PALMER
	iftruefwd .thursday_palmer
	writetext FightingDojoScheduleThursdayText
	waitbutton
	sjumpfwd .friday
.thursday_palmer
	writetext FightingDojoScheduleThursdayPalmerText
	waitbutton
.friday
	checkevent EVENT_BEAT_YELLOW
	iftruefwd .friday_yellow
	writetext FightingDojoScheduleFridayText
	waitbutton
	sjumpfwd .saturday
.friday_yellow
	writetext FightingDojoScheduleFridayYellowText
	waitbutton
.saturday
	checkevent EVENT_BEAT_AGATHA
	iftruefwd .saturday_agatha
	jumpthisopenedtext

	text "Saturday: Whitney,"
	line "Chuck, ???"
	done
.saturday_agatha
	jumpthisopenedtext

	text "Saturday: Whitney,"
	line "Chuck, Agatha"
	done

BlackBeltText_ExplainsRematches:
	text "Gym Leaders from"
	line "Kanto and Johto"

	para "come to this"
	line "Fighting Dojo"
	cont "to train."

	para "You should join"
	line "them!"
	done

FightingDojoSign1Text:
	text "What goes around"
	line "comes around!"
	done

FightingDojoSign2Text:
	text "Enemies on every"
	line "side!"
	done

MACRO rematch_script
	; rematch_script name, trainer, flag
	checkflag ENGINE_GYM_LEADER_REMATCH_\3
	iftrue_jumptextfaceplayer \1Text_Done
	faceplayer
	showtext \1Text_Greeting
	winlosstext \1Text_WinLoss, 0
	loadtrainer \2, 2
	startbattle
	reloadmapafterbattle
	setflag ENGINE_GYM_LEADER_REMATCH_\3
	end
ENDM

FightingDojoRematch1Script:
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .Falkner
	ifequalfwd TUESDAY, .Pryce
	ifequalfwd WEDNESDAY, .Brock
	ifequalfwd THURSDAY, .Bugsy
	ifequalfwd FRIDAY, .Surge
	ifequalfwd SATURDAY, .Whitney

.Jasmine
	rematch_script Jasmine, JASMINE, 1

.Falkner
	rematch_script Falkner, FALKNER, 1

.Pryce
	rematch_script Pryce, PRYCE, 1

.Brock
	rematch_script Brock, BROCK, 1

.Bugsy
	rematch_script Bugsy, BUGSY, 1

.Surge
	rematch_script Surge, LT_SURGE, 1

.Whitney
	rematch_script Whitney, WHITNEY, 1

FightingDojoRematch2Script:
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .Janine
	ifequalfwd TUESDAY, .Blaine
	ifequalfwd WEDNESDAY, .Misty
	ifequalfwd THURSDAY, .Morty
	ifequalfwd FRIDAY, .Clair
	ifequalfwd SATURDAY, .Chuck

.Erika
	rematch_script Erika, ERIKA, 2

.Janine
	rematch_script Janine, JANINE, 2

.Blaine
	rematch_script Blaine, BLAINE, 2

.Misty
	rematch_script Misty, MISTY, 2

.Morty
	rematch_script Morty, MORTY, 2

.Clair
	rematch_script Clair, CLAIR, 2

.Chuck
	rematch_script Chuck, CHUCK, 2

FightingDojoRematch3Script:
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .Walker
	ifequalfwd TUESDAY, .Lorelei
	ifequalfwd WEDNESDAY, .Blue
	ifequalfwd THURSDAY, .Palmer
	ifequalfwd FRIDAY, .Yellow
	ifequalfwd SATURDAY, .Agatha

.Sabrina
	rematch_script Sabrina, SABRINA, 3

.Walker
	rematch_script Walker, WALKER, 3

.Lorelei
	rematch_script Lorelei, LORELEI, 3

.Blue
	rematch_script Blue, BLUE, 3

.Palmer
	rematch_script Palmer, TOWERTYCOON, 3

.Yellow
	rematch_script Yellow, YELLOW, 3

.Agatha
	rematch_script Agatha, AGATHA, 3

BrockText_Greeting:
	text "I like Rock-type"
	line "#mon best."

	para "They're solid and"
	line "rough, yet brittle"
	cont "at the same time."

	para "You'll see how"
	line "much stronger my"

	para "rock #mon have"
	line "become!"
	done

MistyText_Greeting:
	text "I've heard a lot"
	line "of good things"

	para "about you since"
	line "our last battle."

	para "Let me test how"
	line "good you are!"
	done

SurgeText_Greeting:
	text "I can feel great"
	line "electric power"

	para "around the Magnet"
	line "Train station!"

	para "I'm psyched for"
	line "an electrifying"
	cont "battle!"
	done

ErikaText_Greeting:
	text "Good to see you"
	line "again!"

	para "How are you?"

	para "This place doesn't"
	line "really suit me,"
	cont "but…"

	para "let's ignore that"
	line "and battle!"
	done

JanineText_Greeting:
	text "I can't use my"
	line "ninja technique,"

	para "but I won't let"
	line "you win!"
	done

SabrinaText_Greeting:
	text "I knew you'd come"
	line "battle me again."

	para "I had a feeling."
	done

BlaineText_Greeting:
	text "My Gym is still"
	line "gone, so let's"

	para "hold our rematch"
	line "right here!"
	done

BlueText_Greeting:
	text "Good! You're"
	line "here too."

	para "Thanks for coming"
	line "to lose to me!"
	done

FalknerText_Greeting:
	text "I'm in top form"
	line "today."

	para "It's a pleasure to"
	line "be able to battle"
	cont "you again!"
	done

BugsyText_Greeting:
	text "Good to see you"
	line "again! Behold my"
	cont "bug research!"
	done

WhitneyText_Greeting:
	text "Hi, <PLAYER>!"
	line "Since we're both"

	para "here, let's have"
	line "a battle!"

	para "Are you ready?"
	done

MortyText_Greeting:
	text "The legendary"
	line "#mon did not"
	cont "choose me…"

	para "But that does not"
	line "mean I have lost"

	para "out on my future."
	line "Let's battle!"
	done

ChuckText_Greeting:
	text "There you are!"

	para "Taste my 24-hour"
	line "training!"
	done

JasmineText_Greeting:
	text "Hello, <PLAYER>…"
	line "How are you?"
	cont "I'm doing well…"

	para "Anyway, are you"
	line "prepared to"
	cont "battle me again?"
	done

PryceText_Greeting:
	text "No need for words."
	line "A #mon battle"

	para "is the way for us"
	line "to communicate."
	done

ClairText_Greeting:
	text "…So you are here."

	para "Now let's battle!"
	done

PalmerText_Greeting:
	text "So, you've come"
	line "this far!"

	para "As the Tower"
	line "Tycoon, I'll have"

	para "to give you my"
	line "best effort."

	para "That's how the best"
	line "trainers show"

	para "respect to each"
	line "other."

	para "By battling all-"
	line "out as dedicated"

	para "students of"
	line "#mon!"
	done

LoreleiText_Greeting:
	text "Hello again,"
	line "<PLAYER>."

	para "We're on my home"
	line "ground now."

	para "I won't lose!"
	done

AgathaText_Greeting:
	text "Hello, child."

	para "You're still"
	line "filling a #dex"

	para "for that old duff"
	line "Oak?"

	para "#mon are for"
	line "battling!"

	para "Show me your"
	line "real talent"
	cont "as a trainer!"
	done

WalkerText_Greeting:
	text "Hey there,"
	line "<PLAYER>!"

	para "Seems like I just"
	line "missed my son"

	para "Falkner here"
	line "earlier…"

	para "How about if we"
	line "battle instead?"
	done

YellowText_Greeting:
	text "Hi, <PLAYER>!"

	para "Let me see…"

	para "Yes! You still"
	line "take good care of"
	cont "your #mon!"

	para "You've gotten"
	line "stronger, but so"
	cont "have I!"
	done

BrockText_WinLoss:
	text "I've lost again…"

	para "You aren't adven-"
	line "turing around"
	cont "for nothing!"
	done

MistyText_WinLoss:
	text "Wow! You're"
	line "getting stronger"
	cont "by the battle!"
	done

SurgeText_WinLoss:
	text "You're very"
	line "strong!"

	para "But I'll repay my"
	line "debt someday!"
	done

ErikaText_WinLoss:
	text "You have grown"
	line "even stronger…"
	done

JanineText_WinLoss:
	text "I lost today, but"
	line "I'll win next time!"
	done

SabrinaText_WinLoss:
	text "I know… we will"
	line "meet again some-"
	cont "time."
	done

BlaineText_WinLoss:
	text "Waaah! I've burned"
	line "out again!"
	done

BlueText_WinLoss:
	text "Just as I"
	line "expected!"

	para "No wonder you've"
	line "become the"
	cont "Champion…"
	done

FalknerText_WinLoss:
	text "Mmm… It's still a"
	line "long way to become"
	cont "the best trainer…"
	done

BugsyText_WinLoss:
	text "You must have"
	line "studied a lot"
	cont "about #mon!"
	done

WhitneyText_WinLoss:
	text "You really are"
	line "strong!"

	para "But I won't lose"
	line "next time!"
	done

MortyText_WinLoss:
	text "I've lost again…"
	line "You have something"

	para "more than just"
	line "strength."
	done

ChuckText_WinLoss:
	text "Wahaha!"
	line "A battle with you"
	cont "is never boring!"
	done

JasmineText_WinLoss:
	text "True to your"
	line "reputation…"
	done

PryceText_WinLoss:
	text "Mmm… Impressive!"
	done

ClairText_WinLoss:
	text "Way to go."
	line "…"

	para "Now give it"
	line "your all!"
	done

PalmerText_WinLoss:
	text "Bravo! I feel"
	line "inspired in my"
	cont "heart!"
	done

LoreleiText_WinLoss:
	text "How dare you!"
	done

AgathaText_WinLoss:
	text "Woo-hoo!"
	done

WalkerText_WinLoss:
	text "I was no match"
	line "for you!"
	done

YellowText_WinLoss:
	text "Hahaha!"
	done

BrockText_Done:
MistyText_Done:
SurgeText_Done:
ErikaText_Done:
JanineText_Done:
SabrinaText_Done:
BlaineText_Done:
BlueText_Done:
FalknerText_Done:
BugsyText_Done:
WhitneyText_Done:
MortyText_Done:
ChuckText_Done:
JasmineText_Done:
PryceText_Done:
ClairText_Done:
PalmerText_Done:
LoreleiText_Done:
AgathaText_Done:
WalkerText_Done:
YellowText_Done:
	text "I'm done battling"
	line "for today."
	done

FightingDojoScheduleQuestionText:
	text "It's a training"
	line "schedule! Read it?"
	done

FightingDojoScheduleSundayText:
	text "Sunday: Jasmine,"
	line "Erika, Sabrina"
	done

FightingDojoScheduleMondayText:
	text "Monday: Falkner,"
	line "Janine, ???"
	done

FightingDojoScheduleMondayWalkerText:
	text "Monday: Falkner,"
	line "Janine, Walker"
	done

FightingDojoScheduleTuesdayText:
	text "Tuesday: Pryce,"
	line "Blaine, ???"
	done

FightingDojoScheduleTuesdayLoreleiText:
	text "Tuesday: Pryce,"
	line "Blaine, Lorelei"
	done

FightingDojoScheduleWednesdayText:
	text "Wednesday: Brock,"
	line "Misty, Blue"
	done

FightingDojoScheduleThursdayText:
	text "Thursday: Bugsy,"
	line "???, Morty"
	done

FightingDojoScheduleThursdayPalmerText:
	text "Thursday: Bugsy,"
	line "Palmer, Morty"
	done

FightingDojoScheduleFridayText:
	text "Friday: Lt.Surge,"
	line "???, Clair"
	done

FightingDojoScheduleFridayYellowText:
	text "Friday: Lt.Surge,"
	line "Yellow, Clair"
	done
