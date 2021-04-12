SwitchItemsInBag:
	ld a, [wSwitchItem]
	and a
	jr nz, .completeItemSwitch
	ld a, [wScrollingMenuCursorPosition]
	inc a
	ld [wSwitchItem], a
	ret
.completeItemSwitch
	ld b, a
	ld a, [wScrollingMenuCursorPosition]
	inc a
	cp b
	jr nz, .notSwappingItemWithItself
	xor a
	ld [wSwitchItem], a
	ret
.notSwappingItemWithItself
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	ld a, [hl]
	inc a
	ret z
	ld a, [wSwitchItem]
	dec a
	ld [wSwitchItem], a
	call TryCombiningSwitchItems
	jr c, CombineSwitchItems
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld a, [wSwitchItem]
	cp c
	jr c, .insertItemAbove
	call GetSwitchItemDestinationOffset
	push bc
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	dec hl
	push hl
	call ItemSwitch_ConvertSpacingToDW
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	call SwitchItems_BackwardsCopy
	ld a, [wScrollingMenuCursorPosition]
	call CopyBufferedSwitchItemToScrollLocation
	xor a
	ld [wSwitchItem], a
	ret

.insertItemAbove
	call GetSwitchItemDestinationOffset
	push bc
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	call ItemSwitch_ConvertSpacingToDW
	add hl, bc
	pop bc
	rst CopyBytes
	ld a, [wScrollingMenuCursorPosition]
	call CopyBufferedSwitchItemToScrollLocation
	xor a
	ld [wSwitchItem], a
	ret

TryCombiningSwitchItems:
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	ld a, [de]
	cp [hl]
	jr nz, .doNotCombineSwitchItems
	ld a, [wMenuData_ScrollingMenuSpacing]
	cp 2
	jr nz, .doNotCombineSwitchItems
	ld a, [wScrollingMenuCursorPosition]
	call GetQuantityOfSwitchItem
	cp 99
	jr z, .doNotCombineSwitchItems
	ld a, [wSwitchItem]
	call GetQuantityOfSwitchItem
	cp 99
	jr nz, .combineSwitchItems
.doNotCombineSwitchItems
	and a
	ret

.combineSwitchItems
	scf
	ret

CombineSwitchItems:
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	inc hl
	push hl
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	ld a, [hl]
	pop hl
	add [hl]
	cp 100
	jr c, .mergeItemStacks
	sub 99
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	ld [hl], 99
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	inc hl
	pop af
	ld [hl], a
	xor a
	ld [wSwitchItem], a
	ret

.mergeItemStacks
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	pop af
	ld [hl], a
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wSwitchItem]
	cp [hl]
	jr nz, .notCombiningLastItem
	dec [hl]
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	ld [hl], $ff
	xor a
	ld [wSwitchItem], a
	ret

.notCombiningLastItem
	dec [hl]
	call ItemSwitch_ConvertSpacingToDW
	push bc
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	pop bc
	push hl
	add hl, bc
	pop de
.shiftInventoryAboveLoop
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .shiftInventoryAboveLoop
	xor a
	ld [wSwitchItem], a
	ret

CopySwitchItemToBuffer:
	call ItemSwitch_GetNthItem
	ld de, wSwitchItemBuffer
	call ItemSwitch_ConvertSpacingToDW
	rst CopyBytes
	ret

CopyBufferedSwitchItemToScrollLocation:
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	ld hl, wSwitchItemBuffer
	call ItemSwitch_ConvertSpacingToDW
	rst CopyBytes
	ret

ItemSwitch_GetNthItem:
	ld c, a
	ld b, 0
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [wMenuData_ScrollingMenuSpacing]
	rst AddNTimes
	ret

GetSwitchItemDestinationOffset:
	ld a, [wSwitchItem]
	call CopySwitchItemToBuffer
	push hl
	call ItemSwitch_ConvertSpacingToDW
	ld a, [wSwitchItem]
	ld e, a
	ld a, [wScrollingMenuCursorPosition]
	sub e
	jr nc, .dont_negate
	dec a
	cpl
.dont_negate
	ld hl, 0
	rst AddNTimes
	ld b, h
	ld c, l
	pop hl
	ret

ItemSwitch_ConvertSpacingToDW:
	ld a, [wMenuData_ScrollingMenuSpacing]
	ld c, a
	ld b, 0
	ret

GetQuantityOfSwitchItem:
	call ItemSwitch_GetNthItem
	inc hl
	ld a, [hl]
	ret

SwitchItems_BackwardsCopy:
.loop
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

SortItemsInBag:
; Sorts items in the bag.
; wMenuCursorY=1: by name
; wMenuCursorY=2: by type (index order)
	ld a, [wScrollingMenuCursorPosition]
	push af
	xor a
	ld b, a
.outer_loop
	ld a, b
	call GetSortingItemIndex
	ld c, a
	inc a
	jr z, .done
.inner_loop
	inc b
	ld a, b
	call GetSortingItemIndex
	inc a
	jr z, .done
	dec a
	cp c
	ld c, a
	jr nc, .inner_loop
	push bc
	ld a, b
	ld [wScrollingMenuCursorPosition], a
	call SwitchItemsInBag
	pop bc
	push bc
	ld b, 0
.insertion_loop
	ld a, b
	call GetSortingItemIndex
	cp c
	jr nc, .do_sort
	inc b
	jr .insertion_loop
.do_sort
	ld a, b
	ld [wScrollingMenuCursorPosition], a
	call SwitchItemsInBag
	pop bc
	jr .outer_loop
.done
	pop af
	ld [wScrollingMenuCursorPosition], a
	ret

GetSortingItemIndex:
	push bc
	call ItemSwitch_GetNthItem
	ld a, [wMenuCursorY]
	dec a
	jr z, .done
	ld c, [hl]
	inc c
	jr z, .done
	dec c
	ld b, 0
	ld hl, ItemNameOrder
	add hl, bc
.done
	ld a, [hl]
	pop bc
	ret

INCLUDE "data/items/name_order.asm"
