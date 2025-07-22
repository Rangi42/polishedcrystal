; Functions to fade the screen in and out.

SetBlackPals::
	ld a, BANK(wBGPals1)
	call StackCallInWRAMBankA

.Function:
if !DEF(MONOCHROME)
	xor a
else
	ld bc, PAL_MONOCHROME_BLACK
endc
	jr DoSetPals

SetWhitePals::
	ld a, BANK(wBGPals1)
	call StackCallInWRAMBankA

.Function:
if !DEF(MONOCHROME)
	ld a, $ff
else
	ld bc, PAL_MONOCHROME_WHITE
endc
DoSetPals:
	ld hl, wBGPals1
if !DEF(MONOCHROME)
	ld bc, 16 palettes
	rst ByteFill
else
	ld a, 16 * PAL_COLORS
.loop
	ld [hl], c ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], b ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	dec a
	jr nz, .loop
endc
	ret

;FadeBGPalettes::
;	ld a, PALFADE_BG
;	ld [wPalFadeMode], a
;	jr DoFadePalettes

;FadeOBPalettes::
;	ld a, PALFADE_OBJ
;	ld [wPalFadeMode], a
;	jr DoFadePalettes

FadeToWhite::
	push bc
	call SetWhitePals
	pop bc
	jr FadePalettes

FadeToBlack::
	push bc
	call SetBlackPals
	pop bc
	; fallthrough

FadePalettes::
; Fades active palettes in wBGPals2/wOBPals2 to new ones in wBGPals1/wOBPals1 in c frames
	xor a
	ld [wPalFadeMode], a
DoFadePalettes::
	farjp _DoFadePalettes
