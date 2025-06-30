; These functions preserve all registers (a, bc, de, hl) unless otherwise stated.
; Functions that rely on "following" data access it via their return address on
; the stack, and update the return address to point past the data.

; In home/header.asm:
; FarCall::
;   dec sp ; push space for the return bank
; ; Stack layout:
; ; +1 pointer to function address and bank followed by return location
; ; +0 nothing
;   call _RstFarCall
; ; Stack layout:
; ; +1 return address
; ; +0 return bank
;   jmp _ReturnFarCall

_RstFarCall::
; Call the following dab pointer.
; Preserves af, bc, de, hl.
	dec sp ; push space for the target function pointer
	dec sp ; 'dec sp' preserves flags, unlike 'add sp, -2'
	push af
	push de
	push hl

; Stack layout:
; +11 pointer to dab pointer followed by return location
; +10 nothing
; +8  after 'call .do_farcall'
; +6  nothing
; +4  saved af
; +2  saved de
; +0  saved hl

; Write return bank to sp+10
	ld hl, sp + 10
	ldh a, [hROMBank]
	ld [hli], a

; Get function bank and address in a:de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli] ; LOW(function address)
	ld e, a
	ld a, [hli] ; HIGH(function address)
	ld d, a
	add a ; set carry if farjp
	ld a, [hli] ; function bank
	rst Bankswitch
	jr nc, .not_farjp
	res 7, d ; d has HIGH(function address), with the 'jump' flag bit cleared
	ld hl, DoNothing ; farjp is really a call and then jump to DoNothing
.not_farjp

; Write function pointer to sp+6
	push hl
	ld hl, sp + 8
	ld a, e
	ld [hli], a
	ld [hl], d
	pop de

; Update sp+11 pointer to be actual return location
	ld hl, sp + 11
	ld a, e
	ld [hli], a
	ld [hl], d

; Stack layout:
; +11 return address
; +10 return bank
; +8  after 'call .do_farcall'
; +6  target function
; +4  saved af
; +2  saved de
; +0  saved hl

; Restore registers and "return" to the target function
	pop hl
	pop de
	pop af
	ret

FarPointerCall::
; Call the dba pointer at hl.
; Clobbers a and hl.
	ld a, [hli] ; a = bank
	push af
	ld a, [hli] ; hl = address
	ld h, [hl]
	ld l, a
	pop af
; fallthrough

FarCall_hl::
; Call a:hl.
	and a ; clear carry (signal to call hl not de)
	; fallthrough

_DoFarCall:
	dec sp ; push space for the return bank
	push hl
	push af
; Stack layout:
; +5 return address
; +4 nothing
; +2 saved hl
; +0 saved af
; Write return bank to sp+0
	ldh a, [hROMBank]
	ld hl, sp + 4
	ld [hl], a
	pop af
	rst Bankswitch
	pop hl
; Stack layout:
; +1 return address
; +0 return bank
	jr nc, .call_hl
	call _de_
	jr _ReturnFarCall
.call_hl
	call _hl_
; fallthrough

_ReturnFarCall:
	push af
	push hl
; Stack layout:
; +5 return address
; +4 return bank
; +2 saved af
; +0 saved hl
	ld hl, sp + 4
	ld a, [hl]
	rst Bankswitch
	pop hl
	pop af
	inc sp
	ret

FarCall_de::
; Call a:de.
	scf ; set carry (signal to call de not hl)
	jr _DoFarCall

AnonBankPush::
	add sp, -3 ; push space for the target function bank and address
	push af
	push de
	push hl

; Stack layout:
; +9 pointer to bank number followed by return location
; +8 nothing
; +6 nothing
; +4 saved af
; +2 saved de
; +0 saved hl

; Write return bank to sp+10
	ld hl, sp + 10
	ldh a, [hROMBank]
	ld d, [hl] ; HIGH(return address)
	ld [hld], a

	ld e, [hl] ; LOW(return address)
	ld a, HIGH(_ReturnFarCall)
	ld [hld], a
	ld a, LOW(_ReturnFarCall)
	ld [hld], a

	ld a, [de]
	inc de
	rst Bankswitch

	ld a, d
	ld [hld], a
	ld [hl], e

; Stack layout:
; +10 return bank
; +8  _ReturnFarCall
; +6  target function
; +4  saved af
; +2  saved de
; +0  saved hl

	pop hl
	pop de
	pop af
	ret

StackCallInBankB:
; Call the following function in bank b. Clobbers a.
	ld a, b
StackCallInBankA:
; Call the following function in bank a. Clobbers a.
	add sp, -3
	push de
	push hl

; Stack layout:
; +7 return location
; +6 nothing
; +4 nothing
; +2 saved de
; +0 saved hl

	ld hl, sp + 8
	ld d, [hl]
	ld e, a
	ldh a, [hROMBank]
	ld [hld], a
	ld a, e

	ld e, [hl]
	ld [hl], HIGH(_ReturnFarCall)
	dec hl ; no-optimize *hl++|*hl-- = N preserving a
	ld [hl], LOW(_ReturnFarCall)
	dec hl ; no-optimize *hl++|*hl-- = N

	ld [hl], d ; no-optimize *hl++|*hl-- = b|c|d|e
	dec hl
	ld [hl], e

; Stack layout:
; +8 return bank
; +6 _ReturnFarCall
; +4 target function
; +2 saved de
; +0 saved hl

	pop hl
	pop de
	jmp Bankswitch

RunFunctionInWRA6::
; Call the following function in wDecompressScratch's WRAM bank. Clobbers a.
	ld a, BANK(wDecompressScratch)
StackCallInWRAMBankA::
; Call the following function in WRAM bank a. Clobbers a.
	add sp, -3
	push de
	push hl

; Stack layout:
; +7 return location
; +6 nothing
; +4 nothing
; +2 saved de
; +0 saved hl

	ld hl, rWBK
	ld e, [hl]
	ld [hl], a

	ld hl, sp + 8
	ld d, [hl]
	ld a, e
	ld [hld], a

	ld e, [hl]
	ld a, HIGH(.return)
	ld [hld], a
	ld a, LOW(.return)
	ld [hld], a

	ld a, d
	ld [hld], a
	ld [hl], e

; Stack layout:
; +8 saved wram bank
; +6 .return
; +4 target function
; +2 saved de
; +0 saved hl

	pop hl
	pop de
	ret

.return
	push hl
	push af
; Stack layout:
; +5 return address
; +4 saved wram bank
; +2 saved af
; +0 saved hl
	ld hl, sp + 4
	ld a, [hl]
	ldh [rWBK], a
	pop af
	pop hl
	inc sp
	ret
