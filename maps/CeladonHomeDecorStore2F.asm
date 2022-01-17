CeladonHomeDecorStore2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  9,  0, CELADON_HOME_DECOR_STORE_1F, 3
	warp_event  6,  0, CELADON_HOME_DECOR_STORE_3F, 1

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, CeladonHomeDecorStore2FDirectoryText

	def_object_events
	object_event  9,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonHomeDecorStore2FClerkScript, -1
	object_event  3,  1, SPRITE_MATRON, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore2FPokefanfText, -1

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
	sjump .Start

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
	sjump .Start

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
	sjump .Start

.NotEnoughMoney:
	writetext CeladonHomeDecorStore2FNoMoneyText
	waitbutton
	sjump .Start

.AlreadyBought:
	writetext CeladonHomeDecorStore2FAlreadyBoughtText
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
	db "Pink      ¥62000@"
	db "PolkaDot  ¥94000@"
	db "Pikachu  ¥126000@"
	db "Cancel@"

CeladonHomeDecorStore2FClerkText:
	ctxt "Welcome! Are you"
	line "in the market for"
	cont "a new bed?"
	done

BoughtPinkBedText:
	ctxt "<PLAYER> bought"
	line "Pink Bed."
	done

PinkBedSentText:
	ctxt "Pink Bed"
	line "was sent home."
	done

BoughtPolkaDotBedText:
	ctxt "<PLAYER> bought"
	line "PolkaDot Bed."
	done

PolkaDotBedSentText:
	ctxt "PolkaDot Bed"
	line "was sent home."
	done

BoughtPikachuBedText:
	ctxt "<PLAYER> bought"
	line "Pikachu Bed."
	done

PikachuBedSentText:
	ctxt "Pikachu Bed"
	line "was sent home."
	done

CeladonHomeDecorStore2FNoMoneyText:
	ctxt "You can't afford"
	line "that!"
	done

CeladonHomeDecorStore2FAlreadyBoughtText:
	ctxt "You already have"
	line "that!"
	done

CeladonHomeDecorStore2FPokefanfText:
	ctxt "Brand-name items"
	line "cost more than"
	cont "generic ones."

	para "But the Pikachu"
	line "Bed is so cute…"
	done

CeladonHomeDecorStore2FDirectoryText:
	ctxt "Soft and Fluffy!"

	para "2F: Beds"
	done
