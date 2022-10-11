LyraPhoneScript:
	checktime 1 << DAY
	iftruefwd .daygreet
	checktime 1 << EVE
	iftruefwd .nitegreet
	checktime 1 << NITE
	iftruefwd .nitegreet
	farwritetext LyraPhoneMornGreetingText
	promptbutton
	sjumpfwd .main

.daygreet
	farwritetext LyraPhoneDayGreetingText
	promptbutton
	sjumpfwd .main

.evegreet
	farwritetext LyraPhoneEveGreetingText
	promptbutton
	sjumpfwd .main

.nitegreet
	farwritetext LyraPhoneNiteGreetingText
	promptbutton
	; fallthrough

.main
	checkpoke MAGNETON
	iftruefwd .magneton
	farwritetext LyraPhoneMainText
	end

.magneton
	farwritetext LyraPhoneMagnetonText
	promptbutton
	; fallthrough

.endpokemon
	farwritetext LyraPhoneEndText
	end

LyraPhoneScript2:
	readvar VAR_SPECIALPHONECALL
	ifequalfwd SPECIALCALL_YELLOWFOREST, .yellowforest
	ifequalfwd SPECIALCALL_FIRSTBADGE, .firstbadge
	ifequalfwd SPECIALCALL_LYRASEGG, .lyrasegg
	specialphonecall SPECIALCALL_NONE
	sjump LyraPhoneScript

.yellowforest
	farwritetext LyraPhoneYellowForestText
	specialphonecall SPECIALCALL_NONE
	end

.firstbadge
	farwritetext LyraPhoneFirstBadgeText
	specialphonecall SPECIALCALL_NONE
	end

.lyrasegg
	farwritetext LyraPhoneLyrasEggIntroText
	promptbutton
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftruefwd .lyrasegg_totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftruefwd .lyrasegg_chikorita
	farwritetext LyraPhoneLyrasEggChikoritaText
	sjumpfwd .lyrasegg_end

.lyrasegg_totodile
	farwritetext LyraPhoneLyrasEggCyndaquilText
	sjumpfwd .lyrasegg_end

.lyrasegg_chikorita:
	farwritetext LyraPhoneLyrasEggTotodileText
.lyrasegg_end
	promptbutton
	farwritetext LyraPhoneLyrasEggEndText
	setevent EVENT_LYRA_GAVE_AWAY_EGG
	specialphonecall SPECIALCALL_NONE
	end
