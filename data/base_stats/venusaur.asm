	db VENUSAUR ; 003

	db  80,  82,  83,  80, 100, 100
	;   hp  atk  def  spd  sat  sdf

	db GRASS, POISON
	db 45 ; catch rate
	db 208 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_12_5 ; gender
	db 20 ; step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db OVERGROW ; ability 1
	db CHLOROPHYLL ; ability 2
	db THICK_FAT ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   2,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, EARTHQUAKE, RETURN, MUD_SLAP, DOUBLE_TEAM, SLUDGE_BOMB, FACADE, REST, ATTRACT, FURY_CUTTER, ROCK_SMASH, ENERGY_BALL, ENDURE, GIGA_IMPACT, FLASH, CUT, STRENGTH, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, SEED_BOMB, SLEEP_TALK, SUBSTITUTE, SWAGGER
	; end
