	db  45,  30,  15,  65,  85,  65 ; 305 BST
	;   hp  atk  def  spe  sat  sdf

	db ICE, PSYCHIC ; type
	db 45 ; catch rate
	db 87 ; base exp
	db ALWAYS_ITEM_2, ASPEAR_BERRY ; held items
	dn GENDER_F100, HATCH_MEDIUM_SLOW ; gender ratio, step cycles to hatch

if DEF(FAITHFUL)
	abilities_for SMOOCHUM, OBLIVIOUS, FOREWARN, HYDRATION
else
	abilities_for SMOOCHUM, OBLIVIOUS, FILTER, HYDRATION
endc
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	ev_yield 1 SAt

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, WATER_PULSE, AVALANCHE, FLASH, BODY_SLAM, CHARM, COUNTER, DOUBLE_EDGE, DREAM_EATER, ENDURE, ICE_PUNCH, ICY_WIND, SEISMIC_TOSS, SKILL_SWAP, SLEEP_TALK, SWAGGER, TRICK, TRICK_ROOM, ZEN_HEADBUTT
	; end
