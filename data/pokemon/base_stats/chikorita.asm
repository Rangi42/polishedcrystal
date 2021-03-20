	db  45,  49,  65,  45,  49,  65 ; 318 BST
	;   hp  atk  def  spd  sat  sdf

	db GRASS, GRASS ; type
	db 45 ; catch rate
	db 64 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F12_5, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/chikorita/front.dimensions"
if DEF(FAITHFUL)
	abilities_for CHIKORITA, OVERGROW, OVERGROW, LEAF_GUARD
else
	abilities_for CHIKORITA, OVERGROW, NATURAL_CURE, LEAF_GUARD
endc
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_PLANT ; egg groups

	ev_yield   0,   0,   0,   0,   0,   1
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, IRON_TAIL, RETURN, DOUBLE_TEAM, REFLECT, SUBSTITUTE, FACADE, REST, ATTRACT, ENERGY_BALL, FLASH, SWORDS_DANCE, CUT, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, HEADBUTT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
