	db  55,  95,  55, 115,  35,  75 ; 430 BST
	;   hp  atk  def  spd  sat  sdf

	db POISON, FIGHTING ; type
	db 60 ; catch rate
	db 132 ; base exp
	db GRIP_CLAW ; item 1
	db QUICK_CLAW ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/sneasel_hisuian/front.dimensions"
	abilities_for SNEASEL_HISUIAN, INNER_FOCUS, KEEN_EYE, POISON_TOUCH
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, VENOSHOCK, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, FALSE_SWIPE, X_SCISSOR, DRAIN_PUNCH, SHADOW_CLAW, POISON_JAB, SWORDS_DANCE, CUT, SURF, STRENGTH, WHIRLPOOL, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
