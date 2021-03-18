GetBreedMon1LevelGrowth:
	ld hl, wBreedMon1
	ld de, wTempMon
	ld bc, BREEDMON_STRUCT_LENGTH
	rst CopyBytes
	farcall CalcLevel
	ld a, [wBreedMon1Level]
	ld b, a
	ld a, d
	ld e, a
	sub b
	ld d, a
	ret

GetBreedMon2LevelGrowth:
	ld hl, wBreedMon2
	ld de, wTempMon
	ld bc, BREEDMON_STRUCT_LENGTH
	rst CopyBytes
	farcall CalcLevel
	ld a, [wBreedMon2Level]
	ld b, a
	ld a, d
	ld e, a
	sub b
	ld d, a
	ret
