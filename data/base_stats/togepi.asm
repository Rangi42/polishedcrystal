	db TOGEPI ; 175

	db  35,  20,  65,  20,  40,  65
	;   hp  atk  def  spd  sat  sdf

	db FAIRY, FAIRY
	db 190 ; catch rate
	db 74 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_12_5 ; gender
	db 10 ; step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db HUSTLE ; ability 1
	db SERENE_GRACE ; ability 2
	db SUPER_LUCK ; hidden ability
	db FAST ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, FLAMETHROWER, FIRE_BLAST, SWIFT, FACADE, REST, ATTRACT, ROCK_SMASH, ENDURE, DAZZLINGLEAM, THUNDER_WAVE, FLASH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, HYPER_VOICE, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SUBSTITUTE, SWAGGER, WATER_PULSE, ZAP_CANNON, ZEN_HEADBUTT
	; end
