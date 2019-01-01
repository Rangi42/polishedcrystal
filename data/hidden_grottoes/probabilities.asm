HiddenGrottoPokemonIndexes:
	db  40 ; total probability
	db  15, $0
	db  15, $1
	db   8, $2
	db   2, $3
	db -1 ; end

HiddenGrottoItems:
	db 160 ; total probability
	db  50, POKE_BALL
	db  20, GREAT_BALL
	db   8, ULTRA_BALL
	db  25, POTION
	db  10, SUPER_POTION
	db   4, HYPER_POTION
	db  25, REPEL
	db  10, SUPER_REPEL
	db   4, MAX_REPEL
	db   4, ITEM_FROM_MEM
	db -1 ; end

HiddenGrottoHiddenItems:
	db 160 ; total probability
	db  99, MULCH
	db  30, TINYMUSHROOM
	db  10, BIG_MUSHROOM
	db   1, BALMMUSHROOM
	db   8, SILVER_LEAF
	db   8, GOLD_LEAF
	db   1, RARE_CANDY
	db   2, PP_UP
	db   1, PP_MAX
	db -1 ; end
