	db KABUTOPS ; 141

	db  60, 115, 105,  80,  65,  70
	;   hp  atk  def  spd  sat  sdf

	db ROCK, WATER
	db 45 ; catch rate
	db 201 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_12_5 ; gender
	db 30 ; step cycles to hatch
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
	tmhm CURSE, TOXIC, HAIL, SWORDS_DANCE, HIDDEN_POWER, HONE_CLAWS, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, RETURN, DIG, DOUBLE_TEAM, SANDSTORM, AERIAL_ACE, STONE_EDGE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, FURY_CUTTER, ROCK_SMASH, LEECH_LIFE, SCALD, X_SCISSOR, ENDURE, GIGA_IMPACT, CUT, SURF, WATERFALL, WHIRLPOOL, AQUA_TAIL, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, ICY_WIND, IRON_HEAD, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SUBSTITUTE, SWAGGER, WATER_PULSE
	; end
