MovePriorities:
	; no move is for explicit switch-out
	dwb NO_MOVE,       10
	dwb ENDURE,        4
	dwb PROTECT,       4
	dwb EXTREMESPEED,  2
	dwb AQUA_JET,      1
	dwb BULLET_PUNCH,  1
	dwb ICE_SHARD,     1
	dwb MACH_PUNCH,    1
	dwb QUICK_ATTACK,  1
	dwb SUCKER_PUNCH,  1
	; everything else 0
	dwb AVALANCHE,    -4
	dwb COUNTER,      -5
	dwb MIRROR_COAT,  -5
	dwb ROAR,         -6
	dwb TELEPORT,     -6
	dwb TRICK_ROOM,   -7
	db -1
