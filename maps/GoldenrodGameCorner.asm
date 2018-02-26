GoldenrodGameCorner_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2, 13, GOLDENROD_CITY, 10
	warp_event  3, 13, GOLDENROD_CITY, 10

	db 0 ; coord events

	db 31 ; bg events
	bg_event  6,  6, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6,  7, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6,  8, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6,  9, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6, 10, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6, 11, SIGNPOST_RIGHT, GoldenrodGameCornerSlotsMachineScript
	bg_event  7,  6, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7,  7, SIGNPOST_READ, GoldenrodGameCornerLuckySlotsMachineScript
	bg_event  7,  8, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7,  9, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7, 10, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7, 11, SIGNPOST_LEFT, GoldenrodGameCornerSlotsMachineScript
	bg_event 12,  6, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12,  7, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12,  8, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12,  9, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12, 10, SIGNPOST_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12, 11, SIGNPOST_RIGHT, GoldenrodGameCornerSlotsMachineScript
	bg_event 13,  6, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13,  7, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13,  8, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13,  9, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13, 10, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13, 11, SIGNPOST_LEFT, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  6, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  7, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  8, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  9, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18, 10, SIGNPOST_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18, 11, SIGNPOST_RIGHT, GoldenrodGameCornerCardFlipMachineScript
	bg_event 12,  1, SIGNPOST_LEFT, GoldenrodGameCornerLeftTheirDrinkScript

	db 12 ; object events
	object_event  3,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumpstd, gamecornercoinvendor, -1
	object_event 16,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerTMVendorScript, -1
	object_event 18,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerPrizeMonVendorScript, -1
	object_event 10,  1, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerFisherScript, -1
	object_event 10,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodGameCornerCooltrainerFText, -1
	object_event 17,  6, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanFScript, -1
	object_event  8,  7, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerPharmacistScript, -1
	object_event 14,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerCooltrainerMScript, -1
	object_event  5, 10, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerGentlemanScript, -1
	object_event 11, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanM1Script, -1
	object_event 17, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanM3Script, -1
	object_event  2,  9, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodGameCornerPokefanM2Text, EVENT_BEAT_WHITNEY

GoldenrodGameCornerPokefanM3Script:
	showtextfaceplayer GoldenrodGameCornerPokefanM3Text
	turnobject LAST_TALKED, RIGHT
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
	ifequal $0, .TeachMove
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
	iffalse_jumpopenedtext GoldenrodGameCornerPrizeVendorNoCoinCaseText
	writetext GoldenrodGameCornerPrizeVendorWhichPrizeText
GoldenrodGameCornerTMVendor_LoopScript: ; 056c36
	special Special_DisplayCoinCaseBalance
	loadmenu GoldenrodGameCornerTMVendorMenuData
	verticalmenu
	closewindow
	ifequal $1, .flamethrower
	ifequal $2, .thunderbolt
	ifequal $3, .ice_beam
	jumpopenedtext GoldenrodGameCornerPrizeVendorQuitText

.flamethrower:
	checktmhm TM_FLAMETHROWER
	iftrue GoldenrodGameCornerPrizeVendor_AlreadyHaveTMScript
	checkcoins 4000
	ifequal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	tmhmtotext TM_FLAMETHROWER, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext GoldenrodGameCornerPrizeVendorQuitText
	givetmhm TM_FLAMETHROWER
	takecoins 4000
	jump GoldenrodGameCornerTMVendor_FinishScript

.thunderbolt:
	checktmhm TM_THUNDERBOLT
	iftrue GoldenrodGameCornerPrizeVendor_AlreadyHaveTMScript
	checkcoins 4000
	ifequal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	tmhmtotext TM_THUNDERBOLT, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext GoldenrodGameCornerPrizeVendorQuitText
	givetmhm TM_THUNDERBOLT
	takecoins 4000
	jump GoldenrodGameCornerTMVendor_FinishScript

.ice_beam:
	checktmhm TM_ICE_BEAM
	iftrue GoldenrodGameCornerPrizeVendor_AlreadyHaveTMScript
	checkcoins 4000
	ifequal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	tmhmtotext TM_ICE_BEAM, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext GoldenrodGameCornerPrizeVendorQuitText
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
	iffalse_jumpopenedtext GoldenrodGameCornerPrizeVendorNoCoinCaseText
.loop
	writetext GoldenrodGameCornerPrizeVendorWhichPrizeText
	special Special_DisplayCoinCaseBalance
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, .abra
	ifequal $2, .cubone
	ifequal $3, .clefairy
	jumpopenedtext GoldenrodGameCornerPrizeVendorQuitText

.abra
	checkcoins 200
	ifequal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	checkcode VAR_PARTYCOUNT
	ifequal $6, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	pokenamemem ABRA, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext GoldenrodGameCornerPrizeVendorQuitText
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
	ifequal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	checkcode VAR_PARTYCOUNT
	ifequal $6, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	pokenamemem CUBONE, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext GoldenrodGameCornerPrizeVendorQuitText
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
	ifequal $2, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	checkcode VAR_PARTYCOUNT
	ifequal $6, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	pokenamemem CLEFAIRY, $0
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse_jumpopenedtext GoldenrodGameCornerPrizeVendorQuitText
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
	turnobject LAST_TALKED, LEFT
	end

GoldenrodGameCornerPokefanM1Script:
	showtextfaceplayer GoldenrodGameCornerPokefanM1Text
	turnobject LAST_TALKED, RIGHT
	end

GoldenrodGameCornerCooltrainerMScript:
	showtextfaceplayer GoldenrodGameCornerCooltrainerMText
	turnobject LAST_TALKED, LEFT
	end

GoldenrodGameCornerPokefanFScript:
	showtextfaceplayer GoldenrodGameCornerPokefanFText
	turnobject LAST_TALKED, RIGHT
	end

GoldenrodGameCornerGentlemanScript:
	showtextfaceplayer GoldenrodGameCornerGentlemanText
	turnobject LAST_TALKED, RIGHT
	end

GoldenrodGameCornerLeftTheirDrinkScript:
	jumptext GoldenrodGameCornerLeftTheirDrinkText

GoldenrodGameCornerSlotsMachineScript:
	random 6
	ifequal 0, GoldenrodGameCornerLuckySlotsMachineScript
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
