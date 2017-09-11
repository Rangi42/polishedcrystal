if DEF(FAITHFUL)
	db  75,  75,  55,  30, 105,  85
	;   hp  atk  def  spd  sat  sdf
else
	db  75,  55,  75,  85, 105,  85
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db GRASS, GRASS
else
	db GRASS, FIRE
endc
if DEF(FAITHFUL)
	db 120 ; catch rate
else
	db 110 ; catch rate
endc
if DEF(FAITHFUL)
	db 146 ; base exp
else
	db 156 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db CHLOROPHYLL ; ability 1
	db SOLAR_POWER ; ability 2
	db EARLY_BIRD ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   2,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DOUBLE_TEAM, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, ENERGY_BALL, ENDURE, GIGA_IMPACT, FLASH, SWORDS_DANCE, CUT, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ROLLOUT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
