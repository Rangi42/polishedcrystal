	db PARASECT ; 047

if DEF(FAITHFUL)
	db  60,  95,  80,  30,  60,  80
	;   hp  atk  def  spd  sat  sdf
else
	db  60, 115, 100,  30,  60,  80
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, GRASS
	db 75 ; catch rate
	db 128 ; base exp
	db TINYMUSHROOM ; item 1
	db BIG_MUSHROOM ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db EFFECT_SPORE ; ability 1
	db DRY_SKIN ; ability 2
	db DAMP ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INSECT, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   2,   1,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DIG, DOUBLE_TEAM, SLUDGE_BOMB, AERIAL_ACE, FACADE, REST, ATTRACT, THIEF, FURY_CUTTER, ROCK_SMASH, LEECH_LIFE, ENERGY_BALL, FALSE_SWIPE, X_SCISSOR, ENDURE, GIGA_IMPACT, FLASH, CUT, BODY_SLAM, COUNTER, DOUBLE_EDGE, SEED_BOMB, SLEEP_TALK, SUBSTITUTE, SWAGGER
	; end
