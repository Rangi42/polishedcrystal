Fish:
; Using a fishing rod.
; Fish for monsters with rod e in encounter group d.
; Return monster bc at level d.

	push hl
	push af

	ld b, e
	call GetFishGroupIndex

	ld hl, FishGroups
rept FISHGROUP_DATA_LENGTH
	add hl, de
endr
	call .Fish

	pop af
	pop hl
	ret

.Fish:
; Fish for monsters with rod b from encounter data in FishGroup at hl.
; Return monster bc at level d; or item bc if d = 0; or nothing if bc = 0 and d = 0.

	ld e, b
	ld d, 0
	call Random
	cp [hl]
	jr c, .bite
	inc hl
	cp [hl]
	jr nc, .no_bite

	; Get item by rod
	; 0: Old
	; 1: Good
	; 2: Super (10% of the time)
	ld a, b
	cp 2
	jr c, .not_super
	ld a, 10
	call RandomRange
	and a
	jr nz, .no_bite

.not_super
	ld hl, FishItems
	add hl, de
	ld c, [hl]
	ld b, d ; ld b, 0
	ret

.bite
	; Get encounter data by rod:
	; 0: Old
	; 1: Good
	; 2: Super
	inc hl
	inc hl
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Compare the encounter chance to select a Pokemon.
	call Random
.loop
	cp [hl]
	inc hl
	jr z, .ok
	jr c, .ok
	inc hl
	inc hl
	inc hl
	jr .loop
.ok
	ld a, [hli]
	ld c, a

	ld a, [hli]
	ld b, a
	ld d, [hl]
	ret

.no_bite
	ld b, d ; d already = 0
	ld c, d
	ret

GetFishLocations:
; Writes to wDexAreaMons. Assumes we're in the correct WRAM bank for this.
; Parameters: e = type, d = region, c = species, b = form.
	; Clear area locator data.
	ld hl, wDexAreaValidFishGroups
	push bc
	ld bc, NUM_FISHGROUPS
	xor a
	rst ByteFill
	pop bc

	push de

	; If this loop finishes with carry flag still set, return afterwards since
	; we didn't find anything.
	scf
	push af
	ld d, a

	; By doubling e, we can use it as an offset into the
	; FishGroup pointer tables, as long as we account for constant offsets
	; when reading from it.
	sla e
.moncheck_loop
	call .GetFishTable
	call .CheckTable
	call nc, .AppendFishSet ; This function screws with previously pushed af.
	inc d
	ld a, d
	cp NUM_FISHGROUPS
	jr c, .moncheck_loop

	; Check if the mon occupies any slot. We have to do this before
	; the farjp (despite code duplication) because farjp screws with
	; the stack.
	pop af
	pop de
	ret c

	assert wDexAreaValidTreeGroups == wDexAreaValidFishGroups

	; TODO: fix labels, we don't want "call/jp a.b"...
	ld hl, FishMonMaps
	farjp GetTreeOrRockLocations.CheckMaps

.GetFishTable:
; Returns the relevant fishing table in hl.
; d: fish group, e: rod type with an offset.
	; The fish group pointer table is 8 bytes per entry.
	ld a, d
	add a
	add a
	add a

	; e contains DEXAREA_(OLD|GOOD|SUPER)_ROD*2. Factor that into
	; initial hl.
	; + 2 skips the percent values which we don't care for.
	push de
	ld hl, FishGroups + 2 - (DEXAREA_OLD_ROD * 2)

	; Get the correct rod table.
	ld d, 0
	add hl, de

	; Get the correct group table.
	ld e, a
	add hl, de
	pop de

	; Return the table pointed to in hl + 1 (ignore encounter rate).
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ret

.CheckTable:
	; Old Rod encounters have 3 entries, good+super has 4.
	push de
	ld d, 3 ; iterator
	ld a, e
	cp DEXAREA_OLD_ROD * 2
	jr z, .checktable_loop
	inc d
.checktable_loop
	; Return carry if d==0 before decrement
	ld a, d
	dec d
	cp d
	jr nc, .continue
	pop de
	ret

.continue
	ld a, [hli]
	cp c
	ld a, [hli]
	inc hl ; skip level
	inc hl ; skip (next entry's) encounter rate
	jr nz, .checktable_loop
	call DexCompareWildForm
	jr nz, .checktable_loop

	; Returns noncarry if species+form matches.
	pop de
	ret

.AppendFishSet:
	ld a, LOW(wDexAreaValidFishGroups)
	add d
	ld h, HIGH(wDexAreaValidFishGroups)
	ld l, a
	ld [hl], 1

	; Resets carry on previously pushed af.
	pop hl ; return addr
	pop af
	and a
	push af
	jp hl

GetFishGroupIndex:
; Return the index of fishgroup d in de.

	push hl
	ld hl, wDailyFlags
	bit 2, [hl] ; ENGINE_FISH_SWARM
	pop hl
	jr z, .done

	ld a, d
	cp FISHGROUP_QWILFISH
	jr z, .qwilfish
	cp FISHGROUP_REMORAID
	jr z, .remoraid

.done
	ld e, d
	ld d, 0
	ret

.qwilfish
	ld a, [wFishingSwarmFlag]
	cp FISHSWARM_QWILFISH
	jr nz, .done
	ld d, FISHGROUP_QWILFISH_SWARM
	jr .done

.remoraid
	ld a, [wFishingSwarmFlag]
	cp FISHSWARM_REMORAID
	jr nz, .done
	ld d, FISHGROUP_REMORAID_SWARM
	jr .done

INCLUDE "data/wild/fish.asm"
INCLUDE "data/items/fish_items.asm"
