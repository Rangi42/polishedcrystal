; wInputType::
DEF AUTO_INPUT EQU $ff

; wMonType::
	const_def
	const PARTYMON   ; 0
	const OTPARTYMON ; 1
	const BOXMON     ; 2
	const TEMPMON    ; 3
	const WILDMON    ; 4

; wJumptableIndex::
DEF JUMPTABLE_INDEX_MASK EQU %01111111
	const_def 7
	shift_const JUMPTABLE_EXIT

; wJoypadDisable::
DEF JOYPAD_DISABLE_MON_FAINT_F    EQU 6
DEF JOYPAD_DISABLE_SGB_TRANSFER_F EQU 7

; wOptions3::
	const_def
	const QWERTY_KEYBOARD_F  ; 0

; wOptions1::
	const_def 3
	const AUTOSCROLL_ABF ; 3
	const TURNING_SPEED  ; 4
	const NO_TEXT_SCROLL ; 5
	const STEREO         ; 6
	const BATTLE_EFFECTS ; 7
DEF TEXT_DELAY_MASK    EQU %00011
; JoyCheckTextAdvance relies on exact bit usage and order
DEF AUTOSCROLL_MASK    EQU %01100
DEF AUTOSCROLL_NONE    EQU %00000
DEF AUTOSCROLL_START   EQU %00100
DEF AUTOSCROLL_B       EQU %01000 ; from Mystery Dungeon
DEF AUTOSCROLL_AORB    EQU %01100
DEF TURNING_SPEED_MASK EQU %10000

	const_def
	const SLOW_TEXT ; %00
	const MED_TEXT ; %01
	const FAST_TEXT  ; %10
	const INST_TEXT ; %11

; wTextboxFrame::
	const_def
	const FRAME_1  ;  0
	const FRAME_2  ;  1
	const FRAME_3  ;  2
	const FRAME_4  ;  3
	const FRAME_5  ;  4
	const FRAME_6  ;  5
	const FRAME_7  ;  6
	const FRAME_8  ;  7
	const FRAME_9  ;  8
	const FRAME_10 ;  9
	const FRAME_11 ;  a
	const FRAME_12 ;  b
	const FRAME_13 ;  c
	const FRAME_14 ;  d
	const FRAME_15 ;  e
	const FRAME_16 ;  f
	const FRAME_17 ; 10
	const FRAME_18 ; 11
	const FRAME_19 ; 12
	const FRAME_20 ; 13
DEF NUM_FRAMES EQU const_value

; wTextboxFlags::
	const_def
	const FAST_TEXT_DELAY_F  ; 0
	const TEXT_DELAY_F       ; 1
	const NO_LINE_SPACING_F  ; 2
	const USE_BG_MAP_WIDTH_F ; 3
	const NEWLINE_ENEMY_F    ; 4

; wOptions2::
	const_def 3
	const RUNNING_SHOES  ; 3
	const CLOCK_FORMAT   ; 4
	const POKEDEX_UNITS  ; 5
	const BATTLE_SWITCH  ; 6
	const BATTLE_PREDICT ; 7
DEF FONT_MASK EQU %00000111

	const_def
	const NORMAL_FONT  ; %000
	const NARROW_FONT  ; %001
	const BOLD_FONT    ; %010
	const ITALIC_FONT  ; %011
	const SERIF_FONT   ; %100
	const CHICAGO_FONT ; %101
	const MICR_FONT    ; %110
	const UNOWN_FONT   ; %111
DEF NUM_FONTS EQU const_value

; wInitialOptions::
	const_def
	const NATURES_OPT      ; 0
	const ABILITIES_OPT    ; 1
	const COLOR_VARY_OPT   ; 2
	const PERFECT_IVS_OPT  ; 3
	const TRADED_AS_OT_OPT ; 4
	const AFFECTION_OPT    ; 5
	const SCALED_EXP_OPT   ; 6
	const PSS_OPT          ; 7

DEF ABILITIES_OPTMASK EQU 1 << ABILITIES_OPT
DEF LINK_OPTMASK EQU (1 << NATURES_OPT) | (1 << ABILITIES_OPT) | (1 << PERFECT_IVS_OPT) | (1 << PSS_OPT)

; wInitialOptions2::
	const_def 2
	const NO_EXP_OPT           ; 2
	const RTC_OPT              ; 3
	const EVOLVE_IN_BATTLE_OPT ; 4
	const_skip 2
	const RESET_INIT_OPTS      ; 7

	const_def
	const EVS_OPT_DISABLED ; %00
	const EVS_OPT_CLASSIC  ; %01
	const EVS_OPT_MODERN   ; %10
DEF EV_OPTMASK EQU %11

; wForgettingMove::
	const_def 6
	const LEARNING_TM_F     ; 6
	const FORGETTING_MOVE_F ; 7

DEF LEARNING_TM       EQU 1 << LEARNING_TM_F
DEF FORGETTING_MOVE   EQU 1 << FORGETTING_MOVE_F

; wWalkingDirection::
	const_def -1
	const STANDING ; -1
	const DOWN     ; 0
	const UP       ; 1
	const LEFT     ; 2
	const RIGHT    ; 3
DEF NUM_DIRECTIONS EQU const_value

DEF DOWN_MASK  EQU 1 << DOWN
DEF UP_MASK    EQU 1 << UP
DEF LEFT_MASK  EQU 1 << LEFT
DEF RIGHT_MASK EQU 1 << RIGHT

; wFacingDirection::
DEF FACE_CURRENT EQU 0
DEF FACE_DOWN  EQU 8
DEF FACE_UP    EQU 4
DEF FACE_LEFT  EQU 2
DEF FACE_RIGHT EQU 1

; wStateFlags
DEF SPRITE_UPDATES_DISABLED_F             EQU 0
DEF LAST_12_SPRITE_OAM_STRUCTS_RESERVED_F EQU 1
DEF TEXT_STATE_F                          EQU 6
DEF SCRIPTED_MOVEMENT_STATE_F             EQU 7

; wPokemonWithdrawDepositParameter::
DEF PC_WITHDRAW       EQU 0
DEF PC_DEPOSIT        EQU 1
DEF REMOVE_PARTY      EQU 0
DEF REMOVE_BOX        EQU 1
DEF DAY_CARE_WITHDRAW EQU 2
DEF DAY_CARE_DEPOSIT  EQU 3

; wPlayerStepFlags::
	const_def 4
	const PLAYERSTEP_MIDAIR_F   ; 4
	const PLAYERSTEP_CONTINUE_F ; 5
	const PLAYERSTEP_STOP_F     ; 6
	const PLAYERSTEP_START_F    ; 7

; wTimeOfDay::
	const_def
	const MORN ; 0
	const DAY  ; 1
	const NITE ; 2
	const EVE  ; 3
DEF NUM_DAYTIMES EQU const_value

; wBattleAnimFlags::
	const_def
	const BATTLEANIM_STOP_F          ; 0
	const BATTLEANIM_IN_SUBROUTINE_F ; 1
	const BATTLEANIM_IN_LOOP_F       ; 2
	const BATTLEANIM_KEEPSPRITES_F   ; 3

; wPlayerSpriteSetupFlags::
DEF PLAYERSPRITESETUP_FACING_MASK       EQU %11
DEF PLAYERSPRITESETUP_CUSTOM_FACING_F   EQU 5
DEF PLAYERSPRITESETUP_SKIP_RELOAD_GFX_F EQU 6
DEF PLAYERSPRITESETUP_RESET_ACTION_F    EQU 7

; wPlayerGender::
	const_def
	const PLAYER_MALE   ; 0
	const PLAYER_FEMALE ; 1
	const PLAYER_ENBY   ; 2
DEF NUM_PLAYER_GENDERS EQU const_value

; wMapStatus::
	const_def
	const MAPSTATUS_START  ; 0
	const MAPSTATUS_ENTER  ; 1
	const MAPSTATUS_HANDLE ; 2
	const MAPSTATUS_DONE   ; 3

; wMapEventStatus::
	const_def
	const MAPEVENTS_ON  ; 0
	const MAPEVENTS_OFF ; 1

; wScriptFlags::
DEF SCRIPT_RUNNING EQU 2

; wScriptMode::
	const_def
	const SCRIPT_OFF
	const SCRIPT_READ
	const SCRIPT_WAIT_MOVEMENT
	const SCRIPT_WAIT

; wSpawnAfterChampion::
DEF SPAWN_LANCE EQU 1
DEF SPAWN_LEAF  EQU 2

; wCurDay::
	const_def
	const SUNDAY    ; 0
	const MONDAY    ; 1
	const TUESDAY   ; 2
	const WEDNESDAY ; 3
	const THURSDAY  ; 4
	const FRIDAY    ; 5
	const SATURDAY  ; 6

; wStatusFlags::
	const_def
	const STATUSFLAGS_POKEDEX_F                  ; 0
	const STATUSFLAGS_UNOWN_DEX_F                ; 1
	const STATUSFLAGS_FLASH_F                    ; 2
	const STATUSFLAGS_CAUGHT_POKERUS_F           ; 3
	const STATUSFLAGS_ROCKET_SIGNAL_F            ; 4
	const STATUSFLAGS_NO_WILD_ENCOUNTERS_F       ; 5
	const STATUSFLAGS_HALL_OF_FAME_F             ; 6

; wStatusFlags2::
	const_def
	const STATUSFLAGS2_ROCKETS_IN_RADIO_TOWER_F  ; 0
	const STATUSFLAGS2_SAFARI_GAME_F             ; 1
	const STATUSFLAGS2_BUG_CONTEST_TIMER_F       ; 2
	const STATUSFLAGS2_SEEN_SHAMOUTI_F           ; 3
	const STATUSFLAGS2_BIKE_SHOP_CALL_F          ; 4
	const STATUSFLAGS2_CAN_USE_SWEET_SCENT_F     ; 5
	const STATUSFLAGS2_EXORCISED_LAV_RADIO_F     ; 6
	const STATUSFLAGS2_ROCKETS_IN_MAHOGANY_F     ; 7

; wStatusFlags3::
	const_def
	const STATUSFLAGS3_JUDGE_MACHINE_F ; 0

; wMomSavingMoney::
DEF MOM_SAVING_SOME_MONEY_F EQU 0
DEF MOM_SAVING_HALF_MONEY_F EQU 1
DEF MOM_SAVING_ALL_MONEY_F  EQU 2
DEF MOM_ACTIVE_F            EQU 7

DEF MOM_SAVING_MONEY_MASK EQU (1 << MOM_SAVING_SOME_MONEY_F) | (1 << MOM_SAVING_HALF_MONEY_F) | (1 << MOM_SAVING_ALL_MONEY_F)

; wJohtoBadges::
	const_def
	const ZEPHYRBADGE
	const HIVEBADGE
	const PLAINBADGE
	const FOGBADGE
	const MINERALBADGE
	const STORMBADGE
	const GLACIERBADGE
	const RISINGBADGE
DEF NUM_JOHTO_BADGES EQU const_value

; wKantoBadges::
	const_def
	const BOULDERBADGE
	const CASCADEBADGE
	const THUNDERBADGE
	const RAINBOWBADGE
	const MARSHBADGE
	const SOULBADGE
	const VOLCANOBADGE
	const EARTHBADGE
DEF NUM_KANTO_BADGES EQU const_value
DEF NUM_BADGES EQU NUM_JOHTO_BADGES + NUM_KANTO_BADGES

; wPokegearFlags::
	const_def
	const POKEGEAR_MAP_CARD_F   ; 0
	const POKEGEAR_RADIO_CARD_F ; 1
	const POKEGEAR_PHONE_CARD_F ; 2
	const POKEGEAR_EXPN_CARD_F  ; 3
	const_skip 3
	const POKEGEAR_OBTAINED_F   ; 7

; wRegisteredItemFlags::
	const_def
	const REGISTERED_KEY_ITEM_0    ; 0
	const REGISTERED_KEY_ITEM_1    ; 1
	const REGISTERED_KEY_ITEM_2    ; 2
	const REGISTERED_KEY_ITEM_3    ; 3
	const REGISTERED_SECOND_ITEM_0 ; 4
	const REGISTERED_SECOND_ITEM_1 ; 5
	const REGISTERED_SECOND_ITEM_2 ; 6
	const REGISTERED_SECOND_ITEM_3 ; 7

; wOWState::
	const_def
	const OWSTATE_STRENGTH        ; 0
	const OWSTATE_BIKING_FORCED   ; 1
	const OWSTATE_BIKING_DOWNHILL ; 2
	const OWSTATE_SURF            ; 3
	const OWSTATE_ROCK_SMASH      ; 4
	const OWSTATE_HEADBUTT        ; 5
	const OWSTATE_WHIRLPOOL       ; 6
	const OWSTATE_WATERFALL       ; 7
	const OWSTATE_CUT             ; 8

; wPlayerState::
DEF PLAYER_NORMAL    EQU 0
DEF PLAYER_BIKE      EQU 1
DEF PLAYER_SKATE     EQU 2
DEF PLAYER_SURF      EQU 4
DEF PLAYER_SURF_PIKA EQU 8

; wPalFadeMode::
DEF PALFADE_WHICH        EQU %11
DEF PALFADE_FLASH_F      EQU 2
DEF PALFADE_PARTIAL_F    EQU 3
DEF PALFADE_SKIP_FIRST_F EQU 4

; hBattlePalFadeMode::
DEF PALFADE_BOTH       EQU %00
DEF PALFADE_BG         EQU %01
DEF PALFADE_OBJ        EQU %10
DEF PALFADE_FLASH      EQU 1 << PALFADE_FLASH_F
DEF PALFADE_PARTIAL    EQU 1 << PALFADE_PARTIAL_F
DEF PALFADE_SKIP_FIRST EQU 1 << PALFADE_SKIP_FIRST_F

; wDayCareMan::
DEF DAYCAREMAN_HAS_MON_F         EQU 0
DEF DAYCAREMAN_MONS_COMPATIBLE_F EQU 5
DEF DAYCAREMAN_HAS_EGG_F         EQU 6
DEF DAYCAREMAN_ACTIVE_F          EQU 7

; wDayCareLady::
DEF DAYCARELADY_HAS_MON_F        EQU 0
DEF DAYCARELADY_ACTIVE_F         EQU 7

; wHiddenGrottoContents::
	const_def
	const GROTTO_UNDEFINED
	const GROTTO_POKEMON
	const GROTTO_ITEM
	const GROTTO_HIDDEN_ITEM
	const GROTTO_EMPTY

; wPokemonJournals::
	const_def
	const FALKNER_JOURNAL ; Violet Pokémon Center
	const BUGSY_JOURNAL ; Azalea Pokémon Center
	const WHITNEY_JOURNAL ; Goldenrod PokéCom Center
	const MORTY_JOURNAL ; Ecruteak Pokémon Center
	const CHUCK_JOURNAL ; Cianwood Pokémon Center
	const JASMINE_JOURNAL ; Olivine Pokémon Center
	const PRYCE_JOURNAL ; Mahogany Pokémon Center
	const CLAIR_JOURNAL ; Blackthorn Pokémon Center
	const BROCK_JOURNAL ; Pewter Pokémon Center
	const MISTY_JOURNAL ; Cerulean Pokémon Center
	const LT_SURGE_JOURNAL ; Vermilion Pokémon Center
	const ERIKA_JOURNAL ; Celadon Pokémon Center
	const JANINE_JOURNAL ; Fuchsia Pokémon Center
	const SABRINA_JOURNAL ; Saffron Pokémon Center
	const BLAINE_JOURNAL ; Cinnabar Pokémon Center
	const BLUE_JOURNAL ; Viridian Pokémon Center
	const WILL_JOURNAL ; Mahogany Souvenir Shop
	const KOGA_JOURNAL ; Safari Zone rest houses
	const BRUNO_JOURNAL ; Pokémon Trainer Fan Club
	const KAREN_JOURNAL ; Mt. Moon Pokémon Center
	const LANCE_JOURNAL ; Silver Cave Pokémon Center
	const RED_JOURNAL ; Cherrygrove Pokémon Center
	const GREEN_JOURNAL ; Pokémon Fan Club
	const PROF_OAK_JOURNAL ; Red's house, Blue's house
	const PROF_ELM_JOURNAL ; Kris's house, Lyra's house
	const PROF_IVY_JOURNAL ; Ivy's lab
	const PROF_WESTWOOD_JOURNAL ; Kurt's house
	const GIOVANNI_JOURNAL ; Indigo Plateau Pokémon Center
	const LORELEI_JOURNAL ; Shamouti Island Pokémon Center
	const AGATHA_JOURNAL ; Rock Tunnel Pokémon Center
	const BILL_JOURNAL ; Bill's house
	const KURT_JOURNAL ; Union Cave Pokémon Center
	const MR_FUJI_JOURNAL ; Lavender Town Pokémon Center
	const PROF_WILLOW_JOURNAL ; Snowtop Mountain Pokémon Center
	const STEVEN_JOURNAL ; Pewter Museum
	const CYNTHIA_JOURNAL ; Pewter Museum (TODO: move to Goldenrod Museum)
	const WALKER_JOURNAL ; Earl's Pokémon Academy
	const KIYO_JOURNAL ; Viridian schoolhouse
	const PALMER_JOURNAL ; Battle Tower
	const THORTON_JOURNAL ; Battle Factory
DEF NUM_POKEMON_JOURNALS EQU const_value

; wUnlockedUnowns ::
	const_def
	const UNLOCKED_UNOWNS_A_TO_J_F
	const UNLOCKED_UNOWNS_K_TO_Q_F
	const UNLOCKED_UNOWNS_R_TO_W_F
	const UNLOCKED_UNOWNS_X_TO_QUESTION_F
DEF NUM_UNLOCKED_UNOWN_SETS EQU const_value

; wLuckyNumberShowFlag::
DEF LUCKYNUMBERSHOW_GAME_OVER_F EQU 0

; wDailyFlags::
	const_def
	const DAILYFLAGS_KURT_MAKING_BALLS_F                     ; 0
	const DAILYFLAGS_DAILY_BUG_CONTEST_F                     ; 1
	const DAILYFLAGS_FISH_SWARM_F                            ; 2
	const DAILYFLAGS_VALERIE_MORNING_WALK_F                  ; 3
	const_skip ; unused
	const DAILYFLAGS_GOT_SHUCKIE_TODAY_F                     ; 5
	const DAILYFLAGS_GOLDENROD_UNDERGROUND_MERCHANT_CLOSED_F ; 6
	const DAILYFLAGS_FOUGHT_IN_TRAINER_HALL_TODAY_F          ; 7

; wDailyFlags2::
	const_def
	const DAILYFLAGS2_GYM_LEADER_REMATCH_1_F ; 0
	const DAILYFLAGS2_GYM_LEADER_REMATCH_2_F ; 1
	const DAILYFLAGS2_GYM_LEADER_REMATCH_3_F ; 2
	const DAILYFLAGS2_DAILY_PHOTOGRAPH_F     ; 3
	const DAILYFLAGS2_DAILY_SHRINE_VISIT_F   ; 4
	const DAILYFLAGS2_DAILY_MYSTERY_GIFT_F   ; 5
	const DAILYFLAGS2_RED_IN_MOUNT_SILVER_F  ; 6
	const DAILYFLAGS2_LEAF_IN_NAVEL_ROCK_F   ; 7

; wDailyFlags3::
	const_def
	const DAILYFLAGS3_BOUGHT_LEFTOVERS_F  ; 0
	const DAILYFLAGS3_TOOK_HYPER_TEST_F   ; 1
	const DAILYFLAGS3_CHERYL_DONE_TODAY_F ; 2
	const DAILYFLAGS3_RILEY_DONE_TODAY_F  ; 3
	const DAILYFLAGS3_BUCK_DONE_TODAY_F   ; 4
	const DAILYFLAGS3_MARLEY_DONE_TODAY_F ; 5
	const DAILYFLAGS3_MIRA_DONE_TODAY_F   ; 6
	const DAILYFLAGS3_ANABEL_DONE_TODAY_F ; 7

; wDailyFlags4::
	const_def
	const DAILYFLAGS4_SEASHORE_SHELL_BELL_F           ; 0
	const DAILYFLAGS4_SHAMOUTI_RESTAURANT_CHALLENGE_F ; 1
	const DAILYFLAGS4_FOUGHT_PSYCHIC_INVER_F          ; 2
	const DAILYFLAGS4_BOUGHT_MOOMOO_MILK_F            ; 3
	const DAILYFLAGS4_CHANGED_TRENDY_PHRASE_F         ; 4
	const DAILYFLAGS4_ALL_HIDDEN_GROTTOES_F           ; 5

; wWeeklyFlags::
	const_def
	const WEEKLYFLAGS_MT_MOON_SQUARE_CLEFAIRY_F           ; 0
	const WEEKLYFLAGS_UNION_CAVE_LAPRAS_F                 ; 1
	const WEEKLYFLAGS_GOLDENROD_UNDERGROUND_GOT_HAIRCUT_F ; 2
	const WEEKLYFLAGS_GOLDENROD_MALL_5F_HAPPINESS_EVENT_F ; 3
	const WEEKLYFLAGS_TEA_IN_BLUES_HOUSE_F                ; 4
	const WEEKLYFLAGS_INDIGO_PLATEAU_RIVAL_FIGHT_F        ; 5
	const WEEKLYFLAGS_INDIGO_PLATEAU_LYRA_FIGHT_F         ; 6
	const WEEKLYFLAGS_BUENAS_PASSWORD_F                   ; 7

; wSwarmFlags::
	const_def
	const SWARMFLAGS_BUENAS_PASSWORD_2_F         ; 0
	const SWARMFLAGS_GOLDENROD_DEPT_STORE_SALE_F ; 1
	const SWARMFLAGS_DUNSPARCE_SWARM_F           ; 2
	const SWARMFLAGS_YANMA_SWARM_F               ; 3

; wCelebiEvent::
DEF CELEBIEVENT_FOREST_IS_RESTLESS_F EQU 2

; wPlayerCaught::
	const_def
	const PLAYER_CAUGHT_HO_OH_F    ; 0
	const PLAYER_CAUGHT_LUGIA_F    ; 1
	const PLAYER_CAUGHT_RAIKOU_F   ; 2
	const PLAYER_CAUGHT_ENTEI_F    ; 3
	const PLAYER_CAUGHT_SUICUNE_F  ; 4
	const PLAYER_CAUGHT_ARTICUNO_F ; 5
	const PLAYER_CAUGHT_ZAPDOS_F   ; 6
	const PLAYER_CAUGHT_MOLTRES_F  ; 7

; wPlayerCaught2::
	const_def
	const PLAYER_CAUGHT_MEW_F                ; 0
	const PLAYER_CAUGHT_MEWTWO_F             ; 1
	const PLAYER_CAUGHT_CELEBI_F             ; 2
	const PLAYER_CAUGHT_SUDOWOODO_F          ; 3
	const PLAYER_CAUGHT_GALARIAN_ARTICUNO_F  ; 4
	const PLAYER_CAUGHT_GALARIAN_ZAPDOS_F    ; 5
	const PLAYER_CAUGHT_GALARIAN_MOLTRES_F   ; 6
	const PLAYER_CAUGHT_BLOODMOON_URSALUNA_F ; 7

DEF CAUGHT_DUO_MASK    EQU (1 << PLAYER_CAUGHT_HO_OH_F) | (1 << PLAYER_CAUGHT_LUGIA_F)
DEF CAUGHT_BEASTS_MASK EQU (1 << PLAYER_CAUGHT_RAIKOU_F) | (1 << PLAYER_CAUGHT_ENTEI_F) | (1 << PLAYER_CAUGHT_SUICUNE_F)
DEF CAUGHT_BIRDS_MASK  EQU (1 << PLAYER_CAUGHT_ARTICUNO_F) | (1 << PLAYER_CAUGHT_ZAPDOS_F) | (1 << PLAYER_CAUGHT_MOLTRES_F)

; wPalFlags
	const_def
	const NO_DYN_PAL_APPLY_ONCE_F        ; 0
	const SCAN_OBJECTS_FIRST_F           ; 1
	const USE_DAYTIME_PAL_F              ; 2
	const DISABLE_DYN_PAL_F              ; 3
	const NO_DYN_PAL_APPLY_UNTIL_RESET_F ; 4
	const MAP_CONNECTION_PAL_F           ; 5
DEF NO_DYN_PAL_APPLY EQU (1 << NO_DYN_PAL_APPLY_ONCE_F) | (1 << NO_DYN_PAL_APPLY_UNTIL_RESET_F)

; wMapSetupFlags
	const_def
	const MAPSETUP_CONNECTION_F ; 0
