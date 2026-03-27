if DEF(FAITHFUL)
	bst 349,  63,  60,  55,  50,  50,  71
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 349,  63,  50,  50,  65,  50,  71
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db NORMAL, FLYING ; type
	db 120 ; catch rate
	db 113 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for PIDGEOTTO, KEEN_EYE, TANGLED_FEET, BIG_PECKS
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	ev_yield 2 Spe

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, FOCUS_BLAST, U_TURN, FLY, AGILITY, DOUBLE_EDGE, ENDURE, SLEEP_TALK, SWAGGER
	; end
