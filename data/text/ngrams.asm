NgramStrings:
	table_width 1
	dr .ou
	dr .th
	dr .in
	dr .t_
	dr .er
	dr .s_
	dr .an
	dr .on
	dr .to_
	dr .d_
	dr .ea
	dr .y_
	dr .en
	dr .or
	dr .at
	dr .$_
	dr .ll
	dr .I_
	dr .ar
	dr .it
	dr .st
	dr .ow
	dr .ha
	dr .a_
	dr .om
	dr .le
	dr .of_
	dr .se
	dr .re
	dr .to
	dr .#s_
	dr .Th
	dr .is
	dr .ra
	dr .ch
	dr .I#m_
	dr .o_
	dr .gh
	dr .es
	dr .wa
	dr .e@
	dr .oo
	dr .ck
	dr .r_
	dr .l_
	dr .be
	dr .li
	dr .ed
	dr .us
	dr .ti
	dr ._you
	dr .ing_
	dr .the_
	dr .you
	dr .ing
	dr .is_
	dr .the
	dr .You_
	dr .er_
	dr .with
	dr .batt
	dr .for
	dr .ve_
	dr .ed_
	dr .It#s_
	dr .that_
	dr .e_
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
.ou:      rawchar "ou@"
.th:      rawchar "th@"
.in:      rawchar "in@"
.t_:      rawchar "t @"
.er:      rawchar "er@"
.s_:      rawchar "s @"
.an:      rawchar "an@"
.on:      rawchar "on@"
.to_:     rawchar "to @"
.d_:      rawchar "d @"
.ea:      rawchar "ea@"
.y_:      rawchar "y @"
.en:      rawchar "en@"
.or:      rawchar "or@"
.at:      rawchar "at@"
.$_:      rawchar ", @"
.ll:      rawchar "ll@"
.I_:      rawchar "I @"
.ar:      rawchar "ar@"
.it:      rawchar "it@"
.st:      rawchar "st@"
.ow:      rawchar "ow@"
.ha:      rawchar "ha@"
.a_:      rawchar "a @"
.om:      rawchar "om@"
.le:      rawchar "le@"
.of_:     rawchar "of @"
.se:      rawchar "se@"
.re:      rawchar "re@"
.to:      rawchar "to@"
.#s_:     rawchar "'s @"
.Th:      rawchar "Th@"
.is:      rawchar "is@"
.ra:      rawchar "ra@"
.ch:      rawchar "ch@"
.I#m_:    rawchar "I'm @"
.o_:      rawchar "o @"
.gh:      rawchar "gh@"
.es:      rawchar "es@"
.wa:      rawchar "wa@"
.e@:      rawchar "e.@"
.oo:      rawchar "oo@"
.ck:      rawchar "ck@"
.r_:      rawchar "r @"
.l_:      rawchar "l @"
.be:      rawchar "be@"
.li:      rawchar "li@"
.ed:      rawchar "ed@"
.us:      rawchar "us@"
.ti:      rawchar "ti@"
._you:    rawchar " you@"
.ing_:    rawchar "ing @"
.the_:    rawchar "the @"
.you:     rawchar "you@"
.ing:     rawchar "ing@"
.is_:     rawchar "is @"
.the:     rawchar "the@"
.You_:    rawchar "You @"
.er_:     rawchar "er @"
.with:    rawchar "with@"
.batt:    rawchar "batt@"
.for:     rawchar "for@"
.ve_:     rawchar "ve @"
.ed_:     rawchar "ed @"
.It#s_:   rawchar "It's @"
.that_:   rawchar "that @"
._you_:   rawchar " you @"
.Poke:    rawchar "Poké@"
.Pokemon: rawchar "Pokémon@"
