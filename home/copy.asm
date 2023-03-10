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
	jr nc, .skip1
	ld a, [hli]
	ld [de], a
	inc de

.skip1
	srl c
	jr nc, .skip2
rept 2
	ld a, [hli]
	ld [de], a
	inc de
endr

.skip2
	jr z, .next
.loop
rept 4
	ld a, [hli]
	ld [de], a
	inc de
endr

	dec c
	jr nz, .loop

.next
	dec b
	ret z

	ld c, $40
	jr .loop

_ByteFill::
; fill bc bytes with the value of a, starting at hl
	inc b  ; we bail the moment b hits 0, so include the last run
	srl c
	jr nc, .skip1
	ld [hli], a

.skip1
	srl c
	jr nc, .skip2
	ld [hli], a
	ld [hli], a

.skip2
	jr z, .next
.loop
rept 4
	ld [hli], a
endr
	dec c
	jr nz, .loop

.next
	dec b
	ret z

	ld c, $40
	jr .loop

GetFarWord::
; retrieve a word from a:hl, and return it in hl.
	; bankswitch to new bank
	push bc
	ld b, a
	ldh a, [hROMBank]
	ld c, a
	ld a, b
	rst Bankswitch

	; get word from new bank, put it in hl
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; bankswitch to previous bank and return
	ld a, c
	rst Bankswitch
	pop bc
	ret
