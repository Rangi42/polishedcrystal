	db  60,  48,  45,  42,  43,  90
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC
	db 190 ; catch rate
	db 102 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db INSOMNIA ; ability 1
	db FOREWARN ; ability 2
	db INNER_FOCUS ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, ENDURE, DRAIN_PUNCH, FLASH, THUNDER_WAVE, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, SEISMIC_TOSS, SKILL_SWAP, SLEEP_TALK, SWAGGER, THUNDERPUNCH, TRICK, ZAP_CANNON, ZEN_HEADBUTT
	; end
