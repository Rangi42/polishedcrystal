if DEF(FAITHFUL)
	db  83,  80,  75, 101,  70,  70 ; 479 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  93,  81,  75, 101,  90,  70 ; 510 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, FLYING
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 172 ; base exp
else
	db 194 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/pidgeot/front.dimensions"
	abilities_for PIDGEOT, KEEN_EYE, TANGLED_FEET, NO_GUARD
	db MEDIUM_SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	ev_yield   0,   0,   0,   3,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, FOCUS_BLAST, GIGA_IMPACT, U_TURN, FLY, DOUBLE_EDGE, ENDURE, SLEEP_TALK, SWAGGER
	; end
