BASEMON_BASE_STATS    EQUS "(BaseData + BaseStats - CurBaseData)"
BASEMON_BASE_HP       EQUS "(BaseData + BaseHP - CurBaseData)"
BASEMON_BASE_ATK      EQUS "(BaseData + BaseAttack - CurBaseData)"
BASEMON_BASE_DEF      EQUS "(BaseData + BaseDefense - CurBaseData)"
BASEMON_BASE_SPD      EQUS "(BaseData + BaseSpeed - CurBaseData)"
BASEMON_BASE_SAT      EQUS "(BaseData + BaseSpecialAttack - CurBaseData)"
BASEMON_BASE_SDF      EQUS "(BaseData + BaseSpecialDefense - CurBaseData)"
BASEMON_TYPES         EQUS "(BaseData + BaseType - CurBaseData)"
BASEMON_TYPE_1        EQUS "(BaseData + BaseType1 - CurBaseData)"
BASEMON_TYPE_2        EQUS "(BaseData + BaseType2 - CurBaseData)"
BASEMON_CATCH_RATE    EQUS "(BaseData + BaseCatchRate - CurBaseData)"
BASEMON_BASE_EXP      EQUS "(BaseData + BaseExp - CurBaseData)"
BASEMON_ITEMS         EQUS "(BaseData + BaseItems - CurBaseData)"
BASEMON_ITEM_1        EQUS "(BaseData + BaseItems - CurBaseData)"
BASEMON_ITEM_2        EQUS "(BaseData + BaseItems + 1 - CurBaseData)"
BASEMON_GENDER        EQUS "(BaseData + BaseGender - CurBaseData)"
BASEMON_EGG_STEPS     EQUS "(BaseData + BaseEggSteps - CurBaseData)"
BASEMON_PIC_SIZE      EQUS "(BaseData + BasePicSize - CurBaseData)"
BASEMON_ABILITIES     EQUS "(BaseData + BaseAbility1 - CurBaseData)"
BASEMON_ABILITY_1     EQUS "(BaseData + BaseAbility1 - CurBaseData)"
BASEMON_ABILITY_2     EQUS "(BaseData + BaseAbility2 - CurBaseData)"
BASEMON_ABILITY_3     EQUS "(BaseData + BaseHiddenAbility - CurBaseData)"
BASEMON_GROWTH_RATE   EQUS "(BaseData + BaseGrowthRate - CurBaseData)"
BASEMON_EGG_GROUPS    EQUS "(BaseData + BaseEggGroups - CurBaseData)"
BASEMON_EV_YIELD_1    EQUS "(BaseData + BaseEVYield1 - CurBaseData)"
BASEMON_EV_YIELD_2    EQUS "(BaseData + BaseEVYield2 - CurBaseData)"
BASEMON_TMHM          EQUS "(BaseData + BaseTMHM - CurBaseData)"
BASEMON_STRUCT_LENGTH EQUS "(BaseData1 - BaseData0)"

; growth rate
	const_def
	const MEDIUM_FAST
	const MEDIUM_SLOW
	const FAST
	const SLOW

; gender ratios
	const_def
	const ALL_MALE
	const FEMALE_12_5
	const FEMALE_25
	const FEMALE_37_5
	const FEMALE_50
	const FEMALE_62_5
	const FEMALE_75
	const FEMALE_87_5
	const ALL_FEMALE

GENDERLESS EQU %1111

; egg group constants
	const_def 1
	const MONSTER      ; 1
	const AMPHIBIAN    ; 2
	const INSECT       ; 3
	const AVIAN        ; 4
	const FIELD        ; 5
	const FAERY        ; 6
	const PLANT        ; 7
	const HUMANSHAPE   ; 8
	const INVERTEBRATE ; 9
	const INANIMATE    ; a
	const AMORPHOUS    ; b
	const FISH         ; c
	const LADIES_MAN   ; d
	const REPTILE      ; e
	const NO_EGGS      ; f


; pokemon structure in RAM
MON_SPECIES              EQUS "(PartyMon1Species - PartyMon1)"
MON_ITEM                 EQUS "(PartyMon1Item - PartyMon1)"
MON_MOVES                EQUS "(PartyMon1Moves - PartyMon1)"
MON_ID                   EQUS "(PartyMon1ID - PartyMon1)"
MON_EXP                  EQUS "(PartyMon1Exp - PartyMon1)"
MON_EVS                  EQUS "(PartyMon1EVs - PartyMon1)"
MON_HP_EV                EQUS "(PartyMon1HPEV - PartyMon1)"
MON_ATK_EV               EQUS "(PartyMon1AtkEV - PartyMon1)"
MON_DEF_EV               EQUS "(PartyMon1DefEV - PartyMon1)"
MON_SPD_EV               EQUS "(PartyMon1SpdEV - PartyMon1)"
MON_SAT_EV               EQUS "(PartyMon1SatEV - PartyMon1)"
MON_SDF_EV               EQUS "(PartyMon1SdfEV - PartyMon1)"
MON_DVS                  EQUS "(PartyMon1DVs - PartyMon1)"
MON_PERSONALITY          EQUS "(PartyMon1Personality - PartyMon1)"
MON_SHINY                EQUS "(PartyMon1Shiny - PartyMon1)"
MON_ABILITY              EQUS "(PartyMon1Ability - PartyMon1)"
MON_NATURE               EQUS "(PartyMon1Nature - PartyMon1)"
MON_GENDER               EQUS "(PartyMon1Gender - PartyMon1)"
MON_IS_EGG               EQUS "(PartyMon1IsEgg - PartyMon1)"
MON_IS_DEAD              EQUS "(PartyMon1IsDead - PartyMon1)"
MON_FORM                 EQUS "(PartyMon1Form - PartyMon1)"
MON_PP                   EQUS "(PartyMon1PP - PartyMon1)"
MON_HAPPINESS            EQUS "(PartyMon1Happiness - PartyMon1)"
MON_PKRUS                EQUS "(PartyMon1PokerusStatus - PartyMon1)"
MON_CAUGHTDATA           EQUS "(PartyMon1CaughtData - PartyMon1)"
MON_CAUGHTGENDER         EQUS "(PartyMon1CaughtGender - PartyMon1)"
MON_CAUGHTTIME           EQUS "(PartyMon1CaughtTime - PartyMon1)"
MON_CAUGHTBALL           EQUS "(PartyMon1CaughtBall - PartyMon1)"
MON_CAUGHTLEVEL          EQUS "(PartyMon1CaughtLevel - PartyMon1)"
MON_CAUGHTLOCATION       EQUS "(PartyMon1CaughtLocation - PartyMon1)"
MON_LEVEL                EQUS "(PartyMon1Level - PartyMon1)"
MON_STATUS               EQUS "(PartyMon1Status - PartyMon1)"
MON_HP                   EQUS "(PartyMon1HP - PartyMon1)"
MON_MAXHP                EQUS "(PartyMon1MaxHP - PartyMon1)"
MON_STATS                EQUS "(PartyMon1Stats - PartyMon1)"
MON_ATK                  EQUS "(PartyMon1Attack - PartyMon1)"
MON_DEF                  EQUS "(PartyMon1Defense - PartyMon1)"
MON_SPD                  EQUS "(PartyMon1Speed - PartyMon1)"
MON_SAT                  EQUS "(PartyMon1SpclAtk - PartyMon1)"
MON_SDF                  EQUS "(PartyMon1SpclDef - PartyMon1)"
BOXMON_STRUCT_LENGTH     EQUS "(PartyMon1End - PartyMon1)"
PARTYMON_STRUCT_LENGTH   EQUS "(PartyMon1StatsEnd - PartyMon1)"

; apply to MON_FORM
SHINY_MASK   EQU %10000000
ABILITY_MASK EQU %01100000
NATURE_MASK  EQU %00011111
GENDER_MASK  EQU %10000000
IS_EGG_MASK  EQU %01000000
IS_DEAD_MASK EQU %00100000
FORM_MASK    EQU %00011111

; apply to MON_CAUGHTDATA
CAUGHTGENDER_MASK EQU %10000000
CAUGHTTIME_MASK   EQU %01100000
CAUGHTBALL_MASK   EQU %00011111

; gender values
MALE   EQU %00000000
FEMALE EQU %10000000

BATTLEMON_STRUCT_LENGTH EQUS "(BattleMonStructEnd - BattleMonSpecies)"


; evolution types
	const_def 1
	const EVOLVE_LEVEL
	const EVOLVE_ITEM
	const EVOLVE_HOLDING
	const EVOLVE_HAPPINESS
	const EVOLVE_STAT
	const EVOLVE_LOCATION
	const EVOLVE_MOVE
	const EVOLVE_EVS

; happiness evolution triggers
HAPPINESS_TO_EVOLVE EQU 220
	const_def 1
	const TR_ANYTIME
	const TR_MORNDAY
	const TR_NITE

EVS_TO_EVOLVE EQU 50

; stat evolution triggers
	const_def 1
	const ATK_GT_DEF
	const ATK_LT_DEF
	const ATK_EQ_DEF


PARTY_LENGTH EQU 6

; boxes
MONS_PER_BOX EQU 20
NUM_BOXES    EQU 14

; hall of fame
HOF_MON_LENGTH = 1 + 2 + 2 + 1 + (PKMN_NAME_LENGTH +- 1) ; species, id, dvs, level, nick
HOF_LENGTH = 1 + HOF_MON_LENGTH * PARTY_LENGTH + 1 ; win count, party, terminator
NUM_HOF_TEAMS = 30


NUM_GRASSMON EQU 7
NUM_WATERMON EQU 3

GRASS_WILDDATA_LENGTH EQU (NUM_GRASSMON * 2 + 1) * 3 + 2
WATER_WILDDATA_LENGTH EQU (NUM_WATERMON * 2 + 1) * 1 + 2


BASE_HAPPINESS        EQU 70
FRIEND_BALL_HAPPINESS EQU 200
