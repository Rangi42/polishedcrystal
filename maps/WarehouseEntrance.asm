WarehouseEntrance_MapScriptHeader:
	db 0 ; scene scripts

	db 3 ; callbacks
	callback MAPCALLBACK_NEWMAP, WarehouseEntranceResetSwitches
	callback MAPCALLBACK_TILES, WarehouseEntranceCheckBasementKey
	callback MAPCALLBACK_OBJECTS, WarehouseEntranceCheckDayOfWeek

	db 6 ; warp events
	warp_event  1,  2, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES, 7
	warp_event  1, 34, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES, 4
	warp_event 16,  6, WAREHOUSE_ENTRANCE, 4
	warp_event 13, 35, WAREHOUSE_ENTRANCE, 3
	warp_event 14, 35, WAREHOUSE_ENTRANCE, 3
	warp_event 14, 31, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES, 1

	db 0 ; coord events

	db 5 ; bg events
	bg_event 16,  6, SIGNPOST_READ, BasementDoorScript
	bg_event 17,  6, SIGNPOST_JUMPTEXT, UnknownText_0x7c91a
	bg_event  4, 13, SIGNPOST_ITEM + PARLYZ_HEAL, EVENT_WAREHOUSE_ENTRANCE_HIDDEN_PARLYZ_HEAL
	bg_event  2, 18, SIGNPOST_ITEM + SUPER_POTION, EVENT_WAREHOUSE_ENTRANCE_HIDDEN_SUPER_POTION
	bg_event 15,  8, SIGNPOST_ITEM + ANTIDOTE, EVENT_WAREHOUSE_ENTRANCE_HIDDEN_ANTIDOTE

	db 10 ; object events
	object_event  5, 11, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, GrampsScript_0x7c146, EVENT_WAREHOUSE_ENTRANCE_GRAMPS
	object_event  5, 14, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, OlderHaircutBrotherScript, EVENT_WAREHOUSE_ENTRANCE_OLDER_HAIRCUT_BROTHER
	object_event  5, 15, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, YoungerHaircutBrotherScript, EVENT_WAREHOUSE_ENTRANCE_YOUNGER_HAIRCUT_BROTHER
	object_event  5, 21, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, GrannyScript_0x7c132, EVENT_WAREHOUSE_ENTRANCE_GRANNY
	object_event  3, 31, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerSupernerdEric, -1
	object_event  4,  9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerSupernerdTeru, -1
	object_event  1, 27, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerPokemaniacIssac, -1
	object_event  0,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerPokemaniacDonald, -1
	itemball_event  4, 25, COIN_CASE, 1, EVENT_WAREHOUSE_ENTRANCE_COIN_CASE
	object_event  1, 18, SPRITE_COSPLAYER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerCosplayerClara, -1

	const_def 1 ; object constants
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
	writebyte $0
	copyvartobyte UndergroundSwitchPositions
	return

WarehouseEntranceCheckBasementKey:
	checkevent EVENT_USED_BASEMENT_KEY
	iffalse .LockBasementDoor
	return

.LockBasementDoor:
	changeblock 16, 6, $3d
	return

WarehouseEntranceCheckDayOfWeek:
	checkcode VAR_WEEKDAY
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
	return

.Monday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	checktime 1 << MORN
	iffalse .NotMondayMorning
	appear WAREHOUSEENTRANCE_GRAMPS
.NotMondayMorning:
	disappear WAREHOUSEENTRANCE_SUPER_NERD5
	disappear WAREHOUSEENTRANCE_SUPER_NERD6
	disappear WAREHOUSEENTRANCE_GRANNY
	return

.Tuesday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	appear WAREHOUSEENTRANCE_SUPER_NERD5
	disappear WAREHOUSEENTRANCE_SUPER_NERD6
	disappear WAREHOUSEENTRANCE_GRANNY
	return

.Wednesday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	disappear WAREHOUSEENTRANCE_SUPER_NERD5
	appear WAREHOUSEENTRANCE_SUPER_NERD6
	disappear WAREHOUSEENTRANCE_GRANNY
	return

.Thursday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	appear WAREHOUSEENTRANCE_SUPER_NERD5
	disappear WAREHOUSEENTRANCE_SUPER_NERD6
	disappear WAREHOUSEENTRANCE_GRANNY
	return

.Friday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	disappear WAREHOUSEENTRANCE_SUPER_NERD5
	appear WAREHOUSEENTRANCE_SUPER_NERD6
	disappear WAREHOUSEENTRANCE_GRANNY
	return

.Saturday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	appear WAREHOUSEENTRANCE_SUPER_NERD5
	disappear WAREHOUSEENTRANCE_SUPER_NERD6
	appear WAREHOUSEENTRANCE_GRANNY
	return

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

GrannyScript_0x7c132:
	checkcode VAR_WEEKDAY
	ifequal SUNDAY, .Open
	ifequal SATURDAY, .Open
	jumptext UnknownText_0x7c904

.Open:
	pokemart MARTTYPE_BITTER, MART_UNDERGROUND

GrampsScript_0x7c146:
	checkflag ENGINE_GOLDENROD_UNDERGROUND_MERCHANT_CLOSED
	iftrue_jumptext UnknownText_0x7c904
	checkcode VAR_WEEKDAY
	ifequal MONDAY, .CheckMorn
	jumptext UnknownText_0x7c904

.CheckMorn:
	checktime 1 << MORN
	iffalse_jumptext UnknownText_0x7c904
	pokemart MARTTYPE_BARGAIN, 0

OlderHaircutBrotherScript:
	checkcode VAR_WEEKDAY
	ifequal TUESDAY, .DoHaircut
	ifequal THURSDAY, .DoHaircut
	ifequal SATURDAY, .DoHaircut
	jumptext UnknownText_0x7c904

.DoHaircut:
	opentext
	checkflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	iftrue .AlreadyGotHaircut
	special PlaceMoneyTopRight
	writetext UnknownText_0x7c5f9
	yesorno
	iffalse .Refused
	checkmoney $0, 500
	ifequal $2, .NotEnoughMoney
	writetext UnknownText_0x7c69a
	buttonsound
	special Special_YoungerHaircutBrother
	ifequal $0, .Refused
	ifequal $1, .Refused
	setflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	ifequal $2, .two
	ifequal $3, .three
	jump .else

.two
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	jump .then

.three
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	jump .then

.else
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	jump .then

.then
	takemoney $0, 500
	special PlaceMoneyTopRight
	writetext UnknownText_0x7c6b8
	waitbutton
	closetext
	special FadeOutPalettes
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes
	special RestartMapMusic
	opentext
	writetext UnknownText_0x7c6d8
	waitbutton
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue UnknownScript_0x7c2bb
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue UnknownScript_0x7c2c4
	jump UnknownScript_0x7c2cd

.Refused:
	jumpopenedtext UnknownText_0x7c6ea

.NotEnoughMoney:
	jumpopenedtext UnknownText_0x7c709

.AlreadyGotHaircut:
	jumpopenedtext UnknownText_0x7c72b

YoungerHaircutBrotherScript:
	checkcode VAR_WEEKDAY
	ifequal SUNDAY, .DoHaircut
	ifequal WEDNESDAY, .DoHaircut
	ifequal FRIDAY, .DoHaircut
	jumptext UnknownText_0x7c904

.DoHaircut:
	opentext
	checkflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	iftrue .AlreadyGotHaircut
	special PlaceMoneyTopRight
	writetext UnknownText_0x7c75c
	yesorno
	iffalse .Refused
	checkmoney $0, 300
	ifequal $2, .NotEnoughMoney
	writetext UnknownText_0x7c7f1
	buttonsound
	special Special_OlderHaircutBrother
	ifequal $0, .Refused
	ifequal $1, .Refused
	setflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	ifequal $2, .two
	ifequal $3, .three
	jump .else

.two
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	jump .then

.three
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	jump .then

.else
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
.then
	takemoney $0, 300
	special PlaceMoneyTopRight
	writetext UnknownText_0x7c80e
	waitbutton
	closetext
	special FadeOutPalettes
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes
	special RestartMapMusic
	opentext
	writetext UnknownText_0x7c82a
	waitbutton
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue UnknownScript_0x7c2bb
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue UnknownScript_0x7c2c4
	jump UnknownScript_0x7c2cd

.Refused:
	jumpopenedtext UnknownText_0x7c842

.NotEnoughMoney:
	jumpopenedtext UnknownText_0x7c85b

.AlreadyGotHaircut:
	jumpopenedtext UnknownText_0x7c87b

UnknownScript_0x7c2bb:
	writetext HaircutBrosText_SlightlyHappier
	special PlayCurMonCry
	waitendtext

UnknownScript_0x7c2c4:
	writetext HaircutBrosText_Happier
	special PlayCurMonCry
	waitendtext

UnknownScript_0x7c2cd:
	writetext HaircutBrosText_MuchHappier
	special PlayCurMonCry
	waitendtext

BasementDoorScript::
	checkevent EVENT_USED_BASEMENT_KEY
	iftrue_jumptext UnknownText_0x7c5c3
	checkitem BASEMENT_KEY
	iffalse_jumptext UnknownText_0x7c5b0
	opentext
	playsound SFX_TRANSACTION
	writetext UnknownText_0x7c5d6
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

UnknownText_0x7c5b0:
	text "The door's locked…"
	done

UnknownText_0x7c5c3:
	text "The door is open."
	done

UnknownText_0x7c5d6:
	text "The Basement Key"
	line "opened the door."
	done

UnknownText_0x7c5f9:
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

UnknownText_0x7c69a:
	text "Which #mon"
	line "should I work on?"
	done

UnknownText_0x7c6b8:
	text "OK! Watch it"
	line "become beautiful!"
	done

UnknownText_0x7c6d8:
	text "There! All done!"
	done

UnknownText_0x7c6ea:
	text "Is that right?"
	line "That's a shame!"
	done

UnknownText_0x7c709:
	text "You'll need more"
	line "money than that."
	done

UnknownText_0x7c72b:
	text "I do only one"
	line "haircut a day. I'm"
	cont "done for today."
	done

UnknownText_0x7c75c:
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

UnknownText_0x7c7f1:
	text "OK, which #mon"
	line "should I do?"
	done

UnknownText_0x7c80e:
	text "OK! I'll make it"
	line "look cool!"
	done

UnknownText_0x7c82a:
	text "There we go!"
	line "All done!"
	done

UnknownText_0x7c842:
	text "No?"
	line "How disappointing!"
	done

UnknownText_0x7c85b:
	text "You're a little"
	line "short on funds."
	done

UnknownText_0x7c87b:
	text "I can do only one"
	line "haircut a day."

	para "Sorry, but I'm all"
	line "done for today."
	done

HaircutBrosText_SlightlyHappier:
	text_from_ram StringBuffer3
	text " looks a"
	line "little happier."
	done

HaircutBrosText_Happier:
	text_from_ram StringBuffer3
	text " looks"
	line "happy."
	done

HaircutBrosText_MuchHappier:
	text_from_ram StringBuffer3
	text " looks"
	line "delighted!"
	done

UnknownText_0x7c904:
	text "We're not open"
	line "today."
	done

UnknownText_0x7c91a:
	text "NO ENTRY BEYOND"
	line "THIS POINT"
	done
