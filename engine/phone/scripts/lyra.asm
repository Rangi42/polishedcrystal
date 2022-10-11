LyraPhoneScript:
	readmem wTimeOfDay
	scalltable LyraPhoneScript_GreetingsTable
	checkpoke MAGNETON
	iftruefwd .Magneton
	farwritetext LyraPhoneMainText
	end

.Magneton:
	farwritetext LyraPhoneMagnetonText
	farwritetext LyraPhoneEndText
	end

LyraPhoneScript_GreetingsTable:
	table_width 2, LyraPhoneScript_GreetingsTable
	dw .MornGreeting
	dw .DayGreeting
	dw .NiteGreeting
	dw .EveGreeting
	assert_table_length NUM_DAYTIMES
.MornGreeting:
	farwritetext LyraPhoneMornGreetingText
	end
.DayGreeting:
	farwritetext LyraPhoneDayGreetingText
	end
.EveGreeting:
	farwritetext LyraPhoneEveGreetingText
	end
.NiteGreeting:
	farwritetext LyraPhoneNiteGreetingText
	end

LyraPhoneScript2:
	readvar VAR_SPECIALPHONECALL
	ifequalfwd SPECIALCALL_YELLOWFOREST, .YellowForest
	ifequalfwd SPECIALCALL_FIRSTBADGE, .FirstBadge
	ifequalfwd SPECIALCALL_LYRASEGG, .LyrasEgg
	specialphonecall SPECIALCALL_NONE
	sjump LyraPhoneScript

.YellowForest:
	farwritetext LyraPhoneYellowForestText
	specialphonecall SPECIALCALL_NONE
	end

.FirstBadge:
	farwritetext LyraPhoneFirstBadgeText
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
	farwritetext LyraPhoneLyrasEggText
	setevent EVENT_LYRA_GAVE_AWAY_EGG
	specialphonecall SPECIALCALL_NONE
	end

.Chicory: db "Chicory@"
.Cinder:  db "Cinder@"
.Toto:    db "Toto@"

/*
NEW_BARK_TOWN
ROUTE_29
CHERRYGROVE_CITY
CHERRYGROVE_BAY
ROUTE_30
ROUTE_31
VIOLET_CITY
SPROUT_TOWER
VIOLET_OUTSKIRTS
RUINS_OF_ALPH
ROUTE_32
ROUTE_32_COAST
UNION_CAVE ; no calls
ROUTE_33
AZALEA_TOWN
SLOWPOKE_WELL ; no calls
ILEX_FOREST
ROUTE_34
ROUTE_34_COAST
STORMY_BEACH
MURKY_SWAMP
GOLDENROD_CITY
RADIO_TOWER ; no calls
GOLDENROD_HARBOR
MAGNET_TUNNEL
ROUTE_35
ROUTE_35_COAST
NATIONAL_PARK
ROUTE_36
ROUTE_37
ECRUTEAK_CITY
BELLCHIME_TRAIL
TIN_TOWER
BURNED_TOWER ; no calls
ROUTE_38
ROUTE_39
RUGGED_ROAD
SNOWTOP_MOUNTAIN
OLIVINE_CITY
LIGHTHOUSE
ROUTE_40
BATTLE_TOWER
WHIRL_ISLANDS ; no calls
ROUTE_41
CIANWOOD_CITY
CLIFF_EDGE_GATE ; no calls
ROUTE_47
CLIFF_CAVE ; no calls
ROUTE_48
YELLOW_FOREST
QUIET_CAVE ; no calls
ROUTE_42
MT_MORTAR ; no calls
MAHOGANY_TOWN
ROUTE_43
LAKE_OF_RAGE
ROUTE_44
ICE_PATH ; no calls
BLACKTHORN_CITY
DRAGONS_DEN ; no calls
ROUTE_45
DARK_CAVE ; no calls
ROUTE_46
SILVER_CAVE
FAST_SHIP
SINJOH_RUINS ; no calls
MYSTRI_STAGE ; no calls

KANTO_LANDMARK
*/
