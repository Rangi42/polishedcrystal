MACRO engine_flag
; location, bit
; (all locations are in WRAM bank 1)
	dwb \1 + (\2 / 8), 1 << (\2 % 8)
ENDM

EngineFlags:
; entries correspond to ENGINE_* constants
	table_width 3

	; pokegear
	engine_flag wPokegearFlags, POKEGEAR_RADIO_CARD_F
	engine_flag wPokegearFlags, POKEGEAR_MAP_CARD_F
	engine_flag wPokegearFlags, POKEGEAR_PHONE_CARD_F
	engine_flag wPokegearFlags, POKEGEAR_EXPN_CARD_F
	engine_flag wPokegearFlags, POKEGEAR_OBTAINED_F

	;   wDayCareMan, DAYCAREMAN_ACTIVE_F ; daycare 1 on
	engine_flag wDayCareMan, DAYCAREMAN_HAS_EGG_F ; egg is ready
	;   wDayCareMan, DAYCAREMAN_MONS_COMPATIBLE_F ; monster 1 and 2 are compatible
	engine_flag wDayCareMan, DAYCAREMAN_HAS_MON_F ; monster 1 in daycare
	;   wDayCareLady, DAYCARELADY_ACTIVE_F = daycare 2 on
	engine_flag wDayCareLady, DAYCARELADY_HAS_MON_F ; monster 2 in daycare

	engine_flag wMomSavingMoney, MOM_SAVING_SOME_MONEY_F
	engine_flag wMomSavingMoney, MOM_ACTIVE_F

	engine_flag wStatusFlags, STATUSFLAGS_POKEDEX_F
	engine_flag wStatusFlags, STATUSFLAGS_UNOWN_DEX_F
	engine_flag wStatusFlags, STATUSFLAGS_CAUGHT_POKERUS_F
	engine_flag wStatusFlags, STATUSFLAGS_ROCKET_SIGNAL_F
	engine_flag wStatusFlags, STATUSFLAGS_HALL_OF_FAME_F
	engine_flag wStatusFlags, 7 ; unused

	engine_flag wStatusFlags2, STATUSFLAGS2_ROCKETS_IN_RADIO_TOWER_F
	engine_flag wStatusFlags2, STATUSFLAGS2_SAFARI_GAME_F
	engine_flag wStatusFlags2, STATUSFLAGS2_BUG_CONTEST_TIMER_F
	engine_flag wStatusFlags2, STATUSFLAGS2_SEEN_SHAMOUTI_F
	engine_flag wStatusFlags2, STATUSFLAGS2_BIKE_SHOP_CALL_F
	engine_flag wStatusFlags2, 5 ; unused
	engine_flag wStatusFlags2, STATUSFLAGS2_EXORCISED_LAV_RADIO_F
	engine_flag wStatusFlags2, STATUSFLAGS2_ROCKETS_IN_MAHOGANY_F

	engine_flag wOWState, OWSTATE_STRENGTH
	engine_flag wOWState, OWSTATE_BIKING_FORCED
	engine_flag wOWState, OWSTATE_BIKING_DOWNHILL
	engine_flag wOWState, OWSTATE_SURF
	engine_flag wOWState, OWSTATE_ROCK_SMASH
	engine_flag wOWState, OWSTATE_HEADBUTT
	engine_flag wOWState, OWSTATE_WHIRLPOOL
	engine_flag wOWState, OWSTATE_WATERFALL
	engine_flag wOWState, OWSTATE_CUT

	engine_flag wJohtoBadges, ZEPHYRBADGE
	engine_flag wJohtoBadges, HIVEBADGE
	engine_flag wJohtoBadges, PLAINBADGE
	engine_flag wJohtoBadges, FOGBADGE
	engine_flag wJohtoBadges, MINERALBADGE
	engine_flag wJohtoBadges, STORMBADGE
	engine_flag wJohtoBadges, GLACIERBADGE
	engine_flag wJohtoBadges, RISINGBADGE

	engine_flag wKantoBadges, BOULDERBADGE
	engine_flag wKantoBadges, CASCADEBADGE
	engine_flag wKantoBadges, THUNDERBADGE
	engine_flag wKantoBadges, RAINBOWBADGE
	engine_flag wKantoBadges, MARSHBADGE
	engine_flag wKantoBadges, SOULBADGE
	engine_flag wKantoBadges, VOLCANOBADGE
	engine_flag wKantoBadges, EARTHBADGE

	; unown sets (see data/wild/unlocked_unowns.asm)
	engine_flag wUnlockedUnowns, UNLOCKED_UNOWNS_A_TO_J_F
	engine_flag wUnlockedUnowns, UNLOCKED_UNOWNS_K_TO_Q_F
	engine_flag wUnlockedUnowns, UNLOCKED_UNOWNS_R_TO_W_F
	engine_flag wUnlockedUnowns, UNLOCKED_UNOWNS_X_TO_QUESTION_F
	engine_flag wUnlockedUnowns, 4 ; unused
	engine_flag wUnlockedUnowns, 5 ; unused
	engine_flag wUnlockedUnowns, 6 ; unused
	engine_flag wUnlockedUnowns, 7 ; unused

	; fly
	engine_flag wVisitedSpawns, SPAWN_HOME
	engine_flag wVisitedSpawns, SPAWN_PALLET
	engine_flag wVisitedSpawns, SPAWN_VIRIDIAN
	engine_flag wVisitedSpawns, SPAWN_PEWTER
	engine_flag wVisitedSpawns, SPAWN_MT_MOON
	engine_flag wVisitedSpawns, SPAWN_CERULEAN
	engine_flag wVisitedSpawns, SPAWN_CERULEAN_CAPE
	engine_flag wVisitedSpawns, SPAWN_ROCK_TUNNEL
	engine_flag wVisitedSpawns, SPAWN_VERMILION
	engine_flag wVisitedSpawns, SPAWN_LAVENDER
	engine_flag wVisitedSpawns, SPAWN_SAFFRON
	engine_flag wVisitedSpawns, SPAWN_CELADON
	engine_flag wVisitedSpawns, SPAWN_FUCHSIA
	engine_flag wVisitedSpawns, SPAWN_CINNABAR
	engine_flag wVisitedSpawns, SPAWN_INDIGO
	engine_flag wVisitedSpawns, SPAWN_NEW_BARK
	engine_flag wVisitedSpawns, SPAWN_CHERRYGROVE
	engine_flag wVisitedSpawns, SPAWN_VIOLET
	engine_flag wVisitedSpawns, SPAWN_UNION_CAVE
	engine_flag wVisitedSpawns, SPAWN_AZALEA
	engine_flag wVisitedSpawns, SPAWN_CIANWOOD
	engine_flag wVisitedSpawns, SPAWN_GOLDENROD
	engine_flag wVisitedSpawns, SPAWN_OLIVINE
	engine_flag wVisitedSpawns, SPAWN_ECRUTEAK
	engine_flag wVisitedSpawns, SPAWN_SNOWTOP
	engine_flag wVisitedSpawns, SPAWN_MAHOGANY
	engine_flag wVisitedSpawns, SPAWN_YELLOW_FOREST
	engine_flag wVisitedSpawns, SPAWN_LAKE_OF_RAGE
	engine_flag wVisitedSpawns, SPAWN_BLACKTHORN
	engine_flag wVisitedSpawns, SPAWN_MT_SILVER
	engine_flag wVisitedSpawns, SPAWN_SHAMOUTI
	engine_flag wVisitedSpawns, SPAWN_VALENCIA
	engine_flag wVisitedSpawns, SPAWN_NAVEL

	engine_flag wLuckyNumberShowFlag, LUCKYNUMBERSHOW_GAME_OVER_F

	engine_flag wDailyFlags, DAILYFLAGS_KURT_MAKING_BALLS_F
	engine_flag wDailyFlags, DAILYFLAGS_DAILY_BUG_CONTEST_F
	engine_flag wDailyFlags, DAILYFLAGS_FISH_SWARM_F
	engine_flag wDailyFlags, DAILYFLAGS_VALERIE_MORNING_WALK_F
	engine_flag wDailyFlags, 4 ; unused
	engine_flag wDailyFlags, DAILYFLAGS_GOT_SHUCKIE_TODAY_F
	engine_flag wDailyFlags, DAILYFLAGS_GOLDENROD_UNDERGROUND_MERCHANT_CLOSED_F
	engine_flag wDailyFlags, DAILYFLAGS_FOUGHT_IN_TRAINER_HALL_TODAY_F

	engine_flag wDailyFlags2, DAILYFLAGS2_GYM_LEADER_REMATCH_1_F
	engine_flag wDailyFlags2, DAILYFLAGS2_GYM_LEADER_REMATCH_2_F
	engine_flag wDailyFlags2, DAILYFLAGS2_GYM_LEADER_REMATCH_3_F
	engine_flag wDailyFlags2, DAILYFLAGS2_DAILY_PHOTOGRAPH_F
	engine_flag wDailyFlags2, DAILYFLAGS2_DAILY_SHRINE_VISIT_F
	engine_flag wDailyFlags2, DAILYFLAGS2_DAILY_MYSTERY_GIFT_F
	engine_flag wDailyFlags2, DAILYFLAGS2_RED_IN_MOUNT_SILVER_F
	engine_flag wDailyFlags2, DAILYFLAGS2_LEAF_IN_NAVEL_ROCK_F

	engine_flag wDailyFlags3, DAILYFLAGS3_BOUGHT_LEFTOVERS_F
	engine_flag wDailyFlags3, DAILYFLAGS3_TOOK_HYPER_TEST_F
	engine_flag wDailyFlags3, DAILYFLAGS3_CHERYL_DONE_TODAY_F
	engine_flag wDailyFlags3, DAILYFLAGS3_RILEY_DONE_TODAY_F
	engine_flag wDailyFlags3, DAILYFLAGS3_BUCK_DONE_TODAY_F
	engine_flag wDailyFlags3, DAILYFLAGS3_MARLEY_DONE_TODAY_F
	engine_flag wDailyFlags3, DAILYFLAGS3_MIRA_DONE_TODAY_F
	engine_flag wDailyFlags3, DAILYFLAGS3_ANABEL_DONE_TODAY_F

	engine_flag wDailyFlags4, DAILYFLAGS4_SEASHORE_SHELL_BELL_F
	engine_flag wDailyFlags4, DAILYFLAGS4_SHAMOUTI_RESTAURANT_CHALLENGE_F
	engine_flag wDailyFlags4, DAILYFLAGS4_FOUGHT_PSYCHIC_INVER_F
	engine_flag wDailyFlags4, DAILYFLAGS4_BOUGHT_MOOMOO_MILK_F
	engine_flag wDailyFlags4, DAILYFLAGS4_CHANGED_TRENDY_PHRASE_F
	engine_flag wDailyFlags4, DAILYFLAGS4_ALL_HIDDEN_GROTTOES_F
	engine_flag wDailyFlags4, 6 ; unused
	engine_flag wDailyFlags4, 7 ; unused

	engine_flag wWeeklyFlags, WEEKLYFLAGS_MT_MOON_SQUARE_CLEFAIRY_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_UNION_CAVE_LAPRAS_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_GOLDENROD_UNDERGROUND_GOT_HAIRCUT_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_GOLDENROD_MALL_5F_HAPPINESS_EVENT_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_TEA_IN_BLUES_HOUSE_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_INDIGO_PLATEAU_RIVAL_FIGHT_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_INDIGO_PLATEAU_LYRA_FIGHT_F
	engine_flag wWeeklyFlags, WEEKLYFLAGS_BUENAS_PASSWORD_F

	engine_flag wSwarmFlags, SWARMFLAGS_BUENAS_PASSWORD_2_F
	engine_flag wSwarmFlags, SWARMFLAGS_GOLDENROD_DEPT_STORE_SALE_F

	engine_flag wCelebiEvent, CELEBIEVENT_FOREST_IS_RESTLESS_F

	; rematches
	engine_flag wDailyRematchFlags, 0  ; jack
	engine_flag wDailyRematchFlags, 1  ; huey
	engine_flag wDailyRematchFlags, 2  ; gaven
	engine_flag wDailyRematchFlags, 3  ; beth
	engine_flag wDailyRematchFlags, 4  ; jose
	engine_flag wDailyRematchFlags, 5  ; reena
	engine_flag wDailyRematchFlags, 6  ; joey
	engine_flag wDailyRematchFlags, 7  ; wade
	engine_flag wDailyRematchFlags, 8  ; ralph
	engine_flag wDailyRematchFlags, 9  ; liz
	engine_flag wDailyRematchFlags, 10 ; anthony
	engine_flag wDailyRematchFlags, 11 ; todd
	engine_flag wDailyRematchFlags, 12 ; gina
	engine_flag wDailyRematchFlags, 13 ; arnie
	engine_flag wDailyRematchFlags, 14 ; alan
	engine_flag wDailyRematchFlags, 15 ; dana
	engine_flag wDailyRematchFlags, 16 ; chad
	engine_flag wDailyRematchFlags, 17 ; tully
	engine_flag wDailyRematchFlags, 18 ; brent
	engine_flag wDailyRematchFlags, 19 ; tiffany
	engine_flag wDailyRematchFlags, 20 ; vance
	engine_flag wDailyRematchFlags, 21 ; wilton
	engine_flag wDailyRematchFlags, 22 ; parry
	engine_flag wDailyRematchFlags, 23 ; erin

	engine_flag wDailyPhoneItemFlags, 0 ; beverly has nugget
	engine_flag wDailyPhoneItemFlags, 1 ; jose has star piece
	engine_flag wDailyPhoneItemFlags, 2 ; wade has item (see EVENT_WADE_HAS_*** in constants/event_flags.asm)
	engine_flag wDailyPhoneItemFlags, 3 ; gina has leaf stone
	engine_flag wDailyPhoneItemFlags, 4 ; alan has fire stone
	engine_flag wDailyPhoneItemFlags, 5 ; liz has thunderstone
	engine_flag wDailyPhoneItemFlags, 6 ; derek has nugget
	engine_flag wDailyPhoneItemFlags, 7 ; tully has water stone
	engine_flag wDailyPhoneItemFlags, 8 ; tiffany has pink bow
	engine_flag wDailyPhoneItemFlags, 9 ; wilton has item (see EVENT_WILTON_HAS_*** in constants/event_flags.asm)

	engine_flag wDailyPhoneTimeOfDayFlags, 0  ; jack monday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 1  ; huey wednesday night
	engine_flag wDailyPhoneTimeOfDayFlags, 2  ; gaven thursday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 3  ; beth friday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 4  ; jose saturday night
	engine_flag wDailyPhoneTimeOfDayFlags, 5  ; reena sunday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 6  ; joey monday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 7  ; wade tuesday night
	engine_flag wDailyPhoneTimeOfDayFlags, 8  ; ralph wednesday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 9  ; liz thursday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 10 ; anthony fiday night
	engine_flag wDailyPhoneTimeOfDayFlags, 11 ; todd saturday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 12 ; gina sunday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 13 ; arnie tuesday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 14 ; alan wednesday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 15 ; dana thursday night
	engine_flag wDailyPhoneTimeOfDayFlags, 16 ; chad friday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 17 ; tully sunday night
	engine_flag wDailyPhoneTimeOfDayFlags, 18 ; brent monday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 19 ; tiffany tuesday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 20 ; vance wednesday night
	engine_flag wDailyPhoneTimeOfDayFlags, 21 ; wilton thursday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 22 ; parry friday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 23 ; erin saturday night

	engine_flag wSwarmFlags, SWARMFLAGS_DUNSPARCE_SWARM_F
	engine_flag wSwarmFlags, SWARMFLAGS_YANMA_SWARM_F

	engine_flag wPokemonJournals, FALKNER_JOURNAL
	engine_flag wPokemonJournals, BUGSY_JOURNAL
	engine_flag wPokemonJournals, WHITNEY_JOURNAL
	engine_flag wPokemonJournals, MORTY_JOURNAL
	engine_flag wPokemonJournals, CHUCK_JOURNAL
	engine_flag wPokemonJournals, JASMINE_JOURNAL
	engine_flag wPokemonJournals, PRYCE_JOURNAL
	engine_flag wPokemonJournals, CLAIR_JOURNAL
	engine_flag wPokemonJournals, BROCK_JOURNAL
	engine_flag wPokemonJournals, MISTY_JOURNAL
	engine_flag wPokemonJournals, LT_SURGE_JOURNAL
	engine_flag wPokemonJournals, ERIKA_JOURNAL
	engine_flag wPokemonJournals, JANINE_JOURNAL
	engine_flag wPokemonJournals, SABRINA_JOURNAL
	engine_flag wPokemonJournals, BLAINE_JOURNAL
	engine_flag wPokemonJournals, BLUE_JOURNAL
	engine_flag wPokemonJournals, WILL_JOURNAL
	engine_flag wPokemonJournals, KOGA_JOURNAL
	engine_flag wPokemonJournals, BRUNO_JOURNAL
	engine_flag wPokemonJournals, KAREN_JOURNAL
	engine_flag wPokemonJournals, LANCE_JOURNAL
	engine_flag wPokemonJournals, RED_JOURNAL
	engine_flag wPokemonJournals, GREEN_JOURNAL
	engine_flag wPokemonJournals, PROF_OAK_JOURNAL
	engine_flag wPokemonJournals, PROF_ELM_JOURNAL
	engine_flag wPokemonJournals, PROF_IVY_JOURNAL
	engine_flag wPokemonJournals, PROF_WESTWOOD_JOURNAL
	engine_flag wPokemonJournals, GIOVANNI_JOURNAL
	engine_flag wPokemonJournals, LORELEI_JOURNAL
	engine_flag wPokemonJournals, AGATHA_JOURNAL
	engine_flag wPokemonJournals, BILL_JOURNAL
	engine_flag wPokemonJournals, KURT_JOURNAL
	engine_flag wPokemonJournals, MR_FUJI_JOURNAL
	engine_flag wPokemonJournals, PROF_WILLOW_JOURNAL
	engine_flag wPokemonJournals, STEVEN_JOURNAL
	engine_flag wPokemonJournals, CYNTHIA_JOURNAL
	engine_flag wPokemonJournals, WALKER_JOURNAL
	engine_flag wPokemonJournals, KIYO_JOURNAL
	engine_flag wPokemonJournals, PALMER_JOURNAL
	engine_flag wPokemonJournals, THORTON_JOURNAL

	engine_flag wStatusFlags3, STATUSFLAGS3_JUDGE_MACHINE_F

	engine_flag wPlayerCaught, PLAYER_CAUGHT_HO_OH_F
	engine_flag wPlayerCaught, PLAYER_CAUGHT_LUGIA_F
	engine_flag wPlayerCaught, PLAYER_CAUGHT_RAIKOU_F
	engine_flag wPlayerCaught, PLAYER_CAUGHT_ENTEI_F
	engine_flag wPlayerCaught, PLAYER_CAUGHT_SUICUNE_F
	engine_flag wPlayerCaught, PLAYER_CAUGHT_ARTICUNO_F
	engine_flag wPlayerCaught, PLAYER_CAUGHT_ZAPDOS_F
	engine_flag wPlayerCaught, PLAYER_CAUGHT_MOLTRES_F

	engine_flag wPlayerCaught2, PLAYER_CAUGHT_MEW_F
	engine_flag wPlayerCaught2, PLAYER_CAUGHT_MEWTWO_F
	engine_flag wPlayerCaught2, PLAYER_CAUGHT_CELEBI_F
	engine_flag wPlayerCaught2, PLAYER_CAUGHT_SUDOWOODO_F
	engine_flag wPlayerCaught2, PLAYER_CAUGHT_GALARIAN_ARTICUNO_F
	engine_flag wPlayerCaught2, PLAYER_CAUGHT_GALARIAN_ZAPDOS_F
	engine_flag wPlayerCaught2, PLAYER_CAUGHT_GALARIAN_MOLTRES_F
	engine_flag wPlayerCaught2, PLAYER_CAUGHT_BLOODMOON_URSALUNA_F

	assert_table_length NUM_ENGINE_FLAGS
