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
	call _hl_
	jr ReturnFarCall

RstFarCall::
; Call the following dba pointer on the stack. Doesn't mangle registers in the process
	ld [wFarCallSavedA], a
	ld a, h
	ld [wFarCallHLBuffer], a
	ld a, l
	ld [wFarCallHLBuffer + 1], a
	pop hl
	ld a, [hli]
	ld [hBuffer], a
	inc hl
	inc hl
	push af
	sub $80
	jr nc, .jump
	ld [hBuffer], a
	pop af
	push hl
	jr .ok
.jump
	pop af
.ok
	dec hl
	ld a, [hld]
	ld l, [hl]
	ld h, a
	ld a, [hROMBank]
	push af
	ld a, [hBuffer]
	rst Bankswitch
	call RecoverHLAndCall

ReturnFarCall::
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

RecoverHLAndCall:
	push hl
	ld [PredefTemp], a
	ld h, a
	ld [PredefTemp + 1], a
	ld l, a
	ld a, [wFarCallSavedA]
	ret
