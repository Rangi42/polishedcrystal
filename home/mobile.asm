MobileReceive:: ; 3e80
	ld a, [hROMBank]
	push af
	ld a, BANK(_MobileReceive)
	ld [$c981], a
	rst Bankswitch

	call _MobileReceive
	pop bc
	ld a, b
	ld [$c981], a
	rst Bankswitch

	ret
; 3e93

Timer:: ; 3e93
	push af
	push bc
	push de
	push hl

	ld a, [hMobile]
	and a
	jr z, .pop_ret

	xor a
	ld [rTAC], a

; Turn off timer interrupt
	ld a, [rIF]
	and 1 << VBLANK | 1 << LCD_STAT | 1 << SERIAL | 1 << JOYPAD
	ld [rIF], a

	ld a, [$c86a]
	or a
	jr z, .pop_ret

	ld a, [$c822]
	bit 1, a
	jr nz, .skip_Timer

	ld a, [rSC]
	and 1 << rSC_ON
	jr nz, .skip_Timer

	ld a, [hROMBank]
	push af
	ld a, BANK(_Timer)
	ld [$c981], a
	rst Bankswitch

	call _Timer

	pop bc
	ld a, b
	ld [$c981], a
	rst Bankswitch

.skip_Timer
	ld a, [rTMA]
	ld [rTIMA], a

	ld a, 1 << rTAC_ON | rTAC_65536_HZ
	ld [rTAC], a

.pop_ret
	pop hl
	pop de
	pop bc
	pop af
	reti
; 3ed7
