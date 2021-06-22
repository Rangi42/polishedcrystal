BattleTower_DVSpreads:
; entries correspond to BTDVS_* constants
	table_width 3, BattleTower_DVSpreads
	; hp:atk, def:spd, sat:sdf
	db $ff, $ff, $ff ; BTDVS_PERFECT
	db $ff, $f0, $ff ; BTDVS_TRICK_ROOM
if DEF(FAITHFUL)
	db $ff, $ee, $ee ; BTDVS_HP_FIGHTING
	db $ee, $ef, $ee ; BTDVS_HP_FLYING
	db $ff, $ef, $ee ; BTDVS_HP_POISON
	db $ff, $ff, $ee ; BTDVS_HP_GROUND
	db $ff, $ee, $fe ; BTDVS_HP_ROCK
	db $fe, $ef, $fe ; BTDVS_HP_BUG
	db $fe, $ff, $fe ; BTDVS_HP_GHOST
	db $ff, $ff, $fe ; BTDVS_HP_STEEL
	db $fe, $fe, $ef ; BTDVS_HP_FIRE
	db $fe, $ef, $ef ; BTDVS_HP_WATER
	db $fe, $ff, $ef ; BTDVS_HP_GRASS
	db $ff, $ff, $ef ; BTDVS_HP_ELECTRIC
	db $fe, $fe, $ff ; BTDVS_HP_PSYCHIC
	db $fe, $ef, $ff ; BTDVS_HP_ICE
	db $fe, $ff, $ff ; BTDVS_HP_DRAGON
	db $ff, $ff, $ff ; BTDVS_HP_DARK
else
	db $ff, $ee, $ee ; BTDVS_HP_FIGHTING
	db $ff, $fe, $ee ; BTDVS_HP_FLYING
	db $ff, $ef, $ee ; BTDVS_HP_POISON
	db $ff, $ff, $ee ; BTDVS_HP_GROUND
	db $ff, $ee, $fe ; BTDVS_HP_ROCK
	db $ff, $fe, $fe ; BTDVS_HP_BUG
	db $ff, $ef, $fe ; BTDVS_HP_GHOST
	db $ff, $ff, $fe ; BTDVS_HP_STEEL
	db $ff, $ee, $ef ; BTDVS_HP_FIRE
	db $ff, $fe, $ef ; BTDVS_HP_WATER
	db $ff, $ef, $ef ; BTDVS_HP_GRASS
	db $ff, $ff, $ef ; BTDVS_HP_ELECTRIC
	db $ff, $ee, $ff ; BTDVS_HP_PSYCHIC
	db $ff, $fe, $ff ; BTDVS_HP_ICE
	db $ff, $ef, $ff ; BTDVS_HP_DRAGON
	db $fe, $ff, $ff ; BTDVS_HP_DARK
endc
	assert_table_length NUM_BTDVS
