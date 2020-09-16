	db  65,  90,  50,  55,  85,  45 ; 390 BST
	;   hp  atk  def  spd  sat  sdf

	db GRASS, POISON
	db 120 ; catch rate
	db 151 ; base exp
	db GOLD_LEAF ; item 1
	db GOLD_LEAF ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/weepinbell/front.dimensions"
	abilities_for WEEPINBELL, CHLOROPHYLL, CHLOROPHYLL, GLUTTONY
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ENERGY_BALL, POISON_JAB, FLASH, SWORDS_DANCE, CUT, DOUBLE_EDGE, ENDURE, KNOCK_OFF, SEED_BOMB, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
