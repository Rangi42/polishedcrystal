; These functions preserve all registers (a, bc, de, hl) unless otherwise stated.
; Functions that rely on "following" data access it via their return address on
; the stack, and update the return address to point past the data.

_RstFarCall::
	dec sp
	call .do_farcall
	jmp FarCall_hl.return
; Call the following dab pointer
; preserves af, bc, de, hl
; Partially implemented in the rst handler

; Stack layout
; +11 return address
; +10 saved bank
; +8  return path
; +6  function pointer
; +4  saved af
; +2  saved de
; +0  saved hl
.do_farcall
; same speed and size as add sp, -2 but preserves flags
	dec sp
	dec sp
	push af
	push de
	push hl

	ld hl, sp + 10
	ldh a, [hROMBank]
	ld [hli], a

; Read return address
	ld a, [hli]
	ld h, [hl]
	ld l, a

; function pointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a

; bank number
	ld a, [hli]
	rst Bankswitch

	push hl
; write the function pointer
	ld hl, sp + 9 ; +3 due to the push above and writing d first
	ld a, d
	and $7f
	ld [hld], a
	ld [hl], e

	xor d
	pop de
	jr z, .call
; for farjp we need to replace the return address
	ld de, DoNothing
.call
; write return address
	ld hl, sp + 11
	ld a, e
	ld [hli], a
	ld [hl], d

; restore registers and jump to the target function
	pop hl
	pop de
	pop af
	ret

FarPointerCall::
; Call the dba pointer at hl. Clobbers a and hl.
	ld a, [hli]
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
; fallthrough

FarCall_hl::
; Call a:hl.
	dec sp
	call .do_farcall
.return
; restore the rom bank and clean up
	push af
	push hl
	ld hl, sp + 4
	ld a, [hl]
	rst Bankswitch
	pop hl
	pop af
	inc sp
	ret

.do_farcall
	push hl
	push af
	ldh a, [hROMBank]
	ld hl, sp + 6
	ld [hl], a
	pop af
	rst Bankswitch
; same speed as ret but doesn't leave a stack address in hl
; less likely to trash the stack if bugs happen
	pop hl
	jp hl

FarCall_de::
; Call a:de.
	dec sp
	call .do_farcall
	jr FarCall_hl.return

.do_farcall
	push de
	push hl
	push af
	ldh a, [hROMBank]
	ld hl, sp + 8
	ld [hl], a
	pop af
	rst Bankswitch
	pop hl
; de already pushed to the stack
	ret

; Stack layout:
; +10 saved bank
; +8  return path
; +6  return address
; return address starts at 10, so it needs to be moved
; note that writing the return path and reading the address
; are interleaved
AnonBankPush::
	add sp, -3
	push af
	push de
	push hl

	ld hl, sp + 10
; Store current bank
	ldh a, [hROMBank]
	ld d, [hl]
	ld [hld], a

	ld e, [hl]
	ld a, HIGH(FarCall_hl.return)
	ld [hld], a
	ld a, LOW(FarCall_hl.return)
	ld [hld], a

	ld a, [de]
	inc de
	rst Bankswitch

; Write the return back
	ld a, d
	ld [hld], a
	ld [hl], e

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

	ld hl, sp + 8
	ld d, [hl]
; Store current bank
	ld e, a
	ldh a, [hROMBank]
	ld [hld], a

	ld a, e
	rst Bankswitch

	ld e, [hl]
	ld a, HIGH(FarCall_hl.return)
	ld [hld], a
	ld a, LOW(FarCall_hl.return)
	ld [hld], a

; Write the return back
	ld a, d
	ld [hld], a
	ld [hl], e

	pop hl
	pop de
	ret

RunFunctionInWRA6::
; Call the following function in wDecompressScratch's WRAM bank. Clobbers a.
	ld a, BANK(wDecompressScratch)
StackCallInWRAMBankA::
; Call the following function in WRAM bank a. Clobbers a.
	add sp, -3
	push de
	push hl

	ld hl, rSVBK
	ld e, [hl]
	ld [hl], a

	ld hl, sp + 8
	ld d, [hl]
	ld [hl], e
	dec hl

	ld e, [hl]
	ld a, HIGH(.return)
	ld [hld], a
	ld a, LOW(.return)
	ld [hld], a

	ld a, d
	ld [hld], a
	ld [hl], e

	pop hl
	pop de
	ret

.return
	push af
	push hl
	ld hl, sp + 4
	ld a, [hl]
	ldh [rSVBK], a
	pop hl
	pop af
	inc sp
	ret
