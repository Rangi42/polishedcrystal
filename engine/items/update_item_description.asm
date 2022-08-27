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
	assert " " < $80 && "0" >= $80
	add a ; overflows iff a == " "
	jr nc, .print_x
	dec hl
.print_x
	ld [hl], "×"
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
