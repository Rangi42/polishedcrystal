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

RstFarCall::
; Call the following dba pointer.
	ldh [hFarCallSavedA], a
	ld a, h
	ldh [hFarCallSavedH], a
	ld a, l
	ldh [hFarCallSavedL], a
	pop hl
	ld a, [hli]
	ldh [hTempBank], a
	ld a, [hli]
	bit 7, [hl]
	jr nz, .farjp
	inc hl
	push hl
	dec hl
.farjp
	ld h, [hl]
	ld l, a
	res 7, h
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

FarCall_de::
; Call a:de. Clobbers a.
	ldh [hTempBank], a
	ldh a, [hROMBank]
	push af
	ldh a, [hTempBank]
	rst Bankswitch
	call _de_
	jr _ReturnFarCall

AnonBankPush::
; Call the following function in the following bank db.
	ldh [hFarCallSavedA], a
	ld a, h
	ldh [hFarCallSavedH], a
	ld a, l
	ldh [hFarCallSavedL], a
	pop hl
	ld a, [hli]
FarCall_hl::
; Call a:hl. Clobbers a and hl.
	ldh [hTempBank], a
	jr _DoFarCall

FarPointerCall::
; Call the dba pointer at hl. Clobbers a and hl.
	ld a, [hli]
	ldh [hTempBank], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
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
