	db  45,  30,  15,  65,  85,  65 ; 305 BST
	;   hp  atk  def  spd  sat  sdf

	db ICE, PSYCHIC ; type
	db 45 ; catch rate
	db 87 ; base exp
	db ASPEAR_BERRY ; item 1
	db ASPEAR_BERRY ; item 2
	dn GENDER_F100, 4 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/smoochum/front.dimensions"
if DEF(FAITHFUL)
	abilities_for SMOOCHUM, OBLIVIOUS, FOREWARN, HYDRATION
else
	abilities_for SMOOCHUM, OBLIVIOUS, FILTER, HYDRATION
endc
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_HUMANSHAPE, EGG_HUMANSHAPE ; egg groups

	ev_yield   0,   0,   0,   0,   1,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, WATER_PULSE, AVALANCHE, FLASH, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, ENDURE, ICE_PUNCH, ICY_WIND, SEISMIC_TOSS, SKILL_SWAP, SLEEP_TALK, SWAGGER, TRICK, ZEN_HEADBUTT
	; end
