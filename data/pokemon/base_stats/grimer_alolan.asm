	db  80,  80,  50,  25,  40,  50 ; 325 BST
	;   hp  atk  def  spd  sat  sdf

	db POISON, DARK
	db 190 ; catch rate
	db 90 ; base exp
	db BLACK_SLUDGE ; item 1
	db NUGGET ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db POISON_TOUCH ; ability 1
	db GLUTTONY ; ability 2
	db CORROSION ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; ev_yield
	ev_yield   1,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, VENOSHOCK, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, GIGA_DRAIN, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, EXPLOSION, POISON_JAB, STONE_EDGE, STRENGTH, BODY_SLAM, ENDURE, FIRE_PUNCH, ICE_PUNCH, KNOCK_OFF, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
