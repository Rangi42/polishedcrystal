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
	object_event  4,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore1FReceptionistText, -1
	object_event  5,  1, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonHomeDecorStore1FClerkScript, -1
	object_event  7,  5, SPRITE_MON_ICON, SPRITEMOVEDATA_STILL, 0, CUPICO, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, NO_FORM, CeladonHomeDecorStore1FCupicoDollScript, -1
	object_event  8,  5, SPRITE_MON_ICON, SPRITEMOVEDATA_STILL, 0, FLIKLIT, -1, PAL_NPC_ORANGE, OBJECTTYPE_SCRIPT, NO_FORM, CeladonHomeDecorStore1FFliklitDollScript, -1
	object_event  9,  5, SPRITE_MON_ICON, SPRITEMOVEDATA_STILL, 0, GLUTTLE, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, NO_FORM, CeladonHomeDecorStore1FGluttleDollScript, -1
	object_event  0,  4, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore1FCooltrainerfText, -1

CeladonHomeDecorStore1FCupicoDollScript:
	jumpthistext

	text "It's a cute"
	line "Cupico doll!"
	done

CeladonHomeDecorStore1FFliklitDollScript:
	jumpthistext

	text "It's a tough"
	line "Fliklit doll!"
	done

CeladonHomeDecorStore1FGluttleDollScript:
	jumpthistext

	text "It's a cool"
	line "Gluttle doll!"
	done

CeladonHomeDecorStore1FClerkScript:
	faceplayer
	opentext
	writetext CeladonHomeDecorStore1FClerkText
	special PlaceMoneyTopRight
.Start:
	loadmenu .MenuData
	verticalmenu
	closewindow
	ifequalfwd $1, .CupicoDoll
	ifequalfwd $2, .FliklitDoll
	ifequalfwd $3, .GluttleDoll
	endtext

.CupicoDoll:
	checkmoney YOUR_MONEY, 16000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	checkevent EVENT_DECO_CUPICO_DOLL
	iftruefwd .AlreadyBought
	takemoney YOUR_MONEY, 16000
	setevent EVENT_DECO_CUPICO_DOLL
	writetext BoughtCupicoDollText
	playsound SFX_TRANSACTION
	special PlaceMoneyTopRight
	waitbutton
	writetext CupicoDollSentText
	waitbutton
	sjump .Start

.FliklitDoll:
	checkmoney YOUR_MONEY, 16000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	checkevent EVENT_DECO_FLIKLIT_DOLL
	iftruefwd .AlreadyBought
	takemoney YOUR_MONEY, 16000
	setevent EVENT_DECO_FLIKLIT_DOLL
	writetext BoughtFliklitDollText
	playsound SFX_TRANSACTION
	special PlaceMoneyTopRight
	waitbutton
	writetext FliklitDollSentText
	waitbutton
	sjump .Start

.GluttleDoll:
	checkmoney YOUR_MONEY, 16000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	checkevent EVENT_DECO_GLUTTLE_DOLL
	iftruefwd .AlreadyBought
	takemoney YOUR_MONEY, 16000
	setevent EVENT_DECO_GLUTTLE_DOLL
	writetext BoughtGluttleDollText
	playsound SFX_TRANSACTION
	special PlaceMoneyTopRight
	waitbutton
	writetext GluttleDollSentText
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
	db MENU_BACKUP_TILES
	menu_coords 0, 2, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Cupico  ¥16000@"
	db "Fliklit ¥16000@"
	db "Gluttle   ¥16000@"
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

BoughtCupicoDollText:
	text "<PLAYER> bought"
	line "Cupico Doll."
	done

CupicoDollSentText:
	text "Cupico Doll"
	line "was sent home."
	done

BoughtFliklitDollText:
	text "<PLAYER> bought"
	line "Fliklit Doll."
	done

FliklitDollSentText:
	text "Fliklit Doll"
	line "was sent home."
	done

BoughtGluttleDollText:
	text "<PLAYER> bought"
	line "Gluttle Doll."
	done

GluttleDollSentText:
	text "Gluttle Doll"
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
