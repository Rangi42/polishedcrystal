GoldenrodFlowerShop_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, GOLDENROD_CITY, 6
	warp_event  3,  7, GOLDENROD_CITY, 6

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FlowerShopTeacherScript, -1
	object_event  5,  6, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, FlowerShopFloriaScript, EVENT_FLORIA_AT_FLOWER_SHOP
	object_event  6,  3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, FlowerShopGentlemanText, EVENT_FLORIA_AT_SUDOWOODO

	const_def 1 ; object constants
	const GOLDENRODFLOWERSHOP_TEACHER

FlowerShopTeacherScript:
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .SellMulch
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue_jumptextfaceplayer UnknownText_0x5550d
	checkevent EVENT_MET_FLORIA
	iffalse_jumptextfaceplayer UnknownText_0x553d4
	checkevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	iffalse .Lalala
	checkflag ENGINE_PLAINBADGE
	iffalse_jumptextfaceplayer UnknownText_0x55463
	faceplayer
	opentext
	writetext UnknownText_0x554c2
	buttonsound
	verbosegiveitem SQUIRTBOTTLE
	setevent EVENT_GOT_SQUIRTBOTTLE
	closetext
	setevent EVENT_FLORIA_AT_SUDOWOODO
	clearevent EVENT_FLORIA_AT_FLOWER_SHOP
	end

.Lalala:
	turnobject GOLDENRODFLOWERSHOP_TEACHER, LEFT
	jumptext UnknownText_0x5552e

.SellMulch:
	faceplayer
	opentext
	writetext WoukdYouLikeMulchText
	special PlaceMoneyTopRight
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, .Buy1
	ifequal $2, .Buy10
	jumpopenedtext DontBuyMulchText

.Buy1:
	checkmoney $0, 200
	ifequal $2, .NotEnoughMoney
	giveitem MULCH
	iffalse_jumpopenedtext NoRoomForMulchText
	takemoney $0, 200
	jump .Done

.Buy10:
	checkmoney $0, 2000
	ifequal $2, .NotEnoughMoney
	giveitem MULCH, 10
	iffalse_jumpopenedtext NoRoomForMulchText
	takemoney $0, 2000

.Done:
	special PlaceMoneyTopRight
	waitsfx
	playsound SFX_TRANSACTION
	itemnotify
	jumpopenedtext BoughtMulchText

.NotEnoughMoney:
	jumpopenedtext NotEnoughMulchMoneyText

.MenuDataHeader:
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 14 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "× 1    ¥200@"
	db "×10   ¥2000@"
	db "Cancel@"

FlowerShopFloriaScript:
	faceplayer
	opentext
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .FoughtSudowoodo
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue_jumpopenedtext UnknownText_0x555e6
	writetext UnknownText_0x55561
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	setevent EVENT_FLORIA_AT_FLOWER_SHOP
	clearevent EVENT_FLORIA_AT_SUDOWOODO
	end

.FoughtSudowoodo:
	checkitem MULCH
	iftrue_jumpopenedtext DescribeMulchText
	jumpopenedtext UnknownText_0x55604

UnknownText_0x553d4:
	text "Have you seen that"
	line "wiggly tree that's"

	para "growing on Route"
	line "36?"

	para "My little sister"
	line "got all excited"

	para "and went to see"
	line "it…"

	para "I'm worried… Isn't"
	line "it dangerous?"
	done

UnknownText_0x55463:
	text "Do you want to"
	line "borrow the water"

	para "bottle too?"
	line "I don't want you"

	para "doing anything"
	line "dangerous with it."
	done

UnknownText_0x554c2:
	text "Oh, you're better"
	line "than Whitney…"

	para "You'll be OK,"
	line "then. Here's the"
	cont "SquirtBottle!"
	done

UnknownText_0x5550d:
	text "Don't do anything"
	line "too dangerous!"
	done

UnknownText_0x5552e:
	text "Lalala lalalala."
	line "Have plenty of"
	cont "water, my lovely!"
	done

UnknownText_0x55561:
	text "When I told my sis"
	line "about the jiggly"

	para "tree, she told me"
	line "it's dangerous."

	para "If I beat Whitney,"
	line "I wonder if she'll"

	para "lend me her water"
	line "bottle…"
	done

UnknownText_0x555e6:
	text "Wow, you beat"
	line "Whitney? Cool!"
	done

UnknownText_0x55604:
	text "So it really was a"
	line "#mon!"
	done

WoukdYouLikeMulchText:
	text "Care to buy some"
	line "Mulch?"

	para "It makes Berries"
	line "grow faster!"
	done

BoughtMulchText:
	text "Thank you!"
	line "Please come again!"
	done

DontBuyMulchText:
	text "Please come again!"
	done

NotEnoughMulchMoneyText:
	text "Well… Excuse me,"
	line "but you're short"
	cont "of money."
	done

NoRoomForMulchText:
	text "Oh no, your Bag"
	line "is full!"
	done

DescribeMulchText:
	text "Our Mulch is a"
	line "mix of high-qual-"

	para "ity soil and #-"
	line "mon's… er… you"

	para "know. It's full"
	line "of nutrients!"
	done

FlowerShopGentlemanText:
	text "I've been working"
	line "late a lot recent-"
	cont "ly, so I'm buying"

	para "some flowers for"
	line "my wife."
	done
