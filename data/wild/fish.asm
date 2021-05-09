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
	dbpb 100 percent,     0,  0
.Shore_Super:
	dbpb  40 percent,     KRABBY,     40
	dbpb  70 percent,     0,  1
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
	dbpb 100 percent,     0,  2
.Ocean_Super:
	dbpb  40 percent,     CHINCHOU,   40
	dbpb  70 percent,     0,  3
	dbpb  90 percent + 1, TENTACRUEL, 40
	dbpb 100 percent,     LANTURN,    40

.Lake_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     GOLDEEN,    10
.Lake_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     GOLDEEN,    20
	dbpb  90 percent + 1, GOLDEEN,    20
	dbpb 100 percent,     0,  4
.Lake_Super:
	dbpb  40 percent,     GOLDEEN,    40
	dbpb  70 percent,     0,  5
	dbpb  90 percent + 1, MAGIKARP,   40
	dbpb 100 percent,     SEAKING,    40

.Pond_Old:
	dbpb  70 percent + 1, MAGIKARP,   10
	dbpb  85 percent + 1, MAGIKARP,   10
	dbpb 100 percent,     POLIWAG,    10
.Pond_Good:
	dbpb  35 percent,     MAGIKARP,   20
	dbpb  70 percent,     POLIWAG,    20
	dbpb  90 percent + 1, POLIWAG,    20
	dbpb 100 percent,     0,  6
.Pond_Super:
	dbpb  40 percent,     POLIWAG,    40
	dbpb  70 percent,     0,  7
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
	dbpb 100 percent,     0,  8
.Dratini_Super:
	dbpb  40 percent,     MAGIKARP,   40
	dbpb  70 percent,     0,  9
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
	dbpb 100 percent,     0,  10
.Qwilfish_Swarm_Super:
	dbpb  40 percent,     QWILFISH,   40
	dbpb  70 percent,     0,  11
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
	dbpb 100 percent,     0,  12
.Remoraid_Swarm_Super:
	dbpb  40 percent,     REMORAID,   40
	dbpb  70 percent,     0,  13
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
	dbpb 100 percent,     0,  14
.Gyarados_Super:
	dbpb  40 percent,     MAGIKARP,   40
	dbpb  70 percent,     0,  15
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
	dbpb 100 percent,     0,  16
.Dratini_2_Super:
	dbpb  40 percent,     MAGIKARP,   10
	dbpb  70 percent,     0,  17
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
	dbpb 100 percent,     0,  18
.WhirlIslands_Super:
	dbpb  40 percent,     KRABBY,     40
	dbpb  70 percent,     0,  19
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
	dbpb 100 percent,     0,  20
.Qwilfish_NoSwarm_Super:
.Qwilfish_Super:
	dbpb  40 percent,     TENTACOOL,  40
	dbpb  70 percent,     0,  21
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
	dbpb 100 percent,     0,  6
.Remoraid_Super:
	dbpb  40 percent,     POLIWAG,    40
	dbpb  70 percent,     0,  7
	dbpb  90 percent + 1, MAGIKARP,   40
	dbpb 100 percent,     REMORAID,   40

TimeFishGroups:
	dpb CORSOLA,    20 ; day
	dpb STARYU,     20 ; night

	dpb CORSOLA,    40 ; day
	dpb STARYU,     40 ; night

	dpb SHELLDER,   20 ; day
	dpb SHELLDER,   20 ; night

	dpb SHELLDER,   40 ; day
	dpb SHELLDER,   40 ; night

	dpb GOLDEEN,    20 ; day
	dpb GOLDEEN,    20 ; night

	dpb GOLDEEN,    40 ; day
	dpb GOLDEEN,    40 ; night

	dpb POLIWAG,    20 ; day
	dpb POLIWAG,    20 ; night

	dpb POLIWAG,    40 ; day
	dpb POLIWAG,    40 ; night

	dpb DRATINI,    20 ; day
	dpb DRATINI,    20 ; night

	dpb DRATINI,    40 ; day
	dpb DRATINI,    40 ; night

	dpb QWILFISH,   20 ; day
	dpb QWILFISH,   20 ; night

	dpb QWILFISH,   40 ; day
	dpb QWILFISH,   40 ; night

	dpb REMORAID,   20 ; day
	dpb REMORAID,   20 ; night

	dpb REMORAID,   40 ; day
	dpb REMORAID,   40 ; night

	dpb GYARADOS,   20 ; day
	dpb GYARADOS,   20 ; night

	dpb GYARADOS,   40 ; dayman (ah-ah-ah!)
	dpb GYARADOS,   40 ; fighter of the nightman (ah-ah-ah!)

	dpb DRATINI,    10 ; day
	dpb DRATINI,    10 ; night

	dpb DRATINI,    10 ; day
	dpb DRATINI,    10 ; night

	dpb HORSEA,     20 ; day
	dpb HORSEA,     20 ; night

	dpb HORSEA,     40 ; day
	dpb HORSEA,     40 ; night

	dpb TENTACOOL,  20 ; day
	dpb TENTACOOL,  20 ; night

	dpb TENTACOOL,  40 ; day
	dpb TENTACOOL,  40 ; night

FishItems:
	db PEARL
	db BIG_PEARL
	db BOTTLE_CAP
