FarCall_de::
; Call a:de.
; Preserves other registers.
; TODO: Get rid of this, it's only used in two places
	ldh [hBuffer], a
	ldh a, [hROMBank]
	push af
	ldh a, [hBuffer]
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

	ldh [hBuffer], a
	ldh a, [hROMBank]
	push af
	jr DoFarCall

FarPointerCall::
	ldh a, [hROMBank]
	push af
	ld a, [hli]
	ldh [hBuffer], a
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
	ldh [hBuffer], a
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
	ldh [hBuffer], a
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
	ldh a, [hBuffer]
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
	ld hl, sp + 2 ; a flags
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
	GLOBAL wDecompressScratch
	ld a, BANK(wDecompressScratch)

; fallthrough
StackCallInWRAMBankA::
	ldh [hBuffer], a
	ld a, h
	ldh [hPredefTemp + 1], a
	ld a, l
	ldh [hPredefTemp], a

; fallthrough
StackCallInWRAMBankA_continue:
	pop hl
	ldh a, [rSVBK]
	push af
	ldh a, [hBuffer]
	ldh [rSVBK], a
	call RetrieveHLAndCallFunction
	ldh [hBuffer], a
	pop af
	ldh [rSVBK], a
	ldh a, [hBuffer]
	ret

RetrieveHLAndCallFunction:
	push hl
	ld hl, hPredefTemp
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ldh a, [hFarCallSavedA]
	ret
