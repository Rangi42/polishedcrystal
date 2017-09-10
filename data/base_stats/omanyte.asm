	db  35,  40, 100,  35,  90,  55
	;   hp  atk  def  spd  sat  sdf

	db ROCK, WATER
	db 45 ; catch rate
	db 120 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 5 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db SWIFT_SWIM ; ability 1
	db SHELL_ARMOR ; ability 2
	db WEAK_ARMOR ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, INVERTEBRATE ; egg groups

	; ev_yield
	ev_yield   0,   0,   1,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, SCALD, ENDURE, WATER_PULSE, GYRO_BALL, SURF, WHIRLPOOL, WATERFALL, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, ICY_WIND, KNOCK_OFF, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
