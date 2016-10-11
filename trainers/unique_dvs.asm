CheckUniqueDVOrPersonalityTrainerPokemon:
; return z if dvs are unique

	ld hl, UniqueDVOrPersonalityTrainerPokemon
.loop
	ld a, [hli] ; TrainerClass
	cp -1
	jr z, .notunique
	ld b, a
	ld a, [OtherTrainerClass]
	cp b
	jr nz, .inc8andloop
	ld a, [hli] ; TrainerID
	ld b, a
	ld a, [OtherTrainerID]
	cp b
	jr nz, .inc7andloop
	ld a, [hli] ; PartySpecies
	ld b, a
	ld a, [CurPartySpecies]
	cp b
	jr nz, .inc6andloop
	ld a, [hli] ; Level
	ld b, a
	ld a, [CurPartyLevel]
	cp b
	jr nz, .inc5andloop
.unique

	ld b, h
	ld c, l

	xor a
	and a
	ret

.inc8andloop
	inc hl
.inc7andloop
	inc hl
.inc6andloop
	inc hl
.inc5andloop
rept 5
	inc hl
endr
	jp .loop

.notunique
	ld a, 1
	and a
	ret

UniqueDVOrPersonalityTrainerPokemon:
	; TrainerClass, TrainerID, PartySpecies, Level, HPAtkDV, DefSpdDV, SAtSDfDV, Personality1, Personality2

	; Shiny
	db BEAUTY,      CHARLOTTE, BELLOSSOM,  20, $CC, $CC, $CC, SHINY_MASK | ABILITY_1      | QUIRKY, FEMALE
	db MYSTICALMAN, EUSINE,    ELECTRODE,  28, PERFECT_DVS,   SHINY_MASK | HIDDEN_ABILITY | QUIRKY, MALE
	db LAWRENCE,    1,         CHARIZARD,  66, PERFECT_DVS,   SHINY_MASK | ABILITY_1      | ADAMANT, MALE
	db CHAMPION,    LANCE,     DRAGONITE,  59, PERFECT_DVS,   SHINY_MASK | ABILITY_1      | MODEST, MALE
	db CHAMPION,    LANCE2,    DRAGONITE,  80, PERFECT_DVS,   SHINY_MASK | ABILITY_1      | MODEST, MALE
	db RED,         1,         GYARADOS,   87, PERFECT_DVS,   SHINY_MASK | ABILITY_1      | ADAMANT, MALE
	db BREEDER,     THERESA,   ELEKID,     14, $DD, $DD, $DD, SHINY_MASK | ABILITY_1      | QUIRKY, FEMALE
	db BREEDER,     CARLENE,   DITTO,      55, PERFECT_DVS,   SHINY_MASK | ABILITY_1      | QUIRKY, FEMALE
	db SUPER_NERD,  MIGUEL,    UMBREON,    64, $BB, $BB, $BB, SHINY_MASK | ABILITY_1      | QUIRKY, MALE

	; Hidden Power types
	db JASMINE,     2,         MAGNEZONE,  72, DVS_HP_GRASS,    ABILITY_1 | TIMID,  FEMALE
	db JASMINE,     2,         MAGNEZONE,  73, DVS_HP_FIRE,     ABILITY_1 | MODEST, FEMALE
	db PRYCE,       2,         GLACEON,    71, DVS_HP_GROUND,   ABILITY_1 | MODEST, MALE
	db WILL,        2,         ALAKAZAM,   69, DVS_HP_FIGHTING, ABILITY_1 | MODEST, MALE
	db LT_SURGE,    2,         JOLTEON,    73, DVS_HP_ICE,      ABILITY_1 | QUIRKY, MALE
	db LT_SURGE,    2,         MAGNEZONE,  72, DVS_HP_FIRE,     ABILITY_1 | QUIRKY, MALE
	db ERIKA,       2,         BELLOSSOM,  75, DVS_HP_ROCK,     ABILITY_1 | QUIRKY, FEMALE
	db LEAF,        1,         MOLTRES,    98, DVS_HP_GRASS,    ABILITY_1 | TIMID,  FEMALE

	; Natures
	db CHAMPION,    LANCE2,    GYARADOS,   75, PERFECT_DVS, HIDDEN_ABILITY | ADAMANT, MALE
	db CHAMPION,    LANCE2,    AERODACTYL, 76, PERFECT_DVS, HIDDEN_ABILITY | ADAMANT, MALE
	db CHAMPION,    LANCE2,    CHARIZARD,  75, PERFECT_DVS, HIDDEN_ABILITY | ADAMANT, MALE
	db RED,         1,         ESPEON,     84, PERFECT_DVS, HIDDEN_ABILITY | MODEST,  MALE
	db RED,         1,         SNORLAX,    85, PERFECT_DVS, HIDDEN_ABILITY | ADAMANT, MALE
	db RED,         1,         CHARIZARD,  88, PERFECT_DVS, HIDDEN_ABILITY | ADAMANT, MALE
	db LEAF,        1,         LAPRAS,     96, PERFECT_DVS, HIDDEN_ABILITY | MODEST,  MALE
	db LEAF,        1,         SYLVEON,    95, PERFECT_DVS, HIDDEN_ABILITY | MODEST,  MALE
	db LEAF,        1,         AERODACTYL, 98, PERFECT_DVS, HIDDEN_ABILITY | ADAMANT, MALE
	db LEAF,        1,         MEW,        99, PERFECT_DVS, HIDDEN_ABILITY | MODEST,  MALE
	db LEAF,        1,         VENUSAUR,  100, PERFECT_DVS, HIDDEN_ABILITY | HASTY,   MALE

	; Top percentage Rattata
	db YOUNGSTER,   JOEY1,     RATTATA,     5, PERFECT_DVS, ABILITY_2 | ADAMANT, MALE
	db YOUNGSTER,   JOEY2,     RATTATA,    15, PERFECT_DVS, ABILITY_2 | ADAMANT, MALE
	db YOUNGSTER,   JOEY3,     RATICATE,   25, PERFECT_DVS, ABILITY_2 | ADAMANT, MALE
	db YOUNGSTER,   JOEY4,     RATICATE,   30, PERFECT_DVS, ABILITY_2 | ADAMANT, MALE
	db YOUNGSTER,   JOEY5,     RATICATE,   40, PERFECT_DVS, ABILITY_2 | ADAMANT, MALE

	db -1 ; end
