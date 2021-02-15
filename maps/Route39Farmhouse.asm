Route39Farmhouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_39, 2
	warp_event  3,  7, ROUTE_39, 2

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_JUMPSTD, picturebookshelf
	bg_event  7,  1, BGEVENT_JUMPSTD, picturebookshelf

	def_object_events
	object_event  3,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PokefanM_DairyFarmer, -1
	object_event  5,  4, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, PokefanF_AcrobaticsFarmer, -1

PokefanM_DairyFarmer:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue FarmerMScript_SellMilk
	writetext FarmerMText_SickCow
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	end

FarmerMScript_SellMilk:
	checkflag ENGINE_BOUGHT_MOOMOO_MILK
	iftrue .Milking
	writetext FarmerMText_BuyMilk
	special PlaceMoneyTopRight
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, .Buy1
	ifequal $2, .Buy12
	jump .Cancel

.Buy1:
	checkmoney $0, 500
	ifequal $2, .NotEnoughMoney
	giveitem MOOMOO_MILK
	iffalse .BagFull
	takemoney $0, 500
	jump .Done

.Buy12:
	checkmoney $0, 6000
	ifequal $2, .NotEnoughMoney
	giveitem MOOMOO_MILK, 12
	iffalse .BagFull
	takemoney $0, 6000

.Done:
	setflag ENGINE_BOUGHT_MOOMOO_MILK
	special PlaceMoneyTopRight
	waitsfx
	playsound SFX_TRANSACTION
	writetext FarmerMText_GotMilk
	buttonsound
	itemnotify
	endtext

.Cancel:
	jumpopenedtext FarmerMText_NoSale

.NotEnoughMoney:
	jumpopenedtext FarmerMText_NoMoney

.BagFull:
	jumpopenedtext FarmerMText_NoRoom

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

.Milking:
	jumpopenedtext FarmerMText_Milking

PokefanF_AcrobaticsFarmer:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM62_ACROBATICS_FROM_MOOMOO_FARM
	iftrue .GotAcrobatics
	checkevent EVENT_HEALED_MOOMOO
	iftrue .GiveAcrobatics
	jumpopenedtext FarmerFText_InTrouble

.GiveAcrobatics:
	writetext FarmerFText_HealedMiltank
	buttonsound
	verbosegivetmhm TM_ACROBATICS
	setevent EVENT_GOT_TM62_ACROBATICS_FROM_MOOMOO_FARM
.GotAcrobatics:
	jumpopenedtext FarmerFText_AcrobaticsSpeech

FarmerMText_SickCow:
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

FarmerMText_BuyMilk:
	text "How'd you like my"
	line "Moomoo Milk?"

	para "It's my pride and"
	line "joy, there."

	para "Give it to #mon"
	line "to restore HP!"

	para "I'll give it to ya"
	line "fer just ¥500."
	done

FarmerMText_GotMilk:
	text "Here ya go!"
	line "Drink up'n enjoy!"
	done

FarmerMText_NoMoney:
	text "Sorry, there."
	line "No cash, no sale!"
	done

FarmerMText_NoRoom:
	text "I reckon yer"
	line "Bag's full."
	done

FarmerMText_NoSale:
	text "You don't want it?"
	line "Come again, hear?"
	done

FarmerMText_Milking:
	text "I best go do my"
	line "milkin'."
	done

FarmerFText_InTrouble:
	text "Our milk even goes"
	line "out to Kanto."

	para "So if our own"
	line "Miltank won't give"

	para "us any milk, we're"
	line "in trouble."
	done

FarmerFText_HealedMiltank:
	text "You fixed our"
	line "Miltank, hon. Now"

	para "it gives Moomoo"
	line "Milk again."

	para "Here's somethin'"
	line "fer your trouble."
	done

FarmerFText_AcrobaticsSpeech:
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
