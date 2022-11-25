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
	farwritetext LyraPhoneEvolutionQuestionText
	yesorno
	iftruefwd .describe_evolution
	farwritetext LyraPhoneEvolutionRefusedText
	sjumpfwd .done
.describe_evolution
	callasm LyraPhone_GetFirstMonEvolutionData
	scalltable LyraPhoneScript_EvolutionMethodsTable
.done
	farwritetext LyraPhoneEndText
	end

.CeladonUniversity: db "Celadon U@"
.PokemonLeague:     db "#mon League@"

LyraPhoneScript_GreetingsTable:
	table_width 2, LyraPhoneScript_GreetingsTable
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
	table_width 2, LyraPhoneScript_JohtoLandmarksTable
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

LyraPhoneScript_EvolutionMethodsTable:
	table_width 2, LyraPhoneScript_EvolutionMethodsTable
	dw .EvolveNone
	dw .EvolveLevel
	dw .EvolveItem
	dw .EvolveHolding
	dw .EvolveHappiness
	dw .EvolveStat
	dw .EvolveLocation
	dw .EvolveMove
	dw .EvolveEVs
	dw .EvolveCrit
	dw .EvolveParty
	dw .EvolveEgg
	dw .EvolvePikachu
	dw .EvolveGloom
	dw .EvolvePoliwhirl
	dw .EvolveSlowpokePlain
	dw .EvolveSlowpokeGalarian
	dw .EvolveMagneton
	dw .EvolveExeggcute
	dw .EvolveKoffing
	dw .EvolveCubone
	dw .EvolveScyther
	dw .EvolveEevee
	dw .EvolveMimeJr
	dw .EvolveUrsaring
	dw .EvolveStantler
	dw .EvolveDunsparce
	assert_table_length NUM_EVOLVE_METHODS
.EvolveNone:
	farwritetext LyraPhoneEvoText_None
	end
.EvolveLevel:
	farwritetext LyraPhoneEvoText_Level
	end
.EvolveItem:
	farwritetext LyraPhoneEvoText_Item
	end
.EvolveHolding:
	readmem wStringBuffer5
	ifequalfwd TR_MORNDAY, .EvolveHolding_MornDay
	ifequalfwd TR_EVENITE, .EvolveHolding_EveNite
	farwritetext LyraPhoneEvoText_Holding
	end
.EvolveHolding_MornDay:
	farwritetext LyraPhoneEvoText_Holding_MornDay
	end
.EvolveHolding_EveNite:
	farwritetext LyraPhoneEvoText_Holding_EveNite
	end
.EvolveHappiness:
	readmem wStringBuffer5
	ifequalfwd TR_MORNDAY, .EvolveHappiness_MornDay
	ifequalfwd TR_EVENITE, .EvolveHappiness_EveNite
	farwritetext LyraPhoneEvoText_Happiness
	end
.EvolveHappiness_MornDay:
	farwritetext LyraPhoneEvoText_Happiness_MornDay
	end
.EvolveHappiness_EveNite:
	farwritetext LyraPhoneEvoText_Happiness_EveNite
	end
.EvolveStat:
	farwritetext LyraPhoneEvoText_Stat
	end
.EvolveLocation:
	farwritetext LyraPhoneEvoText_Location
	end
.EvolveMove:
	farwritetext LyraPhoneEvoText_Move
	end
.EvolveEVs:
	farwritetext LyraPhoneEvoText_EVs
	end
.EvolveCrit:
	farwritetext LyraPhoneEvoText_Crit
	end
.EvolveParty:
	farwritetext LyraPhoneEvoText_Party
	end
.EvolveEgg:
	farwritetext LyraPhoneEvoText_Egg
	end
.EvolvePikachu:
	farwritetext LyraPhoneEvoText_Pikachu
	end
.EvolveGloom:
	farwritetext LyraPhoneEvoText_Gloom
	end
.EvolvePoliwhirl:
	farwritetext LyraPhoneEvoText_Poliwhirl
	end
.EvolveSlowpokePlain:
	farwritetext LyraPhoneEvoText_SlowpokePlain
	end
.EvolveSlowpokeGalarian:
	farwritetext LyraPhoneEvoText_SlowpokeGalarian
	end
.EvolveMagneton:
	farwritetext LyraPhoneEvoText_Magneton
	end
.EvolveExeggcute:
	farwritetext LyraPhoneEvoText_Exeggcute
	end
.EvolveKoffing:
	farwritetext LyraPhoneEvoText_Koffing
	end
.EvolveCubone:
	farwritetext LyraPhoneEvoText_Cubone
	end
.EvolveScyther:
	farwritetext LyraPhoneEvoText_Scyther
	end
.EvolveEevee:
	farwritetext LyraPhoneEvoText_Eevee
	end
.EvolveMimeJr:
	farwritetext LyraPhoneEvoText_MimeJr
	end
.EvolveUrsaring:
	getitemname MOON_STONE, STRING_BUFFER_4
	farwritetext LyraPhoneEvoText_Item
	farwritetext LyraPhoneEvoText_AncientSinnoh
	end
.EvolveStantler:
	farwritetext LyraPhoneEvoText_Stantler
	farwritetext LyraPhoneEvoText_AncientSinnoh
	end
.EvolveDunsparce:
	loadmem wStringBuffer4, 32
	farwritetext LyraPhoneEvoText_Level
	farwritetext LyraPhoneEvoText_DunsparceSegments
	end

LyraPhone_GetFirstMonEvolutionData:
	; get first non-Egg party mon
	ld hl, wPartyMon1Species
.first_loop
	ld a, [hl]
	ld bc, MON_IS_EGG - MON_SPECIES
	add hl, bc
	bit MON_IS_EGG_F, [hl]
	jr z, .got_mon
	ld bc, PARTYMON_STRUCT_LENGTH - MON_IS_EGG
	add hl, bc
	jr .first_loop
.got_mon
	ld c, a ; species
	ld [wNamedObjectIndex], a
	assert MON_IS_EGG == MON_FORM
	ld a, [hl]
	ld b, a ; ext species/form
	ld [wNamedObjectIndex+1], a
	; wStringBuffer3 = species name
	push bc
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wStringBuffer3
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	pop bc
	; hScriptVar, wStringBuffer4, wStringBuffer5 = evo data
	farcall GetEvolutionData
	ldh [hScriptVar], a
	ret

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
