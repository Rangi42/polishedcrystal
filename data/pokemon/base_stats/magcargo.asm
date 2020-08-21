if DEF(FAITHFUL)
	db  60,  50, 120,  30,  90,  80 ; 430 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  60,  50, 135,  30, 115, 115 ; 505 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db FIRE, ROCK
	db 75 ; catch rate
if DEF(FAITHFUL)
	db 154 ; base exp
else
	db 171 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/magcargo/front.dimensions"
	abilities_for MAGCARGO, MAGMA_ARMOR, FLAME_BODY, WEAK_ARMOR
	db MEDIUM_FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, BULLDOZE, SOLAR_BEAM, EARTHQUAKE, RETURN, ROCK_SMASH, DOUBLE_TEAM, REFLECT, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, ATTRACT, ROCK_SLIDE, WILL_O_WISP, EXPLOSION, GIGA_IMPACT, STONE_EDGE, GYRO_BALL, STRENGTH, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
