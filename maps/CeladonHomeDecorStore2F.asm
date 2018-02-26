CeladonHomeDecorStore2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  9,  0, CELADON_HOME_DECOR_STORE_1F, 3
	warp_event  6,  0, CELADON_HOME_DECOR_STORE_3F, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event  8,  0, SIGNPOST_JUMPTEXT, CeladonHomeDecorStore2FDirectoryText

	db 2 ; object events
	object_event  9,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHomeDecorStore2FClerkScript, -1
	object_event  3,  1, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore2FPokefanfText, -1

CeladonHomeDecorStore2FClerkScript:
	faceplayer
	opentext
	writetext CeladonHomeDecorStore2FClerkText
.Start:
	special PlaceMoneyTopRight
	loadmenu .MenuData
	verticalmenu
	closewindow
	ifequal $1, .PinkBed
	ifequal $2, .PolkaDotBed
	ifequal $3, .PikachuBed
	endtext

.PinkBed:
	checkmoney $0, 62000
	ifequal $2, .NotEnoughMoney
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
	ifequal $2, .NotEnoughMoney
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
	ifequal $2, .NotEnoughMoney
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
