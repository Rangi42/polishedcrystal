	db  25,  20,  15,  90, 105,  55
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC
	db 200 ; catch rate
	db 73 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_25, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db SYNCHRONIZE ; ability 1
	db INNER_FOCUS ; ability 2
	db MAGIC_GUARD ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, ENERGY_BALL, ENDURE, DRAIN_PUNCH, FLASH, THUNDER_WAVE, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, KNOCK_OFF, SEISMIC_TOSS, SKILL_SWAP, SLEEP_TALK, SWAGGER, THUNDERPUNCH, TRICK, ZAP_CANNON, ZEN_HEADBUTT
	; end
