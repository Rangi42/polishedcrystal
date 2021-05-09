_FindThatSpeciesYourTrainerID:
	call FindThatSpecies
	ret z
	ld a, e
	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .nope
	inc hl
	ld a, [wPlayerID + 1]
	cp [hl]
	jr nz, .nope
	ld a, $1
	and a
	ret

.nope
	xor a
	ret

FindThatSpecies:
; Find species/extspecies bc in your party.
; If you have no Pokemon, returns e = -1 and z.
; If that species is in your party, returns its location in c, and nz.
; Otherwise, returns z.
	ld e, -1
	ld a, [wPartyCount]
	ld d, a
	and a
	ret z
	inc e
	ld hl, wPartyMon1Species
.loop
	ld a, [hl]
	push de
	ld de, MON_FORM - MON_SPECIES
	add hl, de
	pop de
	cp b
	jr nz, .next
	ld a, [hl]
	and EXTSPECIES_MASK
	cp c
	jr nz, .next
	and a
	ret

.next
	inc e
	ld a, d
	cp e
	ret z
	push de
	ld de, PARTYMON_STRUCT_LENGTH - MON_FORM
	add hl, de
	pop de
	jr .loop
