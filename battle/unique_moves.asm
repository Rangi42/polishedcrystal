CheckUniqueWildMove:
	ld hl, UniqueWildMoves
.loop
	ld a, [hli] ; MapGroup
	cp -1
	ret z

	ld b, a
	ld a, [MapGroup]
	cp b
	jr nz, .inc4andloop
	ld a, [hli] ; MapNumber
	ld b, a
	ld a, [MapNumber]
	cp b
	jr nz, .inc3andloop
	ld a, [hli] ; Species
	ld b, a
	ld a, [CurPartySpecies]
	cp b
	jr nz, .inc2andloop
	ld a, [hli] ; SurfMove
	ld b, a
	; always teach Surf if surfing
	cp SURF
	jr nz, .ChanceToTeach
	ld a, [PlayerState]
	cp PLAYER_SURF
	jr z, .TeachMove
	cp PLAYER_SURF_PIKA
	jr z, .TeachMove
	ld a, [hli] ; GrassMove
	ld b, a
.ChanceToTeach
	; 25% chance to teach other moves
	ld a, 4
	call RandomRange
	and a
	ret nz

.TeachMove
	ld hl, EnemyMonMoves + 1 ; second move
	ld a, b
	ld [hl], a
	ret

.inc4andloop
	inc hl
.inc3andloop
	inc hl
.inc2andloop
	inc hl
	inc hl
	jp .loop


UniqueWildMoves:
	; MapGroup, MapNumber, Species, SurfMove, GrassMove
	db GROUP_YELLOW_FOREST, MAP_YELLOW_FOREST, PIKACHU, SURF, FLY
	db GROUP_QUIET_CAVE_1F, MAP_QUIET_CAVE_1F, MUNCHLAX, SELFDESTRUCT, SELFDESTRUCT
	db GROUP_QUIET_CAVE_B1F, MAP_QUIET_CAVE_B1F, MUNCHLAX, SELFDESTRUCT, SELFDESTRUCT
	db GROUP_QUIET_CAVE_B1F, MAP_QUIET_CAVE_B1F, MAGIKARP, HYDRO_PUMP, HYDRO_PUMP
	db GROUP_QUIET_CAVE_B2F, MAP_QUIET_CAVE_B2F, MAGIKARP, HYDRO_PUMP, HYDRO_PUMP
	db GROUP_QUIET_CAVE_B3F, MAP_QUIET_CAVE_B3F, MAGIKARP, HYDRO_PUMP, HYDRO_PUMP
	db -1
