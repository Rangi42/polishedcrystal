if DEF(FAITHFUL)
	db  40,  45,  65,  90, 100, 120 ; 460 BST
	;   hp  atk  def  spe  sat  sdf
else
	db  50,  45,  65, 100, 100, 125 ; 485 BST
	;   hp  atk  def  spe  sat  sdf
endc

	db PSYCHIC, FAIRY ; type
	db 45 ; catch rate
	db 136 ; base exp
	db PERSIM_BERRY, PERSIM_BERRY ; held items
	dn GENDER_F50, HATCH_MEDIUM_SLOW ; gender ratio, step cycles to hatch

	abilities_for MR__MIME, SOUNDPROOF, FILTER, TECHNICIAN
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_HUMANSHAPE, EGG_HUMANSHAPE ; egg groups

	ev_yield 2 SDf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, REFLECT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, FOCUS_BLAST, ENERGY_BALL, DRAIN_PUNCH, GIGA_IMPACT, FLASH, THUNDER_WAVE, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, ENDURE, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, ICY_WIND, SEISMIC_TOSS, SKILL_SWAP, SLEEP_TALK, SWAGGER, THUNDERPUNCH, TRICK, ZAP_CANNON, ZEN_HEADBUTT, CUT, FLY, SURF, WHIRLPOOL, FLASH
	; end
