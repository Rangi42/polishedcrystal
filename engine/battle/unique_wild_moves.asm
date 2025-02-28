CheckUniqueWildMove:
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	ld c, a
	ld hl, UniqueWildMoves
.loop
	ld a, [hli] ; landmark
	cp -1
	ret z
	cp c
	jr nz, .inc3andloop
	ld a, [hli] ; species
	ld b, a
	ld a, [wCurPartySpecies]
	cp b
	jr nz, .inc2andloop

	; If form isn't specified in the unique wildmove list, any form will do.
	ld a, [hli] ; form
	ld b, a
	and FORM_MASK
	ld a, [wCurForm]
	jr nz, .specific_form
	and EXTSPECIES_MASK
	jr .compare_form
.specific_form
	and SPECIESFORM_MASK
.compare_form
	cp b
	jr nz, .inc1andloop
	ld a, [hli] ; move
	ld b, a

	; Ignore placeholders (move 0)
	and a
	ret z

	; always teach moves for certain Pokémon
	ld a, c
	cp MAHOGANY_TOWN
	jr z, .TeachMove ; assume this is for Explosion in TeamRocketBaseB1F
	cp UNION_CAVE
	jr z, .TeachMove ; assume this is a Lapras in UnionCaveB2F
	ld a, b
	cp SURF
	jr z, .TeachMove ; assume only Pikachu can learn Surf

	call Random
	add a
	ret nc
.TeachMove
	ld hl, wOTPartyMon1Moves + 1 ; second move
	ld a, [hl]
	and a
	jr z, .ok
	inc hl ; third move
	ld a, [hl]
	and a
	jr z, .ok
	inc hl ; fourth move
	ld a, [hl]
	and a
	jr z, .ok
	ld hl, wOTPartyMon1Moves ; first move
.ok
	ld a, b
	ld [hl], a

	; assume only Pikachu can learn Fly
	cp FLY
	jr z, .UseFlyingPikachu
	ret

.inc3andloop
	inc hl
.inc2andloop
	inc hl
.inc1andloop
	inc hl
	jr .loop

.UseFlyingPikachu
	ld a, [wOTPartyMon1Form]
	and ~FORM_MASK
	or PIKACHU_FLY_FORM
	ld [wCurForm], a
	ld [wOTPartyMon1Form], a
	ld [wEnemyMonForm], a
	ret

INCLUDE "data/pokemon/unique_wild_moves.asm"
