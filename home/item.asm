DoItemEffect::
	farjp _DoItemEffect

TossItem::
	push hl
	push de
	push bc
	ld a, [hROMBank]
	push af
	ld a, BANK(_TossItem)
	rst Bankswitch

	call _TossItem

	pop bc
	ld a, b
	rst Bankswitch
	pop bc
	pop de
	pop hl
	ret

ReceiveItem::
	push bc
	ld a, [hROMBank]
	push af
	ld a, BANK(_ReceiveItem)
	rst Bankswitch
	push hl
	push de

	call _ReceiveItem

	pop de
	pop hl
	pop bc
	ld a, b
	rst Bankswitch
	pop bc
	ret

ReceiveTMHM::
	ld a, [wCurTMHM]
	ld e, a
	ld d, 0
	ld b, SET_FLAG
	ld hl, wTMsHMs
	call FlagAction
	scf
	ret

CheckItem::
	push hl
	push de
	push bc
	ld a, [hROMBank]
	push af
	ld a, BANK(_CheckItem)
	rst Bankswitch

	call _CheckItem

	pop bc
	ld a, b
	rst Bankswitch
	pop bc
	pop de
	pop hl
	ret

CheckTMHM::
	ld a, [wCurTMHM]
	ld e, a
	ld d, 0
	ld b, CHECK_FLAG
	ld hl, wTMsHMs
	call FlagAction
	ret z
	scf
	ret

CountItem::
	push bc
	ld a, [hROMBank]
	push af
	ld a, BANK(_CountItem)
	rst Bankswitch
	push hl
	push de

	call _CountItem
	ld a, b
	ld [wBuffer1], a
	ld a, c
	ld [wBuffer2], a

	pop de
	pop hl
	pop bc
	ld a, b
	rst Bankswitch
	pop bc
	ret

ReceiveKeyItem::
	ld a, [wCurKeyItem]
	ld e, a
	ld d, 0
	ld b, SET_FLAG
	ld hl, wKeyItems
	call FlagAction
	scf
	ret

TossKeyItem::
	ld a, [wCurKeyItem]
	ld e, a
	ld d, 0
	ld b, RESET_FLAG
	ld hl, wKeyItems
	call FlagAction
	scf
	ret

CheckKeyItem::
	ld a, [wCurKeyItem]
	ld e, a
	ld d, 0
	ld b, CHECK_FLAG
	ld hl, wKeyItems
	call FlagAction
	ret z
	scf
	ret

CheckUniqueItemPocket::
	ld a, [wCurrPocket]
	cp TM_HM - 1
	ret z
	cp KEY_ITEM - 1
	ret
