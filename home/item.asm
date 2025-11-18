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
_CheckTMHM::
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
; Adds the key item if not already obtained, and shifts the terminator.
	; This also leaves registers in such a way that we can append it directly.
	call CheckKeyItem
	ccf
	ret nc
	ld [hld], a
	ld [hl], e
	scf
	ret

TossKeyItem::
; Tosses the key item if found and shifts everything backwards.
	ld a, [wCurKeyItem]
	ld e, a
	ld hl, wKeyItems
.loop
	ld d, h
	ld a, [hli]
	and a
	ret z
	cp e
	jr nz, .loop
	ld e, l
	dec e
.loop2
	ld a, [hli]
	ld [de], a
	inc de
	and a
	jr nz, .loop2
	scf
	ret

CheckKeyItem::
; Returns carry if we found the key item.
	ld a, [wCurKeyItem]
_CheckKeyItem::
	ld e, a
	ld hl, wKeyItems
.loop
	ld a, [hli]
	cp e
	scf
	ret z
	and a
	jr nz, .loop
	ret

CheckUniqueItemPocket::
	ld a, [wCurPocket]
	cp TM_HM - 1
	ret z
	cp KEY_ITEM - 1
	ret
