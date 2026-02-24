GoldenrodUnderground_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, GoldenrodUndergroundResetSwitches
	callback MAPCALLBACK_TILES, GoldenrodUndergroundCheckBasementKey
	callback MAPCALLBACK_OBJECTS, GoldenrodUndergroundCheckDayOfWeek

	def_warp_events
	warp_event  1,  2, GOLDENROD_UNDERGROUND_ENTRANCES, 4
	warp_event  1, 38, GOLDENROD_UNDERGROUND_ENTRANCES, 1
	warp_event 16,  6, GOLDENROD_UNDERGROUND, 4
	warp_event 27, 23, GOLDENROD_UNDERGROUND, 3
	warp_event 28, 23, GOLDENROD_UNDERGROUND, 3
	warp_event 28, 19, GOLDENROD_UNDERGROUND_SWITCH_ROOM, 1
	warp_event 19, 36, GOLDENROD_UNDERGROUND_ENTRANCES, 7

	def_coord_events

	def_bg_events
	bg_event 16,  6, BGEVENT_READ, BasementDoorScript
	bg_event 17,  6, BGEVENT_JUMPTEXT, GoldenrodUndergroundNoEntryText
	bg_event  4, 17, BGEVENT_ITEM + PARALYZEHEAL, EVENT_GOLDENROD_UNDERGROUND_HIDDEN_PARALYZEHEAL
	bg_event  2, 22, BGEVENT_ITEM + SUPER_POTION, EVENT_GOLDENROD_UNDERGROUND_HIDDEN_SUPER_POTION
	bg_event 15,  8, BGEVENT_ITEM + ANTIDOTE, EVENT_GOLDENROD_UNDERGROUND_HIDDEN_ANTIDOTE
	bg_event 20, 31, BGEVENT_ITEM + X_SP_ATK, EVENT_GOLDENROD_UNDERGROUND_HIDDEN_X_SP_ATK

	def_object_events
	object_event  5, 15, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BargainMerchantScript, EVENT_GOLDENROD_UNDERGROUND_GRAMPS
	object_event  5, 18, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OlderHaircutBrotherScript, EVENT_GOLDENROD_UNDERGROUND_OLDER_HAIRCUT_BROTHER
	object_event  5, 19, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, YoungerHaircutBrotherScript, EVENT_GOLDENROD_UNDERGROUND_YOUNGER_HAIRCUT_BROTHER
	object_event  5, 25, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BitterMerchantScript, EVENT_GOLDENROD_UNDERGROUND_GRANNY
	object_event 13, 29, SPRITE_PIERS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, PiersScript, -1
	object_event  3, 35, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSupernerdEric, -1
	object_event  4,  9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSupernerdTeru, -1
	object_event  1, 31, SPRITE_POKEMANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPokemaniacIssac, -1
	object_event  0,  6, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPokemaniacDonald, -1
	object_event  8, 31, SPRITE_COSPLAYER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCosplayerClara, -1
	object_event 14, 29, SPRITE_PIDGEOTTO_SIDE, SPRITEMOVEDATA_MICROPHONE, 0, 0, -1, PAL_NPC_EMOTE_GRAY, OBJECTTYPE_COMMAND, jumptextfaceplayer, PiersMicrophoneText, -1
	object_event  5, 11, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLACK, OBJECTTYPE_SCRIPT, 0, GoldenrodUndergroundCandyManScript, -1
	keyitemball_event  5, 28, COIN_CASE, EVENT_GOLDENROD_UNDERGROUND_COIN_CASE

	object_const_def
	const GOLDENRODUNDERGROUND_GRAMPS
	const GOLDENRODUNDERGROUND_SUPER_NERD5
	const GOLDENRODUNDERGROUND_SUPER_NERD6
	const GOLDENRODUNDERGROUND_GRANNY
	const GOLDENRODUNDERGROUND_PIERS

GoldenrodUndergroundResetSwitches:
	clearevent EVENT_SWITCH_1
	clearevent EVENT_SWITCH_2
	clearevent EVENT_SWITCH_3
	clearevent EVENT_EMERGENCY_SWITCH
	clearevent EVENT_DOOR_1_OPEN
	clearevent EVENT_DOOR_2_OPEN
	clearevent EVENT_DOOR_3_OPEN
	clearevent EVENT_DOOR_4_OPEN
	clearevent EVENT_DOOR_5_OPEN
	clearevent EVENT_DOOR_6_OPEN
	clearevent EVENT_DOOR_7_OPEN
	clearevent EVENT_DOOR_8_OPEN
	clearevent EVENT_DOOR_9_OPEN
	clearevent EVENT_DOOR_10_OPEN
	clearevent EVENT_DOOR_11_OPEN
	setval $0
	writemem wUndergroundSwitchPositions
	endcallback

GoldenrodUndergroundCheckBasementKey:
	checkevent EVENT_USED_BASEMENT_KEY
	iffalsefwd .LockBasementDoor
	endcallback

.LockBasementDoor:
	changeblock 16, 6, $3d
	endcallback

GoldenrodUndergroundCheckDayOfWeek:
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .Monday
	ifequalfwd TUESDAY, .Tuesday
	ifequalfwd WEDNESDAY, .Wednesday
	ifequalfwd THURSDAY, .Thursday
	ifequalfwd FRIDAY, .Friday
	ifequalfwd SATURDAY, .Saturday

.Sunday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	disappear GOLDENRODUNDERGROUND_SUPER_NERD5
	appear GOLDENRODUNDERGROUND_SUPER_NERD6
	appear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Monday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	checktime 1 << MORN
	iffalsefwd .NotMondayMorning
	appear GOLDENRODUNDERGROUND_GRAMPS
.NotMondayMorning:
	disappear GOLDENRODUNDERGROUND_SUPER_NERD5
	disappear GOLDENRODUNDERGROUND_SUPER_NERD6
	disappear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Tuesday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	appear GOLDENRODUNDERGROUND_SUPER_NERD5
	disappear GOLDENRODUNDERGROUND_SUPER_NERD6
	disappear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Wednesday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	disappear GOLDENRODUNDERGROUND_SUPER_NERD5
	appear GOLDENRODUNDERGROUND_SUPER_NERD6
	disappear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Thursday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	appear GOLDENRODUNDERGROUND_SUPER_NERD5
	disappear GOLDENRODUNDERGROUND_SUPER_NERD6
	disappear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Friday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	disappear GOLDENRODUNDERGROUND_SUPER_NERD5
	appear GOLDENRODUNDERGROUND_SUPER_NERD6
	disappear GOLDENRODUNDERGROUND_GRANNY
	endcallback

.Saturday:
	disappear GOLDENRODUNDERGROUND_GRAMPS
	appear GOLDENRODUNDERGROUND_SUPER_NERD5
	disappear GOLDENRODUNDERGROUND_SUPER_NERD6
	appear GOLDENRODUNDERGROUND_GRANNY
	endcallback

GenericTrainerSupernerdEric:
	generictrainer SUPER_NERD, ERIC, EVENT_BEAT_SUPER_NERD_ERIC, SupernerdEricSeenText, SupernerdEricBeatenText

	text "I guess I have to"
	line "do things fair and"
	cont "square…"
	done

GenericTrainerSupernerdTeru:
	generictrainer SUPER_NERD, TERU, EVENT_BEAT_SUPER_NERD_TERU, SupernerdTeruSeenText, SupernerdTeruBeatenText

	text "I know my #mon"
	line "type alignments."

	para "But I only use one"
	line "type of #mon."
	done

GenericTrainerPokemaniacIssac:
	generictrainer POKEMANIAC, ISSAC, EVENT_BEAT_POKEMANIAC_ISSAC, PokemaniacIssacSeenText, PokemaniacIssacBeatenText

	text "Your #mon will"
	line "like you more if"

	para "you give them"
	line "haircuts."
	done

GenericTrainerPokemaniacDonald:
	generictrainer POKEMANIAC, DONALD, EVENT_BEAT_POKEMANIAC_DONALD, PokemaniacDonaldSeenText, PokemaniacDonaldBeatenText

	text "Are you making a"
	line "#dex? Here's a"
	cont "hot tip."

	para "The Hiker on Route"
	line "33, Anthony, is a"
	cont "good guy."

	para "He'll phone you if"
	line "he sees any rare"
	cont "#mon."
	done

GenericTrainerCosplayerClara:
	generictrainer COSPLAYER, CLARA, EVENT_BEAT_COSPLAYER_CLARA, CosplayerClaraSeenText, CosplayerClaraBeatenText

	text "I made this cos-"
	line "tume myself!"
	done

BitterMerchantScript:
	readvar VAR_WEEKDAY
	ifequalfwd SUNDAY, .Open
	ifequalfwd SATURDAY, .Open
	jumptext GoldenrodUndergroundWeAreNotOpenTodayText

.Open:
	pokemart MARTTYPE_BITTER, MART_UNDERGROUND

BargainMerchantScript:
	checkflag ENGINE_GOLDENROD_UNDERGROUND_MERCHANT_CLOSED
	iftrue_jumptext GoldenrodUndergroundWeAreNotOpenTodayText
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .CheckMorn
	jumptext GoldenrodUndergroundWeAreNotOpenTodayText

.CheckMorn:
	checktime 1 << MORN
	iffalse_jumptext GoldenrodUndergroundWeAreNotOpenTodayText
	pokemart MARTTYPE_BARGAIN, 0

OlderHaircutBrotherScript:
	readvar VAR_WEEKDAY
	ifequalfwd TUESDAY, .DoHaircut
	ifequalfwd THURSDAY, .DoHaircut
	ifequalfwd SATURDAY, .DoHaircut
	jumptext GoldenrodUndergroundWeAreNotOpenTodayText

.DoHaircut:
	opentext
	checkflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	iftruefwd .AlreadyGotHaircut
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundOlderHaircutBrotherOfferHaircutText
	yesorno
	iffalsefwd .Refused
	checkmoney YOUR_MONEY, 500
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	writetext GoldenrodUndergroundOlderHaircutBrotherAskWhichMonText
	promptbutton
	special Special_OlderHaircutBrother
	ifequalfwd $0, .Refused
	ifequalfwd $1, .Refused
	setflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	ifequalfwd $2, .two
	ifequalfwd $3, .three
	sjumpfwd .else

.two
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjumpfwd .then

.three
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjumpfwd .then

.else
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	; fallthrough

.then
	takemoney YOUR_MONEY, 500
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundOlderHaircutBrotherWatchItBecomeBeautifulText
	waitbutton
	closetext
	special FadeOutPalettes
	special LoadMapPalettes
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes_EnableDynNoApply
	special RestartMapMusic
	opentext
	writetext GoldenrodUndergroundOlderHaircutBrotherAllDoneText
	waitbutton
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue EitherHaircutBrotherScript_SlightlyHappier
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue EitherHaircutBrotherScript_Happier
	sjump EitherHaircutBrotherScript_MuchHappier

.Refused:
	jumpthisopenedtext

	text "Is that right?"
	line "That's a shame!"
	done

.NotEnoughMoney:
	jumpthisopenedtext

	text "You'll need more"
	line "money than that."
	done

.AlreadyGotHaircut:
	jumpthisopenedtext

	text "I do only one"
	line "haircut a day. I'm"
	cont "done for today."
	done

YoungerHaircutBrotherScript:
	readvar VAR_WEEKDAY
	ifequalfwd SUNDAY, .DoHaircut
	ifequalfwd WEDNESDAY, .DoHaircut
	ifequalfwd FRIDAY, .DoHaircut
	jumptext GoldenrodUndergroundWeAreNotOpenTodayText

.DoHaircut:
	opentext
	checkflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	iftruefwd .AlreadyGotHaircut
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundYoungerHaircutBrotherOfferHaircutText
	yesorno
	iffalsefwd .Refused
	checkmoney YOUR_MONEY, 300
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	writetext GoldenrodUndergroundYoungerHaircutBrotherAskWhichMonText
	promptbutton
	special Special_YoungerHaircutBrother
	ifequalfwd $0, .Refused
	ifequalfwd $1, .Refused
	setflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	ifequalfwd $2, .two
	ifequalfwd $3, .three
	sjumpfwd .else

.two
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjumpfwd .then

.three
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjumpfwd .then

.else
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
.then
	takemoney YOUR_MONEY, 300
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundYoungerHaircutBrotherIllMakeItLookCoolText
	waitbutton
	closetext
	special FadeOutPalettes
	special LoadMapPalettes
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes_EnableDynNoApply
	special RestartMapMusic
	opentext
	writetext GoldenrodUndergroundYoungerHaircutBrotherAllDoneText
	waitbutton
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftruefwd EitherHaircutBrotherScript_SlightlyHappier
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftruefwd EitherHaircutBrotherScript_Happier
	sjumpfwd EitherHaircutBrotherScript_MuchHappier

.Refused:
	jumpthisopenedtext

	text "No?"
	line "How disappointing!"
	done

.NotEnoughMoney:
	jumpthisopenedtext

	text "You're a little"
	line "short on funds."
	done

.AlreadyGotHaircut:
	jumpthisopenedtext

	text "I can do only one"
	line "haircut a day."

	para "Sorry, but I'm all"
	line "done for today."
	done

EitherHaircutBrotherScript_SlightlyHappier:
	writetext HaircutBrosText_SlightlyHappier
	special PlayCurMonCry
	waitendtext

EitherHaircutBrotherScript_Happier:
	writetext HaircutBrosText_Happier
	special PlayCurMonCry
	waitendtext

EitherHaircutBrotherScript_MuchHappier:
	writetext HaircutBrosText_MuchHappier
	special PlayCurMonCry
	waitendtext

BasementDoorScript::
	checkevent EVENT_USED_BASEMENT_KEY
	iftrue_jumptext GoldenrodUndergroundTheDoorIsOpenText
	checkkeyitem BASEMENT_KEY
	iffalse_jumptext GoldenrodUndergroundTheDoorsLockedText
	opentext
	playsound SFX_TRANSACTION
	writetext GoldenrodUndergroundBasementKeyOpenedDoorText
	waitbutton
	closetext
	changeblock 16, 6, $2e
	refreshmap
	setevent EVENT_USED_BASEMENT_KEY
	endtext

GoldenrodUndergroundCandyManScript:
	checkevent EVENT_GOT_CANDY_JAR
	iftruefwd .AlreadyGotCandyJar
	opentext
	writetext .GiveCandyJarText1
	waitbutton
	verbosegivekeyitem CANDY_JAR
	setevent EVENT_GOT_CANDY_JAR
	writetext .GiveCandyJarText2
	waitbutton
	setval 1
	writemem wExpCandySAmount
	endtext

.AlreadyGotCandyJar:
	pokemart MARTTYPE_EXP_CANDY, 0

.GiveCandyJarText1:
	text "Psst! Over here…"
	line "You look like you"
	cont "could use a boost."

	para "Don't ask too many"
	line "questions."

	para "Here, take this."
	done

.GiveCandyJarText2:
	text "It's a Candy Jar."

	para "You'll need it to"
	line "store my, uh,"
	cont "special candy."

	para "First one's on me!"
	line "Try it out."

	para "…For your"
	line "#mon,"
	cont "of course."
	done

PiersScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd PiersRematchScript
	checkevent EVENT_BEAT_PIERS
	iftrue_jumpopenedtext PiersAfterText
	checkevent EVENT_INTRODUCED_PIERS
	iftruefwd .AfterIntro
	writetext PiersIntroText
	waitbutton
	setevent EVENT_INTRODUCED_PIERS
.AfterIntro:
	writetext PiersAfterIntroText
	yesorno
	iffalse_jumpopenedtext PiersNoBattleText
	writetext PiersSeenText
	waitbutton
	closetext
	winlosstext PiersBeatenText, 0
	setlasttalked GOLDENRODUNDERGROUND_PIERS
	loadtrainer PIERS, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_PIERS
	opentext
	writetext PiersRewardText
	promptbutton
	verbosegiveitem THROAT_SPRAY
	iffalse_jumpopenedtext PiersAfterText
	setevent EVENT_GOT_THROAT_SPRAY_FROM_PIERS
	jumpthisopenedtext

PiersAfterText:
	text "If you want to be-"
	line "come the Champion,"

	para "you better get"
	line "goin'!"

	para "I'll send some sup-"
	line "port your way with"
	cont "a yell!"
	done

PiersRematchScript:
	checkevent EVENT_BEAT_PIERS_AGAIN
	iffalsefwd .DoRematch
	checkevent EVENT_GOT_THROAT_SPRAY_FROM_PIERS
	iftrue_jumpopenedtext PiersRematchAfterText
	opentext
	sjumpfwd .GiveThroatSpray
.DoRematch:
	checkevent EVENT_INTRODUCED_PIERS
	iffalsefwd .Intro
	writetext PiersRematchIntroAgainText
	sjumpfwd .AfterIntro
.Intro:
	writetext PiersIntroText
.AfterIntro:
	setevent EVENT_INTRODUCED_PIERS
	waitbutton
	writetext PiersRematchSeenText
	waitbutton
	closetext
	winlosstext PiersRematchBeatenText, 0
	setlasttalked GOLDENRODUNDERGROUND_PIERS
	loadtrainer PIERS, 2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_PIERS_AGAIN
	opentext
	checkevent EVENT_GOT_THROAT_SPRAY_FROM_PIERS
	iftrue_jumpopenedtext PiersRematchAfterText
.GiveThroatSpray:
	writetext PiersRewardText
	promptbutton
	verbosegiveitem THROAT_SPRAY
	iffalse_jumpopenedtext PiersRematchAfterText
	setevent EVENT_GOT_THROAT_SPRAY_FROM_PIERS
	jumpthisopenedtext

PiersRematchAfterText:
	text "I have a little"
	line "sister."
	cont "Her name's Marnie."

	para "She's about as"
	line "cute as they come."

	para "When she's older,"
	line "I don't know if"

	para "she'll want to"
	line "sing, play music,"

	para "battle with #-"
	line "mon, or something"
	cont "totally new."

	para "But whatever she"
	line "chooses, I hope"

	para "she has as much"
	line "passion as you"
	cont "do, <PLAYER>!"
	done

PiersIntroText:
	text "Piers: The only"
	line "thing a humble"
	cont "singer can do"
	cont "is sing a humble"
	cont "song… ♪"

	para "My name's Piers."
	line "I'm not from Johto,"

	para "but I came here"
	line "to sing on the"

	para "radio and make"
	line "everyone smile"
	cont "in my hometown."
	done

PiersAfterIntroText:
	text "Some of my best"
	line "riffs have come"

	para "from winning a"
	line "good battle."

	para "How 'bout we have"
	line "one here and now?"
	done

PiersNoBattleText:
	text "Sigh… I feel like"
	line "my soul's weeping."
	done

PiersSeenText:
	text "I make dark music"
	line "and use Dark-type"
	cont "#mon!"

	para "It's time to rock!"
	done

PiersBeatenText:
	text "Me an' my team"
	line "gave it our best."
	done

PiersRewardText:
	text "I'm glad we were"
	line "able to battle."

	para "Seems like my"
	line "#mon feel the"
	cont "same way."

	para "Here's something"
	line "to help rock out"

	para "even harder next"
	line "time!"
	done

PiersRematchIntroAgainText:
	text "Piers: Hey there,"
	line "<PLAYER>."
	done

PiersRematchSeenText:
	text "Hah! So you're the"
	line "new Champion."

	para "You're a big deal"
	line "now!"

	para "And I'm still just"
	line "singing my humble"
	cont "songs…"

	para "So you want an"
	line "encore?"

	para "I'll make an ex-"
	line "ception for you,"
	cont "just this once!"
	done

PiersRematchBeatenText:
	text "That's it?!"
	line "No way!"
	done

SupernerdEricSeenText:
	text "I got booted out"
	line "of the Game Cor-"
	cont "ner."

	para "I was trying to"
	line "cheat using my"
	cont "#mon…"
	done

SupernerdEricBeatenText:
	text "…Grumble…"
	done

SupernerdTeruSeenText:
	text "Do you consider"
	line "type alignments in"
	cont "battle?"

	para "If you know your"
	line "type advantages,"

	para "you'll do better"
	line "in battle."
	done

SupernerdTeruBeatenText:
	text "Ow, ow, ow!"
	done

PokemaniacIssacSeenText:
	text "My #mon just"
	line "got a haircut!"

	para "I'll show you how"
	line "strong it is!"
	done

PokemaniacIssacBeatenText:
	text "Aiyeeee!"
	done

PokemaniacDonaldSeenText:
	text "I think you have"
	line "some rare #mon"
	cont "with you."

	para "Let me see them!"
	done

PokemaniacDonaldBeatenText:
	text "Gaah! I lost!"
	line "That makes me mad!"
	done

CosplayerClaraSeenText:
	text "Pix! Vul, pix! ♥"
	done

CosplayerClaraBeatenText:
	text "You thought I was"
	line "a #mon?"

	para "Nope! It's just"
	line "quality cosplay."
	done

GoldenrodUndergroundTheDoorsLockedText:
	text "The door's locked…"
	done

GoldenrodUndergroundTheDoorIsOpenText:
	text "The door is open."
	done

GoldenrodUndergroundBasementKeyOpenedDoorText:
	text "The Basement Key"
	line "opened the door."
	done

GoldenrodUndergroundOlderHaircutBrotherOfferHaircutText:
	text "Welcome!"

	para "I run the #mon"
	line "Salon!"

	para "I'm the older and"
	line "better of the two"
	cont "Haircut Brothers."

	para "I can make your"
	line "#mon beautiful"
	cont "for just ¥500."

	para "Would you like me"
	line "to do that?"
	done

GoldenrodUndergroundOlderHaircutBrotherAskWhichMonText:
	text "Which #mon"
	line "should I work on?"
	done

GoldenrodUndergroundOlderHaircutBrotherWatchItBecomeBeautifulText:
	text "OK! Watch it"
	line "become beautiful!"
	done

GoldenrodUndergroundOlderHaircutBrotherAllDoneText:
	text "There! All done!"
	done




GoldenrodUndergroundYoungerHaircutBrotherOfferHaircutText:
	text "Welcome to the"
	line "#mon Salon!"

	para "I'm the younger"
	line "and less expen-"
	cont "sive of the two"
	cont "Haircut Brothers."

	para "I'll spiff up your"
	line "#mon for just"
	cont "¥300."

	para "So? How about it?"
	done

GoldenrodUndergroundYoungerHaircutBrotherAskWhichMonText:
	text "OK, which #mon"
	line "should I do?"
	done

GoldenrodUndergroundYoungerHaircutBrotherIllMakeItLookCoolText:
	text "OK! I'll make it"
	line "look cool!"
	done

GoldenrodUndergroundYoungerHaircutBrotherAllDoneText:
	text "There we go!"
	line "All done!"
	done




HaircutBrosText_SlightlyHappier:
	text_ram wStringBuffer3
	text " looks a"
	line "little happier."
	done

HaircutBrosText_Happier:
	text_ram wStringBuffer3
	text " looks"
	line "happy."
	done

HaircutBrosText_MuchHappier:
	text_ram wStringBuffer3
	text " looks"
	line "delighted!"
	done

GoldenrodUndergroundWeAreNotOpenTodayText:
	text "We're not open"
	line "today."
	done

GoldenrodUndergroundNoEntryText: ; text > text
	text "NO ENTRY BEYOND"
	line "THIS POINT"
	done

PiersMicrophoneText:
	text "It's a microphone."
	done
