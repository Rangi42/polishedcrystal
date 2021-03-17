; base data struct members (see data/pokemon/base_stats/*.asm)
rsreset
BASE_STATS       rb NUM_STATS
rsset BASE_STATS
BASE_HP          rb
BASE_ATK         rb
BASE_DEF         rb
BASE_SPD         rb
BASE_SAT         rb
BASE_SDF         rb
BASE_TYPES       rw
rsset BASE_TYPES
BASE_TYPE_1      rb
BASE_TYPE_2      rb
BASE_CATCH_RATE  rb
BASE_EXP         rb
BASE_ITEMS       rw
rsset BASE_ITEMS
BASE_ITEM_1      rb
BASE_ITEM_2      rb
BASE_GENDER      rb
BASE_EGG_STEPS EQU BASE_GENDER
BASE_PIC_SIZE    rb
BASE_ABILITIES   rb 3
rsset BASE_ABILITIES
BASE_ABILITY_1   rb
BASE_ABILITY_2   rb
BASE_ABILITY_3   rb
BASE_GROWTH_RATE rb
BASE_EGG_GROUPS  rb
BASE_EV_YIELDS   rw
rsset BASE_EV_YIELDS
BASE_EV_YIELD_1  rb
BASE_EV_YIELD_2  rb
BASE_TMHM        rb (NUM_TM_HM_TUTOR + 7) / 8
BASE_DATA_SIZE EQU _RS

; gender ratio constants
	const_def
	const GENDER_F0
	const GENDER_F12_5
	const GENDER_F25
	const GENDER_F37_5
	const GENDER_F50
	const GENDER_F62_5
	const GENDER_F75
	const GENDER_F87_5
	const GENDER_F100

GENDER_UNKNOWN EQU %1111

; wBaseGrowthRate values
; GrowthRates indexes (see data/growth_rates.asm)
	const_def
	const GROWTH_MEDIUM_FAST
	const GROWTH_MEDIUM_SLOW
	const GROWTH_FAST
	const GROWTH_SLOW

; wBaseEggGroups values
	const_def 1
	const EGG_MONSTER       ; 1
	const EGG_WATER_1       ; 2 (Amphibian)
	const EGG_BUG           ; 3
	const EGG_FLYING        ; 4
	const EGG_GROUND        ; 5 (Field)
	const EGG_FAIRY         ; 6
	const EGG_PLANT         ; 7 (Grass)
	const EGG_HUMANSHAPE    ; 8 (Human-Like)
	const EGG_WATER_3       ; 9 (Invertebrate)
	const EGG_MINERAL       ; a
	const EGG_INDETERMINATE ; b (Amorphous)
	const EGG_WATER_2       ; c (Fish)
	const EGG_DITTO         ; d
	const EGG_DRAGON        ; e
	const EGG_NONE          ; f (Undiscovered)

; party_struct members (see macros/wram.asm)
rsreset
MON_SPECIES            rb
MON_ITEM               rb
MON_MOVES              rb NUM_MOVES
MON_ID                 rw
MON_EXP                rb 3
MON_EVS                rb NUM_STATS
rsset MON_EVS
MON_HP_EV              rb
MON_ATK_EV             rb
MON_DEF_EV             rb
MON_SPD_EV             rb
MON_SAT_EV             rb
MON_SDF_EV             rb
MON_DVS                rb NUM_STATS / 2
rsset MON_DVS
MON_HP_ATK_DV          rb
MON_DEF_SPD_DV         rb
MON_SAT_SDF_DV         rb
MON_PERSONALITY        rw
MON_SHINY      EQU MON_PERSONALITY
MON_ABILITY    EQU MON_PERSONALITY
MON_NATURE     EQU MON_PERSONALITY
MON_GENDER     EQU MON_PERSONALITY + 1
MON_IS_EGG     EQU MON_PERSONALITY + 1
MON_EXTSPECIES EQU MON_PERSONALITY + 1
MON_FORM       EQU MON_PERSONALITY + 1
MON_PP                 rb NUM_MOVES
MON_HAPPINESS          rb
MON_PKRUS              rb
MON_CAUGHTDATA         rb 3
rsset MON_CAUGHTDATA
MON_CAUGHTGENDER       rb
MON_CAUGHTTIME EQU MON_CAUGHTGENDER
MON_CAUGHTBALL EQU MON_CAUGHTGENDER
MON_CAUGHTLEVEL        rb
MON_CAUGHTLOCATION     rb
MON_LEVEL              rb
BOXMON_STRUCT_LENGTH EQU _RS
MON_STATUS             rb
                       rb_skip
MON_HP                 rw
MON_MAXHP              rw
MON_STATS              rw NUM_BATTLE_STATS
rsset MON_STATS
MON_ATK                rw
MON_DEF                rw
MON_SPD                rw
MON_SAT                rw
MON_SDF                rw
PARTYMON_STRUCT_LENGTH EQU _RS
rsset BOXMON_STRUCT_LENGTH
MON_EXTRA              rb 3
MON_NICK               rb MON_NAME_LENGTH - 1
MON_OT                 rb PLAYER_NAME_LENGTH - 1
SAVEMON_STRUCT_LENGTH EQU _RS

; personality

SHINY_MASK       EQU %10000000
ABILITY_MASK     EQU %01100000
NATURE_MASK      EQU %00011111

MON_SHINY_F      EQU 7

GENDER_MASK      EQU %10000000
IS_EGG_MASK      EQU %01000000
EXTSPECIES_MASK  EQU %00100000
FORM_MASK        EQU %00011111

SPECIESFORM_MASK EQU EXTSPECIES_MASK | FORM_MASK

MON_GENDER_F     EQU 7
MON_IS_EGG_F     EQU 6
MON_EXTSPECIES_F EQU 5

; shiny probability values
SHINY_NUMERATOR         EQU 16 ; 16/65536 = 1/4096
CHARMED_SHINY_NUMERATOR EQU 48 ; 48/65536 = 3/4096

; ability values
ABILITY_1      EQU %00100000
ABILITY_2      EQU %01000000
HIDDEN_ABILITY EQU %01100000

; gender values
MALE   EQU %00000000
FEMALE EQU %10000000

; caught data
CAUGHT_GENDER_MASK EQU %10000000
CAUGHT_TIME_MASK   EQU %01100000
CAUGHT_BALL_MASK   EQU %00011111

; hyper training (stored at end of OT name)
HYPER_TRAINING_MASK EQU %11111100

; maximum number of party pokemon
PARTY_LENGTH EQU 6

; boxes
MONS_PER_BOX  EQU 20
NUM_BOXES     EQU 15
MONDB_ENTRIES EQU (20 * 15 + 14) / 2

; hall of fame
HOF_MON_LENGTH EQU 1 + 2 + 2 + 1 + (MON_NAME_LENGTH - 1) ; species, id, dvs, level, nick
HOF_LENGTH EQU 1 + HOF_MON_LENGTH * PARTY_LENGTH + 1 ; win count, party, terminator
NUM_HOF_TEAMS EQU 30

; evolution types (used in data/pokemon/evos_attacks.asm)
	const_def 1
	const EVOLVE_LEVEL
	const EVOLVE_ITEM
	const EVOLVE_HOLDING
	const EVOLVE_HAPPINESS
	const EVOLVE_STAT
	const EVOLVE_LOCATION
	const EVOLVE_MOVE
	const EVOLVE_EVS

; EVOLVE_HAPPINESS triggers
	const_def 1
	const TR_ANYTIME
	const TR_MORNDAY
	const TR_EVENITE

; EVOLVE_STAT triggers
	const_def 1
	const ATK_GT_DEF
	const ATK_LT_DEF
	const ATK_EQ_DEF

; EVOLVE_EVS trigger value
EVS_TO_EVOLVE EQU 50

; wild data

NUM_GRASSMON EQU 7 ; data/wild/*_grass.asm table size
NUM_WATERMON EQU 3 ; data/wild/*_water.asm table size

GRASS_WILDDATA_LENGTH EQU 2 + (1 + NUM_GRASSMON * 3) * 3
WATER_WILDDATA_LENGTH EQU 2 + (1 + NUM_WATERMON * 3) * 1
FISHGROUP_DATA_LENGTH EQU 1 + 2 * 3

NUM_ROAMMON_MAPS EQU 16 ; RoamMaps table size (see data/wild/roammon_maps.asm)

; treemon sets
; TreeMons indexes (see data/wild/treemons.asm)
	const_def
	const TREEMON_SET_CITY
	const TREEMON_SET_CANYON
	const TREEMON_SET_TOWN
	const TREEMON_SET_ROUTE
	const TREEMON_SET_KANTO
	const TREEMON_SET_LAKE
	const TREEMON_SET_FOREST
	const TREEMON_SET_ROCK
NUM_TREEMON_SETS EQU const_value

; treemon scores
	const_def
	const TREEMON_SCORE_BAD  ; 0
	const TREEMON_SCORE_GOOD ; 1
	const TREEMON_SCORE_RARE ; 2

; ChangeHappiness arguments (see data/events/happiness_changes.asm)
	const_def
	const HAPPINESS_GAINLEVEL         ; 00
	const HAPPINESS_USEDITEM          ; 01
	const HAPPINESS_USEDXITEM         ; 02
	const HAPPINESS_USEDEVBERRY       ; 03
	const HAPPINESS_GYMBATTLE         ; 04
	const HAPPINESS_LEARNMOVE         ; 05
	const HAPPINESS_FAINTED           ; 06
	const HAPPINESS_POISONFAINT       ; 07
	const HAPPINESS_BEATENBYSTRONGFOE ; 08
	const HAPPINESS_OLDERCUT1         ; 09
	const HAPPINESS_OLDERCUT2         ; 0a
	const HAPPINESS_OLDERCUT3         ; 0b
	const HAPPINESS_YOUNGCUT1         ; 0c
	const HAPPINESS_YOUNGCUT2         ; 0d
	const HAPPINESS_YOUNGCUT3         ; 0e
	const HAPPINESS_BITTERPOWDER      ; 0f
	const HAPPINESS_ENERGYROOT        ; 10
	const HAPPINESS_REVIVALHERB       ; 11
	const HAPPINESS_GROOMING          ; 12
	const HAPPINESS_GAINLEVELATHOME   ; 13
	const HAPPINESS_PHOTOGRAPH        ; 14
	const HAPPINESS_BLESSING          ; 15
NUM_HAPPINESS_CHANGES EQU const_value - 1

; significant happiness values
BASE_HAPPINESS        EQU 70
FRIEND_BALL_HAPPINESS EQU 200
HAPPINESS_TO_EVOLVE   EQU 220
HAPPINESS_THRESHOLD_1 EQU 100
HAPPINESS_THRESHOLD_2 EQU 200

; PP
PP_UP_MASK EQU %11000000
PP_UP_ONE  EQU %01000000
PP_MASK    EQU %00111111
