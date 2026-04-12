LyraPhoneScript:
	readmem wTimeOfDay
	scalltable LyraPhoneScript_GreetingsTable
	getcurlandmarkname STRING_BUFFER_4
	readvar VAR_LANDMARK
	; Special-case too-long landmark names
	ifnotequal POKEMON_LEAGUE, .got_landmark
	getstring .PokemonLeague, STRING_BUFFER_4
.got_landmark
	farwritetext LyraPhoneLandmarkText
	ifless SHAMOUTI_LANDMARK, .not_shamouti
	farwritetext LyraPhoneIslandsText
	sjumpfwd .landmark_done
.not_shamouti
	ifless KANTO_LANDMARK, .not_kanto
	farwritetext LyraPhoneKantoText
	sjumpfwd .landmark_done
.not_kanto
	scalltable LyraPhoneScript_JohtoLandmarksTable
.landmark_done
	farwritetext LyraPhoneNextMoveQuestionText
	yesorno
	iftruefwd .describe_next_move
	farwritetext LyraPhoneNextMoveRefusedText
	sjumpfwd .done

.describe_next_move
	callasm LyraPhone_GetFirstMonNextMove
	iffalsefwd .no_move
	ifequalfwd -1, .egg
	farwritetext LyraPhoneNextMoveLevelText
	sjumpfwd .done

.no_move
	farwritetext LyraPhoneNoNextMoveText
	sjumpfwd .done

.egg
	farwritetext LyraPhoneNoEggMovesText
.done
	farwritetext LyraPhoneEndText
	end

.PokemonLeague:     db "#mon League@"

LyraPhone_GetFirstMonNextMove:
	; [wStringBuffer3] = species name
	call EvolutionPhone_GetFirstNonEggPartyMon
	; a = move level, d = move name
	farcall GetNextMove
	; [hScriptVar] = move level
	ldh [hScriptVar], a
	; [wStringBuffer1] = move name
	ld a, d
	ld [wNamedObjectIndex], a
	jmp GetMoveName

LyraPhoneScript_GreetingsTable:
	table_width 2
	dw .MornGreeting
	dw .DayGreeting
	dw .NiteGreeting
	dw .EveGreeting
	assert_table_length NUM_DAYTIMES
.MornGreeting:
	farwritetext LyraPhoneGreetingText_Morn
	end
.DayGreeting:
	farwritetext LyraPhoneGreetingText_Day
	end
.EveGreeting:
	farwritetext LyraPhoneGreetingText_Eve
	end
.NiteGreeting:
	farwritetext LyraPhoneGreetingText_Nite
	end

LyraPhoneScript_JohtoLandmarksTable:
	table_width 2
	dw .Generic
	dw .Hollowport
	dw .Route101
	dw .Route102
	dw .Olsteeton
	dw .NationalForest1
	dw .OlsteetonUni
	dw .BattleTower
.Generic:
.Hollowport:
.Route101:
.Route102:
.Olsteeton:
.NationalForest1:
.OlsteetonUni:
.BattleTower:
	; TODO: define individual texts for Johto landmarks
	farwritetext LyraPhoneJohtoText_Generic
	end

LyraPhoneScript2:
	readvar VAR_SPECIALPHONECALL
	ifequalfwd SPECIALCALL_YELLOWFOREST, .YellowForest
	ifequalfwd SPECIALCALL_FIRSTBADGE, .FirstBadge
	ifequalfwd SPECIALCALL_LYRASEGG, .LyrasEgg
	specialphonecall SPECIALCALL_NONE
	sjump LyraPhoneScript

.YellowForest:
	farwritetext LyraPhoneSpecialText_YellowForest
	specialphonecall SPECIALCALL_NONE
	end

.FirstBadge:
	farwritetext LyraPhoneSpecialText_FirstBadge
	specialphonecall SPECIALCALL_NONE
	end

.LyrasEgg:
	checkevent EVENT_GOT_GLUTTLE_FROM_ELM
	iftruefwd .lyrasegg_totodile
	checkevent EVENT_GOT_CUPICO_FROM_ELM
	iftruefwd .lyrasegg_chikorita
	getstring .Chicory, STRING_BUFFER_4
	sjumpfwd .lyrasegg_end
.lyrasegg_totodile
	getstring .Cinder, STRING_BUFFER_4
	sjumpfwd .lyrasegg_end
.lyrasegg_chikorita:
	getstring .Toto, STRING_BUFFER_4
.lyrasegg_end
	farwritetext LyraPhoneSpecialText_LyrasEgg
	setevent EVENT_LYRA_GAVE_AWAY_EGG
	specialphonecall SPECIALCALL_NONE
	end

.Chicory: db "Chicory@"
.Cinder:  db "Cinder@"
.Toto:    db "Toto@"
