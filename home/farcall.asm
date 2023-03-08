; These functions preserve all registers (a, bc, de, hl) unless otherwise stated.
; Functions that rely on "following" data access it via their return address on
; the stack, and update the return address to point past the data.

RstFarCall::
; Call the following dab pointer
; preserves af, bc, de, hl
	dec sp
	call .do_farcall
.return
; restore the rom bank and clean up
	push af
	push hl
	ld hl, sp+4
	ld a, [hl]
	rst Bankswitch
	pop hl
	pop af
	inc sp
	ret

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

	ld hl, sp+10
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
	ld hl, sp+9 ; +3 due to the push above and writing d first
	ld a, d
	and $7f
	ld [hld], a
	ld [hl], e

	bit 7, d
	pop de
	jr z, .call
; for farjp we need to replace the return address
	ld de, DoNothing
.call
; write return address
	ld hl, sp+11
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
	jr RstFarCall.return

.do_farcall
	push hl
	push af
	ldh a, [hROMBank]
	ld hl, sp+6
	ld [hl], a
	pop af
	rst Bankswitch
	pop hl
	jp hl

FarCall_de::
; Call a:de.
	dec sp
	call .do_farcall
	jr RstFarCall.return

.do_farcall
	push de
	push hl
	push af
	ldh a, [hROMBank]
	ld hl, sp+8
	ld [hl], a
	pop af
	rst Bankswitch
	pop hl
; de already pushed to the stack
	ret


AnonBankPush::
; Call the following function in the following bank db.
	call .do_push
.return
	push af
	push hl
	ld hl, sp+5
	ld a, [hl]
	pop hl
	rst Bankswitch
	pop af
; skip past where the return address was
	inc sp
	inc sp
	ret

; Stack layout
; +11 saved bank
; +10 Original return address
; +8  return path
; +6  return address
; +4  saved af
; +2  saved de
; +0  saved hl
; the return address starts at +10 and needs to be moved
.do_push
	dec sp
	dec sp
	push af
	push de
	push hl

; Read return address
	ld hl, sp+10
	ld a, [hli]
	ld d, [hl]
	ld e, a

; Save the current bank
	ldh a, [hROMBank]
	ld [hl], a

	ld a, [de]
	rst Bankswitch
	inc de

; Write return adress back in its new place
	ld hl, sp+6
	ld a, e
	ld [hli], a
	ld [hl], d

; Return, with code to restore the saved bank on the stack
	pop hl
	pop de
	pop af
	ret

; Very similar to AnonBankPush
StackCallInBankB:
; Call the following function in bank b. Clobbers a.
	ld a, b
StackCallInBankA:
; Call the following function in bank a. Clobbers a.
	call .do_push
	jr AnonBankPush.return

.do_push
	dec sp
	dec sp
	push af
	push de
	push hl

; Read return address
	ld hl, sp+10
	ld a, [hli]
	ld d, [hl]
	ld e, a

; Save the current bank
	ldh a, [hROMBank]
	ld [hl], a

; Write return adress back in its new place
	ld hl, sp+6
	ld a, e
	ld [hli], a
	ld [hl], d

; Return, with code to restore the saved bank on the stack
	pop hl
	pop de
	pop af
	rst Bankswitch
	ret

RunFunctionInWRA6::
; Call the following function in wDecompressScratch's WRAM bank. Clobbers a.
	ld a, BANK(wDecompressScratch)
StackCallInWRAMBankA::
; Call the following function in WRAM bank a. Clobbers a.
	call .do_push
	push af
	push hl
	ld hl, sp+5
	ld a, [hl]
	pop hl
	ldh [rSVBK], a
	pop af
; skip past where the return address was
	inc sp
	inc sp
	ret

.do_push
	dec sp
	dec sp
	push af
	push de
	push hl

; Read return address
	ld hl, sp+10
	ld a, [hli]
	ld d, [hl]
	ld e, a

; Save the current ram bank
	ldh a, [rSVBK]
	ld [hl], a

; Write return adress back in its new place
	ld hl, sp+6
	ld a, e
	ld [hli], a
	ld [hl], d

; Return, with code to restore the saved ram bank on the stack
	pop hl
	pop de
	pop af
	ldh [rSVBK], a
	ret
