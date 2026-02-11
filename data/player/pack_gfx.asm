PlayerPackGFX:
	table_width 2
	dw .Male   ; PLAYER_MALE
	dw .Female ; PLAYER_FEMALE
	dw .Enby   ; PLAYER_ENBY
	dw .Beta   ; PLAYER_BETA
	assert_table_length NUM_PLAYER_GENDERS

.Male:
	farbank "Pack Graphics"
	fardw PackM0GFX
	fardw PackM1GFX
	fardw PackM2GFX
	fardw PackM3GFX
	fardw PackM4GFX
	fardw PackM5GFX

.Female:
	farbank "Pack Graphics"
	fardw PackF0GFX
	fardw PackF1GFX
	fardw PackF2GFX
	fardw PackF3GFX
	fardw PackF4GFX
	fardw PackF5GFX

.Enby:
	farbank "Pack Graphics"
	fardw PackX0GFX
	fardw PackX1GFX
	fardw PackX2GFX
	fardw PackX3GFX
	fardw PackX4GFX
	fardw PackX5GFX

.Beta:
	farbank "Pack Graphics"
	fardw PackB0GFX
	fardw PackB1GFX
	fardw PackB2GFX
	fardw PackB3GFX
	fardw PackB4GFX
	fardw PackB5GFX
