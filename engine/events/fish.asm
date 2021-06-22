Fish:
; Using a fishing rod.
; Fish for monsters with rod e in encounter group d.
; Return monster e at level d.

	push hl
	push bc
	push af

	ld b, e
	call GetFishGroupIndex

	ld hl, FishGroups
rept FISHGROUP_DATA_LENGTH
	add hl, de
endr
	call .Fish

	pop af
	pop bc
	pop hl
	ret

.Fish:
; Fish for monsters with rod b from encounter data in FishGroup at hl.
; Return monster e at level d; or item e if d = 0; or nothing if de = 0.

	call Random
	cp [hl]
	jr c, .bite
	inc hl
	cp [hl]
	jr nc, .no_bite

	; Get item by rod
	; 0: Old
	; 1: Good
	; 2: Super
	ld hl, FishItems
	ld e, b
	ld d, 0
	add hl, de
	ld a, [hl]
	ld e, a
	ret

.bite
	; Get encounter data by rod:
	; 0: Old
	; 1: Good
	; 2: Super
	inc hl
	inc hl
	ld e, b
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Compare the encounter chance to select a Pokemon.
	call Random
.loop
	cp [hl]
	jr z, .ok
	jr c, .ok
	inc hl
	inc hl
	inc hl
	jr .loop
.ok
	inc hl

	; Species 0 reads from a time-based encounter table.
	ld a, [hli]
	ld d, a
	and a
	call z, .TimeEncounter

	ld e, [hl]
	ret

.no_bite
	ld de, 0
	ret

.TimeEncounter:
	; The level byte is repurposed as the index for the new table.
	ld e, [hl]
	ld d, 0
	ld hl, TimeFishGroups
rept 4
	add hl, de
endr

	ld a, [wTimeOfDay]
	and 3
	cp NITE
	jr c, .time_species
	inc hl
	inc hl

.time_species
	ld d, [hl]
	inc hl
	ret

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
	dec d
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
