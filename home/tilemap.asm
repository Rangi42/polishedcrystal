ClearPalettes::
; Make all palettes white
	ldh a, [rWBK]
	push af

	ld a, BANK(wBGPals2)
	ldh [rWBK], a

; Fill wBGPals2 and wOBPals2 with $ffff (white)
	ld hl, wBGPals2
if !DEF(MONOCHROME)
	ld bc, 16 palettes
	ld a, $ff ; RGB 31, 31, 31
	rst ByteFill
else
	ld b, (16 palettes) / 2
.mono_loop
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_WHITE)
	ld [hli], a
	dec b
	jr nz, .mono_loop
endc

	pop af
	ldh [rWBK], a

; Request palette update
	ld a, 1
	ldh [hCGBPalUpdate], a
	ret

SetHPPal::
; Set palette at hl for the big-endian HP and max HP at bc.
	push hl
	ld h, b
	ld l, c
	call GetHPPal
	pop hl
	ld [hl], d
	ret

GetHPPal::
; Get palette in d for the big-endian HP and max HP at hl.
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld d, a
	ld e, [hl]
	farcall GetHPPalFromHP
	ret
