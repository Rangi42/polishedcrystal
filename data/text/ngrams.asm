NgramStrings:
	table_width 1
	dr .Poke
	dr .Pokemon
	assert_table_length NGRAMS_VAR_START - NGRAMS_START
	dr .Player
	dr .Rival
	dr .Trendy
	assert_table_length NGRAMS_END - NGRAMS_START + 1

.Player:  dw wPlayerName
.Rival:   dw wRivalName
.Trendy:  dw wTrendyPhrase
.Poke:    rawchar "Poké@"
.Pokemon: rawchar "Pokémon@"
