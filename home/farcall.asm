FarCall_de::
; Call a:de.
; Preserves other registers.

	ld [hBuffer], a
	ld a, [hROMBank]
	push af
	ld a, [hBuffer]
	rst Bankswitch
	call .de
	jr ReturnFarCall

.de
	push de
	ret

FarCall_hl::
; Call a:hl.
; Preserves other registers.

	ld [hBuffer], a
	ld a, [hROMBank]
	push af
	ld a, [hBuffer]
	rst Bankswitch
	call FarJump_hl
	jr ReturnFarCall

RstFarCall::
; Calls BANK(x):x where x is assumed to be defined below the rst FarCall, and skips these
; to avoid running them as instructions, to save space. Preserves bc, de
	pop hl
	ld a, [hli]
	ld [hBuffer], a
	ld a, [hli]
	inc hl
	push hl
	dec hl
	ld h, [hl]
	ld l, a
	ld a, [hROMBank]
	push af
	ld a, [hBuffer]
	rst Bankswitch
	call FarJump_hl

ReturnFarCall:: ; 2d6e
; We want to retain the contents of f.
; To do this, we can pop to bc instead of af.

	ld a, b
	ld [wFarCallBCBuffer], a
	ld a, c
	ld [wFarCallBCBuffer + 1], a

; Restore the working bank.
	pop bc
	ld a, b
	rst Bankswitch

	ld a, [wFarCallBCBuffer]
	ld b, a
	ld a, [wFarCallBCBuffer + 1]
	ld c, a
	ret
; 2d82

FarJump_hl:: ; 2d82
	jp hl
; 2d83
