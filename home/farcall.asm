FarCall_de::
; Call a:de.
; Preserves other registers.
; TODO: Get rid of this, it's only used in two places
	ldh [hTempBank], a
	ldh a, [hROMBank]
	push af
	ldh a, [hTempBank]
	rst Bankswitch
	call _de_
	jr ReturnFarCall

AnonBankPush::
	ldh [hFarCallSavedA], a
	ld a, h
	ldh [hPredefTemp + 1], a
	ld a, l
	ldh [hPredefTemp], a
	pop hl
	ldh a, [hROMBank]
	push af
	ld a, [hli]
	jr DoFarCall_BankInA

FarCall_hl::
; Call a:hl.
; Preserves other registers.

	ldh [hTempBank], a
	ldh a, [hROMBank]
	push af
	jr DoFarCall

FarPointerCall::
	ldh a, [hROMBank]
	push af
	ld a, [hli]
	ldh [hTempBank], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jr DoFarCall

CallOpponentTurn::
	ldh [hFarCallSavedA], a
	ld a, h
	ldh [hPredefTemp + 1], a
	ld a, l
	ldh [hPredefTemp], a

	pop hl
	call SwitchTurn
	call RetrieveHLAndCallFunction
	push af
	call SwitchTurn
	pop af
	ret

StackCallInBankB:
	ld a, b
StackCallInBankA:
	ldh [hTempBank], a
	ld a, h
	ldh [hPredefTemp + 1], a
	ld a, l
	ldh [hPredefTemp], a
	pop hl
	ldh a, [hROMBank]
	push af
	jr DoFarCall

RstFarCall::
; Call the following dba pointer on the stack.
; Preserves a, bc, de, hl
	ldh [hFarCallSavedA], a
	ld a, h
	ldh [hPredefTemp + 1], a
	ld a, l
	ldh [hPredefTemp], a
	pop hl
	ld a, [hli]
	ldh [hTempBank], a
	add a
	jr c, .farjp
	inc hl
	inc hl
	push hl
	dec hl
	dec hl
.farjp
	ldh a, [hROMBank]
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
DoFarCall:
	ldh a, [hTempBank]
DoFarCall_BankInA:
	and $7f
	rst Bankswitch
	call RetrieveHLAndCallFunction

ReturnFarCall::
	ldh [hFarCallSavedA], a
	; We want to retain the contents of f.
	; To accomplish this, mess with the stack a bit...
	push af
	push hl
	ld hl, sp+$2 ; a flags
	ld a, [hli]
	inc l ; faster than inc hl (stack is always c000-c100...)
	ld [hl], a ; write to flags
	pop hl
	pop af
	pop af
	rst Bankswitch
	ldh a, [hFarCallSavedA]
	ret

RunFunctionInWRA6::
	ld a, BANK(wDecompressScratch)

; fallthrough
StackCallInWRAMBankA::
	ldh [hTempBank], a
	ld a, h
	ldh [hPredefTemp + 1], a
	ld a, l
	ldh [hPredefTemp], a

; fallthrough
StackCallInWRAMBankA_continue:
	pop hl
	ldh a, [rSVBK]
	push af
	ldh a, [hTempBank]
	ldh [rSVBK], a
	call RetrieveHLAndCallFunction
	ldh [hTempBank], a
	pop af
	ldh [rSVBK], a
	ldh a, [hTempBank]
	ret

RetrieveHLAndCallFunction:
	push hl
	ld hl, hPredefTemp
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ldh a, [hFarCallSavedA]
	ret
