DailyTrainerHouseOpponents:
; entries correspond to OPP_* constants (see constants/script_constants.asm)
	table_width TRAINER_HOUSE_OPPONENT_SIZE
	db CAL,      1
	db CARRIE,   1
	db JACKY,    1
	; based on http://bulbapedia.bulbagarden.net/wiki/The_Legendary_Rotation_Battle!
	db VETERANM, EN
	db VETERANF, MADOKA
	assert_table_length NUM_TRAINER_HOUSE_OPPONENTS
