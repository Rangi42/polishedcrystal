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

_LoadCryHeader:
	ld hl, PokemonCries
rept 6
	add hl, bc
endr

	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
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
; input: c = species, b = form
; output: bc = base species index
	ld a, c
	and a
	jr z, .no
	inc c ; cp EGG
	jr z, .no

	dec c
	dec c ; slightly faster than dec bc, since we know c != 0
	ld a, b
	call ConvertFormToExtendedSpecies
	ld b, a
	and a
	ret

.no
	scf
	ret
