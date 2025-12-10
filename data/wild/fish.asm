MACRO fishgroup
; mon chance, mon+item chance, old rod, good rod, super rod
	db \1, \2
	dw \3, \4, \5
ENDM

FishGroups:
; entries correspond to FISHGROUP_* constants
	table_width FISHGROUP_DATA_LENGTH
	fishgroup 65 percent, (65 + 5) percent, .Shore_Old,            .Shore_Good,            .Shore_Super
	fishgroup 75 percent, (75 + 1) percent, .Ocean_Old,            .Ocean_Good,            .Ocean_Super
	fishgroup 70 percent, (70 + 5) percent, .Lake_Old,             .Lake_Good,             .Lake_Super
	fishgroup 70 percent, (70 + 5) percent, .Well_Old,             .Well_Good,             .Well_Super
	fishgroup 70 percent, (70 + 3) percent, .River_Old,            .River_Good,            .River_Super
	fishgroup 55 percent, (55 + 5) percent, .Pond_Old,             .Pond_Good,             .Pond_Super
	fishgroup 60 percent, (60 + 3) percent, .Dratini_Old,          .Dratini_Good,          .Dratini_Super
	fishgroup 60 percent, (65 + 5) percent, .Qwilfish_Swarm_Old,   .Qwilfish_Swarm_Good,   .Qwilfish_Swarm_Super
	fishgroup 60 percent, (60 + 3) percent, .Remoraid_Swarm_Old,   .Remoraid_Swarm_Good,   .Remoraid_Swarm_Super
	fishgroup 60 percent, (60 + 3) percent, .Gyarados_Old,         .Gyarados_Good,         .Gyarados_Super
	fishgroup 55 percent, (55 + 1) percent, .Dratini_2_Old,        .Dratini_2_Good,        .Dratini_2_Super
	fishgroup 60 percent, (60 + 3) percent, .WhirlIslands_Old,     .WhirlIslands_Good,     .WhirlIslands_Super
	fishgroup 60 percent, (60 + 3) percent, .Qwilfish_Old,         .Qwilfish_Good,         .Qwilfish_Super
	fishgroup 60 percent, (60 + 3) percent, .Remoraid_Old,         .Remoraid_Good,         .Remoraid_Super
	fishgroup 65 percent, (65 + 5) percent, .Hisuian_Qwilfish_Old, .Hisuian_Qwilfish_Good, .Hisuian_Qwilfish_Super
	fishgroup 65 percent, (65 + 5) percent, .Staryu_Old,           .Staryu_Good,           .Staryu_Super
	assert_table_length NUM_FISHGROUPS

MACRO fishentry
; % chance, species, level
	db \1
	if _NARG == 4
		dp \2, \3
		shift
	else
		dp \2
	endc
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
	fishentry 100 percent,     CORSOLA,    20
.Shore_Super:
	fishentry  40 percent,     KRABBY,     40
	fishentry  70 percent,     CORSOLA,    40
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
	fishentry 100 percent,     SHELLDER,   20
.Ocean_Super:
	fishentry  40 percent,     CHINCHOU,   40
	fishentry  70 percent,     SHELLDER,   40
	fishentry  90 percent + 1, TENTACRUEL, 40
	fishentry 100 percent,     LANTURN,    40

.Lake_Old:
.River_Old:
.Well_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     GOLDEEN,    10
.Lake_Good:
.River_Good:
.Well_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     GOLDEEN,    20
	fishentry  90 percent + 1, GOLDEEN,    20
	fishentry 100 percent,     GOLDEEN,    20
.Lake_Super:
.River_Super:
	fishentry  40 percent,     GOLDEEN,    40
	fishentry  70 percent,     GOLDEEN,    40
	fishentry  90 percent + 1, MAGIKARP,   40
	fishentry 100 percent,     SEAKING,    40

.Well_Super:
	fishentry  40 percent,     GOLDEEN,    40
	fishentry  70 percent,     GOLDEEN,    40
	fishentry  90 percent + 1, SHELLDER,   40
	fishentry 100 percent,     SEAKING,    40

.Pond_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     POLIWAG,    10
.Pond_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     POLIWAG,    20
	fishentry  90 percent + 1, POLIWAG,    20
	fishentry 100 percent,     POLIWAG,    20
.Pond_Super:
	fishentry  40 percent,     POLIWAG,    40
	fishentry  70 percent,     POLIWAG,    40
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
	fishentry 100 percent,     DRATINI,    20
.Dratini_Super:
	fishentry  40 percent,     MAGIKARP,   40
	fishentry  70 percent,     DRATINI,    40
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
	fishentry 100 percent,     QWILFISH,   20
.Qwilfish_Swarm_Super:
	fishentry  40 percent,     QWILFISH,   40
	fishentry  70 percent,     QWILFISH,   40
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
	fishentry 100 percent,     REMORAID,   20
.Remoraid_Swarm_Super:
	fishentry  40 percent,     REMORAID,   40
	fishentry  70 percent,     REMORAID,   40
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
	fishentry 100 percent,     GYARADOS,   20
.Gyarados_Super:
	fishentry  40 percent,     MAGIKARP,   40
	fishentry  70 percent,     GYARADOS,   40
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
	fishentry 100 percent,     DRATINI,    10
.Dratini_2_Super:
	fishentry  40 percent,     MAGIKARP,   10
	fishentry  70 percent,     DRATINI,    10
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
	fishentry 100 percent,     HORSEA,     20
.WhirlIslands_Super:
	fishentry  40 percent,     KRABBY,     40
	fishentry  70 percent,     HORSEA,     40
	fishentry  90 percent + 1, KINGLER,    40
	fishentry 100 percent,     SEADRA,     40

.Qwilfish_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     TENTACOOL,  10
.Qwilfish_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     TENTACOOL,  20
	fishentry  90 percent + 1, TENTACOOL,  20
	fishentry 100 percent,     TENTACOOL,  20
.Qwilfish_Super:
	fishentry  40 percent,     TENTACOOL,  40
	fishentry  70 percent,     TENTACOOL,  40
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
	fishentry 100 percent,     POLIWAG,    20
.Remoraid_Super:
	fishentry  40 percent,     POLIWAG,    40
	fishentry  70 percent,     POLIWAG,    40
	fishentry  90 percent + 1, MAGIKARP,   40
	fishentry 100 percent,     REMORAID,   40

.Hisuian_Qwilfish_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     TENTACOOL,  10
.Hisuian_Qwilfish_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     TENTACOOL,  20
	fishentry  90 percent + 1, HORSEA,     20
	fishentry 100 percent,     QWILFISH,   HISUIAN_FORM,   20
.Hisuian_Qwilfish_Super:
	fishentry  40 percent,     TENTACRUEL, 40
	fishentry  70 percent,     SEADRA,     40
	fishentry  90 percent + 1, QWILFISH,   HISUIAN_FORM,   40
	fishentry 100 percent,     OVERQWIL,   40

.Staryu_Old:
	fishentry  70 percent + 1, MAGIKARP,   10
	fishentry  85 percent + 1, MAGIKARP,   10
	fishentry 100 percent,     KRABBY,     10
.Staryu_Good:
	fishentry  35 percent,     MAGIKARP,   20
	fishentry  70 percent,     KRABBY,     20
	fishentry  90 percent + 1, KRABBY,     20
	fishentry 100 percent,     STARYU,     20
.Staryu_Super:
	fishentry  40 percent,     KRABBY,     40
	fishentry  70 percent,     STARYU,     40
	fishentry  90 percent + 1, KRABBY,     40
	fishentry 100 percent,     KINGLER,    40
