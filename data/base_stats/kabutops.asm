	db  60, 115, 105,  80,  65,  70
	;   hp  atk  def  spd  sat  sdf

	db ROCK, WATER
	db 45 ; catch rate
	db 201 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 5 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db SWIFT_SWIM ; ability 1
	db BATTLE_ARMOR ; ability 2
	db WEAK_ARMOR ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, INVERTEBRATE ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, HONE_CLAWS, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, RETURN, DIG, DOUBLE_TEAM, SANDSTORM, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, LEECH_LIFE, SCALD, X_SCISSOR, ENDURE, WATER_PULSE, GIGA_IMPACT, STONE_EDGE, SWORDS_DANCE, CUT, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, ICY_WIND, IRON_HEAD, KNOCK_OFF, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER
	; end
