FishGroups:
; entries correspond to FISHGROUP_* constants
	table_width FISHGROUP_DATA_LENGTH, FishGroups
	dbbwww 65 percent + 1, 85 percent + 1, .Shore_Old,            .Shore_Good,            .Shore_Super
	dbbwww 75 percent + 1, 85 percent + 1, .Ocean_Old,            .Ocean_Good,            .Ocean_Super
	dbbwww 70 percent + 1, 85 percent + 1, .Lake_Old,             .Lake_Good,             .Lake_Super
	dbbwww 55 percent + 1, 65 percent + 1, .Pond_Old,             .Pond_Good,             .Pond_Super
	dbbwww 60 percent + 1, 70 percent + 1, .Dratini_Old,          .Dratini_Good,          .Dratini_Super
	dbbwww 60 percent + 1, 70 percent + 1, .Qwilfish_Swarm_Old,   .Qwilfish_Swarm_Good,   .Qwilfish_Swarm_Super
	dbbwww 60 percent + 1, 70 percent + 1, .Remoraid_Swarm_Old,   .Remoraid_Swarm_Good,   .Remoraid_Swarm_Super
	dbbwww 60 percent + 1, 70 percent + 1, .Gyarados_Old,         .Gyarados_Good,         .Gyarados_Super
	dbbwww 60 percent + 1, 70 percent + 1, .Dratini_2_Old,        .Dratini_2_Good,        .Dratini_2_Super
	dbbwww 60 percent + 1, 70 percent + 1, .WhirlIslands_Old,     .WhirlIslands_Good,     .WhirlIslands_Super
	dbbwww 60 percent + 1, 70 percent + 1, .Qwilfish_Old,         .Qwilfish_Good,         .Qwilfish_Super
	dbbwww 60 percent + 1, 70 percent + 1, .Remoraid_Old,         .Remoraid_Good,         .Remoraid_Super
	dbbwww 60 percent + 1, 70 percent + 1, .Qwilfish_NoSwarm_Old, .Qwilfish_NoSwarm_Good, .Qwilfish_NoSwarm_Super
	assert_table_length NUM_FISHGROUPS

.Shore_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     KRABBY,     10
.Shore_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     KRABBY,     20
	dbpb  90 percent + 1, KRABBY,     20
	dbpb 100 percent,     0, 0
.Shore_Super:
	dbpb  40 percent,     KRABBY,     40
	dbpb  70 percent,     0, 1
	dbpb  90 percent + 1, KRABBY,     40
	dbpb 100 percent,     KINGLER,    40

.Ocean_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     TENTACOOL,  10
.Ocean_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     TENTACOOL,  20
	dbpb  90 percent + 1, CHINCHOU,   20
	dbpb 100 percent,     0, 2
.Ocean_Super:
	dbpb  40 percent,     CHINCHOU,   40
	dbpb  70 percent,     0, 3
	dbpb  90 percent + 1, TENTACRUEL, 40
	dbpb 100 percent,     LANTURN,    40

.Lake_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     POLIWAG,    10
.Lake_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     POLIWAG,    20
	dbpb  90 percent + 1, POLIWAG,    20
	dbpb 100 percent,     0, 4
.Lake_Super:
	dbpb  40 percent,     POLIWAG,    40
	dbpb  70 percent,     0, 5
	dbpb  90 percent + 1, MAGIKARP,   40
	dbpb 100 percent,     POLIWAG,    40

.Pond_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     POLIWAG,    10
.Pond_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     POLIWAG,    20
	dbpb  90 percent + 1, POLIWAG,    20
	dbpb 100 percent,     0, 6
.Pond_Super:
	dbpb  40 percent,     POLIWAG,    40
	dbpb  70 percent,     0, 7
	dbpb  90 percent + 1, MAGIKARP,   40
	dbpb 100 percent,     POLIWAG,    40

.Dratini_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     MAGIKARP,   10
.Dratini_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     MAGIKARP,   20
	dbpb  90 percent + 1, MAGIKARP,   20
	dbpb 100 percent,     0, 8
.Dratini_Super:
	dbpb  40 percent,     MAGIKARP,   40
	dbpb  70 percent,     0, 9
	dbpb  90 percent + 1, MAGIKARP,   40
	dbpb 100 percent,     DRAGONAIR,  40

.Qwilfish_Swarm_Old:
	dbpb  70 percent + 1, MAGIKARP,   5
	dbpb  85 percent + 1, MAGIKARP,   5
	dbpb 100 percent,     QWILFISH,   5
.Qwilfish_Swarm_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     QWILFISH,   20
	dbpb  90 percent + 1, QWILFISH,   20
	dbpb 100 percent,     0, 10
.Qwilfish_Swarm_Super:
	dbpb  40 percent,     QWILFISH,   40
	dbpb  70 percent,     0, 11
	dbpb  90 percent + 1, QWILFISH,   40
	dbpb 100 percent,     QWILFISH,   40

.Remoraid_Swarm_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     REMORAID,   10
.Remoraid_Swarm_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     REMORAID,   20
	dbpb  90 percent + 1, REMORAID,   20
	dbpb 100 percent,     0, 12
.Remoraid_Swarm_Super:
	dbpb  40 percent,     REMORAID,   40
	dbpb  70 percent,     0, 13
	dbpb  90 percent + 1, REMORAID,   40
	dbpb 100 percent,     REMORAID,   40

.Gyarados_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     MAGIKARP,   10
.Gyarados_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     MAGIKARP,   20
	dbpb  90 percent + 1, MAGIKARP,   20
	dbpb 100 percent,     0, 14
.Gyarados_Super:
	dbpb  40 percent,     MAGIKARP,   40
	dbpb  70 percent,     0, 15
	dbpb  90 percent + 1, MAGIKARP,   40
	dbpb 100 percent,     MAGIKARP,   40

.Dratini_2_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     MAGIKARP,   10
.Dratini_2_Good:
	dbpb  35 percent,     MAGIKARP,   10
	dbpb  70 percent,     MAGIKARP,   10
	dbpb  90 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     0, 16
.Dratini_2_Super:
	dbpb  40 percent,     MAGIKARP,   10
	dbpb  70 percent,     0, 17
	dbpb  90 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     DRAGONAIR,  10

.WhirlIslands_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     KRABBY,     10
.WhirlIslands_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     KRABBY,     20
	dbpb  90 percent + 1, KRABBY,     20
	dbpb 100 percent,     0, 18
.WhirlIslands_Super:
	dbpb  40 percent,     KRABBY,     40
	dbpb  70 percent,     0, 19
	dbpb  90 percent + 1, KINGLER,    40
	dbpb 100 percent,     SEADRA,     40

.Qwilfish_NoSwarm_Old:
.Qwilfish_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     TENTACOOL,  10
.Qwilfish_NoSwarm_Good:
.Qwilfish_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     TENTACOOL,  20
	dbpb  90 percent + 1, TENTACOOL,  20
	dbpb 100 percent,     0, 20
.Qwilfish_NoSwarm_Super:
.Qwilfish_Super:
	dbpb  40 percent,     TENTACOOL,  40
	dbpb  70 percent,     0, 21
	dbpb  90 percent + 1, MAGIKARP,   40
	dbpb 100 percent,     QWILFISH,   40

.Remoraid_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     POLIWAG,    10
.Remoraid_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     POLIWAG,    20
	dbpb  90 percent + 1, POLIWAG,    20
	dbpb 100 percent,     0, 6
.Remoraid_Super:
	dbpb  40 percent,     POLIWAG,    40
	dbpb  70 percent,     0, 7
	dbpb  90 percent + 1, MAGIKARP,   40
	dbpb 100 percent,     REMORAID,   40

TimeFishGroups:
	;  day              nite
	db CORSOLA,    20,  STARYU,     20
	db CORSOLA,    40,  STARYU,     40
	db SHELLDER,   20,  SHELLDER,   20
	db SHELLDER,   40,  SHELLDER,   40
	db PSYDUCK,    20,  PSYDUCK,    20
	db PSYDUCK,    40,  PSYDUCK,    40
	db POLIWAG,    20,  POLIWAG,    20
	db POLIWAG,    40,  POLIWAG,    40
	db DRATINI,    20,  DRATINI,    20
	db DRATINI,    40,  DRATINI,    40
	db QWILFISH,   20,  QWILFISH,   20
	db QWILFISH,   40,  QWILFISH,   40
	db REMORAID,   20,  REMORAID,   20
	db REMORAID,   40,  REMORAID,   40
	db GYARADOS,   20,  GYARADOS,   20
	db GYARADOS,   40,  GYARADOS,   40
	db DRATINI,    10,  DRATINI,    10
	db DRATINI,    10,  DRATINI,    10
	db HORSEA,     20,  HORSEA,     20
	db HORSEA,     40,  HORSEA,     40
	db TENTACOOL,  20,  TENTACOOL,  20
	db TENTACOOL,  40,  TENTACOOL,  40

FishItems:
	db PEARL
	db BIG_PEARL
	db BOTTLE_CAP
