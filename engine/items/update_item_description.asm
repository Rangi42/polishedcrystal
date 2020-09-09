UpdateItemDescriptionAndBagQuantity:
	hlcoord 1, 1
	lb bc, 1, 8
	call ClearBox
	ld a, [wMenuSelection]
	cp -1
	jr z, UpdateItemDescription
	hlcoord 1, 1
	ld de, BagXString
	rst PlaceString
	ld a, [wMenuSelection]
	call GetQuantityInBag
	hlcoord 6, 1
	ld de, wBuffer1
	lb bc, 2, 3
	call PrintNum
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

BagXString:
	db "Bag ×@"

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
	; ld a, [wMenuSelection]
	; cp -1
	; ret z
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
