fishgroup: MACRO
; mon chance, mon/item chance, old rod, good rod, super rod
	db \1, \2
	dw \3, \4, \5
ENDM

FishGroups:
; entries correspond to FISHGROUP_* constants
	table_width FISHGROUP_DATA_LENGTH, FishGroups
	fishgroup 65 percent + 1, 85 percent + 1, .Shore_Old,            .Shore_Good,            .Shore_Super
	fishgroup 75 percent + 1, 85 percent + 1, .Ocean_Old,            .Ocean_Good,            .Ocean_Super
	fishgroup 70 percent + 1, 85 percent + 1, .Lake_Old,             .Lake_Good,             .Lake_Super
	fishgroup 55 percent + 1, 65 percent + 1, .Pond_Old,             .Pond_Good,             .Pond_Super
	fishgroup 60 percent + 1, 70 percent + 1, .Dratini_Old,          .Dratini_Good,          .Dratini_Super
	fishgroup 60 percent + 1, 70 percent + 1, .Qwilfish_Swarm_Old,   .Qwilfish_Swarm_Good,   .Qwilfish_Swarm_Super
	fishgroup 60 percent + 1, 70 percent + 1, .Remoraid_Swarm_Old,   .Remoraid_Swarm_Good,   .Remoraid_Swarm_Super
	fishgroup 60 percent + 1, 70 percent + 1, .Gyarados_Old,         .Gyarados_Good,         .Gyarados_Super
	fishgroup 60 percent + 1, 70 percent + 1, .Dratini_2_Old,        .Dratini_2_Good,        .Dratini_2_Super
	fishgroup 60 percent + 1, 70 percent + 1, .WhirlIslands_Old,     .WhirlIslands_Good,     .WhirlIslands_Super
	fishgroup 60 percent + 1, 70 percent + 1, .Qwilfish_Old,         .Qwilfish_Good,         .Qwilfish_Super
	fishgroup 60 percent + 1, 70 percent + 1, .Remoraid_Old,         .Remoraid_Good,         .Remoraid_Super
	fishgroup 60 percent + 1, 70 percent + 1, .Qwilfish_NoSwarm_Old, .Qwilfish_NoSwarm_Good, .Qwilfish_NoSwarm_Super
	assert_table_length NUM_FISHGROUPS

fishentry: MACRO
; % chance, species, level
	db \1
	dp \2
	db \3
ENDM

.Shore_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     KRABBY,     10
.Shore_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     KRABBY,     20
	fishentry  90 percent + 1, KRABBY,     20
	fishentry 100 percent,     0,  0
.Shore_Super:
	fishentry  40 percent,     KRABBY,     40
	fishentry  70 percent,     0,  1
	fishentry  90 percent + 1, KRABBY,     40
	fishentry 100 percent,     KINGLER,    40

.Ocean_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     TENTACOOL,  10
.Ocean_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     TENTACOOL,  20
	fishentry  90 percent + 1, CHINCHOU,   20
	fishentry 100 percent,     0,  2
.Ocean_Super:
	fishentry  40 percent,     CHINCHOU,   40
	fishentry  70 percent,     0,  3
	fishentry  90 percent + 1, TENTACRUEL, 40
	fishentry 100 percent,     LANTURN,    40

.Lake_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     GOLDEEN,    10
.Lake_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     GOLDEEN,    20
	fishentry  90 percent + 1, GOLDEEN,    20
	fishentry 100 percent,     0,  4
.Lake_Super:
	fishentry  40 percent,     GOLDEEN,    40
	fishentry  70 percent,     0,  5
	fishentry  90 percent + 1, MAGIKARP,   40
	fishentry 100 percent,     SEAKING,    40

.Pond_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     POLIWAG,    10
.Pond_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     POLIWAG,    20
	fishentry  90 percent + 1, POLIWAG,    20
	fishentry 100 percent,     0,  6
.Pond_Super:
	fishentry  40 percent,     POLIWAG,    40
	fishentry  70 percent,     0,  7
	fishentry  90 percent + 1, MAGIKARP,   40
	fishentry 100 percent,     POLIWAG,    40

.Dratini_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     MAGIKARP,   10
.Dratini_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     MAGIKARP,   20
	fishentry  90 percent + 1, MAGIKARP,   20
	fishentry 100 percent,     0,  8
.Dratini_Super:
	fishentry  40 percent,     MAGIKARP,   40
	fishentry  70 percent,     0,  9
	fishentry  90 percent + 1, MAGIKARP,   40
	fishentry 100 percent,     DRAGONAIR,  40

.Qwilfish_Swarm_Old:
	fishentry  70 percent + 1, MAGIKARP,   5
	fishentry  85 percent + 1, MAGIKARP,   5
	fishentry 100 percent,     QWILFISH,   5
.Qwilfish_Swarm_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     QWILFISH,   20
	fishentry  90 percent + 1, QWILFISH,   20
	fishentry 100 percent,     0,  10
.Qwilfish_Swarm_Super:
	fishentry  40 percent,     QWILFISH,   40
	fishentry  70 percent,     0,  11
	fishentry  90 percent + 1, QWILFISH,   40
	fishentry 100 percent,     QWILFISH,   40

.Remoraid_Swarm_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     REMORAID,   10
.Remoraid_Swarm_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     REMORAID,   20
	fishentry  90 percent + 1, REMORAID,   20
	fishentry 100 percent,     0,  12
.Remoraid_Swarm_Super:
	fishentry  40 percent,     REMORAID,   40
	fishentry  70 percent,     0,  13
	fishentry  90 percent + 1, REMORAID,   40
	fishentry 100 percent,     REMORAID,   40

.Gyarados_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     MAGIKARP,   10
.Gyarados_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     MAGIKARP,   20
	fishentry  90 percent + 1, MAGIKARP,   20
	fishentry 100 percent,     0,  14
.Gyarados_Super:
	fishentry  40 percent,     MAGIKARP,   40
	fishentry  70 percent,     0,  15
	fishentry  90 percent + 1, MAGIKARP,   40
	fishentry 100 percent,     MAGIKARP,   40

.Dratini_2_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     MAGIKARP,   10
.Dratini_2_Good:
	fishentry  35 percent,     MAGIKARP,   10
	fishentry  70 percent,     MAGIKARP,   10
	fishentry  90 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     0,  16
.Dratini_2_Super:
	fishentry  40 percent,     MAGIKARP,   10
	fishentry  70 percent,     0,  17
	fishentry  90 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     DRAGONAIR,  10

.WhirlIslands_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     KRABBY,     10
.WhirlIslands_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     KRABBY,     20
	fishentry  90 percent + 1, KRABBY,     20
	fishentry 100 percent,     0,  18
.WhirlIslands_Super:
	fishentry  40 percent,     KRABBY,     40
	fishentry  70 percent,     0,  19
	fishentry  90 percent + 1, KINGLER,    40
	fishentry 100 percent,     SEADRA,     40

.Qwilfish_NoSwarm_Old:
.Qwilfish_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     TENTACOOL,  10
.Qwilfish_NoSwarm_Good:
.Qwilfish_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     TENTACOOL,  20
	fishentry  90 percent + 1, TENTACOOL,  20
	fishentry 100 percent,     0,  20
.Qwilfish_NoSwarm_Super:
.Qwilfish_Super:
	fishentry  40 percent,     TENTACOOL,  40
	fishentry  70 percent,     0,  21
	fishentry  90 percent + 1, MAGIKARP,   40
	fishentry 100 percent,     QWILFISH,   40

.Remoraid_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     POLIWAG,    10
.Remoraid_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     POLIWAG,    20
	fishentry  90 percent + 1, POLIWAG,    20
	fishentry 100 percent,     0,  6
.Remoraid_Super:
	fishentry  40 percent,     POLIWAG,    40
	fishentry  70 percent,     0,  7
	fishentry  90 percent + 1, MAGIKARP,   40
	fishentry 100 percent,     REMORAID,   40

timedfishgroup: MACRO
	dp \1
	db \2
	dp \3
	db \4
ENDM

TimeFishGroups:
	; day, night
	timedfishgroup CORSOLA,    20, STARYU,     20
	timedfishgroup CORSOLA,    40, STARYU,     40
	timedfishgroup SHELLDER,   20, SHELLDER,   20
	timedfishgroup SHELLDER,   40, SHELLDER,   40
	timedfishgroup GOLDEEN,    20, GOLDEEN,    20
	timedfishgroup GOLDEEN,    40, GOLDEEN,    40
	timedfishgroup POLIWAG,    20, POLIWAG,    20
	timedfishgroup POLIWAG,    40, POLIWAG,    40
	timedfishgroup DRATINI,    20, DRATINI,    20
	timedfishgroup DRATINI,    40, DRATINI,    40
	timedfishgroup QWILFISH,   20, QWILFISH,   20
	timedfishgroup QWILFISH,   40, QWILFISH,   40
	timedfishgroup REMORAID,   20, REMORAID,   20
	timedfishgroup REMORAID,   40, REMORAID,   40
	timedfishgroup GYARADOS,   20, GYARADOS,   20
	timedfishgroup GYARADOS,   40, GYARADOS,   40
	timedfishgroup DRATINI,    10, DRATINI,    10
	timedfishgroup DRATINI,    10, DRATINI,    10
	timedfishgroup HORSEA,     20, HORSEA,     20
	timedfishgroup HORSEA,     40, HORSEA,     40
	timedfishgroup TENTACOOL,  20, TENTACOOL,  20
	timedfishgroup TENTACOOL,  40, TENTACOOL,  40

FishItems:
	db PEARL
	db BIG_PEARL
	db BOTTLE_CAP
