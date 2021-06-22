CalculateMaximumQuantity:
; limit [wItemQuantityBuffer] so that de * [wItemQuantityBuffer] <= wMoney
; 1 <= [wItemQuantityBuffer] <= 99
	xor a
	ldh [hMoneyTemp + 0], a
	ldh [hMoneyTemp + 1], a
	ldh [hMoneyTemp + 2], a
	ld b, -1
	jr .start
.loop
	cp 99
	jr nc, .done
.start
	ldh a, [hMoneyTemp + 2]
	add e
	ldh [hMoneyTemp + 2], a
	ldh a, [hMoneyTemp + 1]
	adc d
	ldh [hMoneyTemp + 1], a
	ldh a, [hMoneyTemp + 0]
	adc 0
	ldh [hMoneyTemp + 0], a
	inc b
	push de
	push bc
	ld bc, hMoneyTemp
	ld de, wMoney
	farcall CompareMoney
	pop bc
	pop de
	ld a, b
	jr nc, .loop
.done
	and a
	jr nz, .ok
	inc a
.ok
	ld [wItemQuantityBuffer], a
	ret

CalculateMaximumBTQuantity:
; limit [wItemQuantityBuffer] so that c * [wItemQuantityBuffer] <= wBattlePoints
; 1 <= [wItemQuantityBuffer] <= 99
	xor a
	ldh [hMoneyTemp + 0], a
	ldh [hMoneyTemp + 1], a
	ld b, -1
	jr .start
.loop
	cp 99
	jr nc, .done
.start
	ldh a, [hMoneyTemp + 1]
	add c
	ldh [hMoneyTemp + 1], a
	ldh a, [hMoneyTemp + 0]
	adc 0
	ldh [hMoneyTemp + 0], a
	inc b
	push bc
	ld bc, hMoneyTemp
	ld de, wBattlePoints
	ld a, 2
	farcall CompareFunds
	pop bc
	ld a, b
	jr nc, .loop
.done
	and a
	jr nz, .ok
	inc a
.ok
	ld [wItemQuantityBuffer], a
	ret

SelectQuantityToToss:
	ld hl, TossItem_MenuDataHeader
	call LoadMenuHeader
	jr Toss_Sell_Loop

SelectQuantityToBuy:
	farcall GetItemPrice
RooftopSale_SelectQuantityToBuy:
	ld a, d
	ld [wBuffer1], a
	ld a, e
	ld [wBuffer2], a
	call CalculateMaximumQuantity
	ld hl, BuyItem_MenuDataHeader
	call LoadMenuHeader
	jr Toss_Sell_Loop

BT_SelectQuantityToBuy:
	xor a
	ld [wBuffer1], a
	ld a, c
	ld [wBuffer2], a
	call CalculateMaximumBTQuantity
	ld hl, BTBuyItem_MenuDataHeader
	call LoadMenuHeader
	jr Toss_Sell_Loop

SelectQuantityToSell:
	farcall GetItemPrice
	ld a, d
	ld [wBuffer1], a
	ld a, e
	ld [wBuffer2], a
	ld hl, SellItem_MenuDataHeader
	call LoadMenuHeader
	; fallthrough

Toss_Sell_Loop:
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
.loop
	call BuySellToss_UpdateQuantityDisplay ; update display
	call BuySellToss_InterpretJoypad       ; joy action
	jr nc, .loop
	cp -1
	jr nz, .nope ; pressed B
	scf
	ret

.nope
	and a
	ret

BuySellToss_InterpretJoypad:
	call JoyTextDelay_ForcehJoyDown ; get joypad
	bit B_BUTTON_F, c
	jr nz, .b
	bit A_BUTTON_F, c
	jr nz, .a
	bit D_DOWN_F, c
	jr nz, .down
	bit D_UP_F, c
	jr nz, .up
	bit D_LEFT_F, c
	jr nz, .left
	bit D_RIGHT_F, c
	jr nz, .right
	and a
	ret

.b
	ld a, -1
	scf
	ret

.a
	xor a
	scf
	ret

.down
	ld hl, wItemQuantityChangeBuffer
	dec [hl]
	jr nz, .finish_down
	ld a, [wItemQuantityBuffer]
	ld [hl], a

.finish_down
	and a
	ret

.up
	ld hl, wItemQuantityChangeBuffer
	inc [hl]
	ld a, [wItemQuantityBuffer]
	cp [hl]
	jr nc, .finish_up
	ld [hl], 1

.finish_up
	and a
	ret

.left
	ld a, [wItemQuantityChangeBuffer]
	sub 10
	jr c, .load_1
	jr nz, .finish_left

.load_1
	ld a, 1

.finish_left
	ld [wItemQuantityChangeBuffer], a
	and a
	ret

.right
	ld a, [wItemQuantityChangeBuffer]
	add 10
	ld b, a
	ld a, [wItemQuantityBuffer]
	cp b
	jr nc, .finish_right
	ld b, a

.finish_right
	ld a, b
	ld [wItemQuantityChangeBuffer], a
	and a
	ret

BuySellToss_UpdateQuantityDisplay:
	call MenuBox
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld a, "×"
	ld [hli], a
	ld de, wItemQuantityChangeBuffer
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	dec hl
	ld a, [wMenuDataPointer]
	ld e, a
	ld a, [wMenuDataPointer + 1]
	ld d, a
	ld a, [wMenuDataBank]
	jmp FarCall_de

DisplayPurchasePrice:
	call BuySell_MultiplyPrice
	jr BuySell_DisplaySubtotal

DisplaySellingPrice:
	call BuySell_MultiplyPrice
	; halve price
	push hl
	ld hl, hProduct + 1
	ld a, [hl]
	srl a
	ld [hli], a
	ld a, [hl]
	rra
	ld [hli], a
	ld a, [hl]
	rra
	ld [hl], a
	pop hl
	; fallthrough

BuySell_DisplaySubtotal:
	call DisplayPurchasePriceCommon
	lb bc, PRINTNUM_MONEY | 3, 7
	call PrintNum
	jmp ApplyTilemapInVBlank

BuySell_MultiplyPrice:
	xor a
	ldh [hMultiplicand + 0], a
	ld a, [wBuffer1]
	ldh [hMultiplicand + 1], a
	ld a, [wBuffer2]
	ldh [hMultiplicand + 2], a
	ld a, [wItemQuantityChangeBuffer]
	ldh [hMultiplier], a
	push hl
	call Multiply
	pop hl
	ret

BTDisplayPurchaseCost:
	call BuySell_MultiplyPrice
	call DisplayPurchasePriceCommon
	lb bc, 3, 5
	call PrintNum
	ld de, .BPString
	rst PlaceString
	jmp ApplyTilemapInVBlank

.BPString:
	db " BP@"

DisplayPurchasePriceCommon:
	push hl
	ld hl, hMoneyTemp
	ldh a, [hProduct + 1]
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop hl
	inc hl
	ld de, hMoneyTemp
	ret

TossItem_MenuDataHeader:
	db $40 ; flags
	db 09, 15 ; start coords
	db 11, 19 ; end coords
	dw DoNothing
	db 0 ; default option

BuyItem_MenuDataHeader:
	db $40 ; flags
	db 15, 07 ; start coords
	db 17, 19 ; end coords
	dw DisplayPurchasePrice
	db -1 ; default option

SellItem_MenuDataHeader:
	db $40 ; flags
	db 15, 07 ; start coords
	db 17, 19 ; end coords
	dw DisplaySellingPrice
	db 0 ; default option

BTBuyItem_MenuDataHeader:
	db $40 ; flags
	db 15, 07 ; start coords
	db 17, 19 ; end coords
	dw BTDisplayPurchaseCost
	db -1 ; default option
