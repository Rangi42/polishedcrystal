	db  35,  70,  55,  25,  45,  55 ; 285 BST
	;   hp  atk  def  spd  sat  sdf

	db BUG, GRASS
	db 190 ; catch rate
	db 70 ; base exp
	db TINYMUSHROOM ; item 1
	db BIG_MUSHROOM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/paras/front.dimensions"
	abilities_for PARAS, EFFECT_SPORE, DRY_SKIN, DAMP
	db MEDIUM_FAST ; growth rate
	dn INSECT, PLANT ; egg groups

	ev_yield   0,   1,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SLUDGE_BOMB, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, ENERGY_BALL, FALSE_SWIPE, X_SCISSOR, FLASH, SWORDS_DANCE, CUT, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, KNOCK_OFF, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
