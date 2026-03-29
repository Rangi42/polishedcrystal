if DEF(FAITHFUL)
	bst 479,  83,  80,  75,  70,  70, 101
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 499,  83,  60,  70, 115,  70, 101
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db NORMAL, FLYING ; type
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 172 ; base exp
else
	db 194 ; base exp
endc
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for PIDGEOT, KEEN_EYE, TANGLED_FEET, NO_GUARD
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	ev_yield 3 Spe

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, FOCUS_BLAST, GIGA_IMPACT, U_TURN, FLY, AGILITY, DOUBLE_EDGE, ENDURE, SLEEP_TALK, SWAGGER
	; end
