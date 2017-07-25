CheckUniqueWildMove:
	ld a, [MapGroup]
	ld b, a
	ld a, [MapNumber]
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
	ld a, [CurPartySpecies]
	cp b
	jr nz, .inc1andloop
	ld a, [hli] ; move
	ld b, a
	cp FLY
	jr nz, .ChanceToTeach
	ld a, [PlayerState]
	cp PLAYER_SURF
	jr z, .SurfingPikachu
	cp PLAYER_SURF_PIKA
	jr nz, .ChanceToTeach
.SurfingPikachu
	ld a, SURF
	ld b, a
	jr .TeachMove
.ChanceToTeach
	; 25% chance to teach other moves
	call Random
	cp 25 percent + 1
	ret nc
.TeachMove
	ld hl, EnemyMonMoves + 1 ; second move
	ld a, b
	ld [hl], a
	ret

.inc2andloop
	inc hl
.inc1andloop
	inc hl
	jr .loop


UniqueWildMoves:
	; landmark, species, move
	; TODO: finish unique moves
	db CHERRYGROVE_BAY, CORSOLA, SUCKER_PUNCH ; HGSS tutor move
	db SPROUT_TOWER, BELLSPROUT, GROWTH ; knows Growth early
	db ROUTE_32_COAST, FLAAFFY, PURSUIT ; Prism tutor move
	db RUINS_OF_ALPH, SMEARGLE, SKETCH ; knows Sketch twice
	db SLOWPOKE_WELL, SLOWPOKE, GROWTH ; Prism tutor move
	db ILEX_FOREST, 0, 0
	db ROUTE_34_COAST, STARYU, DREAM_EATER ; new move
	db STORMY_BEACH, VENOMOTH, TWISTER ; HGSS tutor move
	db MURKY_SWAMP, KOFFING, CRUNCH ; Prism tutor move
	db MURKY_SWAMP, MISDREAVUS, HEAL_BELL ; HGSS tutor move
	db ROUTE_35_COAST, 0, 0
	db NATIONAL_PARK, 0, 0
	db TIN_TOWER, 0, 0
	db BURNED_TOWER, 0, 0
	db MURKY_SWAMP, MISDREAVUS, SUCKER_PUNCH ; HGSS tutor move
	db GOLDENROD_HARBOR, PSYDUCK, ENCORE ; Dream World move
	db WHIRL_ISLANDS, 0, 0
	db CLIFF_CAVE, 0, 0
	db YELLOW_FOREST, PIKACHU, FLY ; replaced with Surf if Surfing
	db QUIET_CAVE, MUNCHLAX, SELFDESTRUCT ; Pokéwalker move
	db MT_MORTAR, 0, 0
	db LAKE_OF_RAGE, MAGIKARP, HYDRO_PUMP ; Pokéwalker move
	db ICE_PATH, 0, 0
	db DRAGONS_DEN, 0, 0
	db DARK_CAVE, 0, 0
	db SILVER_CAVE, TYRANITAR, DRAGON_DANCE ; event move
	db VIRIDIAN_FOREST, PIKACHU, BARRIER ; Prism tutor move
	db MT_MOON, 0, 0
	db CERULEAN_CAVE, MACHAMP, METRONOME ; RBY TM move
	db CERULEAN_CAVE, GOLEM, METRONOME ; RBY TM move
	db CERULEAN_CAVE, GENGAR, METRONOME ; RBY TM move
	db CERULEAN_CAVE, ALAKAZAM, METRONOME ; RBY TM move
	db CERULEAN_CAPE, POLIWHIRL, METRONOME ; RBY TM move
	db DIGLETTS_CAVE, 0, 0
	db ROCK_TUNNEL, ELECTABUZZ, METRONOME ; RBY TM move
	db DIM_CAVE, GRAVELER, SUCKER_PUNCH ; HGSS tutor move
	db DIM_CAVE, RHYDON, CRUNCH ; Prism tutor move
	db SOUL_HOUSE, HAUNTER, MOONBLAST ; Prism tutor move
	db LAV_RADIO_TOWER, MAROWAK, PERISH_SONG ; Dream World move
	db LUCKY_ISLAND, CHANSEY, TRI_ATTACK ; RBY TM move
	db LUCKY_ISLAND, TOGETIC, TWISTER ; HGSS tutor move
	db SAFARI_ZONE, TANGELA, LEECH_SEED ; Dream World move (hub)
	db SAFARI_ZONE, TAUROS, STOMP ; RBY move (east)
	db SAFARI_ZONE, PINSIR, SLASH ; RBY move (north)
	db SAFARI_ZONE, DODRIO, SKY_ATTACK ; HGSS tutor move (west)
	db URAGA_CHANNEL, TENTACRUEL, RECOVER ; TCG move
	db SCARY_CAVE, GOLBAT, HYPNOSIS ; Dream World move
	db SCARY_CAVE, LANTURN, SUCKER_PUNCH ; HGSS tutor move
	db SEAFOAM_ISLANDS, JYNX, METRONOME ; RBY TM move
	db POKEMON_MANSION, RAPIDASH, NASTY_PLOT ; Prism tutor move
	db CINNABAR_VOLCANO, MAGMAR, METRONOME ; RBY TM move
	db TOHJO_FALLS, 0, 0
	db VICTORY_ROAD, 0, 0
	db SHAMOUTI_ISLAND, 0, 0
	db BEAUTIFUL_BEACH, 0, 0
	db ROCKY_BEACH, DONPHAN, LOW_KICK ; HGSS tutor move
	db NOISY_FOREST, SCIZOR, CRABHAMMER ; new move
	db NOISY_FOREST, PINECO, PAIN_SPLIT ; HGSS tutor move
	db SHRINE_RUINS, HYPNO, METRONOME ; RBY TM move
	db SHAMOUTI_TUNNEL, GOLBAT, OUTRAGE ; Prism tutor move
	db WARM_BEACH, SEADRA, FLAMETHROWER ; new move
	db SHAMOUTI_COAST, 0, 0
	db FIRE_ISLAND, HOUNDOOM, SUCKER_PUNCH ; HGSS tutor move
	db ICE_ISLAND, WEAVILE, LOW_KICK ; HGSS tutor move
	db LIGHTNING_ISLAND, ELECTRODE, SUCKER_PUNCH ; HGSS tutor move
	db ROUTE_49, PARASECT, CONFUSE_RAY ; Prism tutor move
	db -1
