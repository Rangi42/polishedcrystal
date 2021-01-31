MovePriorities:
	; no move is for explicit switch-out
	db NO_MOVE,       10
	db ENDURE,        4
	db PROTECT,       4
	db EXTREMESPEED,  2
	db AQUA_JET,      1
	db BULLET_PUNCH,  1
	db ICE_SHARD,     1
	db MACH_PUNCH,    1
	db QUICK_ATTACK,  1
	db SUCKER_PUNCH,  1
	; everything else 0
	db AVALANCHE,    -4
	db COUNTER,      -5
	db MIRROR_COAT,  -5
	db ROAR,         -6
	db TELEPORT,     -6
	db TRICK_ROOM,   -7
	db -1
