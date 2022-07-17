GoldenrodHoneyHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 21
	warp_event  3,  7, GOLDENROD_CITY, 21

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodHoneyHousePokefanFScript, -1
	pokemon_event  6,  3, BUTTERFREE, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_BLUE, GoldenrodHoneyHouseButterfreeText, -1

GoldenrodHoneyHousePokefanFScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue_jumptextfaceplayer .AfterText
	checkevent EVENT_GOT_HONEY_FROM_GOLDENROD
	iftruefwd .SellHoney
	faceplayer
	opentext
	writetext .IntroText
	promptbutton
	verbosegiveitem SWEET_HONEY
	iffalse_endtext
	setevent EVENT_GOT_HONEY_FROM_GOLDENROD
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	jumpthisopenedtext

.AfterText:
	text "My little brother"
if DEF(FAITHFUL)
	line "takes Honey and"

	para "spreads it around"
else
	line "takes Sweet Honey"

	para "and spreads it in"
endc
	line "tall grass."

	para "#mon are"
	line "enticed by it."

	para "It tends to draw"
	line "in #mon at the"

	para "same level as"
	line "your own!"
	done

.IntroText:
	text "My #mon is an"
	line "expert at collect-"
if DEF(FAITHFUL)
	cont "ing Honey."
else
	cont "ing Sweet Honey."
endc

	para "I'll share some"
	line "with you."
	done

.SellHoney:
	faceplayer
	opentext
	writetext .SellText
	special PlaceMoneyTopRight
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .Buy1
	ifequalfwd $2, .Buy10
	jumpthisopenedtext ; cancel

	text "Well, come again,"
	line "honey!"
	done

.Buy1:
	checkmoney $0, 1000
	ifequalfwd $2, .NotEnoughMoney
	giveitem SWEET_HONEY
	iffalse_jumpopenedtext .BagFullText
	takemoney $0, 1000
	sjumpfwd .Done

.Buy10:
	checkmoney $0, 10000
	ifequalfwd $2, .NotEnoughMoney
	giveitem SWEET_HONEY, 10
	iffalse_jumpopenedtext .BagFullText
	takemoney $0, 10000

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
	line "enough money,"
	cont "honey!"
	done

.SellText:
	text "Would you like to"
if DEF(FAITHFUL)
	line "buy some Honey"

	para "for attracting"
	line "#mon?"
else
	line "buy some Sweet"

	para "Honey for attract-"
	line "ing #mon?"
endc
	cont "Just ¥1000 each!"
	done

.GoodbyeText:
	text "Here you go,"
	line "honey!"
	done

.BagFullText:
	text "Oopsy! You have"
	line "no room for it."
	done

.MenuDataHeader:
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 14 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "× 1   ¥1000@"
	db "×10  ¥10000@"
	db "Cancel@"

GoldenrodHoneyHouseButterfreeText:
	text "Butterfree: Freeh!"
	done
