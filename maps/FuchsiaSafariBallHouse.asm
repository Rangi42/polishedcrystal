FuchsiaSafariBallHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 11
	warp_event  3,  7, FUCHSIA_CITY, 11

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, FuchsiaSafariBallHouseOfficerScript, -1

FuchsiaSafariBallHouseOfficerScript:
	faceplayer
	opentext
	writetext .IntroText
	special PlaceMoneyTopRight
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .Buy1
	ifequalfwd $2, .Buy10
	jumpthisopenedtext ; cancel

	text "What will I do"
	line "with them all?"
	done

.Buy1:
	checkmoney $0, 2000
	ifequalfwd $2, .NotEnoughMoney
	giveitem SAFARI_BALL
	iffalse_jumpopenedtext .BagFullText
	takemoney $0, 2000
	sjumpfwd .Done

.Buy10:
	checkmoney $0, 20000
	ifequalfwd $2, .NotEnoughMoney
	giveitem SAFARI_BALL, 10
	iffalse_jumpopenedtext .BagFullText
	takemoney $0, 20000

.Done:
	special PlaceMoneyTopRight
	waitsfx
	playsound SFX_TRANSACTION
	writetext .GoodbyeText
	promptbutton
	itemnotify
	endtext

.NotEnoughMoney:
	jumpthisopenedtext

	text "You don't have"
	line "enough money."
	done

.IntroText:
	text "I used to manage"
	line "the Safari Game."

	para "Now that it's"
	line "closed I need to"

	para "make money an-"
	line "other way."

	para "Want to buy some"
	line "leftover Safari"
	cont "Balls?"

	para "They're a collec-"
	line "tor's item!"
	done

.GoodbyeText:
	text "Thanks, pal!"
	done

.BagFullText:
	text "You can't carry"
	line "them!"
	done

.MenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 14, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "× 1   ¥2000@"
	db "×10  ¥20000@"
	db "Cancel@"
