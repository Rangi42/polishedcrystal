; Functions to copy data from ROM.


Get2bpp_2:: ; dc9
	ld a, [rLCDC]
	bit 7, a ; lcd on?
	jp z, Copy2bpp
	homecall _Get2bpp
	ret
; ddc

Get1bpp_2:: ; ddc
	ld a, [rLCDC]
	bit 7, a ; lcd on?
	jp z, Copy1bpp
	homecall _Get1bpp
	ret
; def

ReplaceKrisSprite:: ; e4a
	farjp _ReplaceKrisSprite
; e51

LoadStandardFont:: ; e51
	farjp _LoadStandardFont
; e58

LoadFontsBattleExtra:: ; e58
	farjp _LoadFontsBattleExtra
; e5f

LoadFontsExtra:: ; e5f
	farjp LoadFrame
; e6c

DecompressRequest2bpp:: ; e73
	push de
	ld a, BANK(sScratch)
	call GetSRAMBank
	push bc

	ld de, sScratch
	ld a, b
	call FarDecompress

	pop bc
	pop hl

	ld de, sScratch
	call Request2bpp
	jp CloseSRAM
; e8d



FarCopyBytes:: ; e8d
; copy bc bytes from a:hl to de
	ld [hBuffer], a
	homecall CopyBytes, [hBuffer]
	ret
; 0xe9b


FarCopyBytesDouble:: ; e9b
; Copy bc bytes from a:hl to bc*2 bytes at de,
; doubling each byte in the process.

	ld [hBuffer], a
	ld a, [hROMBank]
	push af
	ld a, [hBuffer]
	rst Bankswitch

; switcheroo, de <> hl
	ld a, h
	ld h, d
	ld d, a
	ld a, l
	ld l, e
	ld e, a

	inc b
	inc c
	jr .dec

.loop
	ld a, [de]
	inc de
	ld [hli], a
	ld [hli], a
.dec
	dec c
	jr nz, .loop
	dec b
	jr nz, .loop

	pop af
	rst Bankswitch
	ret
; 0xeba


Request2bpp:: ; eba
; Load 2bpp at b:de to occupy c tiles of hl.
	ld a, [hBGMapMode]
	push af
	xor a
	ld [hBGMapMode], a

	ld a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch

	ld a, [hTilesPerCycle]
	push af
	ld a, $8
	ld [hTilesPerCycle], a

	ld a, e
	ld [Requested2bppSource], a
	ld a, d
	ld [Requested2bppSource + 1], a
	ld a, l
	ld [Requested2bppDest], a
	ld a, h
	ld [Requested2bppDest + 1], a
.loop
	ld a, c
	ld hl, hTilesPerCycle
	cp [hl]
	jr nc, .iterate

	ld [Requested2bpp], a
.wait
	call DelayFrame
	ld a, [Requested2bpp]
	and a
	jr nz, .wait

	pop af
	ld [hTilesPerCycle], a

	pop af
	rst Bankswitch

	pop af
	ld [hBGMapMode], a
	ret

.iterate
	ld a, [hTilesPerCycle]
	ld [Requested2bpp], a

.wait2
	call DelayFrame
	ld a, [Requested2bpp]
	and a
	jr nz, .wait2

	ld a, c
	ld hl, hTilesPerCycle
	sub [hl]
	ld c, a
	jr .loop
; f1e


Request1bpp:: ; f1e
; Load 1bpp at b:de to occupy c tiles of hl.
	ld a, [hBGMapMode]
	push af
	xor a
	ld [hBGMapMode], a

	ld a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch

	ld a, [hTilesPerCycle]
	push af

	ld a, $8
	ld [hTilesPerCycle], a
	ld a, e
	ld [Requested1bppSource], a
	ld a, d
	ld [Requested1bppSource + 1], a
	ld a, l
	ld [Requested1bppDest], a
	ld a, h
	ld [Requested1bppDest + 1], a
.loop
	ld a, c
	ld hl, hTilesPerCycle
	cp [hl]
	jr nc, .iterate

	ld [Requested1bpp], a
.wait
	call DelayFrame
	ld a, [Requested1bpp]
	and a
	jr nz, .wait

	pop af
	ld [hTilesPerCycle], a

	pop af
	rst Bankswitch

	pop af
	ld [hBGMapMode], a
	ret

.iterate
	ld a, [hTilesPerCycle]
	ld [Requested1bpp], a

.wait2
	call DelayFrame
	ld a, [Requested1bpp]
	and a
	jr nz, .wait2

	ld a, c
	ld hl, hTilesPerCycle
	sub [hl]
	ld c, a
	jr .loop
; f82


Get2bpp:: ; f82
	ld a, [rLCDC]
	bit 7, a ; lcd on?
	jp nz, Request2bpp

Copy2bpp:: ; f89
; copy c 2bpp tiles from b:de to hl

	push hl
	ld h, d
	ld l, e
	pop de

; bank
	ld a, b

; bc = c * $10
	push af
	swap c
	ld a, $f
	and c
	ld b, a
	ld a, $f0
	and c
	ld c, a
	pop af

	jp FarCopyBytes
; f9d


Get1bpp:: ; f9d
	ld a, [rLCDC]
	bit 7, a ; lcd on?
	jp nz, Request1bpp

Copy1bpp:: ; fa4
; copy c 1bpp tiles from b:de to hl

	push de
	ld d, h
	ld e, l

; bank
	ld a, b

; bc = c * $10 / 2
	push af
	ld h, 0
	ld l, c
	add hl, hl
	add hl, hl
	add hl, hl
	ld b, h
	ld c, l
	pop af

	pop hl
	jp FarCopyBytesDouble
; fb6


GetOpaque1bpp_2::
; Two bytes in VRAM define eight pixels (2 bits/pixel)
; Bits are paired from the bytes, e.g. %ABCDEFGH %abcdefgh defines pixels
; %Aa, %Bb, %Cc, %Dd, %Ee, %Ff, %Gg, %Hh
; %00 = white, %11 = black, %10 = light, %01 = dark
	ld a, [rLCDC]
	bit 7, a ; lcd on?
	jr z, .CopyOpaque1bpp
	homecall _GetOpaque1bpp
	ret

.CopyOpaque1bpp:
; copy c 1bpp tiles from b:de to hl

	push de
	ld d, h
	ld e, l

; bank
	ld a, b

; bc = c * $10 / 2
	push af
	ld h, 0
	ld l, c
	add hl, hl
	add hl, hl
	add hl, hl
	ld b, h
	ld c, l
	pop af

	pop hl
	; fallthrough

FarCopyOpaqueBytesDouble::
; Copy bc bytes from a:hl to bc*2 bytes at de,
; writing $ff before each byte in the process.

	ld [hBuffer], a
	ld a, [hROMBank]
	push af
	ld a, [hBuffer]
	rst Bankswitch

; switcheroo, de <> hl
	ld a, h
	ld h, d
	ld d, a
	ld a, l
	ld l, e
	ld e, a

	inc b
	inc c
	jr .dec

.loop
	ld a, [de]
	inc de
	ld [hl], $ff
	inc hl
	ld [hli], a
.dec
	dec c
	jr nz, .loop
	dec b
	jr nz, .loop

	pop af
	rst Bankswitch
	ret
