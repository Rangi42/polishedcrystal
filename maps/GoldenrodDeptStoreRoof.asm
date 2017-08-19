GoldenrodDeptStoreRoof_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 2
	dbw MAPCALLBACK_TILES, GoldenrodDeptStoreRoofCheckSaleChangeBlock
	dbw MAPCALLBACK_OBJECTS, GoldenrodDeptStoreRoofCheckSaleChangeClerk

GoldenrodDeptStoreRoof_MapEventHeader:

.Warps: db 1
	warp_def 1, 13, 3, GOLDENROD_DEPT_STORE_6F

.XYTriggers: db 0

.Signposts: db 4
	signpost 3, 15, SIGNPOST_RIGHT, Binoculars1
	signpost 5, 15, SIGNPOST_RIGHT, Binoculars2
	signpost 6, 15, SIGNPOST_RIGHT, Binoculars3
	signpost 0, 3, SIGNPOST_UP, PokeDollVendingMachine

.PersonEvents: db 8
	person_event SPRITE_FISHER, 1, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, FisherScript_0x56749, -1
	person_event SPRITE_POKEFAN_F, 3, 10, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5677f, -1
	person_event SPRITE_SUPER_NERD, 6, 14, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x56757, EVENT_GOLDENROD_SALE_ON
	person_event SPRITE_TWIN, 4, 3, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x56839, EVENT_GOLDENROD_SALE_ON
	person_event SPRITE_CLERK, 4, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_ROOFTOP, 0, EVENT_GOLDENROD_SALE_OFF
	person_event SPRITE_POKEFAN_M, 0, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5688e, EVENT_GOLDENROD_SALE_OFF
	person_event SPRITE_TEACHER, 3, 5, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x56901, EVENT_GOLDENROD_SALE_OFF
	person_event SPRITE_BUG_CATCHER, 6, 1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x56942, EVENT_GOLDENROD_SALE_OFF

GoldenrodDeptStoreRoofCheckSaleChangeBlock:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue .ChangeBlock
	return

.ChangeBlock:
	changeblock 0, 2, $3f
	changeblock 0, 4, $f
	return

GoldenrodDeptStoreRoofCheckSaleChangeClerk:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue .ChangeClerk
	setevent EVENT_GOLDENROD_SALE_OFF
	clearevent EVENT_GOLDENROD_SALE_ON
	return

.ChangeClerk:
	clearevent EVENT_GOLDENROD_SALE_OFF
	setevent EVENT_GOLDENROD_SALE_ON
	return

FisherScript_0x56749:
	faceplayer
	opentext
	writetext UnknownText_0x567d2
	waitbutton
	checkevent EVENT_DECO_VOLTORB_DOLL
	iftrue .AlreadyGotVoltorbDoll
	writetext GoldenrodDeptStoreRoofFisherDuplicateText
	waitbutton
	setevent EVENT_DECO_VOLTORB_DOLL
	writetext GotVoltorbDollText
	playsound SFX_ITEM
	pause 60
	buttonsound
	writetext VoltorbDollSentText
	waitbutton
	writetext GoldenrodDeptStoreRoofFisherCatchEmAllText
	waitbutton
.AlreadyGotVoltorbDoll
	closetext
	spriteface LAST_TALKED, UP
	end

SuperNerdScript_0x56757:
	showtext UnknownText_0x56867
	faceplayer
	showtext UnknownText_0x56871
	spriteface LAST_TALKED, RIGHT
	end

Binoculars1:
	jumptext Binoculars1Text

Binoculars2:
	jumptext Binoculars2Text

Binoculars3:
	jumptext Binoculars3Text

PokeDollVendingMachine:
	opentext
	writetext PokeDollVendingMachineText
.Start:
	special PlaceMoneyTopRight
	loadmenudata .MenuData
	verticalmenu
	closewindow
	if_equal $1, .JigglypuffDoll
	if_equal $2, .GeodudeDoll
	if_equal $3, .OddishDoll
	endtext

.JigglypuffDoll:
	checkmoney $0, 2400
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_JIGGLYPUFF_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_JIGGLYPUFF_DOLL
	writetext BoughtJigglypuffDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext JigglypuffDollSentText
	waitbutton
	jump .Start

.GeodudeDoll:
	checkmoney $0, 2400
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_GEODUDE_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_GEODUDE_DOLL
	writetext BoughtGeodudeDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext GeodudeDollSentText
	waitbutton
	jump .Start

.OddishDoll:
	checkmoney $0, 2400
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_ODDISH_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_ODDISH_DOLL
	writetext BoughtOddishDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext OddishDollSentText
	waitbutton
	jump .Start

.NotEnoughMoney:
	writetext PokeDollVendingMachineNoMoneyText
	waitbutton
	jump .Start

.AlreadyBought:
	writetext PokeDollVendingMachineAlreadyBoughtText
	waitbutton
	jump .Start

.MenuData:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Jigglypuff  ¥2400@"
	db "Geodude     ¥2400@"
	db "Oddish      ¥2400@"
	db "Cancel@"

UnknownText_0x5677f:
	text "Whew, I'm tired."

	para "I sometimes come"
	line "up to the rooftop"

	para "to take a break"
	line "from shopping."
	done

UnknownText_0x567d2:
	text "Pardon? Who says"
	line "an adult can't get"
	cont "into this?"

	para "I'm going to be"
	line "back every day to"

	para "collect all the"
	line "dolls!"
	done

GoldenrodDeptStoreRoofFisherDuplicateText:
	text "This one is a"
	line "duplicate. Here,"
	cont "you can have it."
	done

GotVoltorbDollText:
	text "<PLAYER> received"
	line "Voltorb Doll."
	done

VoltorbDollSentText:
	text "Voltorb Doll"
	line "was sent home."
	done

GoldenrodDeptStoreRoofFisherCatchEmAllText:
	text "I heard there are"
	line "22 kinds of dolls."
	done

UnknownText_0x56839:
	text "They have bargain"
	line "sales here every"
	cont "so often."
	done

UnknownText_0x56867:
	text "Oh, wow!"
	done

UnknownText_0x56871:
	text "Will you quit"
	line "bothering me?"
	done

UnknownText_0x5688e:
	text "There's something"
	line "I really want, but"

	para "I don't have the"
	line "necessary cash…"

	para "Maybe I'll sell"
	line "off the Berries"
	cont "I've collected…"
	done

UnknownText_0x56901:
	text "Oh, everything is"
	line "so cheap!"

	para "I bought so much,"
	line "my Bag's crammed!"
	done

UnknownText_0x56942:
	text "My #mon always"
	line "get paralyzed or"

	para "poisoned when the"
	line "chips are down…"

	para "So I came to buy"
	line "some Full Heal."

	para "I wonder if"
	line "there's any left?"
	done

Binoculars1Text:
	text "These binoculars"
	line "let me see far"

	para "away. Maybe I can"
	line "see my own house."

	para "Is it the one with"
	line "the green roof?"
	done

Binoculars2Text:
	text "Hey! Some trainers"
	line "are battling on"
	cont "the road!"

	para "A #mon fired a"
	line "flurry of leaves!"

	para "That makes me feel"
	line "like battling"
	cont "right now!"
	done

Binoculars3Text:
	text "A Fisher caught a"
	line "lot of Magikarp…"

	para "They're Splashing"
	line "at the same time!"

	para "Look at the water"
	line "going everywhere!"
	done

PokeDollVendingMachineText:
	text "A vending machine"
	line "for #mon dolls!"
	done

PokeDollVendingMachineNoMoneyText:
	text "It costs too much!"
	done

PokeDollVendingMachineAlreadyBoughtText:
	text "It's a duplicate!"
	done

BoughtJigglypuffDollText:
	text "<PLAYER> bought"
	line "Jigglypuff Doll."
	done

JigglypuffDollSentText:
	text "Jigglypuff Doll"
	line "was sent home."
	done

BoughtGeodudeDollText:
	text "<PLAYER> bought"
	line "Geodude Doll."
	done

GeodudeDollSentText:
	text "Geodude Doll"
	line "was sent home."
	done

BoughtOddishDollText:
	text "<PLAYER> bought"
	line "Oddish Doll."
	done

OddishDollSentText:
	text "Oddish Doll"
	line "was sent home."
	done
