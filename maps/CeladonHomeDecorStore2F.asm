CeladonHomeDecorStore2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonHomeDecorStore2F_MapEventHeader:

.Warps: db 2
	warp_def 0, 9, 3, CELADON_HOME_DECOR_STORE_1F
	warp_def 0, 6, 1, CELADON_HOME_DECOR_STORE_3F

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 8, SIGNPOST_JUMPTEXT, CeladonHomeDecorStore2FDirectoryText

.PersonEvents: db 2
	person_event SPRITE_CLERK, 5, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHomeDecorStore2FClerkScript, -1
	person_event SPRITE_POKEFAN_F, 1, 3, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore2FPokefanfText, -1

CeladonHomeDecorStore2FClerkScript:
	faceplayer
	opentext
	writetext CeladonHomeDecorStore2FClerkText
.Start:
	special PlaceMoneyTopRight
	loadmenudata .MenuData
	verticalmenu
	closewindow
	if_equal $1, .PinkBed
	if_equal $2, .PolkaDotBed
	if_equal $3, .PikachuBed
	endtext

.PinkBed:
	checkmoney $0, 62000
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_BED_2
	iftrue .AlreadyBought
	takemoney $0, 62000
	setevent EVENT_DECO_BED_2
	writetext BoughtPinkBedText
	playsound SFX_TRANSACTION
	waitbutton
	writetext PinkBedSentText
	waitbutton
	jump .Start

.PolkaDotBed:
	checkmoney $0, 94000
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_BED_3
	iftrue .AlreadyBought
	takemoney $0, 94000
	setevent EVENT_DECO_BED_3
	writetext BoughtPolkaDotBedText
	playsound SFX_TRANSACTION
	waitbutton
	writetext PolkaDotBedSentText
	waitbutton
	jump .Start

.PikachuBed:
	checkmoney $0, 126000
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_BED_4
	iftrue .AlreadyBought
	takemoney $0, 126000
	setevent EVENT_DECO_BED_4
	writetext BoughtPikachuBedText
	playsound SFX_TRANSACTION
	waitbutton
	writetext PikachuBedSentText
	waitbutton
	jump .Start

.NotEnoughMoney:
	writetext CeladonHomeDecorStore2FNoMoneyText
	waitbutton
	jump .Start

.AlreadyBought:
	writetext CeladonHomeDecorStore2FAlreadyBoughtText
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
	db "Pink      ¥62000@"
	db "PolkaDot  ¥94000@"
	db "Pikachu  ¥126000@"
	db "Cancel@"

CeladonHomeDecorStore2FClerkText:
	text "Welcome! Are you"
	line "in the market for"
	cont "a new bed?"
	done

BoughtPinkBedText:
	text "<PLAYER> bought"
	line "Pink Bed."
	done

PinkBedSentText:
	text "Pink Bed"
	line "was sent home."
	done

BoughtPolkaDotBedText:
	text "<PLAYER> bought"
	line "PolkaDot Bed."
	done

PolkaDotBedSentText:
	text "PolkaDot Bed"
	line "was sent home."
	done

BoughtPikachuBedText:
	text "<PLAYER> bought"
	line "Pikachu Bed."
	done

PikachuBedSentText:
	text "Pikachu Bed"
	line "was sent home."
	done

CeladonHomeDecorStore2FNoMoneyText:
	text "You can't afford"
	line "that!"
	done

CeladonHomeDecorStore2FAlreadyBoughtText:
	text "You already have"
	line "that!"
	done

CeladonHomeDecorStore2FPokefanfText:
	text "Brand-name items"
	line "cost more than"
	cont "generic ones."

	para "But the Pikachu"
	line "Bed is so cute…"
	done

CeladonHomeDecorStore2FDirectoryText:
	text "Soft and Fluffy!"

	para "2F: Beds"
	done
