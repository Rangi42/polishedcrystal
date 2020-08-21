	db  60,  62,  63,  60,  80,  80 ; 405 BST
	;   hp  atk  def  spd  sat  sdf

	db GRASS, POISON
	db 45 ; catch rate
	db 141 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/ivysaur/front.dimensions"
	abilities_for IVYSAUR, OVERGROW, CHLOROPHYLL, EFFECT_SPORE
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, PLANT ; egg groups

	ev_yield   0,   0,   0,   0,   1,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, ROCK_SMASH, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, ENERGY_BALL, FLASH, SWORDS_DANCE, CUT, STRENGTH, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, KNOCK_OFF, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
