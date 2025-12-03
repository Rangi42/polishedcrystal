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
	cp -1
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
	call GetItemQuantity
	jr z, .no_item ; Item not found in bag, return no carry
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
	cp -1
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
	; CountItem returns 16-bit value in wBuffer1 (low) and wBuffer2 (high)
	ld a, [wBuffer2]
	and a
	jr nz, .max_quantity ; If high byte is non-zero, cap at 99
	ld a, [wBuffer1]
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
	jp TossItem

MultiplyMoneyByQuantity:
; Multiply hMoneyTemp by wItemQuantityChangeBuffer
; Result is stored in hMoneyTemp (3 bytes)
; If overflow would occur, caps at MAX_MONEY
	push bc
	push de
	push hl
	ld a, [wItemQuantityChangeBuffer]
	ld b, a
	ldh a, [hMoneyTemp + 2]
	ld c, a
	ldh a, [hMoneyTemp + 1]
	ld d, a
	ldh a, [hMoneyTemp]
	ld e, a
	
	; Clear result
	xor a
	ldh [hMoneyTemp], a
	ldh [hMoneyTemp + 1], a
	ldh [hMoneyTemp + 2], a
	
	; Add the original value b times
.loop
	ld a, b
	and a
	jr z, .done
	
	; Add CDE to hMoneyTemp
	ldh a, [hMoneyTemp + 2]
	add c
	ldh [hMoneyTemp + 2], a
	ldh a, [hMoneyTemp + 1]
	adc d
	ldh [hMoneyTemp + 1], a
	ldh a, [hMoneyTemp]
	adc e
	ldh [hMoneyTemp], a
	
	; Check for overflow (if result >= MAX_MONEY)
	jr c, .overflow
	ldh a, [hMoneyTemp]
	cp HIGH(MAX_MONEY >> 16)
	jr c, .no_overflow
	jr nz, .overflow
	ldh a, [hMoneyTemp + 1]
	cp HIGH(MAX_MONEY >> 8)
	jr c, .no_overflow
	jr nz, .overflow
	ldh a, [hMoneyTemp + 2]
	cp LOW(MAX_MONEY)
	jr c, .no_overflow
	
.overflow
	; Cap at MAX_MONEY
	ld a, HIGH(MAX_MONEY >> 16)
	ldh [hMoneyTemp], a
	ld a, HIGH(MAX_MONEY >> 8)
	ldh [hMoneyTemp + 1], a
	ld a, LOW(MAX_MONEY)
	ldh [hMoneyTemp + 2], a
	jr .done
	
.no_overflow
	dec b
	jr .loop
	
.done
	jmp PopBCDEHL
