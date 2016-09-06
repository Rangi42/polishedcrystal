	db BELLSPROUT ; 069

	db  50,  75,  35,  40,  70,  30
	;   hp  atk  def  spd  sat  sdf

	db GRASS, POISON
	db 255 ; catch rate
	db 84 ; base exp
	db GOLD_LEAF ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, REST, ATTRACT, THIEF, SUBSTITUTE, ENERGY_BALL, ENDURE, CUT, FLASH, DOUBLE_EDGE, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
