FarCall_de::
; Call a:de.
; Preserves other registers.
; TODO: Get rid of this, it's only used in one place
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
	jr DoFarCall


FarCallInBankB:
	ld a, b
	ld [hBuffer], a
	ld a, h
	ld [wFarCallHLBuffer], a
	ld a, l
	ld [wFarCallHLBuffer + 1], a
	pop hl
	ld a, [hROMBank]
	push af
	jr DoFarCall

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
	pop af
	push hl
	jr .ok
.jump
	ld [hBuffer], a
	pop af
.ok
	dec hl
	ld a, [hld]
	ld l, [hl]
	ld h, a
	ld a, [hROMBank]
	push af
DoFarCall:
	ld a, [hBuffer]
	rst Bankswitch
	call RetrieveHLAndCallFunction

ReturnFarCall::
	ld [wFarCallSavedA], a
	; We want to retain the contents of f.
	; To accomplish this, mess with the stack a bit...
	push af
	push hl
	ld hl, sp + 2 ; a flags
	ld a, [hli]
	inc l ; faster than inc hl (stack is always c000-c100...)
	ld [hl], a ; write to flags
	pop hl
	pop af
	pop af
	rst Bankswitch
	ld a, [wFarCallSavedA]
	ret

RetrieveHLAndCallFunction:
	push hl
	ld hl, wFarCallHLBuffer
	ld a, [hli]
	ld l, [hl]
	ld h, a
	ld a, [wFarCallSavedA]
	ret
