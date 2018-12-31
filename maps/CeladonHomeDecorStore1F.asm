CeladonHomeDecorStore1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonHomeDecorStore1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 3, 12, CELADON_CITY
	warp_def 7, 4, 12, CELADON_CITY
	warp_def 0, 9, 1, CELADON_HOME_DECOR_STORE_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 8, SIGNPOST_JUMPTEXT, CeladonHomeDecorStore1FDirectoryText

.PersonEvents: db 6
	person_event SPRITE_RECEPTIONIST, 1, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore1FReceptionistText, -1
	person_event SPRITE_CLERK, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHomeDecorStore1FClerkScript, -1
	person_event SPRITE_BULBASAUR, 5, 7, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptext, CeladonHomeDecorStore1FBulbasaurDollText, -1
	person_event SPRITE_CHARMANDER, 5, 8, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptext, CeladonHomeDecorStore1FCharmanderDollText, -1
	person_event SPRITE_SQUIRTLE, 5, 9, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptext, CeladonHomeDecorStore1FSquirtleDollText, -1
	person_event SPRITE_COOLTRAINER_F, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore1FCooltrainerfText, -1

CeladonHomeDecorStore1FClerkScript:
	faceplayer
	opentext
	writetext CeladonHomeDecorStore1FClerkText
.Start:
	special PlaceMoneyTopRight
	loadmenudata .MenuData
	verticalmenu
	closewindow
	if_equal $1, .BulbasaurDoll
	if_equal $2, .CharmanderDoll
	if_equal $3, .SquirtleDoll
	endtext

.BulbasaurDoll:
	checkmoney $0, 16000
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_BULBASAUR_DOLL
	iftrue .AlreadyBought
	takemoney $0, 16000
	setevent EVENT_DECO_BULBASAUR_DOLL
	writetext BoughtBulbasaurDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext BulbasaurDollSentText
	waitbutton
	jump .Start

.CharmanderDoll:
	checkmoney $0, 16000
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_CHARMANDER_DOLL
	iftrue .AlreadyBought
	takemoney $0, 16000
	setevent EVENT_DECO_CHARMANDER_DOLL
	writetext BoughtCharmanderDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext CharmanderDollSentText
	waitbutton
	jump .Start

.SquirtleDoll:
	checkmoney $0, 16000
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_SQUIRTLE_DOLL
	iftrue .AlreadyBought
	takemoney $0, 16000
	setevent EVENT_DECO_SQUIRTLE_DOLL
	writetext BoughtSquirtleDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext SquirtleDollSentText
	waitbutton
	jump .Start

.NotEnoughMoney:
	writetext CeladonHomeDecorStore1FNoMoneyText
	waitbutton
	jump .Start

.AlreadyBought:
	writetext CeladonHomeDecorStore1FAlreadyBoughtText
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
	db "Bulbasaur  ¥16000@"
	db "Charmander ¥16000@"
	db "Squirtle   ¥16000@"
	db "Cancel@"

CeladonHomeDecorStore1FReceptionistText:
	text "Hello! Welcome to"
	line "Celadon Dept."
	cont "Store Home Decor!"

	para "The directory is"
	line "on the wall."
	done

CeladonHomeDecorStore1FClerkText:
	text "Welcome! Would you"
	line "like a doll as a"
	cont "Celadon souvenir?"
	done

BoughtBulbasaurDollText:
	text "<PLAYER> bought"
	line "Bulbasaur Doll."
	done

BulbasaurDollSentText:
	text "Bulbasaur Doll"
	line "was sent home."
	done

BoughtCharmanderDollText:
	text "<PLAYER> bought"
	line "Charmander Doll."
	done

CharmanderDollSentText:
	text "Charmander Doll"
	line "was sent home."
	done

BoughtSquirtleDollText:
	text "<PLAYER> bought"
	line "Squirtle Doll."
	done

SquirtleDollSentText:
	text "Squirtle Doll"
	line "was sent home."
	done

CeladonHomeDecorStore1FNoMoneyText:
	text "You can't afford"
	line "that!"
	done

CeladonHomeDecorStore1FAlreadyBoughtText:
	text "You already have"
	line "that!"
	done

CeladonHomeDecorStore1FBulbasaurDollText:
	text "It's a cute"
	line "Bulbasaur doll!"
	done

CeladonHomeDecorStore1FCharmanderDollText:
	text "It's a tough"
	line "Charmander doll!"
	done

CeladonHomeDecorStore1FSquirtleDollText:
	text "It's a cool"
	line "Squirtle doll!"
	done

CeladonHomeDecorStore1FCooltrainerfText:
	text "This new wing"
	line "feels more upscale"

	para "than the main"
	line "Dept.Store."
	done

CeladonHomeDecorStore1FDirectoryText:
	text "1F: Lobby"

	para "2F: Beds"

	para "3F: Carpets"

	para "4F: Jumbo Dolls"
	done
