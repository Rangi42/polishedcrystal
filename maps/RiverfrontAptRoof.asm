RiverfrontAptRoof_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13,  1, RIVERFRONT_APT_5F, 2
	warp_event  8,  0, RIVERFRONT_APT_ELEVATOR, 1

	def_coord_events

	def_bg_events
	; bg_event  1,  1, BGEVENT_UP, PokeDollVendingMachine

	def_object_events
	object_event 11,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, RiverfrontAptRoofPokefanFText, -1
	object_event  6,  5, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, RiverfrontAptRoofGrampsText, -1
	object_event  7,  5, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, RiverfrontAptRoofGrannyText, -1
	pokemon_event  5,  5, ALAKAZAM, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_BROWN, RiverfrontAptRoofAlakazamText, -1



; PokeDollVendingMachine:
; 	opentext
; 	writetext PokeDollVendingMachineText
; 	special PlaceMoneyTopRight
; .Start:
; 	loadmenu .MenuData
; 	verticalmenu
; 	closewindow
; 	ifequalfwd $1, .JigglypuffDoll
; 	ifequalfwd $2, .DittoDoll
; 	ifequalfwd $3, .MeowthDoll
; 	endtext

; .JigglypuffDoll:
; 	checkmoney YOUR_MONEY, 2400
; 	ifequalfwd HAVE_LESS, .NotEnoughMoney
; 	checkevent EVENT_DECO_JIGGLYPUFF_DOLL
; 	iftruefwd .AlreadyBought
; 	takemoney YOUR_MONEY, 2400
; 	setevent EVENT_DECO_JIGGLYPUFF_DOLL
; 	writetext BoughtJigglypuffDollText
; 	playsound SFX_TRANSACTION
; 	special PlaceMoneyTopRight
; 	waitbutton
; 	writetext JigglypuffDollSentText
; 	waitbutton
; 	sjump .Start

; .DittoDoll:
; 	checkmoney YOUR_MONEY, 2400
; 	ifequalfwd HAVE_LESS, .NotEnoughMoney
; 	checkevent EVENT_DECO_DITTO_DOLL
; 	iftruefwd .AlreadyBought
; 	takemoney YOUR_MONEY, 2400
; 	setevent EVENT_DECO_DITTO_DOLL
; 	writetext BoughtDittoDollText
; 	playsound SFX_TRANSACTION
; 	special PlaceMoneyTopRight
; 	waitbutton
; 	writetext DittoDollSentText
; 	waitbutton
; 	sjump .Start

; .MeowthDoll:
; 	checkmoney YOUR_MONEY, 2400
; 	ifequalfwd HAVE_LESS, .NotEnoughMoney
; 	checkevent EVENT_DECO_MEOWTH_DOLL
; 	iftruefwd .AlreadyBought
; 	takemoney YOUR_MONEY, 2400
; 	setevent EVENT_DECO_MEOWTH_DOLL
; 	writetext BoughtMeowthDollText
; 	playsound SFX_TRANSACTION
; 	special PlaceMoneyTopRight
; 	waitbutton
; 	writetext MeowthDollSentText
; 	waitbutton
; 	sjump .Start

; .NotEnoughMoney:
; 	writetext PokeDollVendingMachineNoMoneyText
; 	waitbutton
; 	sjump .Start

; .AlreadyBought:
; 	writetext PokeDollVendingMachineAlreadyBoughtText
; 	waitbutton
; 	sjump .Start

; .MenuData:
; 	db MENU_BACKUP_TILES
; 	menu_coords 0, 2, 19, 11
; 	dw .MenuData2
; 	db 1 ; default option

; .MenuData2:
; 	db $80 ; flags
; 	db 4 ; items
; 	db "Jigglypuff  ¥2400@"
; 	db "Ditto       ¥2400@"
; 	db "Meowth      ¥2400@"
; 	db "Cancel@"

RiverfrontAptRoofPokefanFText:
	text "I sometimes come"
	line "up to the rooftop"

	para "to take a break"
	line "from everything."
	done

RiverfrontAptRoofGrannyText:
	text "I don't know"
	line "where we would"

	para "be without"
	line "#mon."
	done

RiverfrontAptRoofGrampsText:
	text "Sometimes I"
	line "forget what's"

	para "going on,"
	line "but Alakazam"

	para "helps me"
	line "to remember."
	done

RiverfrontAptRoofAlakazamText:
	text "Psshhakzm"
	done

; PokeDollVendingMachineText:
; 	text "A vending machine"
; 	line "for #mon dolls!"
; 	done

; PokeDollVendingMachineNoMoneyText:
; 	text "It costs too much!"
; 	done

; PokeDollVendingMachineAlreadyBoughtText:
; 	text "It's a duplicate!"
; 	done

; BoughtJigglypuffDollText:
; 	text "<PLAYER> bought"
; 	line "Jigglypuff Doll."
; 	done

; JigglypuffDollSentText:
; 	text "Jigglypuff Doll"
; 	line "was sent home."
; 	done

; BoughtDittoDollText:
; 	text "<PLAYER> bought"
; 	line "Ditto Doll."
; 	done

; DittoDollSentText:
; 	text "Ditto Doll"
; 	line "was sent home."
; 	done

; BoughtMeowthDollText:
; 	text "<PLAYER> bought"
; 	line "Meowth Doll."
; 	done

; MeowthDollSentText:
; 	text "Meowth Doll"
; 	line "was sent home."
; 	done
