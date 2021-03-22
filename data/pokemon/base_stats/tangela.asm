	db  65,  55, 115,  60, 100,  40 ; 435 BST
	;   hp  atk  def  spd  sat  sdf

	db GRASS, GRASS ; type
	db 45 ; catch rate
	db 166 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/tangela/front.dimensions"
	abilities_for TANGELA, CHLOROPHYLL, LEAF_GUARD, REGENERATOR
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	ev_yield   0,   0,   1,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, EARTHQUAKE, RETURN, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, ENERGY_BALL, GIGA_IMPACT, FLASH, SWORDS_DANCE, CUT, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, KNOCK_OFF, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
