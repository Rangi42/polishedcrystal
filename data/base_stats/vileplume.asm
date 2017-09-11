if DEF(FAITHFUL)
	db  75,  80,  85,  50, 110,  90
	;   hp  atk  def  spd  sat  sdf
else
	db  75,  80,  85,  50, 110, 100
	;   hp  atk  def  spd  sat  sdf
endc

	db GRASS, POISON
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 184 ; base exp
else
	db 192 ; base exp
endc
	db SILVER_LEAF ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db CHLOROPHYLL ; ability 1
	db CHLOROPHYLL ; ability 2
	db EFFECT_SPORE ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, ENERGY_BALL, ENDURE, DRAIN_PUNCH, GIGA_IMPACT, FLASH, SWORDS_DANCE, CUT, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, HYPER_VOICE, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
