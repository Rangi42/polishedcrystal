UpdateItemDescriptionAndBagQuantity:
	hlcoord 1, 1
	lb bc, 1, 8
	call ClearBox
	ld a, [wMenuSelection]
	cp -1
	jr z, UpdateItemDescription
	hlcoord 1, 1
	ld de, BagString
	rst PlaceString
	ld a, [wMenuSelection]
	call GetQuantityInBag
	hlcoord 5, 1
	push hl
	ld de, wBuffer1
	lb bc, 2, 4
	call PrintNum
	pop hl
	; "Bag ×  9", "Bag × 99" "Bag ×999", or "Bag×9999"
	ld a, [hl]
	assert ' ' < $80 && '0' >= $80
	add a ; overflows iff a == ' '
	jr nc, .print_x
	dec hl
.print_x
	ld [hl], '×'
UpdateItemDescription:
	ld a, [wMenuSelection]
	ld [wCurSpecies], a
	hlcoord 0, 12
	lb bc, 4, SCREEN_WIDTH - 2
	call Textbox
	ld a, [wMenuSelection]
	cp -1
	ret z
	decoord 1, 14
	farjp PrintItemDescription

BagString:
	db "Bag @"

UpdateExpCandyDescriptionAndBagQuantity:
	hlcoord 1, 1
	lb bc, 1, 8
	call ClearBox
	ld a, [wMenuSelection]
	cp -1
	jr z, UpdateExpCandyDescription
	hlcoord 1, 1
	ld de, BagString
	rst PlaceString
	ld a, [wMenuSelection]
	call GetExpCandyQuantity
	hlcoord 5, 1
	push hl
	ld de, wBuffer1
	lb bc, 2, 4
	call PrintNum
	pop hl
	; "Bag ×  9", "Bag × 99" "Bag ×999", or "Bag×9999"
	ld a, [hl]
	assert ' ' < $80 && '0' >= $80
	add a ; overflows iff a == ' '
	jr nc, .print_x
	dec hl
.print_x
	ld [hl], '×'
UpdateExpCandyDescription:
	ld a, [wMenuSelection]
	ld [wCurSpecies], a
	hlcoord 0, 12
	lb bc, 4, SCREEN_WIDTH - 2
	call Textbox
	ld a, [wMenuSelection]
	cp -1
	ret z
	decoord 1, 14
	farjp PrintExpCandyDescription

UpdateTMHMDescriptionAndOwnership:
	hlcoord 1, 1
	lb bc, 1, 8
	call ClearBox
	ld a, [wMenuSelection]
	cp -1
	jr z, UpdateTMHMDescription
	ld a, [wCurTMHM]
	call CheckTMHM
	ld de, OwnedTMString
	jr c, .GotString
	ld de, UnownedTMString
.GotString
	hlcoord 1, 1
	rst PlaceString
UpdateTMHMDescription:
	ld a, [wMenuSelection]
	ld [wCurSpecies], a
	hlcoord 0, 12
	lb bc, 4, SCREEN_WIDTH - 2
	call Textbox
	ld a, [wMenuSelection]
	cp -1
	ret z
	decoord 1, 14
	farjp PrintTMHMDescription

OwnedTMString:
	db "Owned@"
UnownedTMString:
	db "Unowned@"

UpdateKeyItemDescription:
	hlcoord 0, 12
	lb bc, 4, SCREEN_WIDTH - 2
	call Textbox
	ld a, [wMenuSelection]
	and a
	ret z
	decoord 1, 14
	farjp PrintKeyItemDescription

GetQuantityInBag:
	ld a, [wCurItem]
	push af
	ld a, [wMenuSelection]
	ld [wCurItem], a
	call CountItem
	pop af
	ret

GetExpCandyQuantity:
	ld a, [wMenuSelection]
	dec a
	ld hl, wCandyAmounts
	ld d, 0
	ld e, a
	add hl, de
	xor a
	ld [wBuffer1], a
	ld a, [hl]
	ld [wBuffer2], a
	ret
