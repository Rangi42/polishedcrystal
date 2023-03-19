_Predef::
; Call predefined function on the stack.
; Preserves a, bc, de, hl.
	dec sp ; push space for the return bank
; Stack layout:
; +1 pointer to predef id followed by return location
; +0 nothing
	call .do_predef
; Stack layout:
; +1 return address
; +0 return bank
	jr _ReturnFarCall

.do_predef
	dec sp ; push space for the predef function pointer
	dec sp ; 'dec sp' preserves flags, unlike 'add sp, -2'
	push af
	push de
	push hl

; Stack layout:
; +11 pointer to predef id followed by return location
; +10 nothing
; +8  after 'call .do_predef'
; +6  nothing
; +4  saved af
; +2  saved de
; +0  saved hl

; Write return bank to sp+10
	ld hl, sp + 10
	ldh a, [hROMBank]
	ld [hli], a

; Get predef id
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld a, [de]
	add a ; set carry if predef_jump
	jr nc, .not_predef_jump
	ld de, DoNothing - 1 ; predef_jump is really a call and then jump to DoNothing
.not_predef_jump

; Update sp+11 pointer to be actual return location
	inc de
	ld [hl], d ; no-optimize *hl++|*hl-- = b|c|d|e
	dec hl
	ld [hl], e
	rrca ; a has the predef id, with the 'jump' flag bit cleared

; Get predef function bank and address in a:de
	ld e, a
	ld d, 0
	ld a, BANK(PredefPointers)
	rst Bankswitch
	ld hl, PredefPointers
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli] ; LOW(predef address)
	ld e, a
	ld a, [hli] ; predef bank
	ld d, [hl] ; HIGH(predef address)
	rst Bankswitch

; Write function pointer to sp+6
	ld hl, sp + 6
	ld a, e
	ld [hli], a
	ld [hl], d

; Stack layout:
; +11 return address
; +10 return bank
; +8  after 'call .do_predef'
; +6  predef function
; +4  saved af
; +2  saved de
; +0  saved hl

; Restore registers and "return" to predef function
	pop hl
	pop de
	pop af
	ret
