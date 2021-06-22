; wInputType::
AUTO_INPUT EQU $ff

; wCurDexMode::
	const_def
	const DEXMODE_NEW
	const DEXMODE_OLD
	const DEXMODE_ABC
	const DEXMODE_UNOWN

; wMonType::
	const_def
	const PARTYMON   ; 0
	const OTPARTYMON ; 1
	const BOXMON     ; 2
	const TEMPMON    ; 3
	const WILDMON    ; 4

; wGameTimerPaused::
GAME_TIMER_PAUSED_F EQU 0

; wJoypadDisable::
JOYPAD_DISABLE_MON_FAINT_F    EQU 6
JOYPAD_DISABLE_SGB_TRANSFER_F EQU 7

; wOptions3::
QWERTY_KEYBOARD_F EQU 0

; wOptions1::
	const_def 3
	const AUTOSCROLL_ABF ; 3
	const TURNING_SPEED  ; 4
	const NO_TEXT_SCROLL ; 5
	const STEREO         ; 6
	const BATTLE_EFFECTS ; 7
TEXT_DELAY_MASK    EQU %00011
; CheckAutoscroll relies on exact bit usage and order
AUTOSCROLL_MASK    EQU %01100
AUTOSCROLL_NONE    EQU %00000
AUTOSCROLL_START   EQU %00100
AUTOSCROLL_AANDB   EQU %01000
AUTOSCROLL_AORB    EQU %01100
TURNING_SPEED_MASK EQU %10000

	const_def
	const INST_TEXT ; %00
	const FAST_TEXT ; %01
	const MED_TEXT  ; %10
	const SLOW_TEXT ; %11

; wTextboxFrame::
	const_def
	const FRAME_1 ; 0
	const FRAME_2 ; 1
	const FRAME_3 ; 2
	const FRAME_4 ; 3
	const FRAME_5 ; 4
	const FRAME_6 ; 5
	const FRAME_7 ; 6
	const FRAME_8 ; 7
	const FRAME_9 ; 8
NUM_FRAMES EQU const_value

; wTextboxFlags::
	const_def
	const FAST_TEXT_DELAY_F ; 0
	const NO_TEXT_DELAY_F   ; 1
	const NO_LINE_SPACING_F ; 2

; wOptions2::
	const_def 3
	const RUNNING_SHOES  ; 3
	const CLOCK_FORMAT   ; 4
	const POKEDEX_UNITS  ; 5
	const BATTLE_SWITCH  ; 6
	const BATTLE_PREDICT ; 7
FONT_MASK EQU %00000111

	const_def
	const NORMAL_FONT  ; %000
	const NARROW_FONT  ; %001
	const BOLD_FONT    ; %010
	const ITALIC_FONT  ; %011
	const SERIF_FONT   ; %100
	const CHICAGO_FONT ; %101
	const MICR_FONT    ; %110
	const UNOWN_FONT   ; %111

; wInitialOptions::
	const_def
	const NATURES_OPT      ; 0
	const ABILITIES_OPT    ; 1
	const COLOR_VARY_OPT   ; 2
	const PERFECT_IVS_OPT  ; 3
	const TRADED_AS_OT_OPT ; 4
	const NUZLOCKE_MODE    ; 5
	const SCALED_EXP       ; 6
	const PSS_OPT          ; 7

ABILITIES_OPTMASK EQU 1 << ABILITIES_OPT

; wInitialOptions2::
RESET_INIT_OPTS EQU 7

; wForgettingMove::
	const_def 6
	const LEARNING_TM_F     ; 6
	const FORGETTING_MOVE_F ; 7

LEARNING_TM       EQU 1 << LEARNING_TM_F
FORGETTING_MOVE   EQU 1 << FORGETTING_MOVE_F

; wWalkingDirection::
	const_def -1
	const STANDING ; -1
	const DOWN     ; 0
	const UP       ; 1
	const LEFT     ; 2
	const RIGHT    ; 3
NUM_DIRECTIONS EQU const_value

DOWN_MASK  EQU 1 << DOWN
UP_MASK    EQU 1 << UP
LEFT_MASK  EQU 1 << LEFT
RIGHT_MASK EQU 1 << RIGHT

; wFacingDirection::
FACE_CURRENT EQU 0
FACE_DOWN  EQU 8
FACE_UP    EQU 4
FACE_LEFT  EQU 2
FACE_RIGHT EQU 1

; wPokemonWithdrawDepositParameter::
PC_WITHDRAW       EQU 0
PC_DEPOSIT        EQU 1
REMOVE_PARTY      EQU 0
REMOVE_BOX        EQU 1
DAY_CARE_WITHDRAW EQU 2
DAY_CARE_DEPOSIT  EQU 3

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
NUM_DAYTIMES EQU const_value

; wBattleAnimFlags::
	const_def
	const BATTLEANIM_STOP_F          ; 0
	const BATTLEANIM_IN_SUBROUTINE_F ; 1
	const BATTLEANIM_IN_LOOP_F       ; 2
	const BATTLEANIM_KEEPSPRITES_F   ; 3

; wPlayerSpriteSetupFlags::
PLAYERSPRITESETUP_FACING_MASK       EQU %11
PLAYERSPRITESETUP_FEMALE_TO_MALE_F  EQU 2
PLAYERSPRITESETUP_CUSTOM_FACING_F   EQU 5
PLAYERSPRITESETUP_SKIP_RELOAD_GFX_F EQU 6
PLAYERSPRITESETUP_RESET_ACTION_F    EQU 7

; wPlayerGender::
PLAYERGENDER_FEMALE_F EQU 0

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
SCRIPT_RUNNING EQU 2

; wScriptMode::
	const_def
	const SCRIPT_OFF
	const SCRIPT_READ
	const SCRIPT_WAIT_MOVEMENT
	const SCRIPT_WAIT

; wSpawnAfterChampion::
SPAWN_LANCE EQU 1
SPAWN_LEAF  EQU 2

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

; wMomSavingMoney::
MOM_SAVING_SOME_MONEY_F EQU 0
MOM_SAVING_HALF_MONEY_F EQU 1
MOM_SAVING_ALL_MONEY_F  EQU 2
MOM_ACTIVE_F            EQU 7

MOM_SAVING_MONEY_MASK EQU (1 << MOM_SAVING_SOME_MONEY_F) | (1 << MOM_SAVING_HALF_MONEY_F) | (1 << MOM_SAVING_ALL_MONEY_F)

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
NUM_JOHTO_BADGES EQU const_value

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
NUM_KANTO_BADGES EQU const_value
NUM_BADGES EQU NUM_JOHTO_BADGES + NUM_KANTO_BADGES

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
PLAYER_NORMAL    EQU 0
PLAYER_BIKE      EQU 1
PLAYER_SKATE     EQU 2
PLAYER_SURF      EQU 4
PLAYER_SURF_PIKA EQU 8

; wPalFadeMode::
PALFADE_WHICH        EQU %11
PALFADE_FLASH_F      EQU 2
PALFADE_PARTIAL_F    EQU 3
PALFADE_SKIP_FIRST_F EQU 4

; hBattlePalFadeMode::
PALFADE_BOTH       EQU %00
PALFADE_BG         EQU %01
PALFADE_OBJ        EQU %10
PALFADE_FLASH      EQU 1 << PALFADE_FLASH_F
PALFADE_PARTIAL    EQU 1 << PALFADE_PARTIAL_F
PALFADE_SKIP_FIRST EQU 1 << PALFADE_SKIP_FIRST_F

; wDayCareMan::
DAYCAREMAN_HAS_MON_F         EQU 0
DAYCAREMAN_MONS_COMPATIBLE_F EQU 5
DAYCAREMAN_HAS_EGG_F         EQU 6
DAYCAREMAN_ACTIVE_F          EQU 7

; wDayCareLady::
DAYCARELADY_HAS_MON_F        EQU 0
DAYCARELADY_ACTIVE_F         EQU 7

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
	const WILL_JOURNAL ; Earl's Pokémon Academy
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
NUM_POKEMON_JOURNALS EQU const_value
