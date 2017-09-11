	db  45,  50,  55,  30,  75,  65
	;   hp  atk  def  spd  sat  sdf

	db GRASS, POISON
	db 255 ; catch rate
	db 78 ; base exp
	db SILVER_LEAF ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db CHLOROPHYLL ; ability 1
	db CHLOROPHYLL ; ability 2
	db RUN_AWAY ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, ENERGY_BALL, ENDURE, FLASH, SWORDS_DANCE, CUT, DOUBLE_EDGE, HYPER_VOICE, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
