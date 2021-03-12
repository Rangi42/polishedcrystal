CeladonHomeDecorStore3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  0, CELADON_HOME_DECOR_STORE_2F, 2
	warp_event  9,  0, CELADON_HOME_DECOR_STORE_4F, 1

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, CeladonHomeDecorStore3FDirectoryText

	def_object_events
	object_event  7,  7, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonHomeDecorStore3FClerk1Script, -1
	object_event  8,  7, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonHomeDecorStore3FClerk2Script, -1
	object_event  3,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore3FYoungsterText, -1
	object_event  9,  3, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore3FBeautyText, -1

CeladonHomeDecorStore3FClerk1Script:
	faceplayer
	opentext
	writetext CeladonHomeDecorStore3FClerk1Text
.Start:
	special PlaceMoneyTopRight
	loadmenu .MenuData
	verticalmenu
	closewindow
	ifequal $1, .RedCarpet
	ifequal $2, .YellowCarpet
	ifequal $3, .GreenCarpet
	endtext

.RedCarpet:
	checkmoney $0, 45000
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_CARPET_1
	iftrue .AlreadyBought
	takemoney $0, 45000
	setevent EVENT_DECO_CARPET_1
	writetext BoughtRedCarpetText
	playsound SFX_TRANSACTION
	waitbutton
	writetext RedCarpetSentText
	waitbutton
	sjump .Start

.YellowCarpet:
	checkmoney $0, 45000
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_CARPET_3
	iftrue .AlreadyBought
	takemoney $0, 45000
	setevent EVENT_DECO_CARPET_3
	writetext BoughtYellowCarpetText
	playsound SFX_TRANSACTION
	waitbutton
	writetext YellowCarpetSentText
	waitbutton
	sjump .Start

.GreenCarpet:
	checkmoney $0, 45000
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_CARPET_4
	iftrue .AlreadyBought
	takemoney $0, 45000
	setevent EVENT_DECO_CARPET_4
	writetext BoughtGreenCarpetText
	playsound SFX_TRANSACTION
	waitbutton
	writetext GreenCarpetSentText
	waitbutton
	sjump .Start

.NotEnoughMoney:
	writetext CeladonHomeDecorStore3FNoMoneyText
	waitbutton
	sjump .Start

.AlreadyBought:
	writetext CeladonHomeDecorStore3FAlreadyBoughtText
	waitbutton
	sjump .Start

.MenuData:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Red C.    ¥45000@"
	db "Yellow C. ¥45000@"
	db "Green C.  ¥45000@"
	db "Cancel@"

CeladonHomeDecorStore3FClerk2Script:
	checkevent EVENT_DECO_CARPET_2
	iftrue_jumptextfaceplayer CeladonHomeDecorStore3FClerk2Text
	faceplayer
	opentext
	special PlaceMoneyTopRight
	writetext CeladonHomeDecorStore3FClerk2SaleText
	yesorno
	iffalse_jumpopenedtext CeladonHomeDecorStore3FClerk2NoText
	checkmoney $0, 35000
	ifequal $2, .NotEnoughMoney
	takemoney $0, 35000
	setevent EVENT_DECO_CARPET_2
	writetext BoughtBlueCarpetText
	playsound SFX_TRANSACTION
	waitbutton
	writetext BlueCarpetSentText
	waitbutton
	jumpopenedtext CeladonHomeDecorStore3FClerk2YesText

.NotEnoughMoney:
	jumpopenedtext CeladonHomeDecorStore3FNoMoneyText

CeladonHomeDecorStore3FClerk1Text:
	text "Welcome! Would"
	line "you like a carpet?"
	done

CeladonHomeDecorStore3FClerk2Text:
	text "Doesn't a carpet"
	line "really tie your"
	cont "room together?"
	done

CeladonHomeDecorStore3FClerk2SaleText:
	text "Our imported"
	line "Royal Blue Carpet"

	para "is on sale right"
	line "now for ¥35,000."

	para "Would you like to"
	line "buy one?"
	done

CeladonHomeDecorStore3FClerk2YesText:
	text "Thank you!"
	line "Have a nice day!"
	done

CeladonHomeDecorStore3FClerk2NoText:
	text "Have a nice day!"
	done

BoughtRedCarpetText:
	text "<PLAYER> bought"
	line "Red Carpet."
	done

RedCarpetSentText:
	text "Red Carpet"
	line "was sent home."
	done

BoughtBlueCarpetText:
	text "<PLAYER> bought"
	line "Blue Carpet."
	done

BlueCarpetSentText:
	text "Blue Carpet"
	line "was sent home."
	done

BoughtYellowCarpetText:
	text "<PLAYER> bought"
	line "Yellow Carpet."
	done

YellowCarpetSentText:
	text "Yellow Carpet"
	line "was sent home."
	done

BoughtGreenCarpetText:
	text "<PLAYER> bought"
	line "Green Carpet."
	done

GreenCarpetSentText:
	text "Green Carpet"
	line "was sent home."
	done

CeladonHomeDecorStore3FNoMoneyText:
	text "You can't afford"
	line "that!"
	done

CeladonHomeDecorStore3FAlreadyBoughtText:
	text "You already have"
	line "that!"
	done

CeladonHomeDecorStore3FYoungsterText:
	text "This carpet feels"
	line "so plush!"
	done

CeladonHomeDecorStore3FBeautyText:
	text "Some of these"
	line "carpets are im-"
	cont "ported from Kalos!"
	done

CeladonHomeDecorStore3FDirectoryText:
	text "Colorful Elegance"

	para "3F: Carpets"
	done
