if DEF(FAITHFUL)
	db  52,  90,  55,  60,  58,  62 ; 377 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  55, 110,  55, 105,  60,  65 ; 450 BST
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db NORMAL, FLYING ; type
else
	db FLYING, FIGHTING ; type
endc
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 94 ; base exp
else
	db 124 ; base exp
endc
	db NO_ITEM ; item 1
	db STICK ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/farfetch_d/front.dimensions"
	abilities_for FARFETCH_D, KEEN_EYE, INNER_FOCUS, DEFIANT
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FLYING, EGG_GROUND ; egg groups

	ev_yield   0,   1,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, IRON_TAIL, RETURN, ROCK_SMASH, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, FALSE_SWIPE, ACROBATICS, POISON_JAB, U_TURN, SWORDS_DANCE, CUT, FLY, SURF, STRENGTH, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
