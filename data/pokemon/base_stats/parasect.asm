if DEF(FAITHFUL)
	db  60,  95,  80,  30,  60,  80 ; 405 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  60, 115, 100,  30,  60,  80 ; 445 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, GRASS ; type
	db 75 ; catch rate
	db 128 ; base exp
	db TINYMUSHROOM ; item 1
	db BIG_MUSHROOM ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/parasect/front.dimensions"
	abilities_for PARASECT, EFFECT_SPORE, DRY_SKIN, DAMP
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_BUG, EGG_PLANT ; egg groups

	ev_yield   0,   2,   1,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SLUDGE_BOMB, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, ENERGY_BALL, FALSE_SWIPE, X_SCISSOR, SHADOW_CLAW, GIGA_IMPACT, FLASH, SWORDS_DANCE, CUT, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, ENDURE, KNOCK_OFF, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
