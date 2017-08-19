CeladonHomeDecorStore3F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonHomeDecorStore3F_MapEventHeader:

.Warps: db 2
	warp_def 0, 6, 2, CELADON_HOME_DECOR_STORE_2F
	warp_def 0, 9, 1, CELADON_HOME_DECOR_STORE_4F

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 8, SIGNPOST_JUMPTEXT, CeladonHomeDecorStore3FDirectoryText

.PersonEvents: db 4
	person_event SPRITE_CLERK, 7, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHomeDecorStore3FClerk1Script, -1
	person_event SPRITE_CLERK, 7, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHomeDecorStore3FClerk2Script, -1
	person_event SPRITE_YOUNGSTER, 5, 3, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore3FYoungsterText, -1
	person_event SPRITE_BEAUTY, 3, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore3FBeautyText, -1

CeladonHomeDecorStore3FClerk1Script:
	faceplayer
	opentext
	writetext CeladonHomeDecorStore3FClerk1Text
.Start:
	special PlaceMoneyTopRight
	loadmenudata .MenuData
	verticalmenu
	closewindow
	if_equal $1, .RedCarpet
	if_equal $2, .YellowCarpet
	if_equal $3, .GreenCarpet
	endtext

.RedCarpet:
	checkmoney $0, 45000
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_CARPET_1
	iftrue .AlreadyBought
	takemoney $0, 45000
	setevent EVENT_DECO_CARPET_1
	writetext BoughtRedCarpetText
	playsound SFX_TRANSACTION
	waitbutton
	writetext RedCarpetSentText
	waitbutton
	jump .Start

.YellowCarpet:
	checkmoney $0, 45000
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_CARPET_3
	iftrue .AlreadyBought
	takemoney $0, 45000
	setevent EVENT_DECO_CARPET_3
	writetext BoughtYellowCarpetText
	playsound SFX_TRANSACTION
	waitbutton
	writetext YellowCarpetSentText
	waitbutton
	jump .Start

.GreenCarpet:
	checkmoney $0, 45000
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_CARPET_4
	iftrue .AlreadyBought
	takemoney $0, 45000
	setevent EVENT_DECO_CARPET_4
	writetext BoughtGreenCarpetText
	playsound SFX_TRANSACTION
	waitbutton
	writetext GreenCarpetSentText
	waitbutton
	jump .Start

.NotEnoughMoney:
	writetext CeladonHomeDecorStore3FNoMoneyText
	waitbutton
	jump .Start

.AlreadyBought:
	writetext CeladonHomeDecorStore3FAlreadyBoughtText
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
	db "Red C.    ¥45000@"
	db "Yellow C. ¥45000@"
	db "Green C.  ¥45000@"
	db "Cancel@"

CeladonHomeDecorStore3FClerk2Script:
	faceplayer
	opentext
	checkevent EVENT_DECO_CARPET_2
	iftrue_jumpopenedtext CeladonHomeDecorStore3FClerk2Text
	special PlaceMoneyTopRight
	writetext CeladonHomeDecorStore3FClerk2SaleText
	yesorno
	iffalse_jumpopenedtext CeladonHomeDecorStore3FClerk2NoText
	checkmoney $0, 35000
	if_equal $2, .NotEnoughMoney
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
