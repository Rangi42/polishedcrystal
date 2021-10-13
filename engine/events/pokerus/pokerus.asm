GivePokerusAndConvertBerries:
; There are four Pokerus strains in Polished Crystal:
; -- Strain 1: one-day strain, value %1111
; -- Strain 2: two-day strain, value %1110 -> %0111
; -- Strain 3: three-day strain, value %1100 -> %0110 -> %0011
; -- Strain 4: four-day strain, value %1000 -> %0100 -> %0010 -> %0001
; When a day passes with a Pokerus strain value already in the LSB, the mon is cured
	ld a, [wPartyCount]
	and a
	ret z

	ld c, a
	ld b, 0
	push bc
	call Random
	cp 1 + 33 percent
	jr nc, .done_spread

; first, we want to spread active pokerus infections
	ld hl, wPartyMon1PokerusStatus
	ld de, PARTYMON_STRUCT_LENGTH
.loop_spread
	ld a, [hl]
	and $f ; Pokerus status is the lower nybble
	jr z, .cont
	cp POKERUS_CURED
	jr z, .cont
	ld b, a

; we check if the infection can spread to the prior partymon
	ld de, PARTYMON_STRUCT_LENGTH * -1
	add hl, de
	ld a, [wPartyCount]
	cp c
	jr z, .check_next
	ld a, [hl]
	and $f
	call z, SpreadPokerus

; we check if the succeeding partymon can get infected too
.check_next
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	ld a, c
	dec a
	jr z, .cont
	push hl
	add hl, de
	ld a, [hl]
	and $f
	pop hl
	jr nz, .cont
	add hl, de
	call SpreadPokerus
	dec c ; we don't want newly infected mons to spread their infection this time around

.cont
	add hl, de
	dec c
	jr nz, .loop_spread
.done_spread
; next, we want to convert Oran Berries held by Shuckle
	pop bc
	ld b, c
	ld hl, wPartyMon1Species
.berries_loop
	assert MON_SPECIES + 1 == MON_ITEM
	ld a, [hli]
	cp LOW(SHUCKLE)
	jr nz, .no_berry_juice
	push hl
	assert !HIGH(SHUCKLE)
	ld de, MON_FORM - MON_ITEM
	add hl, de
	ld a, [hl]
	pop hl
	and EXTSPECIES_MASK
	jr nz, .no_berry_juice
	ld a, [hl]
	cp ORAN_BERRY
	jr nz, .no_berry_juice
	call Random
	and $f ; 16/256 = 1/16 chance
	jr nz, .no_berry_juice
	ld a, BERRY_JUICE
	ld [hl], a
.no_berry_juice
	ld de, PARTYMON_STRUCT_LENGTH - 1
	add hl, de
	dec c
	jr nz, .berries_loop

; finally, we check if we can infect a partymon with a new pokerus strain
	call Random
	and a
	ret nz ; 1/256 chance
	ldh a, [hRandomAdd]
	cp 3
	ret nc ; 3/256 chance (total 3/65536 chance)

; one thing to note is that while eggs can get and spread pokerus,
; they cannot get infected at random (only via spread from other party mons)
	inc c ; conveniently, c was already 0
	ld d, b
.party_loop
	dec d
	ld a, d
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .next
	ld a, c
	inc c
	call RandomRange
	and a
	jr nz, .next
	ld a, d
	ld [wCurPartyMon], a
.next
	dec b
	jr nz, .party_loop

; did we find anything? we should have, since you can't have non-eggs in your party
	dec c
	ret z
	; fall-through
ContinueGivingPokerus:
	ld a, MON_PKRUS
	call GetPartyParamLocationAndValue
	and $f
	ret nz ; did you hit the 3/65536 chance but the randomly selected mon already has pokerus? sucks to be you!
	call Random
	and 3
	inc a
	ld b, a
	ld a, %11110000
.strain_loop
	rrca
	dec b
	jr nz, .strain_loop
	and $f
	or [hl]
	ld [hl], a
	ret

GivePokerusToWonderTradeMon:
	call Random
	and a
	ret nz
	ldh a, [hRandomAdd]
	cp $20
	jr c, ContinueGivingPokerus ; 32/65536 = 1/2048 chance
	ret

SpreadPokerus:
; b: strain to infect partymon with
; hl: partymon pokerus data location
	ld a, b
	and $f
.get_strain_loop
	rlca
	cp $10
	jr c, .get_strain_loop
	rrca
	or [hl]
	ld [hl], a
	ret
