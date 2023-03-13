_Predef::
; Call predefined function on the stack.
; Preserves a, bc, de, hl.
	dec sp
	call .do_farcall
	jmp _ReturnFarCall

; Stack layout
; +11 return address
; +10 saved bank
; +8  return path
; +6  function pointer
; +4  saved af
; +2  saved hl
; +0  saved de
.do_farcall
	dec sp
	dec sp
	push af
	push hl
	push de

	ld hl, sp + 10
	ldh a, [hROMBank]
	ld [hli], a

; Read return address
	ld a, [hli]
	ld d, [hl]
	ld e, a

; predef id
	ld a, [de]

	add a
	jr nc, .call
; for predef_jump we need to replace the return address
	ld de, DoNothing - 1
.call
	inc de
	ld [hl], d
	dec hl
	ld [hl], e

	rrca
	ld e, a
	ld d, 0
	ld a, BANK(PredefPointers)
	rst Bankswitch
	ld hl, PredefPointers
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, [hl]
	rst Bankswitch

; Write out the function pointer
	ld hl, sp + 6
	ld a, e
	ld [hli], a
	ld [hl], d

; Restore registers and jump to predef
	pop de
	pop hl
	pop af
	ret
