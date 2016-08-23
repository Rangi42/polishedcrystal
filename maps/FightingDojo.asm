const_value set 2
	const FIGHTINGDOJO_POKE_BALL
	const FIGHTINGDOJO_BLACK_BELT
	const REMATCH_RED_1
	const REMATCH_GREEN_2
	const REMATCH_BLUE_2
	const REMATCH_BLUE_3
	const REMATCH_BROWN_2
	const REMATCH_BROWN_3

FightingDojo_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_SPRITES, .SetupRematchesCallback

.SetupRematchesCallback:
	disappear REMATCH_RED_1
	disappear REMATCH_GREEN_2
	disappear REMATCH_BLUE_2
	disappear REMATCH_BLUE_3
	disappear REMATCH_BROWN_2
	disappear REMATCH_BROWN_3
	checkevent EVENT_BEAT_BLUE
	iftrue .SetupDailyRematches
	return

rematch: MACRO
	; rematch person, varsprite, sprite, y, x, face
	moveperson \1, \5, \4
	spriteface \1, \6
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
	checkcode VAR_WEEKDAY
	if_equal MONDAY, .Monday
	if_equal TUESDAY, .Tuesday
	if_equal WEDNESDAY, .Wednesday
	if_equal THURSDAY, .Thursday
	if_equal FRIDAY, .Friday
	if_equal SATURDAY, .Saturday
.Sunday
	checknite
	iftrue .SundayNight
.SundayMorningAndDay
	rematch_left REMATCH_RED_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_JASMINE
	rematch_right REMATCH_GREEN_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_ERIKA
	return
.SundayNight
	rematch REMATCH_RED_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_SABRINA, 4, 6, DOWN
	return
.Monday
	checknite
	iftrue .MondayNight
.MondayMorningAndDay
	rematch_left REMATCH_BLUE_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_FALKNER
	rematch_right REMATCH_BLUE_3, SPRITE_REMATCH_GYM_LEADER_3, SPRITE_JANINE
.MondayNight
	return
.Tuesday
	checknite
	iftrue .TuesdayNight
.TuesdayMorningAndDay
	rematch_left REMATCH_BROWN_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_PRYCE
	rematch_right REMATCH_BROWN_3, SPRITE_REMATCH_GYM_LEADER_3, SPRITE_BLAINE
.TuesdayNight
	return
.Wednesday
	checkmorn
	iftrue .WednesdayMorning
	checknite
	iftrue .WednesdayNight
.WednesdayDay
	rematch_left REMATCH_BROWN_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_BROCK
	rematch REMATCH_RED_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_MISTY, 5, 2, RIGHT
	rematch_right REMATCH_BLUE_3, SPRITE_REMATCH_GYM_LEADER_3, SPRITE_BLUE
	return
.WednesdayMorning
	rematch_left REMATCH_BROWN_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_BROCK
	rematch_right REMATCH_RED_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_MISTY
	return
.WednesdayNight
	rematch REMATCH_BLUE_3, SPRITE_REMATCH_GYM_LEADER_3, SPRITE_BLUE, 4, 8, DOWN
	return
.Thursday
	checkmorn
	iftrue .ThursdayMorning
	checknite
	iftrue .ThursdayNight
.ThursdayDay
	rematch_left REMATCH_GREEN_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_BUGSY
	rematch_right REMATCH_BROWN_3, SPRITE_REMATCH_GYM_LEADER_3, SPRITE_MORTY
	return
.ThursdayMorning
	rematch REMATCH_GREEN_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_BUGSY, 6, 1, DOWN
	return
.ThursdayNight
	rematch REMATCH_BROWN_3, SPRITE_REMATCH_GYM_LEADER_3, SPRITE_MORTY, 4, 2, DOWN
	return
.Friday
	checkmorn
	iftrue .FridayMorning
	checknite
	iftrue .FridayNight
.FridayDay
	return
.FridayMorning
	rematch REMATCH_BROWN_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_SURGE, 7, 6, DOWN
	return
.FridayNight
	rematch REMATCH_BLUE_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_CLAIR, 6, 2, RIGHT
	return
.Saturday
	checkday
	iffalse .SaturdayMorningAndNight
.SaturdayDay
	rematch_left REMATCH_RED_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_WHITNEY
	rematch_right REMATCH_BROWN_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_CHUCK
.SaturdayMorningAndNight
	return

BlackBeltScript_0x189b61:
	checkevent EVENT_BEAT_BLUE
	iftrue .BlackBeltExplainsRematchesScript
	jumptextfaceplayer UnknownText_0x189b6c
.BlackBeltExplainsRematchesScript
	jumptextfaceplayer BlackBeltText_ExplainsRematches

MapFightingDojoSignpost0Script:
	jumptext UnknownText_0x189bc0

MapFightingDojoSignpost1Script:
	jumptext UnknownText_0x189be0

FightingDojoFocusBand:
	itemball FOCUS_BAND

RematchRed0Script:
	checkcode VAR_WEEKDAY
	if_equal WEDNESDAY, .Red0Wednesday
	if_equal SATURDAY, .Red0Saturday
	checknite
	iftrue .Red0SundayNight
	jump RematchJasmineScript
.Red0SundayNight
	jump RematchSabrinaScript
.Red0Wednesday
	jump RematchMistyScript
.Red0Saturday
	jump RematchWhitneyScript

RematchGreen1Script:
	checkcode VAR_WEEKDAY
	if_equal THURSDAY, .Green1Thursday
	jump RematchErikaScript
.Green1Thursday
	jump RematchBugsyScript

RematchBlue1Script:
	checkcode VAR_WEEKDAY
	if_equal FRIDAY, .Blue1Friday
	jump RematchFalknerScript
.Blue1Friday
	jump RematchClairScript

RematchBlue2Script:
	checkcode VAR_WEEKDAY
	if_equal WEDNESDAY, .Blue2Wednesday
	jump RematchJanineScript
.Blue2Wednesday
	jump RematchBlueScript

RematchBrown1Script:
	checkcode VAR_WEEKDAY
	if_equal WEDNESDAY, .Brown1Wednesday
	if_equal FRIDAY, .Brown1Friday
	if_equal SATURDAY, .Brown1Saturday
	jump RematchPryceScript
.Brown1Wednesday
	jump RematchBrockScript
.Brown1Friday
	jump RematchSurgeScript
.Brown1Saturday
	jump RematchChuckScript

RematchBrown2Script:
	checkcode VAR_WEEKDAY
	if_equal THURSDAY, .Brown2Thursday
	jump RematchBlaineScript
.Brown2Thursday
	jump RematchMortyScript

UnknownText_0x189b6c:
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

UnknownText_0x189bc0:
	text "What goes around"
	line "comes around!"
	done

UnknownText_0x189be0:
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
	writetext \1Text_Done
	waitbutton
	closetext
	end
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
	line "training!
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
	text "I'm done battling"
	line "for today."
	done

FightingDojo_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $4, 1, SAFFRON_CITY
	warp_def $b, $5, 1, SAFFRON_CITY

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 0, 4, SIGNPOST_READ, MapFightingDojoSignpost0Script
	signpost 0, 5, SIGNPOST_READ, MapFightingDojoSignpost1Script

.PersonEvents:
	db 8
	person_event SPRITE_POKE_BALL, 1, 3, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, FightingDojoFocusBand, EVENT_PICKED_UP_FOCUS_BAND
	person_event SPRITE_BLACK_BELT, 4, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BlackBeltScript_0x189b61, -1
	person_event SPRITE_REMATCH_GYM_LEADER_1, 1, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, RematchRed0Script, EVENT_REMATCH_GYM_LEADER_1
	person_event SPRITE_REMATCH_GYM_LEADER_2, 2, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, RematchGreen1Script, EVENT_REMATCH_GYM_LEADER_2
	person_event SPRITE_REMATCH_GYM_LEADER_2, 3, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, RematchBlue1Script, EVENT_REMATCH_GYM_LEADER_3
	person_event SPRITE_REMATCH_GYM_LEADER_3, 4, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, RematchBlue2Script, EVENT_REMATCH_GYM_LEADER_4
	person_event SPRITE_REMATCH_GYM_LEADER_2, 5, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, RematchBrown1Script, EVENT_REMATCH_GYM_LEADER_5
	person_event SPRITE_REMATCH_GYM_LEADER_3, 6, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, RematchBrown2Script, EVENT_REMATCH_GYM_LEADER_6
