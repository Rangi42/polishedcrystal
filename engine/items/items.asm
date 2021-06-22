_ReceiveItem::
	call DoesHLEqualNumItems
	jmp nz, PutItemInPocket
	push hl
	call CheckItemPocket
	pop de
	ld a, [wItemAttributeParamBuffer]
	dec a
	call StackJumpTable

.Pockets:
	dw .Item
	dw .Medicine
	dw .Ball
	dw DoNothing
	dw .Berry
	dw DoNothing

.Item:
	ld hl, wNumItems
	jmp PutItemInPocket

.Medicine:
	ld hl, wNumMedicine
	jmp PutItemInPocket

.Ball:
	ld hl, wNumBalls
	jmp PutItemInPocket

.Berry:
	ld hl, wNumBerries
	jmp PutItemInPocket

_TossItem::
	call DoesHLEqualNumItems
	jr nz, .remove
	push hl
	call CheckItemPocket
	pop de
	ld a, [wItemAttributeParamBuffer]
	dec a
	call StackJumpTable

.Pockets:
	dw .Item
	dw .Medicine
	dw .Ball
	dw DoNothing
	dw .Berry
	dw DoNothing

.Medicine:
	ld hl, wNumMedicine
	jmp RemoveItemFromPocket

.Ball:
	ld hl, wNumBalls
	jmp RemoveItemFromPocket

.Berry:
	ld hl, wNumBerries
	jmp RemoveItemFromPocket

.Item:
	ld h, d
	ld l, e
.remove
	jmp RemoveItemFromPocket

_CheckItem::
	call DoesHLEqualNumItems
	jr nz, .nope
	push hl
	call CheckItemPocket
	pop de
	ld a, [wItemAttributeParamBuffer]
	dec a
	call StackJumpTable

.Pockets:
	dw .Item
	dw .Medicine
	dw .Ball
	dw DoNothing
	dw .Berry
	dw DoNothing

.Medicine:
	ld hl, wNumMedicine
	jmp CheckTheItem

.Ball:
	ld hl, wNumBalls
	jmp CheckTheItem

.Berry:
	ld hl, wNumBerries
	jmp CheckTheItem

.Item:
	ld h, d
	ld l, e
.nope
	jmp CheckTheItem

DoesHLEqualNumItems:
	ld a, l
	cp LOW(wNumItems)
	ret nz
	ld a, h
	cp HIGH(wNumItems)
	ret

GetPocketCapacity:
	ld c, MAX_ITEMS
	ld a, e
	cp LOW(wNumItems)
	jr nz, .not_items
	ld a, d
	cp HIGH(wNumItems)
	ret z

.not_items:
	ld c, MAX_MEDICINE
	ld a, e
	cp LOW(wNumMedicine)
	jr nz, .not_medicine
	ld a, d
	cp HIGH(wNumMedicine)
	ret z

.not_medicine:
	ld c, MAX_BALLS
	ld a, e
	cp LOW(wNumBalls)
	jr nz, .not_balls
	ld a, d
	cp HIGH(wNumBalls)
	ret z

.not_balls:
	ld c, MAX_BERRIES
	ld a, e
	cp LOW(wNumBerries)
	jr nz, .not_berries
	ld a, d
	cp HIGH(wNumBerries)
	ret z

.not_berries:
	ld c, MAX_PC_ITEMS
	ret

PutItemInPocket:
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

RemoveItemFromPocket:
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

CheckTheItem:
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

CheckSelectableKeyItem:
; Return 1 in wItemAttributeParamBuffer and carry if wCurKeyItem can be selected.
	ld a, KEYITEMATTR_PERMISSIONS
	call GetKeyItemAttr
	and a
	ret z
	ld a, 1
	ld [wItemAttributeParamBuffer], a
	scf
	ret

CheckItemPocket::
; Return the pocket for wCurItem in wItemAttributeParamBuffer.
	ld a, ITEMATTR_POCKET
	call GetItemAttr
	and $f
	ld [wItemAttributeParamBuffer], a
	ret

CheckItemContext:
; Return the context for wCurItem in wItemAttributeParamBuffer.
	ld a, ITEMATTR_HELP
	call GetItemAttr
	and $f
	ld [wItemAttributeParamBuffer], a
	ret

CheckKeyItemContext:
	ld a, KEYITEMATTR_HELP
	call GetKeyItemAttr
	and $f
	ld [wItemAttributeParamBuffer], a
	ret

CheckItemMenu:
; Return the menu for wCurItem in wItemAttributeParamBuffer.
	ld a, ITEMATTR_HELP
	call GetItemAttr
	swap a
	and $f
	ld [wItemAttributeParamBuffer], a
	ret

CheckKeyItemMenu:
	ld a, KEYITEMATTR_HELP
	call GetKeyItemAttr
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

GetItemAttr:
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
	ld a, ITEMATTR_STRUCT_LENGTH
	rst AddNTimes
	ld a, BANK(ItemAttributes)
	call GetFarByte

	pop bc
	pop hl
	ret

GetKeyItemAttr:
	push hl
	push bc

	ld hl, KeyItemAttributes
	ld c, a
	ld b, 0
	add hl, bc

	xor a
	ld [wItemAttributeParamBuffer], a

	ld a, [wCurKeyItem]
	dec a
	ld c, a
	ld a, KEYITEMATTR_STRUCT_LENGTH
	rst AddNTimes
	ld a, BANK(KeyItemAttributes)
	call GetFarByte

	pop bc
	pop hl
	ret

GetItemPrice:
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
	call StackJumpTable

.Pockets:
	dw .Item
	dw .Medicine
	dw .Ball
	dw DoNothing
	dw .Berry
	dw DoNothing

.Item:
	ld hl, wNumItems
	jr CountItemInPocket

.Medicine:
	ld hl, wNumMedicine
	jr CountItemInPocket

.Ball:
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
	; bc += a
	add c
	ld c, a
	adc b
	sub c
	ld b, a
.next
	inc hl
	jr .loop
