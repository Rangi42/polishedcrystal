	db  80, 130,  60, 120,  40,  80 ; 510 BST
	;   hp  atk  def  spd  sat  sdf

	db POISON, FIGHTING ; type
	db 45 ; catch rate
	db 199 ; base exp
	db GRIP_CLAW, QUICK_CLAW ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/sneasler/front.dimensions"
if DEF(FAITHFUL)
	abilities_for SNEASLER, PRESSURE, PRESSURE, POISON_TOUCH
else
	abilities_for SNEASLER, PRESSURE, TECHNICIAN, POISON_TOUCH
endc
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield   0,   1,   0,   1,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, BULK_UP, VENOSHOCK, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, FALSE_SWIPE, X_SCISSOR, DRAIN_PUNCH, SHADOW_CLAW, POISON_JAB, SWORDS_DANCE, CUT, SURF, STRENGTH, WHIRLPOOL, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, ICE_PUNCH, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
