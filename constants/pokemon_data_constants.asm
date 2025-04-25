; base data struct members (see data/pokemon/base_stats/*.asm)
rsreset
DEF BASE_STATS       rb NUM_STATS
rsset BASE_STATS
DEF BASE_HP          rb
DEF BASE_ATK         rb
DEF BASE_DEF         rb
DEF BASE_SPE         rb
DEF BASE_SAT         rb
DEF BASE_SDF         rb
DEF BASE_TYPES       rw
rsset BASE_TYPES
DEF BASE_TYPE_1      rb
DEF BASE_TYPE_2      rb
DEF BASE_CATCH_RATE  rb
DEF BASE_EXP         rb
DEF BASE_ITEMS       rw
rsset BASE_ITEMS
DEF BASE_ITEM_1      rb
DEF BASE_ITEM_2      rb
DEF BASE_GENDER      rb
DEF BASE_EGG_STEPS EQU BASE_GENDER
DEF BASE_ABILITIES   rb 3
rsset BASE_ABILITIES
DEF BASE_ABILITY_1   rb
DEF BASE_ABILITY_2   rb
DEF BASE_ABILITY_3   rb
DEF BASE_GROWTH_RATE rb
DEF BASE_EGG_GROUPS  rb
DEF BASE_EV_YIELDS   rw
rsset BASE_EV_YIELDS
DEF BASE_EV_YIELD_1  rb
DEF BASE_EV_YIELD_2  rb
DEF BASE_TMHM        rb (NUM_TM_HM_TUTOR + 7) / 8
DEF BASE_DATA_SIZE EQU _RS

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

DEF GENDER_UNKNOWN EQU %1111

; "step cycles to hatch" constants
	const_def
	const HATCH_FASTEST
	const HATCH_FASTER
	const HATCH_FAST
	const HATCH_MEDIUM_FAST
	const HATCH_MEDIUM_SLOW
	const HATCH_SLOW
	const HATCH_SLOWER
	const HATCH_SLOWEST
DEF NUM_HATCH_RATES EQU const_value

DEF HATCH_UNKNOWN EQU %1111

; wBaseGrowthRate values
; GrowthRates indexes (see data/growth_rates.asm)
	const_def
	const GROWTH_MEDIUM_FAST
	const GROWTH_MEDIUM_SLOW
	const GROWTH_FAST
	const GROWTH_SLOW
DEF NUM_GROWTH_RATES EQU const_value

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
DEF NUM_EGG_GROUPS EQU const_value - 1

; body data struct members (see data/pokemon/body_data.asm)
rsreset
DEF BODY_HEIGHT rb
DEF BODY_WEIGHT rw
DEF BODY_COLOR  rb
DEF BODY_SHAPE EQU BODY_COLOR
DEF BODY_DATA_SIZE EQU _RS

; shapes (see data/pokemon/body_data.asm)
	const_def
	const SHAPE_HEAD         ; 0
	const SHAPE_SERPENTINE   ; 1
	const SHAPE_FINS         ; 2
	const SHAPE_HEAD_ARMS    ; 3
	const SHAPE_HEAD_BASE    ; 4
	const SHAPE_BIPEDAL_TAIL ; 5
	const SHAPE_HEAD_LEGS    ; 6
	const SHAPE_QUADRUPED    ; 7
	const SHAPE_WINGS        ; 8
	const SHAPE_TENTACLES    ; 9
	const SHAPE_MULTIBODY    ; a
	const SHAPE_BIPEDAL      ; b
	const SHAPE_MULTIWINGS   ; c
	const SHAPE_INSECTOID    ; d
assert const_value <= $10
DEF NUM_SHAPES EQU const_value

; body colors (see data/pokemon/body_data.asm)
	const_def
	const BODY_COLOR_RED    ; 0
	const BODY_COLOR_BLUE   ; 1
	const BODY_COLOR_YELLOW ; 2
	const BODY_COLOR_GREEN  ; 3
	const BODY_COLOR_BLACK  ; 4
	const BODY_COLOR_BROWN  ; 5
	const BODY_COLOR_PURPLE ; 6
	const BODY_COLOR_GRAY   ; 7
	const BODY_COLOR_WHITE  ; 8
	const BODY_COLOR_PINK   ; 9
assert const_value <= $10
DEF NUM_BODY_COLORS EQU const_value

; breed_struct and party_struct members (see macros/ram.asm)
rsreset
DEF MON_SPECIES            rb
DEF MON_ITEM               rb
DEF MON_MOVES              rb NUM_MOVES
DEF MON_ID                 rw
DEF MON_EXP                rb 3
DEF MON_EVS                rb NUM_STATS
rsset MON_EVS
DEF MON_HP_EV              rb
DEF MON_ATK_EV             rb
DEF MON_DEF_EV             rb
DEF MON_SPE_EV             rb
DEF MON_SAT_EV             rb
DEF MON_SDF_EV             rb
DEF MON_DVS                rb NUM_STATS / 2
rsset MON_DVS
DEF MON_HP_ATK_DV          rb
DEF MON_DEF_SPE_DV         rb
DEF MON_SAT_SDF_DV         rb
DEF MON_PERSONALITY        rw
DEF MON_SHINY      EQU MON_PERSONALITY
DEF MON_ABILITY    EQU MON_PERSONALITY
DEF MON_NATURE     EQU MON_PERSONALITY
DEF MON_GENDER     EQU MON_PERSONALITY + 1
DEF MON_IS_EGG     EQU MON_PERSONALITY + 1
DEF MON_EXTSPECIES EQU MON_PERSONALITY + 1
DEF MON_FORM       EQU MON_PERSONALITY + 1
DEF MON_PP                 rb NUM_MOVES
DEF MON_HAPPINESS          rb
DEF MON_PKRUS              rb
DEF MON_CAUGHTDATA         rb 3
rsset MON_CAUGHTDATA
DEF MON_CAUGHTTIME         rb
DEF MON_CAUGHTBALL EQU MON_CAUGHTTIME
DEF MON_CAUGHTLEVEL        rb
DEF MON_CAUGHTLOCATION     rb
DEF MON_LEVEL              rb
DEF BREEDMON_STRUCT_LENGTH EQU _RS
DEF MON_STATUS             rb
                           rb_skip
DEF MON_HP                 rw
DEF MON_MAXHP              rw
DEF MON_STATS              rw NUM_BATTLE_STATS
rsset MON_STATS
DEF MON_ATK                rw
DEF MON_DEF                rw
DEF MON_SPE                rw
DEF MON_SAT                rw
DEF MON_SDF                rw
DEF PARTYMON_STRUCT_LENGTH EQU _RS

; savemon_struct members (see macros/ram.asm)
rsreset
DEF SAVEMON_SPECIES            rb
DEF SAVEMON_ITEM               rb
DEF SAVEMON_MOVES              rb NUM_MOVES
DEF SAVEMON_ID                 rw
DEF SAVEMON_EXP                rb 3
DEF SAVEMON_EVS                rb NUM_STATS
rsset SAVEMON_EVS
DEF SAVEMON_HP_EV              rb
DEF SAVEMON_ATK_EV             rb
DEF SAVEMON_DEF_EV             rb
DEF SAVEMON_SPE_EV             rb
DEF SAVEMON_SAT_EV             rb
DEF SAVEMON_SDF_EV             rb
DEF SAVEMON_DVS                rb NUM_STATS / 2
rsset SAVEMON_DVS
DEF SAVEMON_HP_ATK_DV          rb
DEF SAVEMON_DEF_SPE_DV         rb
DEF SAVEMON_SAT_SDF_DV         rb
DEF SAVEMON_PERSONALITY        rw
DEF SAVEMON_SHINY      EQU SAVEMON_PERSONALITY
DEF SAVEMON_ABILITY    EQU SAVEMON_PERSONALITY
DEF SAVEMON_NATURE     EQU SAVEMON_PERSONALITY
DEF SAVEMON_GENDER     EQU SAVEMON_PERSONALITY + 1
DEF SAVEMON_IS_EGG     EQU SAVEMON_PERSONALITY + 1
DEF SAVEMON_EXTSPECIES EQU SAVEMON_PERSONALITY + 1
DEF SAVEMON_FORM       EQU SAVEMON_PERSONALITY + 1
; savemon_struct is identical to party_struct before this point
DEF SAVEMON_PP_UPS             rb
; savemon_struct is shifted from party_struct beyond this point
DEF SAVEMON_HAPPINESS          rb
DEF SAVEMON_PKRUS              rb
DEF SAVEMON_CAUGHTDATA         rb 3
rsset SAVEMON_CAUGHTDATA
DEF SAVEMON_CAUGHTTIME         rb
DEF SAVEMON_CAUGHTBALL EQU SAVEMON_CAUGHTTIME
DEF SAVEMON_CAUGHTLEVEL        rb
DEF SAVEMON_CAUGHTLOCATION     rb
DEF SAVEMON_LEVEL              rb
; savemon_struct is different from party_struct beyond this point
DEF SAVEMON_EXTRA              rb 3
DEF SAVEMON_NICKNAME           rb MON_NAME_LENGTH - 1
DEF SAVEMON_OT                 rb PLAYER_NAME_LENGTH - 1
DEF SAVEMON_STRUCT_LENGTH EQU _RS

; personality

DEF SHINY_MASK       EQU %10000000
DEF ABILITY_MASK     EQU %01100000
DEF NATURE_MASK      EQU %00011111

DEF MON_SHINY_F      EQU 7

DEF CAUGHT_MASK      EQU %10000000 ; Reuses the gender flag in dex.
DEF GENDER_MASK      EQU %10000000
DEF IS_EGG_MASK      EQU %01000000
DEF EXTSPECIES_MASK  EQU %00100000
DEF FORM_MASK        EQU %00011111

DEF SPECIESFORM_MASK EQU EXTSPECIES_MASK | FORM_MASK

DEF MON_COSMETIC_F   EQU 7 ; used for area location checking
DEF MON_CAUGHT_F     EQU 7
DEF MON_GENDER_F     EQU 7
DEF MON_IS_EGG_F     EQU 6
DEF MON_EXTSPECIES_F EQU 5

; modern EVs are max 252 per stat, 510 total
; stat exp style allows 255 in all six stats
DEF MODERN_MAX_EV EQU 252
DEF MODERN_EV_LIMIT EQU 510

; hyper training level requirement
DEF HYPER_LEVEL_REQ EQU 50

; shiny probability values
DEF SHINY_NUMERATOR         EQU 16 ; 16/65536 = 1/4096
DEF CHARMED_SHINY_NUMERATOR EQU 48 ; 48/65536 = 3/4096

; ability values
DEF ABILITY_1      EQU %00100000
DEF ABILITY_2      EQU %01000000
DEF HIDDEN_ABILITY EQU %01100000

; gender values
DEF MALE   EQU %00000000
DEF FEMALE EQU %10000000

; caught data
DEF CAUGHT_TIME_MASK   EQU %01100000
DEF CAUGHT_BALL_MASK   EQU %00011111

; hyper training (stored at end of OT name)
DEF HYPER_TRAINING_MASK EQU %11111100

DEF MON_CRY_LENGTH EQU 6

; maximum number of party pokemon
DEF PARTY_LENGTH EQU 6

; pokerus
; NOTE: because # of days remaining in a pokerus infection is a nybble and tracked via bit-shifting and not arithmetic,
; there are five 4-bit that are left unused. for a minor memory optimization, numbers > 7 are preferred.
; therefore, the unused candidate numbers are %1001, %1010 %1011, %1101
; why did I pick %1101? I like the number 13 :)
DEF POKERUS_CURED EQU %1101
DEF POKERUS_MASK EQU %00001111

; boxes
DEF MONS_PER_BOX    EQU 20
DEF MONDB_ENTRIES_A EQU 167
DEF MONDB_ENTRIES_B EQU 28
DEF MONDB_ENTRIES_C EQU 12
DEF MONDB_ENTRIES   EQU MONDB_ENTRIES_A + MONDB_ENTRIES_B + MONDB_ENTRIES_C
DEF MIN_MONDB_SLACK EQU 10
DEF NUM_BOXES       EQU (MONDB_ENTRIES * 2 - MIN_MONDB_SLACK) / MONS_PER_BOX ; 20

; hall of fame
DEF HOF_MON_LENGTH EQU 1 + 2 + 2 + 1 + (MON_NAME_LENGTH - 1) ; species, id, dvs, level, nick
DEF HOF_LENGTH EQU 1 + HOF_MON_LENGTH * PARTY_LENGTH + 1 ; win count, party, terminator
DEF NUM_HOF_TEAMS EQU 10

; evolution types (used in data/pokemon/evos_attacks.asm)
	const_def
	const EVOLVE_NONE ; only for Lyra's info
	const EVOLVE_LEVEL
	const EVOLVE_ITEM
	const EVOLVE_TRADE
	const EVOLVE_HOLDING
	const EVOLVE_HAPPINESS
	const EVOLVE_STAT ; only for Tyrogue (no need for "EVOLVE_TYROGUE")
	const EVOLVE_LOCATION
	const EVOLVE_MOVE
	const EVOLVE_CRIT ; only for Galarian Farfetch'd
	const EVOLVE_PARTY ; only for Mantyke
; multi_evo types for Lyra's info (used in data/pokemon/multi_evos.asm)
	const EVOLVE_EGG
	const EVOLVE_PIKACHU
	const EVOLVE_GLOOM
	const EVOLVE_POLIWHIRL
	const EVOLVE_SLOWPOKE
	const EVOLVE_SLOWPOKE_GALARIAN
	const EVOLVE_MAGNETON
	const EVOLVE_EXEGGCUTE
	const EVOLVE_KOFFING
	const EVOLVE_CUBONE
	const EVOLVE_SCYTHER
	const EVOLVE_EEVEE
	const EVOLVE_MIME_JR_
	const EVOLVE_URSARING
	const EVOLVE_STANTLER
	const EVOLVE_DUNSPARCE
DEF NUM_EVOLVE_METHODS EQU const_value

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

; wild data

DEF NUM_GRASSMON EQU 7 ; data/wild/*_grass.asm table size
DEF NUM_WATERMON EQU 3 ; data/wild/*_water.asm table size

DEF GRASS_WILDDATA_LENGTH EQU 2 + (1 + NUM_GRASSMON * 3) * 3
DEF WATER_WILDDATA_LENGTH EQU 2 + (1 + NUM_WATERMON * 3) * 1
DEF FISHGROUP_DATA_LENGTH EQU 2 + 2 * 3

DEF NUM_ROAMMON_MAPS EQU 16 ; RoamMaps table size (see data/wild/roammon_maps.asm)

DEF LEVEL_FROM_BADGES EQU 178 ; allows ±77 in either direction

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
	const TREEMON_SET_APRICORNS
	const TREEMON_SET_NOISY_FOREST
	const TREEMON_SET_ROCK ; must be last
DEF NUM_TREEMON_SETS EQU const_value

; treemon scores
	const_def
	const TREEMON_SCORE_BAD  ; 0
	const TREEMON_SCORE_GOOD ; 1
	const TREEMON_SCORE_RARE ; 2

; ChangeHappiness arguments (see data/events/happiness_changes.asm)
	const_def
	const HAPPINESS_GAINLEVEL         ; 00
	const HAPPINESS_USEDVITAMIN       ; 01
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
	const HAPPINESS_STEP              ; 16
DEF NUM_HAPPINESS_CHANGES EQU const_value

; significant happiness values
DEF BASE_HAPPINESS        EQU 70
DEF FRIEND_BALL_HAPPINESS EQU 150
DEF HATCHED_HAPPINESS     EQU 120
DEF HAPPINESS_TO_EVOLVE   EQU 160
DEF MAX_RETURN_HAPPINESS  EQU 160
DEF HAPPINESS_THRESHOLD_1 EQU 100
DEF HAPPINESS_THRESHOLD_2 EQU 160

; PP
DEF PP_UP_MASK EQU %11000000
DEF PP_UP_ONE  EQU %01000000
DEF PP_MASK    EQU %00111111
