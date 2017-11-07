WarehouseEntrance_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 3
	dbw MAPCALLBACK_NEWMAP, WarehouseEntranceResetSwitches
	dbw MAPCALLBACK_TILES, WarehouseEntranceCheckBasementKey
	dbw MAPCALLBACK_OBJECTS, WarehouseEntranceCheckDayOfWeek

WarehouseEntrance_MapEventHeader:

.Warps: db 6
	warp_def 2, 1, 7, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES
	warp_def 34, 1, 4, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES
	warp_def 6, 16, 4, WAREHOUSE_ENTRANCE
	warp_def 35, 13, 3, WAREHOUSE_ENTRANCE
	warp_def 35, 14, 3, WAREHOUSE_ENTRANCE
	warp_def 31, 14, 1, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES

.XYTriggers: db 0

.Signposts: db 5
	signpost 6, 16, SIGNPOST_READ, BasementDoorScript
	signpost 6, 17, SIGNPOST_JUMPTEXT, UnknownText_0x7c91a
	signpost 13, 4, SIGNPOST_ITEM + PARLYZ_HEAL, EVENT_WAREHOUSE_ENTRANCE_HIDDEN_PARLYZ_HEAL
	signpost 18, 2, SIGNPOST_ITEM + SUPER_POTION, EVENT_WAREHOUSE_ENTRANCE_HIDDEN_SUPER_POTION
	signpost 8, 15, SIGNPOST_ITEM + ANTIDOTE, EVENT_WAREHOUSE_ENTRANCE_HIDDEN_ANTIDOTE

.PersonEvents: db 10
	person_event SPRITE_GRAMPS, 11, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, GrampsScript_0x7c146, EVENT_WAREHOUSE_ENTRANCE_GRAMPS
	person_event SPRITE_SUPER_NERD, 14, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OlderHaircutBrotherScript, EVENT_WAREHOUSE_ENTRANCE_OLDER_HAIRCUT_BROTHER
	person_event SPRITE_SUPER_NERD, 15, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, YoungerHaircutBrotherScript, EVENT_WAREHOUSE_ENTRANCE_YOUNGER_HAIRCUT_BROTHER
	person_event SPRITE_GRANNY, 21, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, GrannyScript_0x7c132, EVENT_WAREHOUSE_ENTRANCE_GRANNY
	person_event SPRITE_SUPER_NERD, 31, 3, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerSupernerdEric, -1
	person_event SPRITE_SUPER_NERD, 9, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerSupernerdTeru, -1
	person_event SPRITE_SUPER_NERD, 27, 1, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerPokemaniacIssac, -1
	person_event SPRITE_SUPER_NERD, 6, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPokemaniacDonald, -1
	itemball_event 25, 4, COIN_CASE, 1, EVENT_WAREHOUSE_ENTRANCE_COIN_CASE
	person_event SPRITE_COSPLAYER, 18, 1, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerCosplayerClara, -1

const_value set 1
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
	if_equal MONDAY, .Monday
	if_equal TUESDAY, .Tuesday
	if_equal WEDNESDAY, .Wednesday
	if_equal THURSDAY, .Thursday
	if_equal FRIDAY, .Friday
	if_equal SATURDAY, .Saturday

.Sunday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	disappear WAREHOUSEENTRANCE_SUPER_NERD5
	appear WAREHOUSEENTRANCE_SUPER_NERD6
	appear WAREHOUSEENTRANCE_GRANNY
	return

.Monday:
	disappear WAREHOUSEENTRANCE_GRAMPS
	checkmorn
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

TrainerSupernerdEric:
	trainer EVENT_BEAT_SUPER_NERD_ERIC, SUPER_NERD, ERIC, SupernerdEricSeenText, SupernerdEricBeatenText, 0, SupernerdEricScript

SupernerdEricScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7c36c

TrainerSupernerdTeru:
	trainer EVENT_BEAT_SUPER_NERD_TERU, SUPER_NERD, TERU, SupernerdTeruSeenText, SupernerdTeruBeatenText, 0, SupernerdTeruScript

SupernerdTeruScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7c410

TrainerPokemaniacIssac:
	trainer EVENT_BEAT_POKEMANIAC_ISSAC, POKEMANIAC, ISSAC, PokemaniacIssacSeenText, PokemaniacIssacBeatenText, 0, PokemaniacIssacScript

PokemaniacIssacScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7c498

TrainerPokemaniacDonald:
	trainer EVENT_BEAT_POKEMANIAC_DONALD, POKEMANIAC, DONALD, PokemaniacDonaldSeenText, PokemaniacDonaldBeatenText, 0, PokemaniacDonaldScript

PokemaniacDonaldScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7c52f

TrainerCosplayerClara:
	trainer EVENT_BEAT_COSPLAYER_CLARA, COSPLAYER, CLARA, CosplayerClaraSeenText, CosplayerClaraBeatenText, 0, CosplayerClaraScript

CosplayerClaraScript:
	end_if_just_battled
	jumptextfaceplayer CosplayerClaraAfterText

GrannyScript_0x7c132:
	checkcode VAR_WEEKDAY
	if_equal SUNDAY, .Open
	if_equal SATURDAY, .Open
	jump WarehouseEntranceScript_ShopClosed

.Open:
	pokemart MARTTYPE_BITTER, MART_UNDERGROUND

GrampsScript_0x7c146:
	checkflag ENGINE_GOLDENROD_UNDERGROUND_MERCHANT_CLOSED
	iftrue WarehouseEntranceScript_ShopClosed
	checkcode VAR_WEEKDAY
	if_equal MONDAY, .CheckMorn
	jump WarehouseEntranceScript_ShopClosed

.CheckMorn:
	checkmorn
	iffalse WarehouseEntranceScript_ShopClosed
	pokemart MARTTYPE_BARGAIN, 0

OlderHaircutBrotherScript:
	checkcode VAR_WEEKDAY
	if_equal TUESDAY, .DoHaircut
	if_equal THURSDAY, .DoHaircut
	if_equal SATURDAY, .DoHaircut
	jump WarehouseEntranceScript_ShopClosed

.DoHaircut:
	opentext
	checkflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	iftrue .AlreadyGotHaircut
	special PlaceMoneyTopRight
	writetext UnknownText_0x7c5f9
	yesorno
	iffalse .Refused
	checkmoney $0, 500
	if_equal $2, .NotEnoughMoney
	writetext UnknownText_0x7c69a
	buttonsound
	special Special_YoungerHaircutBrother
	if_equal $0, .Refused
	if_equal $1, .Refused
	setflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	if_equal $2, .two
	if_equal $3, .three
	jump .else

.two
	setevent EVENT_GAVE_KURT_APRICORNS
	clearevent EVENT_RECEIVED_BALLS_FROM_KURT
	clearevent EVENT_DRAGON_SHRINE_QUESTION_2
	jump .then

.three
	clearevent EVENT_GAVE_KURT_APRICORNS
	setevent EVENT_RECEIVED_BALLS_FROM_KURT
	clearevent EVENT_DRAGON_SHRINE_QUESTION_2
	jump .then

.else
	clearevent EVENT_GAVE_KURT_APRICORNS
	clearevent EVENT_RECEIVED_BALLS_FROM_KURT
	setevent EVENT_DRAGON_SHRINE_QUESTION_2
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
	checkevent EVENT_GAVE_KURT_APRICORNS
	iftrue UnknownScript_0x7c2bb
	checkevent EVENT_RECEIVED_BALLS_FROM_KURT
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
	if_equal SUNDAY, .DoHaircut
	if_equal WEDNESDAY, .DoHaircut
	if_equal FRIDAY, .DoHaircut
	jump WarehouseEntranceScript_ShopClosed

.DoHaircut:
	opentext
	checkflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	iftrue .AlreadyGotHaircut
	special PlaceMoneyTopRight
	writetext UnknownText_0x7c75c
	yesorno
	iffalse .Refused
	checkmoney $0, 300
	if_equal $2, .NotEnoughMoney
	writetext UnknownText_0x7c7f1
	buttonsound
	special Special_OlderHaircutBrother
	if_equal $0, .Refused
	if_equal $1, .Refused
	setflag ENGINE_GOLDENROD_UNDERGROUND_GOT_HAIRCUT
	if_equal $2, .two
	if_equal $3, .three
	jump .else

.two
	setevent EVENT_GAVE_KURT_APRICORNS
	clearevent EVENT_RECEIVED_BALLS_FROM_KURT
	clearevent EVENT_DRAGON_SHRINE_QUESTION_2
	jump .then

.three
	clearevent EVENT_GAVE_KURT_APRICORNS
	setevent EVENT_RECEIVED_BALLS_FROM_KURT
	clearevent EVENT_DRAGON_SHRINE_QUESTION_2
	jump .then

.else
	clearevent EVENT_GAVE_KURT_APRICORNS
	clearevent EVENT_RECEIVED_BALLS_FROM_KURT
	setevent EVENT_DRAGON_SHRINE_QUESTION_2
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
	checkevent EVENT_GAVE_KURT_APRICORNS
	iftrue UnknownScript_0x7c2bb
	checkevent EVENT_RECEIVED_BALLS_FROM_KURT
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

WarehouseEntranceScript_ShopClosed:
	jumptext UnknownText_0x7c904

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

UnknownText_0x7c36c:
	text "I guess I have to"
	line "do things fair and"
	cont "square…"
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

UnknownText_0x7c410:
	text "I know my #mon"
	line "type alignments."

	para "But I only use one"
	line "type of #mon."
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

UnknownText_0x7c498:
	text "Your #mon will"
	line "like you more if"

	para "you give them"
	line "haircuts."
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

UnknownText_0x7c52f:
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

CosplayerClaraSeenText:
	text "Pix! Vul, pix! ♥"
	done

CosplayerClaraBeatenText:
	text "You thought I was"
	line "a #mon?"

	para "Nope! It's just"
	line "quality cosplay."
	done

CosplayerClaraAfterText:
	text "I made this cos-"
	line "tume myself!"
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
