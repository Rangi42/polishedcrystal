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
	ld a, 16 * NUM_PAL_COLORS
.loop
	ld [hl], c
	inc hl
	ld [hl], b
	inc hl
	dec a
	jr nz, .loop
endc
	ret
