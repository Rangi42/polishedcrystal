	db  65,  55, 115,  60, 100,  40
	;   hp  atk  def  spd  sat  sdf

	db GRASS, GRASS
	db 45 ; catch rate
	db 166 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db CHLOROPHYLL ; ability 1
	db LEAF_GUARD ; ability 2
	db REGENERATOR ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn PLANT, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   0,   1,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, EARTHQUAKE, RETURN, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SMASH, LEECH_LIFE, ENERGY_BALL, ENDURE, GIGA_IMPACT, FLASH, SWORDS_DANCE, CUT, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, KNOCK_OFF, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
