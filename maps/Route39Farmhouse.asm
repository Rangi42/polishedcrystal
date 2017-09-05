Route39Farmhouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route39Farmhouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 2, ROUTE_39
	warp_def 7, 3, 2, ROUTE_39

.XYTriggers: db 0

.Signposts: db 2
	signpost 1, 6, SIGNPOST_JUMPSTD, picturebookshelf
	signpost 1, 7, SIGNPOST_JUMPSTD, picturebookshelf

.PersonEvents: db 2
	person_event SPRITE_POKEFAN_M, 2, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x9ceb4, -1
	person_event SPRITE_POKEFAN_F, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, PokefanFScript_0x9cf0e, -1

PokefanMScript_0x9ceb4:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue UnknownScript_0x9cec5
	writetext UnknownText_0x9cf38
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	end

UnknownScript_0x9cec5:
	checkflag ENGINE_BOUGHT_MOOMOO_MILK
	iftrue UnknownScript_0x9cf08
	writetext UnknownText_0x9cfe1
	special PlaceMoneyTopRight
	loadmenudata .MenuDataHeader
	verticalmenu
	closewindow
	if_equal $1, .Buy1
	if_equal $2, .Buy12
	jump .Cancel

.Buy1:
	checkmoney $0, 500
	if_equal $2, .NotEnoughMoney
	giveitem MOOMOO_MILK
	iffalse .BagFull
	takemoney $0, 500
	jump .Done

.Buy12:
	checkmoney $0, 6000
	if_equal $2, .NotEnoughMoney
	giveitem MOOMOO_MILK, 12
	iffalse .BagFull
	takemoney $0, 6000

.Done:
	setflag ENGINE_BOUGHT_MOOMOO_MILK
	special PlaceMoneyTopRight
	waitsfx
	playsound SFX_TRANSACTION
	writetext UnknownText_0x9d05d
	buttonsound
	itemnotify
	endtext

.Cancel:
	jumpopenedtext UnknownText_0x9d0b7

.NotEnoughMoney:
	jumpopenedtext UnknownText_0x9d07c

.BagFull:
	jumpopenedtext UnknownText_0x9d09d

.MenuDataHeader:
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 14 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "× 1    ¥500@"
	db "×12   ¥6000@"
	db "Cancel@"

UnknownScript_0x9cf08:
	jumpopenedtext UnknownText_0x9d0dc

PokefanFScript_0x9cf0e:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM62_ACROBATICS_FROM_MOOMOO_FARM
	iftrue UnknownScript_0x9cf2f
	checkevent EVENT_HEALED_MOOMOO
	iftrue UnknownScript_0x9cf22
	jumpopenedtext UnknownText_0x9d0f6

UnknownScript_0x9cf22:
	writetext UnknownText_0x9d156
	buttonsound
	verbosegivetmhm TM_ACROBATICS
	setevent EVENT_GOT_TM62_ACROBATICS_FROM_MOOMOO_FARM
UnknownScript_0x9cf2f:
	jumpopenedtext UnknownText_0x9d1c7

UnknownText_0x9cf38:
	text "My Miltank ain't"
	line "givin' me milk"
	cont "n'more."

	para "This here Farm's"
	line "got famous milk."

	para "Most everyone"
	line "wants a drink."

	para "It'll give me lots"
	line "o' milk if'n I"

	para "feed it lots o'"
	line "Berries, I reckon."
	done

UnknownText_0x9cfe1:
	text "How'd you like my"
	line "Moomoo Milk?"

	para "It's my pride and"
	line "joy, there."

	para "Give it to #mon"
	line "to restore HP!"

	para "I'll give it to ya"
	line "fer just ¥500."
	done

UnknownText_0x9d05d:
	text "Here ya go!"
	line "Drink up'n enjoy!"
	done

UnknownText_0x9d07c:
	text "Sorry, there."
	line "No cash, no sale!"
	done

UnknownText_0x9d09d:
	text "I reckon yer"
	line "Bag's full."
	done

UnknownText_0x9d0b7:
	text "You don't want it?"
	line "Come again, hear?"
	done

UnknownText_0x9d0dc:
	text "I best go do my"
	line "milkin'."
	done

UnknownText_0x9d0f6:
	text "Our milk even goes"
	line "out to Kanto."

	para "So if our own"
	line "Miltank won't give"

	para "us any milk, we're"
	line "in trouble."
	done

UnknownText_0x9d156:
	text "You fixed our"
	line "Miltank, hon. Now"

	para "it gives Moomoo"
	line "Milk again."

	para "Here's somethin'"
	line "fer your trouble."
	done

UnknownText_0x9d1c7:
	text "That there's"
	line "Acrobatics."

	para "It's a move that"
	line "hurts more if'n"

	para "your #mon ain't"
	line "holdin' an item."

	para "You best think how"
	line "you ought to use"
	cont "it, hon."
	done
