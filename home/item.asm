DoItemEffect:: ; 2f3f
	farjp _DoItemEffect
; 2f46

CheckTossableItem:: ; 2f46
	push hl
	push de
	push bc
	farcall _CheckTossableItem
	pop bc
	pop de
	pop hl
	ret
; 2f53

TossItem:: ; 2f53
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
; 2f66

ReceiveItem:: ; 2f66
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
; 2f79

ReceiveTMHM:: ; d3c4
	ld a, [CurTMHM]
	ld e, a
	ld d, 0
	ld b, SET_FLAG
	ld hl, TMsHMs
	call FlagAction
	scf
	ret

CheckItem:: ; 2f79
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
; 2f8c

CheckTMHM:: ; d3fb
	ld a, [CurTMHM]
	ld e, a
	ld d, 0
	ld b, CHECK_FLAG
	ld hl, TMsHMs
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
	ld [Buffer1], a
	ld a, c
	ld [Buffer2], a

	pop de
	pop hl
	pop bc
	ld a, b
	rst Bankswitch
	pop bc
	ret
