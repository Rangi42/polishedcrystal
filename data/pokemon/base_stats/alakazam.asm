	db  55,  50,  45, 120, 135,  95 ; 500 BST
	;   hp  atk  def  spe  sat  sdf

	db PSYCHIC, PSYCHIC ; type
	db 50 ; catch rate
	db 186 ; base exp
	db TWISTEDSPOON, LINKING_CORD ; held items
	dn GENDER_F25, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for ALAKAZAM, SYNCHRONIZE, MAGIC_GUARD, TRACE
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_HUMANSHAPE, EGG_HUMANSHAPE ; egg groups

	ev_yield 3 SAt

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, RETURN, DIG, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, FOCUS_BLAST, ENERGY_BALL, DRAIN_PUNCH, GIGA_IMPACT, FLASH, THUNDER_WAVE, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, ENDURE, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, KNOCK_OFF, SEISMIC_TOSS, SKILL_SWAP, SLEEP_TALK, SWAGGER, THUNDERPUNCH, TRICK, ZAP_CANNON, ZEN_HEADBUTT, CUT, FLY, SURF, WHIRLPOOL, FLASH
	; end
