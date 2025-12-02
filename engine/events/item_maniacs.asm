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

ItemManiac_PrintTextHowMany:
	ld hl, .Text
	jmp PrintText

.Text:
	; How many do you want to sell?
	text_far _ItemManiacHowManyText
	text_end

ItemManiac_SelectQuantity:
; Returns carry if the player selects a quantity, or no carry if they press B.
; The selected quantity is stored in wItemQuantityChangeBuffer.
	call GetItemQuantity
	ret z ; Item not found in bag
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
	jr z, .done
	scf

.done
	jmp CloseWindow

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
	ld a, [wBuffer1]
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
	
	dec b
	jr .loop
	
.done
	pop hl
	pop de
	pop bc
	ret
