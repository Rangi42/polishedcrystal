if DEF(FAITHFUL)
	bst 442,  65,  90,  65,  61,  61, 100
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 485,  85,  95,  80,  61,  64, 100
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db NORMAL, FLYING ; type
	db 90 ; catch rate
if DEF(FAITHFUL)
	db 162 ; base exp
else
	db 169 ; base exp
endc
	db NO_ITEM, SHARP_BEAK ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for FEAROW, KEEN_EYE, KEEN_EYE, SNIPER
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	ev_yield 2 Spe

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, FALSE_SWIPE, GIGA_IMPACT, U_TURN, FLY, AGILITY, BATON_PASS, DOUBLE_EDGE, ENDURE, SLEEP_TALK, SWAGGER
	; end
