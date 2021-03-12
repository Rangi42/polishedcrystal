CeladonHomeDecorStore1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, CELADON_CITY, 12
	warp_event  4,  7, CELADON_CITY, 12
	warp_event  9,  0, CELADON_HOME_DECOR_STORE_2F, 1

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, CeladonHomeDecorStore1FDirectoryText

	def_object_events
	object_event  4,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore1FReceptionistText, -1
	object_event  5,  1, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonHomeDecorStore1FClerkScript, -1
	object_event  7,  5, SPRITE_MON_ICON, SPRITEMOVEDATA_STILL, 0, BULBASAUR, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptext, CeladonHomeDecorStore1FBulbasaurDollText, -1
	object_event  8,  5, SPRITE_MON_ICON, SPRITEMOVEDATA_STILL, 0, CHARMANDER, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptext, CeladonHomeDecorStore1FCharmanderDollText, -1
	object_event  9,  5, SPRITE_MON_ICON, SPRITEMOVEDATA_STILL, 0, SQUIRTLE, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptext, CeladonHomeDecorStore1FSquirtleDollText, -1
	object_event  0,  4, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore1FCooltrainerfText, -1

CeladonHomeDecorStore1FClerkScript:
	faceplayer
	opentext
	writetext CeladonHomeDecorStore1FClerkText
.Start:
	special PlaceMoneyTopRight
	loadmenu .MenuData
	verticalmenu
	closewindow
	ifequal $1, .BulbasaurDoll
	ifequal $2, .CharmanderDoll
	ifequal $3, .SquirtleDoll
	endtext

.BulbasaurDoll:
	checkmoney $0, 16000
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_BULBASAUR_DOLL
	iftrue .AlreadyBought
	takemoney $0, 16000
	setevent EVENT_DECO_BULBASAUR_DOLL
	writetext BoughtBulbasaurDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext BulbasaurDollSentText
	waitbutton
	sjump .Start

.CharmanderDoll:
	checkmoney $0, 16000
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_CHARMANDER_DOLL
	iftrue .AlreadyBought
	takemoney $0, 16000
	setevent EVENT_DECO_CHARMANDER_DOLL
	writetext BoughtCharmanderDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext CharmanderDollSentText
	waitbutton
	sjump .Start

.SquirtleDoll:
	checkmoney $0, 16000
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_SQUIRTLE_DOLL
	iftrue .AlreadyBought
	takemoney $0, 16000
	setevent EVENT_DECO_SQUIRTLE_DOLL
	writetext BoughtSquirtleDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext SquirtleDollSentText
	waitbutton
	sjump .Start

.NotEnoughMoney:
	writetext CeladonHomeDecorStore1FNoMoneyText
	waitbutton
	sjump .Start

.AlreadyBought:
	writetext CeladonHomeDecorStore1FAlreadyBoughtText
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
