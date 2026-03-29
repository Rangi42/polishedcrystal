; Typically, a move makes contact if a move's category is Physical
; This lists all exceptions
AbnormalContactMoves:
	; Special moves that make contact
	db DRAINING_KISS
	db PETAL_DANCE
	; Physical moves that don't make contact
	db BONEMERANG
	db BULLDOZE
	db EARTHQUAKE
	db EXPLOSION
	db GUNK_SHOT
	db ICE_SHARD
	db ICICLE_CRASH
	db ICICLE_SPEAR
	db MAGNITUDE
	db PAY_DAY
	db PIN_MISSILE
	db POISON_STING
	db RAZOR_LEAF
	db ROCK_BLAST
	db ROCK_SLIDE
	db ROCK_THROW
	db SACRED_FIRE
	db SEED_BOMB
	db STONE_EDGE
	db -1 ; Terminator only, Struggle makes contact. Checked for directly.
