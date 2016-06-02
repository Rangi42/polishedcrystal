CheckShinyTrainerPokemon:
; return z if shiny
	ld hl, ShinyTrainerPokemon
.loop
	ld a, [hli] ; TrainerClass
	cp -1
	jr z, .notshiny
	ld b, a
	ld a, [OtherTrainerClass]
	cp b
	jr nz, .inc2andloop
	ld a, [hli] ; TrainerID
	ld b, a
	ld a, [OtherTrainerID]
	cp b
	jr nz, .inc1andloop
	ld a, [hli] ; PartySpecies
	ld b, a
	ld a, [CurPartySpecies]
	cp b
	jr nz, .loop
.shiny
	ld b, ATKDEFDV_SHINY
	ld c, SPDSPCDV_SHINY
	xor a
	and a
	ret
.inc2andloop
	inc hl
.inc1andloop
	inc hl
	jp .loop
.notshiny
	ld a, 1
	and a
	ret

ShinyTrainerPokemon:
	; TrainerClass, TrainerID, PartySpecies
	db MYSTICALMAN, EUSINE, HAUNTER
	db -1, -1, -1
