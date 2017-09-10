	db  60,  40,  80,  40,  60,  45
	;   hp  atk  def  spd  sat  sdf

	db GRASS, PSYCHIC
	db 90 ; catch rate
	db 98 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db CHLOROPHYLL ; ability 1
	db CHLOROPHYLL ; ability 2
	db HARVEST ; hidden ability
	db SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   0,   1,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ENERGY_BALL, ENDURE, EXPLOSION, FLASH, SWORDS_DANCE, STRENGTH, DOUBLE_EDGE, DREAM_EATER, ROLLOUT, SEED_BOMB, SKILL_SWAP, SLEEP_TALK, SWAGGER
	; end
