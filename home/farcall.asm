; These functions preserve all registers (a, bc, de, hl) unless otherwise stated.
; Functions that rely on "following" data access it via their return address on
; the stack, and update the return address to point past the data.

_RstFarCall::
	dec sp
	call .do_farcall
	jr _ReturnFarCall
; Call the following dab pointer
; preserves af, bc, de, hl

.do_farcall
; same speed and size as add sp, -2 but preserves flags
	dec sp
	dec sp
	push af
	push de
	push hl
; Stack layout
; +11 return address
; +10 saved bank
; +8  return path
; +6  function pointer
; +4  saved af
; +2  saved de
; +0  saved hl

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

; check farjp
	add a

; bank number
	ld a, [hli]
	rst Bankswitch

	jr nc, .call
	res 7, d
; for farjp we need to replace the return address
	ld hl, DoNothing
.call
	push hl

; write the function pointer
	ld hl, sp + 8
	ld a, e
	ld [hli], a
	ld [hl], d

	pop de
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
; clear carry
	and a
_DoFarCall:
	dec sp
	push hl
	push af
	ldh a, [hROMBank]
	ld hl, sp + 4
	ld [hl], a
	pop af
	rst Bankswitch
	pop hl
	jr nc, .hl
	call _de_
	jr _ReturnFarCall
.hl
	call _hl_
; fallthrough
_ReturnFarCall:
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

FarCall_de::
; Call a:de.
	scf
	jr _DoFarCall

AnonBankPush::
	add sp, -3
	push af
	push de
	push hl
; Stack layout:
; +10 saved bank
; +8  return path
; +6  return address
; return address starts at 10, so it needs to be moved
; note that writing the return path and reading the address
; are interleaved

	ld hl, sp + 10
; Store current bank
	ldh a, [hROMBank]
	ld d, [hl]
	ld [hld], a

	ld e, [hl]
	ld a, HIGH(_ReturnFarCall)
	ld [hld], a
	ld a, LOW(_ReturnFarCall)
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

	ld e, [hl]
	ld [hl], HIGH(_ReturnFarCall)
	dec hl ; no-optimize *hl++|*hl-- = N preserving a
	ld [hl], LOW(_ReturnFarCall)
	dec hl ; no-optimize *hl++|*hl-- = N

; Write the return back
	ld [hl], d
	dec hl
	ld [hl], e

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

	ld hl, rSVBK
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
