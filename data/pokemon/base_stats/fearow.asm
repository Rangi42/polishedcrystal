if DEF(FAITHFUL)
	db  65,  90,  65, 100,  61,  61 ; 442 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  65,  95,  65, 105,  61,  61 ; 452 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, FLYING ; type
	db 90 ; catch rate
if DEF(FAITHFUL)
	db 162 ; base exp
else
	db 169 ; base exp
endc
	db NO_ITEM ; item 1
	db SHARP_BEAK ; item 2
	dn GENDER_F50, 2 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/fearow/front.dimensions"
	abilities_for FEAROW, KEEN_EYE, KEEN_EYE, SNIPER
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	ev_yield   0,   0,   0,   2,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, FALSE_SWIPE, GIGA_IMPACT, U_TURN, FLY, AGILITY, BATON_PASS, DOUBLE_EDGE, ENDURE, SLEEP_TALK, SWAGGER
	; end
