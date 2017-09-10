	db  46,  57,  40,  50,  40,  40
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON
	db 235 ; catch rate
	db 60 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn ALL_MALE, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db POISON_POINT ; ability 1
	db RIVALRY ; ability 2
	db HUSTLE ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   1,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SMASH, ENDURE, WATER_PULSE, SHADOW_CLAW, POISON_JAB, CUT, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
