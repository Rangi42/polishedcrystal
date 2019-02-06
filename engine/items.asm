_ReceiveItem:: ; d1d5
	call DoesHLEqualNumItems
	jp nz, PutItemInPocket
	push hl
	call CheckItemPocket
	pop de
	ld a, [wItemAttributeParamBuffer]
	dec a
	ld hl, .Pockets
	rst JumpTable
	ret

.Pockets: ; d1e9
	dw .Item
	dw .Medicine
	dw .Ball
	dw TMHM_Dummy
	dw .Berry
	dw .KeyItem

.Item: ; d1f1
	ld hl, wNumItems
	jp PutItemInPocket

.Medicine:
	ld hl, wNumMedicine
	jp PutItemInPocket

.Ball: ; d1fb
	ld hl, wNumBalls
	jp PutItemInPocket

.Berry:
	ld hl, wNumBerries
	jp PutItemInPocket

.KeyItem: ; d1f6
	ld hl, wNumKeyItems
	jp ReceiveKeyItem

_TossItem:: ; d20d
	call DoesHLEqualNumItems
	jr nz, .remove
	push hl
	call CheckItemPocket
	pop de
	ld a, [wItemAttributeParamBuffer]
	dec a
	ld hl, .Pockets
	rst JumpTable
	ret

.Pockets:
	dw .Item
	dw .Medicine
	dw .Ball
	dw TMHM_Dummy
	dw .Berry
	dw .KeyItem

.Medicine:
	ld hl, wNumMedicine
	jp RemoveItemFromPocket

.Ball: ; d228
	ld hl, wNumBalls
	jp RemoveItemFromPocket

.Berry:
	ld hl, wNumBerries
	jp RemoveItemFromPocket

.KeyItem: ; d23a
	ld h, d
	ld l, e
	jp TossKeyItem

.Item: ; d23f
	ld h, d
	ld l, e
.remove
	jp RemoveItemFromPocket

_CheckItem:: ; d244
	call DoesHLEqualNumItems
	jr nz, .nope
	push hl
	call CheckItemPocket
	pop de
	ld a, [wItemAttributeParamBuffer]
	dec a
	ld hl, .Pockets
	rst JumpTable
	ret

.Pockets:
	dw .Item
	dw .Medicine
	dw .Ball
	dw TMHM_Dummy
	dw .Berry
	dw .KeyItem

.Medicine:
	ld hl, wNumMedicine
	jp CheckTheItem

.Ball: ; d25f
	ld hl, wNumBalls
	jp CheckTheItem

.Berry:
	ld hl, wNumBerries
	jp CheckTheItem

.KeyItem: ; d271
	ld h, d
	ld l, e
	jp CheckKeyItems

.Item: ; d276
	ld h, d
	ld l, e
.nope
	jp CheckTheItem

DoesHLEqualNumItems: ; d27b
	ld a, l
	cp wNumItems % $100
	ret nz
	ld a, h
	cp wNumItems / $100
	ret

GetPocketCapacity: ; d283
	ld c, MAX_ITEMS
	ld a, e
	cp wNumItems % $100
	jr nz, .not_items
	ld a, d
	cp wNumItems / $100
	ret z

.not_items:
	ld c, MAX_MEDICINE
	ld a, e
	cp wNumMedicine % $100
	jr nz, .not_medicine
	ld a, d
	cp wNumMedicine / $100
	ret z

.not_medicine:
	ld c, MAX_BALLS
	ld a, e
	cp wNumBalls % $100
	jr nz, .not_balls
	ld a, d
	cp wNumBalls / $100
	ret z

.not_balls:
	ld c, MAX_BERRIES
	ld a, e
	cp wNumBerries % $100
	jr nz, .not_berries
	ld a, d
	cp wNumBerries / $100
	ret z

.not_berries:
	ld c, MAX_PC_ITEMS
TMHM_Dummy:
KeyItem_Dummy:
	ret

PutItemInPocket: ; d29c
	ld d, h
	ld e, l
	inc hl
	ld a, [wCurItem]
	ld c, a
	ld b, 0
.loop
	ld a, [hli]
	cp -1
	jr z, .terminator
	cp c
	jr nz, .next
	ld a, 99
	sub [hl]
	add b
	ld b, a
	ld a, [wItemQuantityChangeBuffer]
	cp b
	jr z, .ok
	jr c, .ok

.next
	inc hl
	jr .loop

.terminator
	call GetPocketCapacity
	ld a, [de]
	cp c
	jr c, .ok
	and a
	ret

.ok
	ld h, d
	ld l, e
	ld a, [wCurItem]
	ld c, a
	ld a, [wItemQuantityChangeBuffer]
	ld [wItemQuantityBuffer], a
.loop2
	inc hl
	ld a, [hli]
	cp -1
	jr z, .terminator2
	cp c
	jr nz, .loop2
	ld a, [wItemQuantityBuffer]
	add [hl]
	cp 100
	jr nc, .newstack
	ld [hl], a
	jr .done

.newstack
	ld [hl], 99
	sub 99
	ld [wItemQuantityBuffer], a
	jr .loop2

.terminator2
	dec hl
	ld a, [wCurItem]
	ld [hli], a
	ld a, [wItemQuantityBuffer]
	ld [hli], a
	ld [hl], -1
	ld h, d
	ld l, e
	inc [hl]

.done
	scf
	ret

RemoveItemFromPocket: ; d2ff
	ld d, h
	ld e, l
	ld a, [hli]
	ld c, a
	ld a, [wCurItemQuantity]
	cp c
	jr nc, .ok ; memory
	ld c, a
	ld b, $0
	add hl, bc
	add hl, bc
	ld a, [wCurItem]
	cp [hl]
	inc hl
	jr z, .skip
	ld h, d
	ld l, e
	inc hl

.ok
	ld a, [wCurItem]
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr z, .skip
	cp -1
	jr z, .nope
	inc hl
	jr .loop

.skip
	ld a, [wItemQuantityChangeBuffer]
	ld b, a
	ld a, [hl]
	sub b
	jr c, .nope
	ld [hl], a
	ld [wItemQuantityBuffer], a
	and a
	jr nz, .yup
	dec hl
	ld b, h
	ld c, l
	inc hl
	inc hl
.loop2
	ld a, [hli]
	ld [bc], a
	inc bc
	cp -1
	jr nz, .loop2
	ld h, d
	ld l, e
	dec [hl]

.yup
	scf
	ret

.nope
	and a
	ret

CheckTheItem: ; d349
	ld a, [wCurItem]
	ld c, a
.loop
	inc hl
	ld a, [hli]
	cp -1
	jr z, .done
	cp c
	jr nz, .loop
	scf
	ret

.done
	and a
	ret

ReceiveKeyItem: ; d35a
	ld hl, wNumKeyItems
	ld a, [hli]
	cp MAX_KEY_ITEMS
	jr nc, .nope
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurItem]
	ld [hli], a
	ld [hl], -1
	ld hl, wNumKeyItems
	inc [hl]
	scf
	ret

.nope
	and a
	ret

TossKeyItem: ; d374
	ld a, [wCurItemQuantity]
	ld e, a
	ld d, 0
	ld hl, wNumKeyItems
	ld a, [hl]
	cp e
	jr nc, .ok
	call .Toss
	ret nc
	jr .ok2

.ok
	dec [hl]
	inc hl
	add hl, de

.ok2
	ld d, h
	ld e, l
	inc hl
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp -1
	jr nz, .loop
	scf
	ret

.Toss: ; d396
	ld hl, wNumKeyItems
	ld a, [wCurItem]
	ld c, a
.loop3
	inc hl
	ld a, [hl]
	cp c
	jr z, .ok3
	cp -1
	jr nz, .loop3
	xor a
	ret

.ok3
	ld a, [wNumKeyItems]
	dec a
	ld [wNumKeyItems], a
	scf
	ret

CheckKeyItems: ; d3b1
	ld a, [wCurItem]
	ld c, a
	ld hl, wKeyItems
.loop
	ld a, [hli]
	cp c
	jr z, .done
	cp -1
	jr nz, .loop
	and a
	ret

.done
	scf
	ret

_CheckTossableItem:: ; d427
; Return 1 in wItemAttributeParamBuffer and carry if wCurItem can't be removed from the bag.
	ld a, ITEMATTR_PERMISSIONS
	call GetItemAttr
	bit CANT_TOSS_F, a
	jr nz, ItemAttr_ReturnCarry
	and a
	ret

CheckSelectableItem: ; d432
; Return 1 in wItemAttributeParamBuffer and carry if wCurItem can't be selected.
	ld a, ITEMATTR_PERMISSIONS
	call GetItemAttr
	bit CANT_SELECT_F, a
	jr nz, ItemAttr_ReturnCarry
	and a
	ret

CheckItemPocket:: ; d43d
; Return the pocket for wCurItem in wItemAttributeParamBuffer.
	ld a, ITEMATTR_POCKET
	call GetItemAttr
	and $f
	ld [wItemAttributeParamBuffer], a
	ret

CheckItemContext: ; d448
; Return the context for wCurItem in wItemAttributeParamBuffer.
	ld a, ITEMATTR_HELP
	call GetItemAttr
	and $f
	ld [wItemAttributeParamBuffer], a
	ret

CheckItemMenu: ; d453
; Return the menu for wCurItem in wItemAttributeParamBuffer.
	ld a, ITEMATTR_HELP
	call GetItemAttr
	swap a
	and $f
	ld [wItemAttributeParamBuffer], a
	ret

CheckItemParam:
; Return the param for CurItem in wItemAttributeParamBuffer.
	ld a, ITEMATTR_PARAM
	call GetItemAttr
	ld [wItemAttributeParamBuffer], a
	ret

GetItemAttr: ; d460
; Get attribute a of wCurItem.

	push hl
	push bc

	ld hl, ItemAttributes
	ld c, a
	ld b, 0
	add hl, bc

	xor a
	ld [wItemAttributeParamBuffer], a

	ld a, [wCurItem]
	dec a
	ld c, a
	ld a, NUM_ITEMATTRS
	rst AddNTimes
	ld a, BANK(ItemAttributes)
	call GetFarByte

	pop bc
	pop hl
	ret

ItemAttr_ReturnCarry: ; d47f
	ld a, 1
	ld [wItemAttributeParamBuffer], a
	scf
	ret

GetItemPrice: ; d486
; Return the price of wCurItem in de.
	push hl
	push bc
	ld a, ITEMATTR_PRICE
	call GetItemAttr
	ld e, a
	ld a, ITEMATTR_PRICE_HI
	call GetItemAttr
	ld d, a
	pop bc
	pop hl
	ret

_CountItem::
	push hl
	call CheckItemPocket
	pop de
	ld a, [wItemAttributeParamBuffer]
	dec a
	ld hl, .Pockets
	rst JumpTable
	ret

.Pockets:
	dw .Item
	dw .Medicine
	dw .Ball
	dw TMHM_Dummy
	dw .Berry
	dw KeyItem_Dummy

.Item:
	ld hl, wNumItems
	jr CountItemInPocket

.Medicine:
	ld hl, wNumMedicine
	jr CountItemInPocket

.Ball: ; d1fb
	ld hl, wNumBalls
	jr CountItemInPocket

.Berry:
	ld hl, wNumBerries
	; fallthrough

CountItemInPocket:
	inc hl
	ld a, [wCurItem]
	ld d, a
	lb bc, 0, 0
.loop
	ld a, [hli]
	cp -1
	ret z
	cp d
	jr nz, .next
	ld a, [hl]
	add c
	ld c, a
	jr nc, .next
	inc b
.next
	inc hl
	jr .loop
