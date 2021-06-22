CELADONGAMECORNERPRIZEROOM_TM32_COINS EQU 3500
CELADONGAMECORNERPRIZEROOM_TM06_COINS EQU 5500
CELADONGAMECORNERPRIZEROOM_TM68_COINS EQU 7500
CELADONGAMECORNERPRIZEROOM_MR__MIME_COINS EQU 3333
CELADONGAMECORNERPRIZEROOM_EEVEE_COINS    EQU 6666
CELADONGAMECORNERPRIZEROOM_PORYGON_COINS  EQU 9999

CeladonGameCornerPrizeRoom_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, CELADON_CITY, 7
	warp_event  4,  7, CELADON_CITY, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  1, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonGameCornerTMVendor, -1
	object_event  5,  1, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonGameCornerPokemonVendor, -1
	object_event  0,  3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonGameCornerPrizeRoomGentlemanText, -1
	object_event  5,  5, SPRITE_PHARMACIST, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonGameCornerPrizeRoomPharmacistText, -1

CeladonGameCornerTMVendor:
	faceplayer
	opentext
	writetext CeladonPrizeRoom_PrizeVendorIntroText
	waitbutton
	checkkeyitem COIN_CASE
	iffalse_jumpopenedtext CeladonPrizeRoom_NoCoinCaseText
	writetext CeladonPrizeRoom_AskWhichPrizeText
CeladonPrizeRoom_tmcounterloop:
	special Special_DisplayCoinCaseBalance
	loadmenu CeladonPrizeRoom_TMMenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, .doubleteam
	ifequal $2, .toxic
	ifequal $3, .gigaimpact
	jumpopenedtext CeladonPrizeRoom_ComeAgainText

.doubleteam
	checktmhm TM_DOUBLE_TEAM
	iftrue CeladonPrizeRoom_alreadyhavetm
	checkcoins CELADONGAMECORNERPRIZEROOM_TM32_COINS
	ifequal $2, CeladonPrizeRoom_notenoughcoins
	gettmhmname TM_DOUBLE_TEAM, $0
	scall CeladonPrizeRoom_askbuytm
	iffalse_jumpopenedtext CeladonPrizeRoom_ComeAgainText
	givetmhm TM_DOUBLE_TEAM
	takecoins CELADONGAMECORNERPRIZEROOM_TM32_COINS
	sjump CeladonPrizeRoom_purchased

.toxic
	checktmhm TM_TOXIC
	iftrue CeladonPrizeRoom_alreadyhavetm
	checkcoins CELADONGAMECORNERPRIZEROOM_TM06_COINS
	ifequal $2, CeladonPrizeRoom_notenoughcoins
	gettmhmname TM_TOXIC, $0
	scall CeladonPrizeRoom_askbuytm
	iffalse_jumpopenedtext CeladonPrizeRoom_ComeAgainText
	givetmhm TM_TOXIC
	takecoins CELADONGAMECORNERPRIZEROOM_TM06_COINS
	sjump CeladonPrizeRoom_purchased

.gigaimpact
	checktmhm TM_GIGA_IMPACT
	iftrue CeladonPrizeRoom_alreadyhavetm
	checkcoins CELADONGAMECORNERPRIZEROOM_TM68_COINS
	ifequal $2, CeladonPrizeRoom_notenoughcoins
	gettmhmname TM_GIGA_IMPACT, $0
	scall CeladonPrizeRoom_askbuytm
	iffalse_jumpopenedtext CeladonPrizeRoom_ComeAgainText
	givetmhm TM_GIGA_IMPACT
	takecoins CELADONGAMECORNERPRIZEROOM_TM68_COINS
	sjump CeladonPrizeRoom_purchased

CeladonPrizeRoom_askbuy:
	writetext CeladonPrizeRoom_ConfirmPurchaseText
	yesorno
	end

CeladonPrizeRoom_askbuytm:
	writetext CeladonPrizeRoom_ConfirmTMPurchaseText
	yesorno
	end

CeladonPrizeRoom_purchased:
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	sjump CeladonPrizeRoom_tmcounterloop

CeladonPrizeRoom_alreadyhavetm:
	writetext CeladonPrizeRoom_AlreadyHaveTMText
	waitbutton
	sjump CeladonPrizeRoom_tmcounterloop

CeladonPrizeRoom_notenoughcoins:
	jumpopenedtext CeladonPrizeRoom_NotEnoughCoinsText

CeladonPrizeRoom_TMMenuDataHeader:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 15 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "TM32    {d:CELADONGAMECORNERPRIZEROOM_TM32_COINS}@"
	db "TM06    {d:CELADONGAMECORNERPRIZEROOM_TM06_COINS}@"
	db "TM68    {d:CELADONGAMECORNERPRIZEROOM_TM68_COINS}@"
	db "Cancel@"

CeladonGameCornerPokemonVendor:
	faceplayer
	opentext
	writetext CeladonPrizeRoom_PrizeVendorIntroText
	waitbutton
	checkkeyitem COIN_CASE
	iffalse_jumpopenedtext CeladonPrizeRoom_NoCoinCaseText
.loop
	writetext CeladonPrizeRoom_AskWhichPrizeText
	special Special_DisplayCoinCaseBalance
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, .mr__mime
	ifequal $2, .eevee
	ifequal $3, .porygon
	jumpopenedtext CeladonPrizeRoom_ComeAgainText

.mr__mime
	checkcoins CELADONGAMECORNERPRIZEROOM_MR__MIME_COINS
	ifequal $2, CeladonPrizeRoom_notenoughcoins
	getmonname MR__MIME, $0
	scall CeladonPrizeRoom_askbuy
	iffalse_jumpopenedtext CeladonPrizeRoom_ComeAgainText
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	givepoke MR__MIME, 10
	iffalse_jumpopenedtext CeladonPrizeRoom_NotEnoughRoomText
	setval MR__MIME
	special Special_GameCornerPrizeMonCheckDex
	takecoins CELADONGAMECORNERPRIZEROOM_MR__MIME_COINS
	sjump .loop

.eevee
	checkcoins CELADONGAMECORNERPRIZEROOM_EEVEE_COINS
	ifequal $2, CeladonPrizeRoom_notenoughcoins
	getmonname EEVEE, $0
	scall CeladonPrizeRoom_askbuy
	iffalse_jumpopenedtext CeladonPrizeRoom_ComeAgainText
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	givepoke EEVEE, 20
	iffalse_jumpopenedtext CeladonPrizeRoom_NotEnoughRoomText
	setval EEVEE
	special Special_GameCornerPrizeMonCheckDex
	takecoins CELADONGAMECORNERPRIZEROOM_EEVEE_COINS
	sjump .loop

.porygon
	checkcoins CELADONGAMECORNERPRIZEROOM_PORYGON_COINS
	ifequal $2, CeladonPrizeRoom_notenoughcoins
	getmonname PORYGON, $0
	scall CeladonPrizeRoom_askbuy
	iffalse_jumpopenedtext CeladonPrizeRoom_ComeAgainText
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	givepoke PORYGON, 30
	iffalse_jumpopenedtext CeladonPrizeRoom_NotEnoughRoomText
	setval PORYGON
	special Special_GameCornerPrizeMonCheckDex
	takecoins CELADONGAMECORNERPRIZEROOM_PORYGON_COINS
	sjump .loop

.MenuDataHeader:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 17 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Mr.Mime    {d:CELADONGAMECORNERPRIZEROOM_MR__MIME_COINS}@"
	db "Eevee      {d:CELADONGAMECORNERPRIZEROOM_EEVEE_COINS}@"
	db "Porygon    {d:CELADONGAMECORNERPRIZEROOM_PORYGON_COINS}@"
	db "Cancel@"

CeladonGameCornerPrizeRoomGentlemanText:
	text "I wanted Porygon,"
	line "but I was short by"
	cont "100 coins…"
	done

CeladonGameCornerPrizeRoomPharmacistText:
	text "Whew…"

	para "I've got to stay"
	line "calm and cool…"

	para "I can't lose my"
	line "cool, or I'll lose"
	cont "all my money…"
	done

CeladonPrizeRoom_PrizeVendorIntroText:
	text "Welcome!"

	para "We exchange your"
	line "coins for fabulous"
	cont "prizes!"
	done

CeladonPrizeRoom_AskWhichPrizeText:
	text "Which prize would"
	line "you like?"
	done

CeladonPrizeRoom_ConfirmPurchaseText:
	text "OK, so you wanted"
	line "a "
	text_ram wStringBuffer3
	text "?"
	done

CeladonPrizeRoom_ConfirmTMPurchaseText:
	text "OK, so you wanted"
	line ""
	text_ram wStringBuffer3
	text "?"
	done

CeladonPrizeRoom_HereYouGoText:
	text "Here you go!"
	done

CeladonPrizeRoom_AlreadyHaveTMText:
	text "You already have"
	line "that TM."
	done

CeladonPrizeRoom_NotEnoughCoinsText:
	text "You don't have"
	line "enough coins."
	done

CeladonPrizeRoom_NotEnoughRoomText:
	text "Wait, no, you have"
	line "no room for it."

	para "I'll return your"
	line "coins back to you."
	done

CeladonPrizeRoom_ComeAgainText:
	text "Oh. Please come"
	line "back with coins!"
	done

CeladonPrizeRoom_NoCoinCaseText:
	text "Oh? You don't have"
	line "a Coin Case."
	done
