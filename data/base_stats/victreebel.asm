if DEF(FAITHFUL)
	db  80, 105,  65,  70, 100,  70
	;   hp  atk  def  spd  sat  sdf
else
	db  80, 115,  65,  70, 110,  70
	;   hp  atk  def  spd  sat  sdf
endc

	db GRASS, POISON
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 191 ; base exp
else
	db 199 ; base exp
endc
	db GOLD_LEAF ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db CHLOROPHYLL ; ability 1
	db CHLOROPHYLL ; ability 2
	db GLUTTONY ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   3,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ENERGY_BALL, ENDURE, POISON_JAB, GIGA_IMPACT, FLASH, SWORDS_DANCE, CUT, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, KNOCK_OFF, SEED_BOMB, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
