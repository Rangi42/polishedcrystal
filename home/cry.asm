PlayStereoCry::
	push af
	ld a, 1
	ld [wStereoPanningMask], a
	pop af
	call _PlayCry
	jmp WaitSFX

PlayStereoCry2::
; Don't wait for the cry to end.
; Used during pic animations.
	push af
	ld a, 1
	ld [wStereoPanningMask], a
	pop af
	jr _PlayCry

PlayCry::
	call PlayCry2
	jmp WaitSFX

PlayCry2::
; Don't wait for the cry to end.
	push af
	xor a
	ld [wStereoPanningMask], a
	ld [wCryTracks], a
	pop af
	; fallthrough

_PlayCry::
	push hl
	push de
	push bc

	call GetCryIndex
	jr c, .done

	ld e, c
	ld d, b
	call PlayCryHeader

.done
	jmp PopBCDEHL

LoadCryHeader::
; Load cry header bc.

	call GetCryIndex
	ret c

	anonbankpush PokemonCries

.Function:
	ld hl, PokemonCries
rept 6
	add hl, bc
endr

	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

	ld a, [hli]
	ld [wCryPitch], a
	ld a, [hli]
	ld [wCryPitch + 1], a
	ld a, [hli]
	ld [wCryLength], a
	ld a, [hl]
	ld [wCryLength + 1], a

	and a
	ret

GetCryIndex::
	and a
	jr z, .no
	cp NUM_POKEMON + 1
	jr nc, .no

	ld c, a
	ld a, [wCurForm]
	ld b, a
	call GetExtendedSpeciesIndex
	dec bc
	ld a, c
	and a
	ret

.no
	scf
	ret
