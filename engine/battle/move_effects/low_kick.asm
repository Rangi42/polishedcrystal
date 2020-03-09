BattleCommand_lowkick:
	push bc
	push de
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonSpecies
	jr nz, .got_opp_species
	ld hl, wEnemyMonSpecies
.got_opp_species
	ld a, [hl]
	ld hl, PokedexDataPointerTable
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, BANK(PokedexDataPointerTable)
	call GetFarHalfword

	; skip the pokémon "type" (seed for bulbasaur, genetic for mewtwo, etc)
.loop
	farcall GetPokedexEntryBank
	call GetFarByte
	inc hl
	cp "@"
	jr nz, .loop

	; skip height by inc hl twice
	farcall GetPokedexEntryBank
	inc hl
	inc hl
	call GetFarHalfword ; now we have weight in hl
	ld d, h
	ld e, l

	call GetOpponentAbilityAfterMoldBreaker
	cp LIGHT_METAL
	jr nz, .not_light_metal
	srl d
	rr e

.not_light_metal
	ld hl, .WeightTable
.loop2
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	sub e
	ld a, b
	sbc d
	jr nc, .loop2
.got_power
	pop de
	ld d, c
	pop bc
	ret

.WeightTable
	;    BP, weight
	dbw 120, 4407
	dbw 100, 2202
	dbw  80, 1100
	dbw  60, 550
	dbw  40, 218
	dbw  20, 0
