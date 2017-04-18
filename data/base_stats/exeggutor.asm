	db EXEGGUTOR ; 103

	db  95,  95,  85,  55, 125,  75
	;   hp  atk  def  spd  sat  sdf

	db GRASS, PSYCHIC
	db 45 ; catch rate
	db 212 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db CHLOROPHYLL ; ability 1
	db CHLOROPHYLL ; ability 2
	db HARVEST ; hidden ability
	db SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   2,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, FACADE, REST, ATTRACT, THIEF, ENERGY_BALL, ENDURE, EXPLOSION, GIGA_IMPACT, FLASH, STRENGTH, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, ROLLOUT, SEED_BOMB, SLEEP_TALK, SUBSTITUTE, SWAGGER, ZEN_HEADBUTT
	; end
