GoldenrodDeptStoreRoof_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, GoldenrodDeptStoreRoofCheckSaleChangeBlock
	callback MAPCALLBACK_OBJECTS, GoldenrodDeptStoreRoofCheckSaleChangeClerk

	def_warp_events
	warp_event 13,  1, GOLDENROD_DEPT_STORE_6F, 3

	def_coord_events

	def_bg_events
	bg_event 15,  3, BGEVENT_RIGHT, Binoculars1
	bg_event 15,  5, BGEVENT_RIGHT, Binoculars2
	bg_event 15,  6, BGEVENT_RIGHT, Binoculars3
	bg_event  3,  0, BGEVENT_UP, PokeDollVendingMachine

	def_object_events
	object_event  2,  1, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofFisherScript, -1
	object_event 10,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStoreRoofPokefanFText, -1
	object_event 14,  6, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofSuperNerdScript, EVENT_GOLDENROD_SALE_ON
	object_event  3,  4, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStoreRoofTwinText, EVENT_GOLDENROD_SALE_ON
	object_event  1,  4, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_ROOFTOP, 0, EVENT_GOLDENROD_SALE_OFF
	object_event  7,  0, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStoreRoofPokefanMText, EVENT_GOLDENROD_SALE_OFF
	object_event  5,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStoreRoofTeacherText, EVENT_GOLDENROD_SALE_OFF
	object_event  1,  6, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStoreRoofBugCatcherText, EVENT_GOLDENROD_SALE_OFF

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

GoldenrodDeptStoreRoofFisherScript:
	faceplayer
	opentext
	checkevent EVENT_DECO_VOLTORB_DOLL
	iftrue .AlreadyGotVoltorbDoll
	writetext GoldenrodDeptStoreRoofFisherText
	waitbutton
	writetext GoldenrodDeptStoreRoofFisherDuplicateText
	waitbutton
	setevent EVENT_DECO_VOLTORB_DOLL
	writetext GotVoltorbDollText
	playsound SFX_ITEM
	pause 60
	buttonsound
	writetext VoltorbDollSentText
	waitbutton
.AlreadyGotVoltorbDoll
	writetext GoldenrodDeptStoreRoofFisherCatchEmAllText
	waitbutton
	closetext
	turnobject LAST_TALKED, UP
	end

GoldenrodDeptStoreRoofSuperNerdScript:
	showtext GoldenrodDeptStoreRoofSuperNerdOhWowText
	faceplayer
	showtext GoldenrodDeptStoreRoofSuperNerdQuitBotheringMeText
	turnobject LAST_TALKED, RIGHT
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
	loadmenu .MenuData
	verticalmenu
	closewindow
	ifequal $1, .JigglypuffDoll
	ifequal $2, .DittoDoll
	ifequal $3, .MeowthDoll
	endtext

.JigglypuffDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
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

.DittoDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_DITTO_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_DITTO_DOLL
	writetext BoughtDittoDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext DittoDollSentText
	waitbutton
	jump .Start

.MeowthDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_MEOWTH_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_MEOWTH_DOLL
	writetext BoughtMeowthDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext MeowthDollSentText
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
	db "Ditto       ¥2400@"
	db "Meowth      ¥2400@"
	db "Cancel@"

GoldenrodDeptStoreRoofPokefanFText:
	text "Whew, I'm tired."

	para "I sometimes come"
	line "up to the rooftop"

	para "to take a break"
	line "from shopping."
	done

GoldenrodDeptStoreRoofFisherText:
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
	line "30 kinds of dolls."
	done

GoldenrodDeptStoreRoofTwinText:
	text "They have bargain"
	line "sales here every"
	cont "so often."
	done

GoldenrodDeptStoreRoofSuperNerdOhWowText:
	text "Oh, wow!"
	done

GoldenrodDeptStoreRoofSuperNerdQuitBotheringMeText:
	text "Will you quit"
	line "bothering me?"
	done

GoldenrodDeptStoreRoofPokefanMText:
	text "There's something"
	line "I really want, but"

	para "I don't have the"
	line "necessary cash…"

	para "Maybe I'll sell"
	line "off the Berries"
	cont "I've collected…"
	done

GoldenrodDeptStoreRoofTeacherText:
	text "Oh, everything is"
	line "so cheap!"

	para "I bought so much,"
	line "my Bag's crammed!"
	done

GoldenrodDeptStoreRoofBugCatcherText:
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

BoughtDittoDollText:
	text "<PLAYER> bought"
	line "Ditto Doll."
	done

DittoDollSentText:
	text "Ditto Doll"
	line "was sent home."
	done

BoughtMeowthDollText:
	text "<PLAYER> bought"
	line "Meowth Doll."
	done

MeowthDollSentText:
	text "Meowth Doll"
	line "was sent home."
	done
