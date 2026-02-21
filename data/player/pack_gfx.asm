PlayerPackGFX:
	table_width 2
	farbank "Pack Graphics"

; PLAYER_MALE
	fardw PackM0GFX ; ITEM
	fardw PackM1GFX ; MEDICINE
	fardw PackM2GFX ; BALL
	fardw PackM3GFX ; TM_HM
	fardw PackM4GFX ; BERRIES
	fardw PackM5GFX ; KEY_ITEM

; PLAYER_FEMALE
	fardw PackF0GFX ; ITEM
	fardw PackF1GFX ; MEDICINE
	fardw PackF2GFX ; BALL
	fardw PackF3GFX ; TM_HM
	fardw PackF4GFX ; BERRIES
	fardw PackF5GFX ; KEY_ITEM

; PLAYER_ENBY
	fardw PackX0GFX ; ITEM
	fardw PackX1GFX ; MEDICINE
	fardw PackX2GFX ; BALL
	fardw PackX3GFX ; TM_HM
	fardw PackX4GFX ; BERRIES
	fardw PackX5GFX ; KEY_ITEM

; PLAYER_BETA
	fardw PackB0GFX ; ITEM
	fardw PackB1GFX ; MEDICINE
	fardw PackB2GFX ; BALL
	fardw PackB3GFX ; TM_HM
	fardw PackB4GFX ; BERRIES
	fardw PackB5GFX ; KEY_ITEM

	assert_table_length NUM_PLAYER_GENDERS * NUM_POCKETS
