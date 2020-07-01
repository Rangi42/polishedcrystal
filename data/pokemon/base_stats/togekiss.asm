	db  85,  50,  95,  80, 120, 115
	;   hp  atk  def  spd  sat  sdf

	db FAIRY, FLYING
	db 30 ; catch rate
	db 220 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 1 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db HUSTLE ; ability 1
	db SERENE_GRACE ; ability 2
	db SUPER_LUCK ; hidden ability
	db FAST ; growth rate
	dn AVIAN, FAERY ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   2,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, REFLECT, FLAMETHROWER, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, STEEL_WING, DAZZLINGLEAM, ROOST, FOCUS_BLAST, DRAIN_PUNCH, WATER_PULSE, GIGA_IMPACT, FLASH, THUNDER_WAVE, FLY, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, HYPER_VOICE, ROLLOUT, SLEEP_TALK, SWAGGER, TRICK, ZEN_HEADBUTT
	; end
