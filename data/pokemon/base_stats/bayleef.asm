	db  60,  62,  80,  60,  63,  80 ; 405 BST
	;   hp  atk  def  spd  sat  sdf

	db GRASS, GRASS ; type
	db 45 ; catch rate
	db 141 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F12_5, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/bayleef/front.dimensions"
if DEF(FAITHFUL)
	abilities_for BAYLEEF, OVERGROW, OVERGROW, LEAF_GUARD
else
	abilities_for BAYLEEF, OVERGROW, NATURAL_CURE, LEAF_GUARD
endc
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_PLANT ; egg groups

	ev_yield   0,   0,   1,   0,   0,   1
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, IRON_TAIL, RETURN, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SUBSTITUTE, FACADE, REST, ATTRACT, ENERGY_BALL, FLASH, SWORDS_DANCE, CUT, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, HEADBUTT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
