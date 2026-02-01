ClearSavedObjPals::
	ldh a, [rWBK]
	push af
	ld a, BANK(wUsedObjectPals)
	ldh [rWBK], a

	xor a
	ld [wUsedObjectPals], a
	ld hl, wLoadedObjPal0
	ld bc, wNeededPalIndex - wLoadedObjPal0
	ld a, NO_PAL_LOADED
	rst ByteFill

	pop af
	ldh [rWBK], a
	ret

DisableDynPalUpdates::
	push hl
	ld hl, wPalFlags
	set DISABLE_DYN_PAL_F, [hl]
	pop hl
	ret

EnableDynPalUpdatesNoApply::
	push hl
	ld hl, wPalFlags
	set NO_DYN_PAL_APPLY_ONCE_F, [hl]
	res DISABLE_DYN_PAL_F, [hl]
	pop hl
	jr CheckForUsedObjPals

EnableDynPalUpdates::
	push hl
	ld hl, wPalFlags
	res DISABLE_DYN_PAL_F, [hl]
	pop hl
	; fallthrough to manually run CheckForUsedObjPals

CheckForUsedObjPals::
	push hl
	push de
	push bc
	push af

	ldh a, [rWBK]
	push af
	ld a, BANK(wUsedObjectPals)
	ldh [rWBK], a

	ld hl, wPalFlags
	bit DISABLE_DYN_PAL_F, [hl]
	jr nz, .done

	; reset all wUsedObjectPals bits
	xor a
	ld [wUsedObjectPals], a

	call CheckAlolanExeggutorPals

	; Scan for active objects first and mark those pals still in use.
	ld hl, wPalFlags
	set SCAN_OBJECTS_FIRST_F, [hl]
	call ScanObjectStructPals

	; Scan for active objects that still need pals loaded
	ld hl, wPalFlags
	res SCAN_OBJECTS_FIRST_F, [hl]
	call ScanObjectStructPals

	; If this flag was set, it's time to reset it
	ld hl, wPalFlags
	res NO_DYN_PAL_APPLY_ONCE_F, [hl]

.done
	pop af
	ldh [rWBK], a
	jmp PopAFBCDEHL

ScanObjectStructPals:
	ld de, wObjectStructs
	ld b, NUM_OBJECT_STRUCTS

.loop
	; Check if the object has a sprite
	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .skip

	; Check if sprite is SPRITE_MON_ICON for two-nybble palette handling
	ld c, a ; save sprite in c

	; Look up the object's requested color palette
	ld hl, OBJECT_PAL_INDEX
	add hl, de
	ld a, [hl]

	; Default: no secondary light palette
	ld hl, wNeededMonPalLight
	ld [hl], NO_PAL_LOADED

	; Check if this is SPRITE_MON_ICON with a two-nybble palette
	push af
	ld a, c
	cp SPRITE_MON_ICON
	jr nz, .not_mon_icon_pal
	; For mon icons, interpret palette as two nybbles:
	; high nybble = light color (PAL_MON_*), low nybble = dark color (PAL_MON_*)
	pop af
	push af
	ld c, a
	swap a
	and $f
	; If high nybble is same as low nybble, treat as normal palette
	ld [hl], a ; store light color palette in wNeededMonPalLight (high nybble)
	ld a, c
	and $f
	cp [hl]
	jr z, .same_nybbles
	; Check if dark nybble (low) is TAN - if so, use light as main palette
	; but still copy light's color 2 into color 1 (monochromatic)
	cp PAL_MON_TAN
	jr z, .tan_dark_color
	; Check if light nybble is TAN - if so, keep original color 1
	ld a, [hl]
	cp PAL_MON_TAN
	jr z, .tan_light_color
	; Two different nybbles - use low nybble as the main (dark) palette
	; wNeededMonPalLight already has the high nybble (light) palette
	pop af
	and $f
	jr .store_pal_index
.tan_dark_color
	; TAN as dark means use the light color as the main palette
	; wNeededMonPalLight already has the high nybble - keep it to copy color 2 into color 1
	; Use high nybble (light) as the main palette
	pop af
	swap a
	and $f
	jr .store_pal_index
.tan_light_color
	; TAN as light means use the original color 1, so no secondary copy needed
	ld a, NO_PAL_LOADED
	ld [hl], a
	; Still use low nybble as the main palette
	pop af
	and $f
	jr .store_pal_index
.same_nybbles
	; Same nybble values, treat as normal single palette
	ld a, NO_PAL_LOADED
	ld [hl], a
.not_mon_icon_pal
	pop af
.store_pal_index
	ld [wNeededPalIndex], a

	; Mark the palette in use and/or load the palette
	call MarkUsedPal
	; Then load the return into OBJECT_PALETTE, which corresponds
	; to OBJ 0 - OBJ 7
	jr nc, .skip
	and OAM_PALETTE
	ld c, a
	ld hl, OBJECT_PALETTE
	add hl, de
	ld a, [hl]
	and ~OAM_PALETTE
	or c
	ld [hl], a

.skip
	dec b
	ret z

	ld hl, OBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	jr .loop

MarkUsedPal:
	push hl
	push de
	push bc

	; Check if pal is already loaded
	lb bc, 8, 0
	ld hl, wLoadedObjPal0
.loaded_loop
	cp [hl]
	jr z, .mark_in_use
	inc hl
	inc c
	dec b
	jr nz, .loaded_loop

	; If this is the first pass, we do not want to
	; load any pals yet, just mark the still active pals
	ld hl, wPalFlags
	bit SCAN_OBJECTS_FIRST_F, [hl]
	scf
	ccf
	jr nz, .done

	ld b, a
	push bc

	; Pal is not already loaded, find a empty pal slot
	ld a, [wUsedObjectPals]
	inc a
	jr nz, .some_available
	ld b, 7
	jr .unset_bit_found
.some_available
	dec a
	ld b, -1
.bit_check_loop
	inc b
	rrca
	jr c, .bit_check_loop
.unset_bit_found
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
	rst AddNTimes
	ld d, h
	ld e, l
	call CopySpritePalHandler
	pop bc

	; Set the corresponding bit in wUsedObjectPals
	; A set bit corresponds to a used pal slot
.mark_in_use
	push bc
	ld hl, wUsedObjectPals
	inc c
	ld a, 1
.used_loop
	dec c
	jr z, .found_used
	rla
	jr .used_loop
.found_used
	or [hl]
	ld [hl], a
	pop bc
	ld a, c
	scf
.done
	jmp PopBCDEHL

CheckAlolanExeggutorPals:
	ld a, [wMapGroup]
	cp GROUP_SHAMOUTI_ISLAND
	ret nz
	ld a, [wMapNumber]
	cp MAP_SHAMOUTI_ISLAND
	ret nz

; Only Shamouti Island uses SPRITEMOVEDATA_ALOLAN_EXEGGUTOR.
; This sprite movement's facing uses NEXT_PALETTE, and assumes
; that PAL_OW_BROWN exists right after PAL_OW_GREEN.

	ld a, %00000110
	ld [wUsedObjectPals], a

	ld a, PAL_OW_GREEN
	ld [wLoadedObjPal1], a
	ld [wNeededPalIndex], a
	ld de, wOBPals1 + 1 palettes
	call CopySpritePalHandler

	ld a, PAL_OW_BROWN
	ld [wLoadedObjPal2], a
	ld [wNeededPalIndex], a
	ld de, wOBPals1 + 2 palettes
	jmp CopySpritePalHandler
