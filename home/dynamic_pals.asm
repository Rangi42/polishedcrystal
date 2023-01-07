CheckForUsedObjPals::
	push hl
	push bc
	push de

	; reset all wUsedObjectPals bits
	xor a
	ld [wUsedObjectPals], a

	ld de, wObjectStructs
	ld b, NUM_OBJECT_STRUCTS
.loop
	; Check if the object has a sprite
	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .no_sprite_skip

	; Look up the objects requested color palette
	ld hl, OBJECT_PAL_INDEX
	add hl, de
	ld a, [hl]
	ld [wNeededPalIndex], a

	; Mark the palette in use and/or load the palette
	call MarkUsedPal
	; Then load the return into OBJECT_PALETTE. Which corresponds
	; to OBJ 0 - OBJ 7.
	ld hl, OBJECT_PALETTE
	add hl, de
	ld [hl], a
.no_sprite_skip
	dec b
	jr z, .done
	ld hl, OBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	jr .loop

.done
	; Let VBlank know that it can update the pals.
	ld a, TRUE
	ldh [hCGBPalUpdate], a

	; If this flag was set, its time to reset it.
	ld hl, wPalFlags
	res NO_DYN_PAL_APPLY_F, [hl]
	pop de
	pop bc
	pop hl
	ret

MarkUsedPal:
	push hl
	push bc
	push de

	; Check if pal is already loaded
	lb bc, 8, 0
	ld hl, wLoadedObjPal0
.loop
	cp [hl]
	jr z, .mark_in_use
	inc hl
	inc c
	dec b
	jr nz, .loop

	ld b, a
	push bc

	; Pal is not already loaded, find a empty pal slot.
	lb bc, 0, 8
	ld hl, wUsedObjectPals
	ld a, 1
	ld d, a
.search_again
	ld a, d
	and [hl]
	jr z, .found_empty
	ld a, d
	rla
	ld d, a
	inc b
	dec c
	jr nz, .search_again
.found_empty
	ld a, b
	pop bc

	; Save and remember what pal is loaded where
	ld c, a
	ld a, b
	ld b, 0
	ld hl, wLoadedObjPal0
	add hl, bc
	ld [hl], a

	; Copy the needed pal
	push bc
	ld a, c
	ld bc, 1 palettes
	ld hl, wOBPals1
	call AddNTimes
	ld d, h
	ld e, l
	farcall CopySpritePal
	pop bc

	; Set the corresponding bit in wUsedObjectPals
	; A set bit corresponds to a used OBJ Pal slot.
.mark_in_use
	push bc
	ld hl, wUsedObjectPals
	inc c
	ld a, 1
.loop3
	dec c
	jr z, .load_hl
	rla
	jr .loop3
.load_hl
	or [hl]
	ld [hl], a
	pop bc
	ld a, c

.done
	pop de
	pop bc
	pop hl
	ret

ClearSavedObjPals::
	xor a
	ld [wUsedObjectPals], a
	ld hl, wUsedObjectPals
	ld bc, wNeededPalIndex - wUsedObjectPals
	ld a, -1
	jp ByteFill
