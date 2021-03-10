BASEMON_BASE_STATS    EQUS "(BaseData + wBaseStats - wCurBaseData)"
BASEMON_BASE_HP       EQUS "(BaseData + wBaseHP - wCurBaseData)"
BASEMON_BASE_ATK      EQUS "(BaseData + wBaseAttack - wCurBaseData)"
BASEMON_BASE_DEF      EQUS "(BaseData + wBaseDefense - wCurBaseData)"
BASEMON_BASE_SPD      EQUS "(BaseData + wBaseSpeed - wCurBaseData)"
BASEMON_BASE_SAT      EQUS "(BaseData + wBaseSpecialAttack - wCurBaseData)"
BASEMON_BASE_SDF      EQUS "(BaseData + wBaseSpecialDefense - wCurBaseData)"
BASEMON_TYPES         EQUS "(BaseData + wBaseType - wCurBaseData)"
BASEMON_TYPE_1        EQUS "(BaseData + wBaseType1 - wCurBaseData)"
BASEMON_TYPE_2        EQUS "(BaseData + wBaseType2 - wCurBaseData)"
BASEMON_CATCH_RATE    EQUS "(BaseData + wBaseCatchRate - wCurBaseData)"
BASEMON_BASE_EXP      EQUS "(BaseData + wBaseExp - wCurBaseData)"
BASEMON_ITEMS         EQUS "(BaseData + wBaseItems - wCurBaseData)"
BASEMON_ITEM_1        EQUS "(BaseData + wBaseItems - wCurBaseData)"
BASEMON_ITEM_2        EQUS "(BaseData + wBaseItems + 1 - wCurBaseData)"
BASEMON_GENDER        EQUS "(BaseData + wBaseGender - wCurBaseData)"
BASEMON_EGG_STEPS     EQUS "(BaseData + wBaseEggSteps - wCurBaseData)"
BASEMON_PIC_SIZE      EQUS "(BaseData + wBasePicSize - wCurBaseData)"
BASEMON_ABILITIES     EQUS "(BaseData + wBaseAbility1 - wCurBaseData)"
BASEMON_ABILITY_1     EQUS "(BaseData + wBaseAbility1 - wCurBaseData)"
BASEMON_ABILITY_2     EQUS "(BaseData + wBaseAbility2 - wCurBaseData)"
BASEMON_ABILITY_3     EQUS "(BaseData + wBaseHiddenAbility - wCurBaseData)"
BASEMON_GROWTH_RATE   EQUS "(BaseData + wBaseGrowthRate - wCurBaseData)"
BASEMON_EGG_GROUPS    EQUS "(BaseData + wBaseEggGroups - wCurBaseData)"
BASEMON_EV_YIELD_1    EQUS "(BaseData + wBaseEVYield1 - wCurBaseData)"
BASEMON_EV_YIELD_2    EQUS "(BaseData + wBaseEVYield2 - wCurBaseData)"
BASEMON_TMHM          EQUS "(BaseData + wBaseTMHM - wCurBaseData)"
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
MON_SPECIES              EQUS "(wPartyMon1Species - wPartyMon1)"
MON_ITEM                 EQUS "(wPartyMon1Item - wPartyMon1)"
MON_MOVES                EQUS "(wPartyMon1Moves - wPartyMon1)"
MON_ID                   EQUS "(wPartyMon1ID - wPartyMon1)"
MON_EXP                  EQUS "(wPartyMon1Exp - wPartyMon1)"
MON_EVS                  EQUS "(wPartyMon1EVs - wPartyMon1)"
MON_HP_EV                EQUS "(wPartyMon1HPEV - wPartyMon1)"
MON_ATK_EV               EQUS "(wPartyMon1AtkEV - wPartyMon1)"
MON_DEF_EV               EQUS "(wPartyMon1DefEV - wPartyMon1)"
MON_SPD_EV               EQUS "(wPartyMon1SpdEV - wPartyMon1)"
MON_SAT_EV               EQUS "(wPartyMon1SatEV - wPartyMon1)"
MON_SDF_EV               EQUS "(wPartyMon1SdfEV - wPartyMon1)"
MON_DVS                  EQUS "(wPartyMon1DVs - wPartyMon1)"
MON_PERSONALITY          EQUS "(wPartyMon1Personality - wPartyMon1)"
MON_SHINY                EQUS "(wPartyMon1Shiny - wPartyMon1)"
MON_ABILITY              EQUS "(wPartyMon1Ability - wPartyMon1)"
MON_NATURE               EQUS "(wPartyMon1Nature - wPartyMon1)"
MON_GENDER               EQUS "(wPartyMon1Gender - wPartyMon1)"
MON_IS_EGG               EQUS "(wPartyMon1IsEgg - wPartyMon1)"
MON_EXTSPECIES           EQUS "(wPartyMon1ExtSpecies - wPartyMon1)"
MON_FORM                 EQUS "(wPartyMon1Form - wPartyMon1)"
MON_PP                   EQUS "(wPartyMon1PP - wPartyMon1)"
MON_HAPPINESS            EQUS "(wPartyMon1Happiness - wPartyMon1)"
MON_PKRUS                EQUS "(wPartyMon1PokerusStatus - wPartyMon1)"
MON_CAUGHTDATA           EQUS "(wPartyMon1CaughtData - wPartyMon1)"
MON_CAUGHTGENDER         EQUS "(wPartyMon1CaughtGender - wPartyMon1)"
MON_CAUGHTTIME           EQUS "(wPartyMon1CaughtTime - wPartyMon1)"
MON_CAUGHTBALL           EQUS "(wPartyMon1CaughtBall - wPartyMon1)"
MON_CAUGHTLEVEL          EQUS "(wPartyMon1CaughtLevel - wPartyMon1)"
MON_CAUGHTLOCATION       EQUS "(wPartyMon1CaughtLocation - wPartyMon1)"
MON_LEVEL                EQUS "(wPartyMon1Level - wPartyMon1)"
MON_STATUS               EQUS "(wPartyMon1Status - wPartyMon1)"
MON_HP                   EQUS "(wPartyMon1HP - wPartyMon1)"
MON_MAXHP                EQUS "(wPartyMon1MaxHP - wPartyMon1)"
MON_STATS                EQUS "(wPartyMon1Stats - wPartyMon1)"
MON_ATK                  EQUS "(wPartyMon1Attack - wPartyMon1)"
MON_DEF                  EQUS "(wPartyMon1Defense - wPartyMon1)"
MON_SPD                  EQUS "(wPartyMon1Speed - wPartyMon1)"
MON_SAT                  EQUS "(wPartyMon1SpclAtk - wPartyMon1)"
MON_SDF                  EQUS "(wPartyMon1SpclDef - wPartyMon1)"
BOXMON_STRUCT_LENGTH     EQUS "(wPartyMon1End - wPartyMon1)"
PARTYMON_STRUCT_LENGTH   EQUS "(wPartyMon1StatsEnd - wPartyMon1)"

; apply to MON_FORM
SHINY_MASK      EQU %10000000
ABILITY_MASK    EQU %01100000
NATURE_MASK     EQU %00011111
GENDER_MASK     EQU %10000000
IS_EGG_MASK     EQU %01000000
EXTSPECIES_MASK EQU %00100000
FORM_MASK       EQU %00011111
BASEMON_MASK    EQU (EXTSPECIES_MASK | FORM_MASK)

HYPER_TRAINING_MASK EQU %11111100

MON_SHINY_F      EQU 7
MON_GENDER_F     EQU 7
MON_IS_EGG_F     EQU 6
MON_EXTSPECIES_F EQU 5

; apply to MON_CAUGHTDATA
CAUGHTGENDER_MASK EQU %10000000
CAUGHTTIME_MASK   EQU %01100000
CAUGHTBALL_MASK   EQU %00011111

; ability values
ABILITY_1      EQU %00100000
ABILITY_2      EQU %01000000
HIDDEN_ABILITY EQU %01100000

; gender values
MALE   EQU %00000000
FEMALE EQU %10000000

BATTLEMON_STRUCT_LENGTH EQUS "(wBattleMonStructEnd - wBattleMonSpecies)"


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
	const TR_EVENITE

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
HOF_MON_LENGTH = 1 + 2 + 2 + 1 + (MON_NAME_LENGTH - 1) ; species, id, dvs, level, nick
HOF_LENGTH = 1 + HOF_MON_LENGTH * PARTY_LENGTH + 1 ; win count, party, terminator
NUM_HOF_TEAMS = 30


NUM_GRASSMON EQU 7
NUM_WATERMON EQU 3

GRASS_WILDDATA_LENGTH EQU (NUM_GRASSMON * 3 + 1) * 3 + 2
WATER_WILDDATA_LENGTH EQU (NUM_WATERMON * 3 + 1) * 1 + 2


SHINY_NUMERATOR         EQU 16 ; 16/65536 = 1/4096
CHARMED_SHINY_NUMERATOR EQU 48 ; 48/65536 = 3/4096


BASE_HAPPINESS        EQU 70
FRIEND_BALL_HAPPINESS EQU 200

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
	const HAPPINESS_YOUNGCUT1         ; 09
	const HAPPINESS_YOUNGCUT2         ; 0a
	const HAPPINESS_YOUNGCUT3         ; 0b
	const HAPPINESS_OLDERCUT1         ; 0c
	const HAPPINESS_OLDERCUT2         ; 0d
	const HAPPINESS_OLDERCUT3         ; 0e
	const HAPPINESS_BITTERPOWDER      ; 0f
	const HAPPINESS_ENERGYROOT        ; 10
	const HAPPINESS_REVIVALHERB       ; 11
	const HAPPINESS_MASSAGE           ; 12
	const HAPPINESS_GAINLEVELATHOME   ; 13
	const HAPPINESS_PHOTOGRAPH        ; 14
	const HAPPINESS_BLESSING          ; 15
