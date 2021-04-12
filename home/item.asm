DoItemEffect::
	farjp _DoItemEffect

TossItem::
	push hl
	push de
	push bc
	farcall _TossItem
	jmp PopBCDEHL

ReceiveItem::
	push hl
	push de
	push bc
	farcall _ReceiveItem
	jmp PopBCDEHL

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
	farcall _CheckItem
	jmp PopBCDEHL

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
	push hl
	push de
	farcall _CountItem
	ld a, b
	ld [wBuffer1], a
	ld a, c
	ld [wBuffer2], a
	jmp PopBCDEHL

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
	ld a, [wCurPocket]
	cp TM_HM - 1
	ret z
	cp KEY_ITEM - 1
	ret
