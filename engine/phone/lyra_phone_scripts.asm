LyraPhoneScript:
	checktime 1 << DAY
	iftrue .daygreet
	checktime 1 << EVE
	iftrue .evegreet
	checktime 1 << NITE
	iftrue .nitegreet
	farwritetext LyraPhoneMornGreetingText
	promptbutton
	sjump .main

.daygreet
	farwritetext LyraPhoneDayGreetingText
	promptbutton
	sjump .main

.evegreet
	farwritetext LyraPhoneEveGreetingText
	promptbutton
	sjump .main

.nitegreet
	farwritetext LyraPhoneNiteGreetingText
	promptbutton
	sjump .main

.main
	scall MagnetonEvo
	scall PoliwhirlEvo
	scall GloomEvo
	scall SlowpokeEvo
	scall AncientPowerEvo
	farwritetext LyraPhoneMainText
	end

MagnetonEvo:
	checkpoke MAGNETON
	iftrue .magneton
	end

.magneton
	farwritetext LyraPhoneMagnetonText
	yesorno
	iftrue .magneton_evolution
	end

.magneton_evolution
	farwritetext LyraPhoneMagnetonEvoText
	promptbutton
	end

GloomEvo:
	checkpoke GLOOM
	iftrue .gloom
	end

.gloom
	farwritetext LyraPhoneGloomText
	yesorno
	iftrue .gloom_evolution
	end

.gloom_evolution
	farwritetext LyraPhoneGloomEvoText
	promptbutton
	end

SlowpokeEvo:
	checkpoke SLOWPOKE
	iftrue .slowpoke
	end

.slowpoke
	farwritetext LyraPhoneSlowpokeText
	yesorno
	iftrue .slowpoke_evolution
	end

.slowpoke_evolution
	farwritetext LyraPhoneSlowpokeEvoText
	promptbutton
	end	

AncientPowerEvo:
	checkpoke PILOSWINE
	iftrue .piloswine
	checkpoke YANMA
	iftrue .yanma
	checkpoke TANGELA
	iftrue .tangela
	end

.piloswine
	getmonname PILOSWINE, STRING_BUFFER_3
	sjump .ancient_power

.yanma
	getmonname YANMA, STRING_BUFFER_3
	sjump .ancient_power

.tangela
	getmonname TANGELA, STRING_BUFFER_3
	sjump .ancient_power

.ancient_power
	farwritetext LyraPhoneAncientPowerMonText
	yesorno
	iftrue .ancient_power_evolution
	end

.ancient_power_evolution
	farwritetext LyraPhoneAncientPowerEvoText
	promptbutton
	end

PoliwhirlEvo:
	checkpoke POLIWHIRL
	iftrue .poliwhirl
	end

.poliwhirl
	farwritetext LyraPhonePoliwhirlText
	yesorno
	iftrue .poliwhirl_evolution
	end

.poliwhirl_evolution
	farwritetext LyraPhonePoliwhirlEvoText
	promptbutton
	end

LyraPhoneScript2:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_YELLOWFOREST, .yellowforest
	ifequal SPECIALCALL_FIRSTBADGE, .firstbadge
	ifequal SPECIALCALL_LYRASEGG, .lyrasegg
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
	iftrue .lyrasegg_totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .lyrasegg_chikorita
	farwritetext LyraPhoneLyrasEggChikoritaText
	sjump .lyrasegg_end

.lyrasegg_totodile
	farwritetext LyraPhoneLyrasEggCyndaquilText
	sjump .lyrasegg_end

.lyrasegg_chikorita:
	farwritetext LyraPhoneLyrasEggTotodileText
.lyrasegg_end
	promptbutton
	farwritetext LyraPhoneLyrasEggEndText
	setevent EVENT_LYRA_GAVE_AWAY_EGG
	specialphonecall SPECIALCALL_NONE
	end