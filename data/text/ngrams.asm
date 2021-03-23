NgramStrings:
	table_width 2, NgramStrings
	dw .e_
	dw ._t
	dw .ou
	dw .in
	dw .th
	dw .he
	dw .t_
	dw .er
	dw .on
	dw .re
	dw .s_
	dw .at
	dw .an
	dw .to
	dw .ha
	dw .ng
	dw .it
	dw .is
	dw .ea
	dw .ve
	dw .ar
	dw .st
	dw .le
	dw .or
	dw .te
	dw .as
	dw .yo
	dw .y_
	dw .r_
	dw ._b
	dw .en
	dw .me
	dw .e_t
	dw .comma_
	dw .es
	dw .e_you
	dw .se
	dw .ne
	dw ._h
	dw .I_
	dw .our
	dw .You
	dw .nd
	dw .ow
	dw ._c
	dw ._wa
	dw .ome
	dw .are
	dw .The
	dw .t__s
	dw .ut
	dw .nt
	dw .the
	dw .you
	dw .ing
	dw .hat
	dw .and
	dw .for
	dw .all
	dw .here
	dw .that
	dw .have
	dw .rain
	dw .this
	dw .ight
	dw .with
	dw .ould
	dw .thing
	dw .attle
	dw .Poke
	dw .Pokemon
	dw wPlayerName
	dw wRivalName
	dw wTrendyPhrase
	assert_table_length NGRAMS_END - NGRAMS_START + 1

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
.thing:   rawchar "thing@"
.attle:   rawchar "attle@"
.Poke:    rawchar "Poké@"
.Pokemon: rawchar "Pokémon@"
