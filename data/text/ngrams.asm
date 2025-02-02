NgramStrings:
	table_width 1
	dr .e_
	dr ._t
	dr .ou
	dr .in
	dr .th
	dr .he
	dr .t_
	dr .er
	dr .on
	dr .re
	dr .s_
	dr .at
	dr .an
	dr .to
	dr .ha
	dr .ng
	dr .it
	dr .is
	dr .ea
	dr .ve
	dr .ar
	dr .st
	dr .le
	dr .or
	dr .te
	dr .as
	dr .yo
	dr .y_
	dr .r_
	dr ._b
	dr .en
	dr .me
	dr .e_t
	dr .comma_
	dr .es
	dr .e_you
	dr .se
	dr .ne
	dr ._h
	dr .I_
	dr .our
	dr .You
	dr .nd
	dr .ow
	dr ._c
	dr ._wa
	dr .ome
	dr .are
	dr .The
	dr .t__s
	dr .ut
	dr .nt
	dr .the
	dr .you
	dr .ing
	dr .hat
	dr .and
	dr .for
	dr .all
	dr .here
	dr .that
	dr .have
	dr .rain
	dr .this
	dr .ight
	dr .with
	dr .ould
	dr .attle
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
