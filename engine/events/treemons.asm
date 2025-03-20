TreeItemEncounter:
	; We can't get any wings if we can't put them anywhere.
	ld a, WING_CASE
	call _CheckKeyItem
	jr nc, .no_wing

	; 10% chance for a wing
	ld a, NUM_WINGS * 10
	call RandomRange
	cp NUM_WINGS
	jr nc, .no_wing

	push af
	add a
	add LOW(wWingAmounts)
	ld l, a
	adc HIGH(wWingAmounts)
	sub l
	ld h, a

	; Check if we have 999 wings of this type.
	call .CheckWingCap ; also increments hl
	jr z, .pop_af_no_wing

	; We're not yet capped. Give 1-10 wings of this type.
	ld a, 10
	call RandomRange
	inc a
	ld [wCurWingQuantity], a
	add [hl]
	ld [hld], a
	jr nc, .no_overflow
	inc [hl]

.no_overflow
	; If we overflowed the cap, revert back to 999 wings.
	call .CheckWingCap
	jr c, .cap_not_reached
	ld [hl], LOW(999)
	assert HIGH(999) == HIGH(999 + 10)

.cap_not_reached
	; Print a message about this wing
	pop af
	ld [wNamedObjectIndex], a
	ld [wCurWing], a
	call GetWingName

	ld hl, wStringBuffer1
	ld a, [wCurWingQuantity]
	dec a
	jr z, .no_plural
	push hl
.find_terminator
	ld a, [hli]
	cp "@"
	jr nz, .find_terminator
	dec hl
	ld a, "s"
	ld [hli], a
	ld [hl], "@"
	pop hl
.no_plural
	ld de, wStringBuffer4
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes

	ld a, TRUE
	jr .done

.pop_af_no_wing
	pop af
.no_wing
	xor a
.done
	ldh [hScriptVar], a
	ret

.CheckWingCap:
	ld a, [hli]
	cp HIGH(999)
	ret c
	ld a, [hl]
	cp LOW(999)
	ret

GetWings:
	ldh a, [hScriptVar]
	add LOW(wWingAmounts - 2)
	ld l, a
	adc HIGH(wWingAmounts - 2)
	sub l
	ld h, a
	ret

RockItemEncounter:
	ld hl, RockItems
	call Random
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	jr .loop
.ok
	ld a, [hli]
	cp -1
	ld a, NO_ITEM
	jr z, .done
	ld a, [hl]
.done
	ldh [hScriptVar], a
	ret

INCLUDE "data/items/rock_items.asm"

	const_def
	const TREEMON_NO_ENCOUNTER
	const TREEMON_ENCOUNTER
	const TREEMON_NO_ENCOUNTER_SET

TreeMonEncounter:
	xor a
	ld [wTempWildMonSpecies], a
	ld [wCurPartyLevel], a

	ld hl, TreeMonMaps
	call GetTreeMonSet
	jr nc, .no_tree_mon_set

	call GetTreeMons
	jr nc, .no_battle

	call GetTreeMon
	jr nc, .no_battle

	ld a, BATTLETYPE_TREE
	ld [wBattleType], a
	ld a, TREEMON_ENCOUNTER
	ldh [hScriptVar], a
	ret

.no_battle
	xor a ; TREEMON_NO_ENCOUNTER
	ldh [hScriptVar], a
	ret

.no_tree_mon_set
	ld a, TREEMON_NO_ENCOUNTER_SET
	ldh [hScriptVar], a
	ret

RockMonEncounter:
	xor a
	ld [wTempWildMonSpecies], a
	ld [wCurPartyLevel], a

	ld hl, RockMonMaps
	call GetTreeMonSet
	jr nc, .no_battle

	call GetTreeMons
	jr nc, .no_battle

	ld a, 10
	call RandomRange
	cp 4
	jr nc, .no_battle

	call SelectTreeMon
	ret c

.no_battle
	xor a
	ret

GetTreeMonSet:
; Return carry and treemon set in a
; if the current map is in table hl.
	ld a, [wMapNumber]
	ld e, a
	ld a, [wMapGroup]
	ld d, a
.loop
	ld a, [hli]
	cp -1
	jr z, .not_in_table

	cp d
	jr nz, .skip2

	ld a, [hli]
	cp e
	jr nz, .skip1

	jr .in_table

.skip2
	inc hl
.skip1
	inc hl
	jr .loop

.not_in_table
	xor a
	ret

.in_table
	ld a, [hl]
	scf
	ret

INCLUDE "data/wild/treemon_maps.asm"

GetFishingGroup:
; Return carry and fishgroup in a
; if the current map is in FishMonMaps.
	push de
	push hl
	push bc

	ld hl, FishMonMaps
	call GetTreeMonSet

	jmp PopBCDEHL

INCLUDE "data/wild/fishmon_maps.asm"

GetRockSmashLocations:
; Writes to wDexAreaMons. Assumes we're in the correct WRAM bank for this.
; Parameters: e = type, d = region, c = species, b = form.
	push de
	xor a
	ld d, TREEMON_SET_ROCK
	jr GetTreeOrRockLocations

GetHeadbuttLocations:
; Writes to wDexAreaMons. Assumes we're in the correct WRAM bank for this.
; Parameters: e = type, d = region, c = species, b = form.
	push de
	xor a
	ld d, a
	; fallthrough
GetTreeOrRockLocations:
	; Clear area locator data.
	ld hl, wDexAreaValidTreeGroups
	push bc
	ld bc, NUM_TREEMON_SETS
	rst ByteFill
	pop bc

	; Figure out which treemon sets have this mon.

	; If this loop finishes with carry flag still set, return afterwards since
	; we didn't find anything.
	scf
	push af
.moncheck_loop
	ld a, d
	call GetTreeMons

	; The rock set only has one wildmon table, not 2 for common and rare.
	ld a, d
	cp TREEMON_SET_ROCK
	ccf
	call nc, .CheckTable
	; For whatever reason, headbutt encounters use 2 tables per set, each using
	; a seperator. Thus, we perform the mon check twice...
	call c, .CheckTable
	call nc, .AppendTreeSet ; This function screws with previously pushed af.
	inc d
	ld a, d
	cp TREEMON_SET_ROCK
	jr c, .moncheck_loop

	ld hl, TreeMonMaps
	jr z, .got_map_table
	ld hl, RockMonMaps
.got_map_table
	; Check if the mon occupies any slot
	pop af
	pop de
	ret c
	; fallthrough
.CheckMaps:
	; The mon occupies at least one slot. Iterate TreeMonMaps for all maps with
	; headbutt groups the mon is a part of.
	ld a, d ; region
	scf
	push af
	ld b, HIGH(wDexAreaValidGroups)
.loop
	ld a, [hli]
	ld d, a
	inc a
	jr z, .end_of_maps
	ld a, [hli]
	ld e, a
	ld a, [hli]
	add LOW(wDexAreaValidGroups)
	ld c, a
	ld a, [bc]
	and a
	jr z, .loop

	pop af

	; Resets carry if insertion succeeded.
	call Pokedex_SetWildLandmark_MaintainNoCarry
	push af
	jr .loop

.end_of_maps
	pop af
	ret

.CheckTable:
; Checks if the headbutt table in hl has the given mon in bc. Return nc if yes.
	ld a, [hli]
	add 1 ; no-optimize a++|a-- (sets carry if we found the -1 terminator)
	ret c

	ld a, [hli]
	cp c
	ld a, [hli]
	inc hl ; skip level
	jr nz, .CheckTable
	call DexCompareWildForm
	jr nz, .CheckTable
	ret

.AppendTreeSet:
	ld a, LOW(wDexAreaValidTreeGroups)
	add d
	ld h, HIGH(wDexAreaValidTreeGroups)
	ld l, a
	ld [hl], 1

	; Resets carry on previously pushed af.
	pop hl ; return addr
	pop af
	and a
	push af
	jp hl

GetTreeMons:
; Return the address of TreeMon table a in hl.
; Return nc if table a doesn't exist.

	cp NUM_TREEMON_SETS
	ret nc

	add a
	add LOW(TreeMons)
	ld l, a
	adc HIGH(TreeMons)
	sub l
	ld h, a

	ld a, [hli]
	ld h, [hl]
	ld l, a

	scf
	ret

INCLUDE "data/wild/treemons.asm"

GetTreeMon:
	push hl
	call GetTreeScore
	pop hl
	and a ; 0?
	jr z, .bad
	dec a ; 1?
	jr z, .good
	dec a ; 2?
	jr z, .rare
	ret

.bad
	ld a, 10
	call RandomRange
	and a
	jr nz, NoTreeMon
	jr SelectTreeMon

.good
	ld a, 10
	call RandomRange
	cp 5
	jr nc, NoTreeMon
	jr SelectTreeMon

.rare
	ld a, 10
	call RandomRange
	cp 8
	jr nc, NoTreeMon
.skip
	ld a, [hli]
	cp -1
	jr nz, .skip
	; fallthrough

SelectTreeMon:
; Read a TreeMons table and pick one monster at random.
	ld a, 100
	call RandomRange
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	inc hl
	inc hl
	jr .loop

.ok
	ld a, [hli]
	cp -1
	jr z, NoTreeMon

	push hl
	farcall SetBadgeBaseLevel
	pop hl
	ld a, [hli]
	ld [wTempWildMonSpecies], a
	ld a, [hli]
	ld [wCurForm], a
	ld [wWildMonForm], a
	ld a, [hl]
	farcall AdjustLevelForBadges
	ld [wCurPartyLevel], a
	scf
	ret

NoTreeMon:
	xor a
	ld [wTempWildMonSpecies], a
	ld [wCurPartyLevel], a
	ret

GetTreeScore:
	call .CoordScore
	ld [wBuffer1], a
	call .OTIDScore
	ld [wBuffer2], a
	ld c, a
	ld a, [wBuffer1]
	sub c
	jr z, .rare
	jr nc, .ok
	add 10
.ok
	cp 5
	jr c, .good

.bad
	xor a
	ret

.good
	ld a, 1
	ret

.rare
	ld a, 2
	ret

.CoordScore:
	call GetFacingTileCoord
	ld hl, 0
	ld c, e
	ld b, 0
	ld a, d

	and a
	jr z, .next
.loop
	add hl, bc
	dec a
	jr nz, .loop
.next

	add hl, bc
	ld c, d
	add hl, bc

	ld a, h
	ldh [hDividend], a
	ld a, l
	ldh [hDividend + 1], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	farcall Divide

	ldh a, [hQuotient + 1]
	ldh [hDividend], a
	ldh a, [hQuotient + 2]
	ldh [hDividend + 1], a
	ld a, 10
	ldh [hDivisor], a
	ld b, 2
	farcall Divide

	ldh a, [hQuotient + 3]
	ret

.OTIDScore:
	ld a, [wPlayerID]
	ldh [hDividend], a
	ld a, [wPlayerID + 1]
	ldh [hDividend + 1], a
	ld a, 10
	ldh [hDivisor], a
	ld b, 2
	farcall Divide
	ldh a, [hQuotient + 3]
	ret
