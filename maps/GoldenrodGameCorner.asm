GoldenrodGameCorner_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodGameCorner_MapEventHeader:

.Warps: db 2
	warp_def 13, 2, 10, GOLDENROD_CITY
	warp_def 13, 3, 10, GOLDENROD_CITY

.XYTriggers: db 0

.Signposts: db 31
	signpost 6, 6, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 7, 6, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 8, 6, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 9, 6, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 10, 6, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 11, 6, SIGNPOST_RIGHT, GoldenrodGameCornerSlotsMachineScript
	signpost 6, 7, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 7, 7, SIGNPOST_READ, GoldenrodGameCornerLuckySlotsMachineScript
	signpost 8, 7, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 9, 7, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 10, 7, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 11, 7, SIGNPOST_LEFT, GoldenrodGameCornerSlotsMachineScript
	signpost 6, 12, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 7, 12, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 8, 12, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 9, 12, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 10, 12, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	signpost 11, 12, SIGNPOST_RIGHT, GoldenrodGameCornerSlotsMachineScript
	signpost 6, 13, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	signpost 7, 13, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	signpost 8, 13, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	signpost 9, 13, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	signpost 10, 13, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	signpost 11, 13, SIGNPOST_LEFT, GoldenrodGameCornerCardFlipMachineScript
	signpost 6, 18, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	signpost 7, 18, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	signpost 8, 18, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	signpost 9, 18, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	signpost 10, 18, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	signpost 11, 18, SIGNPOST_RIGHT, GoldenrodGameCornerCardFlipMachineScript
	signpost 1, 12, SIGNPOST_LEFT, GoldenrodGameCornerLeftTheirDrinkScript

.PersonEvents: db 12
	person_event SPRITE_CLERK, 2, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumpstd, gamecornercoinvendor, -1
	person_event SPRITE_RECEPTIONIST, 2, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerTMVendorScript, -1
	person_event SPRITE_RECEPTIONIST, 2, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerPrizeMonVendorScript, -1
	person_event SPRITE_FISHER, 1, 10, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerFisherScript, -1
	person_event SPRITE_COOLTRAINER_F, 3, 10, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodGameCornerCooltrainerFText, -1
	person_event SPRITE_POKEFAN_F, 6, 17, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanFScript, -1
	person_event SPRITE_PHARMACIST, 7, 8, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerPharmacistScript, -1
	person_event SPRITE_COOLTRAINER_M, 8, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerCooltrainerMScript, -1
	person_event SPRITE_GENTLEMAN, 10, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerGentlemanScript, -1
	person_event SPRITE_POKEFAN_M, 10, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanM1Script, -1
	person_event SPRITE_POKEFAN_M, 10, 17, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanM3Script, -1
	person_event SPRITE_POKEFAN_M, 9, 2, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodGameCornerPokefanM2Text, EVENT_BEAT_WHITNEY

GoldenrodGameCornerPokefanM3Script:
	showtextfaceplayer GoldenrodGameCornerPokefanM3Text
	spriteface LAST_TALKED, RIGHT
	end

GoldenrodGameCornerFisherScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_PAY_DAY_INTRO
	iftrue GoldenrodGameCornerTutorPayDayScript
	writetext GoldenrodGameCornerFisherText
	waitbutton
	setevent EVENT_LISTENED_TO_PAY_DAY_INTRO
GoldenrodGameCornerTutorPayDayScript:
	writetext Text_GoldenrodGameCornerTutorPayDayQuestion
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	yesorno
	iffalse .TutorRefused
	writebyte PAY_DAY
	writetext Text_GoldenrodGameCornerTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_GoldenrodGameCornerTutorRefused

.NoSilverLeaf
	waitbutton
	jumpopenedtext Text_GoldenrodGameCornerTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_GoldenrodGameCornerTutorTaught

GoldenrodGameCornerTMVendorScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse GoldenrodGameCornerPrizeVendor_NoCoinCaseScript
	writetext GoldenrodGameCornerPrizeVendorWhichPrizeText
GoldenrodGameCornerTMVendor_LoopScript: ; 056c36
	special Special_DisplayCoinCaseBalance
	loadmenudata GoldenrodGameCornerTMVendorMenuData
	verticalmenu
	closewindow
	if_equal $1, .flamethrower
	if_equal $2, .thunderbolt
	if_equal $3, .ice_beam
	jump GoldenrodGameCornerPrizeVendor_CancelPurchaseScript

.flamethrower:
	checktmhm TM_FLAMETHROWER
	iftrue GoldenrodGameCornerPrizeVendor_AlreadyHaveTMScript
	checkcoins 4000
	if_equal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	tmhmtotext TM_FLAMETHROWER, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	givetmhm TM_FLAMETHROWER
	takecoins 4000
	jump GoldenrodGameCornerTMVendor_FinishScript

.thunderbolt:
	checktmhm TM_THUNDERBOLT
	iftrue GoldenrodGameCornerPrizeVendor_AlreadyHaveTMScript
	checkcoins 4000
	if_equal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	tmhmtotext TM_THUNDERBOLT, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	givetmhm TM_THUNDERBOLT
	takecoins 4000
	jump GoldenrodGameCornerTMVendor_FinishScript

.ice_beam:
	checktmhm TM_ICE_BEAM
	iftrue GoldenrodGameCornerPrizeVendor_AlreadyHaveTMScript
	checkcoins 4000
	if_equal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	tmhmtotext TM_ICE_BEAM, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	givetmhm TM_ICE_BEAM
	takecoins 4000
	jump GoldenrodGameCornerTMVendor_FinishScript

GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript:
	writetext GoldenrodGameCornerPrizeVendorConfirmPrizeText
	yesorno
	end

GoldenrodGameCornerTMVendor_FinishScript:
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	jump GoldenrodGameCornerTMVendor_LoopScript

GoldenrodGameCornerPrizeVendor_AlreadyHaveTMScript:
	writetext GoldenrodGameCornerPrizeVendorAlreadyHaveTMText
	waitbutton
	jump GoldenrodGameCornerTMVendor_LoopScript

GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript:
	jumpopenedtext GoldenrodGameCornerPrizeVendorNeedMoreCoinsText

GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript:
	jumpopenedtext GoldenrodGameCornerPrizeVendorNoMoreRoomText

GoldenrodGameCornerPrizeVendor_CancelPurchaseScript:
	jumpopenedtext GoldenrodGameCornerPrizeVendorQuitText

GoldenrodGameCornerPrizeVendor_NoCoinCaseScript:
	jumpopenedtext GoldenrodGameCornerPrizeVendorNoCoinCaseText

GoldenrodGameCornerTMVendorMenuData:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 15 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "TM35    4000@"
	db "TM24    4000@"
	db "TM13    4000@"
	db "Cancel@"

GoldenrodGameCornerPrizeMonVendorScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse GoldenrodGameCornerPrizeVendor_NoCoinCaseScript
.loop
	writetext GoldenrodGameCornerPrizeVendorWhichPrizeText
	special Special_DisplayCoinCaseBalance
	loadmenudata .MenuDataHeader
	verticalmenu
	closewindow
	if_equal $1, .abra
	if_equal $2, .cubone
	if_equal $3, .clefairy
	jump GoldenrodGameCornerPrizeVendor_CancelPurchaseScript

.abra
	checkcoins 200
	if_equal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	checkcode VAR_PARTYCOUNT
	if_equal $6, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	pokenamemem ABRA, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	writebyte ABRA
	special Special_GameCornerPrizeMonCheckDex
	givepoke ABRA, 5
	takecoins 200
	jump .loop

.cubone
	checkcoins 800
	if_equal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	checkcode VAR_PARTYCOUNT
	if_equal $6, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	pokenamemem CUBONE, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	writebyte CUBONE
	special Special_GameCornerPrizeMonCheckDex
	givepoke CUBONE, 10
	takecoins 800
	jump .loop

.clefairy
	checkcoins 1500
	if_equal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	checkcode VAR_PARTYCOUNT
	if_equal $6, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	pokenamemem CLEFAIRY, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	writebyte CLEFAIRY
	special Special_GameCornerPrizeMonCheckDex
	givepoke CLEFAIRY, 15
	takecoins 1500
	jump .loop

.MenuDataHeader:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 17 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Abra        200@"
	db "Cubone      800@"
	db "Clefairy   1500@"
	db "Cancel@"

GoldenrodGameCornerPharmacistScript:
	showtextfaceplayer GoldenrodGameCornerPharmacistText
	spriteface LAST_TALKED, LEFT
	end

GoldenrodGameCornerPokefanM1Script:
	showtextfaceplayer GoldenrodGameCornerPokefanM1Text
	spriteface LAST_TALKED, RIGHT
	end

GoldenrodGameCornerCooltrainerMScript:
	showtextfaceplayer GoldenrodGameCornerCooltrainerMText
	spriteface LAST_TALKED, LEFT
	end

GoldenrodGameCornerPokefanFScript:
	showtextfaceplayer GoldenrodGameCornerPokefanFText
	spriteface LAST_TALKED, RIGHT
	end

GoldenrodGameCornerGentlemanScript:
	showtextfaceplayer GoldenrodGameCornerGentlemanText
	spriteface LAST_TALKED, RIGHT
	end

GoldenrodGameCornerLeftTheirDrinkScript:
	jumptext GoldenrodGameCornerLeftTheirDrinkText

GoldenrodGameCornerSlotsMachineScript:
	random 6
	if_equal 0, GoldenrodGameCornerLuckySlotsMachineScript
	refreshscreen
	writebyte FALSE
	special Special_SlotMachine
	endtext

GoldenrodGameCornerLuckySlotsMachineScript:
	refreshscreen
	writebyte TRUE
	special Special_SlotMachine
	endtext

GoldenrodGameCornerCardFlipMachineScript:
	refreshscreen
	special Special_CardFlip
	endtext

GoldenrodGameCornerPrizeVendorIntroText:
	text "Welcome!"

	para "We exchange your"
	line "game coins for"
	cont "fabulous prizes!"
	done

GoldenrodGameCornerPrizeVendorWhichPrizeText:
	text "Which prize would"
	line "you like?"
	done

GoldenrodGameCornerPrizeVendorConfirmPrizeText:
	text_from_ram StringBuffer3
	text "."
	line "Is that right?"
	done

GoldenrodGameCornerPrizeVendorHereYouGoText:
	text "Here you go!"
	done

GoldenrodGameCornerPrizeVendorAlreadyHaveTMText:
	text "But you already"
	line "have that TM!"
	done

GoldenrodGameCornerPrizeVendorNeedMoreCoinsText:
	text "Sorry! You need"
	line "more coins."
	done

GoldenrodGameCornerPrizeVendorNoMoreRoomText:
	text "Sorry. You can't"
	line "carry any more."
	done

GoldenrodGameCornerPrizeVendorQuitText:
	text "OK. Please save"
	line "your coins and"
	cont "come again!"
	done

GoldenrodGameCornerPrizeVendorNoCoinCaseText:
	text "Oh? You don't have"
	line "a Coin Case."
	done

GoldenrodGameCornerFisherText:
	text "Today's my pay day!"
	line "Time to celebrate"
	cont "with some slots!"

	para "…You know, #mon"
	line "get a Pay Day too."
	done

Text_GoldenrodGameCornerTutorPayDayQuestion:
	text "If you give me a"
	line "Silver Leaf, I'll"

	para "teach Pay Day to"
	line "your #mon."
	done

Text_GoldenrodGameCornerTutorNoSilverLeaf:
	text "You don't have a"
	line "Silver Leaf?"
	cont "Never mind then."
	done

Text_GoldenrodGameCornerTutorRefused:
	text "Never mind then."
	done

Text_GoldenrodGameCornerTutorClear:
	text ""
	done

Text_GoldenrodGameCornerTutorTaught:
	text "Pay Day nets you"
	line "more money after a"
	cont "battle."

	para "Keep using it and"
	line "you'll be rich!"
	done

GoldenrodGameCornerPharmacistText:
	text "I always play this"
	line "slot machine. It"

	para "pays out more than"
	line "others, I think."
	done

GoldenrodGameCornerPokefanM1Text:
	text "I just love this"
	line "new slot machine."

	para "It's more of a"
	line "challenge than the"
	cont "ones in Celadon."
	done

GoldenrodGameCornerCooltrainerMText:
	text "Life is a gamble."
	line "I'm going to flip"
	cont "cards till I drop!"
	done

GoldenrodGameCornerPokefanFText:
	text "Card flip…"

	para "I prefer it over"
	line "the slots because"

	para "it's easier to"
	line "figure the odds."

	para "But the payout is"
	line "much lower."
	done

GoldenrodGameCornerCooltrainerFText:
	text "I won't quit until"
	line "I win!"
	done

GoldenrodGameCornerGentlemanText:
	text "I taught Ice Beam"
	line "to my #mon."

	para "It was hard to get"
	line "enough coins for"

	para "it, but it was"
	line "worth it."
	done

GoldenrodGameCornerPokefanM2Text:
	text "I couldn't win at"
	line "the slots, and I"

	para "blew it on card"
	line "flipping…"

	para "I got so furious,"
	line "I tossed out my"

	para "Coin Case in the"
	line "Underground."
	done

GoldenrodGameCornerPokefanM3Text:
	text "Wahahah! The coins"
	line "keep rolling in!"
	done

GoldenrodGameCornerLeftTheirDrinkText:
	text "Someone left their"
	line "drink."

	para "It smells sweet."
	done
