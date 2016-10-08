	db WEEPINBELL ; 070

	db  65,  90,  50,  55,  85,  45
	;   hp  atk  def  spd  sat  sdf

	db GRASS, POISON
	db 120 ; catch rate
	db 151 ; base exp
	db GOLD_LEAF ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db CLOROPHYLL ; ability 1
	db CLOROPHYLL ; ability 2
	db CLOROPHYLL ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, REST, ATTRACT, THIEF, SUBSTITUTE, ENERGY_BALL, ENDURE, CUT, FLASH, DOUBLE_EDGE, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
