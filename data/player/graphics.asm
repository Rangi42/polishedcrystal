PlayerSpritePointers:
	table_width 3
	dba ChrisSpriteGFX ; PLAYER_MALE
	dba KrisSpriteGFX  ; PLAYER_FEMALE
	dba CrysSpriteGFX  ; PLAYER_ENBY
	dba BetaSpriteGFX  ; PLAYER_BETA
	assert_table_length NUM_PLAYER_GENDERS

PlayerCardPicPointers:
	table_width 2
	farbank "Trainer Card Pics"
	fardw ChrisCardPic ; PLAYER_MALE
	fardw KrisCardPic  ; PLAYER_FEMALE
	fardw CrysCardPic  ; PLAYER_ENBY
	fardw BetaCardPic  ; PLAYER_BETA
	assert_table_length NUM_PLAYER_GENDERS

PlayerBackpicPointers:
	table_width 2
	farbank "Trainer Backpics"
	fardw ChrisBackpic ; PLAYER_MALE
	fardw KrisBackpic  ; PLAYER_FEMALE
	fardw CrysBackpic  ; PLAYER_ENBY
	fardw BetaBackpic  ; PLAYER_BETA
	assert_table_length NUM_PLAYER_GENDERS
