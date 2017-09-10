if DEF(FAITHFUL)
	db 140,  70,  45,  45,  85,  50
	;   hp  atk  def  spd  sat  sdf
else
	db 148,  70,  55,  45,  85,  65
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, FAIRY
	db 50 ; catch rate
if DEF(FAITHFUL)
	db 109 ; base exp
else
	db 129 ; base exp
endc
	db ORAN_BERRY ; item 1
	db ORAN_BERRY ; item 2
	dn FEMALE_75, 1 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db CUTE_CHARM ; ability 1
	db COMPETITIVE ; ability 2
if DEF(FAITHFUL)
	db FRISK ; hidden ability
else
	db SOUNDPROOF ; hidden ability
endc
	db FAST ; growth rate
	dn FAERY, FAERY ; egg groups

	; ev_yield
	ev_yield   3,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, THUNDERBOLT, THUNDER, RETURN, DIG, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, FLAMETHROWER, FIRE_BLAST, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ATTRACT, DAZZLINGLEAM, FOCUS_BLAST, ENDURE, DRAIN_PUNCH, WATER_PULSE, GIGA_IMPACT, FLASH, THUNDER_WAVE, GYRO_BALL, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, FIRE_PUNCH, HEADBUTT, HYPER_VOICE, ICE_PUNCH, ICY_WIND, KNOCK_OFF, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
