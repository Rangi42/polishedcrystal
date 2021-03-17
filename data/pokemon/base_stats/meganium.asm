	db  80,  82, 100,  80,  83, 100 ; 525 BST
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db GRASS, GRASS
else
	db GRASS, FAIRY
endc
	db 45 ; catch rate
	db 208 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/meganium/front.dimensions"
if DEF(FAITHFUL)
	abilities_for MEGANIUM, OVERGROW, OVERGROW, LEAF_GUARD
else
	abilities_for MEGANIUM, OVERGROW, NATURAL_CURE, LEAF_GUARD
endc
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, PLANT ; egg groups

	ev_yield   0,   0,   1,   0,   0,   2
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, BULLDOZE, SOLAR_BEAM, IRON_TAIL, EARTHQUAKE, RETURN, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, ENERGY_BALL, GIGA_IMPACT, FLASH, SWORDS_DANCE, CUT, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
