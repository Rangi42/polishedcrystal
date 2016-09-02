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

Function3eea:: ; 3eea
	push hl
	push bc
	ld de, AttrMap - TileMap
	add hl, de
	inc b
	inc b
	inc c
	inc c
	call Function3f35
	pop bc
	pop hl
	call MobileHome_PlaceBox
	ret
; 3efd

Function3f35:: ; 3f35
	ld a, 6
	ld de, SCREEN_WIDTH
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	add hl, de
	pop bc
	dec b
	jr nz, .row
	ret
; 3f47

MobileHome_PlaceBox: ; 3f47
	push bc
	call .FillTop
	pop bc
.RowLoop:
	push bc
	call .FillMiddle
	pop bc
	dec b
	jr nz, .RowLoop
	call .FillBottom
	ret
; 3f58

.FillTop:
	ld a, $63
	ld d, $62
	ld e, $64
	jr .FillRow

.FillBottom:
	ld a, $68
	ld d, $67
	ld e, $69
	jr .FillRow

.FillMiddle:
	ld a, $7f
	ld d, $65
	ld e, $66

.FillRow:
	push hl
	ld [hl], d
	inc hl
.FillLoop:
	ld [hli], a
	dec c
	jr nz, .FillLoop
	ld [hl], e
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	ret
; 3f7c
