WarehouseEntrance_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, WarehouseEntranceResetSwitches
	callback MAPCALLBACK_TILES, WarehouseEntranceCheckBasementKey
	callback MAPCALLBACK_OBJECTS, WarehouseEntranceCheckDayOfWeek

	def_warp_events
	warp_event  1,  2, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES, 7
	warp_event  1, 34, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES, 4
	warp_event 16,  6, WAREHOUSE_ENTRANCE, 4
	warp_event 13, 35, WAREHOUSE_ENTRANCE, 3
	warp_event 14, 35, WAREHOUSE_ENTRANCE, 3
	warp_event 14, 31, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES, 1

	def_coord_events

	def_bg_events
	bg_event 16,  6, BGEVENT_READ, BasementDoorScript
	bg_event 17,  6, BGEVENT_JUMPTEXT, GoldenrodUndergroundNoEntryText
	bg_event  4, 13, BGEVENT_ITEM + PARALYZEHEAL, EVENT_WAREHOUSE_ENTRANCE_HIDDEN_PARALYZEHEAL
	bg_event  2, 18, BGEVENT_ITEM + SUPER_POTION, EVENT_WAREHOUSE_ENTRANCE_HIDDEN_SUPER_POTION
	bg_event 15,  8, BGEVENT_ITEM + ANTIDOTE, EVENT_WAREHOUSE_ENTRANCE_HIDDEN_ANTIDOTE

	def_object_events
	object_event  5, 11, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BargainMerchantScript, EVENT_WAREHOUSE_ENTRANCE_GRAMPS
	object_event  5, 14, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OlderHaircutBrotherScript, EVENT_WAREHOUSE_ENTRANCE_OLDER_HAIRCUT_BROTHER
	object_event  5, 15, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, YoungerHaircutBrotherScript, EVENT_WAREHOUSE_ENTRANCE_YOUNGER_HAIRCUT_BROTHER
	object_event  5, 21, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BitterMerchantScript, EVENT_WAREHOUSE_ENTRANCE_GRANNY
	object_event  3, 31, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSupernerdEric, -1
	object_event  4,  9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSupernerdTeru, -1
	object_event  1, 27, SPRITE_POKEMANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPokemaniacIssac, -1
	object_event  0,  6, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPokemaniacDonald, -1
	keyitemball_event  4, 25, COIN_CASE, EVENT_WAREHOUSE_ENTRANCE_COIN_CASE
	object_event  1, 18, SPRITE_COSPLAYER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerCosplayerClara, -1

	object_const_def
	const WAREHOUSEENTRANCE_GRAMPS
	const WAREHOUSEENTRANCE_SUPER_NERD5
	const WAREHOUSEENTRANCE_SUPER_NERD6
	const WAREHOUSEENTRANCE_GRANNY

WarehouseEntranceResetSwitches:
	clearevent EVENT_SWITCH_1
	clearevent EVENT_SWITCH_2
	clearevent EVENT_SWITCH_3
	clearevent EVENT_EMERGENCY_SWITCH
	clearevent EVENT_SWITCH_4
	clearevent EVENT_SWITCH_5
	clearevent EVENT_SWITCH_6
	clearevent EVENT_SWITCH_7
	clearevent EVENT_SWITCH_8
	clearevent EVENT_SWITCH_9
	clearevent EVENT_SWITCH_10
	clearevent EVENT_SWITCH_11
	clearevent EVENT_SWITCH_12
	clearevent EVENT_SWITCH_13
	clearevent EVENT_SWITCH_14
	setval $0
	writemem wUndergroundSwitchPositions
	endcallback

WarehouseEntranceCheckBasementKey:
	checkevent EVENT_USED_BASEMENT_KEY
	iffalse .LockBasementDoor
	endcallback

.LockBasementDoor:
	changeblock 16, 6, $3d
	endcallback

WarehouseEntranceCheckDayOfWeek:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .Monday
	ifequal TUESDAY, .Tuesday
	ifequal WEDNESDAY, .Wednesday
	ifequal THURSDAY, .Thursday
	ifequal FRIDAY, .Friday
	ifequal SATURDAY, .Saturday

.Sunday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	disappear WAREHOUSEENTRANCE_SUPER_NERD5
	appear WAREHOUSEENTRANCE_SUPER_NERD6
	appear WAREHOUSEENTRANCE_GRANNY
	endcallback

.Monday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	checktime 1 << MORN
	iffalse .NotMondayMorning
	appear WAREHOUSEENTRANCE_GRAMPS
.NotMondayMorning:
	disappear WAREHOUSEENTRANCE_SUPER_NERD5
	disappear WAREHOUSEENTRANCE_SUPER_NERD6
	disappear WAREHOUSEENTRANCE_GRANNY
	endcallback

.Tuesday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	appear WAREHOUSEENTRANCE_SUPER_NERD5
	disappear WAREHOUSEENTRANCE_SUPER_NERD6
	disappear WAREHOUSEENTRANCE_GRANNY
	endcallback

.Wednesday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	disappear WAREHOUSEENTRANCE_SUPER_NERD5
	appear WAREHOUSEENTRANCE_SUPER_NERD6
	disappear WAREHOUSEENTRANCE_GRANNY
	endcallback

.Thursday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	appear WAREHOUSEENTRANCE_SUPER_NERD5
	disappear WAREHOUSEENTRANCE_SUPER_NERD6
	disappear WAREHOUSEENTRANCE_GRANNY
	endcallback

.Friday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	disappear WAREHOUSEENTRANCE_SUPER_NERD5
	appear WAREHOUSEENTRANCE_SUPER_NERD6
	disappear WAREHOUSEENTRANCE_GRANNY
	endcallback

.Saturday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	appear WAREHOUSEENTRANCE_SUPER_NERD5
	disappear WAREHOUSEENTRANCE_SUPER_NERD6
	appear WAREHOUSEENTRANCE_GRANNY
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
	ifequal SUNDAY, .Open
	ifequal SATURDAY, .Open
	jumptext GoldenrodUndergroundWeAreNotOpenTodayText

.Open:
	pokemart MARTTYPE_BITTER, MART_UNDERGROUND

BargainMerchantScript:
	checkflag ENGINE_GOLDENROD_UNDERGROUND_MERCHANT_CLOSED
	iftrue_jumptext GoldenrodUndergroundWeAreNotOpenTodayText
	readvar VAR_WEEKDAY
	ifequal MONDAY, .CheckMorn
	jumptext GoldenrodUndergroundWeAreNotOpenTodayText

.CheckMorn:
	checktime 1 << MORN
	iffalse_jumptext GoldenrodUndergroundWeAreNotOpenTodayText
	pokemart MARTTYPE_BARGAIN, 0

OlderHaircutBrotherScript:
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .DoHaircut
	ifequal THURSDAY, .DoHaircut
	ifequal SATURDAY, .DoHaircut
	jumptext GoldenrodUndergroundWeAreNotOpenTodayText

.DoHaircut:
	opentext
	checkflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	iftrue .AlreadyGotHaircut
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundOlderHaircutBrotherOfferHaircutText
	yesorno
	iffalse .Refused
	checkmoney $0, 500
	ifequal $2, .NotEnoughMoney
	writetext GoldenrodUndergroundOlderHaircutBrotherAskWhichMonText
	promptbutton
	special Special_OlderHaircutBrother
	ifequal $0, .Refused
	ifequal $1, .Refused
	setflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	ifequal $2, .two
	ifequal $3, .three
	sjump .else

.two
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjump .then

.three
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjump .then

.else
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjump .then

.then
	takemoney $0, 500
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundOlderHaircutBrotherWatchItBecomeBeautifulText
	waitbutton
	closetext
	special FadeOutPalettes
	special LoadMapPalettes
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes
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
	jumpopenedtext GoldenrodUndergroundOlderHaircutBrotherThatsAShameText

.NotEnoughMoney:
	jumpopenedtext GoldenrodUndergroundOlderHaircutBrotherYoullNeedMoreMoneyText

.AlreadyGotHaircut:
	jumpopenedtext GoldenrodUndergroundOlderHaircutBrotherOneHaircutADayText

YoungerHaircutBrotherScript:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .DoHaircut
	ifequal WEDNESDAY, .DoHaircut
	ifequal FRIDAY, .DoHaircut
	jumptext GoldenrodUndergroundWeAreNotOpenTodayText

.DoHaircut:
	opentext
	checkflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	iftrue .AlreadyGotHaircut
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundYoungerHaircutBrotherOfferHaircutText
	yesorno
	iffalse .Refused
	checkmoney $0, 300
	ifequal $2, .NotEnoughMoney
	writetext GoldenrodUndergroundYoungerHaircutBrotherAskWhichMonText
	promptbutton
	special Special_YoungerHaircutBrother
	ifequal $0, .Refused
	ifequal $1, .Refused
	setflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	ifequal $2, .two
	ifequal $3, .three
	sjump .else

.two
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjump .then

.three
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	sjump .then

.else
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
.then
	takemoney $0, 300
	special PlaceMoneyTopRight
	writetext GoldenrodUndergroundYoungerHaircutBrotherIllMakeItLookCoolText
	waitbutton
	closetext
	special FadeOutPalettes
	special LoadMapPalettes
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes
	special RestartMapMusic
	opentext
	writetext GoldenrodUndergroundYoungerHaircutBrotherAllDoneText
	waitbutton
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue EitherHaircutBrotherScript_SlightlyHappier
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue EitherHaircutBrotherScript_Happier
	sjump EitherHaircutBrotherScript_MuchHappier

.Refused:
	jumpopenedtext GoldenrodUndergroundYoungerHaircutBrotherHowDisappointingText

.NotEnoughMoney:
	jumpopenedtext GoldenrodUndergroundYoungerHaircutBrotherShortOnFundsText

.AlreadyGotHaircut:
	jumpopenedtext GoldenrodUndergroundYoungerHaircutBrotherOneHaircutADayText

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
	reloadmappart
	setevent EVENT_USED_BASEMENT_KEY
	endtext

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

GoldenrodUndergroundOlderHaircutBrotherThatsAShameText:
	text "Is that right?"
	line "That's a shame!"
	done

GoldenrodUndergroundOlderHaircutBrotherYoullNeedMoreMoneyText:
	text "You'll need more"
	line "money than that."
	done

GoldenrodUndergroundOlderHaircutBrotherOneHaircutADayText:
	text "I do only one"
	line "haircut a day. I'm"
	cont "done for today."
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

GoldenrodUndergroundYoungerHaircutBrotherHowDisappointingText:
	text "No?"
	line "How disappointing!"
	done

GoldenrodUndergroundYoungerHaircutBrotherShortOnFundsText:
	text "You're a little"
	line "short on funds."
	done

GoldenrodUndergroundYoungerHaircutBrotherOneHaircutADayText:
	text "I can do only one"
	line "haircut a day."

	para "Sorry, but I'm all"
	line "done for today."
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

GoldenrodUndergroundNoEntryText:
	text "NO ENTRY BEYOND"
	line "THIS POINT"
	done
