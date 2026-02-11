FishingGFXTable:
	table_width 2
	farbank "Fishing Graphics"
	fardw ChrisFishingGFX ; PLAYER_MALE
	fardw KrisFishingGFX  ; PLAYER_FEMALE
	fardw CrysFishingGFX  ; PLAYER_ENBY
	fardw BetaFishingGFX  ; PLAYER_BETA
	assert_table_length NUM_PLAYER_GENDERS

SurfFishingGFXTable:
	table_width 2
	farbank "Fishing Graphics"
	fardw ChrisSurfFishingGFX ; PLAYER_MALE
	fardw KrisSurfFishingGFX  ; PLAYER_FEMALE
	fardw CrysSurfFishingGFX  ; PLAYER_ENBY
	fardw BetaSurfFishingGFX  ; PLAYER_BETA
	assert_table_length NUM_PLAYER_GENDERS
