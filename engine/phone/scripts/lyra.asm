LyraPhoneScript:
	readmem wTimeOfDay
	scalltable LyraPhoneScript_GreetingsTable
	getcurlandmarkname $1
	readvar VAR_LANDMARK
	; Special-case too-long landmark names
	ifnotequal CELADON_UNIVERSITY, .not_celadon_university
	getstring .CeladonUniversity, $1
	sjumpfwd .got_landmark
.not_celadon_university
	ifnotequal POKEMON_LEAGUE, .got_landmark
	getstring .PokemonLeague, $1
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
	callasm LyraPhone_GetFirstMonNextMoveLevel
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

.CeladonUniversity: db "Celadon U@"
.PokemonLeague:     db "#mon League@"

LyraPhone_GetFirstMonNextMoveLevel:
	; wStringBuffer3 = species name
	call EvolutionPhone_GetFirstNonEggPartyMon
	; hScriptVar = move level
	farcall GetNextMoveLevel
	ldh [hScriptVar], a
	ret

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
	dw .NewBarkTown
	dw .Route29
	dw .CherrygroveCity
	dw .CherrygroveBay
	dw .Route30
	dw .Route31
	dw .VioletCity
	dw .SproutTower
	dw .VioletOutskirts
	dw .RuinsOfAlph
	dw .Route32
	dw .Route32Coast
	dw .UnionCave ; no calls
	dw .Route33
	dw .AzaleaTown
	dw .SlowpokeWell ; no calls
	dw .IlexForest
	dw .Route34
	dw .Route34Coast
	dw .StormyBeach
	dw .MurkySwamp
	dw .GoldenrodCity
	dw .RadioTower ; no calls
	dw .GoldenrodHarbor
	dw .MagnetTunnel
	dw .Route35
	dw .Route35Coast
	dw .NationalPark
	dw .Route36
	dw .Route37
	dw .EcruteakCity
	dw .BellchimeTrail
	dw .TinTower
	dw .BurnedTower ; no calls
	dw .Route38
	dw .Route39
	dw .RuggedRoad
	dw .SnowtopMountain
	dw .OlivineCity
	dw .Lighthouse
	dw .Route40
	dw .BattleTower
	dw .WhirlIslands ; no calls
	dw .Route41
	dw .CianwoodCity
	dw .CliffEdgeGate ; no calls
	dw .Route47
	dw .CliffCave ; no calls
	dw .Route48
	dw .YellowForest
	dw .QuietCave ; no calls
	dw .Route42
	dw .MtMortar ; no calls
	dw .MahoganyTown
	dw .Route43
	dw .LakeOfRage
	dw .Route44
	dw .IcePath ; no calls
	dw .BlackthornCity
	dw .DragonsDen ; no calls
	dw .Route45
	dw .DarkCave ; no calls
	dw .Route46
	dw .SilverCave
	dw .FastShip
	dw .SinjohRuins ; no calls
	dw .MystriStage ; no calls
	assert_table_length KANTO_LANDMARK
.Generic:
.NewBarkTown:
.Route29:
.CherrygroveCity:
.CherrygroveBay:
.Route30:
.Route31:
.VioletCity:
.SproutTower:
.VioletOutskirts:
.RuinsOfAlph:
.Route32:
.Route32Coast:
.UnionCave:
.Route33:
.AzaleaTown:
.SlowpokeWell:
.IlexForest:
.Route34:
.Route34Coast:
.StormyBeach:
.MurkySwamp:
.GoldenrodCity:
.RadioTower:
.GoldenrodHarbor:
.MagnetTunnel:
.Route35:
.Route35Coast:
.NationalPark:
.Route36:
.Route37:
.EcruteakCity:
.BellchimeTrail:
.TinTower:
.BurnedTower:
.Route38:
.Route39:
.RuggedRoad:
.SnowtopMountain:
.OlivineCity:
.Lighthouse:
.Route40:
.BattleTower:
.WhirlIslands:
.Route41:
.CianwoodCity:
.CliffEdgeGate:
.Route47:
.CliffCave:
.Route48:
.YellowForest:
.QuietCave:
.Route42:
.MtMortar:
.MahoganyTown:
.Route43:
.LakeOfRage:
.Route44:
.IcePath:
.BlackthornCity:
.DragonsDen:
.Route45:
.DarkCave:
.Route46:
.SilverCave:
.FastShip:
.SinjohRuins:
.MystriStage:
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
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftruefwd .lyrasegg_totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftruefwd .lyrasegg_chikorita
	getstring .Chicory, $1
	sjumpfwd .lyrasegg_end
.lyrasegg_totodile
	getstring .Cinder, $1
	sjumpfwd .lyrasegg_end
.lyrasegg_chikorita:
	getstring .Toto, $1
.lyrasegg_end
	farwritetext LyraPhoneSpecialText_LyrasEgg
	setevent EVENT_LYRA_GAVE_AWAY_EGG
	specialphonecall SPECIALCALL_NONE
	end

.Chicory: db "Chicory@"
.Cinder:  db "Cinder@"
.Toto:    db "Toto@"
