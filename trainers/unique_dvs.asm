CheckUniqueDVTrainerPokemon:
; return z if dvs are unique
	ld hl, UniqueDVTrainerPokemon
.loop
	ld a, [hli] ; TrainerClass
	cp -1
	jr z, .notunique
	ld b, a
	ld a, [OtherTrainerClass]
	cp b
	jr nz, .inc5andloop
	ld a, [hli] ; TrainerID
	ld b, a
	ld a, [OtherTrainerID]
	cp b
	jr nz, .inc4andloop
	ld a, [hli] ; PartySpecies
	ld b, a
	ld a, [CurPartySpecies]
	cp b
	jr nz, .inc3andloop
	ld a, [hli] ; Level
	ld b, a
	ld a, [CurPartyLevel]
	cp b
	jr nz, .inc2andloop
.unique
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	xor a
	and a
	ret
.inc5andloop
	inc hl
.inc4andloop
	inc hl
.inc3andloop
	inc hl
.inc2andloop
	inc hl
	inc hl
	jp .loop
.notunique
	ld a, 1
	and a
	ret

UniqueDVTrainerPokemon:
	; TrainerClass, TrainerID, PartySpecies, Level, AtkDefDV, SpdSpcDV
	db BEAUTY, CHARLOTTE, BELLOSSOM, 16, $7B, SPDSPCDV_SHINY ; female shiny
	db MYSTICALMAN, EUSINE, ELECTRODE, 27, ATKDEFDV_SHINY, SPDSPCDV_SHINY
	db LAWRENCE, 1, CHARIZARD, 62, ATKDEFDV_SHINY, SPDSPCDV_SHINY
	db CHAMPION, LANCE, DRAGONITE, 50, ATKDEFDV_SHINY, SPDSPCDV_SHINY
	db CHAMPION, LANCE2, DRAGONITE, 75, ATKDEFDV_SHINY, SPDSPCDV_SHINY
	db WILL, 2, ALAKAZAM, 61, $FE, $EE ; Hidden Power Fighting
	db -1, -1, -1, -1, -1, -1
