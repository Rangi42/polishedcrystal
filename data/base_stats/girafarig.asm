if DEF(FAITHFUL)
	db  70,  80,  65,  85,  90,  65
	;   hp  atk  def  spd  sat  sdf
else
	db  70,  80,  65, 105, 110,  65
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, PSYCHIC
	db 60 ; catch rate
	db 149 ; base exp
	db NO_ITEM ; item 1
	db PERSIM_BERRY ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db INNER_FOCUS ; ability 1
	db EARLY_BIRD ; ability 2
	db SAP_SIPPER ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   2,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, ROCK_SMASH, ENERGY_BALL, ENDURE, FLASH, THUNDER_WAVE, STRENGTH, BODY_SLAM, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, HYPER_VOICE, SKILL_SWAP, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, TRICK, ZAP_CANNON, ZEN_HEADBUTT
	; end
