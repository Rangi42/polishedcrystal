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
	object_event  0,  1, SPRITE_BIG_DOLL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RematchRed0Script, EVENT_REMATCH_GYM_LEADER_1
	object_event  0,  2, SPRITE_COPYCAT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RematchGreen1Script, EVENT_REMATCH_GYM_LEADER_2
	object_event  0,  3, SPRITE_COPYCAT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RematchBlue1Script, EVENT_REMATCH_GYM_LEADER_3
	object_event  0,  4, SPRITE_CONSOLE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RematchBlue2Script, EVENT_REMATCH_GYM_LEADER_4
	object_event  0,  5, SPRITE_COPYCAT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, RematchBrown1Script, EVENT_REMATCH_GYM_LEADER_5
	object_event  0,  6, SPRITE_CONSOLE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, RematchBrown2Script, EVENT_REMATCH_GYM_LEADER_6
	object_event  4,  4, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FightingDojoBlackBelt, -1

	object_const_def
	const REMATCH_RED_1
	const REMATCH_GREEN_2
	const REMATCH_BLUE_2
	const REMATCH_BLUE_3
	const REMATCH_BROWN_2
	const REMATCH_BROWN_3

FightingDojoSetupRematchesCallback:
	disappear REMATCH_RED_1
	disappear REMATCH_GREEN_2
	disappear REMATCH_BLUE_2
	disappear REMATCH_BLUE_3
	disappear REMATCH_BROWN_2
	disappear REMATCH_BROWN_3
	checkevent EVENT_BEAT_BLUE
	iftrue .SetupDailyRematches
	endcallback

rematch: MACRO
	; rematch person, varsprite, sprite, y, x, face
	moveobject \1, \5, \4
	turnobject \1, \6
	appear \1
	variablesprite \2, \3
ENDM

rematch_left: MACRO
	; rematch_left person, varsprite, sprite
	rematch \1, \2, \3, 6, 3, RIGHT
ENDM

rematch_right: MACRO
	; rematch_right person, varsprite, sprite
	rematch \1, \2, \3, 6, 6, LEFT
ENDM

.SetupDailyRematches:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Monday
	ifequal TUESDAY, .Tuesday
	ifequal WEDNESDAY, .Wednesday
	ifequal THURSDAY, .Thursday
	ifequal FRIDAY, .Friday
	ifequal SATURDAY, .Saturday

.Sunday
	checktime (1 << EVE) | (1 << NITE)
	iftrue .SundayNight
.SundayMorningAndDay
	rematch_left REMATCH_RED_1, SPRITE_BIG_DOLL, SPRITE_JASMINE
	rematch_right REMATCH_GREEN_2, SPRITE_COPYCAT, SPRITE_ERIKA
	endcallback
.SundayNight
	rematch REMATCH_RED_1, SPRITE_BIG_DOLL, SPRITE_SABRINA, 4, 6, DOWN
	endcallback

.Monday
	checktime (1 << EVE) | (1 << NITE)
	iftrue .MondayNight
.MondayMorningAndDay
	rematch_left REMATCH_BLUE_2, SPRITE_COPYCAT, SPRITE_FALKNER
	rematch_right REMATCH_BLUE_3, SPRITE_CONSOLE, SPRITE_JANINE
	endcallback
.MondayNight
	checkevent EVENT_BEAT_WALKER
	iffalse .NoWalker
	rematch REMATCH_BLUE_3, SPRITE_CONSOLE, SPRITE_WALKER, 4, 8, DOWN
.NoWalker
	endcallback

.Tuesday
	checktime (1 << EVE) | (1 << NITE)
	iftrue .TuesdayNight
.TuesdayMorningAndDay
	rematch_left REMATCH_BROWN_2, SPRITE_COPYCAT, SPRITE_PRYCE
	rematch_right REMATCH_BROWN_3, SPRITE_CONSOLE, SPRITE_BLAINE
	endcallback
.TuesdayNight
	checkevent EVENT_BEAT_LORELEI_AGAIN
	iffalse .NoLorelei
	rematch REMATCH_RED_1, SPRITE_BIG_DOLL, SPRITE_LORELEI, 4, 6, DOWN
.NoLorelei
	endcallback

.Wednesday
	checktime 1 << MORN
	iftrue .WednesdayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftrue .WednesdayNight
.WednesdayDay
	rematch_left REMATCH_BROWN_2, SPRITE_COPYCAT, SPRITE_BROCK
	rematch REMATCH_RED_1, SPRITE_BIG_DOLL, SPRITE_MISTY, 5, 2, RIGHT
	rematch_right REMATCH_BLUE_3, SPRITE_CONSOLE, SPRITE_BLUE
	endcallback
.WednesdayMorning
	rematch_left REMATCH_BROWN_2, SPRITE_COPYCAT, SPRITE_BROCK
	rematch_right REMATCH_RED_1, SPRITE_BIG_DOLL, SPRITE_MISTY
	endcallback
.WednesdayNight
	rematch REMATCH_BLUE_3, SPRITE_CONSOLE, SPRITE_BLUE, 4, 8, DOWN
	endcallback

.Thursday
	checktime 1 << MORN
	iftrue .ThursdayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftrue .ThursdayNight
.ThursdayDay
	checkevent EVENT_BEAT_PALMER
	iffalse .NoPalmer
	rematch REMATCH_GREEN_2, SPRITE_COPYCAT, SPRITE_PALMER, 6, 3, DOWN
.NoPalmer
	endcallback
.ThursdayMorning
	rematch REMATCH_GREEN_2, SPRITE_COPYCAT, SPRITE_BUGSY, 6, 1, DOWN
	endcallback
.ThursdayNight
	rematch REMATCH_BROWN_3, SPRITE_CONSOLE, SPRITE_MORTY, 4, 2, DOWN
	endcallback

.Friday
	checktime 1 << MORN
	iftrue .FridayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftrue .FridayNight
.FridayDay
	checkevent EVENT_BEAT_YELLOW
	iffalse .NoYellow
	rematch REMATCH_RED_1, SPRITE_BIG_DOLL, SPRITE_YELLOW, 6, 6, DOWN
.NoYellow
	endcallback
.FridayMorning
	rematch REMATCH_BROWN_2, SPRITE_COPYCAT, SPRITE_SURGE, 7, 6, DOWN
	endcallback
.FridayNight
	rematch REMATCH_BLUE_2, SPRITE_COPYCAT, SPRITE_CLAIR, 6, 2, RIGHT
	endcallback

.Saturday
	checktime 1 << MORN
	iftrue .SaturdayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftrue .SaturdayNight
.SaturdayDay
	rematch_left REMATCH_RED_1, SPRITE_BIG_DOLL, SPRITE_WHITNEY
	rematch_right REMATCH_BROWN_2, SPRITE_COPYCAT, SPRITE_CHUCK
	endcallback
.SaturdayMorning
	rematch_left REMATCH_RED_1, SPRITE_BIG_DOLL, SPRITE_WHITNEY
	endcallback
.SaturdayNight
	checkevent EVENT_BEAT_AGATHA
	iffalse .NoAgatha
	rematch REMATCH_BROWN_3, SPRITE_CONSOLE, SPRITE_AGATHA, 4, 2, DOWN
.NoAgatha
	endcallback

FightingDojoBlackBelt:
	checkevent EVENT_BEAT_BLUE
	iftrue .BlackBeltExplainsRematchesScript
	jumptextfaceplayer FightingDojoBlackBeltText
.BlackBeltExplainsRematchesScript
	jumptextfaceplayer BlackBeltText_ExplainsRematches

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
	iftrue .monday_walker
	writetext FightingDojoScheduleMondayText
	waitbutton
	sjump .tuesday
.monday_walker
	writetext FightingDojoScheduleMondayWalkerText
	waitbutton
.tuesday
	checkevent EVENT_BEAT_LORELEI_AGAIN
	iftrue .tuesday_lorelei
	writetext FightingDojoScheduleTuesdayText
	waitbutton
	sjump .wednesday
.tuesday_lorelei
	writetext FightingDojoScheduleTuesdayLoreleiText
	waitbutton
.wednesday
	writetext FightingDojoScheduleWednesdayText
	waitbutton
.thursday
	checkevent EVENT_BEAT_PALMER
	iftrue .thursday_palmer
	writetext FightingDojoScheduleThursdayText
	waitbutton
	sjump .friday
.thursday_palmer
	writetext FightingDojoScheduleThursdayPalmerText
	waitbutton
.friday
	checkevent EVENT_BEAT_YELLOW
	iftrue .friday_yellow
	writetext FightingDojoScheduleFridayText
	waitbutton
	sjump .saturday
.friday_yellow
	writetext FightingDojoScheduleFridayYellowText
	waitbutton
.saturday
	checkevent EVENT_BEAT_AGATHA
	iftrue .saturday_agatha
	jumpopenedtext FightingDojoScheduleSaturdayText
.saturday_agatha
	jumpopenedtext FightingDojoScheduleSaturdayAgathaText

RematchRed0Script:
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .Red0TuesdayNight
	ifequal WEDNESDAY, .Red0Wednesday
	ifequal FRIDAY, .Red0Friday
	ifequal SATURDAY, .Red0Saturday
	checktime (1 << EVE) | (1 << NITE)
	iftrue .Red0SundayNight
	sjump RematchJasmineScript
.Red0SundayNight
	sjump RematchSabrinaScript
.Red0TuesdayNight
	sjump RematchLoreleiScript
.Red0Wednesday
	sjump RematchMistyScript
.Red0Friday
	sjump RematchYellowScript
.Red0Saturday
	sjump RematchWhitneyScript

RematchGreen1Script:
	readvar VAR_WEEKDAY
	ifequal THURSDAY, .Green1Thursday
.Green1Sunday
	sjump RematchErikaScript
.Green1Thursday
	checktime 1 << MORN
	iftrue .Green1ThursdayMorning
.Green1ThursdayDay
	sjump RematchPalmerScript
.Green1ThursdayMorning
	sjump RematchBugsyScript

RematchBlue1Script:
	readvar VAR_WEEKDAY
	ifequal FRIDAY, .Blue1Friday
.Blue1Monday
	sjump RematchFalknerScript
.Blue1Friday
	sjump RematchClairScript

RematchBlue2Script:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Blue2Monday
.Blue2Wednesday
	sjump RematchBlueScript
.Blue2Monday
	checktime (1 << EVE) | (1 << NITE)
	iftrue .Blue2MondayNight
.Blue2MondayMorningDay
	sjump RematchJanineScript
.Blue2MondayNight
	sjump RematchWalkerScript

RematchBrown1Script:
	readvar VAR_WEEKDAY
	ifequal WEDNESDAY, .Brown1Wednesday
	ifequal FRIDAY, .Brown1Friday
	ifequal SATURDAY, .Brown1Saturday
.Brown1Tuesday
	sjump RematchPryceScript
.Brown1Wednesday
	sjump RematchBrockScript
.Brown1Friday
	sjump RematchSurgeScript
.Brown1Saturday
	sjump RematchChuckScript

RematchBrown2Script:
	readvar VAR_WEEKDAY
	ifequal THURSDAY, .Brown2Thursday
	ifequal SATURDAY, .Brown2SaturdayNight
.Brown2Tuesday
	sjump RematchBlaineScript
.Brown2Thursday
	sjump RematchMortyScript
.Brown2SaturdayNight
	sjump RematchAgathaScript

FightingDojoBlackBeltText:
	text "Hello!"

	para "Karate King, the"
	line "Fighting Dojo's"

	para "master, is in a"
	line "cave in Johto for"
	cont "training."
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

rematch_script: MACRO
	; rematch_script name, trainer, flag
	faceplayer
	opentext
	checkflag \3
	iftrue .RematchDone
	writetext \1Text_Greeting
	waitbutton
	closetext
	winlosstext \1Text_WinLoss, 0
	loadtrainer \2, 2
	startbattle
	reloadmapafterbattle
	setflag \3
	end
.RematchDone
	jumpopenedtext \1Text_Done
ENDM

RematchBrockScript:
	rematch_script Brock, BROCK, ENGINE_GYM_LEADER_REMATCH_1

RematchMistyScript:
	rematch_script Misty, MISTY, ENGINE_GYM_LEADER_REMATCH_2

RematchSurgeScript:
	rematch_script Surge, LT_SURGE, ENGINE_GYM_LEADER_REMATCH_1

RematchErikaScript:
	rematch_script Erika, ERIKA, ENGINE_GYM_LEADER_REMATCH_2

RematchJanineScript:
	rematch_script Janine, JANINE, ENGINE_GYM_LEADER_REMATCH_2

RematchSabrinaScript:
	rematch_script Sabrina, SABRINA, ENGINE_GYM_LEADER_REMATCH_3

RematchBlaineScript:
	rematch_script Blaine, BLAINE, ENGINE_GYM_LEADER_REMATCH_2

RematchBlueScript:
	rematch_script Blue, BLUE, ENGINE_GYM_LEADER_REMATCH_3

RematchFalknerScript:
	rematch_script Falkner, FALKNER, ENGINE_GYM_LEADER_REMATCH_1

RematchBugsyScript:
	rematch_script Bugsy, BUGSY, ENGINE_GYM_LEADER_REMATCH_1

RematchWhitneyScript:
	rematch_script Whitney, WHITNEY, ENGINE_GYM_LEADER_REMATCH_1

RematchMortyScript:
	rematch_script Morty, MORTY, ENGINE_GYM_LEADER_REMATCH_2

RematchChuckScript:
	rematch_script Chuck, CHUCK, ENGINE_GYM_LEADER_REMATCH_2

RematchJasmineScript:
	rematch_script Jasmine, JASMINE, ENGINE_GYM_LEADER_REMATCH_1

RematchPryceScript:
	rematch_script Pryce, PRYCE, ENGINE_GYM_LEADER_REMATCH_1

RematchClairScript:
	rematch_script Clair, CLAIR, ENGINE_GYM_LEADER_REMATCH_2

RematchPalmerScript:
	rematch_script Palmer, TOWERTYCOON, ENGINE_GYM_LEADER_REMATCH_3

RematchLoreleiScript:
	rematch_script Lorelei, LORELEI, ENGINE_GYM_LEADER_REMATCH_3

RematchAgathaScript:
	rematch_script Agatha, AGATHA, ENGINE_GYM_LEADER_REMATCH_3

RematchWalkerScript:
	rematch_script Walker, WALKER, ENGINE_GYM_LEADER_REMATCH_3

RematchYellowScript:
	rematch_script Yellow, YELLOW, ENGINE_GYM_LEADER_REMATCH_3

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
	line "filling a Pokedex"

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

FightingDojoScheduleSaturdayText:
	text "Saturday: Whitney,"
	line "Chuck, ???"
	done

FightingDojoScheduleSaturdayAgathaText:
	text "Saturday: Whitney,"
	line "Chuck, Agatha"
	done
