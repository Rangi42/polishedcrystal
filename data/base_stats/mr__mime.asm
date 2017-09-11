if DEF(FAITHFUL)
	db  40,  45,  65,  90, 100, 120
	;   hp  atk  def  spd  sat  sdf
else
	db  50,  45,  65, 100, 100, 125
	;   hp  atk  def  spd  sat  sdf
endc

	db PSYCHIC, FAIRY
	db 45 ; catch rate
	db 136 ; base exp
	db NO_ITEM ; item 1
	db LEPPA_BERRY ; item 2
	dn FEMALE_50, 4 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db SOUNDPROOF ; ability 1
	db FILTER ; ability 2
	db TECHNICIAN ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   2
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, FOCUS_BLAST, ENERGY_BALL, ENDURE, DRAIN_PUNCH, GIGA_IMPACT, FLASH, THUNDER_WAVE, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, ICY_WIND, SEISMIC_TOSS, SKILL_SWAP, SLEEP_TALK, SWAGGER, THUNDERPUNCH, TRICK, ZAP_CANNON, ZEN_HEADBUTT
	; end
