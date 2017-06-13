const_value set 2
	const CELADONDEPTSTORE4F_CLERK1
	const CELADONDEPTSTORE4F_SUPER_NERD
	const CELADONDEPTSTORE4F_YOUNGSTER
	const CELADONDEPTSTORE4F_CLERK2

CeladonDeptStore4F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ClerkScript_0x70f0d:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_CELADON_4F
	closetext
	end

PosterClerkScript:
	faceplayer
	opentext
	writetext PosterClerkText
.Start:
	special PlaceMoneyTopRight
	loadmenudata .MenuData
	verticalmenu
	closewindow
	if_equal $1, .MarillPoster
	if_equal $2, .ClefairyPoster
	if_equal $3, .PikachuPoster
	closetext
	end

.MarillPoster:
	checkmoney $0, 3200
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_POSTER_3
	iftrue .AlreadyBought
	takemoney $0, 3200
	setevent EVENT_DECO_POSTER_3
	writetext BoughtMarillPosterText
	playsound SFX_TRANSACTION
	waitbutton
	writetext MarillPosterSentText
	waitbutton
	jump .Start

.ClefairyPoster:
	checkmoney $0, 4800
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_POSTER_2
	iftrue .AlreadyBought
	takemoney $0, 4800
	setevent EVENT_DECO_POSTER_2
	writetext BoughtClefairyPosterText
	playsound SFX_TRANSACTION
	waitbutton
	writetext ClefairyPosterSentText
	waitbutton
	jump .Start

.PikachuPoster:
	checkmoney $0, 6400
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_POSTER_1
	iftrue .AlreadyBought
	takemoney $0, 6400
	setevent EVENT_DECO_POSTER_1
	writetext BoughtPikachuPosterText
	playsound SFX_TRANSACTION
	waitbutton
	writetext PikachuPosterSentText
	waitbutton
	jump .Start

.NotEnoughMoney:
	writetext PosterClerkNoMoneyText
	waitbutton
	jump .Start

.AlreadyBought:
	writetext PosterClerkAlreadyBoughtText
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
	db "Marill      ¥3200@"
	db "Clefairy    ¥4800@"
	db "Pikachu     ¥6400@"
	db "Cancel@"

SuperNerdScript_0x70f15:
	jumptextfaceplayer UnknownText_0x70f21

YoungsterScript_0x70f18:
	jumptextfaceplayer UnknownText_0x70f55

CeladonDeptStore4FDirectory:
	jumptext CeladonDeptStore4FDirectoryText

CeladonDeptStore4FElevatorButton:
	jumpstd elevatorbutton

PosterClerkText:
	text "Welcome! Would you"
	line "like a poster?"
	done

PosterClerkNoMoneyText:
	text "You don't have"
	line "enough money."
	done

PosterClerkAlreadyBoughtText:
	text "You bought that"
	line "already."
	done

BoughtMarillPosterText:
	text "<PLAYER> bought"
	line "Marill Poster."
	done

MarillPosterSentText:
	text "Marill Poster"
	line "was sent home."
	done

BoughtClefairyPosterText:
	text "<PLAYER> bought"
	line "Clefairy Poster."
	done

ClefairyPosterSentText:
	text "Clefairy Poster"
	line "was sent home."
	done

BoughtPikachuPosterText:
	text "<PLAYER> bought"
	line "Pikachu Poster."
	done

PikachuPosterSentText:
	text "Pikachu Poster"
	line "was sent home."
	done

UnknownText_0x70f21:
	text "I'm here to buy"
	line "Lovely Mail for"
	cont "my girlfriend."
	done

UnknownText_0x70f55:
	text "This is the only"
	line "place where you"

	para "can buy posters."
	line "I collect them!"
	done

CeladonDeptStore4FDirectoryText:
	text "Express Yourself"
	line "With Gifts!"

	para "4F: Wiseman Gifts"
	done

CeladonDeptStore4F_MapEventHeader:
.Warps:
	db 3
	warp_def $0, $c, 1, CELADON_DEPT_STORE_5F
	warp_def $0, $f, 2, CELADON_DEPT_STORE_3F
	warp_def $0, $2, 1, CELADON_DEPT_STORE_ELEVATOR

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 0, 14, SIGNPOST_READ, CeladonDeptStore4FDirectory
	signpost 0, 3, SIGNPOST_READ, CeladonDeptStore4FElevatorButton

.PersonEvents:
	db 4
	person_event SPRITE_CLERK, 5, 13, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ClerkScript_0x70f0d, -1
	person_event SPRITE_SUPER_NERD, 6, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x70f15, -1
	person_event SPRITE_YOUNGSTER, 2, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x70f18, -1
	person_event SPRITE_CLERK, 5, 15, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, PosterClerkScript, -1
