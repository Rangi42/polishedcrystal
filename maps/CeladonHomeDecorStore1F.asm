const_value set 2
	const CELADONHOMEDECORSTORE1F_RECEPTIONIST

CeladonHomeDecorStore1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHomeDecorStore1FVendingMachine:
	opentext
	writetext CeladonHomeDecorStore1FVendingText
.Start:
	special PlaceMoneyTopRight
	loadmenudata .MenuData
	verticalmenu
	closewindow
	if_equal $1, .FreshWater
	if_equal $2, .SodaPop
	if_equal $3, .Lemonade
	closetext
	end

.FreshWater:
	checkmoney $0, 200
	if_equal $2, .NotEnoughMoney
	giveitem FRESH_WATER
	iffalse .NotEnoughSpace
	takemoney $0, 200
	itemtotext FRESH_WATER, $0
	jump .VendItem

.SodaPop:
	checkmoney $0, 300
	if_equal $2, .NotEnoughMoney
	giveitem SODA_POP
	iffalse .NotEnoughSpace
	takemoney $0, 300
	itemtotext SODA_POP, $0
	jump .VendItem

.Lemonade:
	checkmoney $0, 350
	if_equal $2, .NotEnoughMoney
	giveitem LEMONADE
	iffalse .NotEnoughSpace
	takemoney $0, 350
	itemtotext LEMONADE, $0
	jump .VendItem

.VendItem:
	pause 10
	playsound SFX_ENTER_DOOR
	writetext CeladonHomeDecorStore1FClangText
	buttonsound
	itemnotify
	jump .Start

.NotEnoughMoney:
	writetext CeladonHomeDecorStore1FVendingNoMoneyText
	waitbutton
	jump .Start

.NotEnoughSpace:
	writetext CeladonHomeDecorStore1FVendingNoSpaceText
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
	db "Fresh Water  ¥200@"
	db "Soda Pop     ¥300@"
	db "Lemonade     ¥350@"
	db "Cancel@"

CeladonHomeDecorStore1FDirectory:
	jumptext CeladonHomeDecorStore1FDirectoryText

CeladonHomeDecorStore1FVendingText:
	text "A vending machine!"
	line "Here's the menu."
	done

CeladonHomeDecorStore1FClangText:
	text "Clang!"

	para "@"
	text_from_ram StringBuffer3
	text ""
	line "popped out."
	done

CeladonHomeDecorStore1FVendingNoMoneyText:
	text "Oops, not enough"
	line "money…"
	done

CeladonHomeDecorStore1FVendingNoSpaceText:
	text "There's no more"
	line "room for stuff…"
	done

CeladonHomeDecorStore1FDirectoryText:
	text "1F: Lobby"

	para "2F: Beds"

	para "3F: Carpets"

	para "4F: Jumbo Dolls"
	done

CeladonHomeDecorStore1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $3, 12, CELADON_CITY
	warp_def $7, $4, 12, CELADON_CITY
	warp_def $0, $9, 1, CELADON_HOME_DECOR_STORE_2F

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 0, 8, SIGNPOST_READ, CeladonHomeDecorStore1FDirectory
	signpost 1, 0, SIGNPOST_UP, CeladonHomeDecorStore1FVendingMachine
	signpost 1, 1, SIGNPOST_UP, CeladonHomeDecorStore1FVendingMachine

.PersonEvents:
	db 1
	person_event SPRITE_RECEPTIONIST, 1, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
