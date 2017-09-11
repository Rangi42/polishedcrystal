	db  40,  40,  40,  20,  70,  40
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 190 ; catch rate
	db 78 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db MAGMA_ARMOR ; ability 1
	db FLAME_BODY ; ability 2
	db WEAK_ARMOR ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RETURN, DOUBLE_TEAM, REFLECT, FLAMETHROWER, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, ROCK_SMASH, ENDURE, WILL_O_WISP, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
