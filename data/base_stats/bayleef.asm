	db  60,  62,  80,  60,  63,  80
	;   hp  atk  def  spd  sat  sdf

	db GRASS, GRASS
	db 45 ; catch rate
	db 141 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db OVERGROW ; ability 1
if DEF(FAITHFUL)
	db OVERGROW ; ability 2
else
	db NATURAL_CURE ; ability 2
endc
	db LEAF_GUARD ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   0,   1,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, IRON_TAIL, RETURN, DOUBLE_TEAM, REFLECT, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SMASH, ENERGY_BALL, ENDURE, FLASH, SWORDS_DANCE, CUT, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, HEADBUTT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
