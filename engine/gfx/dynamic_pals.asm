ClearSavedObjPals::
	ldh a, [rWBK]
	push af
	ld a, BANK(wUsedObjectPals)
	ldh [rWBK], a

	xor a
	ld [wUsedObjectPals], a
	ld [wNeededPalType], a
	ld [wLoadedObjPalType], a
	ld [wNeededObjPalGlow], a
	ld [wPrevNeededObjPalGlow], a
	ld hl, wLoadedObjPalGlows
	ld bc, 16
	rst ByteFill
	ld hl, wObjectPrevGlowTypes
	assert wObjectPrevGlowTypes + NUM_OBJECT_STRUCTS == wObjectGlowFadeActive
	ld bc, NUM_OBJECT_STRUCTS + 1 ; also clear wObjectGlowFadeActive
	rst ByteFill
	ld hl, wLoadedObjPal0
	ld bc, wNeededPalIndex - wLoadedObjPal0
	assert NO_PAL_LOADED == -1
	dec a
	ld [wNeededMonPalLight], a
	rst ByteFill

	pop af
	ldh [rWBK], a
	ret

RefreshLoadedObjPals::
; Rebuild the palettes already assigned to OBJ slots after a palette-state
; change, without clearing the assignments and rescanning every object.
	push af
	push bc
	push de
	push hl

	ldh a, [rWBK]
	push af
	ld a, BANK(wLoadedObjPal0)
	ldh [rWBK], a

	ld hl, wLoadedObjPal0
	xor a
	ld c, a ; palette slot index
.loop
	; Ignore cached slots that no active object currently uses.
	ld a, [wUsedObjectPals]
	ld b, c
	inc b
.used_shift
	dec b
	jr z, .used_shifted
	rrca
	jr .used_shift
.used_shifted
	and 1
	jr z, .next

	ld a, [hl]
	cp NO_PAL_LOADED
	jr z, .next
	push af
	xor a
	ld [wNeededPalType], a
	assert NO_PAL_LOADED == -1
	dec a
	ld [wNeededMonPalLight], a

	; Restore this slot's normal/mon palette type.
	ld a, [wLoadedObjPalType]
	ld b, c
	inc b
.type_shift
	dec b
	jr z, .type_shifted
	rrca
	jr .type_shift
.type_shifted
	and 1
	ld [wNeededPalType], a
	jr z, .normal_palette
	pop af
	ld b, a
	and $f
	ld [wNeededPalIndex], a
	ld a, b
	swap a
	and $f
	ld b, a
	ld a, [wNeededPalIndex]
	cp b
	jr z, .got_palette
	ld a, b
	ld [wNeededMonPalLight], a
	jr .got_palette

.normal_palette
	pop af
	ld [wNeededPalIndex], a

.got_palette
	push hl
	ld a, c
	add LOW(wLoadedObjPalGlows)
	ld l, a
	adc HIGH(wLoadedObjPalGlows)
	sub l
	ld h, a
	ld a, [hl]
	ld [wNeededObjPalGlow], a
	ld a, c
	add LOW(wLoadedObjPalPrevGlows)
	ld l, a
	adc HIGH(wLoadedObjPalPrevGlows)
	sub l
	ld h, a
	ld a, [hl]
	ld [wPrevNeededObjPalGlow], a

	; de = wOBPals1 palette c
	ld a, c
	add a
	add a
	add a
	add LOW(wOBPals1)
	ld e, a
	adc HIGH(wOBPals1)
	sub e
	ld d, a
	pop hl
	push bc
	call CopyObjectSpritePalHandler
	pop bc

.next
	inc hl
	inc c
	ld a, c
	cp 8
	jr nz, .loop

	pop af
	ldh [rWBK], a
	pop hl
	pop de
	pop bc
	pop af
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

	; Keep glow state synchronized for newly spawned/reused object structs too.
	ld a, TRUE ; derive collisions from coordinates during full palette scans
	call RefreshObjectGlowTypes
	xor a
	ld [wNeededObjPalGlow], a

	; reset all wUsedObjectPals bits
	xor a
	ld [wUsedObjectPals], a

	; Initialize transient palette state before dual pal check
	ld [wNeededPalType], a ; a = 0 = normal
	assert NO_PAL_LOADED == -1
	dec a
	ld [wNeededMonPalLight], a

	call CheckDualObjectPals

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
	jmp z, .skip

	; Look up this object's collision-driven glow type.
	ld a, b
	cpl
	add NUM_OBJECT_STRUCTS + 1 ; a = NUM_OBJECT_STRUCTS - a
	ld c, a
	add LOW(wObjectGlowTypes)
	ld l, a
	adc HIGH(wObjectGlowTypes)
	sub l
	ld h, a
	ld a, [hl]
	ld [wNeededObjPalGlow], a
	ld a, c
	add LOW(wObjectPrevGlowTypes)
	ld l, a
	adc HIGH(wObjectPrevGlowTypes)
	sub l
	ld h, a
	bit OBJ_GLOW_TRANSITION_F, [hl]
	ld a, [wNeededObjPalGlow]
	jr z, .got_previous_glow
	ld a, [hl]
	and ~OBJ_GLOW_TRANSITION
.got_previous_glow
	ld [wPrevNeededObjPalGlow], a
	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]

	; Look up the object's requested color palette
	ld hl, OBJECT_PAL_INDEX
	add hl, de
	ld c, [hl]

	; Default: no secondary light palette
	ld hl, wNeededMonPalLight
	ld [hl], NO_PAL_LOADED

	; Resolve variable sprites to their current sprite IDs first.
.resolve_variable_sprite
	cp SPRITE_VARS
	jr c, .check_mon_sprite_range
	sub SPRITE_VARS
	push de
	push hl
	ld e, a
	ld d, 0
	ld hl, wVariableSprites
	add hl, de
	ld a, [hl]
	pop hl
	pop de
	and a
	jr z, .not_mon_icon_pal
	jr .resolve_variable_sprite

.check_mon_sprite_range
	; SPRITE_AQUARIUM_MON uses Pokémon icon *graphics* but not *palettes*.
	cp SPRITE_AQUARIUM_MON
	jr z, .not_mon_icon_pal
	; For SPRITE_POKEMON..(SPRITE_VARS - 1), interpret palette as two nybbles:
	; high nybble = light color (PAL_MON_*), low nybble = dark color (PAL_MON_*)
	cp SPRITE_POKEMON
	jr c, .not_mon_icon_pal

.mon_icon_pal
	ld a, c
	swap a
	and $f
	; If high nybble is same as low nybble, treat as normal palette
	ld [hl], a ; store light color palette in wNeededMonPalLight (high nybble)
	ld a, c
	and $f
	cp [hl]
	jr nz, .store_pal_index
	; Same nybble values, treat as normal single palette
	ld [hl], NO_PAL_LOADED

.not_mon_icon_pal
	ld a, c
.store_pal_index
	ld [wNeededPalIndex], a

	; Determine palette type and build a unique slot ID for MarkUsedPal.
	; Normal palettes: ID = palette index, type = 0
	; Mon palettes: ID = (light << 4) | dark, type = 1
	ld c, a
	ld a, [wNeededMonPalLight]
	assert NO_PAL_LOADED == -1
	inc a
	jr z, .set_pal_type
	dec a
	; Mon palette: combine both nybbles for unique slot matching
	swap a
	or c
	ld c, a ; c = combined ID
	ld a, 1
.set_pal_type
	ld [wNeededPalType], a
	ld a, c

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
	jmp .loop

MarkUsedPal:
	push de
	push bc
	ld d, a ; preserve the requested palette ID in a free internal register

	; Check if pal is already loaded (must match both index and type)
	lb bc, 8, 0
	ld hl, wLoadedObjPal0
.loaded_loop
	ld a, d
	cp [hl]
	jr nz, .not_loaded_here
	; Palette index matches - also check type
	ld a, [wLoadedObjPalType]
	ld e, c
	inc e
.type_shift
	dec e
	jr z, .type_shifted
	rrca
	jr .type_shift
.type_shifted
	and 1 ; bit 0 = type of this slot
	ld e, a
	ld a, [wNeededPalType]
	cp e
	jr nz, .not_loaded_here
	; The same base palette may need separate glow-transition slots.
	ld a, c
	add LOW(wLoadedObjPalGlows)
	ld l, a
	adc HIGH(wLoadedObjPalGlows)
	sub l
	ld h, a
	ld a, [wNeededObjPalGlow]
	cp [hl]
	jr nz, .glow_mismatch
	ld a, c
	add LOW(wLoadedObjPalPrevGlows)
	ld l, a
	adc HIGH(wLoadedObjPalPrevGlows)
	sub l
	ld h, a
	ld a, [wPrevNeededObjPalGlow]
	cp [hl]
	jr z, .mark_in_use
	; fallthrough
.glow_mismatch
	ld a, c
	add LOW(wLoadedObjPal0)
	ld l, a
	adc HIGH(wLoadedObjPal0)
	sub l
	ld h, a
.not_loaded_here
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

	; Save and remember what pal is loaded where
	ld c, b
	ld a, d
	ld b, 0
	ld hl, wLoadedObjPal0
	add hl, bc
	ld [hl], a
	ld hl, wLoadedObjPalGlows
	add hl, bc
	ld a, [wNeededObjPalGlow]
	ld [hl], a
	ld hl, wLoadedObjPalPrevGlows
	add hl, bc
	ld a, [wPrevNeededObjPalGlow]
	ld [hl], a

	; Store the palette type for this slot (set/clear bit c in wLoadedObjPalType)
	ld a, 1
	ld e, c
	inc e
.type_set_shift
	dec e
	jr z, .type_set_done
	add a
	jr .type_set_shift
.type_set_done
	ld e, a ; e = bit mask for slot c
	ld a, [wNeededPalType]
	and a
	ld a, [wLoadedObjPalType]
	jr z, .clear_type_bit
	or e
	jr .store_type
.clear_type_bit
	ld d, a
	ld a, e
	cpl
	and d
.store_type
	ld [wLoadedObjPalType], a

	; Copy the needed pal
	push bc
	ld a, c
	ld bc, 1 palettes
	ld hl, wOBPals1
	rst AddNTimes
	ld d, h
	ld e, l
	call CopyObjectSpritePalHandler
	pop bc

	; Set the corresponding bit in wUsedObjectPals
	; A set bit corresponds to a used pal slot
.mark_in_use
	ld hl, wUsedObjectPals
	ld e, c
	inc e
	ld a, 1
.used_loop
	dec e
	jr z, .found_used
	add a
	jr .used_loop
.found_used
	or [hl]
	ld [hl], a
	ld a, c
	scf
.done
	pop bc
	pop de
	ret

CheckDualObjectPals:
	ld a, [wMapGroup]
	ld d, a
	ld a, [wMapNumber]
	ld e, a
	ld hl, DualObjectPalettes
.loop
	ld a, [hli]
	inc a
	ret z
	dec a
	cp d
	ld a, [hli]
	jr nz, .next
	cp e
	jr z, .found
.next
	inc hl
	inc hl
	jr .loop

.found
	ld a, %00000110
	ld [wUsedObjectPals], a
	; Clear type bits for slots 1 and 2 (these are normal palettes, not mon palettes)
	ld a, [wLoadedObjPalType]
	and ~%00000110
	ld [wLoadedObjPalType], a
	ld a, [hli]
	ld [wLoadedObjPal1], a
	ld [wNeededPalIndex], a
	ld de, wOBPals1 + 1 palettes
	ld a, [hl]
	push af
	call CopySpritePalHandler
	pop af
	ld [wLoadedObjPal2], a
	ld [wNeededPalIndex], a
	ld de, wOBPals1 + 2 palettes
	jmp CopySpritePalHandler

UpdateObjectGlowPals::
; Update each active object's collision-driven glow type. Reassign dynamic
; palettes only when an object has entered or left a glow cell, and make that
; change part of the current overworld fade (or initiate one if needed).
	ldh a, [rWBK]
	push af
	ld a, BANK(wObjectGlowTypes)
	ldh [rWBK], a

	; Once the fade finishes, stable palettes no longer need distinct
	; previous/current glow identities. Re-scan to deduplicate those slots.
	ld a, [wObjectGlowFadeActive]
	and a
	jr z, .check_collisions
	farcall CheckPaletteFading
	jr nz, .check_collisions
	xor a
	ld [wObjectGlowFadeActive], a
	ld hl, wObjectPrevGlowTypes
	ld bc, NUM_OBJECT_STRUCTS
	rst ByteFill
	call CheckForUsedObjPals

.check_collisions
	xor a ; use the movement system's cached collision during per-frame checks
	call RefreshObjectGlowTypes
	and a
	jr z, .done

	; Preserve an already-running time/weather/map fade. The object palette
	; loader will rebuild both endpoints and catch the new palette up to it.
	farcall CheckPaletteFading
	jr nz, .fade_ready
	call SavePrevPalStates
	farcall OWFadePalettesInit
.fade_ready
	ld a, TRUE
	ld [wObjectGlowFadeActive], a
	call CheckForUsedObjPals

.done
	pop af
	ldh [rWBK], a
	ret

RefreshObjectGlowTypes:
; Return nz if any object's OBJ_GLOW_* state changed.
; The bank containing wObjectStructs/wObjectGlowTypes must be selected.
	ld [wNeededObjPalGlow], a ; nonzero = derive collision without a transition
	ld de, wObjectStructs
	ld hl, wObjectGlowTypes
	lb bc, NUM_OBJECT_STRUCTS, FALSE
.loop
	ld a, [de] ; OBJECT_SPRITE
	and a
	jr nz, .active_object
	; Despawned object slots do not need a visible exit transition.
	ld a, [hl]
	and a
	jr z, .next
	xor a
	ld [hl], a
	push hl
	push de
	ld de, wObjectPrevGlowTypes - wObjectGlowTypes
	add hl, de
	ld [hl], a
	pop de
	pop hl
	jr .next
.active_object
	push hl
	ld a, [wNeededObjPalGlow]
	and a
	jr z, .cached_collision
	push bc
	push de
	ld hl, OBJECT_MAP_X
	add hl, de
	ld a, [hli]
	ld e, [hl]
	ld d, a
	call GetCoordTileCollision
	pop de
	pop bc
	jr .got_collision
.cached_collision
	ld hl, OBJECT_TILE_COLLISION
	add hl, de
	ld a, [hl]
.got_collision
	push de
	ld hl, GlowCollisions
	ld d, a
.lookup
	ld a, [hli]
	and a
	jr z, .got_obj_glow
	cp d
	ld a, [hli]
	jr z, .got_obj_glow
	jr .lookup
.got_obj_glow
	pop de
	pop hl
	ld [wPrevNeededObjPalGlow], a ; temporarily preserve the new glow
	cp [hl]
	jr z, .next
	ld a, [wNeededObjPalGlow]
	and a
	ld a, 0 ; no-optimize a = 0
	jr nz, .store_previous
	ld a, [hl]
	or OBJ_GLOW_TRANSITION
.store_previous
	push hl
	push de
	ld de, wObjectPrevGlowTypes - wObjectGlowTypes
	add hl, de
	ld [hl], a
	pop de
	pop hl
	ld a, [wPrevNeededObjPalGlow]
	ld [hl], a
	inc c
.next
	inc hl
	ld a, OBJECT_LENGTH
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	dec b
	jr nz, .loop
	ld a, c
	and a
	ret

INCLUDE "data/collision/glow_collisions.asm"
INCLUDE "data/maps/dual_obj_pals.asm"
