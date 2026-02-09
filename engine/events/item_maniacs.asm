GetGourmetManiacPrice:
	ld hl, GourmetManiacItemRewards
	jr GetItemManiacPrice

GetOreManiacPrice:
	ld hl, OreManiacItemRewards
	jr GetItemManiacPrice

GetFossilManiacPrice:
	ld hl, FossilManiacItemRewards
GetItemManiacPrice:
	xor a ; ld a, FALSE
	ldh [hScriptVar], a
	ld a, [wCurItem]
	ld b, a
.loop
	ld a, [hli]
	inc a
	ret z
	cp b
	jr z, .found
	inc hl
	inc hl
	jr .loop
.found
	ld a, [hli]
	ldh [hMoneyTemp + 2], a
	ld a, [hl]
	ldh [hMoneyTemp + 1], a
	xor a
	ldh [hMoneyTemp], a
	inc a ; ld a, TRUE
	ldh [hScriptVar], a
	ret

INCLUDE "data/items/item_maniacs.asm"

ItemManiac_SelectQuantity:
; Returns carry if the player selects a quantity, or no carry if they press B.
; The selected quantity is stored in wItemQuantityChangeBuffer.
	xor a ; ld a, FALSE
	ldh [hScriptVar], a
	call GetItemQuantity
	jr z, .no_item ; Item not found in bag, return no carry
	call ItemManiac_PrintTextHowMany
	ld a, [wItemQuantityChangeBuffer]
	ld [wItemQuantityBuffer], a
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld hl, .MenuDataHeader
	call LoadMenuHeader
	call MenuBox
	call ApplyTilemap
.loop
	ld a, 1
	ldh [hBGMapMode], a
	call MenuBox
	call .PlaceItemName
	call .PlaceItemQuantity
	call UpdateSprites
	farcall BuySellToss_InterpretJoypad
	ld b, a
	jr nc, .loop

	push bc
	call PlayClickSFX
	pop bc
	ld a, b
	inc a ; cp -1
	jr z, .no_item

	; Validate selected quantity doesn't exceed available
	ld a, [wItemQuantityChangeBuffer]
	ld b, a
	ld a, [wItemQuantityBuffer]
	cp b
	jr nc, .valid_quantity
	; Selected quantity exceeds available, cap it
	ld [wItemQuantityChangeBuffer], a
.valid_quantity
	ld a, TRUE
	ldh [hScriptVar], a
	scf
	jmp CloseWindow

.no_item
	call CloseWindow
	and a ; clear carry
	ret

.MenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 6, 9, 19, 12

.PlaceItemName:
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
	call GetItemName
	rst PlaceString
	ret

.PlaceItemQuantity:
	call MenuBoxCoord2Tile
	ld de, 2 * SCREEN_WIDTH + 10
	add hl, de
	ld a, '×'
	ld [hli], a
	ld de, wItemQuantityChangeBuffer
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jmp PrintNum

ItemManiac_PrintTextHowMany:
	ld hl, .Text
	jmp PrintText

.Text:
	; How many do you want to sell?
	text_far _HowManyDoYouWantToSellText
	text_end

GetItemQuantity:
; Get the quantity of the item in wCurItem.
; Returns the quantity in wItemQuantityChangeBuffer.
; Returns z if the item is not in the bag.
	push bc
	push hl
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
	ld hl, wNumItems
	call CountItem
	; CountItem returns 16-bit value in wItemCountHi (high) and wItemCountLo (low)
	ld a, [wItemCountHi]
	and a
	jr nz, .max_quantity ; If high byte is non-zero, cap at 99
	ld a, [wItemCountLo]
	cp 100
	jr c, .store_quantity
.max_quantity
	ld a, 99
.store_quantity
	ld [wItemQuantityChangeBuffer], a
	and a
	pop hl
	pop bc
	ret

Give_hMoneyTemp:
	ld de, wMoney
	ld bc, hMoneyTemp
	farjp GiveMoney

TakeItemFromMemWithQuantity:
; Takes wCurItem with quantity in wItemQuantityChangeBuffer
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
	ld a, [wItemQuantityChangeBuffer]
	ld [wItemQuantityBuffer], a
	ld hl, wNumItems
	jmp TossItem

MultiplyMoneyByQuantity:
; Multiply hMoneyTemp by wItemQuantityChangeBuffer
; Result is stored in hMoneyTemp (3 bytes)
; If overflow would occur, caps at MAX_MONEY
	push bc
	push de
	push hl
	ld a, [wItemQuantityChangeBuffer]
	ldh [hMultiplier], a
	ldh a, [hMoneyTemp]
	ldh [hMultiplicand], a
	ldh a, [hMoneyTemp + 1]
	ldh [hMultiplicand + 1], a
	ldh a, [hMoneyTemp + 2]
	ldh [hMultiplicand + 2], a
	farcall Multiply

	; If hProduct doesn't fit in 24 bits, cap at MAX_MONEY.
	ldh a, [hProduct]
	and a
	jr nz, .overflow
	; Otherwise compare 24-bit hProduct[1..3] against MAX_MONEY.
	ldh a, [hProduct + 1]
	cp HIGH(MAX_MONEY >> 8)
	jr c, .copy
	jr nz, .overflow
	ldh a, [hProduct + 2]
	cp HIGH(MAX_MONEY)
	jr c, .copy
	jr nz, .overflow
	ldh a, [hProduct + 3]
	cp LOW(MAX_MONEY)
	jr z, .copy
	jr c, .copy

.overflow
	ld a, HIGH(MAX_MONEY >> 8)
	ldh [hMoneyTemp], a
	ld a, HIGH(MAX_MONEY)
	ldh [hMoneyTemp + 1], a
	ld a, LOW(MAX_MONEY)
	ldh [hMoneyTemp + 2], a
	jmp PopBCDEHL

.copy
	ldh a, [hProduct + 1]
	ldh [hMoneyTemp], a
	ldh a, [hProduct + 2]
	ldh [hMoneyTemp + 1], a
	ldh a, [hProduct + 3]
	ldh [hMoneyTemp + 2], a
	jmp PopBCDEHL
