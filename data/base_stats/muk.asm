	db 105, 105,  75,  50,  65, 100
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db POISON, POISON
else
	db POISON, DARK
endc
	db 75 ; catch rate
	db 157 ; base exp
	db NO_ITEM ; item 1
	db NUGGET ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db STENCH ; ability 1
	db STICKY_HOLD ; ability 2
	db POISON_TOUCH ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; ev_yield
	ev_yield   1,   1,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, FOCUS_BLAST, DARK_PULSE, ENDURE, EXPLOSION, POISON_JAB, GIGA_IMPACT, STONE_EDGE, STRENGTH, BODY_SLAM, FIRE_PUNCH, ICE_PUNCH, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
