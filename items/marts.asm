Marts: ; 160a9
	dw CherrygroveMart
	dw CherrygroveMartAfterDex
	dw VioletMart
	dw AzaleaMart
	dw Goldenrod2FMart1
	dw Goldenrod2FMart2
	dw Goldenrod2FMart2Eevee
	dw Goldenrod3FMart
	dw Goldenrod4FMart
	dw Goldenrod5FTMMart
	dw GoldenrodHarborMart
	dw UndergroundMart
	dw EcruteakMart
	dw OlivineMart
	dw CianwoodMart
	dw YellowForestMart
	dw MahoganyMart1
	dw MahoganyMart2
	dw BlackthornMart
	dw IndigoPlateauMart
	dw ViridianMart
	dw PewterMart
	dw MtMoonMart
	dw CeruleanMart
	dw LavenderMart
	dw VermilionMart
	dw Celadon2FMart1
	dw Celadon2FMart2
	dw Celadon3FTMMart
	dw Celadon4FMart
	dw Celadon5FMart1
	dw Celadon5FMart2
	dw SaffronMart
	dw SilphCoMart
	dw FuchsiaMart
	dw ShamoutiMart1
	dw ShamoutiMart2
	dw BattleTowerMart1
	dw BattleTowerMart2
	dw BattleTowerMart3
MartsEnd
; 160ed


CherrygroveMart: ; 160ed
	db 4 ; # items
	db POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db -1
; 160f3

CherrygroveMartAfterDex: ; 160f3
	db 6 ; # items
	db POKE_BALL
	db HEAL_BALL
	db POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db -1
; 160fa

VioletMart: ; 160fa
	db 11 ; # items
	db POKE_BALL
	db REPEAT_BALL
	db POTION
	db ESCAPE_ROPE
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db X_ATTACK
	db X_DEFEND
	db X_SPEED
	db FLOWER_MAIL
	db -1
; 16106

AzaleaMart: ; 16106
	db 10 ; # items
	db CHARCOAL
	db POKE_BALL
	db NET_BALL
	db POTION
	db SUPER_POTION
	db ESCAPE_ROPE
	db REPEL
	db ANTIDOTE
	db PARLYZ_HEAL
	db FLOWER_MAIL
	db -1
; 16111

Goldenrod2FMart1: ; 16118
	db 9 ; # items
	db POTION
	db SUPER_POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db ICE_HEAL
	db FULL_HEAL
	db REVIVE
	db -1
; 16121

Goldenrod2FMart2: ; 16121
	db 10 ; # items
	db POKE_BALL
	db GREAT_BALL
	db LUXURY_BALL
	db TIMER_BALL
	db QUICK_BALL
	db ESCAPE_ROPE
	db REPEL
	db POKE_DOLL
	db BLUESKY_MAIL
	db MORPH_MAIL
	db -1
; 1612b

Goldenrod2FMart2Eevee: ; 16140
	db 11 ; # items
	db POKE_BALL
	db GREAT_BALL
	db LUXURY_BALL
	db TIMER_BALL
	db QUICK_BALL
	db ESCAPE_ROPE
	db REPEL
	db POKE_DOLL
	db BLUESKY_MAIL
	db MORPH_MAIL
	db EON_MAIL
	db -1
; 16146

Goldenrod3FMart: ; 1612b
Celadon5FMart2: ; 161e1
	db 8 ; # items
	db X_ATTACK
	db X_DEFEND
	db X_SPEED
	db X_SPCL_ATK
	db X_SPCL_DEF
	db DIRE_HIT
	db GUARD_SPEC
	db X_ACCURACY
	db -1
; 16134

Goldenrod4FMart: ; 16134
Celadon5FMart1: ; 161da
	db 6 ; # items
	db PROTEIN
	db IRON
	db CARBOS
	db CALCIUM
	db ZINC
	db HP_UP
	db -1
; 1613b

Goldenrod5FTMMart: ; 1613b
	db 8 ; # items
	dbw TM_PROTECT,       10000
	dbw TM_REFLECT,       10000
	dbw TM_LIGHT_SCREEN,  10000
	dbw TM_SOLAR_BEAM,    25000
	dbw TM_THUNDER,       30000
	dbw TM_FIRE_BLAST,    30000
	dbw TM_BLIZZARD,      30000
	dbw TM_HYPER_BEAM,    50000
	db -1
; 16140

GoldenrodHarborMart:
	db 8 ; # items
	db ETHER
	db ELIXER
	db DESTINY_KNOT
	db SCOPE_LENS
	db WIDE_LENS
	db ZOOM_LENS
	db BRIGHTPOWDER
	db SURF_MAIL
	db -1

UndergroundMart: ; 1620e
	db 4 ; # items
	db ENERGYPOWDER
	db ENERGY_ROOT
	db HEAL_POWDER
	db REVIVAL_HERB
	db -1
; 16214

EcruteakMart: ; 1615e
	db 11 ; # items
	db POKE_BALL
	db GREAT_BALL
	db NEST_BALL
	db POTION
	db SUPER_POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db ICE_HEAL
	db REVIVE
	db -1
; 1616a

OlivineMart: ; 16153
	db 10 ; # items
	db GREAT_BALL
	db DIVE_BALL
	db SUPER_POTION
	db HYPER_POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db ICE_HEAL
	db SUPER_REPEL
	db SURF_MAIL
	db -1
; 1615e

CianwoodMart: ; 16111
	db 5 ; # items
	db POTION
	db SUPER_POTION
	db HYPER_POTION
	db FULL_HEAL
	db REVIVE
	db -1
; 16118

YellowForestMart: ; 1614c
	db 4 ; # items
	db POKE_BALL
	db REPEL
	db FRESH_WATER
	db FULL_HEAL
	db -1
; 16153

MahoganyMart1: ; 1616a
	db 4 ; # items
	db TINYMUSHROOM
	db SLOWPOKETAIL
	db GREAT_BALL
	db SUPER_POTION
	db -1
; 16170

MahoganyMart2: ; 16170
	db 10 ; # items
	db RAGECANDYBAR
	db AIR_BALLOON
	db QUICK_CLAW
	db KINGS_ROCK
	db GREAT_BALL
	db SUPER_POTION
	db HYPER_POTION
	db SUPER_REPEL
	db REVIVE
	db FLOWER_MAIL
	db -1
; 1617b

BlackthornMart: ; 1617b
	db 11 ; # items
	db GREAT_BALL
	db ULTRA_BALL
	db DUSK_BALL
	db HYPER_POTION
	db MAX_POTION
	db FULL_HEAL
	db REVIVE
	db MAX_REPEL
	db X_DEFEND
	db X_ATTACK
	db MUSIC_MAIL
	db -1
; 16186

IndigoPlateauMart: ; 16205
	db 7 ; # items
	db ULTRA_BALL
	db MAX_REPEL
	db HYPER_POTION
	db MAX_POTION
	db FULL_RESTORE
	db REVIVE
	db FULL_HEAL
	db -1
; 1620e

ViridianMart: ; 16186
	db 11 ; # items
	db ULTRA_BALL
	db NET_BALL
	db HYPER_POTION
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db FULL_HEAL
	db MAX_REPEL
	db REVIVE
	db FLOWER_MAIL
	db -1
; 16191

PewterMart: ; 16191
	db 8 ; # items
	db GREAT_BALL
	db DUSK_BALL
	db SUPER_POTION
	db SUPER_REPEL
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db -1
; 1619a

MtMoonMart: ; 161fd
	db 8 ; # items
	db POKE_DOLL
	db FRESH_WATER
	db SODA_POP
	db LEMONADE
	db REPEL
	db SUPER_REPEL
	db MIRAGE_MAIL
	db PORTRAITMAIL
	db -1
; 16205

CeruleanMart: ; 1619a
	db 10 ; # items
	db GREAT_BALL
	db ULTRA_BALL
	db DIVE_BALL
	db SUPER_POTION
	db SUPER_REPEL
	db FULL_HEAL
	db X_DEFEND
	db X_ATTACK
	db DIRE_HIT
	db SURF_MAIL
	db -1
; 161a5

LavenderMart: ; 161a5
	db 9 ; # items
	db GREAT_BALL
	db HEAL_BALL
	db POTION
	db SUPER_POTION
	db MAX_REPEL
	db ANTIDOTE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db -1
; 161af

VermilionMart: ; 161af
	db 9 ; # items
	db ULTRA_BALL
	db REPEAT_BALL
	db SUPER_POTION
	db HYPER_POTION
	db REVIVE
	db PARLYZ_HEAL
	db AWAKENING
	db BURN_HEAL
	db LITEBLUEMAIL
	db -1
; 161b9

Celadon2FMart1: ; 161b9
	db 12 ; # items
	db POTION
	db SUPER_POTION
	db HYPER_POTION
	db MAX_POTION
	db ANTIDOTE
	db BURN_HEAL
	db ICE_HEAL
	db AWAKENING
	db PARLYZ_HEAL
	db FULL_HEAL
	db REVIVE
	db MAX_REVIVE
	db -1
; 161c2

Celadon2FMart2: ; 161c2
	db 9 ; # items
	db POKE_BALL
	db GREAT_BALL
	db ULTRA_BALL
	db QUICK_BALL
	db TIMER_BALL
	db ESCAPE_ROPE
	db REPEL
	db SUPER_REPEL
	db MAX_REPEL
	db -1
; 161ce

Celadon3FTMMart: ; 161ce
	db 8 ; # items
	dbw TM_SAFEGUARD,     10000
	dbw TM_BULK_UP,       20000
	dbw TM_CALM_MIND,     20000
	dbw TM_SWORDS_DANCE,  20000
	dbw TM_SUNNY_DAY,     40000
	dbw TM_RAIN_DANCE,    40000
	dbw TM_SANDSTORM,     40000
	dbw TM_HAIL,          40000
	db -1
; 161d5

Celadon4FMart: ; 161d5
	db 8 ; # items
	db POKE_DOLL
	db FIRE_STONE
	db WATER_STONE
	db THUNDERSTONE
	db LEAF_STONE
	db EXP_SHARE
	db LOVELY_MAIL
	db SURF_MAIL
	db -1
; 161da

SaffronMart: ; 161f3
	db 9 ; # items
	db GREAT_BALL
	db ULTRA_BALL
	db LUXURY_BALL
	db HYPER_POTION
	db MAX_POTION
	db FULL_HEAL
	db X_ATTACK
	db X_DEFEND
	db FLOWER_MAIL
	db -1
; 161fd

SilphCoMart:
	db 5 ; # items
	db MAX_POTION
	db MAX_REPEL
	db DUSK_BALL
	db UP_GRADE
	db DUBIOUS_DISC
	db -1

FuchsiaMart: ; 161ea
	db 8 ; # items
	db GREAT_BALL
	db ULTRA_BALL
	db NEST_BALL
	db SUPER_POTION
	db HYPER_POTION
	db FULL_HEAL
	db MAX_REPEL
	db FLOWER_MAIL
	db -1
; 161f3

ShamoutiMart1:
	db 4 ; # items
	db MENTAL_HERB
	db POWER_HERB
	db WHITE_HERB
	db BIG_ROOT
	db -1

ShamoutiMart2:
	db 6 ; # items
	db DAMP_ROCK
	db HEAT_ROCK
	db SMOOTH_ROCK
	db ICY_ROCK
	db LIGHT_CLAY
	db EVIOLITE
	db -1

BattleTowerMart1:
	db 9 ; # items
	db CHOICE_BAND,  1
	db CHOICE_SCARF, 1
	db CHOICE_SPECS, 1
	db EXPERT_BELT,  1
	db MUSCLE_BAND,  1
	db WISE_GLASSES, 1
	db METRONOME_I,  1
	db BINDING_BAND, 1
	db GRIP_CLAW,    1
	db -1

BattleTowerMart2:
	db 8 ; # items
	db RARE_CANDY,   1
	db PP_MAX,       1
	db ABILITY_CAP,  1
	db WEAK_POLICY,  1
	db LIFE_ORB,     1
	db FLAME_ORB,    1
	db TOXIC_ORB,    1
	db BLACK_SLUDGE, 1
	db -1

BattleTowerMart3:
	db 7 ; # items
	db MACHO_BRACE,  1
	db FOCUS_BAND,   1
	db FOCUS_SASH,   1
	db ASSAULT_VEST, 1
	db PROTECT_PADS, 1
	db ROCKY_HELMET, 1
	db SAFE_GOGGLES, 1
	db -1
