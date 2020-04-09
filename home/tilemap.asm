SetPalettes::
; Inits the Palettes
; depending on the system the monochromes palettes or color palettes
	push de
	ld a, %11100100
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	call DmgToCgbObjPals
	pop de
	ret

ClearPalettes::
; Make all palettes white
	ldh a, [rSVBK]
	push af

	ld a, BANK(wBGPals2)
	ldh [rSVBK], a

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
	ldh [rSVBK], a

; Request palette update
	ld a, 1
	ldh [hCGBPalUpdate], a
	ret

SetHPPal::
; Set palette for hp bar pixel length e at hl.
	call GetHPPal
	ld [hl], d
	ret

GetHPPal::
; Get palette for hp bar pixel length e in d.
	ld d, HP_GREEN
	ld a, e
	cp 25
	ret nc
	inc d ; HP_YELLOW
	cp 10
	ret nc
	inc d ; HP_RED
	ret
