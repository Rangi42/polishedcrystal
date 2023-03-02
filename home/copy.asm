FarCopyBytesToColorWRAM::
; Copy bc bytes from a:hl to de in color WRAM
	call StackCallInBankA
.Function:
	ld a, BANK("GBC Video")
	call StackCallInWRAMBankA
	jr _CopyBytes

FarCopyBytes::
	call StackCallInBankA
	; fallthrough
_CopyBytes::
; copy bc bytes from hl to de
	inc b  ; we bail the moment b hits 0, so include the last run

	srl c
	jr nc, :+
	ld a, [hli]
	ld [de], a
	inc de

:	srl c
	jr nc, :+
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de

:	jr z, :++
:	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de

	dec c
	jr nz, :-

:	dec b
	ret z

	ld c, $40
	jr :--


_ByteFill::
; fill bc bytes with the value of a, starting at hl
	inc b  ; we bail the moment b hits 0, so include the last run
	srl c
	jr nc, :+
	ld [hli], a

:	srl c
	jr nc, :+
	ld [hli], a
	ld [hli], a

:	jr z, :++
:	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	dec c
	jr nz, :-

:	dec b
	ret z

	ld c, $40
	jr :--

GetFarWord::
; retrieve a word from a:hl, and return it in hl.
	; bankswitch to new bank
	ldh [hTempBank], a
	ldh a, [hROMBank]
	push af
	ldh a, [hTempBank]
	rst Bankswitch

	; get word from new bank, put it in hl
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; bankswitch to previous bank and return
	pop af
	rst Bankswitch
	ret
