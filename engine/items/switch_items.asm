DoPackInsertSort:
	ld [wScrollingMenuCursorPosition], a
	ld a, b
	inc a
	ld [wSwitchItem], a
	; fallthrough
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
	call ScrollingMenu_GetNthItem
	ld a, [hl]
	call ScrollingMenu_IsTerminator
	ret z
	ld hl, wSwitchItem
	dec [hl]
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
	call ScrollingMenu_GetNthItem
	dec hl
	push hl
	call ItemSwitch_GetMenuSpacing
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
	call ScrollingMenu_GetNthItem
	ld d, h
	ld e, l
	call ItemSwitch_GetMenuSpacing
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
	call ScrollingMenu_GetNthItem
	ld d, h
	ld e, l
	ld a, [wScrollingMenuCursorPosition]
	call ScrollingMenu_GetNthItem
	ld a, [de]
	cp [hl]
	jr nz, .doNotCombineSwitchItems
	ld a, [wMenuData_ScrollingMenuSpacing]
	cp SCROLLINGMENU_ITEMS_QUANTITY
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
	call ScrollingMenu_GetNthItem
	inc hl
	push hl
	ld a, [wScrollingMenuCursorPosition]
	call ScrollingMenu_GetNthItem
	inc hl
	ld a, [hl]
	pop hl
	add [hl]
	cp 100
	jr c, .mergeItemStacks
	sub 99
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ScrollingMenu_GetNthItem
	inc hl
	ld [hl], 99
	ld a, [wSwitchItem]
	call ScrollingMenu_GetNthItem
	inc hl
	pop af
	ld [hl], a
	xor a
	ld [wSwitchItem], a
	ret

.mergeItemStacks
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ScrollingMenu_GetNthItem
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
	call ScrollingMenu_GetNthItem
	ld [hl], $ff
	xor a
	ld [wSwitchItem], a
	ret

.notCombiningLastItem
	dec [hl]
	call ItemSwitch_GetMenuSpacing
	push bc
	ld a, [wSwitchItem]
	call ScrollingMenu_GetNthItem
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
	call ScrollingMenu_GetNthItem
	ld de, wSwitchItemBuffer
	call ItemSwitch_GetMenuSpacing
	rst CopyBytes
	ret

CopyBufferedSwitchItemToScrollLocation:
	call ScrollingMenu_GetNthItem
	ld d, h
	ld e, l
	ld hl, wSwitchItemBuffer
	call ItemSwitch_GetMenuSpacing
	rst CopyBytes
	ret

GetSwitchItemDestinationOffset:
	ld a, [wSwitchItem]
	call CopySwitchItemToBuffer
	push hl
	call ItemSwitch_GetMenuSpacing
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

ItemSwitch_GetMenuSpacing:
	ld a, [wMenuData_ScrollingMenuSpacing]
	assert SCROLLINGMENU_ITEMS_QUANTITY == 2
	ld bc, SCROLLINGMENU_ITEMS_QUANTITY
	cp c
	ret z
	dec c
	ret

GetQuantityOfSwitchItem:
	call ScrollingMenu_GetNthItem
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
	ld hl, GetSortingItemIndex
	ld de, DoPackInsertSort
	jmp SortItems

GetSortingItemIndex:
	ld a, b
	push hl
	push bc
	call ScrollingMenu_GetNthItem
	ld c, [hl]

	; If we're dealing with key items, we still want a terminator of -1.
	; To simplify handling, just decrement key item indices by 1.
	ld a, [wCurPocket]
	cp KEY_ITEM - 1
	ld hl, ItemNameOrder
	jr nz, .got_item_data
	ld hl, KeyItemNameOrder
	dec c
.got_item_data
	; If we're sorting by index, c has our desired value.
	ld a, [wMenuCursorY]
	dec a
	ld a, c
	jr z, .done

	; If c is -1 (terminator), return it directly. We can't rely on
	; NameOrder ending with a terminator, because we don't have 255
	; key items, in case we're dealing with those.
	inc c
	jr z, .done

	; Otherwise, reference the desired return index from NameOrder.
	dec c
	ld b, 0
	add hl, bc
	ld a, [hl]
.done
	pop bc
	pop hl
	ret

INCLUDE "data/items/name_order.asm"
