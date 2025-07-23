SoftReset::
	di
	call InitSound
	xor a
	ldh [hMapAnims], a
	call ClearPalettes
	xor a
	ldh [rIF], a
	ld a, IE_VBLANK
	ldh [rIE], a
	ei

	ld hl, wInputFlags
	set 7, [hl]

	ld c, 3
	call DelayFrames

	jr Init

Crash::
	ld b, b ; no-optimize no-op ld (BGB breakpoint)

	ldh [hCrashCode], a
	xor a
	ldh [hCGB], a
	jr Init

_Start::
	cp $11
	jr z, .cgb
	xor a
	jr .load
.cgb
	ld a, $1
.load
	ldh [hCGB], a
	xor a ; ld a, ERR_RST_0
	ldh [hCrashCode], a
	; fallthrough

Init::
	di
	ld a, BANK(_Init)
	ld [rROMB], a
	jmp _Init ; far-ok
