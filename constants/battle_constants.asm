MAX_LEVEL EQU 100
MIN_LEVEL EQU 2
EGG_LEVEL EQU 1
NUM_MOVES EQU 4

REST_TURNS EQU 2
MAX_STAT_LEVEL EQU 13
BASE_STAT_LEVEL EQU 7

; matchups, baseline is $10 for better doubling/halving
SUPER_EFFECTIVE    EQU $20
NOT_VERY_EFFECTIVE EQU $08
NO_EFFECT          EQU $00

	const_def
	const ATTACK
	const DEFENSE
	const SPEED
	const SP_ATTACK
	const SP_DEFENSE
	const ACCURACY
	const EVASION
	const MULTIPLE_STATS ; used by Curse
NUM_LEVEL_STATS EQU const_value

	const_def
	const STAT_TARGET_F
	const STAT_LOWER_F
	const STAT_MISS_F
	const STAT_SECONDARY_F
	const STAT_SILENT_F
	const STAT_SKIPTEXT_F

STAT_TARGET    EQU 1 << STAT_TARGET_F
STAT_LOWER     EQU 1 << STAT_LOWER_F
STAT_MISS      EQU 1 << STAT_MISS_F
STAT_SECONDARY EQU 1 << STAT_SECONDARY_F
STAT_SILENT    EQU 1 << STAT_SILENT_F
STAT_SKIPTEXT  EQU 1 << STAT_SKIPTEXT_F

; move struct
	const_def
	const MOVE_ANIM
	const MOVE_EFFECT
	const MOVE_POWER
	const MOVE_TYPE
	const MOVE_ACC
	const MOVE_PP
	const MOVE_CHANCE
	const MOVE_CATEGORY
	const MOVE_LENGTH

; stat constants
	const_def 1
	const STAT_HP
	const STAT_ATK
	const STAT_DEF
	const STAT_SPD
	const STAT_SATK
	const STAT_SDEF
NUM_STATS EQU const_value

	const_def
	const QUICK_B_F
	const QUICK_START_F
	const QUICK_SELECT_F
	const QUICK_PACK_F

QUICK_B      EQU 1 << QUICK_B_F
QUICK_START  EQU 1 << QUICK_START_F
QUICK_SELECT EQU 1 << QUICK_SELECT_F
QUICK_PACK   EQU 1 << QUICK_PACK_F

STAT_MIN_NORMAL EQU 5
STAT_MIN_HP EQU 10

; $00 is used instead of $ff for DVs because $ff is the end-of-trainer marker
; ReadTrainerParty converts $00 to $ff when reading DVs
; DV order: HP atk def spe sat sdf

PERFECT_DVS      EQUS "$ff, $ff, $ff"
FAKE_PERFECT_DVS EQUS "$00, $00, $00"
DVS_TRICK_ROOM   EQUS "$00, $f0, $00"
BTDVS_TRICK_ROOM EQUS "$ff, $f0, $ff"

; Hidden Power DVs ($00 is converted to $ff in regular trainer sets)
; Chosen for stat importance: Speed > * > Atk
if DEF(FAITHFUL)
DVS_HP_FIGHTING EQUS "$00, $ee, $ee"
DVS_HP_FLYING   EQUS "$ee, $ef, $ee"
DVS_HP_POISON   EQUS "$00, $ef, $ee"
DVS_HP_GROUND   EQUS "$00, $00, $ee"
DVS_HP_ROCK     EQUS "$00, $ee, $fe"
DVS_HP_BUG      EQUS "$fe, $ef, $fe"
DVS_HP_GHOST    EQUS "$fe, $00, $fe"
DVS_HP_STEEL    EQUS "$00, $00, $fe"
DVS_HP_FIRE     EQUS "$fe, $fe, $ef"
DVS_HP_WATER    EQUS "$fe, $ef, $ef"
DVS_HP_GRASS    EQUS "$fe, $00, $ef"
DVS_HP_ELECTRIC EQUS "$00, $00, $ef"
DVS_HP_PSYCHIC  EQUS "$fe, $fe, $00"
DVS_HP_ICE      EQUS "$fe, $ef, $00"
DVS_HP_DRAGON   EQUS "$fe, $00, $00"
DVS_HP_DARK     EQUS "$00, $00, $00"
else
DVS_HP_FIGHTING EQUS "$00, $ee, $ee"
DVS_HP_FLYING   EQUS "$00, $fe, $ee"
DVS_HP_POISON   EQUS "$00, $ef, $ee"
DVS_HP_GROUND   EQUS "$00, $00, $ee"
DVS_HP_ROCK     EQUS "$00, $ee, $fe"
DVS_HP_BUG      EQUS "$00, $fe, $fe"
DVS_HP_GHOST    EQUS "$00, $ef, $fe"
DVS_HP_STEEL    EQUS "$00, $00, $fe"
DVS_HP_FIRE     EQUS "$00, $ee, $ef"
DVS_HP_WATER    EQUS "$00, $fe, $ef"
DVS_HP_GRASS    EQUS "$00, $ef, $ef"
DVS_HP_ELECTRIC EQUS "$00, $00, $ef"
DVS_HP_PSYCHIC  EQUS "$00, $ee, $00"
DVS_HP_ICE      EQUS "$00, $fe, $00"
DVS_HP_DRAGON   EQUS "$00, $ef, $00"
DVS_HP_DARK     EQUS "$fe, $00, $00"
endc

; battle tower hidden power dvs ($ff instead of $00)
if DEF(FAITHFUL)
BTDVS_HP_FIGHTING EQUS "$ff, $ee, $ee"
BTDVS_HP_FLYING   EQUS "$ee, $ef, $ee"
BTDVS_HP_POISON   EQUS "$ff, $ef, $ee"
BTDVS_HP_GROUND   EQUS "$ff, $ff, $ee"
BTDVS_HP_ROCK     EQUS "$ff, $ee, $fe"
BTDVS_HP_BUG      EQUS "$fe, $ef, $fe"
BTDVS_HP_GHOST    EQUS "$fe, $ff, $fe"
BTDVS_HP_STEEL    EQUS "$ff, $ff, $fe"
BTDVS_HP_FIRE     EQUS "$fe, $fe, $ef"
BTDVS_HP_WATER    EQUS "$fe, $ef, $ef"
BTDVS_HP_GRASS    EQUS "$fe, $ff, $ef"
BTDVS_HP_ELECTRIC EQUS "$ff, $ff, $ef"
BTDVS_HP_PSYCHIC  EQUS "$fe, $fe, $ff"
BTDVS_HP_ICE      EQUS "$fe, $ef, $ff"
BTDVS_HP_DRAGON   EQUS "$fe, $ff, $ff"
BTDVS_HP_DARK     EQUS "$ff, $ff, $ff"
else
BTDVS_HP_FIGHTING EQUS "$ff, $ee, $ee"
BTDVS_HP_FLYING   EQUS "$ff, $fe, $ee"
BTDVS_HP_POISON   EQUS "$ff, $ef, $ee"
BTDVS_HP_GROUND   EQUS "$ff, $ff, $ee"
BTDVS_HP_ROCK     EQUS "$ff, $ee, $fe"
BTDVS_HP_BUG      EQUS "$ff, $fe, $fe"
BTDVS_HP_GHOST    EQUS "$ff, $ef, $fe"
BTDVS_HP_STEEL    EQUS "$ff, $ff, $fe"
BTDVS_HP_FIRE     EQUS "$ff, $ee, $ef"
BTDVS_HP_WATER    EQUS "$ff, $fe, $ef"
BTDVS_HP_GRASS    EQUS "$ff, $ef, $ef"
BTDVS_HP_ELECTRIC EQUS "$ff, $ff, $ef"
BTDVS_HP_PSYCHIC  EQUS "$ff, $ee, $ff"
BTDVS_HP_ICE      EQUS "$ff, $fe, $ff"
BTDVS_HP_DRAGON   EQUS "$ff, $ef, $ff"
BTDVS_HP_DARK     EQUS "$fe, $ff, $ff"
endc

; battle classes
	const_def 1
	const WILD_BATTLE
	const TRAINER_BATTLE

; battle types
	const_def
	const BATTLETYPE_NORMAL
	const BATTLETYPE_CANLOSE
	const BATTLETYPE_TUTORIAL
	const BATTLETYPE_FISH
	const BATTLETYPE_TREE
	const BATTLETYPE_ROAMING
	const BATTLETYPE_CONTEST
	const BATTLETYPE_SAFARI
	const BATTLETYPE_GHOST
	const BATTLETYPE_GROTTO
	const BATTLETYPE_INVERSE
	const BATTLETYPE_TRAP
	const BATTLETYPE_FORCEITEM
	const BATTLETYPE_RED_GYARADOS
	const BATTLETYPE_LEGENDARY

; attack failure modes, higher gives priority
	const_def 1
	const ATKFAIL_MISSED  ; "<USER>'s attack missed!"
	const ATKFAIL_PROTECT ; "<TARGET> is protecting itself!"
	const ATKFAIL_ABILITY ; ability immunity, might have side effects
	const ATKFAIL_GENERIC ; "But it failed!"
	const ATKFAIL_IMMUNE  ; "It doesn't affect <TARGET>!"
	const ATKFAIL_ACCMISS ; missed from accuracy
	const ATKFAIL_CUSTOM  ; custom message

; deferred switch types (bitflags)
	const_def
	const SWITCH_DEFERRED
	const SWITCH_EXPLICIT
	const SWITCH_TARGET
	const SWITCH_FORCED
	const SWITCH_PURSUIT
	const SWITCH_ITEM
	const SWITCH_OPPITEM
	const SWITCH_BATON_PASS

; battle variables
	const_def
	const BATTLE_VARS_SUBSTATUS1
	const BATTLE_VARS_SUBSTATUS2
	const BATTLE_VARS_SUBSTATUS3
	const BATTLE_VARS_SUBSTATUS4
	const BATTLE_VARS_SUBSTATUS1_OPP
	const BATTLE_VARS_SUBSTATUS2_OPP
	const BATTLE_VARS_SUBSTATUS3_OPP
	const BATTLE_VARS_SUBSTATUS4_OPP
	const BATTLE_VARS_ABILITY
	const BATTLE_VARS_ABILITY_OPP
	const BATTLE_VARS_STATUS
	const BATTLE_VARS_STATUS_OPP
	const BATTLE_VARS_MOVE_ANIM
	const BATTLE_VARS_MOVE_EFFECT
	const BATTLE_VARS_MOVE_POWER
	const BATTLE_VARS_MOVE_ACCURACY
	const BATTLE_VARS_MOVE_TYPE
	const BATTLE_VARS_MOVE_CATEGORY
	const BATTLE_VARS_MOVE
	const BATTLE_VARS_MOVE_OPP
	const BATTLE_VARS_LAST_COUNTER_MOVE
	const BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	const BATTLE_VARS_LAST_MOVE
	const BATTLE_VARS_LAST_MOVE_OPP

; status
SLP EQU %111 ; max 7 turns
	const_def 3
	const PSN ; 3
	const BRN ; 4
	const FRZ ; 5
	const PAR ; 6
	const TOX ; 7

ALL_STATUS EQU (1 << PSN) | (1 << BRN) | (1 << FRZ) | (1 << PAR) | (1 << TOX) | SLP

; substatus
	enum_start 7, -1
	enum SUBSTATUS_IN_LOVE
	enum SUBSTATUS_FLASH_FIRE
	enum SUBSTATUS_ENDURE
	enum SUBSTATUS_PERISH
	enum SUBSTATUS_IDENTIFIED
	enum SUBSTATUS_PROTECT
	enum SUBSTATUS_CURSE
	enum SUBSTATUS_UNBURDEN

	enum_start 7, -1
	enum SUBSTATUS_CANT_RUN
	enum SUBSTATUS_DESTINY_BOND
	enum SUBSTATUS_LOCK_ON
	enum SUBSTATUS_TRANSFORMED
	enum SUBSTATUS_IN_ABILITY
	enum SUBSTATUS_FAINTED
	enum SUBSTATUS_MINIMIZED

	enum_start 7, -1
	enum SUBSTATUS_CONFUSED
	enum SUBSTATUS_FLYING
	enum SUBSTATUS_UNDERGROUND
	enum SUBSTATUS_CHARGED
	enum SUBSTATUS_RECHARGE
	enum SUBSTATUS_IN_LOOP
	enum SUBSTATUS_RAMPAGE
	enum SUBSTATUS_ROLLOUT

	enum_start 7, -1
	enum SUBSTATUS_LEECH_SEED
	enum SUBSTATUS_RAGE
	enum SUBSTATUS_FLINCHED
	enum SUBSTATUS_SUBSTITUTE
	enum SUBSTATUS_ROOST
	enum SUBSTATUS_FOCUS_ENERGY
	enum SUBSTATUS_4_1 ; unused
	enum SUBSTATUS_CURLED ; formerly in its own substatus

; environmental, things that stack are bitmasks
SCREENS_REFLECT      EQU %00001111
SCREENS_LIGHT_SCREEN EQU %11110000

GUARD_SAFEGUARD EQU %00001111
GUARD_MIST      EQU %11110000

HAZARDS_SPIKES       EQU %00110000
HAZARDS_TOXIC_SPIKES EQU %11000000

; weather
	const_def
	const WEATHER_NONE
	const WEATHER_RAIN
	const WEATHER_SUN
	const WEATHER_SANDSTORM
	const WEATHER_HAIL

; Battle vars used in home/battle.asm
	const_def
	const PLAYER_SUBSTATUS_1
	const ENEMY_SUBSTATUS_1
	const PLAYER_SUBSTATUS_2
	const ENEMY_SUBSTATUS_2
	const PLAYER_SUBSTATUS_3
	const ENEMY_SUBSTATUS_3
	const PLAYER_SUBSTATUS_4
	const ENEMY_SUBSTATUS_4
	const PLAYER_ABILITY
	const ENEMY_ABILITY
	const PLAYER_STATUS
	const ENEMY_STATUS
	const PLAYER_MOVE_ANIMATION
	const ENEMY_MOVE_ANIMATION
	const PLAYER_MOVE_EFFECT
	const ENEMY_MOVE_EFFECT
	const PLAYER_MOVE_POWER
	const ENEMY_MOVE_POWER
	const PLAYER_MOVE_ACCURACY
	const ENEMY_MOVE_ACCURACY
	const PLAYER_MOVE_TYPE
	const ENEMY_MOVE_TYPE
	const PLAYER_MOVE_CATEGORY
	const ENEMY_MOVE_CATEGORY
	const PLAYER_CUR_MOVE
	const ENEMY_CUR_MOVE
	const PLAYER_COUNTER_MOVE
	const ENEMY_COUNTER_MOVE
	const PLAYER_LAST_MOVE
	const ENEMY_LAST_MOVE

; wBattleAction
	const_def
	const BATTLEACTION_MOVE1
	const BATTLEACTION_MOVE2
	const BATTLEACTION_MOVE3
	const BATTLEACTION_MOVE4
	const BATTLEACTION_SWITCH1
	const BATTLEACTION_SWITCH2
	const BATTLEACTION_SWITCH3
	const BATTLEACTION_SWITCH4
	const BATTLEACTION_SWITCH5
	const BATTLEACTION_SWITCH6
	const BATTLEACTION_A
	const BATTLEACTION_B
	const BATTLEACTION_C
	const BATTLEACTION_STRUGGLE
	const BATTLEACTION_FORFEIT

	const_def
	const WIN
	const LOSE
	const DRAW
