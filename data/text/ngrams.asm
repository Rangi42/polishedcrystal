NgramStrings:
	table_width 1, NgramStrings
	; Using offsets instead of full pointers to save space
	db .e_      - @
	db ._t      - @
	db .ou      - @
	db .in      - @
	db .th      - @
	db .he      - @
	db .t_      - @
	db .er      - @
	db .on      - @
	db .re      - @
	db .s_      - @
	db .at      - @
	db .an      - @
	db .to      - @
	db .ha      - @
	db .ng      - @
	db .it      - @
	db .is      - @
	db .ea      - @
	db .ve      - @
	db .ar      - @
	db .st      - @
	db .le      - @
	db .or      - @
	db .te      - @
	db .as      - @
	db .yo      - @
	db .y_      - @
	db .r_      - @
	db ._b      - @
	db .en      - @
	db .me      - @
	db .e_t     - @
	db .comma_  - @
	db .es      - @
	db .e_you   - @
	db .se      - @
	db .ne      - @
	db ._h      - @
	db .I_      - @
	db .our     - @
	db .You     - @
	db .nd      - @
	db .ow      - @
	db ._c      - @
	db ._wa     - @
	db .ome     - @
	db .are     - @
	db .The     - @
	db .t__s    - @
	db .ut      - @
	db .nt      - @
	db .the     - @
	db .you     - @
	db .ing     - @
	db .hat     - @
	db .and     - @
	db .for     - @
	db .all     - @
	db .here    - @
	db .that    - @
	db .have    - @
	db .rain    - @
	db .this    - @
	db .ight    - @
	db .with    - @
	db .ould    - @
	db .attle   - @
	db .Poke    - @
	db .Pokemon - @
	assert_table_length NGRAMS_VAR_START - NGRAMS_START
	db .Player  - @
	db .Rival   - @
	db .Trendy  - @
	assert_table_length NGRAMS_END - NGRAMS_START + 1

.Player:  dw wPlayerName
.Rival:   dw wRivalName
.Trendy:  dw wTrendyPhrase
.e_:      rawchar "e @"
._t:      rawchar " t@"
.ou:      rawchar "ou@"
.in:      rawchar "in@"
.th:      rawchar "th@"
.he:      rawchar "he@"
.t_:      rawchar "t @"
.er:      rawchar "er@"
.on:      rawchar "on@"
.re:      rawchar "re@"
.s_:      rawchar "s @"
.at:      rawchar "at@"
.an:      rawchar "an@"
.to:      rawchar "to@"
.ha:      rawchar "ha@"
.ng:      rawchar "ng@"
.it:      rawchar "it@"
.is:      rawchar "is@"
.ea:      rawchar "ea@"
.ve:      rawchar "ve@"
.ar:      rawchar "ar@"
.st:      rawchar "st@"
.le:      rawchar "le@"
.or:      rawchar "or@"
.te:      rawchar "te@"
.as:      rawchar "as@"
.yo:      rawchar "yo@"
.y_:      rawchar "y @"
.r_:      rawchar "r @"
._b:      rawchar " b@"
.en:      rawchar "en@"
.me:      rawchar "me@"
.e_t:     rawchar "e t@"
.comma_:  rawchar ", @"
.es:      rawchar "es@"
.e_you:   rawchar "e you@"
.se:      rawchar "se@"
.ne:      rawchar "ne@"
._h:      rawchar " h@"
.I_:      rawchar "I @"
.our:     rawchar "our@"
.You:     rawchar "You@"
.nd:      rawchar "nd@"
.ow:      rawchar "ow@"
._c:      rawchar " c@"
._wa:     rawchar " wa@"
.ome:     rawchar "ome@"
.are:     rawchar "are@"
.The:     rawchar "The@"
.t__s:    rawchar "t's@"
.ut:      rawchar "ut@"
.nt:      rawchar "nt@"
.the:     rawchar "the@"
.you:     rawchar "you@"
.ing:     rawchar "ing@"
.hat:     rawchar "hat@"
.and:     rawchar "and@"
.for:     rawchar "for@"
.all:     rawchar "all@"
.here:    rawchar "here@"
.that:    rawchar "that@"
.have:    rawchar "have@"
.rain:    rawchar "rain@"
.this:    rawchar "this@"
.ight:    rawchar "ight@"
.with:    rawchar "with@"
.ould:    rawchar "ould@"
.attle:   rawchar "attle@"
.Poke:    rawchar "Poké@"
.Pokemon: rawchar "Pokémon@"
