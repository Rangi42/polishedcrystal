; Functions to fade the screen in and out.

SetBlackPals::
	ld a, BANK(wBGPals1)
	call StackCallInWRAMBankA

.Function:
	xor a
	jr DoSetPals

SetWhitePals::
	ld a, BANK(wBGPals1)
	call StackCallInWRAMBankA

.Function:
	ld a, $ff
DoSetPals:
	ld hl, wBGPals1
	ld bc, 16 palettes
	rst ByteFill
	ret

FadeToWhite::
	push bc
	call SetWhitePals
	pop bc
	jr FadePalettes

FadeToBlack::
	push bc
	call SetBlackPals
	pop bc

FadePalettes::
; Fades active palettes in wBGPals2/wOBPals2 to new ones in
; wBGPals1/wOBPals1 in c frames
	xor a
	ld [wPalFadeMode], a
	jr DoFadePalettes

FadeBGPalettes::
	ld a, PALFADE_BG
	ld [wPalFadeMode], a
	jr DoFadePalettes

FadeOBPalettes::
	ld a, PALFADE_OBJ
	ld [wPalFadeMode], a
DoFadePalettes::
	farjp _DoFadePalettes
