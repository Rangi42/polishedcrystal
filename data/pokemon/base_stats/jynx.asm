if DEF(FAITHFUL)
	db  65,  50,  35,  95, 115,  95 ; 455 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  70,  60,  40,  95, 120, 100 ; 485 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db ICE, PSYCHIC ; type
	db 45 ; catch rate
	db 137 ; base exp
	db RAWST_BERRY ; item 1
	db RAWST_BERRY ; item 2
	dn GENDER_F100, 4 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/jynx/front.dimensions"
if DEF(FAITHFUL)
	abilities_for JYNX, OBLIVIOUS, FOREWARN, DRY_SKIN
else
	abilities_for JYNX, OBLIVIOUS, FILTER, DRY_SKIN
endc
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_HUMANSHAPE, EGG_HUMANSHAPE ; egg groups

	ev_yield   0,   0,   0,   0,   2,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, FOCUS_BLAST, ENERGY_BALL, DRAIN_PUNCH, WATER_PULSE, AVALANCHE, GIGA_IMPACT, FLASH, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, HYPER_VOICE, ICE_PUNCH, ICY_WIND, SEISMIC_TOSS, SKILL_SWAP, SLEEP_TALK, SWAGGER, TRICK, ZEN_HEADBUTT
	; end
