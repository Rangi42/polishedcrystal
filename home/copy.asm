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

Get2bpp::
	ld a, [rLCDC]
	bit 7, a ; lcd on?
	jp nz, Request2bpp

Copy2bpp::
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

	call WriteVCopyRegistersToHRAM
	ld a, [rLY]
	cp $88
	jr c, .handleLoop
.loop
	ld a, [hTilesPerCycle]
	sub 16
	ld [hTilesPerCycle], a
	jr c, .copyRemainingTilesAndExit
	jr nz, .copySixteenTilesAndContinue
.copyRemainingTilesAndExit
	add 16
	ld [hRequested2bpp], a
	xor a
	ld [hTilesPerCycle], a
	call DelayFrame
	ld a, [hRequested2bpp]
	and a
	jr z, .clearTileCountAndFinish
.addUncopiedTilesToCount
	ld b, a
	ld a, [hTilesPerCycle]
	add b
	ld [hTilesPerCycle], a
	xor a
	ld [hRequested2bpp], a
	jr .handleLoop
.clearTileCountAndFinish
	xor a
	ld [hTilesPerCycle], a
	jr .done
.copySixteenTilesAndContinue
	ld a, 16
	ld [hRequested2bpp], a
	call DelayFrame
	ld a, [hRequested2bpp]
	and a
	jr nz, .addUncopiedTilesToCount
.handleLoop
	call HBlankCopy2bpp
	jr c, .loop
.done
	pop af
	rst Bankswitch

	pop af
	ld [hBGMapMode], a
	ret

Get1bpp:: ; f9d
	ld a, [rLCDC]
	bit 7, a ; lcd on?
	jr nz, Request1bpp

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

	call WriteVCopyRegistersToHRAM
	ld a, [rLY]
	cp $88
	jr c, .handleLoop
.loop
	ld a, [hTilesPerCycle]
	sub 16
	ld [hTilesPerCycle], a
	jr c, .copyRemainingTilesAndExit
	jr nz, .copySixteenTilesAndContinue
.copyRemainingTilesAndExit
	add 16
	ld [hTilesPerCycle], a
	xor a
	ld [hTilesPerCycle], a
	call DelayFrame
	ld a, [hRequested1bpp]
	and a
	jr z, .clearTileCountAndFinish
.addUncopiedTilesToCount
	ld b, a
	ld a, [hTilesPerCycle]
	add b
	ld [hTilesPerCycle], a
	xor a
	ld [hRequested1bpp], a
	jr .handleLoop
.clearTileCountAndFinish
	xor a
	ld [hTilesPerCycle], a
	jr .done
.copySixteenTilesAndContinue
	ld a, 16
	ld [hRequested1bpp], a
	call DelayFrame
	ld a, [hRequested1bpp]
	and a
	jr nz, .addUncopiedTilesToCount
.handleLoop
	call HBlankCopy1bpp
	jr c, .loop
.done
	pop af
	rst Bankswitch

	pop af
	ld [hBGMapMode], a
	ret

HBlankCopy2bpp::
	di
	ld [hSPBuffer], sp
	ld hl, hRequestedVTileDest
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a ; destination

	ld a, [hli] ; source
	ld h, [hl]
	ld l, a
	ld sp, hl ; set source to sp
	ld a, h ; save source high byte for later
	ld h, d ; exchange hl and de
	ld l, e
; vram to vram copy check:
	cp VTiles0 / $100 ; is source in RAM?
	jr c, .innerLoop
	cp SRAM_Begin / $100 ; is source past VRAM
	jr nc, .innerLoop
	lb bc, %11, rSTAT & $ff ; predefine bitmask and rSTAT source for speed and size
	jr .waitNoHBlank2
.outerLoop2
	ld a, [rLY]
	cp $88
	jp nc, ContinueHBlankCopy
.waitNoHBlank2
	ld a, [$ff00+c]
	and b
	jr z, .waitNoHBlank2
.waitHBlank2
	ld a, [$ff00+c]
	and b
	jr nz, .waitHBlank2
	rept 7
	pop de
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	endr
	pop de
	ld a, e
	ld [hli], a
	ld [hl], d
	inc hl
	ld a, l
	and $f
	jr nz, .waitNoHBlank2
	ld a, [hTilesPerCycle]
	dec a
	ld [hTilesPerCycle], a
	jr nz, .outerLoop2
	jp DoneHBlankCopy
.outerLoop
	ld a, [rLY]
	cp $88
	jp nc, ContinueHBlankCopy
.innerLoop
	pop bc
	pop de
.waitNoHBlank
	ld a, [rSTAT]
	and 3
	jr z, .waitNoHBlank
.waitHBlank
	ld a, [rSTAT]
	and 3
	jr nz, .waitHBlank
; preloads r us
	ld a, c ; 1
	ld [hli], a ; 3
	ld a, b ; 4
	ld [hli], a ; 6
	ld a, e ; 7
	ld [hli], a ; 9
	ld a, d ; 10
	ld [hli], a ; 12
	rept 5
	pop de
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	endr ; 47 (12 + 7 * 5)
	pop de ; 50
	ld a, e ; 51
	ld [hli], a ; 53
	ld [hl], d ; 55
	inc hl
	ld a, [hTilesPerCycle]
	dec a
	ld [hTilesPerCycle], a
	jr nz, .outerLoop
	jp DoneHBlankCopy

HBlankCopy1bpp:
	di
	ld [hSPBuffer], sp
	ld hl, hRequestedVTileDest
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a

	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld sp, hl
	ld h, d
	ld l, e
	jr .innerLoop

.outerLoop
	ld a, [rLY]
	cp $88
	jr nc, ContinueHBlankCopy
.innerLoop
	pop bc
	pop de
.waithblank2
	ld a, [rSTAT]
	and 3
	jr z, .waithblank2
.waithblank
	ld a, [rSTAT]
	and 3
	jr nz, .waithblank
	ld a, c
	ld [hli], a
	ld [hli], a
	ld a, b
	ld [hli], a
	ld [hli], a
	ld a, e
	ld [hli], a
	ld [hli], a
	ld a, d
	ld [hli], a
	ld [hli], a
	rept 2
	pop de
	ld a, e
	ld [hli], a
	ld [hli], a
	ld a, d
	ld [hli], a
	ld [hli], a
	endr
	ld a, [hTilesPerCycle]
	dec a
	ld [hTilesPerCycle], a
	jr nz, .outerLoop
	jr DoneHBlankCopy

ContinueHBlankCopy:
	ld [hRequestedVTileSource], sp
	ld sp, hl
	ld [hRequestedVTileDest], sp
	scf
DoneHBlankCopy:
	ld a, [hSPBuffer]
	ld l, a
	ld a, [hSPBuffer + 1]
	ld h, a
	ld sp, hl
	reti

WriteVCopyRegistersToHRAM:
	ld a, e
	ld [hRequestedVTileSource], a
	ld a, d
	ld [hRequestedVTileSource + 1], a
	ld a, l
	ld [hRequestedVTileDest], a
	ld a, h
	ld [hRequestedVTileDest + 1], a
	ld a, c
	ld [hTilesPerCycle], a
	ret


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
