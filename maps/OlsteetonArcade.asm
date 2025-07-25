DEF OlsteetonArcade_TM35_COINS EQU 4000
DEF OlsteetonArcade_TM24_COINS EQU 4000
DEF OlsteetonArcade_TM13_COINS EQU 4000
DEF OlsteetonArcade_ABRA_COINS     EQU 200
DEF OlsteetonArcade_CUBONE_COINS   EQU 800
DEF OlsteetonArcade_CLEFAIRY_COINS EQU 1500

OlsteetonArcade_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 13, OLSTEETON, 14
	warp_event  5, 13, OLSTEETON, 14

	def_coord_events

	def_bg_events
	bg_event  1, 11, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event  1,  8, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event  9,  7, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event 10, 13, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event 10, 12, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event  9,  9, BGEVENT_RIGHT, OlsteetonArcadeSlotsMachineScript
	bg_event  1, 10, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event  1,  7, BGEVENT_READ, OlsteetonArcadeLuckySlotsMachineScript
	bg_event  1,  9, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event  8,  9, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event 10, 11, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event  8,  7, BGEVENT_LEFT, OlsteetonArcadeSlotsMachineScript
	bg_event 16,  3, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event 16,  4, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event  1,  6, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event 14, 11, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event 18, 11, BGEVENT_READ, OlsteetonArcadeSlotsMachineScript
	bg_event  9,  8, BGEVENT_RIGHT, OlsteetonArcadeSlotsMachineScript
	bg_event 19,  9, BGEVENT_READ, OlsteetonArcadeCardFlipMachineScript
	bg_event 11, 13, BGEVENT_READ, OlsteetonArcadeCardFlipMachineScript
	bg_event 15, 13, BGEVENT_READ, OlsteetonArcadeCardFlipMachineScript
	bg_event 15, 12, BGEVENT_READ, OlsteetonArcadeCardFlipMachineScript
	bg_event 15, 11, BGEVENT_READ, OlsteetonArcadeCardFlipMachineScript
	bg_event 11, 11, BGEVENT_LEFT, OlsteetonArcadeCardFlipMachineScript
	bg_event 17,  5, BGEVENT_READ, OlsteetonArcadeCardFlipMachineScript
	bg_event 14, 13, BGEVENT_READ, OlsteetonArcadeCardFlipMachineScript
	bg_event 17,  4, BGEVENT_READ, OlsteetonArcadeCardFlipMachineScript
	bg_event 17,  3, BGEVENT_READ, OlsteetonArcadeCardFlipMachineScript
	bg_event 18, 12, BGEVENT_READ, OlsteetonArcadeCardFlipMachineScript
	bg_event 14, 12, BGEVENT_RIGHT, OlsteetonArcadeCardFlipMachineScript
	bg_event 12,  1, BGEVENT_LEFT, OlsteetonArcadeLeftTheirDrinkScript

	def_object_events
	object_event  6,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumpstd, gamecornercoinvendor, -1
	object_event  3,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlsteetonArcadeTMVendorScript, -1
	object_event  2,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlsteetonArcadePrizeMonVendorScript, -1
	object_event 16,  1, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OlsteetonArcadeFisherScript, -1
	object_event 11,  3, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WANDER, 1, 2, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonArcadeCooltrainerFText, -1
	object_event 15,  5, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonArcadePokefanFScript, -1
	object_event 19,  3, SPRITE_BURGLAR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, (1 << DAY) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, OlsteetonArcadePharmacistScript, -1
	object_event 12, 12, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonArcadeCooltrainerMScript, -1
	object_event 17, 13, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonArcadeGentlemanScript, -1
	object_event  7,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, OlsteetonArcadePokefanM1Script, -1
	object_event 15,  7, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonArcadePokefanM3Script, -1
	object_event  1,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonArcadePokefanM2Text, EVENT_BEAT_WHITNEY

OlsteetonArcadePokefanM3Script:
	showtextfaceplayer OlsteetonArcadePokefanM3Text
	turnobject LAST_TALKED, RIGHT
	end

OlsteetonArcadeFisherScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_PAY_DAY_INTRO
	iftruefwd OlsteetonArcadeTutorPayDayScript
	writetext OlsteetonArcadeFisherText
	waitbutton
	setevent EVENT_LISTENED_TO_PAY_DAY_INTRO
OlsteetonArcadeTutorPayDayScript:
	writetext Text_OlsteetonArcadeTutorPayDayQuestion
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	yesorno
	iffalsefwd .TutorRefused
	setval PAY_DAY
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_OlsteetonArcadeTutorRefused

.NoSilverLeaf
	waitbutton
	jumpopenedtext Text_OlsteetonArcadeTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_OlsteetonArcadeTutorTaught

OlsteetonArcadeTMVendorScript:
	faceplayer
	opentext
	writetext OlsteetonArcadePrizeVendorIntroText
	waitbutton
	checkkeyitem COIN_CASE
	iffalse_jumpopenedtext OlsteetonArcadePrizeVendorNoCoinCaseText
	writetext OlsteetonArcadePrizeVendorWhichPrizeText
OlsteetonArcadeTMVendor_LoopScript: ; 056c36
	special Special_DisplayCoinCaseBalance
	loadmenu OlsteetonArcadeTMVendorMenuData
	verticalmenu
	closewindow
	ifequalfwd $1, .flamethrower
	ifequalfwd $2, .thunderbolt
	ifequalfwd $3, .ice_beam
	jumpopenedtext OlsteetonArcadePrizeVendorQuitText

.flamethrower:
	checktmhm TM_FLAMETHROWER
	iftruefwd OlsteetonArcadePrizeVendor_AlreadyHaveTMScript
	checkcoins OlsteetonArcade_TM35_COINS
	ifequalfwd HAVE_LESS, OlsteetonArcadePrizeVendor_NotEnoughCoinsScript
	gettmhmname TM_FLAMETHROWER, STRING_BUFFER_3
	scall OlsteetonArcadePrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext OlsteetonArcadePrizeVendorQuitText
	givetmhm TM_FLAMETHROWER
	takecoins OlsteetonArcade_TM35_COINS
	sjumpfwd OlsteetonArcadeTMVendor_FinishScript

.thunderbolt:
	checktmhm TM_THUNDERBOLT
	iftruefwd OlsteetonArcadePrizeVendor_AlreadyHaveTMScript
	checkcoins OlsteetonArcade_TM24_COINS
	ifequalfwd HAVE_LESS, OlsteetonArcadePrizeVendor_NotEnoughCoinsScript
	gettmhmname TM_THUNDERBOLT, STRING_BUFFER_3
	scall OlsteetonArcadePrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext OlsteetonArcadePrizeVendorQuitText
	givetmhm TM_THUNDERBOLT
	takecoins OlsteetonArcade_TM24_COINS
	sjumpfwd OlsteetonArcadeTMVendor_FinishScript

.ice_beam:
	checktmhm TM_ICE_BEAM
	iftruefwd OlsteetonArcadePrizeVendor_AlreadyHaveTMScript
	checkcoins OlsteetonArcade_TM13_COINS
	ifequalfwd HAVE_LESS, OlsteetonArcadePrizeVendor_NotEnoughCoinsScript
	gettmhmname TM_ICE_BEAM, STRING_BUFFER_3
	scall OlsteetonArcadePrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext OlsteetonArcadePrizeVendorQuitText
	givetmhm TM_ICE_BEAM
	takecoins OlsteetonArcade_TM13_COINS
	sjumpfwd OlsteetonArcadeTMVendor_FinishScript

OlsteetonArcadePrizeVendor_ConfirmPurchaseScript:
	writetext OlsteetonArcadePrizeVendorConfirmPrizeText
	yesorno
	end

OlsteetonArcadeTMVendor_FinishScript:
	waitsfx
	playsound SFX_TRANSACTION
	writetext OlsteetonArcadePrizeVendorHereYouGoText
	waitbutton
	sjump OlsteetonArcadeTMVendor_LoopScript

OlsteetonArcadePrizeVendor_AlreadyHaveTMScript:
	writetext OlsteetonArcadePrizeVendorAlreadyHaveTMText
	waitbutton
	sjump OlsteetonArcadeTMVendor_LoopScript

OlsteetonArcadePrizeVendor_NotEnoughCoinsScript:
	jumpopenedtext OlsteetonArcadePrizeVendorNeedMoreCoinsText

OlsteetonArcadeTMVendorMenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 2, 15, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "TM35    {d:OlsteetonArcade_TM35_COINS}@"
	db "TM24    {d:OlsteetonArcade_TM24_COINS}@"
	db "TM13    {d:OlsteetonArcade_TM13_COINS}@"
	db "Cancel@"

OlsteetonArcadePrizeMonVendorScript:
	faceplayer
	opentext
	writetext OlsteetonArcadePrizeVendorIntroText
	waitbutton
	checkkeyitem COIN_CASE
	iffalse_jumpopenedtext OlsteetonArcadePrizeVendorNoCoinCaseText
.loop
	writetext OlsteetonArcadePrizeVendorWhichPrizeText
	special Special_DisplayCoinCaseBalance
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .abra
	ifequalfwd $2, .cubone
	ifequalfwd $3, .clefairy
	jumpopenedtext OlsteetonArcadePrizeVendorQuitText

.abra
	checkcoins OlsteetonArcade_ABRA_COINS
	ifequal HAVE_LESS, OlsteetonArcadePrizeVendor_NotEnoughCoinsScript
	getmonname ABRA, STRING_BUFFER_3
	scall OlsteetonArcadePrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext OlsteetonArcadePrizeVendorQuitText
	waitsfx
	playsound SFX_TRANSACTION
	writetext OlsteetonArcadePrizeVendorHereYouGoText
	waitbutton
	givepoke ABRA, 5
	iffalse_jumpopenedtext OlsteetonArcadePrizeVendorNoMoreRoomText
	setmonval ABRA
	special Special_GameCornerPrizeMonCheckDex
	takecoins OlsteetonArcade_ABRA_COINS
	sjump .loop

.cubone
	checkcoins OlsteetonArcade_CUBONE_COINS
	ifequal HAVE_LESS, OlsteetonArcadePrizeVendor_NotEnoughCoinsScript
	getmonname CUBONE, STRING_BUFFER_3
	scall OlsteetonArcadePrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext OlsteetonArcadePrizeVendorQuitText
	waitsfx
	playsound SFX_TRANSACTION
	writetext OlsteetonArcadePrizeVendorHereYouGoText
	waitbutton
	givepoke CUBONE, 10
	iffalse_jumpopenedtext OlsteetonArcadePrizeVendorNoMoreRoomText
	setmonval CUBONE
	special Special_GameCornerPrizeMonCheckDex
	takecoins OlsteetonArcade_CUBONE_COINS
	sjump .loop

.clefairy
	checkcoins OlsteetonArcade_CLEFAIRY_COINS
	ifequal HAVE_LESS, OlsteetonArcadePrizeVendor_NotEnoughCoinsScript
	getmonname CLEFAIRY, STRING_BUFFER_3
	scall OlsteetonArcadePrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext OlsteetonArcadePrizeVendorQuitText
	waitsfx
	playsound SFX_TRANSACTION
	writetext OlsteetonArcadePrizeVendorHereYouGoText
	waitbutton
	givepoke CLEFAIRY, 15
	iffalse_jumpopenedtext OlsteetonArcadePrizeVendorNoMoreRoomText
	setmonval CLEFAIRY
	special Special_GameCornerPrizeMonCheckDex
	takecoins OlsteetonArcade_CLEFAIRY_COINS
	sjump .loop

.MenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 2, 17, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Abra        {d:OlsteetonArcade_ABRA_COINS}@"
	db "Cubone      {d:OlsteetonArcade_CUBONE_COINS}@"
	db "Clefairy   {d:OlsteetonArcade_CLEFAIRY_COINS}@"
	db "Cancel@"

OlsteetonArcadePharmacistScript:
	showtextfaceplayer OlsteetonArcadePharmacistText
	turnobject LAST_TALKED, LEFT
	end

OlsteetonArcadePokefanM1Script:
	showtextfaceplayer OlsteetonArcadePokefanM1Text
	turnobject LAST_TALKED, RIGHT
	end

OlsteetonArcadeCooltrainerMScript:
	showtextfaceplayer OlsteetonArcadeCooltrainerMText
	turnobject LAST_TALKED, LEFT
	end

OlsteetonArcadePokefanFScript:
	showtextfaceplayer OlsteetonArcadePokefanFText
	turnobject LAST_TALKED, RIGHT
	end

OlsteetonArcadeGentlemanScript:
	showtextfaceplayer OlsteetonArcadeGentlemanText
	turnobject LAST_TALKED, RIGHT
	end

OlsteetonArcadeLeftTheirDrinkScript:
	jumptext OlsteetonArcadeLeftTheirDrinkText

OlsteetonArcadeSlotsMachineScript:
	random 6
	ifequalfwd 0, OlsteetonArcadeLuckySlotsMachineScript
	reanchormap
	setval FALSE
	special Special_SlotMachine
	endtext

OlsteetonArcadeLuckySlotsMachineScript:
	reanchormap
	setval TRUE
	special Special_SlotMachine
	endtext

OlsteetonArcadeCardFlipMachineScript:
	reanchormap
	special Special_CardFlip
	endtext

OlsteetonArcadePrizeVendorIntroText:
	text "Welcome!"

	para "We exchange your"
	line "game coins for"
	cont "fabulous prizes!"
	done

OlsteetonArcadePrizeVendorWhichPrizeText:
	text "Which prize would"
	line "you like?"
	done

OlsteetonArcadePrizeVendorConfirmPrizeText:
	text_ram wStringBuffer3
	text "."
	line "Is that right?"
	done

OlsteetonArcadePrizeVendorHereYouGoText:
	text "Here you go!"
	done

OlsteetonArcadePrizeVendorAlreadyHaveTMText:
	text "But you already"
	line "have that TM!"
	done

OlsteetonArcadePrizeVendorNeedMoreCoinsText:
	text "Sorry! You need"
	line "more coins."
	done

OlsteetonArcadePrizeVendorNoMoreRoomText:
	text "Oh, no. You can't"
	line "carry any more and"
	cont "your Box is full."

	para "I'll return your"
	line "coins to you."
	done

OlsteetonArcadePrizeVendorQuitText:
	text "OK. Please save"
	line "your coins and"
	cont "come again!"
	done

OlsteetonArcadePrizeVendorNoCoinCaseText:
	text "Oh? You don't have"
	line "a Coin Case."
	done

OlsteetonArcadeFisherText:
	text "Today's my pay day!"
	line "Time to celebrate"
	cont "with some slots!"

	para "…You know, #mon"
	line "get a Pay Day too."
	done

Text_OlsteetonArcadeTutorPayDayQuestion:
	text "If you give me a"
	line "Silver Leaf, I'll"

	para "teach Pay Day to"
	line "your #mon."
	done

Text_OlsteetonArcadeTutorNoSilverLeaf:
	text "You don't have a"
	line "Silver Leaf?"
	cont "Never mind then."
	done

Text_OlsteetonArcadeTutorRefused:
	text "Never mind then."
	done

Text_OlsteetonArcadeTutorTaught:
	text "Pay Day nets you"
	line "more money after a"
	cont "battle."

	para "Keep using it and"
	line "you'll be rich!"
	done

OlsteetonArcadePharmacistText:
	text "I always play this"
	line "slot machine. It"

	para "pays out more than"
	line "others, I think."
	done

OlsteetonArcadePokefanM1Text:
	text "I just love this"
	line "new slot machine."

	para "It's more of a"
	line "challenge than the"
	cont "ones in Celadon."
	done

OlsteetonArcadeCooltrainerMText:
	text "Life is a gamble."
	line "I'm going to flip"
	cont "cards till I drop!"
	done

OlsteetonArcadePokefanFText:
	text "Card flip…"

	para "I prefer it over"
	line "the slots because"

	para "it's easier to"
	line "figure the odds."

	para "But the payout is"
	line "much lower."
	done

OlsteetonArcadeCooltrainerFText:
	text "I won't quit until"
	line "I win!"
	done

OlsteetonArcadeGentlemanText:
	text "I taught Ice Beam"
	line "to my #mon."

	para "It was hard to get"
	line "enough coins for"

	para "it, but it was"
	line "worth it."
	done

OlsteetonArcadePokefanM2Text:
	text "I couldn't win at"
	line "the slots, and I"

	para "blew it on card"
	line "flipping…"

	para "I got so furious,"
	line "I tossed out my"

	para "Coin Case in the"
	line "Underground."
	done

OlsteetonArcadePokefanM3Text:
	text "Wahahah! The coins"
	line "keep rolling in!"
	done

OlsteetonArcadeLeftTheirDrinkText:
	text "Someone left their"
	line "drink."

	para "It smells sweet."
	done
