; These functions preserve all registers (a, bc, de, hl) unless otherwise stated.
; Functions that rely on "following" data access it via their return address on
; the stack, and update the return address to point past the data.

MACRO update_pushed_af_flags
; Must have been preceded by 'push af'.
; Updates the flags on the stack to their current value
; without clobbering any other registers.
	push af ; pushes current flags
	push hl
	ld hl, sp + 2
	ld a, [hli] ; reads current flags
	assert HIGH(wStackBottom) == HIGH(wStackTop)
	inc l
	ld [hl], a ; overwrites pushed flags
	pop hl
	pop af
ENDM

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

_DoFarCall:
	ldh a, [hROMBank]
	push af
	ldh a, [hTempBank]
_DoFarCall_BankInA:
	rst Bankswitch
	call RetrieveAHLAndCallFunction
_ReturnFarCall:
	ldh [hFarCallSavedA], a
	update_pushed_af_flags
	pop af
	rst Bankswitch
	ldh a, [hFarCallSavedA]
	ret

RunFunctionInWRA6::
; Call the following function in wDecompressScratch's WRAM bank. Clobbers a.
	ld a, BANK(wDecompressScratch)
StackCallInWRAMBankA::
; Call the following function in WRAM bank a. Clobbers a.
	ldh [hTempBank], a
	ld a, h
	ldh [hFarCallSavedH], a
	ld a, l
	ldh [hFarCallSavedL], a
	pop hl
	ldh a, [rSVBK]
	push af
	ldh a, [hTempBank]
	ldh [rSVBK], a
	call RetrieveAHLAndCallFunction
	ldh [hTempBank], a
	update_pushed_af_flags
	pop af
	ldh [rSVBK], a
	ldh a, [hTempBank]
	ret

RetrieveAHLAndCallFunction:
; Call the function at hl with restored values of a and hl.
	push hl
	ld hl, hFarCallSavedHL
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ldh a, [hFarCallSavedA]
	ret

AnonBankPush::
; Call the following function in the following bank db.
	ldh [hFarCallSavedA], a
	ld a, h
	ldh [hFarCallSavedH], a
	ld a, l
	ldh [hFarCallSavedL], a
	pop hl
	ld a, [hli]
	ldh [hTempBank], a
	jr _DoFarCall

StackCallInBankB:
; Call the following function in bank b. Clobbers a.
	ld a, b
StackCallInBankA:
; Call the following function in bank a. Clobbers a.
	ldh [hTempBank], a
	ld a, h
	ldh [hFarCallSavedH], a
	ld a, l
	ldh [hFarCallSavedL], a
	pop hl
	jr _DoFarCall
