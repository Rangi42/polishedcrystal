; wMonType:
	const_def
	const PARTYMON   ; 0
	const OTPARTYMON ; 1
	const BOXMON     ; 2
	const TEMPMON    ; 3
	const WILDMON    ; 4

; Text box flags
; TODO: add the other bits used
NO_LINE_SPACING EQU 2

; wOptions1: text speed
	const_def
	const INST_TEXT ; 0
	const FAST_TEXT ; 1
	const MED_TEXT  ; 2
	const SLOW_TEXT ; 3

; wOptions1: text autoscroll.
; CheckAutoscroll relies on exact bit usage and order
AUTOSCROLL_MASK  EQU %1100
AUTOSCROLL_NONE  EQU %0000
AUTOSCROLL_START EQU %0100
AUTOSCROLL_AANDB EQU %1000
AUTOSCROLL_AORB  EQU %1100

TURNING_SPEED_MASK EQU %10000

; bits
AUTOSCROLL_ABF EQU 3
TURNING_SPEED  EQU 4
NO_TEXT_SCROLL EQU 5
STEREO         EQU 6
BATTLE_EFFECTS EQU 7

; wOptions2:
FONT_MASK      EQU %00000111
NORMAL_FONT    EQU %000
NARROW_FONT    EQU %001
BOLD_FONT      EQU %010
ITALIC_FONT    EQU %011
SERIF_FONT     EQU %100
CHICAGO_FONT   EQU %101
MICR_FONT      EQU %110
UNOWN_FONT     EQU %111
; bits
RUNNING_SHOES  EQU 3
CLOCK_FORMAT   EQU 4
POKEDEX_UNITS  EQU 5
BATTLE_SWITCH  EQU 6
BATTLE_PREDICT EQU 7

; wInitialOptions:
NATURES_OPT      EQU 0
ABILITIES_OPT    EQU 1
COLOR_VARY_OPT   EQU 2
PERFECT_IVS_OPT  EQU 3
TRADED_AS_OT_OPT EQU 4
NUZLOCKE_MODE    EQU 5
SCALED_EXP       EQU 6
PSS_OPT          EQU 7

ABILITIES_OPTMASK EQU 1 << ABILITIES_OPT

; wInitialOptions2:
RESET_INIT_OPTS  EQU 7

; wForgettingMove
FORGETTING_MOVE_F EQU 7
LEARNING_TM_F     EQU 6
FORGETTING_MOVE   EQU 1 << FORGETTING_MOVE_F
LEARNING_TM       EQU 1 << LEARNING_TM_F

; wWalkingDirection:
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

; wFacingDirection:
FACE_CURRENT EQU 0
FACE_DOWN  EQU 8
FACE_UP    EQU 4
FACE_LEFT  EQU 2
FACE_RIGHT EQU 1

; wTimeOfDay:
MORN EQU 0
DAY  EQU 1
NITE EQU 2
EVE  EQU 3

; wPlayerSpriteSetupFlags::
PLAYERSPRITESETUP_FACING_MASK       EQU %11
PLAYERSPRITESETUP_FEMALE_TO_MALE_F  EQU 2
PLAYERSPRITESETUP_CUSTOM_FACING_F   EQU 5
PLAYERSPRITESETUP_SKIP_RELOAD_GFX_F EQU 6
PLAYERSPRITESETUP_RESET_ACTION_F    EQU 7

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

; wScriptFlags:
SCRIPT_RUNNING EQU 2

; wScriptMode:
SCRIPT_OFF EQU 0
SCRIPT_READ EQU 1
SCRIPT_WAIT_MOVEMENT EQU 2
SCRIPT_WAIT EQU 3

; wCurDay:
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
	const STATUSFLAGS_BUG_CONTEST_ON_F           ; 7 (unused?)

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

; wMapObjects:
PLAYER_OBJECT EQU 0
NUM_OBJECTS EQU $15

; wInputType:
AUTO_INPUT EQU $ff

; wOWState
OWSTATE_STRENGTH        EQU 0
OWSTATE_BIKING_FORCED   EQU 1
OWSTATE_BIKING_DOWNHILL EQU 2
OWSTATE_SURF            EQU 3
OWSTATE_ROCK_SMASH      EQU 4
OWSTATE_HEADBUTT        EQU 5
OWSTATE_WHIRLPOOL       EQU 6
OWSTATE_WATERFALL       EQU 7
OWSTATE_CUT             EQU 8

; wPlayerState:
PLAYER_NORMAL    EQU 0
PLAYER_BIKE      EQU 1
PLAYER_SKATE      EQU 2
PLAYER_SURF      EQU 4
PLAYER_SURF_PIKA EQU 8

FIRST_VRAM1_OBJECT_STRUCT EQU 8

; After-Champion Spawn
SPAWN_LANCE EQU 1
SPAWN_LEAF EQU 2

; wPokemonWithdrawDepositParameter
PC_WITHDRAW EQU 0
PC_DEPOSIT EQU 1
DAYCARE_WITHDRAW EQU 2
DAYCARE_DEPOSIT EQU 3

; wPlayerStepFlags::
	const_def 4
	const PLAYERSTEP_MIDAIR_F   ; 4
	const PLAYERSTEP_CONTINUE_F ; 5
	const PLAYERSTEP_STOP_F     ; 6
	const PLAYERSTEP_START_F    ; 7

; wPalFadeMode
PALFADE_WHICH        EQU %11
PALFADE_FLASH_F      EQU 2
PALFADE_PARTIAL_F    EQU 3
PALFADE_SKIP_FIRST_F EQU 4

PALFADE_BOTH       EQU %00
PALFADE_BG         EQU %01
PALFADE_OBJ        EQU %10
PALFADE_FLASH      EQU 1 << PALFADE_FLASH_F
PALFADE_PARTIAL    EQU 1 << PALFADE_PARTIAL_F
PALFADE_SKIP_FIRST EQU 1 << PALFADE_SKIP_FIRST_F

; wCurDexMode
	const_def
	const DEXMODE_NEW
	const DEXMODE_OLD
	const DEXMODE_ABC
	const DEXMODE_UNOWN

; wHiddenGrottoContents
	const_def
	const GROTTO_UNDEFINED
	const GROTTO_POKEMON
	const GROTTO_ITEM
	const GROTTO_HIDDEN_ITEM
	const GROTTO_EMPTY

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
