GivePokerusAndConvertBerries:
; There are four Pokerus strains in Polished Crystal:
; -- Strain 1: one-day strain, value %1111
; -- Strain 2: two-day strain, value %0111 -> %1110
; -- Strain 3: three-day strain, value %0011 -> %0110 -> %1100
; -- Strain 4: four-day strain, value %0001 -> %0010 -> %0100 -> %1000
; When a day passes with a Pokerus strain value already in bit 3 (then rotated left out of the nibble), the mon is cured
	ld a, [wPartyCount]
	and a
	ret z

	ld c, a
	ld b, 0
	push bc

; first, check if we should infect a partymon de novo
	call Random
	and a
	jr nz, .check_spread ; 1/256 chance
	ldh a, [hRandomAdd]
	cp 3
	jr nc, .check_spread ; 3/256 chance (total 3/65536 chance)

; one thing to note is that while eggs can get and spread pokerus,
; they cannot get infected at random (only via spread from other party mons)
	inc b
	ld d, c ; we'd rather preserve c
.party_loop
	ld a, d
	dec a
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .next
	ld a, b
	inc b
	call RandomRange
	and a
	jr nz, .next
	ld a, d
	dec a
	ld [wCurPartyMon], a
.next
	dec d
	jr nz, .party_loop

; did we find anything? we should have, since you can't have non-eggs in your party
	dec b
	call nz, ContinueGivingPokerus
	; bc should = 0:party count, but c is unmodified and ContinueGivingPokerus returns b = 0
.check_spread
; spread active infections (this includes any mons that were just infected de novo)
	call Random
	cp 1 + 33 percent
	jr nc, .done_spread

; find any party mons with active infections
	ld hl, wPartyMon1PokerusStatus
	ld de, PARTYMON_STRUCT_LENGTH
.loop_spread
	ld a, [hl]
	and POKERUS_MASK ; Pokerus status is the lower nybble
	jr z, .cont
	cp POKERUS_CURED
	jr z, .cont
	ld b, a

; check if the infection can spread to the prior partymon
	ld de, PARTYMON_STRUCT_LENGTH * -1
	add hl, de
	ld a, [wPartyCount]
	cp c
	jr z, .check_next
	ld a, [hl]
	and POKERUS_MASK
	call z, .SpreadPokerus

; check if the succeeding partymon can get infected too
.check_next
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	ld a, c
	dec a
	jr z, .cont
	push hl
	add hl, de
	ld a, [hl]
	and POKERUS_MASK
	pop hl
	jr nz, .cont
	add hl, de
	call .SpreadPokerus
	dec c ; newly infected mons shouldn't spread their infection yet (this differs from de novo infections)

.cont
	add hl, de
	dec c
	jr nz, .loop_spread

.done_spread
; convert Oran Berries held by Shuckle to Berry Juice
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
	ld [hl], BERRY_JUICE
.no_berry_juice
	ld de, PARTYMON_STRUCT_LENGTH - 1
	add hl, de
	dec c
	jr nz, .berries_loop
	ret

.SpreadPokerus:
; b: strain to infect partymon with
; hl: partymon pokerus data location
	ld a, b
	and POKERUS_MASK
.get_strain_loop
	rra
	jr nc, .get_strain_loop
	rla
	or [hl]
	ld [hl], a
	ret

GivePokerusToWonderTradeMon:
	call Random
	and a
	ret nz
	ldh a, [hRandomAdd]
	cp $20
	ret nc
	; fall-through
ContinueGivingPokerus:
; uses wCurPartyMon as a parameter
; b = 0 as output (useful for GivePokerusAndConvertBerries)
	ld a, MON_PKRUS
	call GetPartyParamLocationAndValue
	and POKERUS_MASK
	ret nz ; hit the 3/65536 chance but the randomly selected mon already has pokerus? tough luck!
	call Random
	and 3
	inc a
	ld b, a
	ld a, POKERUS_MASK << 1
.strain_loop
	srl a
	dec b
	jr nz, .strain_loop
	or [hl]
	ld [hl], a
	ret
