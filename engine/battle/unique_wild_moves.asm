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
	jr nz, .inc2andloop
	ld a, [hli] ; species
	ld b, a
	ld a, [wCurPartySpecies]
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
	cp YELLOW_FOREST
	jr nz, .ChanceToTeach
	; assume this is a Pikachu in YellowForest; Surf (always teach) or Fly?
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .SurfingPikachu
	cp PLAYER_SURF_PIKA
	jr nz, .ChanceToTeach
.SurfingPikachu
	ld a, SURF
	ld b, a
	jr .TeachMove
.ChanceToTeach
	call Random
	cp 50 percent + 1
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
	ret

.inc2andloop
	inc hl
.inc1andloop
	inc hl
	jr .loop

INCLUDE "data/pokemon/unique_wild_moves.asm"
