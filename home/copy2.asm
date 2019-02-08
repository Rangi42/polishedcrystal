FarCopyBytes::
	call StackCallInBankA
	; fallthrough
_CopyBytes:: ; 0x3026
; copy bc bytes from hl to de
	inc b  ; we bail the moment b hits 0, so include the last run
	inc c  ; same thing; include last byte
	jr .HandleLoop
.CopyByte:
	ld a, [hli]
	ld [de], a
	inc de
.HandleLoop:
	dec c
	jr nz, .CopyByte
	dec b
	jr nz, .CopyByte
	ret

ByteFill:: ; 0x3041
; fill bc bytes with the value of a, starting at hl
	inc b  ; we bail the moment b hits 0, so include the last run
	inc c  ; same thing; include last byte
	jr .HandleLoop
.PutByte:
	ld [hli], a
.HandleLoop:
	dec c
	jr nz, .PutByte
	dec b
	jr nz, .PutByte
	ret

GetFarByte:: ; 0x304d
; retrieve a single byte from a:hl, and return it in a.
	call StackCallInBankA
	ld a, [hl]
	ret

GetFarHalfword:: ; 0x305d
; retrieve a halfword from a:hl, and return it in hl.
	; bankswitch to new bank
	ld [hBuffer], a
	ld a, [hROMBank]
	push af
	ld a, [hBuffer]
	rst Bankswitch

	; get halfword from new bank, put it in hl
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; bankswitch to previous bank and return
	pop af
	rst Bankswitch
	ret
; 0x306b

FarCopyWRAM:: ; 306b
	ld [hBuffer], a
	ld a, [rSVBK]
	push af
	ld a, [hBuffer]
	ld [rSVBK], a

	rst CopyBytes

	pop af
	ld [rSVBK], a
	ret
; 307b

GetFarWRAMByte:: ; 307b
	ld [hBuffer], a
	ld a, [rSVBK]
	push af
	ld a, [hBuffer]
	ld [rSVBK], a
	ld a, [hl]
	ld [hBuffer], a
	pop af
	ld [rSVBK], a
	ld a, [hBuffer]
	ret
; 308d
