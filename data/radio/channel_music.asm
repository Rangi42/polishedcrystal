RadioChannelSongs:
; entries correspond to radio channel ids (see constants/radio_constants.asm)
	table_width 1, RadioChannelSongs
	db MUSIC_POKEMON_TALK
	db MUSIC_POKEMON_CENTER
	db MUSIC_TITLE
	db MUSIC_GAME_CORNER
	db MUSIC_BUENAS_PASSWORD
	db MUSIC_VIRIDIAN_CITY
	db MUSIC_BICYCLE
	db MUSIC_ROCKET_OVERTURE
	db MUSIC_POKE_FLUTE_CHANNEL
	db MUSIC_RUINS_OF_ALPH_RADIO
	db MUSIC_LAKE_OF_RAGE_ROCKET_RADIO
	assert_table_length NUM_RADIO_CHANNELS
